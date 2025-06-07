Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F31D6193
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749282613; cv=none; b=SGjCSsFQlnLdKiD2wQh+WYYHuJqDniei5Hp6ywiF6S1AjYvcO0jg0w4SvMs/rozr8+PLCr4anVRxzj2hgAGIvYCqEzKzA56aswnvwj/tTElpQYFq51LY2NpLUSmlUYRWXOkSnhpnTeZZoTrgBvz+SkvYOYvA4OY9rw9Dhz0WaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749282613; c=relaxed/simple;
	bh=Taej4nwM0F33lMD1X74oWF+IDD9YK3h88CoaJDRFSz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4ObbFGl5UT6N/GdfVeZFRMXeHD4bppf0q4lZDf7LVl61Usjb/oLSuC8nY/ATr1rO6kM+OljbPa7KsqlypgkOV3IlXj6g2kePcd8QNQkyIKuYkuLdobGR4FKqLqUYlpWQ2mQSwEOjXuVCnHLhpLc7Bo+DC3mIVRiwwQrTw1aYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxNHAx70NoyhgPAQ--.40251S3;
	Sat, 07 Jun 2025 15:50:09 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxHcUv70NoBqIOAQ--.45176S2;
	Sat, 07 Jun 2025 15:50:08 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 25/35] mmc: sdhci-omap: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:49:55 +0800
Message-ID: <c45dd3f283de7e259cc2fa01ee8d1e34d18829d3.1749127796.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749127796.git.zhoubinbin@loongson.cn>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxHcUv70NoBqIOAQ--.45176S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF13Kw1DWr1fZr1DGFyfAFc_yoW8trWxpa
	nxJF97Kr48WFWrK398Gw17ZF15XrWjg3y0krWkGw18Cw45KFZ8trn3AFy0yF1rXFykJw15
	JF1UXF18ua98AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8
	Xw0E3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYyMKtUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-omap.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8897839ab2aa..429d8a517fb6 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1257,7 +1257,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	sdhci_get_of_property(pdev);
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto err_pltfm_free;
+		return ret;
 
 	soc = soc_device_match(sdhci_omap_soc_devices);
 	if (soc) {
@@ -1274,22 +1274,19 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
 
 	pltfm_host->clk = devm_clk_get(dev, "fck");
-	if (IS_ERR(pltfm_host->clk)) {
-		ret = PTR_ERR(pltfm_host->clk);
-		goto err_pltfm_free;
-	}
+	if (IS_ERR(pltfm_host->clk))
+		return PTR_ERR(pltfm_host->clk);
 
 	ret = clk_set_rate(pltfm_host->clk, mmc->f_max);
-	if (ret) {
-		dev_err(dev, "failed to set clock to %d\n", mmc->f_max);
-		goto err_pltfm_free;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to set clock to %d\n", mmc->f_max);
 
 	omap_host->pbias = devm_regulator_get_optional(dev, "pbias");
 	if (IS_ERR(omap_host->pbias)) {
 		ret = PTR_ERR(omap_host->pbias);
 		if (ret != -ENODEV)
-			goto err_pltfm_free;
+			return ret;
 		dev_dbg(dev, "unable to get pbias regulator %d\n", ret);
 	}
 	omap_host->pbias_enabled = false;
@@ -1387,9 +1384,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 err_rpm_disable:
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
-
-err_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -1406,7 +1400,6 @@ static void sdhci_omap_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	/* Ensure device gets disabled despite userspace sysfs config */
 	pm_runtime_force_suspend(dev);
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.1

