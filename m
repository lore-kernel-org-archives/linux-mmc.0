From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: [PATCH v3 0/2] block: Adding support for urgent requests handling
Date: Tue, 11 Dec 2012 15:36:53 +0200
Message-ID: <1355233015-25196-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: jaxboe@fusionio.com
Cc: linux-arm-msm@vger.kernel.org, philippedeswert@gmail.com, jengelh@inai.de, jh80.chung@samsung.com, tgih.jun@samsung.com, arnd.bergmann@linaro.org, venkat@linaro.org, linux-mmc@vger.kernel.org, Tanya Brokhman <tlinder@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This patch set adds support in block & elevator layers for handling
urgent requests.
In order to decrease the latency of a prioritized request (such as READ
requests) we might want to stop the transmission of a current "low
priority" request in order to handle the "high priority" one. The
urgency of the request is decided by the block layer I/O scheduler.
When the block layer notifies the underlying device driver (eMMC for
example) of an urgent request, the device driver might decide to stop
the current request transmission. The remainder of the stopped request
will be re-inserted back to the scheduler, to be re-scheduled after
handling the urgent request.

The above is implemented in the block layer by 2 callbacks of the queue:
- urgent_request_fn() - This callback is registered by the underlying
  device driver and is called instead of the existing requst_fn() callback
  to handle urgent requests.
- elevator_is_urgent_fn() - This callback is registered by the current
  I/O scheduler. If present it's used by the block layer to query the
  scheduler of an urgent request presence.
NOTE: If one of the above callbacks is not registered, this code pass
will never be activated.

Tatyana Brokhman (2):
  block: Add support for reinsert a dispatched req
  block: Add API for urgent request handling

 block/blk-core.c         |   70 ++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-settings.c     |   12 ++++++++
 block/blk.h              |   11 +++++++
 block/elevator.c         |   40 ++++++++++++++++++++++++++
 include/linux/blkdev.h   |    6 ++++
 include/linux/elevator.h |    7 ++++
 6 files changed, 144 insertions(+), 2 deletions(-)

-- 
1.7.6
--
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. 
Is a member of Code Aurora Forum, hosted by the Linux Foundation
