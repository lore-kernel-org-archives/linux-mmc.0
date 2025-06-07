Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F95A1E2853
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281876; cv=none; b=lYRC9yw4ycpSn0FKZEe1qRbIzgr7zGrmLafzaaOWdJDxl/nT46Ypm0sEBlx2akRlLYcJfhEaH+VYmS1a0Z22YzpF64hDzcqT0vQJPn0maBjlHKfBaIYkqOhJQ7XXXgJmOwd92+y8ZL4DxG6Z36L5ePETHwhLaEiLmSbbmXeAqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281876; c=relaxed/simple;
	bh=pAgorM6tddKHiQc9BGkIAPiQuCuUdwHusgz32nzu83Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6awxUI0Z2Co7tDGBcYHS91m1e3ft2n+9nVkkWVrpzF1kaZs5gIm4YoF7GL7jXa2SDk/f1o8LmDqltP5eW0tRhvO8KTW+/aV2cJ+nvjv1f5wRGiOXu7DI+fThAK2t49GGQA99meBNOF8I9NWLxkTaZSyWuquRc3WGTE8QMXjB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxeXFS7ENobBYPAQ--.40206S3;
	Sat, 07 Jun 2025 15:37:54 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxvhtN7ENomp4OAQ--.58650S3;
	Sat, 07 Jun 2025 15:37:52 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 15/35] mmc: sdhci-msm: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:37:39 +0800
Message-ID: <3476546610d5518cc4e4490c4e26a71933615aa6.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxvhtN7ENomp4OAQ--.58650S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1DXw1Dur1xZF15Gr15trc_yoW8CFWDpa
	9rXrWvkr47u3ySkan8Jw1qv3Wjyr4I9ayxKry8Gw4fXw45KryDtFs7AFy2qFn5XFy8Ww1U
	WF4DXr48uFyUAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
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
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYkwIDUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-msm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 57bd49eea777..d60454f28b86 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2530,7 +2530,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto pltfm_free;
+		return ret;
 
 	/*
 	 * Based on the compatible string, load the required msm host info from
@@ -2552,7 +2552,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	ret = sdhci_msm_gcc_reset(&pdev->dev, host);
 	if (ret)
-		goto pltfm_free;
+		return ret;
 
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
@@ -2560,10 +2560,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		/* Vote for max. clk rate for max. performance */
 		ret = clk_set_rate(msm_host->bus_clk, INT_MAX);
 		if (ret)
-			goto pltfm_free;
+			return ret;
 		ret = clk_prepare_enable(msm_host->bus_clk);
 		if (ret)
-			goto pltfm_free;
+			return ret;
 	}
 
 	/* Setup main peripheral bus clock */
@@ -2769,8 +2769,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
-pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -2792,7 +2790,6 @@ static void sdhci_msm_remove(struct platform_device *pdev)
 				   msm_host->bulk_clks);
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
-	sdhci_pltfm_free(pdev);
 }
 
 static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
-- 
2.47.1

