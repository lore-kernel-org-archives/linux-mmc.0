From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [RFC/PATCH v2 1/3] mmc: sdio: correct the name of SDIO_CCCR_IF[5] to avoid confusion
Date: Fri, 21 Sep 2012 11:07:45 +0800
Message-ID: <1348196867-15145-2-git-send-email-keyuan.liu@gmail.com>
References: <1348196867-15145-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44293 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932414Ab2IUDMh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 23:12:37 -0400
In-Reply-To: <1348196867-15145-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

SDIO_CCCR_IF[5] should be ECSI rather than ASYNC_INT

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/sdio.c  |    2 +-
 include/linux/mmc/sdio.h |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index d4619e2..909c835 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -279,7 +279,7 @@ static int sdio_disable_wide(struct mmc_card *card)
 		return 0;
 
 	ctrl &= ~SDIO_BUS_WIDTH_4BIT;
-	ctrl |= SDIO_BUS_ASYNC_INT;
+	ctrl |= SDIO_BUS_ECSI;
 
 	ret = mmc_io_rw_direct(card, 1, 0, SDIO_CCCR_IF, ctrl, NULL);
 	if (ret)
diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index 17446d3..47e579d 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -105,8 +105,6 @@
 #define  SDIO_BUS_ECSI		0x20	/* Enable continuous SPI interrupt */
 #define  SDIO_BUS_SCSI		0x40	/* Support continuous SPI interrupt */
 
-#define  SDIO_BUS_ASYNC_INT	0x20
-
 #define  SDIO_BUS_CD_DISABLE     0x80	/* disable pull-up on DAT3 (pin 1) */
 
 #define SDIO_CCCR_CAPS		0x08
-- 
1.7.0.4

