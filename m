From: ludovic.desroches@atmel.com
Subject: [RFC PATCH 1/9] mmc: atmel-mci: change namespace
Date: Thu, 28 Jul 2011 16:29:50 +0200
Message-ID: <1311863398-31579-2-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:60197 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab1G1NYU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 09:24:20 -0400
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: patrice.vilchez@atmel.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Homogenize namespace to atmci.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 drivers/mmc/host/atmel-mci-regs.h        |  206 ++++++++++----------
 drivers/mmc/host/atmel-mci.c             |  301 +++++++++++++++---------------
 include/linux/atmel-mci.h                |    4 +-
 4 files changed, 257 insertions(+), 256 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 39f81f4..c49e84a 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -319,7 +319,7 @@ void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
 	if (!data)
 		return;
 
-	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 		if (data->slot[i].bus_width) {
 			/* input/irq */
 			if (data->slot[i].detect_pin) {
diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index fc8a0fe..29331ab 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -17,112 +17,112 @@
 #define __DRIVERS_MMC_ATMEL_MCI_H__
 
 /* MCI Register Definitions */
-#define MCI_CR			0x0000	/* Control */
-# define MCI_CR_MCIEN		(  1 <<  0)	/* MCI Enable */
-# define MCI_CR_MCIDIS		(  1 <<  1)	/* MCI Disable */
-# define MCI_CR_PWSEN		(  1 <<  2)	/* Power Save Enable */
-# define MCI_CR_PWSDIS		(  1 <<  3)	/* Power Save Disable */
-# define MCI_CR_SWRST		(  1 <<  7)	/* Software Reset */
-#define MCI_MR			0x0004	/* Mode */
-# define MCI_MR_CLKDIV(x)	((x) <<  0)	/* Clock Divider */
-# define MCI_MR_PWSDIV(x)	((x) <<  8)	/* Power Saving Divider */
-# define MCI_MR_RDPROOF		(  1 << 11)	/* Read Proof */
-# define MCI_MR_WRPROOF		(  1 << 12)	/* Write Proof */
-# define MCI_MR_PDCFBYTE	(  1 << 13)	/* Force Byte Transfer */
-# define MCI_MR_PDCPADV		(  1 << 14)	/* Padding Value */
-# define MCI_MR_PDCMODE		(  1 << 15)	/* PDC-oriented Mode */
-#define MCI_DTOR		0x0008	/* Data Timeout */
-# define MCI_DTOCYC(x)		((x) <<  0)	/* Data Timeout Cycles */
-# define MCI_DTOMUL(x)		((x) <<  4)	/* Data Timeout Multiplier */
-#define MCI_SDCR		0x000c	/* SD Card / SDIO */
-# define MCI_SDCSEL_SLOT_A	(  0 <<  0)	/* Select SD slot A */
-# define MCI_SDCSEL_SLOT_B	(  1 <<  0)	/* Select SD slot A */
-# define MCI_SDCSEL_MASK	(  3 <<  0)
-# define MCI_SDCBUS_1BIT	(  0 <<  6)	/* 1-bit data bus */
-# define MCI_SDCBUS_4BIT	(  2 <<  6)	/* 4-bit data bus */
-# define MCI_SDCBUS_8BIT	(  3 <<  6)	/* 8-bit data bus[2] */
-# define MCI_SDCBUS_MASK	(  3 <<  6)
-#define MCI_ARGR		0x0010	/* Command Argument */
-#define MCI_CMDR		0x0014	/* Command */
-# define MCI_CMDR_CMDNB(x)	((x) <<  0)	/* Command Opcode */
-# define MCI_CMDR_RSPTYP_NONE	(  0 <<  6)	/* No response */
-# define MCI_CMDR_RSPTYP_48BIT	(  1 <<  6)	/* 48-bit response */
-# define MCI_CMDR_RSPTYP_136BIT	(  2 <<  6)	/* 136-bit response */
-# define MCI_CMDR_SPCMD_INIT	(  1 <<  8)	/* Initialization command */
-# define MCI_CMDR_SPCMD_SYNC	(  2 <<  8)	/* Synchronized command */
-# define MCI_CMDR_SPCMD_INT	(  4 <<  8)	/* Interrupt command */
-# define MCI_CMDR_SPCMD_INTRESP	(  5 <<  8)	/* Interrupt response */
-# define MCI_CMDR_OPDCMD	(  1 << 11)	/* Open Drain */
-# define MCI_CMDR_MAXLAT_5CYC	(  0 << 12)	/* Max latency 5 cycles */
-# define MCI_CMDR_MAXLAT_64CYC	(  1 << 12)	/* Max latency 64 cycles */
-# define MCI_CMDR_START_XFER	(  1 << 16)	/* Start data transfer */
-# define MCI_CMDR_STOP_XFER	(  2 << 16)	/* Stop data transfer */
-# define MCI_CMDR_TRDIR_WRITE	(  0 << 18)	/* Write data */
-# define MCI_CMDR_TRDIR_READ	(  1 << 18)	/* Read data */
-# define MCI_CMDR_BLOCK		(  0 << 19)	/* Single-block transfer */
-# define MCI_CMDR_MULTI_BLOCK	(  1 << 19)	/* Multi-block transfer */
-# define MCI_CMDR_STREAM	(  2 << 19)	/* MMC Stream transfer */
-# define MCI_CMDR_SDIO_BYTE	(  4 << 19)	/* SDIO Byte transfer */
-# define MCI_CMDR_SDIO_BLOCK	(  5 << 19)	/* SDIO Block transfer */
-# define MCI_CMDR_SDIO_SUSPEND	(  1 << 24)	/* SDIO Suspend Command */
-# define MCI_CMDR_SDIO_RESUME	(  2 << 24)	/* SDIO Resume Command */
-#define MCI_BLKR		0x0018	/* Block */
-# define MCI_BCNT(x)		((x) <<  0)	/* Data Block Count */
-# define MCI_BLKLEN(x)		((x) << 16)	/* Data Block Length */
-#define MCI_CSTOR		0x001c	/* Completion Signal Timeout[2] */
-# define MCI_CSTOCYC(x)		((x) <<  0)	/* CST cycles */
-# define MCI_CSTOMUL(x)		((x) <<  4)	/* CST multiplier */
-#define MCI_RSPR		0x0020	/* Response 0 */
-#define MCI_RSPR1		0x0024	/* Response 1 */
-#define MCI_RSPR2		0x0028	/* Response 2 */
-#define MCI_RSPR3		0x002c	/* Response 3 */
-#define MCI_RDR			0x0030	/* Receive Data */
-#define MCI_TDR			0x0034	/* Transmit Data */
-#define MCI_SR			0x0040	/* Status */
-#define MCI_IER			0x0044	/* Interrupt Enable */
-#define MCI_IDR			0x0048	/* Interrupt Disable */
-#define MCI_IMR			0x004c	/* Interrupt Mask */
-# define MCI_CMDRDY		(  1 <<   0)	/* Command Ready */
-# define MCI_RXRDY		(  1 <<   1)	/* Receiver Ready */
-# define MCI_TXRDY		(  1 <<   2)	/* Transmitter Ready */
-# define MCI_BLKE		(  1 <<   3)	/* Data Block Ended */
-# define MCI_DTIP		(  1 <<   4)	/* Data Transfer In Progress */
-# define MCI_NOTBUSY		(  1 <<   5)	/* Data Not Busy */
-# define MCI_SDIOIRQA		(  1 <<   8)	/* SDIO IRQ in slot A */
-# define MCI_SDIOIRQB		(  1 <<   9)	/* SDIO IRQ in slot B */
-# define MCI_RINDE		(  1 <<  16)	/* Response Index Error */
-# define MCI_RDIRE		(  1 <<  17)	/* Response Direction Error */
-# define MCI_RCRCE		(  1 <<  18)	/* Response CRC Error */
-# define MCI_RENDE		(  1 <<  19)	/* Response End Bit Error */
-# define MCI_RTOE		(  1 <<  20)	/* Response Time-Out Error */
-# define MCI_DCRCE		(  1 <<  21)	/* Data CRC Error */
-# define MCI_DTOE		(  1 <<  22)	/* Data Time-Out Error */
-# define MCI_OVRE		(  1 <<  30)	/* RX Overrun Error */
-# define MCI_UNRE		(  1 <<  31)	/* TX Underrun Error */
-#define MCI_DMA			0x0050	/* DMA Configuration[2] */
-# define MCI_DMA_OFFSET(x)	((x) <<  0)	/* DMA Write Buffer Offset */
-# define MCI_DMA_CHKSIZE(x)	((x) <<  4)	/* DMA Channel Read and Write Chunk Size */
-# define MCI_DMAEN		(  1 <<  8)	/* DMA Hardware Handshaking Enable */
-#define MCI_CFG			0x0054	/* Configuration[2] */
-# define MCI_CFG_FIFOMODE_1DATA	(  1 <<  0)	/* MCI Internal FIFO control mode */
-# define MCI_CFG_FERRCTRL_COR	(  1 <<  4)	/* Flow Error flag reset control mode */
-# define MCI_CFG_HSMODE		(  1 <<  8)	/* High Speed Mode */
-# define MCI_CFG_LSYNC		(  1 << 12)	/* Synchronize on the last block */
-#define MCI_WPMR		0x00e4	/* Write Protection Mode[2] */
-# define MCI_WP_EN		(  1 <<  0)	/* WP Enable */
-# define MCI_WP_KEY		(0x4d4349 << 8)	/* WP Key */
-#define MCI_WPSR		0x00e8	/* Write Protection Status[2] */
-# define MCI_GET_WP_VS(x)	((x) & 0x0f)
-# define MCI_GET_WP_VSRC(x)	(((x) >> 8) & 0xffff)
-#define MCI_FIFO_APERTURE	0x0200	/* FIFO Aperture[2] */
+#define ATMCI_CR			0x0000	/* Control */
+# define ATMCI_CR_MCIEN		(  1 <<  0)	/* MCI Enable */
+# define ATMCI_CR_MCIDIS		(  1 <<  1)	/* MCI Disable */
+# define ATMCI_CR_PWSEN		(  1 <<  2)	/* Power Save Enable */
+# define ATMCI_CR_PWSDIS		(  1 <<  3)	/* Power Save Disable */
+# define ATMCI_CR_SWRST		(  1 <<  7)	/* Software Reset */
+#define ATMCI_MR			0x0004	/* Mode */
+# define ATMCI_MR_CLKDIV(x)	((x) <<  0)	/* Clock Divider */
+# define ATMCI_MR_PWSDIV(x)	((x) <<  8)	/* Power Saving Divider */
+# define ATMCI_MR_RDPROOF		(  1 << 11)	/* Read Proof */
+# define ATMCI_MR_WRPROOF		(  1 << 12)	/* Write Proof */
+# define ATMCI_MR_PDCFBYTE	(  1 << 13)	/* Force Byte Transfer */
+# define ATMCI_MR_PDCPADV		(  1 << 14)	/* Padding Value */
+# define ATMCI_MR_PDCMODE		(  1 << 15)	/* PDC-oriented Mode */
+#define ATMCI_DTOR		0x0008	/* Data Timeout */
+# define ATMCI_DTOCYC(x)		((x) <<  0)	/* Data Timeout Cycles */
+# define ATMCI_DTOMUL(x)		((x) <<  4)	/* Data Timeout Multiplier */
+#define ATMCI_SDCR		0x000c	/* SD Card / SDIO */
+# define ATMCI_SDCSEL_SLOT_A	(  0 <<  0)	/* Select SD slot A */
+# define ATMCI_SDCSEL_SLOT_B	(  1 <<  0)	/* Select SD slot A */
+# define ATMCI_SDCSEL_MASK	(  3 <<  0)
+# define ATMCI_SDCBUS_1BIT	(  0 <<  6)	/* 1-bit data bus */
+# define ATMCI_SDCBUS_4BIT	(  2 <<  6)	/* 4-bit data bus */
+# define ATMCI_SDCBUS_8BIT	(  3 <<  6)	/* 8-bit data bus[2] */
+# define ATMCI_SDCBUS_MASK	(  3 <<  6)
+#define ATMCI_ARGR		0x0010	/* Command Argument */
+#define ATMCI_CMDR		0x0014	/* Command */
+# define ATMCI_CMDR_CMDNB(x)	((x) <<  0)	/* Command Opcode */
+# define ATMCI_CMDR_RSPTYP_NONE	(  0 <<  6)	/* No response */
+# define ATMCI_CMDR_RSPTYP_48BIT	(  1 <<  6)	/* 48-bit response */
+# define ATMCI_CMDR_RSPTYP_136BIT	(  2 <<  6)	/* 136-bit response */
+# define ATMCI_CMDR_SPCMD_INIT	(  1 <<  8)	/* Initialization command */
+# define ATMCI_CMDR_SPCMD_SYNC	(  2 <<  8)	/* Synchronized command */
+# define ATMCI_CMDR_SPCMD_INT	(  4 <<  8)	/* Interrupt command */
+# define ATMCI_CMDR_SPCMD_INTRESP	(  5 <<  8)	/* Interrupt response */
+# define ATMCI_CMDR_OPDCMD	(  1 << 11)	/* Open Drain */
+# define ATMCI_CMDR_MAXLAT_5CYC	(  0 << 12)	/* Max latency 5 cycles */
+# define ATMCI_CMDR_MAXLAT_64CYC	(  1 << 12)	/* Max latency 64 cycles */
+# define ATMCI_CMDR_START_XFER	(  1 << 16)	/* Start data transfer */
+# define ATMCI_CMDR_STOP_XFER	(  2 << 16)	/* Stop data transfer */
+# define ATMCI_CMDR_TRDIR_WRITE	(  0 << 18)	/* Write data */
+# define ATMCI_CMDR_TRDIR_READ	(  1 << 18)	/* Read data */
+# define ATMCI_CMDR_BLOCK		(  0 << 19)	/* Single-block transfer */
+# define ATMCI_CMDR_MULTI_BLOCK	(  1 << 19)	/* Multi-block transfer */
+# define ATMCI_CMDR_STREAM	(  2 << 19)	/* MMC Stream transfer */
+# define ATMCI_CMDR_SDIO_BYTE	(  4 << 19)	/* SDIO Byte transfer */
+# define ATMCI_CMDR_SDIO_BLOCK	(  5 << 19)	/* SDIO Block transfer */
+# define ATMCI_CMDR_SDIO_SUSPEND	(  1 << 24)	/* SDIO Suspend Command */
+# define ATMCI_CMDR_SDIO_RESUME	(  2 << 24)	/* SDIO Resume Command */
+#define ATMCI_BLKR		0x0018	/* Block */
+# define ATMCI_BCNT(x)		((x) <<  0)	/* Data Block Count */
+# define ATMCI_BLKLEN(x)		((x) << 16)	/* Data Block Length */
+#define ATMCI_CSTOR		0x001c	/* Completion Signal Timeout[2] */
+# define ATMCI_CSTOCYC(x)		((x) <<  0)	/* CST cycles */
+# define ATMCI_CSTOMUL(x)		((x) <<  4)	/* CST multiplier */
+#define ATMCI_RSPR		0x0020	/* Response 0 */
+#define ATMCI_RSPR1		0x0024	/* Response 1 */
+#define ATMCI_RSPR2		0x0028	/* Response 2 */
+#define ATMCI_RSPR3		0x002c	/* Response 3 */
+#define ATMCI_RDR			0x0030	/* Receive Data */
+#define ATMCI_TDR			0x0034	/* Transmit Data */
+#define ATMCI_SR			0x0040	/* Status */
+#define ATMCI_IER			0x0044	/* Interrupt Enable */
+#define ATMCI_IDR			0x0048	/* Interrupt Disable */
+#define ATMCI_IMR			0x004c	/* Interrupt Mask */
+# define ATMCI_CMDRDY		(  1 <<   0)	/* Command Ready */
+# define ATMCI_RXRDY		(  1 <<   1)	/* Receiver Ready */
+# define ATMCI_TXRDY		(  1 <<   2)	/* Transmitter Ready */
+# define ATMCI_BLKE		(  1 <<   3)	/* Data Block Ended */
+# define ATMCI_DTIP		(  1 <<   4)	/* Data Transfer In Progress */
+# define ATMCI_NOTBUSY		(  1 <<   5)	/* Data Not Busy */
+# define ATMCI_SDIOIRQA		(  1 <<   8)	/* SDIO IRQ in slot A */
+# define ATMCI_SDIOIRQB		(  1 <<   9)	/* SDIO IRQ in slot B */
+# define ATMCI_RINDE		(  1 <<  16)	/* Response Index Error */
+# define ATMCI_RDIRE		(  1 <<  17)	/* Response Direction Error */
+# define ATMCI_RCRCE		(  1 <<  18)	/* Response CRC Error */
+# define ATMCI_RENDE		(  1 <<  19)	/* Response End Bit Error */
+# define ATMCI_RTOE		(  1 <<  20)	/* Response Time-Out Error */
+# define ATMCI_DCRCE		(  1 <<  21)	/* Data CRC Error */
+# define ATMCI_DTOE		(  1 <<  22)	/* Data Time-Out Error */
+# define ATMCI_OVRE		(  1 <<  30)	/* RX Overrun Error */
+# define ATMCI_UNRE		(  1 <<  31)	/* TX Underrun Error */
+#define ATMCI_DMA			0x0050	/* DMA Configuration[2] */
+# define ATMCI_DMA_OFFSET(x)	((x) <<  0)	/* DMA Write Buffer Offset */
+# define ATMCI_DMA_CHKSIZE(x)	((x) <<  4)	/* DMA Channel Read and Write Chunk Size */
+# define ATMCI_DMAEN		(  1 <<  8)	/* DMA Hardware Handshaking Enable */
+#define ATMCI_CFG			0x0054	/* Configuration[2] */
+# define ATMCI_CFG_FIFOMODE_1DATA	(  1 <<  0)	/* MCI Internal FIFO control mode */
+# define ATMCI_CFG_FERRCTRL_COR	(  1 <<  4)	/* Flow Error flag reset control mode */
+# define ATMCI_CFG_HSMODE		(  1 <<  8)	/* High Speed Mode */
+# define ATMCI_CFG_LSYNC		(  1 << 12)	/* Synchronize on the last block */
+#define ATMCI_WPMR		0x00e4	/* Write Protection Mode[2] */
+# define ATMCI_WP_EN		(  1 <<  0)	/* WP Enable */
+# define ATMCI_WP_KEY		(0x4d4349 << 8)	/* WP Key */
+#define ATMCI_WPSR		0x00e8	/* Write Protection Status[2] */
+# define ATMCI_GET_WP_VS(x)	((x) & 0x0f)
+# define ATMCI_GET_WP_VSRC(x)	(((x) >> 8) & 0xffff)
+#define ATMCI_FIFO_APERTURE	0x0200	/* FIFO Aperture[2] */
 
 /* This is not including the FIFO Aperture on MCI2 */
-#define MCI_REGS_SIZE		0x100
+#define ATMCI_REGS_SIZE		0x100
 
 /* Register access macros */
-#define mci_readl(port,reg)				\
-	__raw_readl((port)->regs + MCI_##reg)
-#define mci_writel(port,reg,value)			\
-	__raw_writel((value), (port)->regs + MCI_##reg)
+#define atmci_readl(port,reg)				\
+	__raw_readl((port)->regs + ATMCI_##reg)
+#define atmci_writel(port,reg,value)			\
+	__raw_writel((value), (port)->regs + ATMCI_##reg)
 
 #endif /* __DRIVERS_MMC_ATMEL_MCI_H__ */
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index fa8cae1..c2a0949 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -39,7 +39,7 @@
 
 #include "atmel-mci-regs.h"
 
-#define ATMCI_DATA_ERROR_FLAGS	(MCI_DCRCE | MCI_DTOE | MCI_OVRE | MCI_UNRE)
+#define ATMCI_DATA_ERROR_FLAGS	(ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
 #define ATMCI_DMA_THRESHOLD	16
 
 enum {
@@ -166,7 +166,7 @@ struct atmel_mci {
 	struct clk		*mck;
 	struct platform_device	*pdev;
 
-	struct atmel_mci_slot	*slot[ATMEL_MCI_MAX_NR_SLOTS];
+	struct atmel_mci_slot	*slot[ATMCI_MAX_NR_SLOTS];
 };
 
 /**
@@ -223,7 +223,7 @@ struct atmel_mci_slot {
  * Enable or disable features/registers based on
  * whether the processor supports them
  */
-static bool mci_has_rwproof(void)
+static bool atmci_has_rwproof(void)
 {
 	if (cpu_is_at91sam9261() || cpu_is_at91rm9200())
 		return false;
@@ -352,7 +352,7 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	struct atmel_mci	*host = s->private;
 	u32			*buf;
 
-	buf = kmalloc(MCI_REGS_SIZE, GFP_KERNEL);
+	buf = kmalloc(ATMCI_REGS_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -363,47 +363,47 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	 */
 	spin_lock_bh(&host->lock);
 	clk_enable(host->mck);
-	memcpy_fromio(buf, host->regs, MCI_REGS_SIZE);
+	memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
 	clk_disable(host->mck);
 	spin_unlock_bh(&host->lock);
 
 	seq_printf(s, "MR:\t0x%08x%s%s CLKDIV=%u\n",
-			buf[MCI_MR / 4],
-			buf[MCI_MR / 4] & MCI_MR_RDPROOF ? " RDPROOF" : "",
-			buf[MCI_MR / 4] & MCI_MR_WRPROOF ? " WRPROOF" : "",
-			buf[MCI_MR / 4] & 0xff);
-	seq_printf(s, "DTOR:\t0x%08x\n", buf[MCI_DTOR / 4]);
-	seq_printf(s, "SDCR:\t0x%08x\n", buf[MCI_SDCR / 4]);
-	seq_printf(s, "ARGR:\t0x%08x\n", buf[MCI_ARGR / 4]);
+			buf[ATMCI_MR / 4],
+			buf[ATMCI_MR / 4] & ATMCI_MR_RDPROOF ? " RDPROOF" : "",
+			buf[ATMCI_MR / 4] & ATMCI_MR_WRPROOF ? " WRPROOF" : "",
+			buf[ATMCI_MR / 4] & 0xff);
+	seq_printf(s, "DTOR:\t0x%08x\n", buf[ATMCI_DTOR / 4]);
+	seq_printf(s, "SDCR:\t0x%08x\n", buf[ATMCI_SDCR / 4]);
+	seq_printf(s, "ARGR:\t0x%08x\n", buf[ATMCI_ARGR / 4]);
 	seq_printf(s, "BLKR:\t0x%08x BCNT=%u BLKLEN=%u\n",
-			buf[MCI_BLKR / 4],
-			buf[MCI_BLKR / 4] & 0xffff,
-			(buf[MCI_BLKR / 4] >> 16) & 0xffff);
+			buf[ATMCI_BLKR / 4],
+			buf[ATMCI_BLKR / 4] & 0xffff,
+			(buf[ATMCI_BLKR / 4] >> 16) & 0xffff);
 	if (atmci_is_mci2())
-		seq_printf(s, "CSTOR:\t0x%08x\n", buf[MCI_CSTOR / 4]);
+		seq_printf(s, "CSTOR:\t0x%08x\n", buf[ATMCI_CSTOR / 4]);
 
 	/* Don't read RSPR and RDR; it will consume the data there */
 
-	atmci_show_status_reg(s, "SR", buf[MCI_SR / 4]);
-	atmci_show_status_reg(s, "IMR", buf[MCI_IMR / 4]);
+	atmci_show_status_reg(s, "SR", buf[ATMCI_SR / 4]);
+	atmci_show_status_reg(s, "IMR", buf[ATMCI_IMR / 4]);
 
 	if (atmci_is_mci2()) {
 		u32 val;
 
-		val = buf[MCI_DMA / 4];
+		val = buf[ATMCI_DMA / 4];
 		seq_printf(s, "DMA:\t0x%08x OFFSET=%u CHKSIZE=%u%s\n",
 				val, val & 3,
 				((val >> 4) & 3) ?
 					1 << (((val >> 4) & 3) + 1) : 1,
-				val & MCI_DMAEN ? " DMAEN" : "");
+				val & ATMCI_DMAEN ? " DMAEN" : "");
 
-		val = buf[MCI_CFG / 4];
+		val = buf[ATMCI_CFG / 4];
 		seq_printf(s, "CFG:\t0x%08x%s%s%s%s\n",
 				val,
-				val & MCI_CFG_FIFOMODE_1DATA ? " FIFOMODE_ONE_DATA" : "",
-				val & MCI_CFG_FERRCTRL_COR ? " FERRCTRL_CLEAR_ON_READ" : "",
-				val & MCI_CFG_HSMODE ? " HSMODE" : "",
-				val & MCI_CFG_LSYNC ? " LSYNC" : "");
+				val & ATMCI_CFG_FIFOMODE_1DATA ? " FIFOMODE_ONE_DATA" : "",
+				val & ATMCI_CFG_FERRCTRL_COR ? " FERRCTRL_CLEAR_ON_READ" : "",
+				val & ATMCI_CFG_HSMODE ? " HSMODE" : "",
+				val & ATMCI_CFG_LSYNC ? " LSYNC" : "");
 	}
 
 	kfree(buf);
@@ -466,7 +466,7 @@ err:
 	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
 }
 
-static inline unsigned int ns_to_clocks(struct atmel_mci *host,
+static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
 					unsigned int ns)
 {
 	return (ns * (host->bus_hz / 1000000) + 999) / 1000;
@@ -482,7 +482,8 @@ static void atmci_set_timeout(struct atmel_mci *host,
 	unsigned	dtocyc;
 	unsigned	dtomul;
 
-	timeout = ns_to_clocks(host, data->timeout_ns) + data->timeout_clks;
+	timeout = atmci_ns_to_clocks(host, data->timeout_ns)
+		+ data->timeout_clks;
 
 	for (dtomul = 0; dtomul < 8; dtomul++) {
 		unsigned shift = dtomul_to_shift[dtomul];
@@ -498,7 +499,7 @@ static void atmci_set_timeout(struct atmel_mci *host,
 
 	dev_vdbg(&slot->mmc->class_dev, "setting timeout to %u cycles\n",
 			dtocyc << dtomul_to_shift[dtomul]);
-	mci_writel(host, DTOR, (MCI_DTOMUL(dtomul) | MCI_DTOCYC(dtocyc)));
+	atmci_writel(host, DTOR, (ATMCI_DTOMUL(dtomul) | ATMCI_DTOCYC(dtocyc)));
 }
 
 /*
@@ -512,13 +513,13 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
 
 	cmd->error = -EINPROGRESS;
 
-	cmdr = MCI_CMDR_CMDNB(cmd->opcode);
+	cmdr = ATMCI_CMDR_CMDNB(cmd->opcode);
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136)
-			cmdr |= MCI_CMDR_RSPTYP_136BIT;
+			cmdr |= ATMCI_CMDR_RSPTYP_136BIT;
 		else
-			cmdr |= MCI_CMDR_RSPTYP_48BIT;
+			cmdr |= ATMCI_CMDR_RSPTYP_48BIT;
 	}
 
 	/*
@@ -526,28 +527,28 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
 	 * it's too difficult to determine whether this is an ACMD or
 	 * not. Better make it 64.
 	 */
-	cmdr |= MCI_CMDR_MAXLAT_64CYC;
+	cmdr |= ATMCI_CMDR_MAXLAT_64CYC;
 
 	if (mmc->ios.bus_mode == MMC_BUSMODE_OPENDRAIN)
-		cmdr |= MCI_CMDR_OPDCMD;
+		cmdr |= ATMCI_CMDR_OPDCMD;
 
 	data = cmd->data;
 	if (data) {
-		cmdr |= MCI_CMDR_START_XFER;
+		cmdr |= ATMCI_CMDR_START_XFER;
 
 		if (cmd->opcode == SD_IO_RW_EXTENDED) {
-			cmdr |= MCI_CMDR_SDIO_BLOCK;
+			cmdr |= ATMCI_CMDR_SDIO_BLOCK;
 		} else {
 			if (data->flags & MMC_DATA_STREAM)
-				cmdr |= MCI_CMDR_STREAM;
+				cmdr |= ATMCI_CMDR_STREAM;
 			else if (data->blocks > 1)
-				cmdr |= MCI_CMDR_MULTI_BLOCK;
+				cmdr |= ATMCI_CMDR_MULTI_BLOCK;
 			else
-				cmdr |= MCI_CMDR_BLOCK;
+				cmdr |= ATMCI_CMDR_BLOCK;
 		}
 
 		if (data->flags & MMC_DATA_READ)
-			cmdr |= MCI_CMDR_TRDIR_READ;
+			cmdr |= ATMCI_CMDR_TRDIR_READ;
 	}
 
 	return cmdr;
@@ -563,14 +564,14 @@ static void atmci_start_command(struct atmel_mci *host,
 			"start command: ARGR=0x%08x CMDR=0x%08x\n",
 			cmd->arg, cmd_flags);
 
-	mci_writel(host, ARGR, cmd->arg);
-	mci_writel(host, CMDR, cmd_flags);
+	atmci_writel(host, ARGR, cmd->arg);
+	atmci_writel(host, CMDR, cmd_flags);
 }
 
-static void send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
+static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
 {
 	atmci_start_command(host, data->stop, host->stop_cmdr);
-	mci_writel(host, IER, MCI_CMDRDY);
+	atmci_writel(host, IER, ATMCI_CMDRDY);
 }
 
 #ifdef CONFIG_MMC_ATMELMCI_DMA
@@ -595,7 +596,7 @@ static void atmci_stop_dma(struct atmel_mci *host)
 	} else {
 		/* Data transfer was stopped by the interrupt handler */
 		atmci_set_pending(host, EVENT_XFER_COMPLETE);
-		mci_writel(host, IER, MCI_NOTBUSY);
+		atmci_writel(host, IER, ATMCI_NOTBUSY);
 	}
 }
 
@@ -609,7 +610,7 @@ static void atmci_dma_complete(void *arg)
 
 	if (atmci_is_mci2())
 		/* Disable DMA hardware handshaking on MCI */
-		mci_writel(host, DMA, mci_readl(host, DMA) & ~MCI_DMAEN);
+		atmci_writel(host, DMA, atmci_readl(host, DMA) & ~ATMCI_DMAEN);
 
 	atmci_dma_cleanup(host);
 
@@ -641,7 +642,7 @@ static void atmci_dma_complete(void *arg)
 		 * completion callback" rule of the dma engine
 		 * framework.
 		 */
-		mci_writel(host, IER, MCI_NOTBUSY);
+		atmci_writel(host, IER, ATMCI_NOTBUSY);
 	}
 }
 
@@ -660,7 +661,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	 * non-word-aligned buffers or lengths. Also, we don't bother
 	 * with all the DMA setup overhead for short transfers.
 	 */
-	if (data->blocks * data->blksz < ATMCI_DMA_THRESHOLD)
+	if (data->blocks * data->blksz < ATATMCI_DMA_THRESHOLD)
 		return -EINVAL;
 	if (data->blksz & 3)
 		return -EINVAL;
@@ -679,7 +680,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 		return -ENODEV;
 
 	if (atmci_is_mci2())
-		mci_writel(host, DMA, MCI_DMA_CHKSIZE(3) | MCI_DMAEN);
+		atmci_writel(host, DMA, ATMCI_DMA_CHKSIZE(3) | ATMCI_DMAEN);
 
 	if (data->flags & MMC_DATA_READ)
 		direction = DMA_FROM_DEVICE;
@@ -729,7 +730,7 @@ static void atmci_stop_dma(struct atmel_mci *host)
 {
 	/* Data transfer was stopped by the interrupt handler */
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
-	mci_writel(host, IER, MCI_NOTBUSY);
+	atmci_writel(host, IER, ATMCI_NOTBUSY);
 }
 
 #endif /* CONFIG_MMC_ATMELMCI_DMA */
@@ -766,9 +767,9 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
 		host->sg = data->sg;
 		host->pio_offset = 0;
 		if (data->flags & MMC_DATA_READ)
-			iflags |= MCI_RXRDY;
+			iflags |= ATMCI_RXRDY;
 		else
-			iflags |= MCI_TXRDY;
+			iflags |= ATMCI_TXRDY;
 	}
 
 	return iflags;
@@ -792,24 +793,24 @@ static void atmci_start_request(struct atmel_mci *host,
 	host->data_status = 0;
 
 	if (host->need_reset) {
-		mci_writel(host, CR, MCI_CR_SWRST);
-		mci_writel(host, CR, MCI_CR_MCIEN);
-		mci_writel(host, MR, host->mode_reg);
+		atmci_writel(host, CR, ATMCI_CR_SWRST);
+		atmci_writel(host, CR, ATMCI_CR_MCIEN);
+		atmci_writel(host, MR, host->mode_reg);
 		if (atmci_is_mci2())
-			mci_writel(host, CFG, host->cfg_reg);
+			atmci_writel(host, CFG, host->cfg_reg);
 		host->need_reset = false;
 	}
-	mci_writel(host, SDCR, slot->sdc_reg);
+	atmci_writel(host, SDCR, slot->sdc_reg);
 
-	iflags = mci_readl(host, IMR);
-	if (iflags & ~(MCI_SDIOIRQA | MCI_SDIOIRQB))
+	iflags = atmci_readl(host, IMR);
+	if (iflags & ~(ATMCI_SDIOIRQA | ATMCI_SDIOIRQB))
 		dev_warn(&slot->mmc->class_dev, "WARNING: IMR=0x%08x\n",
 				iflags);
 
 	if (unlikely(test_and_clear_bit(ATMCI_CARD_NEED_INIT, &slot->flags))) {
 		/* Send init sequence (74 clock cycles) */
-		mci_writel(host, CMDR, MCI_CMDR_SPCMD_INIT);
-		while (!(mci_readl(host, SR) & MCI_CMDRDY))
+		atmci_writel(host, CMDR, ATMCI_CMDR_SPCMD_INIT);
+		while (!(atmci_readl(host, SR) & ATMCI_CMDRDY))
 			cpu_relax();
 	}
 	iflags = 0;
@@ -818,15 +819,15 @@ static void atmci_start_request(struct atmel_mci *host,
 		atmci_set_timeout(host, slot, data);
 
 		/* Must set block count/size before sending command */
-		mci_writel(host, BLKR, MCI_BCNT(data->blocks)
-				| MCI_BLKLEN(data->blksz));
+		atmci_writel(host, BLKR, ATMCI_BCNT(data->blocks)
+				| ATMCI_BLKLEN(data->blksz));
 		dev_vdbg(&slot->mmc->class_dev, "BLKR=0x%08x\n",
-			MCI_BCNT(data->blocks) | MCI_BLKLEN(data->blksz));
+			ATMCI_BCNT(data->blocks) | ATMCI_BLKLEN(data->blksz));
 
 		iflags |= atmci_prepare_data(host, data);
 	}
 
-	iflags |= MCI_CMDRDY;
+	iflags |= ATMCI_CMDRDY;
 	cmd = mrq->cmd;
 	cmdflags = atmci_prepare_command(slot->mmc, cmd);
 	atmci_start_command(host, cmd, cmdflags);
@@ -836,13 +837,13 @@ static void atmci_start_request(struct atmel_mci *host,
 
 	if (mrq->stop) {
 		host->stop_cmdr = atmci_prepare_command(slot->mmc, mrq->stop);
-		host->stop_cmdr |= MCI_CMDR_STOP_XFER;
+		host->stop_cmdr |= ATMCI_CMDR_STOP_XFER;
 		if (!(data->flags & MMC_DATA_WRITE))
-			host->stop_cmdr |= MCI_CMDR_TRDIR_READ;
+			host->stop_cmdr |= ATMCI_CMDR_TRDIR_READ;
 		if (data->flags & MMC_DATA_STREAM)
-			host->stop_cmdr |= MCI_CMDR_STREAM;
+			host->stop_cmdr |= ATMCI_CMDR_STREAM;
 		else
-			host->stop_cmdr |= MCI_CMDR_MULTI_BLOCK;
+			host->stop_cmdr |= ATMCI_CMDR_MULTI_BLOCK;
 	}
 
 	/*
@@ -851,7 +852,7 @@ static void atmci_start_request(struct atmel_mci *host,
 	 * conditions (e.g. command and data complete, but stop not
 	 * prepared yet.)
 	 */
-	mci_writel(host, IER, iflags);
+	atmci_writel(host, IER, iflags);
 }
 
 static void atmci_queue_request(struct atmel_mci *host,
@@ -909,13 +910,13 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct atmel_mci	*host = slot->host;
 	unsigned int		i;
 
-	slot->sdc_reg &= ~MCI_SDCBUS_MASK;
+	slot->sdc_reg &= ~ATMCI_SDCBUS_MASK;
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_1:
-		slot->sdc_reg |= MCI_SDCBUS_1BIT;
+		slot->sdc_reg |= ATMCI_SDCBUS_1BIT;
 		break;
 	case MMC_BUS_WIDTH_4:
-		slot->sdc_reg |= MCI_SDCBUS_4BIT;
+		slot->sdc_reg |= ATMCI_SDCBUS_4BIT;
 		break;
 	}
 
@@ -926,10 +927,10 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		spin_lock_bh(&host->lock);
 		if (!host->mode_reg) {
 			clk_enable(host->mck);
-			mci_writel(host, CR, MCI_CR_SWRST);
-			mci_writel(host, CR, MCI_CR_MCIEN);
+			atmci_writel(host, CR, ATMCI_CR_SWRST);
+			atmci_writel(host, CR, ATMCI_CR_MCIEN);
 			if (atmci_is_mci2())
-				mci_writel(host, CFG, host->cfg_reg);
+				atmci_writel(host, CFG, host->cfg_reg);
 		}
 
 		/*
@@ -937,7 +938,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * core ios update when finding the minimum.
 		 */
 		slot->clock = ios->clock;
-		for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+		for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 			if (host->slot[i] && host->slot[i]->clock
 					&& host->slot[i]->clock < clock_min)
 				clock_min = host->slot[i]->clock;
@@ -952,28 +953,28 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			clkdiv = 255;
 		}
 
