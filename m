From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 23/30] omap_hsmmc: clear interrupt status after init sequence
Date: Wed, 09 Sep 2009 14:59:26 +0300
Message-ID: <20090909115926.12833.41983.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43114 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbZIIL7s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:59:48 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Pierre Ossman <pierre@ossman.eu>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

>From 8cd514349f0a383b8e59172067ac4a3a8829b907 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 16 May 2009 09:35:17 +0300
Subject: [PATCH] omap_hsmmc: clear interrupt status after init sequence

Clear the interrupt status after sending the initialization sequence,
as specified in the TRM.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a669757..42f3aad 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -358,6 +358,10 @@ static void send_init_stream(struct mmc_omap_host *host)
 
 	OMAP_HSMMC_WRITE(host->base, CON,
 		OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
+
+	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+	OMAP_HSMMC_READ(host->base, STAT);
+
 	enable_irq(host->irq);
 }
 
-- 
1.5.6.3

