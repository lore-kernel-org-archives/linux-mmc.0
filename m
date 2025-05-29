Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966021E521
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523587; cv=none; b=Gio5weY5QPfiiWTovTOacihXHZDz40qpFg1RjLMZGXrVcrwHEgR6VnADFRFdcqw5mTtQVEtKL9jaXAzrLaDmZJAhGO0pxho22jtLev4hblrasVVEzzGiFL5FHjZ+oYtnTN/J5h8amqfUn7HFZsG17937B1jIXbl0GS2Ts6tGOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523587; c=relaxed/simple;
	bh=dDwUoPWIPdgqmRZ5Zww0cx8pDnflMgvq1A7R2Vfmv4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWw2Odt8zTiZaW43J3LnP5mqCm6P2ynBbBnCgQSKRvjH86BIbmWTflD2XcJdn1T19R1xR7NkwiWl/oqOGExJwqFAHZgCFXRdr/tR4myXpSRUzQFTV4lrOoIbiZ3nye6O2dfoL+WGq3ohJ3JLHcu8wSN9XMXE5I0xs650ZCJE2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxaeBAWjhoNisCAQ--.23532S3;
	Thu, 29 May 2025 20:59:44 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3MQ0WjhoV7P6AA--.54884S5;
	Thu, 29 May 2025 20:59:43 +0800 (CST)
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
Subject: [PATCH v2 13/35] mmc: sdhci-esdhc-mcf: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 20:59:21 +0800
Message-ID: <ec7a03cdc62568f168fd42a0e974f7866199958c.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBx3MQ0WjhoV7P6AA--.54884S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryfJF1DZr15Wr4rArykCrX_yoW8tw1Upa
	yfWrW5tr4xJr4ktayDWwnF9r45Jr13Kay8Ka98Gw18XF4akryDKr4Sya4kWayFyrykJ345
	XrWjgr9IvFn7WrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Gryq
	6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07b3iihUUUUU=

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

