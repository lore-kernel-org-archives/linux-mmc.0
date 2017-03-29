From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] mmc: sdio: fix alignment issue in struct sdio_func
Date: Wed, 29 Mar 2017 22:56:50 +0200
Message-ID: <3a6258f3-35e3-e2f5-aa6b-e509f603fa45@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32801 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932509AbdC2U5R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Mar 2017 16:57:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18so6494592wrc.0
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2017 13:57:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, Helmut Klein <hgkr.klein@gmail.com>, Kevin Hilman <khilman@baylibre.com>

Certain 64-bit systems (e.g. Amlogic Meson GX) require buffers to be
used for DMA to be 8-byte-aligned. struct sdio_func has an embedded
small DMA buffer not meeting this requirement.
Testing an extension to meson-gx driver for switching to descriptor
chain mode broke SDIO therefore. Aligning tmpbuf to a 8-byte
boundary fixed the driver behavior.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Helmut Klein <hgkr.klein@gmail.com>
---
v2:
- switch to much simpler version as suggested by Kevin Hilman <khilman@baylibre.com>
- adjust commit message
---
 include/linux/mmc/sdio_func.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index aab032a6..65d90f76 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -53,7 +53,8 @@ struct sdio_func {
 	unsigned int		state;		/* function state */
 #define SDIO_STATE_PRESENT	(1<<0)		/* present in sysfs */
 
-	u8			tmpbuf[4];	/* DMA:able scratch buffer */
+	/* take care of proper alignment for DMA on certain 64-bit systems */
+	u8 __aligned(8)		tmpbuf[4];	/* DMA:able scratch buffer */
 
 	unsigned		num_info;	/* number of info strings */
 	const char		**info;		/* info strings */
-- 
2.12.1


