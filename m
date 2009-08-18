From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH] Maintainers update for TI OMAP hsmmc driver
Date: Tue, 18 Aug 2009 21:44:20 +0530 (IST)
Message-ID: <43171.192.168.10.88.1250612060.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34324 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbZHRQO2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Aug 2009 12:14:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com, linux-omap@vger.kernel.org

Update maintainers entry for TI OMAP HS MMC support.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 MAINTAINERS |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/MAINTAINERS
===================================================================
--- linux-omap-2.6.orig/MAINTAINERS
+++ linux-omap-2.6/MAINTAINERS
@@ -3698,7 +3698,13 @@ OMAP MMC SUPPORT
 M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-F:	drivers/mmc/host/*omap*
+F:	drivers/mmc/host/omap.c
+
+OMAP HS MMC SUPPORT
+M:	Madhusudhan Chikkature <madhu.cr@ti.com>
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/omap_hsmmc.c

 OMAP RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>


