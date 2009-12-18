From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] mmc: allow for MMC v4.4
Date: Fri, 18 Dec 2009 14:25:33 +0200
Message-ID: <4B2B74BD.7050405@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59879 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZLRM0m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2009 07:26:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Linux MMC Mailing List <linux-mmc@vger.kernel.org>

>From f296e2af6497a42f825ba37b138ec8db3e0eef61 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Wed, 16 Dec 2009 10:08:04 +0200
Subject: [PATCH] mmc: allow for MMC v4.4

JEDEC eMMC specification version 4.4 (MMCA 4.4) defines
Extended CSD structure versions up to 5.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/core/mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bfefce3..32af45c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -207,7 +207,7 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 	}
 
 	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
-	if (card->ext_csd.rev > 3) {
+	if (card->ext_csd.rev > 5) {
 		printk(KERN_ERR "%s: unrecognised EXT_CSD structure "
 			"version %d\n", mmc_hostname(card->host),
 			card->ext_csd.rev);
-- 
1.6.0.4
