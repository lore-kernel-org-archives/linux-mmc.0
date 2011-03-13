From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH 2/2] MMC: Support for block quirks.
Date: Sun, 13 Mar 2011 08:48:38 -0500
Message-ID: <1300024118-23771-3-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:49900 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605Ab1CMNFi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 09:05:38 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2DD4EZD016904
	for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 09:04:14 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2DD4Axc016876
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 09:04:14 -0400 (EDT)
Received: by mail-gy0-f170.google.com with SMTP id 11so1008417gyb.15
        for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 06:05:37 -0700 (PDT)
In-Reply-To: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tardyp@gmail.com, linus.walleij@linaro.org, arnd@arndb.de, Andrei Warkentin <andreiw@motorola.com>

Block quirks implemented using core/quirks.c support.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7054fd5..913f394 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -686,6 +686,11 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 	return 0;
 }
 
+static const struct mmc_fixup blk_fixups[] =
+{
+	END_FIXUP
+};
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md;
@@ -714,6 +719,8 @@ static int mmc_blk_probe(struct mmc_card *card)
 		cap_str, md->read_only ? "(ro)" : "");
 
 	mmc_set_drvdata(card, md);
+	mmc_fixup_device(card, blk_fixups);
+
 #ifdef CONFIG_MMC_BLOCK_DEFERRED_RESUME
 	mmc_set_bus_resume_policy(card->host, 1);
 #endif
-- 
1.7.0.4

