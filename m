From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 24/30] omap_hsmmc: cater for weird CMD6 behaviour
Date: Wed, 09 Sep 2009 14:59:34 +0300
Message-ID: <20090909115934.12833.48915.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43137 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbZIIL7y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:59:54 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>

>From 60731c064681d57c84ce563274f3f5869c598cce Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 16 May 2009 10:05:40 +0300
Subject: [PATCH] omap_hsmmc: cater for weird CMD6 behaviour

Sometimes the controller unexpectedly produces a TC (transfer
complete) interrupt before the CC (command complete) interrupt for
command 6 (SWITCH).  This is a problem because the CC interrupt
can get mixed up with the next request.  Add a hack for CMD6.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 42f3aad..205cc3a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -474,6 +474,13 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 	if (!data) {
 		struct mmc_request *mrq = host->mrq;
 
+		/* TC before CC from CMD6 - don't know why, but it happens */
+		if (host->cmd && host->cmd->opcode == 6 &&
+		    host->response_busy) {
+			host->response_busy = 0;
+			return;
+		}
+
 		host->mrq = NULL;
 		mmc_request_done(host->mmc, mrq);
 		return;
-- 
1.5.6.3

