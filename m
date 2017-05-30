From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 2/5] mmc: tmio: use EXPORT_SYMBOL_GPL
Date: Tue, 30 May 2017 14:50:51 +0200
Message-ID: <1496148654-20386-3-git-send-email-horms+renesas@verge.net.au>
References: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Use EXPORT_SYMBOL_GPL rather than the non _GPL variant as there seems to be
no reason not to.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/tmio_mmc_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index e1ad461c4b8c..242d9bcc365a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -91,14 +91,14 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 	host->sdcard_irq_mask &= ~(i & TMIO_MASK_IRQ);
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
 }
-EXPORT_SYMBOL(tmio_mmc_enable_mmc_irqs);
+EXPORT_SYMBOL_GPL(tmio_mmc_enable_mmc_irqs);
 
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	host->sdcard_irq_mask |= (i & TMIO_MASK_IRQ);
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
 }
-EXPORT_SYMBOL(tmio_mmc_disable_mmc_irqs);
+EXPORT_SYMBOL_GPL(tmio_mmc_disable_mmc_irqs);
 
 static void tmio_mmc_ack_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
@@ -562,7 +562,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 
 	schedule_work(&host->done);
 }
-EXPORT_SYMBOL(tmio_mmc_do_data_irq);
+EXPORT_SYMBOL_GPL(tmio_mmc_do_data_irq);
 
 static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 {
@@ -766,7 +766,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 
 	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL(tmio_mmc_irq);
+EXPORT_SYMBOL_GPL(tmio_mmc_irq);
 
 static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	struct mmc_data *data)
@@ -1189,13 +1189,13 @@ tmio_mmc_host_alloc(struct platform_device *pdev)
 
 	return host;
 }
-EXPORT_SYMBOL(tmio_mmc_host_alloc);
+EXPORT_SYMBOL_GPL(tmio_mmc_host_alloc);
 
 void tmio_mmc_host_free(struct tmio_mmc_host *host)
 {
 	mmc_free_host(host->mmc);
 }
-EXPORT_SYMBOL(tmio_mmc_host_free);
+EXPORT_SYMBOL_GPL(tmio_mmc_host_free);
 
 int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 			struct tmio_mmc_data *pdata,
@@ -1338,7 +1338,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	return 0;
 }
-EXPORT_SYMBOL(tmio_mmc_host_probe);
+EXPORT_SYMBOL_GPL(tmio_mmc_host_probe);
 
 void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 {
@@ -1363,7 +1363,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 
 	tmio_mmc_clk_disable(host);
 }
-EXPORT_SYMBOL(tmio_mmc_host_remove);
+EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
 #ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev)
@@ -1380,7 +1380,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(tmio_mmc_host_runtime_suspend);
+EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_suspend);
 
 static bool tmio_mmc_can_retune(struct tmio_mmc_host *host)
 {
@@ -1405,7 +1405,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
+EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
 #endif
 
 MODULE_LICENSE("GPL v2");
-- 
2.1.4
