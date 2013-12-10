From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 6/6] mmc: sdhci-esdhc-imx: use actual_clock to calculate timeout
Date: Tue, 10 Dec 2013 20:56:08 +0800
Message-ID: <1386680168-5227-7-git-send-email-b29396@freescale.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:6302 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376Ab3LJNYT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 08:24:19 -0500
In-Reply-To: <1386680168-5227-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

The timeout clock for uSDHC is SDCLK, so it's reasonable to use
the actual_clock to calculate the max timeout.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c24cb23..83236d3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -865,7 +865,8 @@ unsigned int esdhc_get_max_timeout(struct sdhci_host *host)
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 	u32 max_to = esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
 
-	return max_to / (esdhc_pltfm_get_max_clock(host) / 1000);
+	return host->mmc->actual_clock ?
+			max_to / (host->mmc->actual_clock / 1000) : 0;
 }
 
 void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
-- 
1.7.2.rc3


