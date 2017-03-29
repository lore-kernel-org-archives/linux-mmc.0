From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: sdio: fix alignment issue in struct sdio_func
Date: Wed, 29 Mar 2017 20:54:37 +0200
Message-ID: <b4221ed8-1e85-2b8f-31c6-d57bc86d122e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34944 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbdC2SzC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Mar 2017 14:55:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id p52so5604723wrc.2
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2017 11:54:51 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, Helmut Klein <hgkr.klein@gmail.com>

Certain 64-bit systems (e.g. Amlogic Meson GX) require buffers to be
used for DMA to be 8-byte-aligned. struct sdio_func has an embedded
small DMA buffer not meeting this requirement.
When testing switching to descriptor chain mode in meson-gx driver
SDIO is broken therefore. Fix this by allocating the small DMA buffer
separately as kmalloc ensures that the returned memory area is
properly aligned for every basic data type.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Helmut Klein <hgkr.klein@gmail.com>
---
 drivers/mmc/core/sdio_bus.c   | 12 +++++++++++-
 include/linux/mmc/sdio_func.h |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index e992a7f8..2b32b889 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -267,7 +267,7 @@ static void sdio_release_func(struct device *dev)
 	sdio_free_func_cis(func);
 
 	kfree(func->info);
-
+	kfree(func->tmpbuf);
 	kfree(func);
 }
 
@@ -282,6 +282,16 @@ struct sdio_func *sdio_alloc_func(struct mmc_card *card)
 	if (!func)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * allocate buffer separately to make sure it's properly aligned for
+	 * DMA usage (incl. 64 bit DMA)
+	 */
+	func->tmpbuf = kmalloc(4, GFP_KERNEL);
+	if (!func->tmpbuf) {
+		kfree(func);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	func->card = card;
 
 	device_initialize(&func->dev);
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index aab032a6..97ca1053 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -53,7 +53,7 @@ struct sdio_func {
 	unsigned int		state;		/* function state */
 #define SDIO_STATE_PRESENT	(1<<0)		/* present in sysfs */
 
-	u8			tmpbuf[4];	/* DMA:able scratch buffer */
+	u8			*tmpbuf;	/* DMA:able scratch buffer */
 
 	unsigned		num_info;	/* number of info strings */
 	const char		**info;		/* info strings */
-- 
2.12.1

