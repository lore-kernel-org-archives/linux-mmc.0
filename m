From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/4 v2] mmc: sh_mmcif: cosmetic clean up
Date: Wed, 14 Dec 2011 19:31:52 +0100
Message-ID: <1323887514-12650-3-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch doesn't introduce any functional changes, it only simplifies
some code fragments, removes superfluous parameters, fixes typos.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   79 ++++++++++++++++++------------------------
 1 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 63559d6..d6a534c 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -123,6 +123,11 @@
 #define MASK_MRBSYTO		(1 << 1)
 #define MASK_MRSPTO		(1 << 0)
 
+#define MASK_START_CMD		(MASK_MCMDVIO | MASK_MBUFVIO | MASK_MWDATERR | \
+				 MASK_MRDATERR | MASK_MRIDXERR | MASK_MRSPERR | \
+				 MASK_MCCSTO | MASK_MCRCSTO | MASK_MWDATTO | \
+				 MASK_MRDATTO | MASK_MRBSYTO | MASK_MRSPTO)
+
 /* CE_HOST_STS1 */
 #define STS1_CMDSEQ		(1 << 31)
 
@@ -173,8 +178,8 @@ struct sh_mmcif_host {
 	long timeout;
 	void __iomem *addr;
 	struct completion intr_wait;
+	spinlock_t lock;		/* protect sh_mmcif_host::state */
 	enum mmcif_state state;
-	spinlock_t lock;
 	bool power;
 	bool card_present;
 
@@ -409,7 +414,7 @@ static void sh_mmcif_sync_reset(struct sh_mmcif_host *host)
 static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 {
 	u32 state1, state2;
-	int ret, timeout = 10000000;
+	int ret, timeout;
 
 	host->sd_error = false;
 
@@ -421,31 +426,30 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	if (state1 & STS1_CMDSEQ) {
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, CMD_CTRL_BREAK);
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, ~CMD_CTRL_BREAK);
-		while (1) {
-			timeout--;
-			if (timeout < 0) {
-				dev_err(&host->pd->dev,
-					"Forceed end of command sequence timeout err\n");
-				return -EIO;
-			}
+		for (timeout = 10000000; timeout; timeout--) {
 			if (!(sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1)
-								& STS1_CMDSEQ))
+			      & STS1_CMDSEQ))
 				break;
 			mdelay(1);
 		}
+		if (!timeout) {
+			dev_err(&host->pd->dev,
+				"Forced end of command sequence timeout err\n");
+			return -EIO;
+		}
 		sh_mmcif_sync_reset(host);
 		dev_dbg(&host->pd->dev, "Forced end of command sequence\n");
 		return -EIO;
 	}
 
 	if (state2 & STS2_CRC_ERR) {
-		dev_dbg(&host->pd->dev, ": Happened CRC error\n");
+		dev_dbg(&host->pd->dev, ": CRC error\n");
 		ret = -EIO;
 	} else if (state2 & STS2_TIMEOUT_ERR) {
-		dev_dbg(&host->pd->dev, ": Happened Timeout error\n");
+		dev_dbg(&host->pd->dev, ": Timeout\n");
 		ret = -ETIMEDOUT;
 	} else {
-		dev_dbg(&host->pd->dev, ": Happened End/Index error\n");
+		dev_dbg(&host->pd->dev, ": End/Index error\n");
 		ret = -EIO;
 	}
 	return ret;
@@ -668,55 +672,44 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 static int sh_mmcif_data_trans(struct sh_mmcif_host *host,
 				struct mmc_request *mrq, u32 opc)
 {
-	int ret;
-
 	switch (opc) {
 	case MMC_READ_MULTIPLE_BLOCK:
-		ret = sh_mmcif_multi_read(host, mrq);
-		break;
+		return sh_mmcif_multi_read(host, mrq);
 	case MMC_WRITE_MULTIPLE_BLOCK:
-		ret = sh_mmcif_multi_write(host, mrq);
-		break;
+		return sh_mmcif_multi_write(host, mrq);
 	case MMC_WRITE_BLOCK:
-		ret = sh_mmcif_single_write(host, mrq);
-		break;
+		return sh_mmcif_single_write(host, mrq);
 	case MMC_READ_SINGLE_BLOCK:
 	case MMC_SEND_EXT_CSD:
-		ret = sh_mmcif_single_read(host, mrq);
-		break;
+		return sh_mmcif_single_read(host, mrq);
 	default:
 		dev_err(&host->pd->dev, "UNSUPPORTED CMD = d'%08d\n", opc);
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	return ret;
 }
 
 static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
-			struct mmc_request *mrq, struct mmc_command *cmd)
+			       struct mmc_request *mrq)
 {
+	struct mmc_command *cmd = mrq->cmd;
 	long time;
-	int ret = 0, mask = 0;
-	u32 opc = cmd->opcode;
+	int ret = 0;
+	u32 mask, opc = cmd->opcode;
 
 	switch (opc) {
-	/* respons busy check */
+	/* response busy check */
 	case MMC_SWITCH:
 	case MMC_STOP_TRANSMISSION:
 	case MMC_SET_WRITE_PROT:
 	case MMC_CLR_WRITE_PROT:
 	case MMC_ERASE:
 	case MMC_GEN_CMD:
-		mask = MASK_MRBSYE;
+		mask = MASK_START_CMD | MASK_MRBSYE;
 		break;
 	default:
-		mask = MASK_MCRSPE;
+		mask = MASK_START_CMD | MASK_MCRSPE;
 		break;
 	}
-	mask |=	MASK_MCMDVIO | MASK_MBUFVIO | MASK_MWDATERR |
-		MASK_MRDATERR | MASK_MRIDXERR | MASK_MRSPERR |
-		MASK_MCCSTO | MASK_MCRCSTO | MASK_MWDATTO |
-		MASK_MRDATTO | MASK_MRBSYTO | MASK_MRSPTO;
 
 	if (host->data) {
 		sh_mmcif_writel(host->addr, MMCIF_CE_BLOCK_SET, 0);
@@ -784,8 +777,9 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 }
 
 static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
-		struct mmc_request *mrq, struct mmc_command *cmd)
+			      struct mmc_request *mrq)
 {
+	struct mmc_command *cmd = mrq->stop;
 	long time;
 
 	if (mrq->cmd->opcode == MMC_READ_MULTIPLE_BLOCK)
@@ -854,11 +848,11 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 				sh_mmcif_start_dma_tx(host);
 		}
 	}
-	sh_mmcif_start_cmd(host, mrq, mrq->cmd);
+	sh_mmcif_start_cmd(host, mrq);
 	host->data = NULL;
 
 	if (!mrq->cmd->error && mrq->stop)
-		sh_mmcif_stop_cmd(host, mrq, mrq->stop);
+		sh_mmcif_stop_cmd(host, mrq);
 	host->state = STATE_IDLE;
 	mmc_request_done(mmc, mrq);
 }
@@ -935,11 +929,6 @@ static struct mmc_host_ops sh_mmcif_ops = {
 	.get_cd		= sh_mmcif_get_cd,
 };
 
-static void sh_mmcif_detect(struct mmc_host *mmc)
-{
-	mmc_detect_change(mmc, 0);
-}
-
 static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 {
 	struct sh_mmcif_host *host = dev_id;
@@ -1101,7 +1090,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		goto clean_up3;
 	}
 
-	sh_mmcif_detect(host->mmc);
+	mmc_detect_change(host->mmc, 0);
 
 	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
 	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
-- 
1.7.2.5

