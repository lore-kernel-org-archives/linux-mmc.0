From: akpm@linux-foundation.org
Subject: [patch 204/220] mxcmmc: fixed max_seg_size value on initialization
Date: Wed, 10 Mar 2010 15:23:57 -0800
Message-ID: <201003102323.o2ANNv4X010903@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43136 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755397Ab0CJXYQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2010 18:24:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, vzapolskiy@gmail.com, linux-mmc@vger.kernel.org, pierre@ossman.eu, s.hauer@pengutronix.de

From: Vladimir Zapolskiy <vzapolskiy@gmail.com>

This unpleasant typo appeared while porting the driver from Freescale
original sources, where anyone can easily find the correct version.

Current incorrect version potentially can influence segment and merge
handling in block subsystem via MMC request queue settings.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/mxcmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/mxcmmc.c~mxcmmc-fixed-max_seg_size-value-on-initialization drivers/mmc/host/mxcmmc.c
--- a/drivers/mmc/host/mxcmmc.c~mxcmmc-fixed-max_seg_size-value-on-initialization
+++ a/drivers/mmc/host/mxcmmc.c
@@ -708,7 +708,7 @@ static int mxcmci_probe(struct platform_
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 65535;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_seg_size;
+	mmc->max_seg_size = mmc->max_req_size;
 
 	host = mmc_priv(mmc);
 	host->base = ioremap(r->start, resource_size(r));
_