-		host->mode_reg = MCI_MR_CLKDIV(clkdiv);
+		host->mode_reg = ATMCI_MR_CLKDIV(clkdiv);
 
 		/*
 		 * WRPROOF and RDPROOF prevent overruns/underruns by
 		 * stopping the clock when the FIFO is full/empty.
 		 * This state is not expected to last for long.
 		 */
-		if (mci_has_rwproof())
-			host->mode_reg |= (MCI_MR_WRPROOF | MCI_MR_RDPROOF);
+		if (atmci_has_rwproof())
+			host->mode_reg |= (ATMCI_MR_WRPROOF | ATMCI_MR_RDPROOF);
 
 		if (atmci_is_mci2()) {
 			/* setup High Speed mode in relation with card capacity */
 			if (ios->timing == MMC_TIMING_SD_HS)
-				host->cfg_reg |= MCI_CFG_HSMODE;
+				host->cfg_reg |= ATMCI_CFG_HSMODE;
 			else
-				host->cfg_reg &= ~MCI_CFG_HSMODE;
+				host->cfg_reg &= ~ATMCI_CFG_HSMODE;
 		}
 
 		if (list_empty(&host->queue)) {
-			mci_writel(host, MR, host->mode_reg);
+			atmci_writel(host, MR, host->mode_reg);
 			if (atmci_is_mci2())
-				mci_writel(host, CFG, host->cfg_reg);
+				atmci_writel(host, CFG, host->cfg_reg);
 		} else {
 			host->need_clock_update = true;
 		}
