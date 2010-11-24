From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/5 v2] mmc: sh_mmcif: switch to completion, fix flags
Date: Wed, 24 Nov 2010 11:05:12 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011241050310.18622@axis700.grange>
References: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

In sh_mmcif.c an event is used as a completion, switch over. When a
wait_for_completion*_timeout() returns, it suffices to check the remaining
time, setting an additional flag before waking up the waiting task only reduces
the race window, but does not eliminate it. This patch switches the driver to
use a completion to signal an interrupt, the only case, when an interrupt
should not wake up the waiter, is when an automatic CMD12 completes. Also fix
MODULE_ALIAS.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: no change

 drivers/mmc/host/sh_mmcif.c |  117 +++++++++++++++++--------------------------
 1 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index ddd0984..c9eaab2 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -16,6 +16,8 @@
  *
  */
 
+#include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -24,7 +26,6 @@
 #include <linux/mmc/sdio.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
 #include <linux/mmc/sh_mmcif.h>
 
 #define DRIVER_NAME	"sh_mmcif"
@@ -181,11 +182,10 @@ struct sh_mmcif_host {
 	struct clk *hclk;
 	unsigned int clk;
 	int bus_width;
-	u16 wait_int;
-	u16 sd_error;
+	bool sd_error;
 	long timeout;
 	void __iomem *addr;
-	wait_queue_head_t intr_wait;
+	struct completion intr_wait;
 };
 
 
@@ -239,8 +239,7 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	u32 state1, state2;
 	int ret, timeout = 10000000;
 
-	host->sd_error = 0;
-	host->wait_int = 0;
+	host->sd_error = false;
 
 	state1 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1);
 	state2 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS2);
@@ -287,17 +286,13 @@ static int sh_mmcif_single_read(struct sh_mmcif_host *host,
 	long time;
 	u32 blocksize, i, *p = sg_virt(data->sg);
 
-	host->wait_int = 0;
-
 	/* buf read enable */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
-	time = wait_event_interruptible_timeout(host->intr_wait,
-			host->wait_int == 1 ||
-			host->sd_error == 1, host->timeout);
-	if (host->wait_int != 1 && (time == 0 || host->sd_error != 0))
+	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
+			host->timeout);
+	if (time <= 0 || host->sd_error)
 		return sh_mmcif_error_manage(host);
 
-	host->wait_int = 0;
 	blocksize = (BLOCK_SIZE_MASK &
 			sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET)) + 3;
 	for (i = 0; i < blocksize / 4; i++)
@@ -305,13 +300,11 @@ static int sh_mmcif_single_read(struct sh_mmcif_host *host,
 
 	/* buffer read end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
-	time = wait_event_interruptible_timeout(host->intr_wait,
-			host->wait_int == 1 ||
-			host->sd_error == 1, host->timeout);
-	if (host->wait_int != 1 && (time == 0 || host->sd_error != 0))
+	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
+			host->timeout);
+	if (time <= 0 || host->sd_error)
 		return sh_mmcif_error_manage(host);
 
-	host->wait_int = 0;
 	return 0;
 }
 
@@ -326,19 +319,15 @@ static int sh_mmcif_multi_read(struct sh_mmcif_host *host,
 						     MMCIF_CE_BLOCK_SET);
 	for (j = 0; j < data->sg_len; j++) {
 		p = sg_virt(data->sg);
-		host->wait_int = 0;
 		for (sec = 0; sec < data->sg->length / blocksize; sec++) {
 			sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 			/* buf read enable */
-			time = wait_event_interruptible_timeout(host->intr_wait,
-				host->wait_int == 1 ||
-				host->sd_error == 1, host->timeout);
+			time = wait_for_completion_interruptible_timeout(&host->intr_wait,
+				host->timeout);
 
-			if (host->wait_int != 1 &&
-			    (time == 0 || host->sd_error != 0))
+			if (time <= 0 || host->sd_error)
 				return sh_mmcif_error_manage(host);
 
-			host->wait_int = 0;
 			for (i = 0; i < blocksize / 4; i++)
 				*p++ = sh_mmcif_readl(host->addr,
 						      MMCIF_CE_DATA);
@@ -356,17 +345,14 @@ static int sh_mmcif_single_write(struct sh_mmcif_host *host,
 	long time;
 	u32 blocksize, i, *p = sg_virt(data->sg);
 
-	host->wait_int = 0;
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 
 	/* buf write enable */
-	time = wait_event_interruptible_timeout(host->intr_wait,
-			host->wait_int == 1 ||
-			host->sd_error == 1, host->timeout);
-	if (host->wait_int != 1 && (time == 0 || host->sd_error != 0))
+	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
+			host->timeout);
+	if (time <= 0 || host->sd_error)
 		return sh_mmcif_error_manage(host);
 
-	host->wait_int = 0;
 	blocksize = (BLOCK_SIZE_MASK &
 			sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET)) + 3;
 	for (i = 0; i < blocksize / 4; i++)
@@ -375,13 +361,11 @@ static int sh_mmcif_single_write(struct sh_mmcif_host *host,
 	/* buffer write end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
 
-	time = wait_event_interruptible_timeout(host->intr_wait,
-			host->wait_int == 1 ||
-			host->sd_error == 1, host->timeout);
-	if (host->wait_int != 1 && (time == 0 || host->sd_error != 0))
+	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
+			host->timeout);
+	if (time <= 0 || host->sd_error)
 		return sh_mmcif_error_manage(host);
 
-	host->wait_int = 0;
 	return 0;
 }
 
@@ -397,19 +381,15 @@ static int sh_mmcif_multi_write(struct sh_mmcif_host *host,
 
 	for (j = 0; j < data->sg_len; j++) {
 		p = sg_virt(data->sg);
-		host->wait_int = 0;
 		for (sec = 0; sec < data->sg->length / blocksize; sec++) {
 			sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 			/* buf write enable*/
-			time = wait_event_interruptible_timeout(host->intr_wait,
-				host->wait_int == 1 ||
-				host->sd_error == 1, host->timeout);
+			time = wait_for_completion_interruptible_timeout(&host->intr_wait,
+				host->timeout);
 
-			if (host->wait_int != 1 &&
-			    (time == 0 || host->sd_error != 0))
+			if (time <= 0 || host->sd_error)
 				return sh_mmcif_error_manage(host);
 
-			host->wait_int = 0;
 			for (i = 0; i < blocksize / 4; i++)
 				sh_mmcif_writel(host->addr,
 						MMCIF_CE_DATA, *p++);
@@ -579,13 +559,12 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, mask);
 	/* set arg */
 	sh_mmcif_writel(host->addr, MMCIF_CE_ARG, cmd->arg);
-	host->wait_int = 0;
 	/* set cmd */
 	sh_mmcif_writel(host->addr, MMCIF_CE_CMD_SET, opc);
 
-	time = wait_event_interruptible_timeout(host->intr_wait,
-		host->wait_int == 1 || host->sd_error == 1, host->timeout);
-	if (host->wait_int != 1 && time == 0) {
+	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
+		host->timeout);
+	if (time <= 0) {
 		cmd->error = sh_mmcif_error_manage(host);
 		return;
 	}
@@ -602,19 +581,14 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 			cmd->error = sh_mmcif_error_manage(host);
 			break;
 		}
-		host->sd_error = 0;
-		host->wait_int = 0;
+		host->sd_error = false;
 		return;
 	}
 	if (!(cmd->flags & MMC_RSP_PRESENT)) {
 		cmd->error = ret;
-		host->wait_int = 0;
 		return;
 	}
-	if (host->wait_int == 1) {
-		sh_mmcif_get_response(host, cmd);
-		host->wait_int = 0;
-	}
+	sh_mmcif_get_response(host, cmd);
 	if (host->data) {
 		ret = sh_mmcif_data_trans(host, mrq, cmd->opcode);
 		if (ret < 0)
@@ -641,15 +615,13 @@ static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
 		return;
 	}
 
-	time = wait_event_interruptible_timeout(host->intr_wait,
-			host->wait_int == 1 ||
-			host->sd_error == 1, host->timeout);
-	if (host->wait_int != 1 && (time == 0 || host->sd_error != 0)) {
+	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
+			host->timeout);
+	if (time <= 0 || host->sd_error) {
 		cmd->error = sh_mmcif_error_manage(host);
 		return;
 	}
 	sh_mmcif_get_cmd12response(host, cmd);
-	host->wait_int = 0;
 	cmd->error = 0;
 }
 
@@ -735,7 +707,7 @@ static void sh_mmcif_detect(struct mmc_host *mmc)
 static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 {
 	struct sh_mmcif_host *host = dev_id;
-	u32 state = 0;
+	u32 state;
 	int err = 0;
 
 	state = sh_mmcif_readl(host->addr, MMCIF_CE_INT);
@@ -780,11 +752,13 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 		err = 1;
 	}
 	if (err) {
-		host->sd_error = 1;
+		host->sd_error = true;
 		pr_debug("%s: int err state = %08x\n", DRIVER_NAME, state);
 	}
-	host->wait_int = 1;
-	wake_up(&host->intr_wait);
+	if (state & ~(INT_CMD12RBE | INT_CMD12CRE))
+		complete(&host->intr_wait);
+	else
+		dev_dbg(&host->pd->dev, "Unexpected IRQ 0x%x\n", state);
 
 	return IRQ_HANDLED;
 }
@@ -842,7 +816,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	host->clk = clk_get_rate(host->hclk);
 	host->pd = pdev;
 
-	init_waitqueue_head(&host->intr_wait);
+	init_completion(&host->intr_wait);
 
 	mmc->ops = &sh_mmcif_ops;
 	mmc->f_max = host->clk;
@@ -903,20 +877,21 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
 	int irq[2];
 
-	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
-
-	irq[0] = platform_get_irq(pdev, 0);
-	irq[1] = platform_get_irq(pdev, 1);
+	mmc_remove_host(host->mmc);
 
 	if (host->addr)
 		iounmap(host->addr);
 
-	platform_set_drvdata(pdev, NULL);
-	mmc_remove_host(host->mmc);
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
+
+	irq[0] = platform_get_irq(pdev, 0);
+	irq[1] = platform_get_irq(pdev, 1);
 
 	free_irq(irq[0], host);
 	free_irq(irq[1], host);
 
+	platform_set_drvdata(pdev, NULL);
+
 	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
 
@@ -947,5 +922,5 @@ module_exit(sh_mmcif_exit);
 
 MODULE_DESCRIPTION("SuperH on-chip MMC/eMMC interface driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS(DRIVER_NAME);
+MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Yusuke Goda <yusuke.goda.sx@renesas.com>");
-- 
1.7.2.3

