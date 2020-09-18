Return-Path: <SRS0=X25L=C3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DE8C43463
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 03:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422AA20678
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 03:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600398720;
	bh=C38Pw512GiRJJmiYpDblaE9vHIMrSG1yDZ7v6tJDsU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w9XIigS4TF2vZwKhTvObI0E4MsBtvGcO3Qw9IHKJ2zoNclhp3IrwM3T8Hehoz1etK
	 DVHl2l4KzYvIsok7G+tVKN1YgkN3T6SmAyQ9InIY6COoMPT5esBNQlz9kq6gfBUkti
	 WMRMhmlU7LybWgysVkPoXdQ4bdkemvw+Jcml4n7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIRDLp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgIRCCR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Sep 2020 22:02:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AC72344C;
        Fri, 18 Sep 2020 02:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600394536;
        bh=C38Pw512GiRJJmiYpDblaE9vHIMrSG1yDZ7v6tJDsU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWFQ1Z+pP2Ga5y5/JzDQla4q/lW+5xJApKIgVSINGmEikpfl9ULw/0OPc2sKXwAuO
         GLvQJ85l8PGdBOANE6QkI1u1u6CfdWjgaKNX5KJFQJ10by+iP/cT+u221x1Vjl+VJJ
         hu24/ioJer3q1+FLWGWAMGVdgj3lyRfy2B+KNNEM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bradley Bolen <bradleybolen@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 055/330] mmc: core: Fix size overflow for mmc partitions
Date:   Thu, 17 Sep 2020 21:56:35 -0400
Message-Id: <20200918020110.2063155-55-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bradley Bolen <bradleybolen@gmail.com>

[ Upstream commit f3d7c2292d104519195fdb11192daec13229c219 ]

With large eMMC cards, it is possible to create general purpose
partitions that are bigger than 4GB.  The size member of the mmc_part
struct is only an unsigned int which overflows for gp partitions larger
than 4GB.  Change this to a u64 to handle the overflow.

Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/mmc.c   | 9 ++++-----
 include/linux/mmc/card.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b7159e243323b..de14b5845f525 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -297,7 +297,7 @@ static void mmc_manage_enhanced_area(struct mmc_card *card, u8 *ext_csd)
 	}
 }
 
-static void mmc_part_add(struct mmc_card *card, unsigned int size,
+static void mmc_part_add(struct mmc_card *card, u64 size,
 			 unsigned int part_cfg, char *name, int idx, bool ro,
 			 int area_type)
 {
@@ -313,7 +313,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 {
 	int idx;
 	u8 hc_erase_grp_sz, hc_wp_grp_sz;
-	unsigned int part_size;
+	u64 part_size;
 
 	/*
 	 * General purpose partition feature support --
@@ -343,8 +343,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 				(ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1]
 				<< 8) +
 				ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
-			part_size *= (size_t)(hc_erase_grp_sz *
-				hc_wp_grp_sz);
+			part_size *= (hc_erase_grp_sz * hc_wp_grp_sz);
 			mmc_part_add(card, part_size << 19,
 				EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
 				"gp%d", idx, false,
@@ -362,7 +361,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 {
 	int err = 0, idx;
-	unsigned int part_size;
+	u64 part_size;
 	struct device_node *np;
 	bool broken_hpi = false;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index e459b38ef33cc..cf3780a6ccc4b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -226,7 +226,7 @@ struct mmc_queue_req;
  * MMC Physical partitions
  */
 struct mmc_part {
-	unsigned int	size;	/* partition size (in bytes) */
+	u64		size;	/* partition size (in bytes) */
 	unsigned int	part_cfg;	/* partition type */
 	char	name[MAX_MMC_PART_NAME_LEN];
 	bool	force_ro;	/* to make boot parts RO by default */
-- 
2.25.1

