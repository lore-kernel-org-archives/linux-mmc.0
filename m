Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566B35893
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897299; cv=none; b=ac6TD3ZcoE2r935DYBryQxS4pt1ec/Sgn+lbr54uZ7WzeDdwrM5n/MS3cBLVdCxlaoPAvxuYHUxhn5PO/AthBJQfVo+AUEPHxw0lCVVO+BwH7kVMYzwAdFu6HsxJfX6uUSANjaXDHo4+1Cq3vjOmqQ2QxMvZeonqUShZoHNG4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897299; c=relaxed/simple;
	bh=eFvM3TMFXkvcw6kmoo9BGbl9roxeA7s81fdcjz4it1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmlALW+6HFG4T2Nbytjjlm1lwXiFxAGaiolQdsZJoTM0XaJeipAIp/XXUskYsCMvXny8Uj1NfQ3RyZmBzBy1I/KCJFaUUYTnG235QRC8Slcy3XuqUb1xnUavqjx3k8fQ4gkAZCKpvJzvEATO+1kLExHXHa9Jhqgks9cdvuRC/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxjazPyy5oHCP2AA--.37000S3;
	Thu, 22 May 2025 15:01:35 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxHcXLyy5otXLnAA--.2923S2;
	Thu, 22 May 2025 15:01:31 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 34/36] mmc: sunxi: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:01:20 +0800
Message-ID: <b120e66ad97458ea9465e6bb5f619c53ad51e804.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBxHcXLyy5otXLnAA--.2923S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur4fJFy7Gw1rWw1rGr1xJFc_yoW8tF4fpF
	45JF9xKrWUJr4YgrZrAr4Uu34fZw4xKa48KrWrJw1fu3s8Kr4DtrnxCFy0gF95GFWkGa1S
	gFyDWr4rCF1Du3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	ZFpf9x07bVQ6JUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/sunxi-mmc.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 1508eead5d01..ee4a65b0a22d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1369,11 +1369,10 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct sunxi_mmc_host), &pdev->dev);
-	if (!mmc) {
-		dev_err(&pdev->dev, "mmc alloc host failed\n");
-		return -ENOMEM;
-	}
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
+	if (!mmc)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "mmc alloc host failed\n");
 	platform_set_drvdata(pdev, mmc);
 
 	host = mmc_priv(mmc);
@@ -1383,15 +1382,13 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	ret = sunxi_mmc_resource_request(host, pdev);
 	if (ret)
-		goto error_free_host;
+		return ret;
 
 	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
-	if (!host->sg_cpu) {
-		dev_err(&pdev->dev, "Failed to allocate DMA descriptor mem\n");
-		ret = -ENOMEM;
-		goto error_free_host;
-	}
+	if (!host->sg_cpu)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to allocate DMA descriptor mem\n");
 
 	if (host->cfg->ccu_has_timings_switch) {
 		/*
@@ -1481,8 +1478,6 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 error_free_dma:
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-error_free_host:
-	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -1498,7 +1493,6 @@ static void sunxi_mmc_remove(struct platform_device *pdev)
 		sunxi_mmc_disable(host);
 	}
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-	mmc_free_host(mmc);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.1

