From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/6] mmc: sh_mmcif: revision-specific Command Completion Signal handling
Date: Wed, 10 Jul 2013 21:21:12 +0200
Message-ID: <1373484077-10460-2-git-send-email-g.liakhovetski@gmx.de>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Some earlier MMCIF IP revisions contained Command Completion Signal
support, which has been dropped again in modern versions. Sopport for
this feature is added in a way to preserve the current behaviour by
default, i.e. when it is not enabled in platform data. Patch is based
on work by Nobuyuki HIRAI.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/mmc/host/sh_mmcif.c  |   27 +++++++++++++++++++++------
 include/linux/mmc/sh_mmcif.h |    1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 06caaae..7be20c9 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -133,6 +133,8 @@
 				 INT_BUFWEN | INT_CMD12DRE | INT_BUFRE | \
 				 INT_DTRANE | INT_CMD12RBE | INT_CMD12CRE)
 
+#define INT_CCS			(INT_CCSTO | INT_CCSRCV | INT_CCSDE)
+
 /* CE_INT_MASK */
 #define MASK_ALL		0x00000000
 #define MASK_MCCSDE		(1 << 29)
@@ -161,7 +163,7 @@
 
 #define MASK_START_CMD		(MASK_MCMDVIO | MASK_MBUFVIO | MASK_MWDATERR | \
 				 MASK_MRDATERR | MASK_MRIDXERR | MASK_MRSPERR | \
-				 MASK_MCCSTO | MASK_MCRCSTO | MASK_MWDATTO | \
+				 MASK_MCRCSTO | MASK_MWDATTO | \
 				 MASK_MRDATTO | MASK_MRBSYTO | MASK_MRSPTO)
 
 #define MASK_CLEAN		(INT_ERR_STS | MASK_MRBSYE | MASK_MCRSPE |	\
@@ -243,6 +245,7 @@ struct sh_mmcif_host {
 	int sg_blkidx;
 	bool power;
 	bool card_present;
+	bool ccs_enable;		/* Command Completion Signal support */
 	struct mutex thread_lock;
 
 	/* DMA support */
@@ -485,8 +488,10 @@ static void sh_mmcif_sync_reset(struct sh_mmcif_host *host)
 
 	sh_mmcif_writel(host->addr, MMCIF_CE_VERSION, SOFT_RST_ON);
 	sh_mmcif_writel(host->addr, MMCIF_CE_VERSION, SOFT_RST_OFF);
+	if (host->ccs_enable)
+		tmp |= SCCSTO_29;
 	sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, tmp |
-		SRSPTO_256 | SRBSYTO_29 | SRWDTO_29 | SCCSTO_29);
+		SRSPTO_256 | SRBSYTO_29 | SRWDTO_29);
 	/* byte swap on */
 	sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_ATYP);
 }
@@ -866,6 +871,9 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 		break;
 	}
 
+	if (host->ccs_enable)
+		mask |= MASK_MCCSTO;
+
 	if (mrq->data) {
 		sh_mmcif_writel(host->addr, MMCIF_CE_BLOCK_SET, 0);
 		sh_mmcif_writel(host->addr, MMCIF_CE_BLOCK_SET,
@@ -873,7 +881,10 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	}
 	opc = sh_mmcif_set_cmd(host, mrq);
 
-	sh_mmcif_writel(host->addr, MMCIF_CE_INT, 0xD80430C0);
+	if (host->ccs_enable)
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, 0xD80430C0);
+	else
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, 0xD80430C0 | INT_CCS);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, mask);
 	/* set arg */
 	sh_mmcif_writel(host->addr, MMCIF_CE_ARG, cmd->arg);
@@ -1241,11 +1252,14 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 {
 	struct sh_mmcif_host *host = dev_id;
-	u32 state;
+	u32 state, mask;
 
 	state = sh_mmcif_readl(host->addr, MMCIF_CE_INT);
-	sh_mmcif_writel(host->addr, MMCIF_CE_INT,
-			~(state & sh_mmcif_readl(host->addr, MMCIF_CE_INT_MASK)));
+	mask = sh_mmcif_readl(host->addr, MMCIF_CE_INT_MASK);
+	if (host->ccs_enable)
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~(state & mask));
+	else
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, INT_CCS | ~(state & mask));
 	sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state & MASK_CLEAN);
 
 	if (state & ~MASK_CLEAN)
@@ -1375,6 +1389,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	host->mmc	= mmc;
 	host->addr	= reg;
 	host->timeout	= msecs_to_jiffies(1000);
+	host->ccs_enable = !pd || !pd->ccs_unsupported;
 
 	host->pd = pdev;
 
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index e7d5dd6..b2a22b6 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -39,6 +39,7 @@ struct sh_mmcif_plat_data {
 	unsigned int		slave_id_tx;	/* embedded slave_id_[tr]x */
 	unsigned int		slave_id_rx;
 	bool			use_cd_gpio : 1;
+	bool			ccs_unsupported : 1;
 	unsigned int		cd_gpio;
 	u8			sup_pclk;	/* 1 :SH7757, 0: SH7724/SH7372 */
 	unsigned long		caps;
-- 
1.7.2.5

