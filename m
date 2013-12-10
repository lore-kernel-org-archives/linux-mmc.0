From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 2/6] mmc: sdhci-esdhc-imx: fix incorrect max_discard_to for uSDHC
Date: Tue, 10 Dec 2013 20:56:04 +0800
Message-ID: <1386680168-5227-3-git-send-email-b29396@freescale.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:35642
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376Ab3LJNYL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 08:24:11 -0500
In-Reply-To: <1386680168-5227-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

The default sdhci code use the 1 << 27 as the max timeout counter to
to calculate the max_discard_to, however it's not correct for uSDHC
since its the max counter is 1 << 28.
Implement esdhc_get_max_timeout to handle it correctly.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Reported-by: Ed Sutter <ed.sutter@alcatel-lucent.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 461a4c3..97b35e1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -859,6 +859,15 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	return esdhc_change_pinstate(host, uhs);
 }
 
+unsigned int esdhc_get_max_timeout(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	u32 max_to = esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
+
+	return max_to / (esdhc_pltfm_get_max_clock(host) / 1000);
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -871,6 +880,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_ro = esdhc_pltfm_get_ro,
 	.platform_bus_width = esdhc_pltfm_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
+	.get_max_timeout = esdhc_get_max_timeout,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-- 
1.7.2.rc3


