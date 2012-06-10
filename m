From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH v7 0/2] *** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Sun, 10 Jun 2012 11:47:47 +0300
Message-ID: <1339318069-11428-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, ygardi@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

*** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***

Yaniv Gardi (2):
  block: ioctl support for sanitize in eMMC 4.5
  mmc: card: Adding support for sanitize in eMMC 4.5

 block/blk-core.c          |   15 +++++++--
 block/blk-lib.c           |   51 +++++++++++++++++++++++++++++++
 block/blk-merge.c         |    4 ++
 block/elevator.c          |    2 +-
 block/ioctl.c             |    9 +++++
 drivers/mmc/card/block.c  |   72 ++++++++++++++++++++++++++++++++------------
 drivers/mmc/card/queue.c  |   10 +++++-
 include/linux/blk_types.h |    5 ++-
 include/linux/blkdev.h    |    3 ++
 include/linux/fs.h        |    1 +
 include/linux/mmc/host.h  |    1 +
 kernel/trace/blktrace.c   |    2 +
 12 files changed, 149 insertions(+), 26 deletions(-)

-- 
1.7.6
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
