From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V3 4/6] mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
Date: Wed, 27 Aug 2014 15:26:30 +0800
Message-ID: <1409124392-28899-5-git-send-email-b29396@freescale.com>
References: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2lp0209.outbound.protection.outlook.com ([207.46.163.209]:41643
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754088AbaH0HqN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Aug 2014 03:46:13 -0400
In-Reply-To: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

The default sdhci driver write 0xE into timeout counter register to
set the maximum timeout. The value is not correct for uSDHC since the
max counter value for uSDHC is 0xF.
Instead of using common timeout code in sdhci, we implement esdhc_set_timeout
to handle the difference between eSDHC and uSDHC.

Currently we simply set the max timeout value as before.
But in the future, we probably may implement IMX specific timeout
setting algorithm and use suitable timeout for different CMDs.

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 546ed02..587ee0e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -888,6 +888,16 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 	return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
 }
 
+static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+
+	/* use maximum timeout counter */
+	sdhci_writeb(host, esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
+			SDHCI_TIMEOUT_CONTROL);
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -899,6 +909,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_max_timeout_count = esdhc_get_max_timeout_count,
 	.get_ro = esdhc_pltfm_get_ro,
+	.set_timeout = esdhc_set_timeout,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
 	.reset = esdhc_reset,
-- 
1.7.8

