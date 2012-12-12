From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] mmc: sh-mmcif: simplify IRQ processing
Date: Wed, 12 Dec 2012 15:45:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1212121540250.10522@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

The classical way to process IRQs is read out the status, ack all triggered
IRQs, possibly mask them, then process them. Follow this simple procesure
instead of the current complex custom algorithm.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Hi Chris

Attention: this patch is __NOT__ for 3.8, please, let it simmer in -next 
until 3.9. It modifies the driver's interrupt handling significantly, so, 
we want to have it tested over a longer period.

Thanks
Guennadi

 drivers/mmc/host/sh_mmcif.c |   65 ++++++++++++------------------------------
 1 files changed, 19 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 90a9255..bbccc12 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -128,6 +128,10 @@
 				 INT_CCSTO | INT_CRCSTO | INT_WDATTO |	  \
 				 INT_RDATTO | INT_RBSYTO | INT_RSPTO)
 
+#define INT_ALL			(INT_RBSYE | INT_CRSPE | INT_BUFREN |	 \
+				 INT_BUFWEN | INT_CMD12DRE | INT_BUFRE | \
+				 INT_DTRANE | INT_CMD12RBE | INT_CMD12CRE)
+
 /* CE_INT_MASK */
 #define MASK_ALL		0x00000000
 #define MASK_MCCSDE		(1 << 29)
@@ -159,6 +163,11 @@
 				 MASK_MCCSTO | MASK_MCRCSTO | MASK_MWDATTO | \
 				 MASK_MRDATTO | MASK_MRBSYTO | MASK_MRSPTO)
 
+#define MASK_CLEAN		(INT_ERR_STS | MASK_MRBSYE | MASK_MCRSPE |	\
+				 MASK_MBUFREN | MASK_MBUFWEN |			\
+				 MASK_MCMD12DRE | MASK_MBUFRE | MASK_MDTRANE |	\
+				 MASK_MCMD12RBE | MASK_MCMD12CRE)
+
 /* CE_HOST_STS1 */
 #define STS1_CMDSEQ		(1 << 31)
 
@@ -1201,58 +1210,22 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 {
 	struct sh_mmcif_host *host = dev_id;
 	u32 state;
-	int err = 0;
 
 	state = sh_mmcif_readl(host->addr, MMCIF_CE_INT);
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
+	sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state & MASK_CLEAN);
 
-	if (state & INT_ERR_STS) {
-		/* error interrupts - process first */
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
-		err = 1;
-	} else if (state & INT_RBSYE) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
-				~(INT_RBSYE | INT_CRSPE));
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MRBSYE);
-	} else if (state & INT_CRSPE) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_CRSPE);
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MCRSPE);
-	} else if (state & INT_BUFREN) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFREN);
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
-	} else if (state & INT_BUFWEN) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
-				~(INT_BUFWEN | INT_DTRANE | INT_CMD12DRE |
-				  INT_CMD12RBE | INT_CMD12CRE));
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
-	} else if (state & INT_CMD12DRE) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
-			~(INT_CMD12DRE | INT_CMD12RBE |
-			  INT_CMD12CRE | INT_BUFRE));
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MCMD12DRE);
-	} else if (state & INT_BUFRE) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFRE);
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
-	} else if (state & INT_DTRANE) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
-			~(INT_CMD12DRE | INT_CMD12RBE |
-			  INT_CMD12CRE | INT_DTRANE));
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
-	} else if (state & INT_CMD12RBE) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
-				~(INT_CMD12RBE | INT_CMD12CRE));
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MCMD12RBE);
-	} else {
-		dev_dbg(&host->pd->dev, "Unsupported interrupt: 0x%x\n", state);
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
-		err = 1;
-	}
-	if (err) {
+	if (state & ~MASK_CLEAN)
+		dev_dbg(&host->pd->dev, "IRQ state = 0x%08x incompletely cleared\n",
+			state);
+
+	if (state & INT_ERR_STS || state & ~INT_ALL) {
 		host->sd_error = true;
-		dev_dbg(&host->pd->dev, "int err state = %08x\n", state);
+		dev_dbg(&host->pd->dev, "int err state = 0x%08x\n", state);
 	}
 	if (state & ~(INT_CMD12RBE | INT_CMD12CRE)) {
+		if (!host->mrq)
+			dev_dbg(&host->pd->dev, "NULL IRQ state = 0x%08x\n", state);
 		if (!host->dma_active)
 			return IRQ_WAKE_THREAD;
 		else if (host->sd_error)
-- 
1.7.2.5

