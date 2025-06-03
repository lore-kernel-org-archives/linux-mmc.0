Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2213922FDFF
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953574; cv=none; b=YDhW+boQqABEBE4NVKkM49JLRqlFTQAmWOH3tNJDZgQCIMwxyxxmW8KCOCQq+W2hibJkA/+nyx9fkU1QiureJtHrDN7UKsPAdyplZAfv/lBfCe8NO1OmzPZAywmeLpKhepQ7E99KiY2su+m+2YJ8oZv2NQCwZ5mv9r5GGyWdDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953574; c=relaxed/simple;
	bh=iZ336dspeVvcINsRQ9Q2IqWIx00jNXZbJiKIqYD7da0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr08yqTpEtGZDSz2aG4GAxUYeSGSzIzCFZr1+THu1Ih56FfYjqPbdFZzDmbWEar7KrvSv9MFf/LBFpBn+AW1vThd/ZmaFCR9djl3rCHhA//SJiq2EID436PWVmZg/uj1PSSK8fovfHNt+ctyEKe1TDCMbUYWITKIhP8E5+jNUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx367k6T5oljUKAQ--.15153S3;
	Tue, 03 Jun 2025 20:26:12 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxDcXi6T5oHw4HAQ--.21221S2;
	Tue, 03 Jun 2025 20:26:11 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 08/36] mmc: dw_mmc: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:25:54 +0800
Message-ID: <5179b0e39cf2cabbb41ed2de51190913628a7da0.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxDcXi6T5oHw4HAQ--.21221S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr1Dtr47try3XF13AF4kKrX_yoW8ZF43pF
	43W34akr4kAF4fG3ykAw4qgr13Z3yFgrW7GFWDWw4Fvw17Jr1qya1Duay8tF95CFW8J3Wx
	WF45Zr45u3ZrZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0E38UUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/dw_mmc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2bfcc47dcf3e..06ffa65df181 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3008,7 +3008,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	struct dw_mci_slot *slot;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
+	mmc = devm_mmc_alloc_host(host->dev, sizeof(*slot));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -3024,18 +3024,18 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	/*if there are external regulators, get them*/
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto err_host_allocated;
+		return ret;
 
 	if (!mmc->ocr_avail)
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto err_host_allocated;
+		return ret;
 
 	ret = dw_mci_init_slot_caps(slot);
 	if (ret)
-		goto err_host_allocated;
+		return ret;
 
 	/* Useful defaults if platform data is unset. */
 	if (host->use_dma == TRANS_MODE_IDMAC) {
@@ -3065,17 +3065,13 @@ static int dw_mci_init_slot(struct dw_mci *host)
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto err_host_allocated;
+		return ret;
 
 #if defined(CONFIG_DEBUG_FS)
 	dw_mci_init_debugfs(slot);
 #endif
 
 	return 0;
-
-err_host_allocated:
-	mmc_free_host(mmc);
-	return ret;
 }
 
 static void dw_mci_cleanup_slot(struct dw_mci_slot *slot)
@@ -3083,7 +3079,6 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot)
 	/* Debugfs stuff is cleaned up by mmc core */
 	mmc_remove_host(slot->mmc);
 	slot->host->slot = NULL;
-	mmc_free_host(slot->mmc);
 }
 
 static void dw_mci_init_dma(struct dw_mci *host)
-- 
2.47.1

