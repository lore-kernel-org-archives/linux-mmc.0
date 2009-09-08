From: thomas.ab@samsung.com
Subject: [PATCH 0/8] s3c6410: sdhci: Update Samsung 6410 SDHCI driver.
Date: Tue,  8 Sep 2009 14:45:10 +0900
Message-ID: <1252388710-28478-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:37796 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbZIHF5P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 01:57:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch series updates Samsung's 6410 SDHCI driver. This patch series
adds clock configuration code in the sdhci driver, adds ADMA support and 
adds module exit functionality. This patch set includes the following
patches

[PATCH 1/8] s3c6410: sdhci: Adding additional elements in sdhci platform data structure.
[PATCH 2/8] s3c6410: sdhci: Adding additional data in sdhci platform data structure.
[PATCH 3/8] s3c6410: sdhci: Set parent clock, source clock and sdhci module speed.
[PATCH 4/8] s3c6410: sdhci: Enable ADMA feature in 6410 sdhci controller.
[PATCH 5/8] s3c6410: sdhci: Removing unused host_caps entry from sdhci0 platform data
[PATCH 6/8] s3c6410: sdhci: Modify platform data for sdhci-1
[PATCH 7/8] s3c6410: sdhci: Remove host_caps field from sdhci platform data structure
[PATCH 8/8] s3c6410: sdhci: Updating sdhci_s3c_remove module exit function

This patch sets depends on the following patches for proper functioning.

[PATCH 1/4] s3c6410: use correct divider_shift in setrate_clksrc()
[PATCH 2/4] s3c6410: update clk->parent when setting clock source
[PATCH 3/4] s3c6410: Fix divider value calculation in s3c64xx_roundrate_clksrc
[PATCH 4/4] s3c6410: Remove redundant mpll parent assignment.
[PATCH] sdhci: Add new quirk in sdhci driver and update ADMA descriptor build.

-- 
1.5.3.4

