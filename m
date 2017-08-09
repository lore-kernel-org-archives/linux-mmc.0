From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/4] mmc/sdhci-tegra: use generic sdhci_set_bus_width()
Date: Wed, 09 Aug 2017 22:36:05 +0200
Message-ID: <3debee26f13754f08d36bc3647a83979708a67fa.1502310654.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:60490
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752142AbdHIUgH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2017 16:36:07 -0400
In-Reply-To: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci-tegra.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7f93079c7a3a..9a589b6a53dd 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -190,25 +190,6 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	tegra_host->ddr_signaling = false;
 }
 
-static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
-{
-	u32 ctrl;
-
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-	if ((host->mmc->caps & MMC_CAP_8_BIT_DATA) &&
-	    (bus_width == MMC_BUS_WIDTH_8)) {
-		ctrl &= ~SDHCI_CTRL_4BITBUS;
-		ctrl |= SDHCI_CTRL_8BITBUS;
-	} else {
-		ctrl &= ~SDHCI_CTRL_8BITBUS;
-		if (bus_width == MMC_BUS_WIDTH_4)
-			ctrl |= SDHCI_CTRL_4BITBUS;
-		else
-			ctrl &= ~SDHCI_CTRL_4BITBUS;
-	}
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-}
-
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
 	u32 val;
@@ -323,7 +304,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
-	.set_bus_width = tegra_sdhci_set_bus_width,
+	.set_bus_width = sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
@@ -371,7 +352,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.write_w    = tegra_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
-	.set_bus_width = tegra_sdhci_set_bus_width,
+	.set_bus_width = sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
-- 
2.11.0

