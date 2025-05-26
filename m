Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ACB1BF33F
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239633; cv=none; b=V0laFWcKE2Navk58cP9W2DbpqgAGQ9hc9YQ/tmajVM3jcguTozWrK0JMbQEneN4MCfEWesSPnCU+7/8o4W4AD6MnpmmZOrr4DwVcnCpDkVX6fS3Lvq6bx6cVkFpGyDQ/+U9QxgPZSovhdftQab0fe0V37B6MmO/SwmMzAAwDT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239633; c=relaxed/simple;
	bh=Iv1PIZ/7hEr3KvP6h7L3IvZf8MuLJgewmKtXKBy9w2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJjFJTwv7ka+bQqL688uQyzlh9tQXJfynRYrptVj4kLPEf/h2NkBS3b+kMD0Sk4d/nuEPotEAh1MQ0LhIUDqvAFpcb9kkyeu84nkBBL8HgI8i0tdXTs5hyfm/XjYM9yOzh9XbTbXrobnFLHiCGf5zotvAe6uQubS9nfuiIrAV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxLHIOBTRoAIb8AA--.44479S3;
	Mon, 26 May 2025 14:07:10 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+ULBTRoqQTyAA--.32455S4;
	Mon, 26 May 2025 14:07:09 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 26/34] mmc: sdhci-pic32: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:06:59 +0800
Message-ID: <4dc5cf3894a622c43e028e160c6ad5391a74095a.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+ULBTRoqQTyAA--.32455S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cry5Cw18ZFy7CFykWF45urX_yoW8Cr17pF
	W3XF45KrW2gF4Ygay5Jw47Z3W0yr42qayjg3y5Cw1rtrW3tr95AF4xAFyktFyrAFZ7G3WU
	Jr4qqrZ5AF98uabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYh_-PUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pic32.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index d6a299f49900..7ddac0befed8 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -157,20 +157,20 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
 		ret = plat_data->setup_dma(ADMA_FIFO_RD_THSHLD,
 					   ADMA_FIFO_WR_THSHLD);
 		if (ret)
-			goto err_host;
+			goto err;
 	}
 
 	sdhci_pdata->sys_clk = devm_clk_get(&pdev->dev, "sys_clk");
 	if (IS_ERR(sdhci_pdata->sys_clk)) {
 		ret = PTR_ERR(sdhci_pdata->sys_clk);
 		dev_err(&pdev->dev, "Error getting clock\n");
-		goto err_host;
+		goto err;
 	}
 
 	ret = clk_prepare_enable(sdhci_pdata->sys_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Error enabling clock\n");
-		goto err_host;
+		goto err;
 	}
 
 	sdhci_pdata->base_clk = devm_clk_get(&pdev->dev, "base_clk");
@@ -203,8 +203,6 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
 	clk_disable_unprepare(sdhci_pdata->base_clk);
 err_sys_clk:
 	clk_disable_unprepare(sdhci_pdata->sys_clk);
-err_host:
-	sdhci_pltfm_free(pdev);
 err:
 	dev_err(&pdev->dev, "pic32-sdhci probe failed: %d\n", ret);
 	return ret;
@@ -220,7 +218,6 @@ static void pic32_sdhci_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, scratch == (u32)~0);
 	clk_disable_unprepare(sdhci_pdata->base_clk);
 	clk_disable_unprepare(sdhci_pdata->sys_clk);
-	sdhci_pltfm_free(pdev);
 }
 
 static const struct of_device_id pic32_sdhci_id_table[] = {
-- 
2.47.1

