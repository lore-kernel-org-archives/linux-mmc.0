From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH v9 0/2] *** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Tue, 19 Feb 2013 18:10:50 +0200
Message-ID: <1361290252-6004-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:3221 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757768Ab3BSQLM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 11:11:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, vgoyal@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>

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
