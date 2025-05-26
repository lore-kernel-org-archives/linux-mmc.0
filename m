Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304401BF33F
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239655; cv=none; b=nuY4RBpc4fTMxYsH+p/gwsHDzEwCviXl/hD68EEqBdzGqiG72rpcLEe9ZBd8mGBTcXCgCKa0GaHq4HT7QhCN5v33VjggvgBz3CHZjzxMIf74chEKrV6m8ZS/qdBx1Z659ttkQ3r4MkYDGXELCHWk+79WP3FXnLfqzRlYvIo3BVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239655; c=relaxed/simple;
	bh=AxRgvdQL+YjbC1vZfCabMqJEkOKiG3wsWeDnAUluQkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbj9G28eaSaoNzzbo984ZLNYufzOJ2jkIJzjIn7pI/EHkdAJ295VCZKUMZz2Ud9KhsmBFkx+eB716apfljRcegGcYAnIg73xi176paVmoWRKxB/bzrQtjHfb2xgYNOfi2xRQ9PI56lQf5b5m8cCkzWiU6Gi2oA6cC3Ph2EyQdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxvnMlBTRoW4b8AA--.46526S3;
	Mon, 26 May 2025 14:07:33 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxu8QhBTRo0gTyAA--.30312S5;
	Mon, 26 May 2025 14:07:32 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 33/34] mmc: sdhci_am654: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:07:21 +0800
Message-ID: <4a6009e0aff5a6aab2c9f4162a9250beca700bd6.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxu8QhBTRo0gTyAA--.30312S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW7Xw17KFW5CFW7WFWUWrX_yoW8tryxpa
	9xJFWxKrW8WF45Ka98Aw17ZF15Aw4qkayUKrWrAwn7X390yayktrsayFW0v3WvqFy0q3W5
	ZFW5J3y8Ca45ZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYkwIDUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci_am654.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 73385ff4c0f3..58258e275dbb 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -942,35 +942,30 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	clk_xin = devm_clk_get(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
 		dev_err(dev, "clk_xin clock not found.\n");
-		ret = PTR_ERR(clk_xin);
-		goto err_pltfm_free;
+		return PTR_ERR(clk_xin);
 	}
 
 	pltfm_host->clk = clk_xin;
 
 	base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto err_pltfm_free;
+		return PTR_ERR(base);
 	}
 
 	sdhci_am654->base = devm_regmap_init_mmio(dev, base,
 						  &sdhci_am654_regmap_config);
 	if (IS_ERR(sdhci_am654->base)) {
 		dev_err(dev, "Failed to initialize regmap\n");
-		ret = PTR_ERR(sdhci_am654->base);
-		goto err_pltfm_free;
+		return PTR_ERR(sdhci_am654->base);
 	}
 
 	ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
 	if (ret)
-		goto err_pltfm_free;
+		return ret;
 
 	ret = mmc_of_parse(host->mmc);
-	if (ret) {
-		dev_err_probe(dev, ret, "parsing dt failed\n");
-		goto err_pltfm_free;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "parsing dt failed\n");
 
 	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
@@ -1001,8 +996,6 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 pm_put:
 	pm_runtime_put_noidle(dev);
-err_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -1021,7 +1014,6 @@ static void sdhci_am654_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.1

