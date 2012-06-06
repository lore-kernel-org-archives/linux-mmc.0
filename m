From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v2 0/1] block: Add test-iosched scheduler
Date: Wed,  6 Jun 2012 22:44:35 +0300
Message-ID: <1339011882-7919-1-git-send-email-merez@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 212.199.104.198.static.012.net.il ([212.199.104.198]:19204 "EHLO
	lx-merez.qi.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752133Ab2FFTpI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jun 2012 15:45:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>

The test scheduler allows testing a block device by dispatching
specific requests according to the test case and declare PASS/FAIL
according to the requests completion error code

Changes in v2:
    - Export test-iosched functionality to allow definition of the block device
      tests under the block device layer
    - Add registration of block device tests utilities

Maya Erez (1):
  block: Add test-iosched scheduler

 Documentation/block/test-iosched.txt |   39 ++
 block/Kconfig.iosched                |    8 +
 block/Makefile                       |    1 +
 block/blk-core.c                     |    3 +-
 block/test-iosched.c                 | 1025 ++++++++++++++++++++++++++++++++++
 include/linux/test-iosched.h         |  218 +++++++
 6 files changed, 1292 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/block/test-iosched.txt
 create mode 100644 block/test-iosched.c
 create mode 100644 include/linux/test-iosched.h

--
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
