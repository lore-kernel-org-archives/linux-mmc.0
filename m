From: Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH v4 2/5] mmc: atmel-mci: prepare clk before calling enable
Date: Thu, 18 Jul 2013 09:38:52 +0200
Message-ID: <1374133132-17556-1-git-send-email-b.brezillon@overkiz.com>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:48090 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751325Ab3GRHi7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jul 2013 03:38:59 -0400
Received: from mail604.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 47809FFAD8B
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jul 2013 09:38:58 +0200 (CEST)
In-Reply-To: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Boris BREZILLON <b.brezillon@overkiz.com>

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |   34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index bdb84da..69e438e 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -378,6 +378,8 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 {
 	struct atmel_mci	*host = s->private;
 	u32			*buf;
+	int			ret = 0;
+
 
 	buf = kmalloc(ATMCI_REGS_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -388,12 +390,16 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	 * not disabling interrupts, so IMR and SR may not be
 	 * consistent.
 	 */
+	ret = clk_prepare_enable(host->mck);
+	if (ret)
+		goto out;
+
 	spin_lock_bh(&host->lock);
-	clk_enable(host->mck);
 	memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
-	clk_disable(host->mck);
 	spin_unlock_bh(&host->lock);
 
+	clk_disable_unprepare(host->mck);
+
 	seq_printf(s, "MR:\t0x%08x%s%s ",
 			buf[ATMCI_MR / 4],
 			buf[ATMCI_MR / 4] & ATMCI_MR_RDPROOF ? " RDPROOF" : "",
@@ -442,9 +448,10 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 				val & ATMCI_CFG_LSYNC ? " LSYNC" : "");
 	}
 
+out:
 	kfree(buf);
 
-	return 0;
+	return ret;
 }
 
 static int atmci_regs_open(struct inode *inode, struct file *file)
@@ -1262,6 +1269,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct atmel_mci_slot	*slot = mmc_priv(mmc);
 	struct atmel_mci	*host = slot->host;
 	unsigned int		i;
+	bool			unprepare_clk;
 
 	slot->sdc_reg &= ~ATMCI_SDCBUS_MASK;
 	switch (ios->bus_width) {
@@ -1277,9 +1285,13 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		unsigned int clock_min = ~0U;
 		u32 clkdiv;
 
+		clk_prepare(host->mck);
+		unprepare_clk = true;
+
 		spin_lock_bh(&host->lock);
 		if (!host->mode_reg) {
 			clk_enable(host->mck);
+			unprepare_clk = false;
 			atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 			atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
 			if (host->caps.has_cfg_reg)
@@ -1347,6 +1359,8 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	} else {
 		bool any_slot_active = false;
 
+		unprepare_clk = false;
+
 		spin_lock_bh(&host->lock);
 		slot->clock = 0;
 		for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
@@ -1360,12 +1374,16 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			if (host->mode_reg) {
 				atmci_readl(host, ATMCI_MR);
 				clk_disable(host->mck);
+				unprepare_clk = true;
 			}
 			host->mode_reg = 0;
 		}
 		spin_unlock_bh(&host->lock);
 	}
 
+	if (unprepare_clk)
+		clk_unprepare(host->mck);
+
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		set_bit(ATMCI_CARD_NEED_INIT, &slot->flags);
@@ -2376,10 +2394,12 @@ static int __init atmci_probe(struct platform_device *pdev)
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
 
@@ -2482,11 +2502,11 @@ static int __exit atmci_remove(struct platform_device *pdev)
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

