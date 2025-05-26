Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54271BF33F
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239635; cv=none; b=p7y0r9f83ZC76vh+nzOcyzWaO6ckX+h7NAPAYsHoqcDLQbAli7HL9JZTIu6tsgz8V8XVw4SFCDLzm8lz1XZT5OidyY4ogOfnCJwoKsxh7SUCgbMZ9LsxIIwUqcguknoh2qeYerxoMandXIzQDaI7Vh7UIYG6s8uwe0DiqLuzsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239635; c=relaxed/simple;
	bh=ttmkjWUL6ZDoUy6TISeJKm9PHALVgThUOaSQDA82LF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DK49LHSSnA5cyve9Xv601RenVkQ1VdWXAmCig6++jwJMfcSWEw34pLtIfvJV2+CX4YTwIZofqS4hcNJG4DgPGgFEIYEquvA4C4mDPlLJ1K6EkK+Wp/dkeILgsfWfYsKfX9xKFngExMn5v/94tX0dhN0TdqTXdCTZ1WGDd5BtP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxXWsOBTRoBob8AA--.13646S3;
	Mon, 26 May 2025 14:07:10 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+ULBTRoqQTyAA--.32455S5;
	Mon, 26 May 2025 14:07:10 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 27/34] mmc: sdhci-pxav2: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:07:00 +0800
Message-ID: <c8dbb91d5719d44f5d708f139e82f5765da9882b.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+ULBTRoqQTyAA--.32455S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyUJr4rJFy7Ww1fZrWDtrc_yoW8Cw47pF
	s3JFW3KrWUGr4rK3sxXwnrZF1rCw1jgayUK3s5Cw1xXa98tr1DKws3CFW0qFyrAFWkKw13
	XF4UZryUCa9rZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8
	Xw0E3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYkwIDUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pxav2.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 45b6f0891c47..76346353dc55 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -258,7 +258,6 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	struct sdhci_host *host = NULL;
 	const struct sdhci_pxa_variant *variant;
 
-	int ret;
 	struct clk *clk, *clk_core;
 
 	host = sdhci_pltfm_init(pdev, NULL, sizeof(*pxav2_host));
@@ -271,19 +270,14 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	clk = devm_clk_get_optional_enabled(dev, "io");
 	if (!clk)
 		clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		dev_err_probe(dev, ret, "failed to get io clock\n");
-		goto free;
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get io clock\n");
 	pltfm_host->clk = clk;
 
 	clk_core = devm_clk_get_optional_enabled(dev, "core");
-	if (IS_ERR(clk_core)) {
-		ret = PTR_ERR(clk_core);
-		dev_err_probe(dev, ret, "failed to enable core clock\n");
-		goto free;
-	}
+	if (IS_ERR(clk_core))
+		return dev_err_probe(dev, PTR_ERR(clk_core),
+				     "failed to enable core clock\n");
 
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
 		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
@@ -332,15 +326,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		pxav2_host->pinctrl = NULL;
 	}
 
-	ret = sdhci_add_host(host);
-	if (ret)
-		goto free;
-
-	return 0;
-
-free:
-	sdhci_pltfm_free(pdev);
-	return ret;
+	return sdhci_add_host(host);
 }
 
 static struct platform_driver sdhci_pxav2_driver = {
-- 
2.47.1

