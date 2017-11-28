From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] mmc: sunxi: fix mojibake in module metadata
Date: Tue, 28 Nov 2017 04:44:55 +0100
Message-ID: <20171128034455.10344-1-kilobyte@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:50638 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdK1DpL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Nov 2017 22:45:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>

It had an U+FFFD: not a corrupted character but a literal well-formed
replacement marker.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/mmc/host/sunxi-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index cc98355dbdb9..8fef5c17696e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2007-2011 Reuuimlla Technology Co., Ltd.
  * (C) Copyright 2007-2011 Aaron Maoye <leafy.myeh@reuuimllatech.com>
  * (C) Copyright 2013-2014 O2S GmbH <www.o2s.ch>
- * (C) Copyright 2013-2014 David Lanzend�rfer <david.lanzendoerfer@o2s.ch>
+ * (C) Copyright 2013-2014 David Lanzendörfer <david.lanzendoerfer@o2s.ch>
  * (C) Copyright 2013-2014 Hans de Goede <hdegoede@redhat.com>
  * (C) Copyright 2017 Sootech SA
  *
@@ -1393,5 +1393,5 @@ module_platform_driver(sunxi_mmc_driver);
 
 MODULE_DESCRIPTION("Allwinner's SD/MMC Card Controller Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("David Lanzend�rfer <david.lanzendoerfer@o2s.ch>");
+MODULE_AUTHOR("David Lanzendörfer <david.lanzendoerfer@o2s.ch>");
 MODULE_ALIAS("platform:sunxi-mmc");
-- 
2.15.0

