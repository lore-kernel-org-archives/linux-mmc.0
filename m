From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] mmc, sh: use a consistent pr_ prefix
Date: Wed, 10 Nov 2010 19:27:44 +0900
Message-ID: <1289384864-6531-1-git-send-email-horms@verge.net.au>
References: <y>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49416 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab0KJK1x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 05:27:53 -0500
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

Use pr_fmt to set the prefix for pr_ messages.
I believe this method is common in other
source files in the kernel tree.

Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mmcif.c |   52 +++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 3f49273..9f37f74 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -16,6 +16,10 @@
  *
  */
 
+#define KMSG_COMPONENT "sh_mmcif"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define DRIVER_VERSION	"2010-04-28"
+
 #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -27,9 +31,6 @@
 #include <linux/clk.h>
 #include <linux/mmc/sh_mmcif.h>
 
-#define DRIVER_NAME	"sh_mmcif"
-#define DRIVER_VERSION	"2010-04-28"
-
 /* CE_CMD_SET */
 #define CMD_MASK		0x3f000000
 #define CMD_SET_RTYP_NO		((0 << 23) | (0 << 22))
@@ -221,8 +222,8 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 
 	state1 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1);
 	state2 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS2);
-	pr_debug("%s: ERR HOST_STS1 = %08x\n", DRIVER_NAME, state1);
-	pr_debug("%s: ERR HOST_STS2 = %08x\n", DRIVER_NAME, state2);
+	pr_debug("ERR HOST_STS1 = %08x\n", state1);
+	pr_debug("ERR HOST_STS2 = %08x\n", state2);
 
 	if (state1 & STS1_CMDSEQ) {
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, CMD_CTRL_BREAK);
@@ -230,7 +231,7 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 		while (1) {
 			timeout--;
 			if (timeout < 0) {
-				pr_err(DRIVER_NAME": Forceed end of " \
+				pr_err("Forceed end of " \
 					"command sequence timeout err\n");
 				return -EIO;
 			}
@@ -240,18 +241,18 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 			mdelay(1);
 		}
 		sh_mmcif_sync_reset(host);
-		pr_debug(DRIVER_NAME": Forced end of command sequence\n");
+		pr_debug("Forced end of command sequence\n");
 		return -EIO;
 	}
 
 	if (state2 & STS2_CRC_ERR) {
-		pr_debug(DRIVER_NAME": Happened CRC error\n");
+		pr_debug("Happened CRC error\n");
 		ret = -EIO;
 	} else if (state2 & STS2_TIMEOUT_ERR) {
-		pr_debug(DRIVER_NAME": Happened Timeout error\n");
+		pr_debug("Happened Timeout error\n");
 		ret = -ETIMEDOUT;
 	} else {
-		pr_debug(DRIVER_NAME": Happened End/Index error\n");
+		pr_debug("Happened End/Index error\n");
 		ret = -EIO;
 	}
 	return ret;
@@ -434,7 +435,7 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 		tmp |= CMD_SET_RTYP_17B;
 		break;
 	default:
-		pr_err(DRIVER_NAME": Not support type response.\n");
+		pr_err("Not support type response.\n");
 		break;
 	}
 	switch (opc) {
@@ -462,7 +463,7 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 			tmp |= CMD_SET_DATW_8;
 			break;
 		default:
-			pr_err(DRIVER_NAME": Not support bus width.\n");
+			pr_err("Not support bus width.\n");
 			break;
 		}
 	}
@@ -510,7 +511,7 @@ static u32 sh_mmcif_data_trans(struct sh_mmcif_host *host,
 		ret = sh_mmcif_single_read(host, mrq);
 		break;
 	default:
-		pr_err(DRIVER_NAME": NOT SUPPORT CMD = d'%08d\n", opc);
+		pr_err("NOT SUPPORT CMD = d'%08d\n", opc);
 		ret = -EINVAL;
 		break;
 	}
@@ -574,8 +575,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 			cmd->error = -ETIMEDOUT;
 			break;
 		default:
-			pr_debug("%s: Cmd(d'%d) err\n",
-					DRIVER_NAME, cmd->opcode);
+			pr_debug("Cmd(d'%d) err\n", cmd->opcode);
 			cmd->error = sh_mmcif_error_manage(host);
 			break;
 		}
@@ -613,7 +613,7 @@ static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
 	else if (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK)
 		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MCMD12RBE);
 	else {
-		pr_err(DRIVER_NAME": not support stop cmd\n");
+		pr_err("not support stop cmd\n");
 		cmd->error = sh_mmcif_error_manage(host);
 		return;
 	}
@@ -751,14 +751,14 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
 		err = 1;
 	} else {
-		pr_debug("%s: Not support int\n", DRIVER_NAME);
+		pr_debug("Not support int\n");
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
 		err = 1;
 	}
 	if (err) {
 		host->sd_error = 1;
-		pr_debug("%s: int err state = %08x\n", DRIVER_NAME, state);
+		pr_debug("int err state = %08x\n", state);
 	}
 	host->wait_int = 1;
 	wake_up(&host->intr_wait);
@@ -779,7 +779,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 	if (irq[0] < 0 || irq[1] < 0) {
-		pr_err(DRIVER_NAME": Get irq error\n");
+		pr_err("Get irq error\n");
 		return -ENXIO;
 	}
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -847,22 +847,22 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	ret = request_irq(irq[0], sh_mmcif_intr, 0, "sh_mmc:error", host);
 	if (ret) {
-		pr_err(DRIVER_NAME": request_irq error (sh_mmc:error)\n");
+		pr_err("request_irq error (sh_mmc:error)\n");
 		goto clean_up2;
 	}
 	ret = request_irq(irq[1], sh_mmcif_intr, 0, "sh_mmc:int", host);
 	if (ret) {
 		free_irq(irq[0], host);
-		pr_err(DRIVER_NAME": request_irq error (sh_mmc:int)\n");
+		pr_err("request_irq error (sh_mmc:int)\n");
 		goto clean_up2;
 	}
 
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 	sh_mmcif_detect(host->mmc);
 
-	pr_info("%s: driver version %s\n", DRIVER_NAME, DRIVER_VERSION);
-	pr_debug("%s: chip ver H'%04x\n", DRIVER_NAME,
-		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
+	pr_info("driver version %s\n", DRIVER_VERSION);
+	pr_debug("chip ver H'%04x\n",
+		 sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
 clean_up2:
@@ -904,7 +904,7 @@ static struct platform_driver sh_mmcif_driver = {
 	.probe		= sh_mmcif_probe,
 	.remove		= sh_mmcif_remove,
 	.driver		= {
-		.name	= DRIVER_NAME,
+		.name	= KMSG_COMPONENT,
 	},
 };
 
@@ -924,5 +924,5 @@ module_exit(sh_mmcif_exit);
 
 MODULE_DESCRIPTION("SuperH on-chip MMC/eMMC interface driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS(DRIVER_NAME);
+MODULE_ALIAS(KMSG_COMPONENT);
 MODULE_AUTHOR("Yusuke Goda <yusuke.goda.sx@renesas.com>");
-- 
1.7.2.3

