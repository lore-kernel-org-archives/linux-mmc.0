From: Lucas Stach <dev@lynxeye.de>
Subject: [PATCH v2 2/5] mmc: tegra: disable SPI_MODE_CLKEN
Date: Tue, 22 Dec 2015 19:41:01 +0100
Message-ID: <1450809664-11360-3-git-send-email-dev@lynxeye.de>
References: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:44234 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752665AbbLVSlO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Dec 2015 13:41:14 -0500
In-Reply-To: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

The Tegra30 and up TRM states that this bit should always be
programmed to 0 by driver software.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f11db83..20ce81b 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -28,6 +28,10 @@
 #include "sdhci-pltfm.h"
 
 /* Tegra SDHOST controller vendor register definitions */
+#define SDHCI_TEGRA_VENDOR_CLOCK_CTRL			0x100
+#define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
+#define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
+
 #define SDHCI_TEGRA_VENDOR_MISC_CTRL		0x120
 #define SDHCI_MISC_CTRL_ENABLE_SDR104		0x8
 #define SDHCI_MISC_CTRL_ENABLE_SDR50		0x10
@@ -125,7 +129,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = pltfm_host->priv;
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
-	u32 misc_ctrl;
+	u32 misc_ctrl, clk_ctrl;
 
 	sdhci_reset(host, mask);
 
@@ -145,6 +149,10 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
 	sdhci_writew(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 
+	clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
+	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+
 	tegra_host->ddr_signaling = false;
 }
 
-- 
2.5.0

