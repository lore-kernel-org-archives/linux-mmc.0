From: Lucas Stach <dev@lynxeye.de>
Subject: [PATCH 5/5] mmc: tegra: use correct accessor for misc ctrl register
Date: Sat, 19 Dec 2015 20:16:04 +0100
Message-ID: <1450552564-32697-6-git-send-email-dev@lynxeye.de>
References: <1450552564-32697-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:40487 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932724AbbLSTXK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 19 Dec 2015 14:23:10 -0500
In-Reply-To: <1450552564-32697-1-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

The misc control register is 32bit wide, the used readw/writew
accessors only mainipulate the low 16bit of this register. It
currently doesn't matter as all the bit changed are located in
the lower half, but together with the u32 variable used to hold
the contents of the register it is seriously confusing.

Switch to 32bit accessors to avoid any future breakage.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/mmc/host/sdhci-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index b5374d7..5df8166 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -140,7 +140,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (!(mask & SDHCI_RESET_ALL))
 		return;
 
-	misc_ctrl = sdhci_readw(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
+	misc_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 	/* Erratum: Enable SDHCI spec v3.00 support */
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
@@ -151,7 +151,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
-	sdhci_writew(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
+	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 
 	clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
-- 
2.5.0

