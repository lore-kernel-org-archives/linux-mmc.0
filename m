From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 3/6] mmc: sdhci: make max-frequency property in device tree work
Date: Thu, 18 Jun 2015 02:05:34 +0800
Message-ID: <1434564337-24720-4-git-send-email-aisheng.dong@freescale.com>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0140.outbound.protection.outlook.com ([157.56.110.140]:15036
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757304AbbFQSIY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jun 2015 14:08:24 -0400
In-Reply-To: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, fabio.estevam@freescale.com, gwenhael.goavec-merou@armadeus.com, marex@denx.de, s.trumtrar@pengutronix.de, s.hauer@pengutronix.de, lisovy@gmail.com, ipaton0@gmail.com, smoch@web.de, hs@denx.de, rmk+kernel@arm.linux.org.uk, tharvey@gateworks.com, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, p.zabel@pengutronix.de, robertcnelson@gmail.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org

Device tree provides option to specify the max freqency with property
"max-frequency" in dts and common parse function mmc_of_parse() will
parse it and use this value to set host->f_max to tell the MMC core
the maxinum frequency the host works.

However, current sdhci driver will finally overwrite this value with
host->max_clk regardless of the max-frequency property.

This patch makes sure not overwrite the max-frequency set from device
tree and do basic sanity check.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/mmc/host/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bc14452..0781c92 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2866,6 +2866,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	u32 max_current_caps;
 	unsigned int ocr_avail;
 	unsigned int override_timeout_clk;
+	u32 max_clk;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -3047,18 +3048,22 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
-	mmc->f_max = host->max_clk;
+	max_clk = host->max_clk;
+
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else if (host->version >= SDHCI_SPEC_300) {
 		if (host->clk_mul) {
 			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
-			mmc->f_max = host->max_clk * host->clk_mul;
+			max_clk = host->max_clk * host->clk_mul;
 		} else
 			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
+	if (!mmc->f_max || (mmc->f_max && (mmc->f_max > max_clk)))
+		mmc->f_max = max_clk;
+
 	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
 		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
 					SDHCI_TIMEOUT_CLK_SHIFT;
-- 
1.9.1

