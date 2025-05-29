Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB2E4C9D
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524497; cv=none; b=uVFbwCrQr5UNKqJNbC43VwWfr2EiMiLhSJEzKrSdKyYADDdBzCb9k2X9aCbCYdnTSDmMY7QvdAhc4W8jADIRTQ990hz/a/SMaAi5r/yBRDvbEHZq/ZQiVjtGJsW0+hF8T4+Qu6oBkZGM1myIPtQWMW/GHzpEltVpDWfJ0RdoXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524497; c=relaxed/simple;
	bh=sNqQZjze2FA8rb8aSbx0u1MV8ZwWe7pg4d2ijOpMGAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH2oMRk5Lgn6wNfVISk6vRf3kNSNR+Ete7L+IjSxusQo12mdb5MhRUzE+Aq8IlyhqPA6hffERUeYS5pR88h3t+ijheeCz45CxhbldUoY0n5aidtnzWZPd6WSN4Hwy3Ff+kLZj43RiZFw1CPh0Naq/+WoF2h1b0/dBGlwtzI23yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxGHHLXThoxzICAQ--.24193S3;
	Thu, 29 May 2025 21:14:51 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcXGXTho3Lv6AA--.53957S2;
	Thu, 29 May 2025 21:14:49 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH v2 24/35] mmc: sdhci-of-sparx5: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:14:38 +0800
Message-ID: <530357a26141c623ba15fcdec08b004882a26afc.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxLcXGXTho3Lv6AA--.53957S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4rKF47WryxKr1fWw4xZrc_yoW5JF4Upa
	yfAFZxKr1FgrWrCayDJw1UuF1UGr4jgayUKrW8Gwsag3yY9rWDKrn3AFW0gFyrGF95K3Zx
	XF4jqF18AasruFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8Xw0E
	3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxU9zpBDUUUU

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-sparx5.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
index d2aa684e786f..b3db1e2c4c0e 100644
--- a/drivers/mmc/host/sdhci-of-sparx5.c
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -185,11 +185,9 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 	sdhci_sparx5->host = host;
 
 	pltfm_host->clk = devm_clk_get_enabled(&pdev->dev, "core");
-	if (IS_ERR(pltfm_host->clk)) {
-		ret = PTR_ERR(pltfm_host->clk);
-		dev_err(&pdev->dev, "failed to get and enable core clk: %d\n", ret);
-		goto free_pltfm;
-	}
+	if (IS_ERR(pltfm_host->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pltfm_host->clk),
+				     "failed to get and enable core clk\n");
 
 	if (!of_property_read_u32(np, "microchip,clock-delay", &value) &&
 	    (value > 0 && value <= MSHC_DLY_CC_MAX))
@@ -199,14 +197,12 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto free_pltfm;
+		return ret;
 
 	sdhci_sparx5->cpu_ctrl = syscon_regmap_lookup_by_compatible(syscon);
-	if (IS_ERR(sdhci_sparx5->cpu_ctrl)) {
-		dev_err(&pdev->dev, "No CPU syscon regmap !\n");
-		ret = PTR_ERR(sdhci_sparx5->cpu_ctrl);
-		goto free_pltfm;
-	}
+	if (IS_ERR(sdhci_sparx5->cpu_ctrl))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sdhci_sparx5->cpu_ctrl),
+				     "No CPU syscon regmap !\n");
 
 	if (sdhci_sparx5->delay_clock >= 0)
 		sparx5_set_delay(host, sdhci_sparx5->delay_clock);
@@ -222,7 +218,7 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto free_pltfm;
+		return ret;
 
 	/* Set AXI bus master to use un-cached access (for DMA) */
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA) &&
@@ -235,10 +231,6 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 		 mmc_hostname(host->mmc), sdhci_readl(host, MSHC2_TYPE));
 
 	return ret;
-
-free_pltfm:
-	sdhci_pltfm_free(pdev);
-	return ret;
 }
 
 static const struct of_device_id sdhci_sparx5_of_match[] = {
-- 
2.47.1

