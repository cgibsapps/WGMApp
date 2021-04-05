//
//  RequestListView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/8/21.
//

import SwiftUI
import ElegantCalendar

struct RequestsListView: View {

    private let timer = Timer.publish(every: RequestPreviewConstants.previewTime,
                                      on: .main, in: .common).autoconnect()
    @State var requestIndex = 0
    
    let requests: [Request]
    let numberOfCellsInBlock: Int

    init(requests: [Request], height: CGFloat) {
        self.requests = requests
        numberOfCellsInBlock = Int(height / (RequestPreviewConstants.cellHeight + RequestPreviewConstants.cellPadding*2))
    }

    private var range: Range<Int> {
        let exclusiveEndIndex = requestIndex + numberOfCellsInBlock
        guard requests.count > numberOfCellsInBlock &&
            exclusiveEndIndex <= requests.count else {
            return requestIndex..<requests.count
        }
        return requestIndex..<exclusiveEndIndex
    }

    var body: some View {
        requestsPreviewList
            .animation(.easeInOut)
            .onAppear(perform: setUpRequestsSlideShow)
            .onReceive(timer) { _ in
                self.shiftActivePreviewRequestIndex()
            }
    }

    private func setUpRequestsSlideShow() {
        if requests.count <= numberOfCellsInBlock {
            // To reduce memory usage, we don't want the timer to fire when
            // requests count is less than or equal to the number
            // of requests allowed in a single slide
            timer.upstream.connect().cancel()
        }
    }

    private func shiftActivePreviewRequestIndex() {
        let startingRequestIndexOfNextSlide = requestIndex + numberOfCellsInBlock
        let startingRequestIndexOfNextSlideIsValid = startingRequestIndexOfNextSlide < requests.count
        requestIndex = startingRequestIndexOfNextSlideIsValid ? startingRequestIndexOfNextSlide : 0
    }

    private var requestsPreviewList: some View {
        VStack(spacing: 0) {
            ForEach(requests[range]) { request in
                RequestCell(request: request)
            }
        }
    }
    

}

struct RequestsListView_Previews: PreviewProvider {
    static var previews: some View {
        DarkThemePreview {
            RequestsListView(requests: Request.mocks(start: Date(), end: .daysFromToday(2)), height: 300)
        }
    }
}
