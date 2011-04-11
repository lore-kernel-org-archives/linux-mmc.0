From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH 1/2] MMC: Support for block quirks.
Date: Mon, 11 Apr 2011 17:20:40 -0500
Message-ID: <1302560441-10565-2-git-send-email-andreiw@motorola.com>
References: <1302560441-10565-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:50878 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab1DKVlm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 17:41:42 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BLdrQv021402
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:39:53 -0400 (EDT)
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com [209.85.213.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BLdrvu021397
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:39:53 -0400 (EDT)
Received: by ywh1 with SMTP id 1so4181401ywh.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 14:41:40 -0700 (PDT)
In-Reply-To: <1302560441-10565-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

Block quirks implemented using core/quirks.c support.

Change-Id: I81d9ad57a7ae95c60ee8026f090c8df7c75fd069
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 91a6767..823f295 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -755,6 +755,11 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
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
@@ -782,6 +787,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 		cap_str, md->read_only ? "(ro)" : "");
 
 	mmc_set_drvdata(card, md);
+	mmc_fixup_device(card, blk_fixups);
 	add_disk(md->disk);
 	return 0;
 
-- 
1.7.0.4

