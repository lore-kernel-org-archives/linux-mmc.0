Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D5C433DB
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2352664F5A
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhCDAAW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377226AbhCCMWg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 07:22:36 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EE5C0617A9
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 04:20:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id k9so16848039lfo.12
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 04:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vf8w2DOx9jzNzEvSal2fcDgyCGSYzKizUYKhFMSZIWY=;
        b=b+YOBur+UNT3fr1MydkfahrEEu0JFWr+GUvB+DTkjYwK3771dYvme0s6U/30Qq2qVU
         aGyBROFh+WGe8PSdgsVYxWFKg/xBEe13a2dYCdKNBCdPhAKCNjgUNl97HkNkwNZluNMB
         9jXhYjoCW8IRDeNORW4rAqeKcEnNtUGSVw2Rer0Utm4lRD/wkuX/Jwiji31TkuBx7xm1
         b9N+DmuUo0YQWje6iiV0e9loryhhKnXDI0Fcgy9csg4UgsaeIPANALzEQi5g7SPKzkuC
         Uqi6y1VTOsGtTrdsxUqLWAKM0zy+v/tx1OCd3GG5hoE2kux5vbGhKOqUC/xB/r5JQS8T
         dw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vf8w2DOx9jzNzEvSal2fcDgyCGSYzKizUYKhFMSZIWY=;
        b=rCKOCHo8N1hShGWzA2+LVsP/SbH9O4gn5Bcyb7rd4/TppmF21rUissjA8DaFSxs38+
         pdE8WLfj4U73MjZR3PShpa8/X7buQANprOBF3cf1/hJEZHLwUD+ZW+3HyK3sJChI7EJu
         u9A+KrqFhx4T0bN+cIsfBqfdmrI+5x6+EuXZ2VZ30w92jLsyBTTrSojLuXN1IajVKFkk
         OhKW0UjocpDcJS/RBLEy+QXysdofCiubhmN41rcSc8GjRjj26yoK+gOXB2ZCQjD0D2Uk
         nA/VMM2NSQqJFMW5Y6dZ9Y9dz/nw9Pomvx2fvGbN0UVCBfjNV820ax7SWYIKmbujhD4f
         BEuQ==
X-Gm-Message-State: AOAM532War5Jw2zcqm2KmB/rdIaDqLyFs8spzv0UY9fomLo7H7Q/B7UT
        dy52J2YLtwN2T1yfquUhL406ejSdcy6/Ag==
X-Google-Smtp-Source: ABdhPJyejyZYo5gNNlhWEICEam/nrx5cNRlHDqbjVPosD7259wOXYQnbJgEu1XQs1VsA48M6VuUiPg==
X-Received: by 2002:a19:4101:: with SMTP id o1mr14056347lfa.16.1614774056786;
        Wed, 03 Mar 2021 04:20:56 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id d3sm811519lfq.249.2021.03.03.04.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:20:55 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: block: Simplify logging during probe about added partitions
Date:   Wed,  3 Mar 2021 13:20:48 +0100
Message-Id: <20210303122049.151986-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303122049.151986-1-ulf.hansson@linaro.org>
References: <20210303122049.151986-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To simplify the code, move the logging into the common mmc_blk_alloc_req()
and drop the rather useless information about the partition type/id.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index dc6b2e8f4f95..39308b35a1fb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2261,6 +2261,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
+	char cap_str[10];
 
 	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
 	if (devidx < 0) {
@@ -2365,6 +2366,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		blk_queue_write_cache(md->queue.queue, true, true);
 	}
 
+	string_get_size((u64)size, 512, STRING_UNITS_2,
+			cap_str, sizeof(cap_str));
+	pr_info("%s: %s %s %s %s\n",
+		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
+		cap_str, md->read_only ? "(ro)" : "");
+
 	return md;
 
  err_putdisk:
@@ -2407,7 +2414,6 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 			      const char *subname,
 			      int area_type)
 {
-	char cap_str[10];
 	struct mmc_blk_data *part_md;
 
 	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
@@ -2417,11 +2423,6 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 	part_md->part_type = part_type;
 	list_add(&part_md->part, &md->part);
 
-	string_get_size((u64)get_capacity(part_md->disk), 512, STRING_UNITS_2,
-			cap_str, sizeof(cap_str));
-	pr_info("%s: %s %s partition %u %s\n",
-	       part_md->disk->disk_name, mmc_card_id(card),
-	       mmc_card_name(card), part_md->part_type, cap_str);
 	return 0;
 }
 
@@ -2558,9 +2559,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 	string_get_size((u64)size, 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
 
-	pr_info("%s: %s %s partition %u %s, chardev (%d:%d)\n",
-		rpmb_name, mmc_card_id(card),
-		mmc_card_name(card), EXT_CSD_PART_CONFIG_ACC_RPMB, cap_str,
+	pr_info("%s: %s %s %s, chardev (%d:%d)\n",
+		rpmb_name, mmc_card_id(card), mmc_card_name(card), cap_str,
 		MAJOR(mmc_rpmb_devt), rpmb->id);
 
 	return 0;
@@ -2876,7 +2876,6 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
-	char cap_str[10];
 
 	/*
 	 * Check that the card supports the command class(es) we need.
@@ -2897,12 +2896,6 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (IS_ERR(md))
 		return PTR_ERR(md);
 
-	string_get_size((u64)get_capacity(md->disk), 512, STRING_UNITS_2,
-			cap_str, sizeof(cap_str));
-	pr_info("%s: %s %s %s %s\n",
-		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
-		cap_str, md->read_only ? "(ro)" : "");
-
 	if (mmc_blk_alloc_parts(card, md))
 		goto out;
 
-- 
2.25.1

