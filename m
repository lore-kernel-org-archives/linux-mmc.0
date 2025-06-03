Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975782309BE
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953705; cv=none; b=HzIdErSzf0pLzuIB6k0UHWz15V+SB/0e9M9mYgCYQT94loL9Cf/zvmznV4I9JCRSPSh8cMXTZshuynUmxzYbgKanxm5LTTwhdVE+HvU1V1XyzcOQnCeahwX7W1Q/4+jQK5sXAbG8EIk6JRAxjChE/btDDmdKjiDGgxU1x0DJ++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953705; c=relaxed/simple;
	bh=BaHgajgBiiQsQUA75xkYfUdvJvarBzHRpDdgY13cPaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o37Np+IlPMU0zLCBRGn4+AEfbZq2SxPhlxDh+9VC74jVo+DjhXMyGZTKVMJ5X8PwJaluYDMVurYmj+SbLUvpD0LEXrzmk+QFRGn2ePVxZ0KcvwZ+CArU5iYDbrKWxacTXb63LTIrCvZnXZfU6+fcXJAjj05hO4VlO7UXCJWDvWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxnnNm6j5o5DYKAQ--.63312S3;
	Tue, 03 Jun 2025 20:28:22 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3xte6j5oVA8HAQ--.36867S5;
	Tue, 03 Jun 2025 20:28:20 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 33/36] mmc: tmio: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:28:05 +0800
Message-ID: <d7d9120fc1ca2eb014cda4e481af5add05be0bf6.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3xte6j5oVA8HAQ--.36867S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFWkCrWkWrWrCw4kGw1kCrX_yoWrtF1DpF
	W5J3s8JrWUCFWFg3yDCa1DZFyrXw4vgayxK3y8Gwn7Z345GryDGr1DCFyjvF95JFWDWFsa
	qF4rKr18Cw1rArbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Gryq
	6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07b-3ktUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/renesas_sdhi_core.c |  6 +-----
 drivers/mmc/host/tmio_mmc.h          |  1 -
 drivers/mmc/host/tmio_mmc_core.c     | 18 +++---------------
 drivers/mmc/host/uniphier-sd.c       |  8 ++------
 4 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index e6fa3ed42560..4647d86e145e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1164,7 +1164,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	ret = renesas_sdhi_clk_enable(host);
 	if (ret)
-		goto efree;
+		return ret;
 
 	rcfg.of_node = of_get_available_child_by_name(dev->of_node, "vqmmc-regulator");
 	if (rcfg.of_node) {
@@ -1266,9 +1266,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 edisclk:
 	renesas_sdhi_clk_disable(host);
-efree:
-	tmio_mmc_host_free(host);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
@@ -1279,7 +1276,6 @@ void renesas_sdhi_remove(struct platform_device *pdev)
 
 	tmio_mmc_host_remove(host);
 	renesas_sdhi_clk_disable(host);
-	tmio_mmc_host_free(host);
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 41787ea77a13..23b0be8e6d7d 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -199,7 +199,6 @@ struct tmio_mmc_host {
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 					  struct tmio_mmc_data *pdata);
-void tmio_mmc_host_free(struct tmio_mmc_host *host);
 int tmio_mmc_host_probe(struct tmio_mmc_host *host);
 void tmio_mmc_host_remove(struct tmio_mmc_host *host);
 void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index b71241f55df5..c25c5fec3d77 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1097,7 +1097,7 @@ struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 	if (IS_ERR(ctl))
 		return ERR_CAST(ctl);
 
-	mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1110,29 +1110,17 @@ struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 	mmc->ops = &host->ops;
 
 	ret = mmc_of_parse(host->mmc);
-	if (ret) {
-		host = ERR_PTR(ret);
-		goto free;
-	}
+	if (ret)
+		return ERR_PTR(ret);
 
 	tmio_mmc_of_parse(pdev, mmc);
 
 	platform_set_drvdata(pdev, host);
 
-	return host;
-free:
-	mmc_free_host(mmc);
-
 	return host;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_alloc);
 
-void tmio_mmc_host_free(struct tmio_mmc_host *host)
-{
-	mmc_free_host(host->mmc);
-}
-EXPORT_SYMBOL_GPL(tmio_mmc_host_free);
-
 int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 {
 	struct platform_device *pdev = _host->pdev;
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 4ad02cfdc238..1eae2f4b6c1f 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -663,8 +663,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 		priv->rst_hw = devm_reset_control_get_exclusive(dev, "hw");
 		if (IS_ERR(priv->rst_hw)) {
 			dev_err(dev, "failed to get hw reset\n");
-			ret = PTR_ERR(priv->rst_hw);
-			goto free_host;
+			return PTR_ERR(priv->rst_hw);
 		}
 		host->ops.card_hw_reset = uniphier_sd_hw_reset;
 	}
@@ -694,7 +693,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 	ret = uniphier_sd_clk_enable(host);
 	if (ret)
-		goto free_host;
+		return ret;
 
 	uniphier_sd_host_init(host);
 
@@ -720,8 +719,6 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 disable_clk:
 	uniphier_sd_clk_disable(host);
-free_host:
-	tmio_mmc_host_free(host);
 
 	return ret;
 }
@@ -732,7 +729,6 @@ static void uniphier_sd_remove(struct platform_device *pdev)
 
 	tmio_mmc_host_remove(host);
 	uniphier_sd_clk_disable(host);
-	tmio_mmc_host_free(host);
 }
 
 static const struct of_device_id uniphier_sd_match[] = {
-- 
2.47.1

