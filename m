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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F96C636CD
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 02:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3822D611AC
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 02:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhGSCVN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Jul 2021 22:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhGSCVL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Jul 2021 22:21:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26BC061762;
        Sun, 18 Jul 2021 19:18:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id q15so7040752qtp.0;
        Sun, 18 Jul 2021 19:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7LGF7A24MqvtOPGVDdt9eL48iMH5UQbKnUazAYVpTs=;
        b=f3DJt2H0o9omDVvuQN5v1QSb/r6QSjoBV97l95h4zLyzLthlOdnOCwvg+HUNREWxyz
         o/swR0MA67DbNo0RhPjIpzAPMoH7INbTUYgfZkVYDlK5fogvieMixk1GssQ61ex62bag
         IOTixqiI8hrPRhtEhM/c4rJhLUk33yqtmA/fo/PdO9abiEkJNhFr1AXT3jb+/Ln8iUiw
         sVy0bhEIwuMbsdwyHfndj0Qgf34nneiEFhS+L6RIkVr5lS4RNmj2QSjW1yanNQ2XHpNs
         Im0v0WcyKkSx4kYtbzSpurvl+EqpE+ucHC+fOSLZNu6GCEiYByV+YFFI9UZQMfz21Opu
         RxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7LGF7A24MqvtOPGVDdt9eL48iMH5UQbKnUazAYVpTs=;
        b=rVFyBBEMV0CNYeOY1DpKuNh2vWfOJi2Oe9VmuL129hNuYmty9v0DfR/UYiyw8JJ955
         9wM8m2sqIbv81LUeREJLzIpiFUhmqWI3gTqQF9Z7yUV99tAxPWOJfQjlZtJ1Oy9t+Zl1
         HgcmgPSHtbltOau4RduA9RbGoFhleK02ggz5LqsOFK/UQGKsCPXLunbeY0HjzL/CXu68
         Xfxy9RQouwHyIvWZh9CiFXlCDUSsfCVbX1a6jaCsiMlzarkNK6iYnQxs2IDDPdPkRxU/
         3ZQ0vt+Re6GlHuaIefwV/FOI+AwNI7nYM2RGDkNuX/egdv8qT8rHXDupXEb30IewQjKD
         REaw==
X-Gm-Message-State: AOAM530TmpPUdDUGkrf0bOg9q+WYg0t6MpCXzEvF0CD66qBVbJWqDR8q
        bH2ncM4heD7T8Cb0mVFr7DHxCD0UvEU=
X-Google-Smtp-Source: ABdhPJxops0MED8R2XXX4dM9TVbDCyoBT8virK5Xmff0q2qDiCbX/HZRqNJl0c2CgnpKQuMoFQcJaQ==
X-Received: by 2002:ac8:7115:: with SMTP id z21mr14032886qto.85.1626661091797;
        Sun, 18 Jul 2021 19:18:11 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id d7sm6085796qth.70.2021.07.18.19.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 19:18:11 -0700 (PDT)
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
Subject: [PATCH 4/4] vsprintf: rework bitmap_list_string
Date:   Sun, 18 Jul 2021 19:17:55 -0700
Message-Id: <20210719021755.883182-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719021755.883182-1-yury.norov@gmail.com>
References: <20210719021755.883182-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

bitmap_list_string() is very ineffective when printing bitmaps with long
ranges of set bits because it calls find_next_bit() for each bit in the
bitmap.  We can do better by detecting ranges of set bits.

In my environment, before/after is 943008/31008 ns.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/vsprintf.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8b3f20051a..361799075706 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1241,20 +1241,13 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 			 struct printf_spec spec, const char *fmt)
 {
 	int nr_bits = max_t(int, spec.field_width, 0);
-	/* current bit is 'cur', most recently seen range is [rbot, rtop] */
-	int cur, rbot, rtop;
 	bool first = true;
+	int rbot, rtop;
 
 	if (check_pointer(&buf, end, bitmap, spec))
 		return buf;
 
-	rbot = cur = find_first_bit(bitmap, nr_bits);
-	while (cur < nr_bits) {
-		rtop = cur;
-		cur = find_next_bit(bitmap, nr_bits, cur + 1);
-		if (cur < nr_bits && cur <= rtop + 1)
-			continue;
-
+	for_each_set_bitrange(rbot, rtop, bitmap, nr_bits) {
 		if (!first) {
 			if (buf < end)
 				*buf = ',';
@@ -1263,15 +1256,12 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 		first = false;
 
 		buf = number(buf, end, rbot, default_dec_spec);
-		if (rbot < rtop) {
-			if (buf < end)
-				*buf = '-';
-			buf++;
-
-			buf = number(buf, end, rtop, default_dec_spec);
-		}
+		if (rtop == rbot + 1)
+			continue;
 
-		rbot = cur;
+		if (buf < end)
+			*buf = '-';
+		buf = number(++buf, end, rtop - 1, default_dec_spec);
 	}
 	return buf;
 }
-- 
2.30.2

