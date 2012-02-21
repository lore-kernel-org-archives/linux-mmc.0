From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH v3 0/2] *** exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Tue, 21 Feb 2012 16:00:23 +0200
Message-ID: <1329832825-8844-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:26951 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab2BUOA4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2012 09:00:56 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, axboe@kernel.dk, ygardi@codeaurora.org

*** exposing SANITIZE capability to the user space via a unique IOCTL ***

changes patch v3:
split the patch into 2 commits - block and mmc/card
added capability MMC_CAP2_SANITIZE to mmc controller

Yaniv Gardi (2):
  block: IOCTL support for Sanitize in eMMC v4.5
  mmc: card: Adding support for Sanitize in eMMC v4.5

 block/blk-core.c          |   15 +++++++++--
 block/blk-lib.c           |   44 ++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |    6 ++++
 block/elevator.c          |    8 +++++-
 block/ioctl.c             |    9 +++++++
 drivers/mmc/card/block.c  |   58 ++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/card/queue.c  |   12 ++++++++-
 include/linux/blk_types.h |    6 +++-
 include/linux/blkdev.h    |    3 ++
 include/linux/fs.h        |    1 +
 include/linux/mmc/card.h  |    7 +++++
 include/linux/mmc/host.h  |    1 +
 kernel/trace/blktrace.c   |    2 +
 13 files changed, 156 insertions(+), 16 deletions(-)

-- 
1.7.6
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum

