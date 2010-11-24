From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/5 v2] mmc: sh_mmcif: cosmetic clean up
Date: Wed, 24 Nov 2010 11:05:18 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011241052030.18622@axis700.grange>
References: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Replace pr_* with respective dev_*, sort headers alphabetically, remove an
unused struct member, superfluous variable initialisations and type-casts.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: no change

 drivers/mmc/host/sh_mmcif.c |   63 ++++++++++++++++++++----------------------
 1 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index c9eaab2..51a0160 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -18,15 +18,15 @@
 
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/platform_device.h>
 
 #define DRIVER_NAME	"sh_mmcif"
 #define DRIVER_VERSION	"2010-04-28"
@@ -177,7 +177,6 @@
 struct sh_mmcif_host {
 	struct mmc_host *mmc;
 	struct mmc_data *data;
-	struct mmc_command *cmd;
 	struct platform_device *pd;
 	struct clk *hclk;
 	unsigned int clk;
@@ -243,8 +242,8 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 
 	state1 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1);
 	state2 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS2);
-	pr_debug("%s: ERR HOST_STS1 = %08x\n", DRIVER_NAME, state1);
-	pr_debug("%s: ERR HOST_STS2 = %08x\n", DRIVER_NAME, state2);
+	dev_dbg(&host->pd->dev, "ERR HOST_STS1 = %08x\n", state1);
+	dev_dbg(&host->pd->dev, "ERR HOST_STS2 = %08x\n", state2);
 
 	if (state1 & STS1_CMDSEQ) {
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, CMD_CTRL_BREAK);
@@ -252,8 +251,8 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 		while (1) {
 			timeout--;
 			if (timeout < 0) {
-				pr_err(DRIVER_NAME": Forceed end of " \
-					"command sequence timeout err\n");
+				dev_err(&host->pd->dev,
+					"Forceed end of command sequence timeout err\n");
 				return -EIO;
 			}
 			if (!(sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1)
@@ -262,18 +261,18 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 			mdelay(1);
 		}
 		sh_mmcif_sync_reset(host);
-		pr_debug(DRIVER_NAME": Forced end of command sequence\n");
+		dev_dbg(&host->pd->dev, "Forced end of command sequence\n");
 		return -EIO;
 	}
 
 	if (state2 & STS2_CRC_ERR) {
-		pr_debug(DRIVER_NAME": Happened CRC error\n");
+		dev_dbg(&host->pd->dev, ": Happened CRC error\n");
 		ret = -EIO;
 	} else if (state2 & STS2_TIMEOUT_ERR) {
-		pr_debug(DRIVER_NAME": Happened Timeout error\n");
+		dev_dbg(&host->pd->dev, ": Happened Timeout error\n");
 		ret = -ETIMEDOUT;
 	} else {
-		pr_debug(DRIVER_NAME": Happened End/Index error\n");
+		dev_dbg(&host->pd->dev, ": Happened End/Index error\n");
 		ret = -EIO;
 	}
 	return ret;
@@ -437,7 +436,7 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 		tmp |= CMD_SET_RTYP_17B;
 		break;
 	default:
-		pr_err(DRIVER_NAME": Not support type response.\n");
+		dev_err(&host->pd->dev, "Unsupported response type.\n");
 		break;
 	}
 	switch (opc) {
@@ -465,7 +464,7 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 			tmp |= CMD_SET_DATW_8;
 			break;
 		default:
-			pr_err(DRIVER_NAME": Not support bus width.\n");
+			dev_err(&host->pd->dev, "Unsupported bus width.\n");
 			break;
 		}
 	}
@@ -493,10 +492,10 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 	return opc = ((opc << 24) | tmp);
 }
 
-static u32 sh_mmcif_data_trans(struct sh_mmcif_host *host,
+static int sh_mmcif_data_trans(struct sh_mmcif_host *host,
 				struct mmc_request *mrq, u32 opc)
 {
-	u32 ret;
+	int ret;
 
 	switch (opc) {
 	case MMC_READ_MULTIPLE_BLOCK:
@@ -513,7 +512,7 @@ static u32 sh_mmcif_data_trans(struct sh_mmcif_host *host,
 		ret = sh_mmcif_single_read(host, mrq);
 		break;
 	default:
-		pr_err(DRIVER_NAME": NOT SUPPORT CMD = d'%08d\n", opc);
+		dev_err(&host->pd->dev, "UNSUPPORTED CMD = d'%08d\n", opc);
 		ret = -EINVAL;
 		break;
 	}
@@ -527,8 +526,6 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	int ret = 0, mask = 0;
 	u32 opc = cmd->opcode;
 
-	host->cmd = cmd;
-
 	switch (opc) {
 	/* respons busy check */
 	case MMC_SWITCH:
@@ -576,8 +573,8 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 			cmd->error = -ETIMEDOUT;
 			break;
 		default:
-			pr_debug("%s: Cmd(d'%d) err\n",
-					DRIVER_NAME, cmd->opcode);
+			dev_dbg(&host->pd->dev, "Cmd(d'%d) err\n",
+					cmd->opcode);
 			cmd->error = sh_mmcif_error_manage(host);
 			break;
 		}
@@ -585,7 +582,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 		return;
 	}
 	if (!(cmd->flags & MMC_RSP_PRESENT)) {
-		cmd->error = ret;
+		cmd->error = 0;
 		return;
 	}
 	sh_mmcif_get_response(host, cmd);
@@ -610,7 +607,7 @@ static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
 	else if (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK)
 		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MCMD12RBE);
 	else {
-		pr_err(DRIVER_NAME": not support stop cmd\n");
+		dev_err(&host->pd->dev, "unsupported stop cmd\n");
 		cmd->error = sh_mmcif_error_manage(host);
 		return;
 	}
@@ -746,14 +743,14 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
 		err = 1;
 	} else {
-		pr_debug("%s: Not support int\n", DRIVER_NAME);
+		dev_dbg(&host->pd->dev, "Not support int\n");
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
 		err = 1;
 	}
 	if (err) {
 		host->sd_error = true;
-		pr_debug("%s: int err state = %08x\n", DRIVER_NAME, state);
+		dev_dbg(&host->pd->dev, "int err state = %08x\n", state);
 	}
 	if (state & ~(INT_CMD12RBE | INT_CMD12CRE))
 		complete(&host->intr_wait);
@@ -767,8 +764,8 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 {
 	int ret = 0, irq[2];
 	struct mmc_host *mmc;
-	struct sh_mmcif_host *host = NULL;
-	struct sh_mmcif_plat_data *pd = NULL;
+	struct sh_mmcif_host *host;
+	struct sh_mmcif_plat_data *pd;
 	struct resource *res;
 	void __iomem *reg;
 	char clk_name[8];
@@ -776,7 +773,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 	if (irq[0] < 0 || irq[1] < 0) {
-		pr_err(DRIVER_NAME": Get irq error\n");
+		dev_err(&pdev->dev, "Get irq error\n");
 		return -ENXIO;
 	}
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -789,7 +786,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "ioremap error.\n");
 		return -ENOMEM;
 	}
-	pd = (struct sh_mmcif_plat_data *)(pdev->dev.platform_data);
+	pd = pdev->dev.platform_data;
 	if (!pd) {
 		dev_err(&pdev->dev, "sh_mmcif plat data error.\n");
 		ret = -ENXIO;
@@ -844,21 +841,21 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	ret = request_irq(irq[0], sh_mmcif_intr, 0, "sh_mmc:error", host);
 	if (ret) {
-		pr_err(DRIVER_NAME": request_irq error (sh_mmc:error)\n");
+		dev_err(&pdev->dev, "request_irq error (sh_mmc:error)\n");
 		goto clean_up2;
 	}
 	ret = request_irq(irq[1], sh_mmcif_intr, 0, "sh_mmc:int", host);
 	if (ret) {
 		free_irq(irq[0], host);
-		pr_err(DRIVER_NAME": request_irq error (sh_mmc:int)\n");
+		dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
 		goto clean_up2;
 	}
 
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 	sh_mmcif_detect(host->mmc);
 
-	pr_info("%s: driver version %s\n", DRIVER_NAME, DRIVER_VERSION);
-	pr_debug("%s: chip ver H'%04x\n", DRIVER_NAME,
+	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
+	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
-- 
1.7.2.3

