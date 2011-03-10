From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 3/5] MMC: Support for block quirks.
Date: Wed,  9 Mar 2011 18:54:07 -0600
Message-ID: <1299718449-15172-4-git-send-email-andreiw@motorola.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:53694 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1CJAKn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:10:43 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A09NFk017033
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:09:23 -0500 (EST)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A09Mjb017013
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:09:23 -0500 (EST)
Received: by mail-gx0-f170.google.com with SMTP id 1so736041gxk.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:10:42 -0800 (PST)
In-Reply-To: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Block quirks implemented using core/quirks.c support.

Change-Id: I81d9ad57a7ae95c60ee8026f090c8df7c75fd069
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

