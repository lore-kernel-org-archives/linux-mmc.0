From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] mmc: let MFD's provide supported Vdd card voltages to
 tmio_mmc
Date: Fri, 14 May 2010 12:34:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005141232530.6147@axis700.grange>
References: <Pine.LNX.4.64.1005141228510.6147@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005141228510.6147@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |    5 ++++-
 include/linux/mfd/tmio.h    |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index a295328..73f6c3d 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -845,7 +845,10 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 	mmc->caps |= pdata->capabilities;
 	mmc->f_max = pdata->hclk;
 	mmc->f_min = mmc->f_max / 512;
-	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	if (pdata->ocr_mask)
+		mmc->ocr_avail = pdata->ocr_mask;
+	else
+		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	/* Tell the MFD core we are ready to be enabled */
 	if (cell->enable) {
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index feeed0b..f07425b 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -70,6 +70,7 @@ struct tmio_mmc_data {
 	unsigned int			hclk;
 	unsigned long			capabilities;
 	unsigned long			flags;
+	u32				ocr_mask;	/* available voltages */
 	struct tmio_mmc_dma		*dma;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
-- 
1.6.2.4

