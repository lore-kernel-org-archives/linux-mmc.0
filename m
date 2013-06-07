From: Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [RFC PATCH 29/50] mmc: atmel-mci: prepare clk before calling enable
Date: Fri,  7 Jun 2013 18:26:31 +0200
Message-ID: <1370622391-19654-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Boris BREZILLON <b.brezillon@overkiz.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/mmc/host/atmel-mci.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e75774f..99c2fcc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -380,6 +380,8 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 {
 	struct atmel_mci	*host = s->private;
 	u32			*buf;
+	int			ret;
+
 
 	buf = kmalloc(ATMCI_REGS_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -391,7 +393,11 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	 * consistent.
 	 */
 	spin_lock_bh(&host->lock);
-	clk_enable(host->mck);
+	ret = clk_enable(host->mck);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
 	memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
 	clk_disable(host->mck);
 	spin_unlock_bh(&host->lock);
@@ -2379,7 +2385,9 @@ static int __init atmci_probe(struct platform_device *pdev)
 	if (!host->regs)
 		goto err_ioremap;
 
-	clk_enable(host->mck);
+	ret = clk_prepare_enable(host->mck);
+	if (ret)
+		goto err_clk_prepare_enable;
 	atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 	host->bus_hz = clk_get_rate(host->mck);
 	clk_disable(host->mck);
@@ -2463,6 +2471,8 @@ err_init_slot:
 		dma_release_channel(host->dma.chan);
 	free_irq(irq, host);
 err_request_irq:
+	clk_unprepare(host->mck);
+err_clk_prepare_enable:
 	iounmap(host->regs);
 err_ioremap:
 	clk_put(host->mck);
@@ -2491,7 +2501,7 @@ static int __exit atmci_remove(struct platform_device *pdev)
 	atmci_writel(host, ATMCI_IDR, ~0UL);
 	atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIDIS);
 	atmci_readl(host, ATMCI_SR);
-	clk_disable(host->mck);
+	clk_disable_unprepare(host->mck);
 
 	if (host->dma.chan)
 		dma_release_channel(host->dma.chan);
-- 
1.7.9.5
