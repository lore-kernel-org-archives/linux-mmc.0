From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v1 0/1] block: Add eMMC4.5 packed commands unit-tests
Date: Tue, 12 Jun 2012 13:44:20 +0300
Message-ID: <1339497861-31367-1-git-send-email-merez@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 212.199.104.198.static.012.net.il ([212.199.104.198]:29615 "EHLO
	lx-merez.qi.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751797Ab2FLKod (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 06:44:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>

Expose the following packed commands tests:
- Test the write packed commands list preparation
- Simulate a returned error code
- Send an invalid packed command to the card

This patch is dependant in the following patches:
  [PATCH v7 1/3] mmc: core: Add packed command feature of eMMC4.5
  [PATCH v7 2/3] mmc: core: Support packed write command for eMMC4.5 device
  [RFC/PATCH 1/1] Add MMC write packing statistics
  [PATCH v4 1/1] block: Add test-iosched scheduler

Maya Erez (1):
  block: Add eMMC4.5 packed commands unit-tests

 drivers/mmc/card/Kconfig          |   11 +
 drivers/mmc/card/Makefile         |    1 +
 drivers/mmc/card/block.c          |   82 ++-
 drivers/mmc/card/mmc_block_test.c | 1407 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/queue.h          |   15 +
 5 files changed, 1504 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mmc/card/mmc_block_test.c

-- 
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

