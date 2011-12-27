From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH V2] *** exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Tue, 27 Dec 2011 15:33:01 +0200
Message-ID: <1324992782-1004-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:36056 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1L0NdL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Dec 2011 08:33:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>

*** exposing SANITIZE capability to the user space via a unique IOCTL ***

Yaniv Gardi (1):
  mmc: card: IOCTL support for Sanitize feature of eMMC v4.5

 block/blk-core.c          |   15 ++++++++++--
 block/blk-lib.c           |   44 +++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |    6 +++++
 block/elevator.c          |    8 ++++++-
 block/ioctl.c             |    9 ++++++++
 drivers/mmc/card/block.c  |   50 ++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/card/queue.c  |    7 +++++-
 include/linux/blk_types.h |    7 ++++-
 include/linux/blkdev.h    |    3 ++
 include/linux/fs.h        |    1 +
 include/linux/mmc/card.h  |    7 ++++++
 kernel/trace/blktrace.c   |    2 +
 12 files changed, 143 insertions(+), 16 deletions(-)

-- 
1.7.6
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
