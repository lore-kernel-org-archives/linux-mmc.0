Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DDD21FF2C
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741569; cv=none; b=Nu3sOMzzKiqDVq66Q9NK5fOg2z6Misrq5Z64BWerRgC3lGl6cKDWmV99PsQ8I8R0U8qgDTet9EvphwpL4/w3ACooMbWDGuUM/YF6t8Weqdjik1FuCJoz8ypJag3SV09fv3+ysp/4Q2yx/WemMtUlZdOr4LuscTTnkD7hxJUtVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741569; c=relaxed/simple;
	bh=dUX3k7a9APDdNsDubb9hNqJC739uysONwa74QDFj2WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvkqUq+Xf16j484p8od+69XrrcAooss7/4pBkY+3J5NxRDMWv5xHbJtdBoHw48UyfTvdmoV9/+O1ghmQ6FMpVLxgSSISg6PQYq9g84Mfkt2ZiFk/1SGRyfE+CF4b+Olfvbj4Vlo8+CdwHdDIMceoqh7JdbOn6rMxD8jusOvd9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Axx2l+ayxozV3zAA--.31475S3;
	Tue, 20 May 2025 19:46:06 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+V5ayxohzvjAA--.57175S4;
	Tue, 20 May 2025 19:46:05 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 16/36] mmc: mxs-mmc: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:45:51 +0800
Message-ID: <854ccc03918e7506789dae731bbcb8c267019293.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+V5ayxohzvjAA--.57175S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4kur15ur4xCF18ZF4rCrX_yoW5Gr4xpF
	naqFW2yr4jvF4FgrWUJws7A3WYvr409ayIkrWUW393X34YyF4DKrn5uFy0qFWrAFykAF4Y
	gFWUur4kuF17WabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUx_-BDUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/mxs-mmc.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 80e6f48c83aa..a6e44e406106 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -569,7 +569,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	if (irq_err < 0)
 		return irq_err;
 
-	mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -577,10 +577,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	ssp = &host->ssp;
 	ssp->dev = &pdev->dev;
 	ssp->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ssp->base)) {
-		ret = PTR_ERR(ssp->base);
-		goto out_mmc_free;
-	}
+	if (IS_ERR(ssp->base))
+		return PTR_ERR(ssp->base);
 
 	ssp->devid = (enum mxs_ssp_id)of_device_get_match_data(&pdev->dev);
 
@@ -590,26 +588,23 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
 	if (!IS_ERR(reg_vmmc)) {
 		ret = regulator_enable(reg_vmmc);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vmmc regulator: %d\n", ret);
-			goto out_mmc_free;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to enable vmmc regulator\n");
 
 		ret = devm_add_action_or_reset(&pdev->dev, mxs_mmc_regulator_disable,
 					       reg_vmmc);
 		if (ret)
-			goto out_mmc_free;
+			return ret;
 	}
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(ssp->clk)) {
-		ret = PTR_ERR(ssp->clk);
-		goto out_mmc_free;
-	}
+	if (IS_ERR(ssp->clk))
+		return PTR_ERR(ssp->clk);
+
 	ret = clk_prepare_enable(ssp->clk);
 	if (ret)
-		goto out_mmc_free;
+		return ret;
 
 	ret = mxs_mmc_reset(host);
 	if (ret) {
@@ -668,8 +663,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	dma_release_channel(ssp->dmach);
 out_clk_disable:
 	clk_disable_unprepare(ssp->clk);
-out_mmc_free:
-	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -685,8 +678,6 @@ static void mxs_mmc_remove(struct platform_device *pdev)
 		dma_release_channel(ssp->dmach);
 
 	clk_disable_unprepare(ssp->clk);
-
-	mmc_free_host(mmc);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

