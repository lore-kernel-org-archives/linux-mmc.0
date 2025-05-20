Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6933B13635C
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741593; cv=none; b=UGoZJoeEDMB2YISII7ruT6vSI4xSDDnNjGdjKMY6Wik+eMcvCyvIHpqAFVMS6JaY0gLkBJDQwpjdwq0XhgyBkKdYE2UDwJQ7Bhdl+l0m8wojXn8D9sCChi6xaj9SGAS+WaLkJVeym2JkNsnTkWFQeoqYDn/FPrPW41yu9AVSV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741593; c=relaxed/simple;
	bh=LXbCfmKatvEpYfEUStB7lgZEil4eKMlVg0IFRDfEkoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7yZJHcAfH6w57smV5Ii4e6YAG2Wo9XY07IrC30Ek/fsQKTBWJTFvDm7VXFcU4Dmli7I03IGG8RRM3tJj2MA4b1N1tf9tnlMJYVlzcUbHxBLWZXPB52TZlIBJe5+ezOrIzxAvyR/0OZPpEmJY8WmXVi/TmG3fBAZrIPYskvRoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxIK+Wayxo6l3zAA--.63773S3;
	Tue, 20 May 2025 19:46:30 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx7xuUayxoqzvjAA--.55558S2;
	Tue, 20 May 2025 19:46:29 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 20/36] mmc: pxamci: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:46:15 +0800
Message-ID: <5270e4291002e76c48a8819bdf4d25706a83354b.1747739323.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747739323.git.zhoubinbin@loongson.cn>
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx7xuUayxoqzvjAA--.55558S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF45Kr45ZF13GFyUGr1Utwc_yoW5CF45pa
	yrJFZrK3yUKF45W3y8Cw4DXF1rZr4Sy3yxKry8uw1fA34vkrsrK3Z3ua4FqFWrAFWrXr1F
	qa1UJr1UuFW7ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxJKsUUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/pxamci.c | 42 ++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 2d0ad006913d..26d03352af63 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -615,11 +615,9 @@ static int pxamci_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	mmc = mmc_alloc_host(sizeof(struct pxamci_host), dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
+	if (!mmc)
+		return -ENOMEM;
 
 	mmc->ops = &pxamci_ops;
 
@@ -646,7 +644,7 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	ret = pxamci_of_init(pdev, mmc);
 	if (ret)
-		goto out;
+		return ret;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -655,9 +653,8 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(host->clk)) {
-		ret = PTR_ERR(host->clk);
 		host->clk = NULL;
-		goto out;
+		return PTR_ERR(host->clk);
 	}
 
 	host->clkrate = clk_get_rate(host->clk);
@@ -670,7 +667,7 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	ret = pxamci_init_ocr(host);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	mmc->caps = 0;
 	host->cmdat = 0;
@@ -686,10 +683,8 @@ static int pxamci_probe(struct platform_device *pdev)
 	host->imask = MMC_I_MASK_ALL;
 
 	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
-	if (IS_ERR(host->base)) {
-		ret = PTR_ERR(host->base);
-		goto out;
-	}
+	if (IS_ERR(host->base))
+		return PTR_ERR(host->base);
 	host->res = r;
 
 	/*
@@ -704,16 +699,15 @@ static int pxamci_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, pxamci_irq, 0,
 			       DRIVER_NAME, host);
 	if (ret)
-		goto out;
+		return ret;
 
 	platform_set_drvdata(pdev, mmc);
 
 	host->dma_chan_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(host->dma_chan_rx)) {
-		dev_err(dev, "unable to request rx dma channel\n");
-		ret = PTR_ERR(host->dma_chan_rx);
 		host->dma_chan_rx = NULL;
-		goto out;
+		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
+				     "unable to request rx dma channel\n");
 	}
 
 	host->dma_chan_tx = dma_request_chan(dev, "tx");
@@ -771,14 +765,10 @@ static int pxamci_probe(struct platform_device *pdev)
 	return 0;
 
 out:
-	if (host) {
-		if (host->dma_chan_rx)
-			dma_release_channel(host->dma_chan_rx);
-		if (host->dma_chan_tx)
-			dma_release_channel(host->dma_chan_tx);
-	}
-	if (mmc)
-		mmc_free_host(mmc);
+	if (host->dma_chan_rx)
+		dma_release_channel(host->dma_chan_rx);
+	if (host->dma_chan_tx)
+		dma_release_channel(host->dma_chan_tx);
 	return ret;
 }
 
@@ -803,8 +793,6 @@ static void pxamci_remove(struct platform_device *pdev)
 		dmaengine_terminate_all(host->dma_chan_tx);
 		dma_release_channel(host->dma_chan_rx);
 		dma_release_channel(host->dma_chan_tx);
-
-		mmc_free_host(mmc);
 	}
 }
 
-- 
2.47.1

