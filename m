Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3107C4332F
	for <linux-mmc@archiver.kernel.org>; Sun,  5 Nov 2023 10:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjKEKaC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 5 Nov 2023 05:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEKaC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Nov 2023 05:30:02 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E11E9
        for <linux-mmc@vger.kernel.org>; Sun,  5 Nov 2023 02:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699180199; x=1730716199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VggkHKDLYeblpM18nra18nF7SG37uGsrbCNlvqPYx8Y=;
  b=m75pBly3y+AHEeKg1zNLFwDl12pNymtZxxvNeKbfu4YFcYJFW99YTipD
   BYFXwAjDfkyuKTdsATwbcwdufPXEAB2a4I3tKe/CtsJE9vndu59vOaeyN
   id2Z/ZHfhguGuCkVMmHZBPG/I9WuXmHy1Z6SZakn9ORNaObOhmN247euP
   7XPTArFLxbENeZ2J+e/DB4qdcB2p2hxVQKONT4qIRQ4PsHMY/yTuu2l8W
   j6YhWPoFqT5hMrBhKR6Yru5u/n2bUlOoHXXW8rCeLwgjSw5TJjTWFPLWa
   gRjHu8GAwM7m9urD26UqgSn7zcN062+fGM94pbsOc15J4MjrrRvrV/VA7
   Q==;
X-CSE-ConnectionGUID: /1uDGNgYQA2vwTMXlX50Ng==
X-CSE-MsgGUID: U3gZmjoFQEaeddWHGL0VsQ==
X-IronPort-AV: E=Sophos;i="6.03,279,1694707200"; 
   d="scan'208";a="1391310"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2023 18:29:57 +0800
IronPort-SDR: V8C+cEWGf3/xzN0FVeDT+RTo6qI/Qc+WMgWPEf+Mbe90oRs0EMnGH4KkqUAPcfR41pCjBo98S5
 0rpyH/UsDBf6arR4B4C62l/80AuVzNnofVRfcErpC0uVlmI8GQ6v7CwqfZzzCz09+ayfcclZra
 c58LRsAlx7LLAWe3tZewH4dNTLZbabRXFVaLiAyCVT9WlYvNbOBXSgjKyWmWppnqOrAn0b+MTg
 G+Kw93l3fZ2ideEwDuI6iKtOZ3gsAqM5nC1YRIiiag6zSVnPjEHOQOsGfP+Skc/w0rsfnoTc6I
 /Lo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2023 01:41:36 -0800
IronPort-SDR: Dd0Pvl7Cykevt7x8aXMzXzici1ZYA6Gx4F8Ehuy1JvNhZEiD29iMxxlYTwJ3CdhGkdTNfmWunt
 FCzojHJhyRNX6NxhMeM9U+4bnA8PJTARcHpsW6fPKEcuyRwjuuFOIVxR3Yn17KKIp5xvMPS9sH
 UAypbnXwyW3gKYpQzp1q1TK3vu7z1qBhY4+oYN6O4FORQGEqPEllOrZC4dOZCBvH2+fzEV3WDp
 QU+EDfVJlJB3UfsNm4GXCZdh2A+sf4N/WewAer58I/AYFiZRgFT2ZonnzEzxO8WOVq27rNY0BL
 zf4=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Nov 2023 02:29:52 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc: core: Remove obsolete quirk for Sandisk cards
Date:   Sun,  5 Nov 2023 12:29:44 +0200
Message-Id: <20231105102944.1974512-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This quirk applies to an old set of Sandisk cards that are no longer
being sold for many years now, and it is vanishingly unlikely that will
ever meet a V6.7 kernel.

I came across those old cards when I tried to decide what to do with
Sandisk cards that their quirk is designated by OEM id. For many years
we read wrong oemid, reading 16 bits instead of 8. Fixing it however,
turned out to be impractical, and it's better that each eMMC vendor will
handle its own devices.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c  | 32 +-------------------------------
 drivers/mmc/core/quirks.h | 12 ------------
 include/linux/mmc/card.h  |  1 -
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..6aa68ac1129e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1122,17 +1122,7 @@ static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
 	nr = blk_rq_sectors(req);
 
 	do {
-		err = 0;
-		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
-			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					 INAND_CMD38_ARG_EXT_CSD,
-					 erase_arg == MMC_TRIM_ARG ?
-					 INAND_CMD38_ARG_TRIM :
-					 INAND_CMD38_ARG_ERASE,
-					 card->ext_csd.generic_cmd6_time);
-		}
-		if (!err)
-			err = mmc_erase(card, from, nr, erase_arg);
+		err = mmc_erase(card, from, nr, erase_arg);
 	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));
 	if (err)
 		status = BLK_STS_IOERR;
@@ -1182,17 +1172,6 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 		arg = MMC_SECURE_ERASE_ARG;
 
 retry:
-	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 INAND_CMD38_ARG_EXT_CSD,
-				 arg == MMC_SECURE_TRIM1_ARG ?
-				 INAND_CMD38_ARG_SECTRIM1 :
-				 INAND_CMD38_ARG_SECERASE,
-				 card->ext_csd.generic_cmd6_time);
-		if (err)
-			goto out_retry;
-	}
-
 	err = mmc_erase(card, from, nr, arg);
 	if (err == -EIO)
 		goto out_retry;
@@ -1202,15 +1181,6 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	}
 
 	if (arg == MMC_SECURE_TRIM1_ARG) {
-		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
-			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					 INAND_CMD38_ARG_EXT_CSD,
-					 INAND_CMD38_ARG_SECTRIM2,
-					 card->ext_csd.generic_cmd6_time);
-			if (err)
-				goto out_retry;
-		}
-
 		err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
 		if (err == -EIO)
 			goto out_retry;
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index cca71867bc4a..028f55f07ba3 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -22,18 +22,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 #define INAND_CMD38_ARG_SECERASE 0x80
 #define INAND_CMD38_ARG_SECTRIM1 0x81
 #define INAND_CMD38_ARG_SECTRIM2 0x88
-	/* CMD38 argument is passed through EXT_CSD[113] */
-	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM08G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM16G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM32G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-
 	/*
 	 * Some MMC cards experience performance degradation with CMD23
 	 * instead of CMD12-bounded multiblock transfers. For now we'll
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7b12eebc5586..edb27f3c6489 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -284,7 +284,6 @@ struct mmc_card {
 						/* (missing CIA registers) */
 #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
-#define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
 #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
 #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
 						/* byte mode */
-- 
2.42.0

