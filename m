From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: =?UTF-8?q?=5BPATCH=20v4=200/2=5D=20ROW=20scheduling=20Algorithm?=
Date: Tue, 11 Dec 2012 15:41:18 +0200
Message-ID: <1355233280-25923-1-git-send-email-tlinder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: jaxboe@fusionio.com
Cc: linux-arm-msm@vger.kernel.org, philippedeswert@gmail.com, jengelh@inai.de, jh80.chung@samsung.com, tgih.jun@samsung.com, arnd.bergmann@linaro.org, venkat@linaro.org, linux-mmc@vger.kernel.org, Tanya Brokhman <tlinder@codeaurora.org>
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
Give READ requests priority over WRITE with WRITE starvation in mind

With ROW set as the scheduling algorithm we were able to:
- Reduce the worst case READ latency by 41%
- Improve the READ throughput by 63%
(All in read&write coalition scenarios)

Tanya Brokhman (1):
  block: Adding ROW scheduling algorithm

Tatyana Brokhman (1):
  block: compile ROW statically into the kernel

 Documentation/block/row-iosched.txt |  134 +++++++
 block/Kconfig.iosched               |   22 ++
 block/Makefile                      |    1 +
 block/row-iosched.c                 |  694 +++++++++++++++++++++++++++=
++++++++
 4 files changed, 851 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/block/row-iosched.txt
 create mode 100644 block/row-iosched.c

--=20
1.7.6
--
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc.=20
Is a member of Code Aurora Forum, hosted by the Linux Foundation
