Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7019F11B
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239595; cv=none; b=OpBUiqrkRqGgEWHaQmID740SfyXnSqxH1EqLPVpsb0Nn/EFpchfTueOwQuL0OiycCc5aZrRWk4D9KfTonKFNGb0/4liD7nixgMsQuX45BGZptR44s/3NqBTBR5Yvm0zndD3p0lwkBEDOsXbv3JnC3ar1iSH9pujv/tGg5OFobvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239595; c=relaxed/simple;
	bh=XNT8JMARJG4ozj3FeHExA8rmLuvY48DENeQgCZ/CSmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwDAl1ZW+sM2Cikppq2kP2OV79pbikQKreldUvOBzOu7pLmV9dNtAZMJzc1+EkTXIzI9SJcYqZr77IxMd0cf4a9uzCdCluQN7xbflC8q1Rl2bNCiO4Xo0WTaiCptPJSelsyGoFy6Un27Ziueg45iHkyVuKNx/pHf2tCx9wAqbrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx367oBDRon4X8AA--.61353S3;
	Mon, 26 May 2025 14:06:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDx_MTmBDRoQwTyAA--.30214S3;
	Mon, 26 May 2025 14:06:31 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 15/34] mmc: sdhci-msm: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:06:19 +0800
Message-ID: <beb38949e76e8ce2c5d7f2509f9b3bc42afaf0f7.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDx_MTmBDRoQwTyAA--.30214S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1DXw1Dur1xZF15Gr15trc_yoW8CFWDpa
	9rXrWvkr47u3ySkan8Jw1qv3Wjyr4I9ayxKry8Gw4fXw45KryDtFs7AFy2qFn5XFy8Ww1U
	WF4DXr48uFyUAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0D
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUx_-BDUUUU

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

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

