Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045222256D
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897225; cv=none; b=cGAmwTi9w+c3uNXv58210th2O1Y95bUduKlXZDONG2DnASb6GREcZEbDNB5PArjYeAkds33jteYuBB/E1SyoqYZp47xHFHnXDFgoA0j1+tD4gv+wk5PbeCcMudMnSZmw3r5x3LTaUQaZrzPnRP14/NDGaxuinUjASgiZPjx7Or8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897225; c=relaxed/simple;
	bh=tV09GGeKO0vCuNjkW97nkVbuDgHZ17QKWeCDw1NLRgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqvCRUZZPsROcG07GpkIrFBVizwmdElTUdLk4Suv0p4uc0B85PF+4agtG/KpcKOFENSlW3DLL1DQc3TH5WA5Pn2Hrru8h5PBX13F5v2+mro+sieBQzfMnArE3bCXPs34/YnpRGQ0xE6sidbntQxXqZn5w7K+AL8Hdyp+a6Pfq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxvOKFyy5oayL2AA--.6979S3;
	Thu, 22 May 2025 15:00:21 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMSDyy5oMHLnAA--.4625S4;
	Thu, 22 May 2025 15:00:21 +0800 (CST)
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
Subject: [PATCH v2 16/36] mmc: mxs-mmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:10 +0800
Message-ID: <dd52f7b7668baef96d620b329f8a51623bf01b1d.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMSDyy5oMHLnAA--.4625S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4kur15ur4xCF18ZF4rCrX_yoW5GFy8pF
	saqFW7tr4jvF4FgrWUJws7A3W5Zr409ayIkrWUW397X34Yyr4DKrn5CF10qFWrAFykAF4Y
	gFWUur4kuF17W3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	WIevJa73UjIFyTuYvjxUxco7DUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
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

