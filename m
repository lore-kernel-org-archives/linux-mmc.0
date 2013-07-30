From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 07/13] mmc: mmc_spi: Remove platform data .get_cd() and .get_ro() callbacks
Date: Tue, 30 Jul 2013 12:37:31 +0200
Message-ID: <1375180657-23641-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

All platforms now pass the CD and RO GPIOs to the MMC SPI driver, those
callbacks are not used anymore. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/mmc_spi.c  | 24 ++----------------------
 include/linux/spi/mmc_spi.h |  9 ---------
 2 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 62fb82d..0a87e56 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1273,31 +1273,11 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 }
 
-static int mmc_spi_get_ro(struct mmc_host *mmc)
-{
-	struct mmc_spi_host *host = mmc_priv(mmc);
-
-	if (host->pdata && host->pdata->get_ro)
-		return !!host->pdata->get_ro(mmc->parent);
-	else
-		return mmc_gpio_get_ro(mmc);
-}
-
-static int mmc_spi_get_cd(struct mmc_host *mmc)
-{
-	struct mmc_spi_host *host = mmc_priv(mmc);
-
-	if (host->pdata && host->pdata->get_cd)
-		return !!host->pdata->get_cd(mmc->parent);
-	else
-		return mmc_gpio_get_cd(mmc);
-}
-
 static const struct mmc_host_ops mmc_spi_ops = {
 	.request	= mmc_spi_request,
 	.set_ios	= mmc_spi_set_ios,
-	.get_ro		= mmc_spi_get_ro,
-	.get_cd		= mmc_spi_get_cd,
+	.get_ro		= mmc_gpio_get_ro,
+	.get_cd		= mmc_gpio_get_cd,
 };
 
 
diff --git a/include/linux/spi/mmc_spi.h b/include/linux/spi/mmc_spi.h
index 87cdb35..274bc0f 100644
--- a/include/linux/spi/mmc_spi.h
+++ b/include/linux/spi/mmc_spi.h
@@ -26,15 +26,6 @@ struct mmc_spi_platform_data {
 		void *);
 	void (*exit)(struct device *, void *);
 
-	/* sense switch on sd cards */
-	int (*get_ro)(struct device *);
-
-	/*
-	 * If board does not use CD interrupts, driver can optimize polling
-	 * using this function.
-	 */
-	int (*get_cd)(struct device *);
-
 	/*
 	 * Card Detect and Read Only GPIOs. To enable debouncing on the card
 	 * detect GPIO, set the cd_debounce to the debounce time in
-- 
1.8.1.5

