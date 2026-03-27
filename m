Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830A34104B
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580349; cv=none; b=fxpniuI3ltec285vtLBj02aPhxHBM9SqI3XadjJxW4Sg354DqAxOTEASoOoEq9eUGgf3jt0flU2nbDdNvRAn6FX5d7bGud8szaIPUBI6aMSCDr5y2BK7Sbx+J0GaHqqDOmNCWj8oK4fhoDRzK0hnUr1xkpE+5uT3vlGp4xpIuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580349; c=relaxed/simple;
	bh=NaKCyVm1WYHg1WscLfFbkDQ6k04fmBF8uk6h/mVsmHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoUNMUDRH6kyX+e/O6FX3q1owB6ymRUqLm3Uu3Kwr4BTFr/q/pr6a242Ro7Q6lTXIqWr1iIIYQavI9ELmWo/qWnVd3wPsaNNvcmI5m7GnYXVyXutvrobR4E/djwWKIT2YScmpO58o0uR2OUF6Tkj334cfozvMKREEIxXp4FHb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asbumraR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asbumraR"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a655cfab5so1553484b3a.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 19:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580347; x=1775185147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlhO9dnDtgKKk75FhfoMSHhoMn3ErPiErmZ+IolhpDg=;
        b=asbumraRodVOLML5oYt7ovjc4hBOEtAHO294uevxdUMmgbl7u61eBrVtw2+D+CKjRh
         coe3Lhumbeqsish+XbxkRMJ2qGK34oBHC8wwwTp5dk1B68DvRSqIV/vyLebfvL02sp1Z
         PsLy2oSw1xqRfOE8DWx3JeoRe91qAccRKRqJ3XcNZb9x7WFJk8pf27IfhIEyDdiv8h3c
         DSJNHWu+ov8YXeD5uiA6hnkHYXiK1RlM7GrLrZJBiqjrriznr9fdGvnoAmkPOb6lj4tf
         nnjdxg7e6vOLzoBVddO0MzryuyfAqwPYhgYAlPb5DJsWe+vrjxxsoIa7VgnZowNwqKqb
         gyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580347; x=1775185147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlhO9dnDtgKKk75FhfoMSHhoMn3ErPiErmZ+IolhpDg=;
        b=d0BBYHApTBHkMrWEIyYzQgY1lDpqC2RPM0cDJFrJta+CVJSHvs4lUOz6ivBmbv+baH
         Afg9CLRPbSs92G3R+P3cLyAFmoIGGnUyZ++hYDm3hAEjnrBNlsHME3WgolIx6+ZZRUz1
         4rYEbptHSm6k11LCy9RQyGx1lFK33uh5anpwUlT502m5cpyCDaKYSzCrMrZGjalzUKFi
         /R1+3yToHVJ2A4jAepjyJmyrzkOUUfK57vJRULQ/Fm8U52PWm/+0VcZgRra306HQzUxT
         CmpkOhPdpIzFD72/of/W7WsD5aPSunhqd3x4xJD9jCzilB0AnYfh9UKMKX5Tv+wa/38Y
         fKsA==
X-Gm-Message-State: AOJu0YxYht8vXsV3Nls2KhseAMa/a9Ct7qCC8sT9No9U5X47CR0JnZq3
	aWgq9mmezaNhGb5cEJ1mG6mgT+Snza8QurLZstM7+1CVaKhww5yqeRq0s9gE7ZRg
X-Gm-Gg: ATEYQzwBEfd/oyCqGblFmwa0P/Bcx8WHK8yiSRellAf7q79+hzcmPRUPrMnLrmaoUMn
	xmAGtMu0jtjlrLtaheW4JxeyQC1ygCQJnhvksxf2kroFKtX93GL5HjMaBR0tPDtFPWcylNRznRC
	Mxp3kACZOyyPg2tgtPS/uLt9W2wVWKktjTvmfr+UJWbI9V1CHRgC97O0xFGTsgR5Z6ZNcezr5rN
	ddiJdA8YmzFq2GyiffCZ0jjbgSIxAO6eL9zNuNoMtd5CuC6l8/LbSIySAlbkeWi6W8zcynh5PuA
	YAA2j/ZB63NUrsBSLJVZKXC8fJvq4mgGcXGJmCcFVRiRjq7r5q+HCajDSWg2KfDUBx7xj+Z4M7v
	xJ8xaHE4REEF4MQX5O6Hp/VQWnhHxgJkZHsAYfHghYZRntHDMX9duvbPkqS/OW0Wl0CYjhtolbG
	rvBePdmpvYh5wMgBN/FkBsRk1k0Ts681kCJ2jj5pWevEHam9aX2Yiwz6s=
