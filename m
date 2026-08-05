Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF545E555
	for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2026 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896358; cv=none; b=NPEfaWTZkXwApokh2K5kLrmDH1nZHu7pRpCU9Yelz8Cn9VAJH60T4wsx9H3SjMY8UebD+qBVxKJx7soggmiDoV3UVLIvn4hC+T0bXYbSZ7oCARylavbcCVBcZ7V0T4QbFbbZaO8p0sy/xhmmEDT487aCt3wGc+wXVPSHpb8rBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896358; c=relaxed/simple;
	bh=nUuZ2skQfOzg/qCPaXxIP7ZQgcAg/Aar9NHePDlidY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7gb1d7qQXPMm1vmSpdcZHHbo57jcNw+2CR7xoBslNyvrkTaN4g9Yne18IQYNlW17evxjRZPFCPU9uqKdI76ZAquLKGJW2zLvENmBdSZ/2DSQo05zmpVSA7+gKblS7a1aFg4MV2FJeaZuUAL5w9nm9aLkxXjQsEIOOu7/gjvjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aDNGcD5H; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aDNGcD5H"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso536800a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 19:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785896356; x=1786501156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLX43ezAvQWWJkXB9Urrmu7vcoPvWM7hSUWS7Iz4D28=;
        b=aDNGcD5HoyVE6TmgPFOr4MlJCpJRlb5Gg9QsTgUq2iJG3lN3Whe67iY3X9WbgBbp+e
         mutgoztQol7SuecW2F79J9FM7t29ab5dj0RhpG7jw6oHbs8I5HuIWqbRC67jSEtppL+N
         vDixLNEL/+wjMRb60CLa5qgae2yLENFUWCOQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896356; x=1786501156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLX43ezAvQWWJkXB9Urrmu7vcoPvWM7hSUWS7Iz4D28=;
        b=tSLpnxico+z4pE97bVfqnw3F35BiBeHhKgJ+f14vo7RXQxebbvRQR1pg2lHbxWwwH5
         HUyF0CGsQ3MjUAwQo/k885wjdQX9jE4S+3O2xgRGwiuVDD9BU3J6GEJjmdW1dKU1ScAz
         ynas0BzR0E0XLuZjTBdhLVMDMtiMi7qF9iFdfUF7rnum7nUYZdHkn2p8i+lW5pJQLhfM
         WBeDMsNB6n34tfBDNqKTCurbYptIBbodLJEmJgAQT2DoxntNtNCIPyd5ti5gKV9aPPoG
         jVfF2N/PwEUnK5/cYQbUxOjZRC3/4Re8Ab2dT0FraQcu0SYfDku2kcsZW3MjCrwiCglc
         Jm6g==
X-Forwarded-Encrypted: i=1; AHgh+RosvdjIV7OKqpRcBiisIF6yInlegOJNH9ose9nl65L+onLd85W+m1EUpH/dJdhBehq9+BIOQkcCha0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5i4P3RoIbplMnV3J64Nkh9Je+14pCwBLqWjr8N0PxTOOx23a
	GOLmcPAZDMQ2cIMKCnzREPK1i8BiS54aMiVCu7f22/PCwS0vUkHyQhASHuxdPetLXw==
X-Gm-Gg: AR+sD12elIwewzw5eM2oIBT3x5okJy3I4sa9AvAg+pZfsvHhAUmmeg2pvIPJJVap89B
	2dEAqjD6NNqEhqmBiqncK4DpvBpgi6jpqZe7O3QIO3/QVn+eKk+8lSz/lRAVDDiTdHO1Bfs9pEs
	nfUjh9u58qkVLjnAALDebFasUYSuNpqQdZi1h4g6XwPdjl7Bhk2/b70EdqhW3DuAVWHQUQFGMw4
	pmhjVD0AAakx5fVbUw7+Vf46K+/bYH03eKop0xvg77jzNkeLEU6uouywcAK67TKJBxg/sHVP6he
	o2yNJvLdMGAPI5oecUrH5pAqVj4dPwc2guK6Uyf00Y0ZovzXrky7A9knSP0AyzWMEuWAiowBWp8
	t8pHieOm9xm+DJy77bUB1Ap4OmLGd/raVK9oOkbNwyvbQwm6F8RBcb0PwKJfHVpeBAsAvo0lnA+
	UBSvlzH6UKvoyLwMXPG+X7jiFAHt9OpdHvO+SmskZsp7yzTnJzvTOvxFnr9Nqf9udUS7pm5QvWY
	2JFiFoY8HWK41wvCHodHZlsAWg7XoWZLSYQJXW0oFMCuHDRHNDR
X-Received: by 2002:a17:90b:4d91:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-3903c53799cmr2986763a91.1.1785896356174;
        Tue, 04 Aug 2026 19:19:16 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d1971besm543489a91.0.2026.08.04.19.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:19:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] zram: freeze device queue before device reset
Date: Wed,  5 Aug 2026 11:18:44 +0900
Message-ID: <20260805021854.1057715-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device reset does not take into account in-flight async IO
requests so we can free meta table and reset device concurrently
with those requests being executed. The block layer guidelines
indicate that queue state should be protected by blk_mq_freeze_queue()
during teardown.  Freeze zram queue before device reset.

Fixes: cd67e10ac699 ("zram: promote zram from staging")
Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 56183c827e1b..3b9dfcae9317 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -19,6 +19,7 @@
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/buffer_head.h>
 #include <linux/device.h>
 #include <linux/highmem.h>
@@ -2842,6 +2843,9 @@ static void zram_destroy_comps(struct zram *zram)
 
 static void zram_reset_device(struct zram *zram)
 {
+	unsigned int memflags;
+
+	memflags = blk_mq_freeze_queue(zram->disk->queue);
 	guard(rwsem_write)(&zram->dev_lock);
 
 	zram->limit_pages = 0;
@@ -2855,6 +2859,7 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
+	blk_mq_unfreeze_queue(zram->disk->queue, memflags);
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.55.0.571.g244d577d93-goog

