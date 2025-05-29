Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43660647
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524900; cv=none; b=XH8AyMczd1U3HJy23bxEABLJtIhhKsREXzh2R0xJ14LUwGlNV0caH9w/pIl0M/1I+Rux3pM0yZEFI0aF3qo0dO5cUX2Ml8I73Y7aCekNZgGyc813VLRZg7juCepil0KUwxB/s0cPRSnhgHzpIV0T0VsdnDE97txpDGlRt4MH0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524900; c=relaxed/simple;
	bh=zTYKub1b0KqN/G7+cPL2mNNaBmH7SKkNPYT7DKTjwZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clBgXZNXQ6PQLENEA57M/UU4SzB8LZbLnkU85XH88LKnQduSwIisksFyWFg+cHTzk06XwJp0du+x8y/MsSMFwxOerhJhsGicgRqTfv8wEtz8oKRlHPZJpu7RCfQvZvJhSRTeLCusoUeWW0k0O6nTPT7CZN/W5l+OSPJ+h0N5Gn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxWOFgXzhoizUCAQ--.21631S3;
	Thu, 29 May 2025 21:21:36 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxvhtcXzhoJsD6AA--.3688S2;
	Thu, 29 May 2025 21:21:33 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 29/35] mmc: sdhci-sprd: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:21:23 +0800
Message-ID: <c7edbeee7192349f8ffc05041cd2e4812b717a72.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxvhtcXzhoJsD6AA--.3688S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1UXrWkXr1rKF15ArW3twc_yoW5Aw1fpF
	sagr9a9FWUWr4rKFZ8Jw1DZF18Xw4j9ay3C3s5uwn7Xa1YkFZ8CrnakF10gF95ZrykGr15
	WF1UGFy8Z3ZrurcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU5HOJ5UUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>
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

