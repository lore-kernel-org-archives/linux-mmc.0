From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2] mmc: sdhci-brcmstb: Remove incorrect capability
Date: Mon, 29 Aug 2016 18:17:07 +0900
Message-ID: <20160829091707.78436-1-jaedon.shin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34285 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756027AbcH2JRV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2016 05:17:21 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so8652211pac.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2016 02:17:21 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Jaedon Shin <jaedon.shin@gmail.com>

Removes incorrect 64-bit ADMA capability on Broadcom MIPS based SoCs.
The MIPS based BRCMSTB SDHCI host controllers are using ADMA only, but
the several chipsets have a incorrect capability about ADMA 64-bit.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index cce10fe3e19e..683bfc2af512 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -98,6 +98,8 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	 * properties through mmc_of_parse().
 	 */
 	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (IS_ENABLED(CONFIG_MIPS))
+		host->caps &= ~SDHCI_CAN_64BIT;
 	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			SDHCI_SUPPORT_DDR50);
-- 
2.9.3

