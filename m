Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735C1BF33F
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239564; cv=none; b=uS6/CdFKgrp8RhKkiYmThPcuAivu2BQPRACdAUv8Adyczt5+TXowHwhHDbMKO6gQFmkLJ+X5BgPHHdXPFMIWnQ10uDdYX+GUa0viAQm8WpOXkKDDgB7P6eAu3/2Gy44OSvrslbCjRpCLCYpz6CeLIfDDhMsXvE2YWda1WeXajFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239564; c=relaxed/simple;
	bh=L9Eev8z/wlh83PMNUwuA4rNi/p5lXXmtKkt3J/Abu20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjXDs5n3ASxMSOQpNTUfcsh4KYuPRCYb+eEV0nD9jxxvC+y6zMvtYID2esZbf08qp5NtJu8VkI/OhC4xruAvOa8CxCrPBmE3PPVV3QIwPUE5qqbxdh5zFg1QlNGBDNKHAI6t546eRQbtytIGGO/LeXLxLD9bDHfngJ+3RWoWaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxDePHBDRoR4X8AA--.44308S3;
	Mon, 26 May 2025 14:05:59 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx7MTCBDRo+QPyAA--.32601S5;
	Mon, 26 May 2025 14:05:58 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 07/34] mmc: sdhci-pltfm: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:05:46 +0800
Message-ID: <2d6fb35a1093cc4bae34dbeb444a9178129c240b.1747792905.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747792905.git.zhoubinbin@loongson.cn>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx7MTCBDRo+QPyAA--.32601S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr18XF1xtw4kGryrtryUCFX_yoW8KF18pa
	y5Jry7GrW8WFWrWwn8Ww1UAa4S9w1j9345KryrGw10va9IkF98tFs3AFWjyF93ZFyDG3W3
	XF1qvF48CF98A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0E38UUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pltfm.c | 16 +---------------
 drivers/mmc/host/sdhci-pltfm.h |  1 -
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 62753d72198a..7f6ac636f040 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -146,20 +146,11 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
 
-void sdhci_pltfm_free(struct platform_device *pdev)
-{
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-
-	sdhci_free_host(host);
-}
-EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
-
 int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
 				  const struct sdhci_pltfm_data *pdata,
 				  size_t priv_size)
 {
 	struct sdhci_host *host;
-	int ret = 0;
 
 	host = sdhci_pltfm_init(pdev, pdata, priv_size);
 	if (IS_ERR(host))
@@ -167,11 +158,7 @@ int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
 
 	sdhci_get_property(pdev);
 
-	ret = sdhci_add_host(host);
-	if (ret)
-		sdhci_pltfm_free(pdev);
-
-	return ret;
+	return sdhci_add_host(host);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_init_and_add_host);
 
@@ -181,7 +168,6 @@ void sdhci_pltfm_remove(struct platform_device *pdev)
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
-	sdhci_pltfm_free(pdev);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_remove);
 
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index b81d5b0fd616..9c32e8a289d6 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -97,7 +97,6 @@ static inline void sdhci_get_of_property(struct platform_device *pdev)
 extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 					  const struct sdhci_pltfm_data *pdata,
 					  size_t priv_size);
-extern void sdhci_pltfm_free(struct platform_device *pdev);
 
 extern int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
 					 const struct sdhci_pltfm_data *pdata,
-- 
2.47.1

