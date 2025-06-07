Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138081F460B
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281825; cv=none; b=Pzpe6IVujz0sVMzNYfVNcKWKmpWlEzSaYiPGnx7eJKBgoIeync3kH65K8UU8EkO5s498zVSSA8RJf2+dcIYAjSYId9UG/S2Ffw7x8Ji3vHY2/9NUFsG+4vw48WkTqvDdxXk7BhT24SaFwKzFsGmY2QP/KxGxIpTY4KSsKEDI9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281825; c=relaxed/simple;
	bh=dDwUoPWIPdgqmRZ5Zww0cx8pDnflMgvq1A7R2Vfmv4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVWliCkPFcEFxfE3i56kxP5GX5ipzpZk2xg0AuyrlZPf9s4ygfkwcPbU8ggVAtzP59RSfzOjIIdQ/h+5HaEC5BIqI7UJmASon+5a9u3KtJTntsAgh2ObNP/FLFKkS7NUlSMwsNitN20tabPbw/IqlxGPmHXi/gcpK28iWCF5ZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx7eIe7ENoJBYPAQ--.5758S3;
	Sat, 07 Jun 2025 15:37:02 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxPscX7ENoO54OAQ--.49043S5;
	Sat, 07 Jun 2025 15:37:02 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v3 13/35] mmc: sdhci-esdhc-mcf: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:36:46 +0800
Message-ID: <3843af6a7726d8879e5cba02e0321e08c8908328.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxPscX7ENoO54OAQ--.49043S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryfJF1DZr15Wr4rArykCrX_yoW8tw1Upa
	yfWrW5tr4xJr4ktayDWwnF9r45Jr13Kay8Ka98Gw18XF4akryDKr4Sya4kWayFyrykJ345
	XrWjgr9IvFn7WrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8
	Xw0E3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYyMKtUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Acked-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 327662ba5bd9..375fce5639d7 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -426,28 +426,22 @@ static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
 	host->flags |= SDHCI_AUTO_CMD12;
 
 	mcf_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(mcf_data->clk_ipg)) {
-		err = PTR_ERR(mcf_data->clk_ipg);
-		goto err_exit;
-	}
+	if (IS_ERR(mcf_data->clk_ipg))
+		return PTR_ERR(mcf_data->clk_ipg);
 
 	mcf_data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
-	if (IS_ERR(mcf_data->clk_ahb)) {
-		err = PTR_ERR(mcf_data->clk_ahb);
-		goto err_exit;
-	}
+	if (IS_ERR(mcf_data->clk_ahb))
+		return PTR_ERR(mcf_data->clk_ahb);
 
 	mcf_data->clk_per = devm_clk_get(&pdev->dev, "per");
-	if (IS_ERR(mcf_data->clk_per)) {
-		err = PTR_ERR(mcf_data->clk_per);
-		goto err_exit;
-	}
+	if (IS_ERR(mcf_data->clk_per))
+		return PTR_ERR(mcf_data->clk_per);
 
 	pltfm_host->clk = mcf_data->clk_per;
 	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
 	err = clk_prepare_enable(mcf_data->clk_per);
 	if (err)
-		goto err_exit;
+		return err;
 
 	err = clk_prepare_enable(mcf_data->clk_ipg);
 	if (err)
@@ -485,9 +479,6 @@ static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mcf_data->clk_ipg);
 unprep_per:
 	clk_disable_unprepare(mcf_data->clk_per);
-err_exit:
-	sdhci_pltfm_free(pdev);
-
 	return err;
 }
 
@@ -502,8 +493,6 @@ static void sdhci_esdhc_mcf_remove(struct platform_device *pdev)
 	clk_disable_unprepare(mcf_data->clk_ipg);
 	clk_disable_unprepare(mcf_data->clk_ahb);
 	clk_disable_unprepare(mcf_data->clk_per);
-
-	sdhci_pltfm_free(pdev);
 }
 
 static struct platform_driver sdhci_esdhc_mcf_driver = {
-- 
2.47.1

