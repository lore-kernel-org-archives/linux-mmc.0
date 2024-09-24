Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D291BC3F;
	Tue, 24 Sep 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211690; cv=none; b=CmYCpgT2RRFvULlpHDFpapfDr7zsIk+BX8s6PyXqGsI2bJdYL22NVLpMPdP11l7IZ8cUsgUypc82iN9NKFpQeQDMOvZDjaZm3ah2bNqhX+lstugjdCr1enP5ip3sfLD4G7ygA4zXjk1edjSTOuwpPF0VQlQ3vC04kxqACB6/hwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211690; c=relaxed/simple;
	bh=1QAxI24QNqyJlBVZFtXE8X2tAH9zh2VD1mXWlHuZ918=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9r4gZklMjT7kKnLw23OERkYzDEttF+i2m1foKGxuidUxW45QjFXP/lvOGKLrDjS6UuVlj4HU5mx9bs6KhY9kppA33uBefc+xZqsmgBXKgPmKHy7GCrmUXsfK7yGNn42A8PsitWMz6HTeIY2Kn88NY3jEzUxlT3u61OufEQ4s3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3mlY5Qo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3mlY5Qo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20551e2f1f8so70191105ad.2;
        Tue, 24 Sep 2024 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727211688; x=1727816488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MsmwfGIxGDNHXFbLStjjpLFP1XK3C1AVuwxVxIWA5pc=;
        b=P3mlY5Qov3wFf59Xsp2izLTp6jdD0weowXk0NJc801RaFrzmh/w+D9r/8wMgFGmyr2
         UDNky1QD5hXhW4UnwubTicET7VrHP3eJQdhJ8oi7wX2G1T5QjhZ+DbvvxtnGITy/zjco
         74wwRdLyNS2DytAnwblpq2Ck6PZcOb4lNSm0peAgOXa8cOch/vyAk8mKnVjdHRj3Bcwh
         XOt7XNteG/ppA/ayXrKlVcJfKKckufO6R3iRNpOt+TCoczw5ormv1aMImNqxzgjygjVc
         VXvR0w2+W5DS2C+5+ls6K/TK8T/Zrgb9CMYEkmwp7GpMfSVY7S4N40rvC+4qNRttYe1r
         FKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727211688; x=1727816488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsmwfGIxGDNHXFbLStjjpLFP1XK3C1AVuwxVxIWA5pc=;
        b=b8rlGQWw9evZxbNJxUhAPKdUPNG7h5lHgh3iBA39nxgBXOD0oEHIWlBJ9ped8l15Fi
         B5MK4XZfJBnKqyjM/idKXJroHDiyThccxZ3TjiEX7M1gNPcoyMt3DwvkvFrBskcWvr7c
         xaU93ui6N6MOa5ddijG91QNEShG1hDk+N1GuP9PDuqKHA1o00qK/PvzC4mQCMyTPbXUE
         iGjLD6Vh32dx6wLgoZCLQ2cz3WfB5ZhthDT2/HSr/SjkJNEgy9o/fofBNvkkC40SCesi
         sAi2nj9OLpreci+hA3gSqKlJc/jLe0JAF9MFNUtMgtHtNfsuu3W9Zss3s3Gl2p0seM/S
         Ecow==
X-Forwarded-Encrypted: i=1; AJvYcCUANWYAn2CRRjKEzmmlrqtkX6+aJLNBk7BpoQrP11oHD05Tm2EMlvAKb90J9205dqBHYsnRQmeQ9kLjVQY=@vger.kernel.org, AJvYcCV6J4CRBMzF3P+1JLMfwyx4qPDdgQhRU+89IYj5vrEccPRwkwz9639By0hnwgrjfK63Hqlsuchhff6o@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy89MgAnyEhwJJM9iuQMAE+uqxBVPfFdtFI/hzg4hX9StgpXnp
	rU0h+XUpSyTpiaSOaF8b8SAWlXhrM5cbawrst039/9elEi9d5qgX
X-Google-Smtp-Source: AGHT+IHGAgzTdiIMarbX1EfDyWZlQDo2yhTL6zFfq5FVYuejP7LnAB0RB0L9FOX9jUSKIwY3LsbBrg==
X-Received: by 2002:a17:902:db0b:b0:205:76d0:563b with SMTP id d9443c01a7336-20afc2d215bmr7394685ad.0.1727211687547;
        Tue, 24 Sep 2024 14:01:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1724163sm13754305ad.66.2024.09.24.14.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:01:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guenter Roeck <linux@roeck-us.net>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] mmc: core: Only set maximum DMA segment size if DMA is supported
Date: Tue, 24 Sep 2024 14:01:23 -0700
Message-ID: <20240924210123.2288529-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since upstream commit 334304ac2bac ("dma-mapping: don't return errors
from dma_set_max_seg_size") calling dma_set_max_seg_size() on a device
not supporting DMA results in a warning traceback. This is seen when
booting the sifive_u machine from SD. The underlying SPI controller
(sifive,spi0 compatible) explicitly sets dma_mask to NULL.

Avoid the backtrace by only calling dma_set_max_seg_size() if DMA is
supported.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mmc/core/queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index d0b3ca8a11f0..4d6844261912 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -388,7 +388,8 @@ static struct gendisk *mmc_alloc_disk(struct mmc_queue *mq,
 
 	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 
-	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
+	if (mmc_dev(host)->dma_parms)
+		dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
 
 	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
 	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
-- 
2.45.2

