Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E8A95E
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524654; cv=none; b=ng1xuLMS90wG21SJLdl+MqH3OXzcdjFfWQaiGySD+zxt4w5YcmXNBmLFFAM0MZDY8Qq9Zp1cffFxLl+fLX/cooMBAT5zUX+3k1tVDSgI0Jc7PxxGCcvWDV+qV8AccJXmctbzkkmx2M4S3KGPOhCGesEr+tvRF6DuSUp26myQs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524654; c=relaxed/simple;
	bh=IPufr4Xct5wRz5E9L7gt26Aiq5bIJ3tCz354VYBIuzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+dUc19FJMbkNmZgq8y26yBfNojQXRg3IXXOpSywS0giveW55CWh0A4ZlOjsxav3sc84AC4/0MlCTaZGwyM955vgYBW6ZpfFTxAHOjYeWRcXH7AhhIIq1HpTzVCe4CeXmJXuKJJ51EfNjxR1oVnDBcod5UCDGiohfSG34TIVSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx7eJqXjho8DMCAQ--.52341S3;
	Thu, 29 May 2025 21:17:30 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzxtnXjhoxL36AA--.3968S2;
	Thu, 29 May 2025 21:17:30 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 26/35] mmc: sdhci-pic32: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:17:19 +0800
Message-ID: <e3c0c3b239a16f4fb529c5693eebd9e50cf5c688.1748515612.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748515612.git.zhoubinbin@loongson.cn>
References: <cover.1748515612.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxzxtnXjhoxL36AA--.3968S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cry5Cw18ZFy7CFykWF45urX_yoW8Cr17pF
	W3XF45KrW2gF4Ygay5Jw47Z3W0yr42qayjg3y5Cw1rtrW3tr95AF4xAFyktFyrAFZ7G3WU
	Jr4qqrZ5AF98uabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26Fy26r45
	twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5Q0ePUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

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

