Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E859C149C64
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239632; cv=none; b=a7VPXy/tNhCrrP+vRPi2SBZOjgIDcUFC1sUopzDPU+wH2CiYCPfbz0BmZ/lsAhi6Dc797/Hlabob3GC+Rsl/NBttw1n5wGqL8mw70fUGOwqdtmpdeHpvDxoGtXri3NqoHN86z+NMTBbCE8rclug7PyLEvQea5Z0n5sooR9hEGng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239632; c=relaxed/simple;
	bh=bS2xqBU80Tpe9BjC7mu4415Gp1F+4rPP2Yi+JamH3+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN2c4TKwmR06ww7SQ7cNbUZ/IQXyYRMgSv1GgE4wHMEmAZLzpiFzxVhl5wrMF9OJCqR7dca4IC0YFWD44CgWFi1kUkoHXGVCpbXMHnvnZ2XNn+i9l9UeFtpteLXEEu2Nx+7nRvW7AR8K/LI5PEQiXycf79XnneQ244V0iecMpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxquANBTRo+4X8AA--.38197S3;
	Mon, 26 May 2025 14:07:09 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+ULBTRoqQTyAA--.32455S3;
	Mon, 26 May 2025 14:07:08 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 25/34] mmc: sdhci-omap: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:06:58 +0800
Message-ID: <a3b638a9efb382a9e832986b7154501528fa039f.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+ULBTRoqQTyAA--.32455S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF13Kw1DWr1fZr1DGFyfAFc_yoW8trWxpa
	nxJF97Kr48WFWrK398Gw17ZF15XrWjg3y0krWkGw18Cw45KFZ8trn3AFy0yF1rXFykJw15
	JF1UXF18ua98AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Gryq6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07ba1v3UUUUU=

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

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

