From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 3/6] mmc: sdhci: apply both LE and BE mode support to sdhci-of-hwld
Date: Fri, 8 May 2015 14:50:34 +0800
Message-ID: <1431067834-41420-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0141.outbound.protection.outlook.com ([157.56.110.141]:4832
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751679AbbEHGyP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 May 2015 02:54:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v3:
	- Modified the commit message
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

