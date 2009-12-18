From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 2/3] mmc_block: fix probe error cleanup bug
Date: Fri, 18 Dec 2009 14:15:41 +0200
Message-ID: <20091218121541.4351.46593.sendpatchset@ahunter-work.research.nokia.com>
References: <20091218121527.4351.14601.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38272 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZLRMQw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2009 07:16:52 -0500
In-Reply-To: <20091218121527.4351.14601.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

>From b61100e0ec8f994bca8d1dc423870bdf158b733e Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Wed, 11 Nov 2009 11:52:21 +0200
Subject: [PATCH] mmc_block: fix probe error cleanup bug

If mmc_blk_set_blksize() fails mmc_blk_probe() the request queue and
its thread have been set up and they need to be shut down properly before
putting the disk.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/block.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 5988573..ee87911 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -618,6 +618,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 	return 0;
 
  out:
+	mmc_cleanup_queue(&md->queue);
 	mmc_blk_put(md);
 
 	return err;
-- 
1.6.0.4

