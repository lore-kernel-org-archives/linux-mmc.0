Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAF721FF2C
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741634; cv=none; b=Og2+rHnZ1adSavaLdkQtvvKfaSNW6FfcdauTRiKnMqKLhgri+Rx8GRVsichk0K2XWtEUdLhM+cPGa75tiKmRFGkWVkL+jPDPh3leqTm8WpYHv0xvsVqJ8bSbYS50ZaOPLI2CAtWlH1NVoKpQpycyWDul/4mAuYy6JIxTGt515Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741634; c=relaxed/simple;
	bh=/Zbvhli1UbIWVgKrSnwNStyTbFMmmNaxuZK9PH9nqgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahuuuz7VN3mxKwk9awCMT2vN0NH1sr414RBLK5ra3HCMnYtaInMUVxMMZTa74Kna/CWN18Zp7ca9kk0+iHSneEAMNHw7dCJAXoeGP9YJtl2sfa3Lp+ESPdBplLufvSnW0Ehp7m7W1p6aKaSzocF339bhWXrM9R+Ir23VSJYRbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bxlmm_ayxoQF7zAA--.149S3;
	Tue, 20 May 2025 19:47:11 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxXsW8ayxo3zvjAA--.57954S3;
	Tue, 20 May 2025 19:47:10 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Pierre Ossman <pierre@ossman.eu>
Subject: [PATCH 31/36] mmc: wbsd: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:46:58 +0800
Message-ID: <1e5a14f1422dcbe0636efd6aac715ba13ad89334.1747739323.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747739323.git.zhoubinbin@loongson.cn>
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxXsW8ayxo3zvjAA--.57954S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruF4DArW3KFW7Zw1DKr4fCrX_yoWfGFg_C3
	4Yqrn7CryUCr95Zr45Kw4fZryjk3Wqg3Z0vrs5t3yaqa48Xw1DAa4fZrs8Zay7ZrsruFWf
	Aw1UJr1xA3yjyosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb6AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8Xw0E
	3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYkwIDUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Pierre Ossman <pierre@ossman.eu>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/wbsd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index d5974b355a5a..392522a29430 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1190,7 +1190,7 @@ static int wbsd_alloc_mmc(struct device *dev)
 	/*
 	 * Allocate MMC structure.
 	 */
-	mmc = mmc_alloc_host(sizeof(struct wbsd_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -1262,8 +1262,6 @@ static void wbsd_free_mmc(struct device *dev)
 	BUG_ON(host == NULL);
 
 	timer_delete_sync(&host->ignore_timer);
-
-	mmc_free_host(mmc);
 }
 
 /*
-- 
2.47.1

