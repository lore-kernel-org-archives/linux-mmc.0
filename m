Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415FF132103
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523606; cv=none; b=VEb7B8h6UHa0nJlBMKksQNYv2vzZmYtx6Cwmih1qWrR/abN1mRYy23+D9cCI+Ru5rZ6PG3OmBBdu2LXPLDFCI/gAFGNp0Rs+Y4KPLf+SzCqRywZThGGRp88NYnEddo4Ui4sq1JkCn3Zm+rzchcdaFZ80LcuqyYHZOJdqjrSDNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523606; c=relaxed/simple;
	bh=0VOEVfKlIZ6cUQvIBizw9KM3ucLknirNt447P2UiNvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5+uBmy9FrB6KcIoFSuTQzISl5E9SwkdjqKSldGU7FfPhhPowALJC1k7KjTuCayT7jT+zQHBir6FKz0A90DRIeuekbC/GM2EhKU0o7xquljAte0XriOkLVZE0hIKr9qet60dgO9WiVYGlsuFqJGSe+e9j8EQCVFcT6i8kh7rQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxaeBSWjhocysCAQ--.23535S3;
	Thu, 29 May 2025 21:00:02 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxb8dIWjhodrP6AA--.53585S5;
	Thu, 29 May 2025 21:00:02 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 17/35] mmc: sdhci-of-arasan: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 20:59:44 +0800
Message-ID: <57cfb1882e2bb73be903d50b68e67a02ed835373.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBxb8dIWjhodrP6AA--.53585S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF48ZFyrCr1UCr4fWr15trc_yoW8tF4DpF
	s5XFWrt3W5Wrs5Wr93tw4UZr18J345KayUKryrCwn7ZrZ0kryDKF1xAFyIvFyqyFy8uw13
	Ww1fXr48CF4Uu3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-arasan.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 8c29676ab662..42878474e56e 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1883,34 +1883,26 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		sdhci_arasan->soc_ctl_base = syscon_node_to_regmap(node);
 		of_node_put(node);
 
-		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
-			ret = dev_err_probe(dev,
+		if (IS_ERR(sdhci_arasan->soc_ctl_base))
+			return dev_err_probe(dev,
 					    PTR_ERR(sdhci_arasan->soc_ctl_base),
 					    "Can't get syscon\n");
-			goto err_pltfm_free;
-		}
 	}
 
 	sdhci_get_of_property(pdev);
 
 	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
-	if (IS_ERR(sdhci_arasan->clk_ahb)) {
-		ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
+	if (IS_ERR(sdhci_arasan->clk_ahb))
+		return dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
 				    "clk_ahb clock not found.\n");
-		goto err_pltfm_free;
-	}
 
 	clk_xin = devm_clk_get(dev, "clk_xin");
-	if (IS_ERR(clk_xin)) {
-		ret = dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clock not found.\n");
-		goto err_pltfm_free;
-	}
+	if (IS_ERR(clk_xin))
+		return dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clock not found.\n");
 
 	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
-	if (ret) {
-		dev_err(dev, "Unable to enable AHB clock.\n");
-		goto err_pltfm_free;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to enable AHB clock.\n");
 
 	/* If clock-frequency property is set, use the provided value */
 	if (pltfm_host->clock &&
@@ -2029,8 +2021,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
-err_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
-- 
2.47.1

