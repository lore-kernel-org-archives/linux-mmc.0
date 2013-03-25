From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: =?UTF-8?q?=5BPATCH=20v5=200/3=5D=20block=3A=20Adding=20ROW=20scheduling=20algorithm?=
Date: Mon, 25 Mar 2013 11:01:02 +0200
Message-ID: <1364202062-8587-1-git-send-email-tlinder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Alex.Lemberg@sandisk.com, Tanya Brokhman <tlinder@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

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

The ROW I/O scheduler implements and urgent request notification mechan=
ism.

The policy of ROW I/O scheduler is to prioritize READ requests over WRI=
TE
as much as possible without starving the WRITE requests.

The ROW I/O scheduler implements I/O priorities (CLASS_RT, CLASS_BE, CL=
ASS_IDLE).
Dissimilar to CFQ, CLASS_BE requests won=E2=80=99t be starved by CLASS_=
RT, and
CLASS_IDLE requests won=E2=80=99t be starved by CLASS_RT/CLASS_BE reque=
sts.
A tolerance limit is managed to prevent starvation.

The ROW I/O scheduler with the URGENT request support by the device dri=
ver
improves the READ throughput by ~80% and the READ worst case latency is
decreased by ~66%. All measured for READ/WRITE coalition scenarios.

Tanya Brokhman (2):
  block: Add API for urgent request handling
  block: Adding ROW scheduling algorithm

Tatyana Brokhman (1):
  block: Add support for reinsert a dispatched req

 Documentation/block/row-iosched.txt |  134 +++++
 block/Kconfig.iosched               |   21 +
 block/Makefile                      |    1 +
 block/blk-core.c                    |   69 +++-
 block/elevator.c                    |   40 ++
 block/row-iosched.c                 | 1089 +++++++++++++++++++++++++++=
++++++++
 include/linux/blk_types.h           |    2 +
 include/linux/blkdev.h              |    6 +
 include/linux/elevator.h            |    7 +
 9 files changed, 1367 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/block/row-iosched.txt
 create mode 100644 block/row-iosched.c

--=20
1.7.6

--=20
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a mem=
ber
of Code Aurora Forum, hosted by The Linux Foundation
