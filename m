From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH] Maintainers update for TI OMAP hsmmc driver
Date: Thu, 20 Aug 2009 04:16:57 +0530 (IST)
Message-ID: <43836.192.168.10.88.1250722017.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35272 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbZHSWrl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Aug 2009 18:47:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: jarkko.lavinen@nokia.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I have posted this patch to linux-mmc@vger.kernel.org list earlier. I am
reposting it to Andrew as I am not clear on the upstream path from
linux-mmc@vger.kernel.org list currently.

Regards,
Madhu
---

Update maintainers entry for TI OMAP HS MMC support.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 MAINTAINERS |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6/MAINTAINERS
===================================================================
--- linux-2.6.orig/MAINTAINERS
+++ linux-2.6/MAINTAINERS
@@ -3712,7 +3712,13 @@ OMAP MMC SUPPORT
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


