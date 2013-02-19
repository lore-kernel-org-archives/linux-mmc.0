From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH v9 0/2] *** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Tue, 19 Feb 2013 18:22:15 +0200
Message-ID: <1361290937-7427-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, vgoyal@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org, jaxboe@fusionio.com, akpm@linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

*** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***

Yaniv Gardi (2):
  block: ioctl support for sanitize in eMMC 4.5
  mmc: card: Adding support for sanitize in eMMC 4.5

 block/blk-core.c          |    8 +++++
 block/blk-lib.c           |   51 ++++++++++++++++++++++++++++++
 block/blk-merge.c         |    4 ++
 block/elevator.c          |    6 +++-
 block/ioctl.c             |    9 +++++
 drivers/mmc/card/block.c  |   75 +++++++++++++++++++++++++++++++-------------
 drivers/mmc/card/queue.c  |   10 +++++-
 include/linux/blk_types.h |    7 +++-
 include/linux/blkdev.h    |    6 +++
 include/linux/mmc/host.h  |    1 +
 include/uapi/linux/fs.h   |    1 +
 kernel/trace/blktrace.c   |    2 +
 12 files changed, 154 insertions(+), 26 deletions(-)

-- 
1.7.6
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
