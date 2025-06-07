Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA01D6193
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749282542; cv=none; b=judoV+5aicAYafZKXUNvdlk2qlzsAf/splwS36RseovFy2Qtoux/gSqVgz9Wwwj9Vgp90mgg0zaNOvqNq3ckd+mLBaD/S7X9pOHKzp2dA0px+27KoSZtIgpZ1RENYbsyQpyqqJllgCQ684+VgUSn6eBORHg11qY0Ou6Tovqp1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749282542; c=relaxed/simple;
	bh=gvBtDWkbtbkWO+kfisKgwxj/lV+BNsNp0XTiuOtpfVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5POi2bwF6HO4BjITBXLIA27reMjfgA1/cwq9Dq0UVBki56ZW6wB1Jy0PTvgmu/YqQPsqommfI9QGY42yEeu80vxEFkHlNAglATh3Cid3D+FHn1Uy05yWh/MGTA7rBeSg3uM0Fg2AjyAti0X76H+CEbMAfxdTqPsoWGcjuedv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxaWrp7kNokxgPAQ--.43751S3;
	Sat, 07 Jun 2025 15:48:57 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxrhvm7kNowqEOAQ--.60962S2;
	Sat, 07 Jun 2025 15:48:56 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>
Subject: [PATCH v3 23/35] mmc: sdhci-of-ma35d1: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:48:35 +0800
Message-ID: <67a2a3b35e2d46aab06657e88566c14a7f2d7947.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxrhvm7kNowqEOAQ--.60962S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF43AryrXryUCr4xZF47GFX_yoW8tryUpa
	9rJF97tFy8ZrWrK39xGw1UZ3WrGr12gay8K3y8Ww18trW5tryDtrnaya40yFWrJFy0v343
	Za1qqr18CayDW3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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

Cc: Jacky Huang <ychuang3@nuvoton.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-ma35d1.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-of-ma35d1.c
index 1e6d180100ad..287026422616 100644
--- a/drivers/mmc/host/sdhci-of-ma35d1.c
+++ b/drivers/mmc/host/sdhci-of-ma35d1.c
@@ -211,20 +211,18 @@ static int ma35_probe(struct platform_device *pdev)
 	priv = sdhci_pltfm_priv(pltfm_host);
 
 	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
-	if (IS_ERR(pltfm_host->clk)) {
-		err = dev_err_probe(dev, PTR_ERR(pltfm_host->clk), "failed to get clk\n");
-		goto err_sdhci;
-	}
+	if (IS_ERR(pltfm_host->clk))
+		return dev_err_probe(dev, PTR_ERR(pltfm_host->clk),
+				     "failed to get clk\n");
 
 	err = mmc_of_parse(host->mmc);
 	if (err)
-		goto err_sdhci;
+		return err;
 
 	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(priv->rst)) {
-		err = dev_err_probe(dev, PTR_ERR(priv->rst), "failed to get reset control\n");
-		goto err_sdhci;
-	}
+	if (IS_ERR(priv->rst))
+		return dev_err_probe(dev, PTR_ERR(priv->rst),
+				     "failed to get reset control\n");
 
 	sdhci_get_of_property(pdev);
 
@@ -255,7 +253,7 @@ static int ma35_probe(struct platform_device *pdev)
 
 	err = sdhci_add_host(host);
 	if (err)
-		goto err_sdhci;
+		return err;
 
 	/*
 	 * Split data into chunks of 16 or 8 bytes for transmission.
@@ -268,10 +266,6 @@ static int ma35_probe(struct platform_device *pdev)
 	sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
 
 	return 0;
-
-err_sdhci:
-	sdhci_pltfm_free(pdev);
-	return err;
 }
 
 static void ma35_disable_card_clk(struct sdhci_host *host)
@@ -291,7 +285,6 @@ static void ma35_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, 0);
 	ma35_disable_card_clk(host);
-	sdhci_pltfm_free(pdev);
 }
 
 static const struct of_device_id sdhci_ma35_dt_ids[] = {
-- 
2.47.1

