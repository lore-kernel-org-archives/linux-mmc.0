From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH v6 0/2] *** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Thu,  7 Jun 2012 17:38:59 +0300
Message-ID: <1339079942-23542-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:32793 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760847Ab2FGOjJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jun 2012 10:39:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ygardi@codeaurora.org, merez@codeaurora.org

*** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***

changes patch v6:
fixed some code review comments
added timeout dependency for CMD6 when
issueing the sanitize command.

changes patch v5:
added BUG_ON() where needed

changes patch v4:
removed a few debug printouts

changes patch v3:
split the patch into 2 commits - block and mmc/card
added capability MMC_CAP2_SANITIZE to mmc controller

Yaniv Gardi (2):
  block: ioctl support for sanitize in eMMC 4.5
  mmc: card: Adding support for sanitize in eMMC 4.5

 block/blk-core.c          |   18 +++++++++--
 block/blk-lib.c           |   51 +++++++++++++++++++++++++++++++
 block/blk-merge.c         |    6 ++++
 block/elevator.c          |   41 ++++++++++++++++++++++++-
 block/ioctl.c             |    9 +++++
 drivers/mmc/card/block.c  |   72 ++++++++++++++++++++++++++++++++------------
 drivers/mmc/card/queue.c  |   10 +++++-
 include/linux/blk_types.h |    5 ++-
 include/linux/blkdev.h    |    3 ++
 include/linux/fs.h        |    1 +
 include/linux/mmc/host.h  |    1 +
 kernel/trace/blktrace.c   |    2 +
 12 files changed, 191 insertions(+), 28 deletions(-)

-- 
1.7.6
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
