Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D31E2853
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281911; cv=none; b=a/gRpvIMWAlkOJUloTCdzPNtggOv1/JlTj6cGOc1kKf21GPsAmlIzmsPMXxbrsbEC5bbv4Q6Sze4lPtjTPBJqe/38xghckvViXhjDzlUEP6dQF8AlDruFZoYBZERCiVdZzBCE+KBZel/n0+0xWpNat6cZzYlgxphz5L3ihX4+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281911; c=relaxed/simple;
	bh=edvTWU1gUAbEydTGxk1541dlTzX58yaamVTmG/AkSSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar9Mq8F+qA6yeyM2fjLKQeV61j9Ivs22y5zacRwj5L+sOh37ykqDk6+S017zXEdWpWmzcAQhY+E9KOr1sYUo80Xu0eEUzfBHk3S9JCJ1i6Jbtx7BxAESesq7nOyc/ibwbduNbARP05buCq/eka162OhBpgHsf53NQaILSRKvfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Axjmt07ENoohYPAQ--.39325S3;
	Sat, 07 Jun 2025 15:38:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxbsVu7ENowZ4OAQ--.49969S3;
	Sat, 07 Jun 2025 15:38:27 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Aubin Constans <aubin.constans@microchip.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v3 19/35] mmc: sdhci-of-at91: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:38:13 +0800
Message-ID: <d64ed0f849277760d5b9ce04cfff1cd02ad43d19.1749127796.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749127796.git.zhoubinbin@loongson.cn>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxbsVu7ENowZ4OAQ--.49969S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr1xKry5Zw18Xw4xZr1kWFX_yoW8Kw1Upa
	yrGFWFvas7ZrWrt3sxK34xZwn8Jw1jgayjkFy8Gw4kJr4ayr1DGFs2vFy0qFWxAF9Yk398
	GFyqvrW8C3WDu3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8
	Xw0E3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUtVW8ZwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYhtxDUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Aubin Constans <aubin.constans@microchip.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-at91.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 97988ed37467..be80a457cd49 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -333,32 +333,26 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 
 	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
 	if (IS_ERR(priv->mainck)) {
-		if (soc_data->baseclk_is_generated_internally) {
+		if (soc_data->baseclk_is_generated_internally)
 			priv->mainck = NULL;
-		} else {
-			dev_err(&pdev->dev, "failed to get baseclk\n");
-			ret = PTR_ERR(priv->mainck);
-			goto sdhci_pltfm_free;
-		}
+		else
+			return dev_err_probe(&pdev->dev, PTR_ERR(priv->mainck),
+					     "failed to get baseclk\n");
 	}
 
 	priv->hclock = devm_clk_get(&pdev->dev, "hclock");
-	if (IS_ERR(priv->hclock)) {
-		dev_err(&pdev->dev, "failed to get hclock\n");
-		ret = PTR_ERR(priv->hclock);
-		goto sdhci_pltfm_free;
-	}
+	if (IS_ERR(priv->hclock))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->hclock),
+				     "failed to get hclock\n");
 
 	priv->gck = devm_clk_get(&pdev->dev, "multclk");
-	if (IS_ERR(priv->gck)) {
-		dev_err(&pdev->dev, "failed to get multclk\n");
-		ret = PTR_ERR(priv->gck);
-		goto sdhci_pltfm_free;
-	}
+	if (IS_ERR(priv->gck))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
+				     "failed to get multclk\n");
 
 	ret = sdhci_at91_set_clks_presets(&pdev->dev);
 	if (ret)
-		goto sdhci_pltfm_free;
+		return ret;
 
 	priv->restore_needed = false;
 
@@ -438,8 +432,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->gck);
 	clk_disable_unprepare(priv->mainck);
 	clk_disable_unprepare(priv->hclock);
-sdhci_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
-- 
2.47.1

