From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V3 2/6] mmc: sdhci-esdhc-imx: fix incorrect max timeout cout for uSDHC
Date: Wed, 27 Aug 2014 15:26:28 +0800
Message-ID: <1409124392-28899-3-git-send-email-b29396@freescale.com>
References: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0182.outbound.protection.outlook.com ([207.46.163.182]:23012
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751187AbaH0Hps (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Aug 2014 03:45:48 -0400
In-Reply-To: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

The default sdhci code use the 1 << 27 as the max timeout counter to
to calculate the max_busy_timeout, however it's not correct for uSDHC
since its the max counter is 1 << 28.
Implement esdhc_get_max_timeout_cout to handle it correctly.

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 46677f0..546ed02 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -880,6 +880,14 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+
+	return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -889,6 +897,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.set_clock = esdhc_pltfm_set_clock,
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
+	.get_max_timeout_count = esdhc_get_max_timeout_count,
 	.get_ro = esdhc_pltfm_get_ro,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
-- 
1.7.8

