Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBAE226CFE
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524758; cv=none; b=bX7y0xL3DGv9qkfbTuxDJGhpQtr88up0PR20wiDqwMz3t5RTwyQXK6aODcWeaLxdzjoWDPaO53ZgFhbLUcYctnOcxVBxZ3la51VhZ8WyfHe/RDXEEnZmR0kq8bexH4Zr9b9SEo4DyQC9elhqflz3byAtRaWNpe/6aGNbOiDyVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524758; c=relaxed/simple;
	bh=U/zX4Ey7gGpuFKUz7seflSXWJQYqlX27QM7+4mCK/bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9gmvRfgqRb6I4ls0g9JhaPJQK78WEocVD/ej+Vqk6/KNwQy4FZfWrmVr16Fq+4/Odc5jQ0T2QsbWx7gLFVYT3bdvGtJSqV3YEXGbIShQ4j92xtCXKCy+snhTLdYJitij8+gEyqpAKSA4/+1N3xH5VKr+RfHiivHJt/X6WKAY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxvnLSXjhoszQCAQ--.22961S3;
	Thu, 29 May 2025 21:19:14 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxj8XOXjho7r76AA--.58244S2;
	Thu, 29 May 2025 21:19:12 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 27/35] mmc: sdhci-pxav2: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:19:01 +0800
Message-ID: <3950e471f21270735b647a6d632c17bc8963f4ef.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxj8XOXjho7r76AA--.58244S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyUJr4rJFy7Ww1fZrWDtrc_yoW8Cw47pF
	s3JFW3KrWUGr4rK3sxXwnrZF1rCw1jgayUK3s5Cw1xXa98tr1DKws3CFW0qFyrAFWkKw13
	XF4UZryUCa9rZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5HSoJUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

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