@@ -984,16 +985,16 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		spin_lock_bh(&host->lock);
 		slot->clock = 0;
-		for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+		for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 			if (host->slot[i] && host->slot[i]->clock) {
 				any_slot_active = true;
 				break;
 			}
 		}
 		if (!any_slot_active) {
-			mci_writel(host, CR, MCI_CR_MCIDIS);
+			atmci_writel(host, CR, ATMCI_CR_MCIDIS);
 			if (host->mode_reg) {
-				mci_readl(host, MR);
+				atmci_readl(host, MR);
 				clk_disable(host->mck);
 			}
 			host->mode_reg = 0;
@@ -1057,9 +1058,9 @@ static void atmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct atmel_mci	*host = slot->host;
 
 	if (enable)
-		mci_writel(host, IER, slot->sdio_irq);
+		atmci_writel(host, IER, slot->sdio_irq);
 	else
-		mci_writel(host, IDR, slot->sdio_irq);
+		atmci_writel(host, IDR, slot->sdio_irq);
 }
 
 static const struct mmc_host_ops atmci_ops = {
@@ -1086,9 +1087,9 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 	 * busy transferring data.
 	 */
 	if (host->need_clock_update) {
-		mci_writel(host, MR, host->mode_reg);
+		atmci_writel(host, MR, host->mode_reg);
 		if (atmci_is_mci2())
-			mci_writel(host, CFG, host->cfg_reg);
+			atmci_writel(host, CFG, host->cfg_reg);
 	}
 
 	host->cur_slot->mrq = NULL;
@@ -1117,16 +1118,16 @@ static void atmci_command_complete(struct atmel_mci *host,
 	u32		status = host->cmd_status;
 
 	/* Read the response from the card (up to 16 bytes) */
-	cmd->resp[0] = mci_readl(host, RSPR);
-	cmd->resp[1] = mci_readl(host, RSPR);
-	cmd->resp[2] = mci_readl(host, RSPR);
-	cmd->resp[3] = mci_readl(host, RSPR);
+	cmd->resp[0] = atmci_readl(host, RSPR);
+	cmd->resp[1] = atmci_readl(host, RSPR);
+	cmd->resp[2] = atmci_readl(host, RSPR);
+	cmd->resp[3] = atmci_readl(host, RSPR);
 
-	if (status & MCI_RTOE)
+	if (status & ATMCI_RTOE)
 		cmd->error = -ETIMEDOUT;
-	else if ((cmd->flags & MMC_RSP_CRC) && (status & MCI_RCRCE))
+	else if ((cmd->flags & MMC_RSP_CRC) && (status & ATMCI_RCRCE))
 		cmd->error = -EILSEQ;
-	else if (status & (MCI_RINDE | MCI_RDIRE | MCI_RENDE))
+	else if (status & (ATMCI_RINDE | ATMCI_RDIRE | ATMCI_RENDE))
 		cmd->error = -EIO;
 	else
 		cmd->error = 0;
@@ -1138,8 +1139,8 @@ static void atmci_command_complete(struct atmel_mci *host,
 		if (cmd->data) {
 			atmci_stop_dma(host);
 			host->data = NULL;
-			mci_writel(host, IDR, MCI_NOTBUSY
-					| MCI_TXRDY | MCI_RXRDY
+			atmci_writel(host, IDR, ATMCI_NOTBUSY
+					| ATMCI_TXRDY | ATMCI_RXRDY
 					| ATMCI_DATA_ERROR_FLAGS);
 		}
 	}
@@ -1191,11 +1192,11 @@ static void atmci_detect_change(unsigned long data)
 				 * Reset controller to terminate any ongoing
 				 * commands or data transfers.
 				 */
-				mci_writel(host, CR, MCI_CR_SWRST);
-				mci_writel(host, CR, MCI_CR_MCIEN);
-				mci_writel(host, MR, host->mode_reg);
+				atmci_writel(host, CR, ATMCI_CR_SWRST);
+				atmci_writel(host, CR, ATMCI_CR_MCIEN);
+				atmci_writel(host, MR, host->mode_reg);
 				if (atmci_is_mci2())
-					mci_writel(host, CFG, host->cfg_reg);
+					atmci_writel(host, CFG, host->cfg_reg);
 
 				host->data = NULL;
 				host->cmd = NULL;
@@ -1261,7 +1262,7 @@ static void atmci_tasklet_func(unsigned long priv)
 	dev_vdbg(&host->pdev->dev,
 		"tasklet: state %u pending/completed/mask %lx/%lx/%x\n",
 		state, host->pending_events, host->completed_events,
-		mci_readl(host, IMR));
+		atmci_readl(host, IMR));
 
 	do {
 		prev_state = state;
@@ -1291,7 +1292,7 @@ static void atmci_tasklet_func(unsigned long priv)
 						EVENT_DATA_ERROR)) {
 				atmci_stop_dma(host);
 				if (data->stop)
-					send_stop_cmd(host, data);
+					atmci_send_stop_cmd(host, data);
 				state = STATE_DATA_ERROR;
 				break;
 			}
@@ -1313,11 +1314,11 @@ static void atmci_tasklet_func(unsigned long priv)
 			atmci_set_completed(host, EVENT_DATA_COMPLETE);
 			status = host->data_status;
 			if (unlikely(status & ATMCI_DATA_ERROR_FLAGS)) {
-				if (status & MCI_DTOE) {
+				if (status & ATMCI_DTOE) {
 					dev_dbg(&host->pdev->dev,
 							"data timeout error\n");
 					data->error = -ETIMEDOUT;
-				} else if (status & MCI_DCRCE) {
+				} else if (status & ATMCI_DCRCE) {
 					dev_dbg(&host->pdev->dev,
 							"data CRC error\n");
 					data->error = -EILSEQ;
@@ -1330,7 +1331,7 @@ static void atmci_tasklet_func(unsigned long priv)
 			} else {
 				data->bytes_xfered = data->blocks * data->blksz;
 				data->error = 0;
-				mci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS);
+				atmci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS);
 			}
 
 			if (!data->stop) {
@@ -1340,7 +1341,7 @@ static void atmci_tasklet_func(unsigned long priv)
 
 			prev_state = state = STATE_SENDING_STOP;
 			if (!data->error)
-				send_stop_cmd(host, data);
+				atmci_send_stop_cmd(host, data);
 			/* fall through */
 
 		case STATE_SENDING_STOP:
@@ -1380,7 +1381,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 	unsigned int		nbytes = 0;
 
 	do {
-		value = mci_readl(host, RDR);
+		value = atmci_readl(host, RDR);
 		if (likely(offset + 4 <= sg->length)) {
 			put_unaligned(value, (u32 *)(buf + offset));
 
@@ -1412,9 +1413,9 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 			nbytes += offset;
 		}
 
-		status = mci_readl(host, SR);
+		status = atmci_readl(host, SR);
 		if (status & ATMCI_DATA_ERROR_FLAGS) {
-			mci_writel(host, IDR, (MCI_NOTBUSY | MCI_RXRDY
+			atmci_writel(host, IDR, (ATMCI_NOTBUSY | ATMCI_RXRDY
 						| ATMCI_DATA_ERROR_FLAGS));
 			host->data_status = status;
 			data->bytes_xfered += nbytes;
@@ -1423,7 +1424,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 			tasklet_schedule(&host->tasklet);
 			return;
 		}
-	} while (status & MCI_RXRDY);
+	} while (status & ATMCI_RXRDY);
 
 	host->pio_offset = offset;
 	data->bytes_xfered += nbytes;
@@ -1431,8 +1432,8 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 	return;
 
 done:
-	mci_writel(host, IDR, MCI_RXRDY);
-	mci_writel(host, IER, MCI_NOTBUSY);
+	atmci_writel(host, IDR, ATMCI_RXRDY);
+	atmci_writel(host, IER, ATMCI_NOTBUSY);
 	data->bytes_xfered += nbytes;
 	smp_wmb();
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
@@ -1451,7 +1452,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 	do {
 		if (likely(offset + 4 <= sg->length)) {
 			value = get_unaligned((u32 *)(buf + offset));
-			mci_writel(host, TDR, value);
+			atmci_writel(host, TDR, value);
 
 			offset += 4;
 			nbytes += 4;
@@ -1472,20 +1473,20 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 
 			host->sg = sg = sg_next(sg);
 			if (!sg) {
-				mci_writel(host, TDR, value);
+				atmci_writel(host, TDR, value);
 				goto done;
 			}
 
 			offset = 4 - remaining;
 			buf = sg_virt(sg);
 			memcpy((u8 *)&value + remaining, buf, offset);
-			mci_writel(host, TDR, value);
+			atmci_writel(host, TDR, value);
 			nbytes += offset;
 		}
 
-		status = mci_readl(host, SR);
+		status = atmci_readl(host, SR);
 		if (status & ATMCI_DATA_ERROR_FLAGS) {
-			mci_writel(host, IDR, (MCI_NOTBUSY | MCI_TXRDY
+			atmci_writel(host, IDR, (ATMCI_NOTBUSY | ATMCI_TXRDY
 						| ATMCI_DATA_ERROR_FLAGS));
 			host->data_status = status;
 			data->bytes_xfered += nbytes;
@@ -1494,7 +1495,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 			tasklet_schedule(&host->tasklet);
 			return;
 		}
-	} while (status & MCI_TXRDY);
+	} while (status & ATMCI_TXRDY);
 
 	host->pio_offset = offset;
 	data->bytes_xfered += nbytes;
@@ -1502,8 +1503,8 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 	return;
 
 done:
-	mci_writel(host, IDR, MCI_TXRDY);
-	mci_writel(host, IER, MCI_NOTBUSY);
+	atmci_writel(host, IDR, ATMCI_TXRDY);
+	atmci_writel(host, IER, ATMCI_NOTBUSY);
 	data->bytes_xfered += nbytes;
 	smp_wmb();
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
@@ -1511,7 +1512,7 @@ done:
 
 static void atmci_cmd_interrupt(struct atmel_mci *host, u32 status)
 {
-	mci_writel(host, IDR, MCI_CMDRDY);
+	atmci_writel(host, IDR, ATMCI_CMDRDY);
 
 	host->cmd_status = status;
 	smp_wmb();
@@ -1523,7 +1524,7 @@ static void atmci_sdio_interrupt(struct atmel_mci *host, u32 status)
 {
 	int	i;
 
-	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 		struct atmel_mci_slot *slot = host->slot[i];
 		if (slot && (status & slot->sdio_irq)) {
 			mmc_signal_sdio_irq(slot->mmc);
@@ -1539,40 +1540,40 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 	unsigned int		pass_count = 0;
 
 	do {
-		status = mci_readl(host, SR);
-		mask = mci_readl(host, IMR);
+		status = atmci_readl(host, SR);
+		mask = atmci_readl(host, IMR);
 		pending = status & mask;
 		if (!pending)
 			break;
 
 		if (pending & ATMCI_DATA_ERROR_FLAGS) {
-			mci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS
-					| MCI_RXRDY | MCI_TXRDY);
-			pending &= mci_readl(host, IMR);
+			atmci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS
+					| ATMCI_RXRDY | ATMCI_TXRDY);
+			pending &= atmci_readl(host, IMR);
 
 			host->data_status = status;
 			smp_wmb();
 			atmci_set_pending(host, EVENT_DATA_ERROR);
 			tasklet_schedule(&host->tasklet);
 		}
-		if (pending & MCI_NOTBUSY) {
-			mci_writel(host, IDR,
-					ATMCI_DATA_ERROR_FLAGS | MCI_NOTBUSY);
+		if (pending & ATMCI_NOTBUSY) {
+			atmci_writel(host, IDR,
+					ATMCI_DATA_ERROR_FLAGS | ATMCI_NOTBUSY);
 			if (!host->data_status)
 				host->data_status = status;
 			smp_wmb();
 			atmci_set_pending(host, EVENT_DATA_COMPLETE);
 			tasklet_schedule(&host->tasklet);
 		}
-		if (pending & MCI_RXRDY)
+		if (pending & ATMCI_RXRDY)
 			atmci_read_data_pio(host);
-		if (pending & MCI_TXRDY)
+		if (pending & ATMCI_TXRDY)
 			atmci_write_data_pio(host);
 
-		if (pending & MCI_CMDRDY)
+		if (pending & ATMCI_CMDRDY)
 			atmci_cmd_interrupt(host, status);
 
-		if (pending & (MCI_SDIOIRQA | MCI_SDIOIRQB))
+		if (pending & (ATMCI_SDIOIRQA | ATMCI_SDIOIRQB))
 			atmci_sdio_interrupt(host, status);
 
 	} while (pass_count++ < 5);
@@ -1705,7 +1706,7 @@ static void __exit atmci_cleanup_slot(struct atmel_mci_slot *slot,
 }
 
 #ifdef CONFIG_MMC_ATMELMCI_DMA
-static bool filter(struct dma_chan *chan, void *slave)
+static bool atmci_filter(struct dma_chan *chan, void *slave)
 {
 	struct mci_dma_data	*sl = slave;
 
@@ -1730,14 +1731,14 @@ static void atmci_configure_dma(struct atmel_mci *host)
 		dma_cap_mask_t mask;
 
 		setup_dma_addr(pdata->dma_slave,
-			       host->mapbase + MCI_TDR,
-			       host->mapbase + MCI_RDR);
+			       host->mapbase + ATMCI_TDR,
+			       host->mapbase + ATMCI_RDR);
 
 		/* Try to grab a DMA channel */
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
 		host->dma.chan =
-			dma_request_channel(mask, filter, pdata->dma_slave);
+			dma_request_channel(mask, atmci_filter, pdata->dma_slave);
 	}
 	if (!host->dma.chan)
 		dev_notice(&host->pdev->dev, "DMA not available, using PIO\n");
@@ -1789,7 +1790,7 @@ static int __init atmci_probe(struct platform_device *pdev)
 		goto err_ioremap;
 
 	clk_enable(host->mck);
-	mci_writel(host, CR, MCI_CR_SWRST);
+	atmci_writel(host, CR, ATMCI_CR_SWRST);
 	host->bus_hz = clk_get_rate(host->mck);
 	clk_disable(host->mck);
 
@@ -1810,13 +1811,13 @@ static int __init atmci_probe(struct platform_device *pdev)
 	ret = -ENODEV;
 	if (pdata->slot[0].bus_width) {
 		ret = atmci_init_slot(host, &pdata->slot[0],
-				0, MCI_SDCSEL_SLOT_A, MCI_SDIOIRQA);
+				0, ATMCI_SDCSEL_SLOT_A, ATMCI_SDIOIRQA);
 		if (!ret)
 			nr_slots++;
 	}
 	if (pdata->slot[1].bus_width) {
 		ret = atmci_init_slot(host, &pdata->slot[1],
-				1, MCI_SDCSEL_SLOT_B, MCI_SDIOIRQB);
+				1, ATMCI_SDCSEL_SLOT_B, ATMCI_SDIOIRQB);
 		if (!ret)
 			nr_slots++;
 	}
@@ -1854,15 +1855,15 @@ static int __exit atmci_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 		if (host->slot[i])
 			atmci_cleanup_slot(host->slot[i], i);
 	}
 
 	clk_enable(host->mck);
-	mci_writel(host, IDR, ~0UL);
-	mci_writel(host, CR, MCI_CR_MCIDIS);
-	mci_readl(host, SR);
+	atmci_writel(host, IDR, ~0UL);
+	atmci_writel(host, CR, ATMCI_CR_MCIDIS);
+	atmci_readl(host, SR);
 	clk_disable(host->mck);
 
 #ifdef CONFIG_MMC_ATMELMCI_DMA
@@ -1885,7 +1886,7 @@ static int atmci_suspend(struct device *dev)
 	struct atmel_mci *host = dev_get_drvdata(dev);
 	int i;
 
-	 for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+	 for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 		struct atmel_mci_slot *slot = host->slot[i];
 		int ret;
 
@@ -1916,7 +1917,7 @@ static int atmci_resume(struct device *dev)
 	int i;
 	int ret = 0;
 
-	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 		struct atmel_mci_slot *slot = host->slot[i];
 		int err;
 
diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
index 3e09b34..4c7a4b2 100644
--- a/include/linux/atmel-mci.h
+++ b/include/linux/atmel-mci.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_ATMEL_MCI_H
 #define __LINUX_ATMEL_MCI_H
 
-#define ATMEL_MCI_MAX_NR_SLOTS	2
+#define ATMCI_MAX_NR_SLOTS	2
 
 /**
  * struct mci_slot_pdata - board-specific per-slot configuration
@@ -33,7 +33,7 @@ struct mci_slot_pdata {
  */
 struct mci_platform_data {
 	struct mci_dma_data	*dma_slave;
-	struct mci_slot_pdata	slot[ATMEL_MCI_MAX_NR_SLOTS];
+	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
 };
 
 #endif /* __LINUX_ATMEL_MCI_H */
-- 
1.7.0.4

