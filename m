Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4474C9D
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524288; cv=none; b=sX2TWdeSYvLKuJdpmroBTe0tZiWKN8S01yVGr9G4/PfcnnIH/slt4X9RVEdjEFHFBdC5I6J1A0zqSbQs6l2HzkO0RW4l9pmkE1GpMxUhKMqcCGfUbA80qChVKApZZ/YD7MBByc7FbC4Lf96M6gvlJqYQL5ClYG29r6wB/ijymXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524288; c=relaxed/simple;
	bh=gvBtDWkbtbkWO+kfisKgwxj/lV+BNsNp0XTiuOtpfVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwBEJCMMMFfX0ONawKf5OSnZjT8l3dRgMbJGxKHDUBIflGBZtqyX0zhAJ0LolCll1TXmZ1TpkI44ISY7KtMgLSV7nk9joYgRLtrARK7Efpel9TAq8eVOqgCHvB0QmMjBdi9kCwuPETYfLVaDFin5rIIcx7tqvyj2V+SiUNU9T40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxLGv3XDhoqDECAQ--.22258S3;
	Thu, 29 May 2025 21:11:19 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxHcX0XDho8Ln6AA--.55633S2;
	Thu, 29 May 2025 21:11:18 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>
Subject: [PATCH v2 23/35] mmc: sdhci-of-ma35d1: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:11:06 +0800
Message-ID: <0602da4dab975fe8aaa21679b2d588d557edb9b0.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBxHcX0XDho8Ln6AA--.55633S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF43AryrXryUCr4xZF47GFX_yoW8tryUpa
	9rJF97tFy8ZrWrK39xGw1UZ3WrGr12gay8K3y8Ww18trW5tryDtrnaya40yFWrJFy0v343
	Za1qqr18CayDW3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Gryq
	6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07b3iihUUUUU=

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Jacky Huang <ychuang3@nuvoton.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-ma35d1.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-of-ma35d1.c
index 1e6d180100ad..287026422616 100644
--- a/drivers/mmc/host/sdhci-of-ma35d1.c
+++ b/drivers/mmc/host/sdhci-of-ma35d1.c
@@ -211,20 +211,18 @@ static int ma35_probe(struct platform_device *pdev)
 	priv = sdhci_pltfm_priv(pltfm_host);
 
 	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
-	if (IS_ERR(pltfm_host->clk)) {
-		err = dev_err_probe(dev, PTR_ERR(pltfm_host->clk), "failed to get clk\n");
-		goto err_sdhci;
-	}
+	if (IS_ERR(pltfm_host->clk))
+		return dev_err_probe(dev, PTR_ERR(pltfm_host->clk),
+				     "failed to get clk\n");
 
 	err = mmc_of_parse(host->mmc);
 	if (err)
-		goto err_sdhci;
+		return err;
 
 	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(priv->rst)) {
-		err = dev_err_probe(dev, PTR_ERR(priv->rst), "failed to get reset control\n");
-		goto err_sdhci;
-	}
+	if (IS_ERR(priv->rst))
+		return dev_err_probe(dev, PTR_ERR(priv->rst),
+				     "failed to get reset control\n");
 
 	sdhci_get_of_property(pdev);
 
@@ -255,7 +253,7 @@ static int ma35_probe(struct platform_device *pdev)
 
 	err = sdhci_add_host(host);
 	if (err)
-		goto err_sdhci;
+		return err;
 
 	/*
 	 * Split data into chunks of 16 or 8 bytes for transmission.
@@ -268,10 +266,6 @@ static int ma35_probe(struct platform_device *pdev)
 	sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
 
 	return 0;
-
-err_sdhci:
-	sdhci_pltfm_free(pdev);
-	return err;
 }
 
 static void ma35_disable_card_clk(struct sdhci_host *host)
@@ -291,7 +285,6 @@ static void ma35_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, 0);
 	ma35_disable_card_clk(host);
-	sdhci_pltfm_free(pdev);
 }
 
 static const struct of_device_id sdhci_ma35_dt_ids[] = {
-- 
2.47.1

