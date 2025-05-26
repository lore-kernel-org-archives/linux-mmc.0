Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC2145346
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239558; cv=none; b=YTPBUjI2KIitZmXS6yEq7Ql99wZtXLtDqWAWwkGQjSAOfuBPLwdup83f9rMoDfL4EDiGbKGsvPhEK+L0r+7CX1hRFQbxIcktm9isY05OgZe56vc5ZsNs1ixF3W76eq7GtM6voM4l+N9B17tQmCMxzT/gJeNHI+8FQpIrc0gLqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239558; c=relaxed/simple;
	bh=/f2mFhLK6IhYfFFYKHJhsw5v7hTuJNLkwz4PSIaOWNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2PrEWwwuD20PXcXoW57wvjvcCpVVDMDCttvAAnbY2AWXpHiyNROUxlJ8Vx5oCc0stYjv256+FTu2BTUxuO3YdxDPXzgL9HWdUoodd26imzuIxNNys3z25kAL4FbUm6cnBXXDbRO2jPAm9YG1m4VyXtyYh1M4HAYt908MXrKiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxLHLDBDRoMYX8AA--.44474S3;
	Mon, 26 May 2025 14:05:55 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx7MTCBDRo+QPyAA--.32601S2;
	Mon, 26 May 2025 14:05:55 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 04/34] mmc: sdhci-pci: Drop the use of sdhci_free_host()
Date: Mon, 26 May 2025 14:05:43 +0800
Message-ID: <8d8d07fa09f22ac4de737726161a68fbe3827fc6.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx7MTCBDRo+QPyAA--.32601S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kAr17Jr17CF13Zw47GFX_yoW8WF48pa
	15Xa4YkrWrJF4Fvrn8Aw1fZF1Fkr1jqrWYg3W3Xw10qF1Yyr43tFs7CF1rtr98XaykWw4f
	Xan8ZrWrCFW8X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8N6pPUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_free_host() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pci-core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 13a84b9309e0..9f567b768c42 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -2173,7 +2173,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	ret = pcim_iomap_regions(pdev, BIT(bar), mmc_hostname(host->mmc));
 	if (ret) {
 		dev_err(&pdev->dev, "cannot request region\n");
-		goto cleanup;
+		return ERR_PTR(ret);
 	}
 
 	host->ioaddr = pcim_iomap_table(pdev)[bar];
@@ -2181,7 +2181,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	if (chip->fixes && chip->fixes->probe_slot) {
 		ret = chip->fixes->probe_slot(slot);
 		if (ret)
-			goto cleanup;
+			return ERR_PTR(ret);
 	}
 
 	host->mmc->pm_caps = MMC_PM_KEEP_POWER;
@@ -2242,9 +2242,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	if (chip->fixes && chip->fixes->remove_slot)
 		chip->fixes->remove_slot(slot, 0);
 
-cleanup:
-	sdhci_free_host(host);
-
 	return ERR_PTR(ret);
 }
 
@@ -2265,8 +2262,6 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
-
-	sdhci_free_host(slot->host);
 }
 
 int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
-- 
2.47.1

