Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1122647
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524577; cv=none; b=bho0mGHLqXH5gTNwQNy3ejeaNgFVZkL9bJZtsJyQo22YrfSZa/Kd3bAobjz+WFIHrEd8oyIWX0v0036nDpL6NnyhTNmUmBHclB2I/+fxZLgl1q39/X4RJMi1Tjw6M7/rZKrfXw9Y4ZzASLvo9Czu2oKoy13a4siM1pDiV+rGcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524577; c=relaxed/simple;
	bh=Taej4nwM0F33lMD1X74oWF+IDD9YK3h88CoaJDRFSz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEdOWRTjbZkATEIxlpWrHJlcsTcF0YuJEYK2/yIVdt7f+WOJoN86wRe6dIF6Ffmu0WG7njjGaWQYHr6jBUG6gkZ7a306s0MpyoH8oab2dzdPn0M877tE484cV96PYte8ghq8Zn/1ow0fptR3Zpk4sOuXioTsoBRQLXqBCBn+Wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxWOEeXjhohzMCAQ--.21626S3;
	Thu, 29 May 2025 21:16:14 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDx_MQcXjho+rz6AA--.53925S2;
	Thu, 29 May 2025 21:16:13 +0800 (CST)
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
Subject: [PATCH v2 25/35] mmc: sdhci-omap: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:16:03 +0800
Message-ID: <a3477d3d9c923376b9bd435bdb7c0cfb2d81e7d0.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDx_MQcXjho+rz6AA--.53925S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF13Kw1DWr1fZr1DGFyfAFc_yoW8trWxpa
	nxJF97Kr48WFWrK398Gw17ZF15XrWjg3y0krWkGw18Cw45KFZ8trn3AFy0yF1rXFykJw15
	JF1UXF18ua98AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26Fy26r45
	twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU5PhL5UUUUU==

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

