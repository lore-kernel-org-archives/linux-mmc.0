Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A73B27D7
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703217; cv=none; b=FZC3QYA7UBK0QvOh3UqwRaX/608SBLenqc4Nc1hmvpK47d+RNjHOhbLbNbezkqR8BQDpgS5vYXsZh8CeUGRKtslHPbV3dhlNHtop7EwPQiV62KBx2YB8Fvg8xJGBxdfo876nZealT/8OyPtCRr/rhYzJ3QbHYU4hmoMXTYqw0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703217; c=relaxed/simple;
	bh=c/uTj3eUMahseda4ijCDXZHTgGCnC+nQ71EeQCnj+V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHYdzu6X4qYIvU9jRjkcM67lzSsJ3PIm0jp9iPqNcjfINZBMpBbS3JNcSpy4xc6gvtv3X9JemzTqUuEPGJD2XK6L1AcoL3Yj037PXRWx8pLnGUeq7/M6FxcH043XJYZEelZt48b2ALWpouShbjIl38r1KCzfYiACGsdRSQxIDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja6pzugG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja6pzugG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso64484615e9.2
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778703213; x=1779308013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcwsrIgXQYyK1SppA08OyTKLgYONdYnS8FYyBfl9uV8=;
        b=Ja6pzugGGmBBciUf98d3vCdvIm0CZp15cvbqCnIj2NVSWG9Zr2Kvpm7Pa4fljogrWD
         APSSeiCDb9AQcSbA3vrOv6/BXRcc6uw4jWhpsO/ugwRt8qppFdX4A16V0v5DygNtxUb8
         Chs6qZo0S3SBE+n4tUayYIAuyBVO0TkCDLHU3hQ0qUhcUFmzspzJv1lE9Q9F93VI2mRx
         0lVMGUTfpjfOxrQTsXqo4f0+b9LMCja7I7Y9SRBd6o47vXK2qsWDTuWtTpwV5R9spudg
         pefOz9JsTC+FXOvyiAR+wKBU53/Fg+jklyv6vcjk7aXiu8pyOS1l7sfGQdnmlKt8+1PC
         6cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778703213; x=1779308013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcwsrIgXQYyK1SppA08OyTKLgYONdYnS8FYyBfl9uV8=;
        b=qFp1HSZlOnn4XKPqi4mbskyoYS/2rMDRydP5ZHmqtc2Gp24fznP95Qz4z1DQ2AmVTj
         y6nTM5AQ8kQHTnxDlYgKU7s02gFc+WGn+9+vnjhIGMXqQpMHiYcJbXpqDnUgWcheCw6L
         nmOmTliYP6tf8RUjJD8zAuzWA+6inMlp6/zvRO9ml0xUfBUK6oHIMdEjJ+rll5YYpnFr
         VLVys5VjJHHAIr+2u0V9J9w7KYDWVypGCnO4eiNitXOmISAHU9uvGMwIxfMisyl3jMJ8
         5HkxBAnVrbTqO82htiLsf4OrnJrAy6OU9/2f9Vd4gelbmUI1sSzSn2qkx9wK5insTcGq
         Bb0w==
X-Gm-Message-State: AOJu0Yz5SmSzlQWIhkMZ9n3nE0k7hIEeE5R9NYWKJ5nUPnzsbskmszv4
	kVWPNoYbcqU6aYqebNaPesweunWa9zIcHsNn8UsKgeSdwj9ch2Lvu9xr
