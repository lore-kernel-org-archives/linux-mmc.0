From: Venkatraman S <svenkatr@gmail.com>
Subject: [PATCH] mmc: omap_hsmmc: MAINTAINERS: change omap_hsmmc maintenance to orphan
Date: Wed, 16 Jan 2013 19:00:26 +0530
Message-ID: <1358343026-17198-1-git-send-email-svenkatr@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:51801 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663Ab3APNav (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 08:30:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Venkatraman S <svenkatr@gmail.com>

The specified email id is no longer in service.
Update the OMAP HSMMC entry from the MAINTAINERS file as I will
no longer be able to maintain this driver.

Signed-off-by: Venkatraman S <svenkatr@gmail.com>
---
 MAINTAINERS |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5b31f..95778e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5499,10 +5499,8 @@ S:	Maintained
 F:	drivers/mmc/host/omap.c
 
 OMAP HS MMC SUPPORT
-M:	Venkatraman S <svenkatr@ti.com>
-L:	linux-mmc@vger.kernel.org
 L:	linux-omap@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/mmc/host/omap_hsmmc.c
 
 OMAP RANDOM NUMBER GENERATOR SUPPORT
-- 
1.7.10.4

