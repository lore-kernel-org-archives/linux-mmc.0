Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1D22F774
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953577; cv=none; b=BftIOFkZRQHCA2vO8WRTsRy+Vx4bUHGRs9k4E7bZwDKPgZrX3vJBGYjuwgj+Uz4oltL8a++gpdTR/DiQQAut1DHj4VcVsKP4rmo5OO6T8nHvtjSB8kUgxmO4AXztWhh5xSaewDpEFNrIN7STdIOAmm35oHKhpEPNtEhV3VoTRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953577; c=relaxed/simple;
	bh=m0X0hgKSS8FgA+AxYM2UlSig8zgSz09RKCICxn7+EJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id0TmpOCb5aCPTO/513Be+MSEfPkYCp1qaQjKxQ/Ac2JybMUbXxuQ2iojBPiP4EF9+d/YYuO40D9sim6Jdxd5VwTOswAUJOqTWYTqNomqj+0w410K6VvnCPZ4Z/LGeuAIcr5Vv1zs4Ay8Uzw2N3EVaTus7zg7joNpkgsFLuETwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxeXHm6T5onjUKAQ--.32566S3;
	Tue, 03 Jun 2025 20:26:14 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxDcXi6T5oHw4HAQ--.21221S3;
	Tue, 03 Jun 2025 20:26:13 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 09/36] mmc: jz4740: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:25:55 +0800
Message-ID: <243cf4d1515028725f08401a55d2a02c15d6c662.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxDcXi6T5oHw4HAQ--.21221S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1xKr1rCr13GFWUAr4xGrX_yoW5CFW8pa
	93JasxKrW8GF4Yg39rGa1UA3WrXr18tw4xK3yxXw4xAw15Kr1qkrn5CFyFqFyrJFykJw1I
	gFsrWr18AFWUXrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07jhdb8UUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/jz4740_mmc.c | 40 ++++++++++++-----------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index bd1662e275d4..3a623323aef3 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1042,7 +1042,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	struct mmc_host *mmc;
 	struct jz4740_mmc_host *host;
 
-	mmc = mmc_alloc_host(sizeof(struct jz4740_mmc_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc) {
 		dev_err(&pdev->dev, "Failed to alloc mmc host structure\n");
 		return -ENOMEM;
@@ -1054,31 +1054,24 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	host->version = (enum jz4740_mmc_version)device_get_match_data(&pdev->dev);
 
 	ret = mmc_of_parse(mmc);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "could not parse device properties\n");
-		goto err_free_host;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not parse device properties\n");
 
 	mmc_regulator_get_supply(mmc);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0) {
-		ret = host->irq;
-		goto err_free_host;
-	}
+	if (host->irq < 0)
+		return host->irq;
 
 	host->clk = devm_clk_get(&pdev->dev, "mmc");
-	if (IS_ERR(host->clk)) {
-		ret = PTR_ERR(host->clk);
-		dev_err(&pdev->dev, "Failed to get mmc clock\n");
-		goto err_free_host;
-	}
+	if (IS_ERR(host->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(host->clk),
+				     "Failed to get mmc clock\n");
 
 	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &host->mem_res);
-	if (IS_ERR(host->base)) {
-		ret = PTR_ERR(host->base);
-		goto err_free_host;
-	}
+	if (IS_ERR(host->base))
+		return PTR_ERR(host->base);
 
 	mmc->ops = &jz4740_mmc_ops;
 	if (!mmc->f_max)
@@ -1118,10 +1111,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 
 	ret = request_threaded_irq(host->irq, jz_mmc_irq, jz_mmc_irq_worker, 0,
 			dev_name(&pdev->dev), host);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
-		goto err_free_host;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request irq\n");
 
 	jz4740_mmc_clock_disable(host);
 	timer_setup(&host->timeout_timer, jz4740_mmc_timeout, 0);
@@ -1152,9 +1143,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		jz4740_mmc_release_dma_channels(host);
 err_free_irq:
 	free_irq(host->irq, host);
-err_free_host:
-	mmc_free_host(mmc);
-
 	return ret;
 }
 
@@ -1172,8 +1160,6 @@ static void jz4740_mmc_remove(struct platform_device *pdev)
 
 	if (host->use_dma)
 		jz4740_mmc_release_dma_channels(host);
-
-	mmc_free_host(host->mmc);
 }
 
 static int jz4740_mmc_suspend(struct device *dev)
-- 
2.47.1

