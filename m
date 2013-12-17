From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 4/5] mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
Date: Tue, 17 Dec 2013 16:16:30 +0800
Message-ID: <1387268191-19859-5-git-send-email-b29396@freescale.com>
References: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:38373
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293Ab3LQIqJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 03:46:09 -0500
In-Reply-To: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

The default sdhci driver write 0xE into timeout counter register to
set the maximum timeout. The value is not correct for uSDHC since the
max counter value for uSDHC is 0xF.
Instead of using common timeout code in sdhci, we implement esdhc_set_timeout
to handle the difference between eSDHC and uSDHC.

Currently we simply set the max timeout value as before.
But in the future, we probably may implement IMX specific timeout
setting algorithm and use suitable timeout for different CMDs.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5d9b56d..2a04847 100644
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
@@ -901,6 +911,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_bus_width = esdhc_pltfm_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
 	.get_max_timeout_count = esdhc_get_max_timeout_count,
+	.set_timeout = esdhc_set_timeout,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-- 
1.7.2.rc3


