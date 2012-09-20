From: Maya Erez <merez@codeaurora.org>
Subject: [RFC/PATCH 0/2] Handling urgent and new request notifications
Date: Thu, 20 Sep 2012 09:02:30 +0300
Message-ID: <1348120954-6937-1-git-send-email-merez@codeaurora.org>
References: <n>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <n>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Konstantin Dorfman <kdorfman@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Konstantin Dorfman <kdorfman@codeaurora.org>

   In this patch we propose a way to handle urgent requests in the MMC driver.
The decision whether a request is urgent or not is done within the I/O scheduler
at the block layer. In this patch we propose a way for the MMC driver to handle
urgent requests that are triggered while the driver issues packed commands.
That is, we propose a solution to stop an ongoing packed commands transaction in
order to serve an urgent request as well as stopping the packing process due to
an urgent request. This solution may be extended in the future to stop single
request transaction for serving urgent one.

In order to support urgent requests, a callback is added to the queue
structure, q->urgent_request_fn. It is used by the block layer to notify the
device driver that an urgent request just arrived and it is pending to be
fetched. The decision when the urgent request will be fetched is taken by the
device driver. That is, the device driver can decide to stop immediately any
ongoing transaction and fetching the urgent request, but it can also decide to
ignore the urgent request notification and continue the current transaction,
so the urgent request will be fetched like any other normal request when all
prior transactions are finished.

In additional we added a new block layer API, blk_reinsert_request.
If a device driver decides to stop an ongoing transaction in order to fetch and
serve an urgent request, it should keep aside the interrupted request and any
other un-served fetched requests in order to serve them later on.
This situation is problematic in the manner of creating a new scheduling policy
inside the device driver itself. For example, assuming a normal request was
interrupted by an urgent request and saved aside by the device driver for future
execution. Now,every time the device driver tries to execute the normal request,
it keeps getting urgent requests and the normal request is starved.
This situation may happen since the I/O scheduler is not aware of the
interrupted normal request that was saved aside. In order to solve such
scenarios, the device driver may re-insert the interrupted request as well as
any other fetched request that wasn't served yet, back into the I/O scheduler
by calling blk_reinsert_request. Using such a scheme, returns the scheduling
decisions to a single managing center  - the I/O scheduler. The new added RAW
I/O scheduler supports re-insert API.

An urgent request notification from the block layer may arrive to the MMC
driver in one of the following states: when the MMC driver is waiting to the
completion of an ongoing transaction, when the MMC driver prepares the next
request to be sent or when the MMC driver sleeps. If the MMC driver is in the
middle of preparing the next request or if it sleeps then the urgent
notification is not important since the queue_thread will fetch the urgent
request anyhow. However, if the queue_thread is blocked, waiting to the
completion of an ongoing transaction, then the urgent notification should wake
it up in order to stop the current transmission, fetch the urgent request and
re-insert the unfinished blocks of the interrupted request back to the
I/O scheduler. Moreover, if there is also a pending request (as part of the
async request scheme) then this request should also be re-inserted back to
the I/O scheduler.

Even when the queue_thread is woken by the urgent request notification,
it may decide not to stop the current transmission. For example, if the current
transmission is about to finish there is no point in triggering the whole stop
transmission sequence (which is not a zero time process). Nevertheless, the
driver should still re-insert the pending request, if there is any, to the I/O
scheduler.

This patch also resolves an issue in the async request mechanism.
Our tests found out, that in most cases new request is inserted after mmc layer
fetched NULL and was blocked on waiting for the previous request completion.
The new event new_packet_flag wakes mmc layer and allows it to immediately fetch
the new inserted request.

This patch depends on the following patches:
[PATCH v8 1/3] mmc: core: Add packed command feature of eMMC4.5
[PATCH v8 2/3] mmc: core: Support packed write command for eMMC4.5 device
[PATCH v5] mmc: block: Add write packing control
[RFC/PATCH 1/2] block: Add support for reinsert a dispatched req
[RFC/PATCH 2/2] block: Add API for urgent request handling

Please look into ROW I/O scheduler as example of implementing reinsert API:
[RFC/PATCH/RESEND 2/2] block: Adding ROW scheduling algorithm

Konstantin Dorfman (2):
  mmc: Urgent data request flow
  mmc: new packet notification

 drivers/mmc/card/block.c |  182 +++++++++++++++++++++++---
 drivers/mmc/card/queue.c |   67 +++++++++-
 drivers/mmc/card/queue.h |    1 +
 drivers/mmc/core/core.c  |  327 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h |   15 ++
 include/linux/mmc/core.h |   22 +++
 include/linux/mmc/host.h |    4 +
 include/linux/mmc/mmc.h  |    1 +
 8 files changed, 590 insertions(+), 29 deletions(-)

-- 
1.7.6
-- 
QUALCOMM ISRAEL,
on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