X-Gm-Gg: Acq92OHZ2a3P7h1/PWu/wgddnnZ9SbIl8Sy3C5lcPeg7qXGA/QZzjB+ldty6rsxdIXE
	dF4SbPwq1S9vfs0CR3IcupBqArCcsaRnNaQY6HEg7gx7EVGqwLVJN2oK1sDzlD36duppj4Wlrdv
	lXfEPMx28dBd1bdyeUzHLpe/cThwaGMXSLnR3Lo45zQB2Leoo4jkBNruZK/1TPmNhvkcaANMyui
	xggMYCGjQC/NXtho00n32MOVIIRpdmTXbgb0aHTUmD/WdNPbxXMeeu0g7Hg011BUgS64XepCoeY
	L+ajK1SsTdLoYPhfh/5iT/tT5/pf6ETwk+dRD64VOa6g7k4axemxPpNsjvlpa5sErGFRYPtHyWN
	9HsXPnaTJNZ9n4XfQ6TgHHiZhtr2TSgDRk2hoXzQRzczaUUB8nQ4NFk12hJFZEXp+62DciQhaV+
	BVCVSo8WWDhE/tHi0qwmmpFQujpxm6M1Yit11ng5zczx6soM3uVlFiUxO1PXWHDzJI6SK6xwC1S
	0VydpU987+eFfXbFs6cAEhgPPQksIEE/iZz2APpQvjKSZaZ
X-Received: by 2002:a05:600c:8b56:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-48fc9a4bb0cmr78676015e9.26.1778703212855;
        Wed, 13 May 2026 13:13:32 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3e5f:9005:e5d2:460e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd649ea63sm11927465e9.8.2026.05.13.13.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:13:32 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] mmc: mmc_test: Fix __counted_by handling after kzalloc_flex() conversion
Date: Wed, 13 May 2026 21:13:15 +0100
Message-ID: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix logic issues introduced by the kzalloc_flex() conversion in
mmc_test_alloc_mem() due to interaction with the __counted_by
annotation on the flexible array.

Bounds-checking sanitizers rely on the counter field reflecting the
allocated array size before any array access occurs. However, use
mem->cnt both as the allocation size and as the runtime insertion
index, causing incorrect indexing and potentially invalid bounds
tracking.

Initialize mem->cnt to the maximum allocated number of segments
immediately after kzalloc_flex(), then use a separate local index
variable to track successfully allocated entries. Update mem->cnt to
the actual number of initialized elements before returning or entering
the cleanup path.

Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
readability and ensuring only initialized entries are freed.

Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/core/mmc_test.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index ab38e4c45a8d..e0e1b5df76dc 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -316,11 +316,13 @@ static int mmc_test_buffer_transfer(struct mmc_test_card *test,
 
 static void mmc_test_free_mem(struct mmc_test_mem *mem)
 {
+	unsigned int idx;
+
 	if (!mem)
 		return;
-	while (mem->cnt--)
-		__free_pages(mem->arr[mem->cnt].page,
-			     mem->arr[mem->cnt].order);
+	for (idx = 0; idx < mem->cnt; idx++)
+		__free_pages(mem->arr[idx].page,
+			     mem->arr[idx].order);
 	kfree(mem);
 }
 
@@ -341,6 +343,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 	unsigned long page_cnt = 0;
 	unsigned long limit = nr_free_buffer_pages() >> 4;
 	struct mmc_test_mem *mem;
+	unsigned int idx = 0;
 
 	if (max_page_cnt > limit)
 		max_page_cnt = limit;
@@ -356,6 +359,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 	mem = kzalloc_flex(*mem, arr, max_segs);
 	if (!mem)
 		return NULL;
+	mem->cnt = max_segs;
 
 	while (max_page_cnt) {
 		struct page *page;
@@ -375,23 +379,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 				goto out_free;
 			break;
 		}
-		mem->arr[mem->cnt].page = page;
-		mem->arr[mem->cnt].order = order;
-		mem->cnt += 1;
+		mem->arr[idx].page = page;
+		mem->arr[idx].order = order;
+		idx += 1;
 		if (max_page_cnt <= (1UL << order))
 			break;
 		max_page_cnt -= 1UL << order;
 		page_cnt += 1UL << order;
-		if (mem->cnt >= max_segs) {
+		if (idx >= mem->cnt) {
 			if (page_cnt < min_page_cnt)
 				goto out_free;
 			break;
 		}
 	}
 
+	mem->cnt = idx;
+
 	return mem;
 
 out_free:
+	mem->cnt = idx;
 	mmc_test_free_mem(mem);
 	return NULL;
 }
-- 
2.54.0

