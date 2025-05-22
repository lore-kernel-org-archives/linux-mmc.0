Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66239221F00
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897236; cv=none; b=MX3hvvN9VBm+fd63Ciq2rHtcpELPzBBms2mxkx0UcH93ByUQrC7kccvqDPMmnF7C12l4bUUXKesjXTxeh4dQiCGrzpszzE4CxforlSk1I92sbcwDtlwUW14JKHJteZEJjWMmGQOJnXUMYZZRQGgXVLdnk7ilwNRp/kFSDSDj9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897236; c=relaxed/simple;
	bh=RUcNixfnHeGCR3zvXNXTEqRDIY9SENvsLDzFtqDagy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B78wqVmFX79jgh7MBF7ywYOKhtAH9JfKpK3euyP2L6nSESvAVivunhJuYc9lgPLhiAubEzROvaNXhBIkq4lL4OXTzQzBhELp0YB84op9jotqapcEXo6UVRCfapHGf9Jo+qlmZ1r0vwUsoxSzzRGB1SEDUEnD2InsSjRY9a1rhA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxjmuQyy5ogyL2AA--.3657S3;
	Thu, 22 May 2025 15:00:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMSOyy5oQ3LnAA--.4626S3;
	Thu, 22 May 2025 15:00:31 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 19/36] mmc: owl-mmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:22 +0800
Message-ID: <17f7b6074a83b1512c3b3bd53ac3dc3bb4bdb5a2.1747877176.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747877175.git.zhoubinbin@loongson.cn>
References: <cover.1747877175.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxzMSOyy5oQ3LnAA--.4626S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrWDAr1ftw4fAF4DXr45twc_yoW5ur48pF
	n5JF9xKrWUKrW3XrWUJa1UWw1rXr10kw48CayDXw1xZ3s0vrsrGFn5uFy8KFyrtF93Jr1S
	gF45Jr48uF1DZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUINVyUUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Andreas Färber <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/owl-mmc.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 797ef48d9204..dc585726b66e 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -567,7 +567,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct owl_mmc_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*owl_host));
 	if (!mmc) {
 		dev_err(&pdev->dev, "mmc alloc host failed\n");
 		return -ENOMEM;
@@ -580,24 +580,18 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	spin_lock_init(&owl_host->lock);
 
 	owl_host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(owl_host->base)) {
-		ret = PTR_ERR(owl_host->base);
-		goto err_free_host;
-	}
+	if (IS_ERR(owl_host->base))
+		return PTR_ERR(owl_host->base);
 
 	owl_host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(owl_host->clk)) {
-		dev_err(&pdev->dev, "No clock defined\n");
-		ret = PTR_ERR(owl_host->clk);
-		goto err_free_host;
-	}
+	if (IS_ERR(owl_host->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(owl_host->clk),
+				     "No clock defined\n");
 
 	owl_host->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(owl_host->reset)) {
-		dev_err(&pdev->dev, "Could not get reset control\n");
-		ret = PTR_ERR(owl_host->reset);
-		goto err_free_host;
-	}
+	if (IS_ERR(owl_host->reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(owl_host->reset),
+				     "Could not get reset control\n");
 
 	mmc->ops		= &owl_mmc_ops;
 	mmc->max_blk_count	= 512;
@@ -616,16 +610,14 @@ static int owl_mmc_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto err_free_host;
+		return ret;
 
 	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 	owl_host->dma = dma_request_chan(&pdev->dev, "mmc");
-	if (IS_ERR(owl_host->dma)) {
-		dev_err(owl_host->dev, "Failed to get external DMA channel.\n");
-		ret = PTR_ERR(owl_host->dma);
-		goto err_free_host;
-	}
+	if (IS_ERR(owl_host->dma))
+		return dev_err_probe(&pdev->dev, PTR_ERR(owl_host->dma),
+				     "Failed to get external DMA channel.\n");
 
 	dev_info(&pdev->dev, "Using %s for DMA transfers\n",
 		 dma_chan_name(owl_host->dma));
@@ -662,8 +654,6 @@ static int owl_mmc_probe(struct platform_device *pdev)
 
 err_release_channel:
 	dma_release_channel(owl_host->dma);
-err_free_host:
-	mmc_free_host(mmc);
 
 	return ret;
 }
@@ -676,7 +666,6 @@ static void owl_mmc_remove(struct platform_device *pdev)
 	mmc_remove_host(mmc);
 	disable_irq(owl_host->irq);
 	dma_release_channel(owl_host->dma);
-	mmc_free_host(mmc);
 }
 
 static const struct of_device_id owl_mmc_of_match[] = {
-- 
2.47.1

