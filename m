Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248E3145346
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239581; cv=none; b=e2DIQW+OxM0954mSZz5TfyFcsbInt8Cq+FpEAkkhDHq5JXva7JLvcUEfFLbGlaYMDWNvczJ1W9xhTyblw4RBZJXigaMbAELtiLxjfbje4psQ97+jZIRFwMFa52hbipT6Q3b6A5hBtxxzj0hGq7Z4JqG0DS/FLwpniD2sbbVQF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239581; c=relaxed/simple;
	bh=NhPsCj5l+dotACRfQ6FAKS1xfCDCMaTG0wUHFiH9GFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7U8OXahKX3qtoMV/6RSgstoaDii1ZR+JXQ8t1KrUabyUpFY81vHoUN4uHbuPk46y4dcbtOU4SBkYezwTmXICjt3Utfz4tND/8HhAAG1mcRK7WvlwRkk3X3YBoLn7IRxatYAP2cSiNvOZWzyLWk79WZZcp0Wj7moVTxaTZV5Vq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxCGraBDRofoX8AA--.13878S3;
	Mon, 26 May 2025 14:06:18 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxvhvZBDRoKQTyAA--.45642S2;
	Mon, 26 May 2025 14:06:17 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 10/34] mmc: sdhci-cadence: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:06:06 +0800
Message-ID: <ed2d9ba0eb189bbf74006422a49809d99ad93353.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxvhvZBDRoKQTyAA--.45642S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw47XF4Dtr47WF1DJr45CFX_yoW8Ar13pa
	1rAFZ3Cr18XF4rCrZ3Zwsrur1Ykw429ayDKFWrCw1xXrZIk3yUtr1xAFyjqFZ8trW8Ka1r
	WF4qyr98uF98A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jxSdgUUUUU=

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-cadence.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index a94b297fcf2a..a37e6a1f5127 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -515,7 +515,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (data->init) {
 		ret = data->init(pdev);
 		if (ret)
-			goto free;
+			return ret;
 	}
 	sdhci_enable_v4_mode(host);
 	__sdhci_read_caps(host, &version, NULL, NULL);
@@ -524,33 +524,24 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto free;
+		return ret;
 
 	sdhci_cdns_phy_param_parse(dev->of_node, priv);
 
 	ret = sdhci_cdns_phy_init(priv);
 	if (ret)
-		goto free;
+		return ret;
 
 	if (host->mmc->caps & MMC_CAP_HW_RESET) {
 		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
-		if (IS_ERR(priv->rst_hw)) {
-			ret = dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
+		if (IS_ERR(priv->rst_hw))
+			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
 					    "reset controller error\n");
-			goto free;
-		}
 		if (priv->rst_hw)
 			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
 	}
 
-	ret = sdhci_add_host(host);
-	if (ret)
-		goto free;
-
-	return 0;
-free:
-	sdhci_pltfm_free(pdev);
-	return ret;
+	return sdhci_add_host(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

