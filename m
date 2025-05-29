Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E421E521
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523577; cv=none; b=UkIcT5X2RXR6I9avoC4X62zCHEbtvNGxoHPkwPKiQ6p5pzaZhpF1kUc8PYHMLzEUAysz51eWezxY/AiAS6vxQqV8TP62M+9y59IIuhBbyr+smNZNg84MzdeMpePyER35FglnGtFAWLu/B45RFVdIGvHtqW+xi6QKQcKun60hTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523577; c=relaxed/simple;
	bh=ZpqY0xzpWUmYu0TWy6m2JoWok74D5NE7JsWUJJX9LTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI4pzpUY8HJKAgKKJ7jbmhJNAo8lIl3i8oZ4rgWLQa7lDfl70eI0h1FN14d6v+x4MLWDhr96cHkMkEfHdk6U4YEscikp2Lvy3cXhSYtYw/9o0uT9MMS55XOHobmzm3vN1kHr5bOzq4yD2RDSEbzQSH0pd/RwG6l2ma7TwWAYHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxvOI2WjhoESsCAQ--.24544S3;
	Thu, 29 May 2025 20:59:34 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3MQ0WjhoV7P6AA--.54884S2;
	Thu, 29 May 2025 20:59:33 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 10/35] mmc: sdhci-cadence: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 20:59:18 +0800
Message-ID: <ecec19e09e053f39b7a31d16238a559073de4a67.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBx3MQ0WjhoV7P6AA--.54884S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw47XF4Dtr47WF1DJr45CFX_yoW8Ar13pa
	1rAFZ3Cr18XF4rCrZ3Zwsrur1Ykw429ayDKFWrCw1xXrZIk3yUtr1xAFyjqFZ8trW8Ka1r
	WF4qyr98uF98A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bOq2NUUUUU=

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

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

