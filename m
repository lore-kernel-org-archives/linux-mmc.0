Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F417C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Apr 2022 20:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbiDYU74 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245166AbiDYU7z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2022 16:59:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7715E1E3C8
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2022 13:56:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p12so22870354lfs.5
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2022 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QbpvztQHTBeQ0MfRjFIIaZe8+ZCflWIhrMb2PQpfouo=;
        b=yoNgt5m0oawkhpVVymyS3awSI/jBqYpS3V0Labe0qC+Ilgy/Z4ISLxeGwrQV4yLk2Z
         XrvDjC0ncriw88D2xRd8xkTyVIbdnjfs0JZyXsC+SW+F+9oeKB/ToGkw7MNmoIidtLLQ
         2YZrpyEu6AyxYFa06cPOgRl3CyNG4S2ZblnwSMKN0yJOUrMNSPR120YKHiD2n+/o2XCF
         ciTxGzPRT35J9Qa39LOAAigsVmGDo6szhHKZTvIfjLTSnL0OiIct5dCZe3r/76IK5qa4
         TchpZs6YScRgJao8DMWjCpNt6Ms4lODwxT2/vLHdti3Bix/6WEh8DKJyEiP2P0PW4clB
         3vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QbpvztQHTBeQ0MfRjFIIaZe8+ZCflWIhrMb2PQpfouo=;
        b=LdDSRWK1FwNDhqsdksriC5ODmMfrD7KlhWz/mcPjx5Cyp0VQHNAr4SKu4NW2utkhca
         kWit1r/yJ4O9Qgr//pNIZqSsDGyeszWZB3Wlh3DFHs0gnDrIwsj3vtEAFg1goTuv9Mny
         Gil87KxW/Obo5t9Ui9MPsB4xc5Zd5iOSeIOMS1JXiZFD0NjblgbTvCwdmY3QuwfsG0ef
         bHeHp3gdKGD6222UeXaz5OQ86iowa3Ac4eveKvGFKBHmK6c6AMalPaWGpUQexvt1zCIt
         8JcxdUfWMRzz94liudvEXSRarUz3DVTaf6zS2U1zosXQ96llOfsBTIdyghvQlkAnPo0z
         nwKw==
X-Gm-Message-State: AOAM531w0izjOXEkDpwHaxjZUY7NjrbS78BNDrqclwMG1ceQEpyGfiQ+
        LW7UDjXl7KK0M4VYb6YU6gFQ5HnTLheUTw==
X-Google-Smtp-Source: ABdhPJyHmQ+OFy5wCJbG5T6G6rVcanBr4SwSIgz4QV8i4wzFEwDYftJ+FgXwjzeXV97ZJtgtRuMJ/A==
X-Received: by 2002:a05:6512:33d0:b0:471:54b4:4dd7 with SMTP id d16-20020a05651233d000b0047154b44dd7mr13832378lfg.283.1650920205477;
        Mon, 25 Apr 2022 13:56:45 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e2e16000000b0024db885d41asm1309764lju.53.2022.04.25.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:56:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] mmc: core: Add CIDs for cards to the entropy pool
Date:   Mon, 25 Apr 2022 22:54:42 +0200
Message-Id: <20220425205442.1347837-1-linus.walleij@linaro.org>
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
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Move the device_add_randomness() into each mmc_decode_cid()
  function for MMC and SD card.
- Use the raw cid, no reason to unpack the data before using
  it for this purpose.
---
 drivers/mmc/core/mmc.c | 7 +++++++
 drivers/mmc/core/sd.c  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6b78ae45c4c9..9804a06ffadd 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/random.h>
 #include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
@@ -71,6 +72,12 @@ static int mmc_decode_cid(struct mmc_card *card)
 {
 	u32 *resp = card->raw_cid;
 
+	/*
+	 * Add the raw card ID (cid) data to the entropy pool. It doesn't
+	 * matter that not all of it is unique, it's just bonus entropy.
+	 */
+	add_device_randomness(&card->raw_cid, sizeof(card->raw_cid));
+
 	/*
 	 * The selection of the format here is based upon published
 	 * specs from sandisk and from what people have reported.
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 68df6b2f49cc..c5f1df6ce4c0 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/random.h>
 #include <linux/scatterlist.h>
 #include <linux/sysfs.h>
 
@@ -83,6 +84,12 @@ void mmc_decode_cid(struct mmc_card *card)
 {
 	u32 *resp = card->raw_cid;
 
+	/*
+	 * Add the raw card ID (cid) data to the entropy pool. It doesn't
+	 * matter that not all of it is unique, it's just bonus entropy.
+	 */
+	add_device_randomness(&card->raw_cid, sizeof(card->raw_cid));
+
 	/*
 	 * SD doesn't currently have a version field so we will
 	 * have to assume we can parse this.
-- 
2.35.1

