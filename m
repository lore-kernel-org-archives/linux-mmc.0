From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] MAINTAINERS: update entry for TMIO MMC driver
Date: Mon,  9 May 2016 10:26:58 +0200
Message-ID: <1462782418-5908-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47813 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbcEII1H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 May 2016 04:27:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

I have some more additions planned for this driver, so I'd like to get
notified of other changes and coordinate them. Drop Ian as maintainer
because he hasn't been involved in development for a while. Thanks for
all the initial work, of course! Also, reflect the recent changes to
the include file layout.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ian Molton <ian@mnementh.co.uk>
---

Ian: If you'd like to stay involved, please speak up and I'll change my patch
accordingly.

 MAINTAINERS | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42e65d128d015e..d22540c44b534b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11245,14 +11245,13 @@ S:	Maintained
 F:	drivers/media/i2c/tc358743*
 F:	include/media/i2c/tc358743.h
 
-TMIO MMC DRIVER
-M:	Ian Molton <ian@mnementh.co.uk>
+TMIO/SDHI MMC DRIVER
+M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 L:	linux-mmc@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	drivers/mmc/host/tmio_mmc*
 F:	drivers/mmc/host/sh_mobile_sdhi.c
-F:	include/linux/mmc/tmio.h
-F:	include/linux/mmc/sh_mobile_sdhi.h
+F:	include/linux/mfd/tmio.h
 
 TMP401 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-- 
2.7.0

