From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v2 7/7] mmc: omap_hsmmc: Cleanup up bitmap definitions of Interrupt Register
Date: Mon, 19 Nov 2012 22:00:01 +0530
Message-ID: <1353342601-15210-7-git-send-email-svenkatr@ti.com>
References: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Define the most frequently used bitmasks of the Interrupt Enable /
Interrupt Status register with consistent naming ( with _EN suffix).

Use meaningful concatenation of bitfields for INT_EN_MASK, which shows
which interrupts are enabled by default.
No functional changes.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
v1->v2:
 Balaji's comments to not set ERR_EN for INT_EN_MASK is now
 handled.

 drivers/mmc/host/omap_hsmmc.c | 56 ++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9de0b9e..d0a912f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -80,29 +80,17 @@
 #define CLKD_SHIFT		6
 #define DTO_MASK		0x000F0000
 #define DTO_SHIFT		16
-#define INT_EN_MASK		0x307F0033
-#define BWR_ENABLE		(1 << 4)
-#define BRR_ENABLE		(1 << 5)
-#define DTO_ENABLE		(1 << 20)
 #define INIT_STREAM		(1 << 1)
 #define DP_SELECT		(1 << 21)
 #define DDIR			(1 << 4)
-#define DMA_EN			0x1
+#define DMAE			0x1
 #define MSBS			(1 << 5)
 #define BCE			(1 << 1)
 #define FOUR_BIT		(1 << 1)
 #define HSPE			(1 << 2)
 #define DDR			(1 << 19)
 #define DW8			(1 << 5)
-#define CC			0x1
-#define TC			0x02
 #define OD			0x1
-#define ERR			(1 << 15)
-#define CMD_TIMEOUT		(1 << 16)
-#define DATA_TIMEOUT		(1 << 20)
-#define CMD_CRC			(1 << 17)
-#define DATA_CRC		(1 << 21)
-#define CARD_ERR		(1 << 28)
 #define STAT_CLEAR		0xFFFFFFFF
 #define INIT_STREAM_CMD		0x00000000
 #define DUAL_VOLT_OCR_BIT	7
@@ -111,6 +99,26 @@
 #define SOFTRESET		(1 << 1)
 #define RESETDONE		(1 << 0)
 
+/* Interrupt masks for IE and ISE register */
+#define CC_EN			(1 << 0)
+#define TC_EN			(1 << 1)
+#define BWR_EN			(1 << 4)
+#define BRR_EN			(1 << 5)
+#define ERR_EN			(1 << 15)
+#define CTO_EN			(1 << 16)
+#define CCRC_EN			(1 << 17)
+#define CEB_EN			(1 << 18)
+#define CIE_EN			(1 << 19)
+#define DTO_EN			(1 << 20)
+#define DCRC_EN			(1 << 21)
+#define DEB_EN			(1 << 22)
+#define CERR_EN			(1 << 28)
+#define BADA_EN			(1 << 29)
+
+#define INT_EN_MASK		(BADA_EN | CERR_EN | DEB_EN | DCRC_EN |\
+		DTO_EN | CIE_EN | CEB_EN | CCRC_EN | CTO_EN | \
+		BRR_EN | BWR_EN | TC_EN | CC_EN)
+
 #define MMC_AUTOSUSPEND_DELAY	100
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MIN_CLOCK	400000
@@ -458,13 +466,13 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 	unsigned int irq_mask;
 
 	if (host->use_dma)
-		irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
+		irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
 	else
 		irq_mask = INT_EN_MASK;
 
 	/* Disable timeout for erases */
 	if (cmd->opcode == MMC_ERASE)
-		irq_mask &= ~DTO_ENABLE;
+		irq_mask &= ~DTO_EN;
 
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
@@ -702,8 +710,8 @@ static void send_init_stream(struct omap_hsmmc_host *host)
 	OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
 
 	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
-	while ((reg != CC) && time_before(jiffies, timeout))
-		reg = OMAP_HSMMC_READ(host->base, STAT) & CC;
+	while ((reg != CC_EN) && time_before(jiffies, timeout))
+		reg = OMAP_HSMMC_READ(host->base, STAT) & CC_EN;
 
 	OMAP_HSMMC_WRITE(host->base, CON,
 		OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
@@ -794,7 +802,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 	}
 
 	if (host->use_dma)
-		cmdreg |= DMA_EN;
+		cmdreg |= DMAE;
 
 	host->req_in_progress = 1;
 
@@ -1018,14 +1026,14 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 	data = host->data;
 	dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
 
-	if (status & ERR) {
+	if (status & ERR_EN) {
 		omap_hsmmc_dbg_report_irq(host, status);
 
-		if (status & (CMD_TIMEOUT | CMD_CRC))
+		if (status & (CTO_EN | CCRC_EN))
 			end_cmd = 1;
-		if (status & (CMD_TIMEOUT | DATA_TIMEOUT))
+		if (status & (CTO_EN | DTO_EN))
 			hsmmc_command_incomplete(host, -ETIMEDOUT, end_cmd);
-		else if (status & (CMD_CRC | DATA_CRC))
+		else if (status & (CCRC_EN | DCRC_EN))
 			hsmmc_command_incomplete(host, -EILSEQ, end_cmd);
 
 		if (host->data || host->response_busy) {
@@ -1034,9 +1042,9 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 		}
 	}
 
-	if (end_cmd || ((status & CC) && host->cmd))
+	if (end_cmd || ((status & CC_EN) && host->cmd))
 		omap_hsmmc_cmd_done(host, host->cmd);
-	if ((end_trans || (status & TC)) && host->mrq)
+	if ((end_trans || (status & TC_EN)) && host->mrq)
 		omap_hsmmc_xfer_done(host, data);
 }
 
-- 
1.8.0

