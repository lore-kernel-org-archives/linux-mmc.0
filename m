Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA991F4192
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281825; cv=none; b=mYEGAJeMDrZscIjFPZHDGsGPgje4hI9IL5TBvUjRy0V92ThCV2y2PsIeQsKKlUmrCw1sSzqZoF7voEdR7PHl3/3rcrKKfmlKrFHSO/OKbirOydnNEVMZ3o8/T3kNl0KxQENsJa1Z2I8gGoxUsn2Bs2c4jGQJUxXCfwZs3ucosrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281825; c=relaxed/simple;
	bh=3eDQBmQ+AJhNduv18t4R/1/3dV1qU6B9vBte766ow8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbiUnLoxMhy8VweRpQDO4DuGPuJ0/Ynvh9VtkfV74pUAo8VvlO8jlJ5zoNh1HJF4HD9xYocIy6Pu3ls6JDQrtQ9sbgllOyTxRzFuV+F804egWwdxpBMvIupBfvj+WrZqRaa5M+YWPvNxGgCG8Sk5U1oryitxuQosYwIl4/OkhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bxjawd7ENoHBYPAQ--.7319S3;
	Sat, 07 Jun 2025 15:37:01 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxPscX7ENoO54OAQ--.49043S4;
	Sat, 07 Jun 2025 15:37:00 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev
Subject: [PATCH v3 12/35] mmc: sdhci-esdhc-imx: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:36:45 +0800
Message-ID: <9b9014749a9870a9cb3c2818fe9b38c013cb46ca.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxPscX7ENoO54OAQ--.49043S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWrtF15CFWrGr1fuF1kGFyfGrX_yoW8Jr4DpF
	48Wr4Ykr47Jr95t3s0kw1DuF15t3W293yjkrW3W3yrWrW5Kryqqr4SyFyUtr1YyFW8Ka1F
	qFWvqr4UCFy7twcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5mXdUUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ac187a8798b7..011b60d21a80 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1973,7 +1973,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 free_sdhci:
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
-	sdhci_pltfm_free(pdev);
 	return err;
 }
 
@@ -1997,8 +1996,6 @@ static void sdhci_esdhc_imx_remove(struct platform_device *pdev)
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
-
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

