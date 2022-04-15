Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44113C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Apr 2022 22:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiDOWeK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiDOWeJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2022 18:34:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22448A66D2
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2022 15:31:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q14so10760819ljc.12
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2022 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BMwgeUc0Xlg6VZQXkagjAPImol7moZt3g1QrQ8J3cE=;
        b=o0YbJ3KmGMaP4t9lgo4TanbSifySGtdvSclzWyUfZtXCJBgKvSenvn7tJtj/cF4A5R
         keGFWC3/saB9m/cozTVwEMIc6KHgcL+Rll8p8uvekk/1dyN3s38go7jgKBCZHQj1QK1G
         UZiO96IfLGE2QJLWT2N/q4iNeRSVO77BOtOFu9hHreQbFBINwWwfs+uBpobhI9KHt8hh
         BdwQCLgtz9/Eokw+uehxUeCWH9vljX/NyH1TQePNk1IaTjPe2kNcqRyuNVa5X3DmJjoO
         dDA29xBv9Nehbb0fuIjFpOW7j0lzGda3zi+c9tmwvQdioPUyI6LmYdRux/a4fLwn7SrE
         ehYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BMwgeUc0Xlg6VZQXkagjAPImol7moZt3g1QrQ8J3cE=;
        b=JdzQXWKMVbTVLGDwX1JT7ho84P1ynuV4b7sqlyXtEkFbmaUjImLsj+jSwnMNvNR5EZ
         O0vmurkjpvrMV5jf6gs7eOUFrlLDj/TNCh605/bRjFNJW1iuYWIkmZZYG82U7Pfj5ijy
         ZhMBhzxKarj+7p+bPkCdbVYFSjrV07RlVfqvlZy+QnZX7WZI8QDvt78wCWUxrKTLL8xC
         5BQ/wRxS/NiaUWMNpLcsFzrAUKHEuv6d8QdlxgypkShxWEcVfCUfPJZ+IaTZ6eqMopoU
         5Rmrw0DGG40dJXM5h3W962pInWTaWM2p0FOrccQK2Rdxt6gvpkZ9AoHZ0S3v9OsS3KST
         EYCw==
X-Gm-Message-State: AOAM530onX/n5Jg+gmuo24vJzI6U01CoBidvNkNHPe4Lo3s1Ze6/y7vl
        sFsu2irusAYQZPOfobqw2lyYFqJ+Y+hVUQ==
X-Google-Smtp-Source: ABdhPJwTBKKSqMUCZYq6H0Hz1ILRZbH+J4JKo/I0GoWh6MVfGDXGSEIvXDwFQzJL6RqJ3r8Gj/nX4Q==
X-Received: by 2002:a05:651c:545:b0:24d:b084:a673 with SMTP id q5-20020a05651c054500b0024db084a673mr88748ljp.461.1650061897097;
        Fri, 15 Apr 2022 15:31:37 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id n23-20020a056512311700b0046b926fd343sm469679lfb.142.2022.04.15.15.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 15:31:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] mmc: core: Add CIDs for cards to the entropy pool
Date:   Sat, 16 Apr 2022 00:29:31 +0200
Message-Id: <20220415222931.481352-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To make the entropy pool a bit better we can toss in the
CID for eMMC and SD cards into it, usually the serial
number portion is at least unique.

This does not count as improvement of the entropy but
in practice it makes it a bit more random to mix in these
numbers.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/mmc.c | 7 +++++++
 drivers/mmc/core/sd.c  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e7ea45386c22..974d8a02b966 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/random.h>
 #include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
@@ -1673,6 +1674,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_decode_cid(card);
 		if (err)
 			goto free_card;
+		/*
+		 * Add card ID (cid) data to the entropy pool.
+		 * It doesn't matter that not all of it is unique,
+		 * it's just bonus entropy.
+		 */
+		add_device_randomness(&card->cid, sizeof(card->cid));
 	}
 
 	/*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 68df6b2f49cc..65e0ac031e2a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/random.h>
 #include <linux/scatterlist.h>
 #include <linux/sysfs.h>
 
@@ -1443,6 +1444,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 
 		mmc_decode_cid(card);
+		/*
+		 * Add card ID (cid) data to the entropy pool.
+		 * It doesn't matter that not all of it is unique,
+		 * it's just bonus entropy.
+		 */
+		add_device_randomness(&card->cid, sizeof(card->cid));
 	}
 
 	/*
-- 
2.35.1

