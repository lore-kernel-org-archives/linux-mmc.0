From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 01/15] mmc: sunxi: Document host init sequence
Date: Thu, 21 Jan 2016 13:26:28 +0800
Message-ID: <1453354002-28366-2-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org

sunxi_mmc_init_host() originated from Allwinner kernel sources. The
magic numbers written to various registers was never documented.

Add comments for values found in Allwinner user manuals.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 83de82bceafc..cce5ca540857 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -284,16 +284,28 @@ static int sunxi_mmc_init_host(struct mmc_host *mmc)
 	if (sunxi_mmc_reset_host(host))
 		return -EIO;
 
+	/*
+	 * Burst 8 transfers, RX trigger level: 7, TX trigger level: 8
+	 *
+	 * TODO: sun9i has a larger FIFO and supports higher trigger values
+	 */
 	mmc_writel(host, REG_FTRGL, 0x20070008);
+	/* Maximum timeout value */
 	mmc_writel(host, REG_TMOUT, 0xffffffff);
+	/* Unmask SDIO interrupt if needed */
 	mmc_writel(host, REG_IMASK, host->sdio_imask);
+	/* Clear all pending interrupts */
 	mmc_writel(host, REG_RINTR, 0xffffffff);
+	/* Debug register? undocumented */
 	mmc_writel(host, REG_DBGC, 0xdeb);
+	/* Enable CEATA support */
 	mmc_writel(host, REG_FUNS, SDXC_CEATA_ON);
+	/* Set DMA descriptor list base address */
 	mmc_writel(host, REG_DLBA, host->sg_dma);
 
 	rval = mmc_readl(host, REG_GCTRL);
 	rval |= SDXC_INTERRUPT_ENABLE_BIT;
+	/* Undocumented, but found in Allwinner code */
 	rval &= ~SDXC_ACCESS_DONE_DIRECT;
 	mmc_writel(host, REG_GCTRL, rval);
 
-- 
2.7.0.rc3
