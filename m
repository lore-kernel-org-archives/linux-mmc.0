From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH v4 0/2] *** exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Sun, 26 Feb 2012 13:03:03 +0200
Message-ID: <1330254185-2428-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: axboe@kernel.dk, ygardi@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

*** exposing SANITIZE capability to the user space via a unique IOCTL ***

changes patch v4:
removed a few debug printouts

changes patch v3:
split the patch into 2 commits - block and mmc/card
added capability MMC_CAP2_SANITIZE to mmc controller

Yaniv Gardi (2):
  block: IOCTL support for Sanitize in eMMC v4.5
  mmc: card: Adding support for Sanitize in eMMC v4.5

 block/blk-core.c          |   15 ++++++++++--
 block/blk-lib.c           |   44 ++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |    6 +++++
 block/elevator.c          |    8 ++++++-
 block/ioctl.c             |    9 +++++++
 drivers/mmc/card/block.c  |   52 +++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/card/queue.c  |   10 +++++++-
 include/linux/blk_types.h |    6 +++-
 include/linux/blkdev.h    |    3 ++
 include/linux/fs.h        |    1 +
 include/linux/mmc/card.h  |    7 ++++++
 include/linux/mmc/host.h  |    1 +
 kernel/trace/blktrace.c   |    2 +
 13 files changed, 148 insertions(+), 16 deletions(-)
-- 
1.7.6
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
