Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D742A83
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749282773; cv=none; b=FSf1LE/vr2rbCOsp1upIsMIuhdj2VlQxiHxaBgFdVnRc6Um8S6yifXeOHRTLDma/9ciu84emSEO40H2U0X89Y5RPt9z6Iiwi9cKumyfZ+UZeMO5PJ/FFlfYYG57b/itK+AFe9Mj4/Qw1+HF1J0LTF8grsPXEaqbhm9n4smxYUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749282773; c=relaxed/simple;
	bh=8n9fLSa4o/mjVy32rNYbcGPlbOTmaBv1UCBCbtxSTVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0qHIS3VjiYqFvsrr/9wGUuebJ0CUfemAKMne5WtmdFZgzWKHU39+V0bP5p2ezEIQgivpvUZdWEo/Y+8HQ0CKf4akKoYlGOgl/TwsuclC6ZmMoLjD84MiDbj9BVtUK86kifOxLvDsJIlfoMazlpYyDT9ha3IGzuqHxuilb+em30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxmnHS70NoMxkPAQ--.40607S3;
	Sat, 07 Jun 2025 15:52:50 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMTQ70No76IOAQ--.46561S2;
	Sat, 07 Jun 2025 15:52:49 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Hu Ziji <huziji@marvell.com>
Subject: [PATCH v3 32/35] mmc: sdhci-xenon: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:52:39 +0800
Message-ID: <e7c52155f04fc270400985b70514800c23fd5565.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMTQ70No76IOAQ--.46561S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFy5WF4xAr4DZFy5Cw1fKrX_yoW8Ww1xpa
	93tFy5Ka17WFWUK3s0qw4DZF15Jw42gay8Kry5Gw1kG3yakrW5trsayFW8ZF4rJFykKw4f
	W3WDtFW8uas8C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5mXdUUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Hu Ziji <huziji@marvell.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-xenon.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 098f0ea45cbe..41a2c26e2431 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -532,14 +532,13 @@ static int xenon_probe(struct platform_device *pdev)
 
 	if (dev->of_node) {
 		pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
-		if (IS_ERR(pltfm_host->clk)) {
-			err = PTR_ERR(pltfm_host->clk);
-			dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
-			goto free_pltfm;
-		}
+		if (IS_ERR(pltfm_host->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(pltfm_host->clk),
+					     "Failed to setup input clk.\n");
+
 		err = clk_prepare_enable(pltfm_host->clk);
 		if (err)
-			goto free_pltfm;
+			return err;
 
 		priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
 		if (IS_ERR(priv->axi_clk)) {
@@ -603,8 +602,6 @@ static int xenon_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->axi_clk);
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
-free_pltfm:
-	sdhci_pltfm_free(pdev);
 	return err;
 }
 
@@ -623,8 +620,6 @@ static void xenon_remove(struct platform_device *pdev)
 	xenon_sdhc_unprepare(host);
 	clk_disable_unprepare(priv->axi_clk);
 	clk_disable_unprepare(pltfm_host->clk);
-
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

