Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB101C8639
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239585; cv=none; b=FJ2rRGDRUhIxD4ujnyNy+x0lJHyOnoiLczaxnrsCRpGddxmmzfqhGiExRrAQQ9IF/73I6WEz8vjGNJBK0TAa/dn6yxaoFYsUvPat7BPP6PodP7qFqY061jOnA9FioNfSY7sAj69NmjpkicImjdJjZR4gRiITCw3I73DVWeTV+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239585; c=relaxed/simple;
	bh=XZG+gFfw9PHL/GjSMNInA1xmhhqAXyYOkP1RHDyBIpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbQaQ/VZmzasyWZvgwaXoT/0rOtOpi7wSzR+bePl0JhJ4bqDrMU0nhDu0ALs5sb1tBtlPhKhV/FAwskS/nz8q6LYDKLFWXWqHvH3i4wu1bQ2o3p8cPdgy5utrXWuORZpFgWwAm0aT5AFxVZRJQP66DfaMbiRk5KCODRNIurwzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxvnLeBDRokYX8AA--.14811S3;
	Mon, 26 May 2025 14:06:22 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxvhvZBDRoKQTyAA--.45642S5;
	Mon, 26 May 2025 14:06:20 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH 13/34] mmc: sdhci-esdhc-mcf: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:06:09 +0800
Message-ID: <15e9ab28d6b5caa6e34f343b146fc2201f4a848f.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxvhvZBDRoKQTyAA--.45642S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4DXw4Dtr4kKF18XF18WFX_yoW8tFW7pa
	yfXrW5tr4xJr4ktayDWwnF9r45Jr13Kay8Ka98Gw18JF4akryDKr4Sya4kWFWFyrykJ345
	XrWjgr9IvFn7WrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07j25lbUUUUU=

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Cc: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 327662ba5bd9..375fce5639d7 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -426,28 +426,22 @@ static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
 	host->flags |= SDHCI_AUTO_CMD12;
 
 	mcf_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(mcf_data->clk_ipg)) {
-		err = PTR_ERR(mcf_data->clk_ipg);
-		goto err_exit;
-	}
+	if (IS_ERR(mcf_data->clk_ipg))
+		return PTR_ERR(mcf_data->clk_ipg);
 
 	mcf_data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
-	if (IS_ERR(mcf_data->clk_ahb)) {
-		err = PTR_ERR(mcf_data->clk_ahb);
-		goto err_exit;
-	}
+	if (IS_ERR(mcf_data->clk_ahb))
+		return PTR_ERR(mcf_data->clk_ahb);
 
 	mcf_data->clk_per = devm_clk_get(&pdev->dev, "per");
-	if (IS_ERR(mcf_data->clk_per)) {
-		err = PTR_ERR(mcf_data->clk_per);
-		goto err_exit;
-	}
+	if (IS_ERR(mcf_data->clk_per))
+		return PTR_ERR(mcf_data->clk_per);
 
 	pltfm_host->clk = mcf_data->clk_per;
 	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
 	err = clk_prepare_enable(mcf_data->clk_per);
 	if (err)
-		goto err_exit;
+		return err;
 
 	err = clk_prepare_enable(mcf_data->clk_ipg);
 	if (err)
@@ -485,9 +479,6 @@ static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mcf_data->clk_ipg);
 unprep_per:
 	clk_disable_unprepare(mcf_data->clk_per);
-err_exit:
-	sdhci_pltfm_free(pdev);
-
 	return err;
 }
 
@@ -502,8 +493,6 @@ static void sdhci_esdhc_mcf_remove(struct platform_device *pdev)
 	clk_disable_unprepare(mcf_data->clk_ipg);
 	clk_disable_unprepare(mcf_data->clk_ahb);
 	clk_disable_unprepare(mcf_data->clk_per);
-
-	sdhci_pltfm_free(pdev);
 }
 
 static struct platform_driver sdhci_esdhc_mcf_driver = {
-- 
2.47.1

