From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 13/30] omap_hsmmc: set open drain bit correctly
Date: Wed, 09 Sep 2009 14:58:10 +0300
Message-ID: <20090909115810.12833.65502.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24423 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbZIIL6A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:58:00 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Pierre Ossman <pierre@ossman.eu>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

>From ca1bda2fa518c0263af943ffd953ab59515c949d Mon Sep 17 00:00:00 2001
From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Date: Thu, 23 Apr 2009 16:44:58 +0300
Subject: [PATCH] omap_hsmmc: set open drain bit correctly

The code could set the bit to 1 but not reset it to 0.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d5e4f08..e0b9c49 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1111,9 +1111,11 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (do_send_init_stream)
 		send_init_stream(host);
 
+	con = OMAP_HSMMC_READ(host->base, CON);
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
-		OMAP_HSMMC_WRITE(host->base, CON,
-				OMAP_HSMMC_READ(host->base, CON) | OD);
+		OMAP_HSMMC_WRITE(host->base, CON, con | OD);
+	else
+		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
 
 	mmc_host_lazy_disable(host->mmc);
 }
-- 
1.5.6.3

