From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: =?UTF-8?q?=5BPATCH=20v7=200/4=5D=20block=3A=20Adding=20ROW=20scheduling=20algorithm?=
Date: Thu,  6 Jun 2013 14:20:28 +0300
Message-ID: <1370517628-5620-1-git-send-email-tlinder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:34251 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab3FFLUg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 07:20:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, Tanya Brokhman <tlinder@codeaurora.org>

In order to decrease the latency of a prioritized request (such as READ
requests) the device driver might decide to stop the transmission of a
current "low priority" request in order to handle the "high priority" o=
ne.
The urgency of the request is decided by the block layer I/O scheduler.
When the block layer notifies the underlying device driver (eMMC for
example) of an urgent request, the device driver might decide to stop
the current request transmission. The remainder of the stopped request
will be re-inserted back to the scheduler, to be re-scheduled after
handling the urgent request.

The above is implemented in the block layer by 2 callbacks of the queue=
:
- urgent_request_fn() - This callback is registered by the underlying
  device driver and is called instead of the existing requst_fn() callb=
acks
  to handle urgent requests.
- elevator_is_urgent_fn() - This callback is registered by the current
  I/O scheduler. If present it's used by the block layer to ping the
  scheduler of an urgent request presence.          =20
NOTE: If one of the above callbacks is not registered, these code pass
will never be activated.

The ROW I/O scheduler implements an urgent request notification mechani=
sm.

The policy of ROW I/O scheduler is to prioritize READ requests over WRI=
TE
as much as possible without starving the WRITE requests.

The ROW I/O scheduler implements I/O priorities (CLASS_RT, CLASS_BE,
CLASS_IDLE). Dissimilar to CFQ, CLASS_BE requests won=E2=80=99t be star=
ved by
CLASS_RT, and CLASS_IDLE requests won=E2=80=99t be starved by CLASS_RT/=
CLASS_BE
requests. A tolerance limit is managed to prevent starvation.

The ROW I/O scheduler with the URGENT request support by the device dri=
ver
improves the READ throughput by ~25% and the READ worst case latency is
decreased by ~85%. All measured for READ/WRITE coalition scenarios.

=46or example, the bellow numbers were collected for  parallel lmdd rea=
d and
write. The tests were performed on:
kernel version: 3.4
Underline device driver: mmc
Host controller: msm-sdcc
Card: standard emmc NAND flash

-------------------------------------------------------------------
   Algorithm   |   Throughput [mb/sec]   |   Worst case Latency   |
               |     READ    |   WRITE   |   READ Latency [msec]  |
-------------------------------------------------------------------
CFQ	       |    122.3    |   40.22   |         422            |
ROW	       |    151.4    |   41.07   |         51.5           |

Tanya Brokhman (4):
  block: Add support for reinsert a dispatched req
  block: Extend cmd_flags in struct request
  block: Add API for urgent request handling
  block: Adding ROW scheduling algorithm

 Documentation/block/row-iosched.txt |  134 +++++
 block/Kconfig.iosched               |   21 +
 block/Makefile                      |    1 +
 block/blk-core.c                    |   89 +++-
 block/elevator.c                    |   40 ++
 block/row-iosched.c                 | 1090 +++++++++++++++++++++++++++=
++++++++
 include/linux/blk_types.h           |    7 +
 include/linux/blkdev.h              |    7 +
 include/linux/elevator.h            |    7 +
 9 files changed, 1387 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/block/row-iosched.txt
 create mode 100644 block/row-iosched.c

--=20
1.7.6

--=20
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a mem=
ber
of Code Aurora Forum, hosted by The Linux Foundatio
