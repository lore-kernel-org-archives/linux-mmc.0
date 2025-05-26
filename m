Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025471922FD
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239631; cv=none; b=jcpsx5w7oC9GiQDDOoNvrhW68tSWU5mQEBgVJql9bQQxjWcwEwSVtgAeTskvwH35IdI7YvdbfA0YUaRo3ZSdkczmGSANQ3FRsySl9LdBSvIXPqYYpBJfgRvDOMEXBpNhtXws6xC/m3Xv/3c90h9lXLvHi44QCHKh9UEbOE/SY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239631; c=relaxed/simple;
	bh=PmINK6tzV8VRSSUxgzdPZPtV+oVRcVIzxqg0M3mG4Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KakNg56PYvP642LAFFynAXz4UucM/oGmROdlsXxyi4Ziv4JXUXb7PPqLr4eFllY95op5VqNL7J1HtS+BYOlBygRrHdEsEUqPhIGqXeqEttvlRfveUXsUkzE6UwGD0Wti6hWVJ63R1lsidoIipFHVIGktTg4Xatun0zRzo+ACELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxbWsMBTRo9IX8AA--.13539S3;
	Mon, 26 May 2025 14:07:08 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+ULBTRoqQTyAA--.32455S2;
	Mon, 26 May 2025 14:07:08 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH 24/34] mmc: sdhci-of-sparx5: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:06:57 +0800
Message-ID: <b5b65c9a4672174712446de69f60d23e2e44a8f0.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+ULBTRoqQTyAA--.32455S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4rKF47WryxKr1fWw4xZrc_yoW5JF4Upa
	yfAFZxKr1FgrWrCayDJw1UuF1UGr4jgayUKrW8Gwsag3yY9rWDKrn3AFW0gFyrGF95K3Zx
	XF4jqF18AasruFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Gryq6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07b-3ktUUUUU=

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-sparx5.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
index d2aa684e786f..b3db1e2c4c0e 100644
--- a/drivers/mmc/host/sdhci-of-sparx5.c
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -185,11 +185,9 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 	sdhci_sparx5->host = host;
 
 	pltfm_host->clk = devm_clk_get_enabled(&pdev->dev, "core");
-	if (IS_ERR(pltfm_host->clk)) {
-		ret = PTR_ERR(pltfm_host->clk);
-		dev_err(&pdev->dev, "failed to get and enable core clk: %d\n", ret);
-		goto free_pltfm;
-	}
+	if (IS_ERR(pltfm_host->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pltfm_host->clk),
+				     "failed to get and enable core clk\n");
 
 	if (!of_property_read_u32(np, "microchip,clock-delay", &value) &&
 	    (value > 0 && value <= MSHC_DLY_CC_MAX))
@@ -199,14 +197,12 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto free_pltfm;
+		return ret;
 
 	sdhci_sparx5->cpu_ctrl = syscon_regmap_lookup_by_compatible(syscon);
-	if (IS_ERR(sdhci_sparx5->cpu_ctrl)) {
-		dev_err(&pdev->dev, "No CPU syscon regmap !\n");
-		ret = PTR_ERR(sdhci_sparx5->cpu_ctrl);
-		goto free_pltfm;
-	}
+	if (IS_ERR(sdhci_sparx5->cpu_ctrl))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sdhci_sparx5->cpu_ctrl),
+				     "No CPU syscon regmap !\n");
 
 	if (sdhci_sparx5->delay_clock >= 0)
 		sparx5_set_delay(host, sdhci_sparx5->delay_clock);
@@ -222,7 +218,7 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto free_pltfm;
+		return ret;
 
 	/* Set AXI bus master to use un-cached access (for DMA) */
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA) &&
@@ -235,10 +231,6 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 		 mmc_hostname(host->mmc), sdhci_readl(host, MSHC2_TYPE));
 
 	return ret;
-
-free_pltfm:
-	sdhci_pltfm_free(pdev);
-	return ret;
 }
 
 static const struct of_device_id sdhci_sparx5_of_match[] = {
-- 
2.47.1

