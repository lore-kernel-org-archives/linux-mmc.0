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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846CEC636CB
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 02:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C36E6117A
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 02:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhGSCVJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Jul 2021 22:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhGSCVI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Jul 2021 22:21:08 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D003EC061765;
        Sun, 18 Jul 2021 19:18:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c68so10618472qkf.9;
        Sun, 18 Jul 2021 19:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jO4nyGRdRSlBrG+WtYYiYryUcVMfftUEaMWXVUBDHo=;
        b=SKGJyt71wEAPu9gRSETzpS6ZnOKx6a1bVyzPQQZ7wf8q9e73XNqg20Rep9KCsgrJy+
         6Hc3QqOXLFgPBymAhgv3OdB98lsEtfYwD4ait9F9Gu9xVNNl1pArXFG2hWMtL3OO6agz
         SxH8WuxRAMY8Vfw1gSSYi+51LcEQc9Oi+X4vTKka5FVLiWWv51br36NbOaUPqU1D51w9
         SjDbXTB+VSgkS8I43DHq5z+4+zymugAbk3ZEwYK0fZpqFfb3P53OivY0S/RgGvti2oPv
         4ZuW/H1CYbkP//CQIV/63MPo7glEXQQl+QC6U1KHSvlP4kzxCfosoWd9BYTo07k0Y6y4
         l+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jO4nyGRdRSlBrG+WtYYiYryUcVMfftUEaMWXVUBDHo=;
        b=DAsEyGuhn9QrT4VCdl0RvhTXDCc7deSFLdXWvZNCssYAYo4GIehStnZw2RVpaEmQkY
         OEcTN0EpHTQ2kWphJWAVDspRFFBHij9Uh+jy35f3LG/qM6s+NmXbn5n9U7Yi8xKpSJ2b
         7I3PqWrOUZY8QOOIXHyL1kpO3QfM/E+O3pWeLzNQRQOq4dkk9P+39G9SyiDh6tAo0sba
         w1K5Z/cq1JYKTngToqJSIpGsT+YxMfFV2XoYIjxmRwk4a5S3QdfBHfRQjTsSH+q7TKfv
         MCWyvv4dNn9NEd67rcZvGG3X9lBOLMIK7MgsKF3GJm9y2B2J9Fsj/xD6Iejpy4mWXZb0
         ToHA==
X-Gm-Message-State: AOAM532FB+88AQuFE/G8hH8EkVxSBQBHURYddZahww5/bwErDGvn2UXf
        qcvw8r4Icqz2TugkypiXxYytcF9fzGA=
X-Google-Smtp-Source: ABdhPJzYvqeefWrAr6+pDZNfg1zE1hHMkxSmnfBnpZkpOG8dZNMF6D/di1+589JFQPt7g2NDmTm3GA==
X-Received: by 2002:a05:620a:f91:: with SMTP id b17mr3591105qkn.107.1626661087768;
        Sun, 18 Jul 2021 19:18:07 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id o27sm3351949qkk.124.2021.07.18.19.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 19:18:07 -0700 (PDT)
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
Subject: [PATCH 1/4] mm/percpu: micro-optimize pcpu_is_populated()
Date:   Sun, 18 Jul 2021 19:17:52 -0700
Message-Id: <20210719021755.883182-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719021755.883182-1-yury.norov@gmail.com>
References: <20210719021755.883182-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

bitmap_next_clear_region() calls find_next_zero_bit() and find_next_bit()
sequentially to find a range of clear bits. In case of pcpu_is_populated()
there's a chance to return earlier if bitmap has all bits set.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 mm/percpu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 7f2e0151c4e2..25461571dcc5 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1071,17 +1071,18 @@ static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
 static bool pcpu_is_populated(struct pcpu_chunk *chunk, int bit_off, int bits,
 			      int *next_off)
 {
-	unsigned int page_start, page_end, rs, re;
+	unsigned int start, end;
 
-	page_start = PFN_DOWN(bit_off * PCPU_MIN_ALLOC_SIZE);
-	page_end = PFN_UP((bit_off + bits) * PCPU_MIN_ALLOC_SIZE);
+	start = PFN_DOWN(bit_off * PCPU_MIN_ALLOC_SIZE);
+	end = PFN_UP((bit_off + bits) * PCPU_MIN_ALLOC_SIZE);
 
-	rs = page_start;
-	bitmap_next_clear_region(chunk->populated, &rs, &re, page_end);
-	if (rs >= page_end)
+	start = find_next_zero_bit(chunk->populated, end, start);
+	if (start >= end)
 		return true;
 
-	*next_off = re * PAGE_SIZE / PCPU_MIN_ALLOC_SIZE;
+	end = find_next_bit(chunk->populated, end, start + 1);
+
+	*next_off = end * PAGE_SIZE / PCPU_MIN_ALLOC_SIZE;
 	return false;
 }
 
-- 
2.30.2

