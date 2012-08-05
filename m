From: Tatyana Brokhman <tlinder@codeaurora.org>
Subject: =?UTF-8?q?=5BRFC/PATCH=200/2=5D=20ROW=20scheduling=20Algorithm?=
Date: Sun,  5 Aug 2012 14:30:39 +0300
Message-ID: <1344166241-18708-1-git-send-email-tlinder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Tatyana Brokhman <tlinder@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

The ROW scheduling algorithm will be used in mobile devices as default
block layer IO scheduling algorithm. ROW stands for "READ Over WRITE"
which is the main requests dispatch policy of this algorithm.

The ROW IO scheduler was developed with the mobile devices needs in
mind. In mobile devices we favor user experience upon everything else,
thus we want to give READ IO requests as much priority as possible.
In mobile devices we won=E2=80=99t have AS much parallel threads as on =
desktops.
Usually it=E2=80=99s a single thread or at most 2 simultaneous working =
threads
for read & write. Favoring READ requests over WRITEs decreases the READ
latency greatly.

The main idea of the ROW scheduling policy is:
If there are READ requests in pipe - dispatch them but don't starve
the WRITE requests too much.

Bellow you=E2=80=99ll find a small comparison of ROW to existing schedu=
lers.
The test that was run for these measurements is parallel lmdd read and =
write.
The tests were performed on:
kernel version: 3.4
Underline device driver: mmc
Host controller: msm-sdcc
Card:standard emmc NAND flash

-----------------------------------------------------------------------=
---
   Algorithm   |   Throughput [mb/sec]   |   Worst case Latency [msec] =
  |
               |     READ    |   WRITE   |     READ      |     WRITE   =
  |
-----------------------------------------------------------------------=
---
Noop           |    12.12    |   25.18   |     4407      |      4804   =
  |
Deadline       |    12.02    |   24.6    |     705       |      5130   =
  |=20
CFQ	       |    20.81    |   15.23   |     230       |      9370     |
ROW	       |    27.75    |   15.34   |      85       |     12025     |
-----------------------------------------------------------------------=
--|


Tatyana Brokhman (2):
  block: Expose kblock_schedule_delayed_work()
  block: Adding ROW scheduling algorithm

 Documentation/block/row-iosched.txt |  117 ++++++
 block/Kconfig.iosched               |   22 ++
 block/Makefile                      |    1 +
 block/row-iosched.c                 |  675 +++++++++++++++++++++++++++=
++++++++
 include/linux/blkdev.h              |    2 +
 5 files changed, 817 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/block/row-iosched.txt
 create mode 100644 block/row-iosched.c

--=20
1.7.6
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.
