From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: avoid writing power control register
Date: Fri, 16 Oct 2015 15:44:03 +0800
Message-ID: <1444981443-38869-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0133.outbound.protection.outlook.com ([65.55.169.133]:29328
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752792AbbJPHud (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Oct 2015 03:50:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

The eSDHC doesn't have a standard power control register, so when
writing this register in stack we should do nothing to avoid
incorrect operation.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7b9282b..90e94a0 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -183,6 +183,12 @@ static u32 esdhc_writeb_fixup(struct sdhci_host *host,
 	int shift = (spec_reg & 0x3) * 8;
 
 	/*
+	 * eSDHC doesn't have a standard power control register, so we do
+	 * nothing here to avoid incorrect operation.
+	 */
+	if (spec_reg == SDHCI_POWER_CONTROL)
+		return old_value;
+	/*
 	 * "DMA select" location is offset 0x28 in SD specification, but on
 	 * P5020 or P3041, it's located at 0x29.
 	 */
-- 
2.1.0.27.g96db324

