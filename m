Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88A222173A
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897215; cv=none; b=moeImIoFSJYZpKQIWCDVn+ngrXB3mRhBP6yNkrKZ9IU69jtakQhjL3mE3HtieMhBhYsI0mQVgslAKoXCTvE/3mMF9IArXZJ/E/UfVADqLcdAbrRFVG/5KoF7SNtwaZuG9PPVJ7ttETLXow5sJK4xmfl4Y0YGafbah7HVOLg+EXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897215; c=relaxed/simple;
	bh=tDXs0iwaSVpfnOJcEAq+ks74/ZfqufvBYU1EoMNX8WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLRq/2L/CAWeruLoOzNMNsq4f4/cLT4+H1bFiF/Wdb+TGQ20F5noCHXRml7KLNZPNJNpnlDPqWFQp4n4u5TzULW/eDH3NNNX111VlMApkE0CyAa3EZyxHD5vBkjlTqko3hxjrwGxCcx9tTcnsI1wE0Wwh+EUj7VLdjf2CaC1td4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx32t7yy5oTiL2AA--.4809S3;
	Thu, 22 May 2025 15:00:11 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcV1yy5oEnLnAA--.499S5;
	Thu, 22 May 2025 15:00:10 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 13/36] mmc: moxart-mmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 14:59:54 +0800
Message-ID: <aca5d6ebbca5fc0fecbd0762d28353126c01eedc.1747877176.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747877175.git.zhoubinbin@loongson.cn>
References: <cover.1747877175.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxLcV1yy5oEnLnAA--.499S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4fWFyDJry8Kw1fXry3ZFc_yoW8KFWDpF
	Z3Ja43KryYyF4fWrW8Ja1DAF4S9r1IgayUCay8Wwn7u3ZrAr1DKws8Ca40va4rAFWrGa4j
	qFWUJF15CaykJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26Fy26r45twAv7VC2z280aVAF
	wI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aFAJUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/moxart-mmc.c | 40 ++++++++++++-----------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a12048e5de63..3dd8f232052f 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -558,41 +558,33 @@ static int moxart_probe(struct platform_device *pdev)
 	int irq, ret;
 	u32 i;
 
-	mmc = mmc_alloc_host(sizeof(struct moxart_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc) {
-		dev_err(dev, "mmc_alloc_host failed\n");
-		ret = -ENOMEM;
-		goto out_mmc;
+		dev_err(dev, "devm_mmc_alloc_host failed\n");
+		return -ENOMEM;
 	}
 
 	ret = of_address_to_resource(node, 0, &res_mmc);
-	if (ret) {
-		dev_err(dev, "of_address_to_resource failed\n");
-		goto out_mmc;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "of_address_to_resource failed\n");
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0) {
-		dev_err(dev, "irq_of_parse_and_map failed\n");
-		ret = -EINVAL;
-		goto out_mmc;
-	}
+	if (irq <= 0)
+		return dev_err_probe(dev, -EINVAL,
+				     "irq_of_parse_and_map failed\n");
 
 	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto out_mmc;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	reg_mmc = devm_ioremap_resource(dev, &res_mmc);
-	if (IS_ERR(reg_mmc)) {
-		ret = PTR_ERR(reg_mmc);
-		goto out_mmc;
-	}
+	if (IS_ERR(reg_mmc))
+		return PTR_ERR(reg_mmc);
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto out_mmc;
+		return ret;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -686,9 +678,6 @@ static int moxart_probe(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_tx);
 	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
 		dma_release_channel(host->dma_chan_rx);
-out_mmc:
-	if (mmc)
-		mmc_free_host(mmc);
 	return ret;
 }
 
@@ -707,7 +696,6 @@ static void moxart_remove(struct platform_device *pdev)
 	writel(0, host->base + REG_POWER_CONTROL);
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
-	mmc_free_host(mmc);
 }
 
 static const struct of_device_id moxart_mmc_match[] = {
-- 
2.47.1

