From: Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH v2 2/4] mmc: atmel-mci: prepare clk before calling enable
Date: Tue, 25 Jun 2013 10:11:31 +0200
Message-ID: <1372147891-4296-1-git-send-email-b.brezillon@overkiz.com>
References: <1372147702-4074-1-git-send-email-b.brezillon@overkiz.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:48238 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751766Ab3FYILn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jun 2013 04:11:43 -0400
Received: from mail435.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 3E471FF8E0C
	for <linux-mmc@vger.kernel.org>; Tue, 25 Jun 2013 10:11:42 +0200 (CEST)
In-Reply-To: <1372147702-4074-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Boris BREZILLON <b.brezillon@overkiz.com>

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/mmc/host/atmel-mci.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e75774f..631c4cf 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -380,6 +380,8 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 {
 	struct atmel_mci	*host = s->private;
 	u32			*buf;
+	int			ret = 0;
+
 
 	buf = kmalloc(ATMCI_REGS_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -391,9 +393,13 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	 * consistent.
 	 */
 	spin_lock_bh(&host->lock);
-	clk_enable(host->mck);
+	ret = clk_prepare_enable(host->mck);
+	if (ret) {
+		spin_unlock_bh(&host->lock);
+		goto out;
+	}
 	memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
-	clk_disable(host->mck);
+	clk_disable_unprepare(host->mck);
 	spin_unlock_bh(&host->lock);
 
 	seq_printf(s, "MR:\t0x%08x%s%s ",
@@ -444,9 +450,10 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 				val & ATMCI_CFG_LSYNC ? " LSYNC" : "");
 	}
 
+out:
 	kfree(buf);
 
-	return 0;
+	return ret;
 }
 
 static int atmci_regs_open(struct inode *inode, struct file *file)
@@ -1281,7 +1288,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		spin_lock_bh(&host->lock);
 		if (!host->mode_reg) {
-			clk_enable(host->mck);
+			clk_prepare_enable(host->mck);
 			atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 			atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
 			if (host->caps.has_cfg_reg)
@@ -1361,7 +1368,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIDIS);
 			if (host->mode_reg) {
 				atmci_readl(host, ATMCI_MR);
-				clk_disable(host->mck);
+				clk_disable_unprepare(host->mck);
 			}
 			host->mode_reg = 0;
 		}
@@ -2379,10 +2386,12 @@ static int __init atmci_probe(struct platform_device *pdev)
 	if (!host->regs)
 		goto err_ioremap;
 
-	clk_enable(host->mck);
+	ret = clk_prepare_enable(host->mck);
+	if (ret)
+		goto err_request_irq;
 	atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 	host->bus_hz = clk_get_rate(host->mck);
-	clk_disable(host->mck);
+	clk_disable_unprepare(host->mck);
 
 	host->mapbase = regs->start;
 
@@ -2487,11 +2496,11 @@ static int __exit atmci_remove(struct platform_device *pdev)
 			atmci_cleanup_slot(host->slot[i], i);
 	}
 
-	clk_enable(host->mck);
+	clk_prepare_enable(host->mck);
 	atmci_writel(host, ATMCI_IDR, ~0UL);
 	atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIDIS);
 	atmci_readl(host, ATMCI_SR);
-	clk_disable(host->mck);
+	clk_disable_unprepare(host->mck);
 
 	if (host->dma.chan)
 		dma_release_channel(host->dma.chan);
-- 
1.7.9.5

