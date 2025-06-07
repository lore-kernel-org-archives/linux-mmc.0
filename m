Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AA542A83
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749282793; cv=none; b=UHF5F0KSXGEJ8+xoSRwL6hBMnv9BMn6+Imj1kLI9c96GKHiPWQ2BvHNnIxWgHatVOxCHZhEs2TY1B25F+LOjXc3xvSo/InYT/BQzoacvKF7veR6VvruJOQOoX0FOakiEpway2FT7RU/LWd3uw640s4XsKBEh8658vWp7XGPlAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749282793; c=relaxed/simple;
	bh=uiDxw6jK7Av8dyaqHvmfk+f14H8MMoqqlSknelKy4uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReR0Yce3Q274QpCv+0ar7LqPefiCVXZvcbBP0EiX8YHiZXvNuTb4/MU0rP8aoLTWwpOSfuZYWeCHiM6Hwu6fDdJOEr5HLrmfHq7+CyqHeoBYp7eHweQ13e/hfwVVoFwzSGOgQ8bEJ3QiQMIr9K669I2h/I8Zvl6Td4oGBYVE304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxeXHm70NoTxkPAQ--.40222S3;
	Sat, 07 Jun 2025 15:53:10 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx7MTj70NoBKMOAQ--.46151S2;
	Sat, 07 Jun 2025 15:53:09 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 33/35] mmc: sdhci_am654: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:52:58 +0800
Message-ID: <a456963bae14b0c6dade02f388f815f1ffcaa98a.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx7MTj70NoBKMOAQ--.46151S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW7Xw17KFW5CFW7WFWUWrX_yoW8tryxpa
	9xJFWxKrW8WF45Ka98Aw17ZF15Aw4qkayUKrWrAwn7X390yayktrsayFW0v3WvqFy0q3W5
	ZFW5J3y8Ca45ZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26Fy2
	6r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r126r1DMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07bOeHgUUUUU=

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci_am654.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 73385ff4c0f3..58258e275dbb 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -942,35 +942,30 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	clk_xin = devm_clk_get(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
 		dev_err(dev, "clk_xin clock not found.\n");
-		ret = PTR_ERR(clk_xin);
-		goto err_pltfm_free;
+		return PTR_ERR(clk_xin);
 	}
 
 	pltfm_host->clk = clk_xin;
 
 	base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto err_pltfm_free;
+		return PTR_ERR(base);
 	}
 
 	sdhci_am654->base = devm_regmap_init_mmio(dev, base,
 						  &sdhci_am654_regmap_config);
 	if (IS_ERR(sdhci_am654->base)) {
 		dev_err(dev, "Failed to initialize regmap\n");
-		ret = PTR_ERR(sdhci_am654->base);
-		goto err_pltfm_free;
+		return PTR_ERR(sdhci_am654->base);
 	}
 
 	ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
 	if (ret)
-		goto err_pltfm_free;
+		return ret;
 
 	ret = mmc_of_parse(host->mmc);
-	if (ret) {
-		dev_err_probe(dev, ret, "parsing dt failed\n");
-		goto err_pltfm_free;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "parsing dt failed\n");
 
 	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
@@ -1001,8 +996,6 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 pm_put:
 	pm_runtime_put_noidle(dev);
-err_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -1021,7 +1014,6 @@ static void sdhci_am654_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.1

