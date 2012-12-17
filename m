From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 07/12] mmc: sdhci: fix the bug that DDR50 can't work for emmc in default code
Date: Mon, 17 Dec 2012 19:22:03 +0800
Message-ID: <1355743328-17758-8-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:52021 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752295Ab2LQLWu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:22:50 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

According to SD host controller spec (Host Control 2 Register, offset 0x3E<3:0>),
1.8v signaling must be enabled for UHS-I modes. Otherwise all UHS-I modes
will NOT take effect.
For both sd and sdio card with UHS-I enabled, 1.8v signaling is enabled
in mmc_set_signal_voltage. But emmc with DDR50 won't change the voltage.
So 1.8v signal enabling is missed by default for emmc with DDR50.
And DDR50 will NOT take effect at all in this case.
Of course we can added this operation in callback function set_uhs_signaling.
In fact only sdhci-pxav3.c did this. But we should fix this in sdhci.c
since the spec required this explicitly. Then the callback function can be removed.
This patch enable the 1.8v signaling for mmc DDR50 mode in sdhci.c.

Below is more infomation from spec:
In JEDEC spec, there are two emmc device types which support DDR50.
One type can work under signal 1.2v while the other type work under
signal 1.8v or 3v. So current code just keep 3v for the second device
type.

But in SD host spec, 1.8v signal must be enabled for all UHS-I modes
taking effect. So the fact is, if using SD host to work with emmc chip,
then 1.8v signal must be selected in order to enable DDR50.
Current code missed this.

Because DDR50 shall can work under both signal 1.8v and 3v according
to JEDEC spec,  So always switching to 1.8v in mmc core code is
unreasonable. It's the SD host controller's requirement that 1.8v
signal must be enabled for DDR50, which conflict with JEDEC spec.
So correct this in host driver.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 98b2a2a..4ef94a5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1484,8 +1484,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
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
 
-- 
1.7.0.4