X-Received: by 2002:a05:6a00:170b:b0:82c:21b8:4a1f with SMTP id d2e1a72fcca58-82c95c19881mr773878b3a.5.1774580347440;
        Thu, 26 Mar 2026 19:59:07 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d23c7a4sm3969059b3a.27.2026.03.26.19.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:59:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] mmc: mmc_test: use kzalloc_flex
Date: Thu, 26 Mar 2026 19:58:49 -0700
Message-ID: <20260327025849.8085-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in these structs.

Add __counted_by to get extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/core/mmc_test.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 43fdb67d5407..f5c542855037 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -51,12 +51,12 @@ struct mmc_test_pages {
 
 /**
  * struct mmc_test_mem - allocated memory.
- * @arr: array of allocations
  * @cnt: number of allocations
+ * @arr: array of allocations
  */
 struct mmc_test_mem {
-	struct mmc_test_pages *arr;
 	unsigned int cnt;
+	struct mmc_test_pages arr[] __counted_by(cnt);
 };
 
 /**
@@ -135,21 +135,22 @@ struct mmc_test_dbgfs_file {
  * struct mmc_test_card - test information.
  * @card: card under test
  * @scratch: transfer buffer
- * @buffer: transfer buffer
  * @highmem: buffer for highmem tests
  * @area: information for performance tests
  * @gr: pointer to results of current testcase
+ * @buffer: transfer buffer
  */
 struct mmc_test_card {
 	struct mmc_card	*card;
 
 	u8		scratch[BUFFER_SIZE];
-	u8		*buffer;
 #ifdef CONFIG_HIGHMEM
 	struct page	*highmem;
 #endif
 	struct mmc_test_area		area;
 	struct mmc_test_general_result	*gr;
+
+	u8		buffer[];
 };
 
 enum mmc_test_prep_media {
@@ -315,7 +316,6 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
 	while (mem->cnt--)
 		__free_pages(mem->arr[mem->cnt].page,
 			     mem->arr[mem->cnt].order);
-	kfree(mem->arr);
 	kfree(mem);
 }
 
@@ -348,14 +348,10 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 	if (max_segs > max_page_cnt)
 		max_segs = max_page_cnt;
 
-	mem = kzalloc_obj(*mem);
+	mem = kzalloc_flex(*mem, arr, max_segs);
 	if (!mem)
 		return NULL;
 
-	mem->arr = kzalloc_objs(*mem->arr, max_segs);
-	if (!mem->arr)
-		goto out_free;
-
 	while (max_page_cnt) {
 		struct page *page;
 		unsigned int order;
@@ -3099,7 +3095,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 	if (ret)
 		return ret;
 
-	test = kzalloc_obj(*test);
+	test = kzalloc_flex(*test, buffer, BUFFER_SIZE);
 	if (!test)
 		return -ENOMEM;
 
@@ -3111,7 +3107,6 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 
 	test->card = card;
 
-	test->buffer = kzalloc(BUFFER_SIZE, GFP_KERNEL);
 #ifdef CONFIG_HIGHMEM
 	test->highmem = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, BUFFER_ORDER);
 	if (!test->highmem) {
@@ -3120,17 +3115,14 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 	}
 #endif
 
-	if (test->buffer) {
-		mutex_lock(&mmc_test_lock);
-		mmc_test_run(test, testcase);
-		mutex_unlock(&mmc_test_lock);
-	}
+	mutex_lock(&mmc_test_lock);
+	mmc_test_run(test, testcase);
+	mutex_unlock(&mmc_test_lock);
 
 #ifdef CONFIG_HIGHMEM
 	__free_pages(test->highmem, BUFFER_ORDER);
 free_test_buffer:
 #endif
-	kfree(test->buffer);
 	kfree(test);
 
 	return count;
-- 
2.53.0

