Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9651D6193
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749282679; cv=none; b=XFaUS4ffjF7UeZz/1WGySn0+tEdgSl5M2WleBuZ1jqbsjklN9LsNtWMpomGZbDFljofu4yHzccVoQL9LFSkEt/jCGgDgznjVi+jbwJ5jBjR0OVfvR2I4GYUzDRIEDJjZCC2JY6Gwt9MkMwW3ck5AXYJhDqS8O2peC0c+chNH9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749282679; c=relaxed/simple;
	bh=aEo09SDN7IKz2C7iPCLvloc9yqfG67JoznHm8tjlwMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKPQQXr7PIeWp03Sj6IP1fVlCY8tkqGMUEIRVnV9GLNHdWlXPQ23mcxeKOrvVtxIa2k/L/l5z/6ulBnqsK8djmHSxbJ454lKomoOnq7a8Z7/kMXwk1v6mKefw9saoNRfHm7HMKjLheg2uvjLNPoDjuzRX/lwqFqYyzT+4Mn5R5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxbeJ070NoARkPAQ--.2706S3;
	Sat, 07 Jun 2025 15:51:16 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx_cZx70NoYKIOAQ--.50853S2;
	Sat, 07 Jun 2025 15:51:15 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 28/35] mmc: sdhci-pxav3: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:51:05 +0800
Message-ID: <7b489e7326349c3709caa33efb0e995b5667fb27.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx_cZx70NoYKIOAQ--.50853S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1rGr17XFykJryDKrW7GFX_yoW8Gr1rpa
	18GryvkrZrWrWrKas8JwnF9FyUKF12gayFgFW5Gwn7GFWakryktF4fAFy0qFy5XrW8Gws3
	Xr10qr48CFyUu3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
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

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pxav3.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3fb56face3d8..7173a0296738 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -389,8 +389,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		pxa->clk_io = devm_clk_get(dev, NULL);
 	if (IS_ERR(pxa->clk_io)) {
 		dev_err(dev, "failed to get io clock\n");
-		ret = PTR_ERR(pxa->clk_io);
-		goto err_clk_get;
+		return PTR_ERR(pxa->clk_io);
 	}
 	pltfm_host->clk = pxa->clk_io;
 	clk_prepare_enable(pxa->clk_io);
@@ -466,8 +465,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 err_mbus_win:
 	clk_disable_unprepare(pxa->clk_io);
 	clk_disable_unprepare(pxa->clk_core);
-err_clk_get:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -485,8 +482,6 @@ static void sdhci_pxav3_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pxa->clk_io);
 	clk_disable_unprepare(pxa->clk_core);
-
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

