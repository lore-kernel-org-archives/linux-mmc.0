Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89437132103
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523623; cv=none; b=gWxftx8T5/JlrprDMI+s8FnJwQcoda7Enzh36Kak0EzgYzDY4W30ZHUbHv+SVaB8NTAhhRfXc7Cjgfq4beJZUlX+UJfu/DdA2aztbVlxVXH4UjnhEENAVBjkyEkbIU80loY/ilN4jDCYJdx2PUQfAXNXtrkoeW6Y2uelpSHNBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523623; c=relaxed/simple;
	bh=IXxa2os21PWjWpV5tXZLUEX0/RNWVRAv861nyagGQJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDT88Dr2u8Hn96PSpZH7hN4L2LraZ0eBxjBmKJMUQbrYVBEBJTx6axbPODYAFb5AorudCf8sCXR9HSn5jraqMRyCUswP/nCLnEASO+ZU4ExiEfIx6hmgrl3JQhJOFs8aBj63pgJIrFi11uNSxhP5uv1Us9Kgw5JRQnwBJICm/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx22pkWjhosCsCAQ--.52574S3;
	Thu, 29 May 2025 21:00:20 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx_cZcWjhomLP6AA--.61136S3;
	Thu, 29 May 2025 21:00:18 +0800 (CST)
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
Subject: [PATCH v2 19/35] mmc: sdhci-of-at91: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:00:02 +0800
Message-ID: <a1f998ecdae85cc3039cfa30096220d822b616fa.1748515612.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748515612.git.zhoubinbin@loongson.cn>
References: <cover.1748515612.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_cZcWjhomLP6AA--.61136S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr1xKry5Zw18Xw4xWF1xZwc_yoW8uF1Dpa
	y3GF9Yvas7urWrt3sxK34xZ3Z8tw1jgayjkFy8Gw4kJF4ayr1DGFs2vFy0qFWxAF9Yk39x
	GFyqqrW8C3WDu3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Gryq
	6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07bVa0QUUUUU=

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Aubin Constans <aubin.constans@microchip.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-at91.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 97988ed37467..0b7d7db79139 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -337,28 +337,23 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 			priv->mainck = NULL;
 		} else {
 			dev_err(&pdev->dev, "failed to get baseclk\n");
-			ret = PTR_ERR(priv->mainck);
-			goto sdhci_pltfm_free;
+			return PTR_ERR(priv->mainck);
 		}
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
 
@@ -438,8 +433,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->gck);
 	clk_disable_unprepare(priv->mainck);
 	clk_disable_unprepare(priv->hclock);
-sdhci_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
-- 
2.47.1

