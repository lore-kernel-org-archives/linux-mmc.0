From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] mmc: sdio: fix alignment issue in struct sdio_func
Date: Wed, 29 Mar 2017 13:17:32 -0700
Message-ID: <m237dv7s83.fsf@baylibre.com>
References: <b4221ed8-1e85-2b8f-31c6-d57bc86d122e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33116 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932763AbdC2URf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Mar 2017 16:17:35 -0400
Received: by mail-pg0-f44.google.com with SMTP id x125so17424023pgb.0
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2017 13:17:34 -0700 (PDT)
In-Reply-To: <b4221ed8-1e85-2b8f-31c6-d57bc86d122e@gmail.com> (Heiner
        Kallweit's message of "Wed, 29 Mar 2017 20:54:37 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-amlogic@lists.infradead.org, Helmut Klein <hgkr.klein@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Certain 64-bit systems (e.g. Amlogic Meson GX) require buffers to be
> used for DMA to be 8-byte-aligned. struct sdio_func has an embedded
> small DMA buffer not meeting this requirement.
> When testing switching to descriptor chain mode in meson-gx driver
> SDIO is broken therefore. Fix this by allocating the small DMA buffer
> separately as kmalloc ensures that the returned memory area is
> properly aligned for every basic data type.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Tested-by: Helmut Klein <hgkr.klein@gmail.com>

This should work too, without the need to do a tiny kmalloc.

diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index aab032a6ae61..071addf23931 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -53,7 +53,7 @@ struct sdio_func {
 	unsigned int		state;		/* function state */
 #define SDIO_STATE_PRESENT	(1<<0)		/* present in sysfs */
 
-	u8			tmpbuf[4];	/* DMA:able scratch buffer */
+	u8			tmpbuf[4] __aligned(8);	/* DMA:able scratch buffer */
 
 	unsigned		num_info;	/* number of info strings */
 	const char		**info;		/* info strings */

Kevin
