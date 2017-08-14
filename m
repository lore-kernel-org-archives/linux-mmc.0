From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/4] mmc: sdhci-pci: use generic sdhci_set_bus_width()
Date: Mon, 14 Aug 2017 22:00:26 +0200
Message-ID: <16ce227fbf1a5ea490ad3b405cfd3de460b08abe.1502740497.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502740497.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:46932
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751603AbdHNUA2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Aug 2017 16:00:28 -0400
In-Reply-To: <cover.1502740497.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Now that sdhci_set_bus_width() supports 8-bit bus widths based on the
MMC_CAP_8_BIT_DATA capability flag, replace the sdhci-pci version with
the generic sdhci version.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index e1721ac37919..deffd73df124 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -35,7 +35,6 @@
 #include "sdhci-pci-o2micro.h"
 
 static int sdhci_pci_enable_dma(struct sdhci_host *host);
-static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width);
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
 #ifdef CONFIG_PM_SLEEP
@@ -562,7 +561,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_power		= sdhci_intel_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
-	.set_bus_width		= sdhci_pci_set_bus_width,
+	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= sdhci_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
@@ -1197,7 +1196,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 static const struct sdhci_ops amd_sdhci_pci_ops = {
 	.set_clock			= sdhci_set_clock,
 	.enable_dma			= sdhci_pci_enable_dma,
-	.set_bus_width			= sdhci_pci_set_bus_width,
+	.set_bus_width			= sdhci_set_bus_width,
 	.reset				= sdhci_reset,
 	.set_uhs_signaling		= sdhci_set_uhs_signaling,
 	.platform_execute_tuning	= amd_execute_tuning,
@@ -1313,29 +1312,6 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
-static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width)
-{
-	u8 ctrl;
-
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-
-	switch (width) {
-	case MMC_BUS_WIDTH_8:
-		ctrl |= SDHCI_CTRL_8BITBUS;
-		ctrl &= ~SDHCI_CTRL_4BITBUS;
-		break;
-	case MMC_BUS_WIDTH_4:
-		ctrl |= SDHCI_CTRL_4BITBUS;
-		ctrl &= ~SDHCI_CTRL_8BITBUS;
-		break;
-	default:
-		ctrl &= ~(SDHCI_CTRL_8BITBUS | SDHCI_CTRL_4BITBUS);
-		break;
-	}
-
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-}
-
 static void sdhci_pci_gpio_hw_reset(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
@@ -1362,7 +1338,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 static const struct sdhci_ops sdhci_pci_ops = {
 	.set_clock	= sdhci_set_clock,
 	.enable_dma	= sdhci_pci_enable_dma,
-	.set_bus_width	= sdhci_pci_set_bus_width,
+	.set_bus_width	= sdhci_set_bus_width,
 	.reset		= sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
-- 
2.11.0

