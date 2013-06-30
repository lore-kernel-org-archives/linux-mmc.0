From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: [RFC/PATCH v2] mmc: Add support to handle Urgent data transfer request
Date: Sun, 30 Jun 2013 15:19:48 +0300
Message-ID: <1372594789-24558-1-git-send-email-kdorfman@codeaurora.org>
References: <n>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <n>
Sender: linux-arm-msm-owner@vger.kernel.org
To: cjb@laptop.org
Cc: tlinder@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, merez@codeaurora.org, kdorfman@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Motivation:

In order to decrease the latency of a prioritized request (such as READ
requests) the device driver might decide to stop the transmission of a
current "low priority" request in order to handle the "high priority" one.
The urgency of the request is decided by the block layer I/O scheduler.
When the block layer notifies the underlying device driver (eMMC for
example) of an urgent request, the device driver might decide to stop
the current request transmission. The remainder of the stopped request
will be re-inserted back to the scheduler, to be re-scheduled after
handling the urgent request.

This patch depends on following patches (in this order): 
1. [PATCH v9 2/4] block: Add support for reinsert a dispatched req
2. [PATCH v9 1/4] block: make rq->cmd_flags be 64-bit
3. [PATCH v9 3/4] block: Add API for urgent request handling

In order to benefit in terms of read request latency I/O scheduler
should implement urgent request classify and schedule policy, like one
implemented by: 
	[PATCH v9 4/4] block: Adding ROW scheduling algorithm
	by Tanya Brokhman <tlinder@codeaurora.org> tlinder@codeaurora.org

These patches are introducing a new api's of the block layer, supporting
its ability to classify incoming requests as urgent:
 - blk_urgent_request()   - set a notifier function, which will be called upon
			    urgent request arraiving at block layer
 - blk_reinsert_request() - used to re-insert back request unserved by
			    MMC requests

Besides block layer dependencies, following eMMC device and host controller
capabilities needed:
 - eMMC card HPI functionality to be able to interrupt undergoing write request
 - stop_request() api implemented by host controller driver to correctly stop
   undergoing write transaction
 - MMC_CAP2_STOP_REQUEST capability bit used to enable/disable the feature

The change extends existing MMC layer wait event functionality, that was
introduced by following commit:

6035d97 mmc: fix async request mechanism for sequential read scenarios

Test was done with kernel 3.4 on msm platform.  Latency measured using
blktrace and custom instrumentation. Test was running parallel
read/write lmdd stream. Latency is measured in ms. CFQ scheduler used as
baseline, compared with ROW scheduler with the feature turned on.

Parallel lmdd:
./data/lmdd if=internal of=/data/write.dat bs=128k count=2500 sync=1
./data/lmdd of=internal if=/data/readfile.dat bs=128k count=2500

        Throughput [Mb/sec]  Worst latency [msec]
        read     write       read     write
ROW     150      40          55       3800
CFQ     134      40          500      3280

Above is the average of 5 runs. Resulting worst case latency improved by
factor 9.

Konstantin Dorfman (1):
  mmc: Add support to handle Urgent data transfer request

 drivers/mmc/card/block.c |  151 +++++++++++++++++++++++++++++++++-
 drivers/mmc/card/queue.c |   54 ++++++++++++-
 drivers/mmc/card/queue.h |    5 +-
 drivers/mmc/core/core.c  |  208 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/mmc/card.h |    5 +-
 include/linux/mmc/host.h |   16 ++++-
 include/linux/mmc/mmc.h  |    1 +
 7 files changed, 425 insertions(+), 15 deletions(-)

-- 
1.7.6
--
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
