Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6436A1DC997
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525151; cv=none; b=RyVUVmnBYHK2TRyzc38E5RK3HNYqqE8T+G6Ih6Wwj+g8cJYJ/CNS6vanAKDiiFRdzFaOu0kTLyO+D7xJmjRw9k2ShVdBiC9S9JJNNuySreWVFb8OCeVHIoxGYzGMhZjZcel63SpQbUxGz2fl0sWZTToeM60ATmapjr9gjNtwf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525151; c=relaxed/simple;
	bh=uiDxw6jK7Av8dyaqHvmfk+f14H8MMoqqlSknelKy4uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLBPXBrmNSCDr8LzqSFSfbt+VhGG/SkO1k/rkJBJ8MfY+5O5hPyqtQjz95LF0GyFPPais+geDpVPnIfYUYjQAa4IS4z76lhwxPB+drKd/28i9Qx6Pz5PeGvbxNhUMGTA5qp27FEeQvrgAX6jhlnUerxA4VVq53OoORkocXvrq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxIK9bYDhoSDcCAQ--.19874S3;
	Thu, 29 May 2025 21:25:47 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxXsVXYDhoRML6AA--.57259S2;
	Thu, 29 May 2025 21:25:47 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 33/35] mmc: sdhci_am654: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:25:35 +0800
Message-ID: <4258bdf5dd5f843db99678a1fe7fd9d104e8ed34.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBxXsVXYDhoRML6AA--.57259S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW7Xw17KFW5CFW7WFWUWrX_yoW8tryxpa
	9xJFWxKrW8WF45Ka98Aw17ZF15Aw4qkayUKrWrAwn7X390yayktrsayFW0v3WvqFy0q3W5
	ZFW5J3y8Ca45ZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8
	Xw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUgPxhDUUUU

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci_am654.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 73385ff4c0f3..58258e275dbb 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -942,35 +942,30 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	clk_xin = devm_clk_get(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
 		dev_err(dev, "clk_xin clock not found.\n");
-		ret = PTR_ERR(clk_xin);
-		goto err_pltfm_free;
+		return PTR_ERR(clk_xin);
 	}
 
 	pltfm_host->clk = clk_xin;
 
 	base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto err_pltfm_free;
+		return PTR_ERR(base);
 	}
 
 	sdhci_am654->base = devm_regmap_init_mmio(dev, base,
 						  &sdhci_am654_regmap_config);
 	if (IS_ERR(sdhci_am654->base)) {
 		dev_err(dev, "Failed to initialize regmap\n");
-		ret = PTR_ERR(sdhci_am654->base);
-		goto err_pltfm_free;
+		return PTR_ERR(sdhci_am654->base);
 	}
 
 	ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
 	if (ret)
-		goto err_pltfm_free;
+		return ret;
 
 	ret = mmc_of_parse(host->mmc);
-	if (ret) {
-		dev_err_probe(dev, ret, "parsing dt failed\n");
-		goto err_pltfm_free;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "parsing dt failed\n");
 
 	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
@@ -1001,8 +996,6 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 pm_put:
 	pm_runtime_put_noidle(dev);
-err_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -1021,7 +1014,6 @@ static void sdhci_am654_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.1

