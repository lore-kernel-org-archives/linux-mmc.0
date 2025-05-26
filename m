Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D844149C64
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239644; cv=none; b=RfEN38AZAPA98pOn1+N1lzAxvX3WEPAYNNMif+jpFrewGuG42vIB9iRLaQcRm1qEjlC8b2uZ0YTwjoyb4M90wbZTaZHyDd/P4e79OIa/rtmqevFpjIKiEq43xYYeMYJqglr5+5lvIIOdBMv0d6HT0RFK4diDQFrruzETjk+yPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239644; c=relaxed/simple;
	bh=9kspLVRAFU1ToROP0OecpwgSemPmUm8kFWDl9SrLh6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIcitZrRSU7Pj3KdUGPdM7VQ+6IqJvkFdbC33rtwXfKUsK5Ux1+qnq+0mHQ7ihxGu0Bm0KV4yX9cq8R4HLxavfwjRM47EVHhPxKOjhUCKLr/4j3tYzv0RXznRnaEidRdlNWRNp4VXHsnW0Ob+Zj8AJxmwbJY2U5Oa+5QTRZZ/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxGHEZBTRoKob8AA--.15903S3;
	Mon, 26 May 2025 14:07:21 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxu8QXBTRowwTyAA--.30311S3;
	Mon, 26 May 2025 14:07:20 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 29/34] mmc: sdhci-sprd: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:07:10 +0800
Message-ID: <d7994a2655d27bc2cb6d740345747292b67e4a25.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxu8QXBTRowwTyAA--.30311S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1UXrWkXr1rKF15ArW3twc_yoW5AFWDpF
	saqr9a9FWUWr4rKFZ8Jw1DZF18Xw4j9ay3C3s5uwn7Ja1YkFZ5CrnakF10gF95ZrykGr15
	GF1UGFy8Z3ZrurcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
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
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYkwIDUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-sprd.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index db5e253b0f79..a5dec1a0e934 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -764,7 +764,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto pltfm_free;
+		return ret;
 
 	if (!mmc_card_is_removable(host->mmc))
 		host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
@@ -778,34 +778,26 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (!IS_ERR(sprd_host->pinctrl)) {
 		sprd_host->pins_uhs =
 			pinctrl_lookup_state(sprd_host->pinctrl, "state_uhs");
-		if (IS_ERR(sprd_host->pins_uhs)) {
-			ret = PTR_ERR(sprd_host->pins_uhs);
-			goto pltfm_free;
-		}
+		if (IS_ERR(sprd_host->pins_uhs))
+			return PTR_ERR(sprd_host->pins_uhs);
 
 		sprd_host->pins_default =
 			pinctrl_lookup_state(sprd_host->pinctrl, "default");
-		if (IS_ERR(sprd_host->pins_default)) {
-			ret = PTR_ERR(sprd_host->pins_default);
-			goto pltfm_free;
-		}
+		if (IS_ERR(sprd_host->pins_default))
+			return PTR_ERR(sprd_host->pins_default);
 	}
 
 	clk = devm_clk_get(&pdev->dev, "sdio");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto pltfm_free;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 	sprd_host->clk_sdio = clk;
 	sprd_host->base_rate = clk_get_rate(sprd_host->clk_sdio);
 	if (!sprd_host->base_rate)
 		sprd_host->base_rate = SDHCI_SPRD_CLK_DEF_RATE;
 
 	clk = devm_clk_get(&pdev->dev, "enable");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto pltfm_free;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 	sprd_host->clk_enable = clk;
 
 	clk = devm_clk_get(&pdev->dev, "2x_enable");
@@ -814,7 +806,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(sprd_host->clk_sdio);
 	if (ret)
-		goto pltfm_free;
+		return ret;
 
 	ret = clk_prepare_enable(sprd_host->clk_enable);
 	if (ret)
@@ -891,9 +883,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 clk_disable:
 	clk_disable_unprepare(sprd_host->clk_sdio);
-
-pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -907,8 +896,6 @@ static void sdhci_sprd_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
-
-	sdhci_pltfm_free(pdev);
 }
 
 static const struct of_device_id sdhci_sprd_of_match[] = {
-- 
2.47.1

