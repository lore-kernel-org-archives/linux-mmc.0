Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81241F4612
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281880; cv=none; b=KdBxVnRZg9tIVo79ihwEt+Y666/Y3aE1/ZWOu3O03/HcMUnHktVjm5VQ+mFwrxhr3aASZe3h3dB1dehxOORbk02ohxhspTYtqTr5UhCesixuDKqG/eBqfc/xmdVX4qLKmZ6zOfpapY52LmuGgGtb4BHEImRAfDln6fpDfRU0GL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281880; c=relaxed/simple;
	bh=0VOEVfKlIZ6cUQvIBizw9KM3ucLknirNt447P2UiNvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k64ncSjoPPXgpESVJaR9wAuQENvzWcWr6nSLpN5ErVv5RTN/gNdE/dbU8EoJGk1/O3H8OuLJVcfkRMIjmrSWjEH0cIELpuivY7x0LjsrB/eJ9+xDWPwqDucOVOvbmefXBgVqkp5ULTT0Xj/0cZT5yCtjzB+J1mCmjTQ6REJZ1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxHHJV7ENofhYPAQ--.40694S3;
	Sat, 07 Jun 2025 15:37:57 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxvhtN7ENomp4OAQ--.58650S5;
	Sat, 07 Jun 2025 15:37:56 +0800 (CST)
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
Subject: [PATCH v3 17/35] mmc: sdhci-of-arasan: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:37:41 +0800
Message-ID: <ff7094276568354687a691f7f2789048c1706476.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxvhtN7ENomp4OAQ--.58650S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF48ZFyrCr1UCr4fWr15trc_yoW8tF4DpF
	s5XFWrt3W5Wrs5Wr93tw4UZr18J345KayUKryrCwn7ZrZ0kryDKF1xAFyIvFyqyFy8uw13
	Ww1fXr48CF4Uu3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8
	Xw0E3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYyMKtUUUUU==

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

