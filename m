From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 06/12] mmc: mmc_spi: Remove platform data .get_cd() and .get_ro() callbacks
Date: Fri, 26 Jul 2013 01:26:42 +0200
Message-ID: <1374794808-21890-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34839 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab3GYX0A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2013 19:26:00 -0400
In-Reply-To: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>

All platforms now pass the CD and RO GPIOs to the MMC SPI driver, those
callbacks are not used anymore. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/mmc_spi.c  | 24 ++----------------------
 include/linux/spi/mmc_spi.h |  9 ---------
 2 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 4e83908..19aa660 100644
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
index a54da4a..46cc2f8 100644
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
 	/* Card Detect and Read Only GPIOs */
 	unsigned int flags;
 	unsigned int cd_gpio;
-- 
1.8.1.5

