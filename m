From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/4] mmc: sdhci-s3c: use generic sdhci_set_bus_width()
Date: Mon, 14 Aug 2017 22:00:26 +0200
Message-ID: <471746dfd08fd4eeae2e747c4ce7f98371ac1e99.1502740497.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502740497.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:46946
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751389AbdHNUA3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Aug 2017 16:00:29 -0400
In-Reply-To: <cover.1502740497.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Now that sdhci_set_bus_width() supports 8-bit bus widths based on the
MMC_CAP_8_BIT_DATA capability flag, replace the sdhci-s3c version with
the generic sdhci version.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-s3c.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7c065a70f92b..d328fcf284d1 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -414,43 +414,11 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 }
 
-/**
- * sdhci_s3c_set_bus_width - support 8bit buswidth
- * @host: The SDHCI host being queried
- * @width: MMC_BUS_WIDTH_ macro for the bus width being requested
- *
- * We have 8-bit width support but is not a v3 controller.
- * So we add platform_bus_width() and support 8bit width.
- */
-static void sdhci_s3c_set_bus_width(struct sdhci_host *host, int width)
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
-		ctrl &= ~SDHCI_CTRL_4BITBUS;
-		ctrl &= ~SDHCI_CTRL_8BITBUS;
-		break;
-	}
-
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-}
-
 static struct sdhci_ops sdhci_s3c_ops = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
 	.set_clock		= sdhci_s3c_set_clock,
 	.get_min_clock		= sdhci_s3c_get_min_clock,
-	.set_bus_width		= sdhci_s3c_set_bus_width,
+	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= sdhci_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 };
-- 
2.11.0

