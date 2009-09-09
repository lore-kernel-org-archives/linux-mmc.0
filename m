From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 21/30] omap_hsmmc: fix NULL pointer dereference
Date: Wed, 09 Sep 2009 14:59:11 +0300
Message-ID: <20090909115911.12833.58886.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51620 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbZIIL71 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:59:27 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Pierre Ossman <pierre@ossman.eu>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

>From bd81dee10c08ae9290c9a6170584549c15bc43d0 Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Tue, 12 May 2009 19:46:14 +0300
Subject: [PATCH] omap_hsmmc: fix NULL pointer dereference

Do not call 'mmc_omap_xfer_done()' if the request is
already done.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d6bf65b..243ad97 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -670,7 +670,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 
 	if (end_cmd || ((status & CC) && host->cmd))
 		mmc_omap_cmd_done(host, host->cmd);
-	if (end_trans || (status & TC))
+	if ((end_trans || (status & TC)) && host->mrq)
 		mmc_omap_xfer_done(host, data);
 
 	return IRQ_HANDLED;
-- 
1.5.6.3

