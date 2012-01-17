From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/8] mmc: mmci: Improved PM and SDIO support
Date: Tue, 17 Jan 2012 15:34:19 +0100
Message-ID: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:42428 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754199Ab2AQOex (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2012 09:34:53 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

This patch series replaces previous version of the series below:
	- Improved PM support, cleanup and bugfixes
	- Improvements and bugfixes for SDIO

Patches that were accepted has been removed from the series and the
ones left has been rebased.

Patch 1 to 5:
	- PM patches.
Patch 6 - 8:
	- SDIO patches.

Per Forlin (1):
  mmc: mmci: Add constraints on alignment for SDIO

Ulf Hansson (7):
  mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
  mmc: mmci: Decrease current consumption in suspend
  mmc: mmci: Implement PM runtime callbacks to save power
  mmc: mmci: Use ios_handler to save power
  mmc: mmci: Support MMC_PM_KEEP_POWER
  mmc: mmci: Fix incorrect handling of HW flow control for SDIO
  mmc: mmci: Support any block sizes for ux500v2 variant

 drivers/mmc/host/mmci.c |  251 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h |   10 ++-
 2 files changed, 222 insertions(+), 39 deletions(-)

-- 
1.7.5.4

