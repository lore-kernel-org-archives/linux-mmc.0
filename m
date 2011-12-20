From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH V1] *** exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Tue, 20 Dec 2011 19:21:04 +0200
Message-ID: <1324401665-17799-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

*** exposing SANITIZE capability to the user space via a unique IOCTL ***

Yaniv Gardi (1):
  mmc: card: IOCTL support for Sanitize feature of eMMC v4.5

 block/blk-core.c          |   15 +++++++++++--
 block/blk-lib.c           |   44 ++++++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |    6 +++++
 block/elevator.c          |    8 ++++++-
 block/ioctl.c             |    9 ++++++++
 drivers/mmc/card/block.c  |   47 ++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/card/queue.c  |    7 +++++-
 include/linux/blk_types.h |    7 ++++-
 include/linux/blkdev.h    |    3 ++
 include/linux/fs.h        |    1 +
 include/linux/mmc/card.h  |    7 ++++++
 kernel/trace/blktrace.c   |    2 +
 12 files changed, 140 insertions(+), 16 deletions(-)

-- 
1.7.6
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
