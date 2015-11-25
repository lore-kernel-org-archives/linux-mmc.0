From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] mmc: mvsdio: delete platform data header
Date: Wed, 25 Nov 2015 14:57:31 +0100
Message-ID: <1448459851-32565-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34522 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbbKYN5p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 08:57:45 -0500
Received: by lffu14 with SMTP id u14so61419972lff.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 05:57:44 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

This platform data struct is only used inside the MVSDIO driver,
nowhere else in the entire kernel. Move the struct into the
driver and delete the external header.

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mvsdio.c                |  7 ++++++-
 include/linux/platform_data/mmc-mvsdio.h | 18 ------------------
 2 files changed, 6 insertions(+), 19 deletions(-)
 delete mode 100644 include/linux/platform_data/mmc-mvsdio.h

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index a448498e3af2..18c70380ea93 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -28,7 +28,6 @@
 
 #include <asm/sizes.h>
 #include <asm/unaligned.h>
-#include <linux/platform_data/mmc-mvsdio.h>
 
 #include "mvsdio.h"
 
@@ -37,6 +36,12 @@
 static int maxfreq;
 static int nodma;
 
+struct mvsdio_platform_data {
+	unsigned int clock;
+	int gpio_card_detect;
+	int gpio_write_protect;
+};
+
 struct mvsd_host {
 	void __iomem *base;
 	struct mmc_request *mrq;
diff --git a/include/linux/platform_data/mmc-mvsdio.h b/include/linux/platform_data/mmc-mvsdio.h
deleted file mode 100644
index d02704cd3695..000000000000
--- a/include/linux/platform_data/mmc-mvsdio.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MMC_MVSDIO_H
-#define __MMC_MVSDIO_H
-
-#include <linux/mbus.h>
-
-struct mvsdio_platform_data {
-	unsigned int clock;
-	int gpio_card_detect;
-	int gpio_write_protect;
-};
-
-#endif
-- 
2.4.3

