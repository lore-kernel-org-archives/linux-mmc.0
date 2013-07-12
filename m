From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: [RFC/PATCH v2 0/4] block: Add support for urgent request handling in CFQ
Date: Fri, 12 Jul 2013 20:05:58 +0300
Message-ID: <1373648759-16875-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, Tanya Brokhman <tlinder@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

In order to decrease the latency of a prioritized request (such as READ
requests) the device driver might decide to stop the transmission of a
current "low priority" request in order to handle the "high priority" one.
The urgency of the request is decided by the block layer I/O scheduler.
When the block layer notifies the underlying device driver (eMMC for
example) of an urgent request, the device driver might decide to stop
the current request transmission. The remainder of the stopped request
will be re-inserted back to the scheduler, to be re-scheduled after
handling the urgent request.

The above is implemented in the block layer by 2 callbacks of the queue:
- urgent_request_fn() - This callback is registered by the underlying
  device driver and is called instead of the existing requst_fn() callbacks
  to handle urgent requests.
- elevator_is_urgent_fn() - This callback is registered by the current
  I/O scheduler. If present it's used by the block layer to ping the
  scheduler of an urgent request presence.           
NOTE: If one of the above callbacks is not registered, these code pass
will never be activated.

This patch set adds support for urgent request handling to the CFQ I/O
scheduler as an example. Using the urgent request notification together
with support from the underling device driver improves both the throughput
and the worst case latency of READ requests in READ and WRITE collision
scenarios.

For example, the bellow numbers were collected for  parallel lmdd read and
write. The tests were performed on:
kernel version: 3.4
Underline device driver: mmc
Host controller: msm-sdhci
Card: standard emmc NAND flash

-------------------------------------------------------------------
   Algorithm   |   Throughput [mb/sec]   |   Worst case Latency   |
               |     READ    |   WRITE   |   READ Latency [msec]  |
-------------------------------------------------------------------
original CFQ   |    119      |   39      |         597            |
CFQ with urgent|    	     |           |                        |
notification   |    150      |   37      |         35             |
support	       |	     |		 |			  |

This development depends on a patch introduced by Jens Axboe in
linux-block git tree which extends the req->cmd_flags field.
It's attached to this patch set for convenience.

Jens Axboe (1):
  block: make rq->cmd_flags be 64-bit

Tanya Brokhman (3):
  block: Add support for reinsert a dispatched req
  block: Add API for URGENT request handling
  block: Add URGENT request notification support to CFQ scheduler

 block/blk-core.c          |   89 ++++++++++++++++++++++++++++++++++-----
 block/blk-settings.c      |   12 +++++
 block/cfq-iosched.c       |  101 ++++++++++++++++++++++++++++++++++++++++++--
 block/elevator.c          |   39 +++++++++++++++++
 drivers/block/floppy.c    |    4 +-
 drivers/scsi/sd.c         |    2 +-
 include/linux/blk_types.h |   68 +++++++++++++++---------------
 include/linux/blkdev.h    |   10 ++++-
 include/linux/elevator.h  |    7 +++
 9 files changed, 278 insertions(+), 54 deletions(-)

-- 
1.7.6

-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundatio
