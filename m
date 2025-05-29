Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA08225A36;
	Thu, 29 May 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525037; cv=none; b=N+vOhSldv8AeYkN3OsujGB6BlsBpoHOKSUVSFFdIfo9ofo4ZCszWLc6k16KItkEgDq70pk2jt4QsDWhHsTGgcbGZ7xrsni5Ew1bGb6ZFCyi0Bmo/p0MlwfG2AzBJT0IpKLVqYGJyuScoXYCrrQbHIeASPUzpF6MIbAM2fUfU4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525037; c=relaxed/simple;
	bh=NNc/Qya68Pqu2BaUk5YCLfe344htnliiaLl+9up7ktA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PecvSK6IprPUzEgUrTzuemRVAqJu3DWX8XGwyiKuwug9Dt3mLYeZQX5awKC+gkK08qEnh7ffzkqBcZhJWJAPdYGefL4t1Uh9/VXmxD9FHYKnCBTxlUj8r4Xy+rLZC7aXJ41VmMuw/3AI8sLElnR5tO/lQF61IIeuAkoxWEPNkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxbKzpXzhoaDYCAQ--.22363S3;
	Thu, 29 May 2025 21:23:53 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx_cbmXzhoH8H6AA--.61294S2;
	Thu, 29 May 2025 21:23:52 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 31/35] mmc: sdhci-tegra: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:23:42 +0800
Message-ID: <cd4ea3082e448c0a04bcec3b751f956d5c39d383.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx_cbmXzhoH8H6AA--.61294S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrW8Xw4kKF4fXr4fCF1fXwc_yoW8CFW5pF
	4DJFWIkr4xWr4FkFyDGwnrZa45Cr129ay7K3s5Kwn7A398JryDGFn3AFyjvFWrAFykK3W8
	XF1UKF18CF9rWabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8
	Xw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUgBOJUUUUU

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-tegra.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index b2f5c3f8b839..c811297185d8 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1693,7 +1693,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	rc = mmc_of_parse(host->mmc);
 	if (rc)
-		goto err_parse_dt;
+		return rc;
 
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
@@ -1739,7 +1739,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		if (IS_ERR(clk)) {
 			rc = PTR_ERR(clk);
 			if (rc == -EPROBE_DEFER)
-				goto err_power_req;
+				return rc;
 
 			dev_warn(&pdev->dev, "failed to get tmclk: %d\n", rc);
 			clk = NULL;
@@ -1750,7 +1750,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		if (rc) {
 			dev_err(&pdev->dev,
 				"failed to enable tmclk: %d\n", rc);
-			goto err_power_req;
+			return rc;
 		}
 
 		tegra_host->tmclk = clk;
@@ -1811,8 +1811,6 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 err_clk_get:
 	clk_disable_unprepare(tegra_host->tmclk);
 err_power_req:
-err_parse_dt:
-	sdhci_pltfm_free(pdev);
 	return rc;
 }
 
@@ -1831,7 +1829,6 @@ static void sdhci_tegra_remove(struct platform_device *pdev)
 	pm_runtime_force_suspend(&pdev->dev);
 
 	clk_disable_unprepare(tegra_host->tmclk);
-	sdhci_pltfm_free(pdev);
 }
 
 static int __maybe_unused sdhci_tegra_runtime_suspend(struct device *dev)
-- 
2.47.1

