From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] sh: allow platforms to specify SD-card supported voltages
Date: Fri, 14 May 2010 12:34:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005141233250.6147@axis700.grange>
References: <Pine.LNX.4.64.1005141228510.6147@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005141228510.6147@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Boards can have different supplied voltages on different SD card slots. This
information has to be passed down to the SD/MMC driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mfd/sh_mobile_sdhi.c       |    4 +++-
 include/linux/mfd/sh_mobile_sdhi.h |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index 7970fe8..d9e4701 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -106,8 +106,10 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
-	if (p)
+	if (p) {
 		mmc_data->flags = p->tmio_flags;
+		mmc_data->ocr_mask = p->tmio_ocr_mask;
+	}
 
 	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
 		priv->param_tx.slave_id = p->dma_slave_tx;
diff --git a/include/linux/mfd/sh_mobile_sdhi.h b/include/linux/mfd/sh_mobile_sdhi.h
index c7b47f8..4906780 100644
--- a/include/linux/mfd/sh_mobile_sdhi.h
+++ b/include/linux/mfd/sh_mobile_sdhi.h
@@ -1,10 +1,13 @@
 #ifndef __SH_MOBILE_SDHI_H__
 #define __SH_MOBILE_SDHI_H__
 
+#include <linux/types.h>
+
 struct sh_mobile_sdhi_info {
 	int dma_slave_tx;
 	int dma_slave_rx;
 	unsigned long tmio_flags;
+	u32 tmio_ocr_mask;	/* available MMC voltages */
 	void (*set_pwr)(struct platform_device *pdev, int state);
 };
 
-- 
1.6.2.4

