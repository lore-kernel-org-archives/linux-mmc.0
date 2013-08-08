From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 11/14] mmc: sh_mobile_sdhi: Remove .get_cd() callback from platform data
Date: Thu,  8 Aug 2013 12:38:41 +0200
Message-ID: <1375958324-29683-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

All platforms pass the CD GPIO number to the driver in the .cd_gpio
field. The .get_cd() callback isn't used anymore, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c  | 9 ---------
 include/linux/mmc/sh_mobile_sdhi.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index ebea749..663a672 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -77,13 +77,6 @@ static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
 	p->set_pwr(pdev, state);
 }
 
-static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
-{
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
-
-	return p->get_cd(pdev);
-}
-
 static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
 {
 	int timeout = 1000;
@@ -182,8 +175,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->cd_gpio = p->cd_gpio;
 		if (p->set_pwr)
 			mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
-		if (p->get_cd)
-			mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
 			/*
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index b76bcf0..f31c692 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -26,7 +26,6 @@ struct sh_mobile_sdhi_info {
 	u32 tmio_ocr_mask;	/* available MMC voltages */
 	unsigned int cd_gpio;
 	void (*set_pwr)(struct platform_device *pdev, int state);
-	int (*get_cd)(struct platform_device *pdev);
 
 	/* callbacks for board specific setup code */
 	int (*init)(struct platform_device *pdev,
-- 
1.8.1.5

