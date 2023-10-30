Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1061C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Oct 2023 06:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjJ3GWn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Oct 2023 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjJ3GWm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Oct 2023 02:22:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8FC1
        for <linux-mmc@vger.kernel.org>; Sun, 29 Oct 2023 23:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698646960; x=1730182960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xwQQiJz3r6MkImdDJ73RhT+2aEKHqcVjy2pbPS9h2X8=;
  b=WmTrTDoSor7Hf4nbcwiTiEVN7usG6+u2S8MNVgWgZULOTBYQu669faNc
   7bQhMYQEJbEvO8wTPIntIA9xOoEKHYrf7mbK+fyBoN0uK06Q24EIDUhEt
   lmRFzw84zbNveRq42VYGa/z/jz4Xk7SjwnyzsHJ5o/OQ8P6371Yj+eIYM
   wbYLN/PxZpE6r5lmZNygecrW1CbsXOHTXvRqfZyRbtgtVK3/9S/o/BtgT
   y2u5Nt6G+bRXUTGWcGe8RtXp56c5zLSSe2LmGitjrYhqcOtYSGPeqByk2
   AAgyJVbVMJ7fzGiQ8faEYewdEIIumwmnJyuMUVQrSmWVcf+KseHzZJiFP
   g==;
X-CSE-ConnectionGUID: wdA6cdHqTwuM1T2uJvYZuA==
X-CSE-MsgGUID: UUUwVQ3iTNidmNMCt81Jyg==
X-IronPort-AV: E=Sophos;i="6.03,262,1694707200"; 
   d="scan'208";a="1036977"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2023 14:22:38 +0800
IronPort-SDR: Vrr8mqiv1gM6kshda6vIC+dXv7XrKrj2YW7bizHtRvYcdAWK7dSeL6IQPV+rozy5EkeB7B8Ak9
 eftOyFU0PpHMJToFINwnqbYB5pny2kLSi8rkIKqUroOcyxb4iyVrCMBTMSlzQXfhylHzAiiR5J
 s7GEpstq34d8n3p0MqAVEpyofhSIs/ergPUJORf6clQPGYtAhL3r/CMt67e6w5p4sWeepUg1YR
 JItXGS8pcpvr7Nw7wamaSgZmdZV2cM/AV/aQNyNWUR91HK7823hmlQwsJak5SDYrs9/i94wWtp
 RbI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2023 22:34:25 -0700
IronPort-SDR: /mTdG0tIWlmzxoHpqmbes44BRurAvlIrqGCXAsydAOuN7mp5F3VEnh9OdwGlWE/BbcedBem0j2
 tSDP4rwFLjBhD53yV++mVlvWV4QKbE0g3ZTL+Ou/SJEWt2KhEqMKhMdL3+r1fhQWIrvjE+sWkV
 LqZB3vYSQq58+8aoeKdHKRbfr8lpik1hdwmZ7eBWyFmG13OTf1dZMBIhnWElaMSDuSho7SOuHm
 MJBuhl9yxEkTrEKOQFThuNfwAiZ2+zkDuD9BVYGyLPk+V4Rv7+CrSoEhDpGwopHJ0mJfAiLhGa
 yUA=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2023 23:22:38 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc: core: Remove packed command leftovers
Date:   Mon, 30 Oct 2023 08:22:26 +0200
Message-Id: <20231030062226.1895692-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Packed commands support was removed long time ago, but some bits got
left behind. Remove them.

Fixes: 03d640ae1f9b (mmc: block: delete packed command support)
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/mmc.c   |  5 -----
 include/linux/mmc/card.h |  3 ---
 include/linux/mmc/core.h |  1 -
 include/linux/mmc/mmc.h  | 10 ----------
 4 files changed, 19 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8180983bd402..5e577aa31bf2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -613,11 +613,6 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		} else {
 			card->ext_csd.data_tag_unit_size = 0;
 		}
-
-		card->ext_csd.max_packed_writes =
-			ext_csd[EXT_CSD_MAX_PACKED_WRITES];
-		card->ext_csd.max_packed_reads =
-			ext_csd[EXT_CSD_MAX_PACKED_READS];
 	} else {
 		card->ext_csd.data_sector_size = 512;
 	}
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index daa2f40d9ce6..24aaa819f9f0 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -52,9 +52,6 @@ struct mmc_ext_csd {
 	u8			part_config;
 	u8			cache_ctrl;
 	u8			rst_n_function;
-	u8			max_packed_writes;
-	u8			max_packed_reads;
-	u8			packed_event_en;
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		generic_cmd6_time;	/* Units: 10ms */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 6efec0b9820c..2c7928a50907 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -27,7 +27,6 @@ struct mmc_command {
 	u32			opcode;
 	u32			arg;
 #define MMC_CMD23_ARG_REL_WR	(1 << 31)
-#define MMC_CMD23_ARG_PACKED	((0 << 31) | (1 << 30))
 #define MMC_CMD23_ARG_TAG_REQ	(1 << 29)
 	u32			resp[4];
 	unsigned int		flags;		/* expected response type */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 6f7993803ee7..cf2bcb5da30d 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -257,8 +257,6 @@ static inline bool mmc_ready_for_data(u32 status)
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
-#define EXT_CSD_PACKED_FAILURE_INDEX	35	/* RO */
-#define EXT_CSD_PACKED_CMD_STATUS	36	/* RO */
 #define EXT_CSD_EXP_EVENTS_STATUS	54	/* RO, 2 bytes */
 #define EXT_CSD_EXP_EVENTS_CTRL		56	/* R/W, 2 bytes */
 #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
@@ -321,8 +319,6 @@ static inline bool mmc_ready_for_data(u32 status)
 #define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
-#define EXT_CSD_MAX_PACKED_WRITES	500	/* RO */
-#define EXT_CSD_MAX_PACKED_READS	501	/* RO */
 #define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
 #define EXT_CSD_HPI_FEATURES		503	/* RO */
 
@@ -402,18 +398,12 @@ static inline bool mmc_ready_for_data(u32 status)
 #define EXT_CSD_PWR_CL_8BIT_SHIFT	4
 #define EXT_CSD_PWR_CL_4BIT_SHIFT	0
 
-#define EXT_CSD_PACKED_EVENT_EN	BIT(3)
-
 /*
  * EXCEPTION_EVENT_STATUS field
  */
 #define EXT_CSD_URGENT_BKOPS		BIT(0)
 #define EXT_CSD_DYNCAP_NEEDED		BIT(1)
 #define EXT_CSD_SYSPOOL_EXHAUSTED	BIT(2)
-#define EXT_CSD_PACKED_FAILURE		BIT(3)
-
-#define EXT_CSD_PACKED_GENERIC_ERROR	BIT(0)
-#define EXT_CSD_PACKED_INDEXED_ERROR	BIT(1)
 
 /*
  * BKOPS status level
-- 
2.42.0

