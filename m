From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/4] mmc: atmel-mci: incude asm/cacheclush.h
Date: Thu,  5 Jun 2014 23:14:38 +0200
Message-ID: <1402002881-1986640-2-git-send-email-arnd@arndb.de>
References: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56404 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaFEVO7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 17:14:59 -0400
In-Reply-To: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ludovic Desroches <ludovic.desroches@atmel.com>

This avoids a build error due to the use of flush_dcache_page.

drivers/mmc/host/atmel-mci.c: In function 'atmci_read_data_pio':
drivers/mmc/host/atmel-mci.c:1870:5: error: implicit declaration of function 'flush_dcache_page' [-Werror=implicit-function-declaration]
     flush_dcache_page(sg_page(sg));
     ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index aece7ca..bb585d9 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -37,6 +37,7 @@
 #include <linux/atmel-mci.h>
 #include <linux/atmel_pdc.h>
 
+#include <asm/cacheflush.h>
 #include <asm/io.h>
 #include <asm/unaligned.h>
 
-- 
1.8.3.2

