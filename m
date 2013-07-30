From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 12/13] mmc: tmio-mmc: Remove .get_cd() callback from platform data
Date: Tue, 30 Jul 2013 12:37:36 +0200
Message-ID: <1375180657-23641-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

All platforms pass the CD GPIO number to the driver in the .cd_gpio
field. The .get_cd() callback isn't used anymore, remove it

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c | 16 +---------------
 include/linux/mfd/tmio.h        |  1 -
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 8486a22..2a7eb5a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -932,25 +932,11 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 		 (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
 }
 
-static int tmio_mmc_get_cd(struct mmc_host *mmc)
-{
-	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct tmio_mmc_data *pdata = host->pdata;
-	int ret = mmc_gpio_get_cd(mmc);
-	if (ret >= 0)
-		return ret;
-
-	if (!pdata->get_cd)
-		return -ENOSYS;
-	else
-		return pdata->get_cd(host->pdev);
-}
-
 static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
-	.get_cd		= tmio_mmc_get_cd,
+	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index ce35113..b22883d 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -108,7 +108,6 @@ struct tmio_mmc_data {
 	unsigned int			cd_gpio;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
-	int (*get_cd)(struct platform_device *host);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	/* clock management callbacks */
 	int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
-- 
1.8.1.5

