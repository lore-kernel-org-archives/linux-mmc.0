From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 2/5] mmc: sdhci-esdhc-imx: fix incorrect max_discard_to for uSDHC
Date: Tue, 17 Dec 2013 16:16:28 +0800
Message-ID: <1387268191-19859-3-git-send-email-b29396@freescale.com>
References: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:1404 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751118Ab3LQIqA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 03:46:00 -0500
In-Reply-To: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

The default sdhci code use the 1 << 27 as the max timeout counter to
to calculate the max_discard_to, however it's not correct for uSDHC
since its the max counter is 1 << 28.
Implement esdhc_get_max_timeout to handle it correctly.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index de2655e..5d9b56d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -880,6 +880,14 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	return esdhc_change_pinstate(host, uhs);
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
@@ -892,6 +900,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_ro = esdhc_pltfm_get_ro,
 	.platform_bus_width = esdhc_pltfm_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
+	.get_max_timeout_count = esdhc_get_max_timeout_count,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-- 
1.7.2.rc3


