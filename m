From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v5 12/13] mmc: sdhci: fix the bug that DDR50 can't work for emmc
Date: Fri, 28 Sep 2012 15:56:11 +0800
Message-ID: <1348818972-26711-13-git-send-email-keyuan.liu@gmail.com>
References: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:56648 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756685Ab2I1ICJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 04:02:09 -0400
In-Reply-To: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Host controller must enable 1.8v signal for UHS modes. Otherwise
UHS modes won't take effect. But mmc core does NOT switch to 1.8v
for DDR50 mode. So enable the 1.8v signal for mmc DDR50 mode in host
driver.

In JEDEC spec, there are two emmc device types which support DDR50.
One type can work under signal 1.2v while the other type work under
signal 1.8v or 3v. So current code just keep 3v for the second device
type.

But in SD host spec, 1.8v signal must be enabled for all UHS modes
taking effect. So the fact is, if using SD host to work with emmc chip,
then 1.8v signal must be selected in order to enable DDR50.
Current code missed this.

Because DDR50 shall can work under both signal 1.8v and 3v according
to JEDEC spec,  So should not switch to 1.8v in mmc core code.
It's the host controller requirement that 1.8v signal must be enabled
in order to enable DDR50, which conflict with emmc spec. So add this
in host driver.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1faa5ec..fbf94b0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1529,8 +1529,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
 			else if (ios->timing == MMC_TIMING_UHS_SDR104)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
-			else if (ios->timing == MMC_TIMING_UHS_DDR50)
+			else if (ios->timing == MMC_TIMING_UHS_DDR50) {
+				struct mmc_card	*card;
+
 				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+				card = container_of(&(host->mmc),
+					struct mmc_card, host);
+				if (mmc_card_mmc(card))
+					ctrl_2 |= SDHCI_CTRL_VDD_180;
+			}
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 		}
 		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
-- 
1.7.0.4

