Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A760C636CB
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 02:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B26610A2
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 02:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhGSCVN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Jul 2021 22:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhGSCVL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Jul 2021 22:21:11 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87147C061765;
        Sun, 18 Jul 2021 19:18:11 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i4so7652619qvq.10;
        Sun, 18 Jul 2021 19:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F05MjF1EjPo9ALm7Ep9kFMbBo/dzAk/z9NhYdhgbLQU=;
        b=c2JnXWJDh86iqNrQ6XAfurPn8Ie54j98BTn8TjxSUeD7s2VhqxnTAPDTOaWsh/Jc8N
         OFH55XkPpYC2ZkF3rR0Mue2csD7bqk5bdHV/IqKmyPtq2iHFKOcRe5MysqBwR6ekRbm4
         skimyqWhoJWEVo0FU1E8ofgjIghmwyuDm+aF9W5TN4Vg8izknB8DLlPJ9WVAl308AGgB
         XskN6a3h24i5tPll4sDkRqkESVOEgyJxW1+IqjqTfLgn2X5ljk7QTxnAisLlnwD9clyN
         /Lmd8rWgVe8ypGcdM4ubs6cuEYrkAC9rIJTL4U7zJVKPCH6LYe5OsRbL/BJ+X4evGqSU
         lHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F05MjF1EjPo9ALm7Ep9kFMbBo/dzAk/z9NhYdhgbLQU=;
        b=MS4mHwonRExbydDk9c0CUznA1GQuVoQ5Wc/GpQvJCS6AkrHC62E4SDl5SIfw6qiWrX
         VHZ5AGVtMrSFHxpcDWM6AokkMe891ZtshaLRXMqa1PPhZxbQ3w9pwgI2is73/iW73NTu
         aVqHVMFLu9m1J/aYbbDos3E88BcCxNtGzbTGnKzuWZOHhuM9tiuLoXwB1Q2GEYAyKcHH
         g9vCIwnHL3w4p+ZQ1UzLp1hSzxRGyBq3o0J2CYdBva3hR5HLrQGWS4MyDmM3Sqp7Ds79
         NBf+U5iCwl4pyD3lVyWlFucobzaWvjjXqlKU4JtRjx64pTEgKJeG64t3gnIXc5lpg2mx
         eVyQ==
X-Gm-Message-State: AOAM531rijq8pydszERnhjV9UH4nGHBOONw1rgIUcQMdV14/rTj+fHf7
        Nn17iorvknJ/373yMhn9iXpGgZWIgiM=
X-Google-Smtp-Source: ABdhPJw5IaXLvY4GY3gixUsEQH1zgiCmVLiM4jB+jFuk8uQo1DBCTKt27AdmcwKgHMmo4ADCH4O/UQ==
X-Received: by 2002:ad4:5c49:: with SMTP id a9mr13679048qva.27.1626661090504;
        Sun, 18 Jul 2021 19:18:10 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id k10sm54870qtp.76.2021.07.18.19.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 19:18:10 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mmc@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] lib: bitmap: add performance test for bitmap_print_to_pagebuf
Date:   Sun, 18 Jul 2021 19:17:54 -0700
Message-Id: <20210719021755.883182-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719021755.883182-1-yury.norov@gmail.com>
References: <20210719021755.883182-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Functional tests for bitmap_print_to_pagebuf() are provided
in lib/test_printf.c. This patch adds performance test for
a case of fully set bitmap.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4ea73f5aed41..452d525007da 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -430,6 +430,42 @@ static void __init test_bitmap_parselist(void)
 	}
 }
 
+static void __init test_bitmap_printlist(void)
+{
+	unsigned long *bmap = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char expected[256];
+	int ret, slen;
+	ktime_t time;
+
+	if (!buf || !bmap)
+		goto out;
+
+	memset(bmap, -1, PAGE_SIZE);
+	slen = snprintf(expected, 256, "0-%ld", PAGE_SIZE * 8 - 1);
+	if (slen < 0)
+		goto out;
+
+	time = ktime_get();
+	ret = bitmap_print_to_pagebuf(true, buf, bmap, PAGE_SIZE * 8);
+	time = ktime_get() - time;
+
+	if (ret != slen + 1) {
+		pr_err("bitmap_print_to_pagebuf: result is %d, expected %d\n", ret, slen);
+		goto out;
+	}
+
+	if (strncmp(buf, expected, slen)) {
+		pr_err("bitmap_print_to_pagebuf: result is %s, expected %s\n", buf, expected);
+		goto out;
+	}
+
+	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+out:
+	kfree(buf);
+	kfree(bmap);
+}
+
 static const unsigned long parse_test[] __initconst = {
 	BITMAP_FROM_U64(0),
 	BITMAP_FROM_U64(1),
@@ -669,6 +705,7 @@ static void __init selftest(void)
 	test_bitmap_arr32();
 	test_bitmap_parse();
 	test_bitmap_parselist();
+	test_bitmap_printlist();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
 	test_bitmap_cut();
-- 
2.30.2

