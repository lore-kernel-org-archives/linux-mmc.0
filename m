Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197251922FD
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239655; cv=none; b=C4+TE33+1KfrGIEprHOst5SoUvOlhJ97VAoXhctMqSyc3bcXAgl52cySzbErZYOQHEe+jEfz/9Hxa0sOUdm7+1BdnK08kTl4pjpipVwaAHQnEgQ1GuU5LNRoxGtP7LpqWt3IFhlVUQCpYt8i97F/EgOJwg58umJYVGSd2PBGiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239655; c=relaxed/simple;
	bh=EitnyjbKo7HcRohLVnstFswxUIWtHY9Ai3PvPhBg3Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIi01EyvfSDXxfaI+MK6ODlqrGm8tHmCawG/h62dLOCfYggK8fL9CdKO8qWVGq/55+HR2nnPvXgdZMlNx2kec13Rqicno+6p4V0YNpzzErlHWGbWdwPbPJo/E8pXo2vy/D8EpCtiONzt8od/ZhsXS8JxmoduMGwGqGj6iunh8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxbeIkBTRoVIb8AA--.41194S3;
	Mon, 26 May 2025 14:07:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxu8QhBTRo0gTyAA--.30312S4;
	Mon, 26 May 2025 14:07:32 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Hu Ziji <huziji@marvell.com>
Subject: [PATCH 32/34] mmc: sdhci-xenon: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:07:20 +0800
Message-ID: <67f2389da4a2cc4d2d463b652f118ef4e8caeee4.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxu8QhBTRo0gTyAA--.30312S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4rGFy7tw4kAF13KF1ruFX_yoW8Xw48pa
	9ayFy5Ka17WFWUKas0qw4DZF15ta12gay8Kry5Gw1kG3yakrW5trs3AFW8ZF4rAFy8Kw4f
	Wa4DtF48uas8CabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
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

Cc: Hu Ziji <huziji@marvell.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-xenon.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 098f0ea45cbe..20efb0225d3a 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -533,13 +533,12 @@ static int xenon_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
 		if (IS_ERR(pltfm_host->clk)) {
-			err = PTR_ERR(pltfm_host->clk);
 			dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
-			goto free_pltfm;
+			return PTR_ERR(pltfm_host->clk);
 		}
 		err = clk_prepare_enable(pltfm_host->clk);
 		if (err)
-			goto free_pltfm;
+			return err;
 
 		priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
 		if (IS_ERR(priv->axi_clk)) {
@@ -603,8 +602,6 @@ static int xenon_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->axi_clk);
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
-free_pltfm:
-	sdhci_pltfm_free(pdev);
 	return err;
 }
 
@@ -623,8 +620,6 @@ static void xenon_remove(struct platform_device *pdev)
 	xenon_sdhc_unprepare(host);
 	clk_disable_unprepare(priv->axi_clk);
 	clk_disable_unprepare(pltfm_host->clk);
-
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

