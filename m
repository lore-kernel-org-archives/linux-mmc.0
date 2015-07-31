From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 3/6] mmc: sdhci: apply little-endian mode support to sdhci-of-hwld
Date: Fri, 31 Jul 2015 11:54:40 +0800
Message-ID: <1438314880-47515-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0111.outbound.protection.outlook.com ([65.55.169.111]:55728
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751158AbbGaD7s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jul 2015 23:59:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-hlwd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 4079a96..83d8149 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -35,26 +35,26 @@
 
 static void sdhci_hlwd_writel(struct sdhci_host *host, u32 val, int reg)
 {
-	sdhci_be32bs_writel(host, val, reg);
+	sdhci_32bs_writel(host, val, reg);
 	udelay(SDHCI_HLWD_WRITE_DELAY);
 }
 
 static void sdhci_hlwd_writew(struct sdhci_host *host, u16 val, int reg)
 {
-	sdhci_be32bs_writew(host, val, reg);
+	sdhci_32bs_writew(host, val, reg);
 	udelay(SDHCI_HLWD_WRITE_DELAY);
 }
 
 static void sdhci_hlwd_writeb(struct sdhci_host *host, u8 val, int reg)
 {
-	sdhci_be32bs_writeb(host, val, reg);
+	sdhci_32bs_writeb(host, val, reg);
 	udelay(SDHCI_HLWD_WRITE_DELAY);
 }
 
 static const struct sdhci_ops sdhci_hlwd_ops = {
-	.read_l = sdhci_be32bs_readl,
-	.read_w = sdhci_be32bs_readw,
-	.read_b = sdhci_be32bs_readb,
+	.read_l = sdhci_32bs_readl,
+	.read_w = sdhci_32bs_readw,
+	.read_b = sdhci_32bs_readb,
 	.write_l = sdhci_hlwd_writel,
 	.write_w = sdhci_hlwd_writew,
 	.write_b = sdhci_hlwd_writeb,
-- 
2.1.0.27.g96db324

