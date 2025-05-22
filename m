Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF31A76AE
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897188; cv=none; b=G5uT5I4JS8esccOGXV0lcyHfYyjcBBmsbB8h0cYgzywla3uTUB/8OYT4fCxnnfmkKXQAHuwWw5X4z/G78BhJzRn1VL/TtfYTMMpf/WwISgeX6Uz1W6lZ05VwGPOe8ToVIQ03OKVd5Nyc3ic3ZJckA53QgX+DddusXeiJDT5c5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897188; c=relaxed/simple;
	bh=4cnLHnmIVfUXSUxVnJr77eTmxXi837Boz1Br8OuChkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2afwoWlPRb6xBnchdVaBVU6zrcLtNUsvUhyXBAam5auWaFkAeSCzrq6aCmRbgqqc08KcRGu6FzuXoSSGv22RGjPr3/CkeCMsZj3M2/1S0gCNyqlWEWijwHAz9EILCU+DOOz+T6GANkUC8eDjvG+AZnKjr/epUzqP1/A2JKKt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxPuNgyy5o+CH2AA--.35135S3;
	Thu, 22 May 2025 14:59:44 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcVdyy5oznHnAA--.496S5;
	Thu, 22 May 2025 14:59:44 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 07/36] mmc: davinci_mmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 14:59:32 +0800
Message-ID: <49ec71cd3e9792e5a8907976bd222e9df6ff9520.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxLcVdyy5oznHnAA--.496S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1DZw1xuF4DZw43Xw4DJrc_yoW8urW5p3
	WfJFy3KFWUXF4agrWkJ3y5uF1xXw1xtayxCry8Xw1kZw15tw1qqFsYkFyvvFWrAFWkJr13
	Wa1UJr18uFyUWrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0E38UUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/davinci_mmc.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index cde4c4339ab7..c691f1b60395 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1203,7 +1203,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	if (!mem)
 		return -EBUSY;
 
-	mmc = mmc_alloc_host(sizeof(struct mmc_davinci_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -1212,19 +1212,16 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	host->mem_res = mem;
 	host->base = devm_ioremap(&pdev->dev, mem->start, mem_size);
-	if (!host->base) {
-		ret = -ENOMEM;
-		goto ioremap_fail;
-	}
+	if (!host->base)
+		return -ENOMEM;
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(host->clk)) {
-		ret = PTR_ERR(host->clk);
-		goto clk_get_fail;
-	}
+	if (IS_ERR(host->clk))
+		return PTR_ERR(host->clk);
+
 	ret = clk_prepare_enable(host->clk);
 	if (ret)
-		goto clk_prepare_enable_fail;
+		return ret;
 
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
@@ -1336,10 +1333,6 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 parse_fail:
 dma_probe_defer:
 	clk_disable_unprepare(host->clk);
-clk_prepare_enable_fail:
-clk_get_fail:
-ioremap_fail:
-	mmc_free_host(mmc);
 
 	return ret;
 }
@@ -1352,7 +1345,6 @@ static void davinci_mmcsd_remove(struct platform_device *pdev)
 	mmc_davinci_cpufreq_deregister(host);
 	davinci_release_dma_channels(host);
 	clk_disable_unprepare(host->clk);
-	mmc_free_host(host->mmc);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.1

