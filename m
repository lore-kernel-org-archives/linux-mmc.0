From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 11/13] mmc: sh_mobile_sdhi: Remove .set_pwr() callback from platform data
Date: Tue, 30 Jul 2013 12:37:35 +0200
Message-ID: <1375180657-23641-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

The .set_pwr() callback isn't used anymore as all platforms register
GPIO-controlled regulators. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c  | 9 ---------
 include/linux/mmc/sh_mobile_sdhi.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 663a672..b3fd2c3 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -70,13 +70,6 @@ static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
 	clk_disable(priv->clk);
 }
 
-static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
-{
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
-
-	p->set_pwr(pdev, state);
-}
-
 static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
 {
 	int timeout = 1000;
@@ -173,8 +166,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->capabilities |= p->tmio_caps;
 		mmc_data->capabilities2 |= p->tmio_caps2;
 		mmc_data->cd_gpio = p->cd_gpio;
-		if (p->set_pwr)
-			mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
 			/*
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index f31c692..68927ae 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -25,7 +25,6 @@ struct sh_mobile_sdhi_info {
 	unsigned long tmio_caps2;
 	u32 tmio_ocr_mask;	/* available MMC voltages */
 	unsigned int cd_gpio;
-	void (*set_pwr)(struct platform_device *pdev, int state);
 
 	/* callbacks for board specific setup code */
 	int (*init)(struct platform_device *pdev,
-- 
1.8.1.5

