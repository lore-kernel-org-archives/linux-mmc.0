Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060431E2853
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281957; cv=none; b=b8KSl0rKdHuKynwQ7IBC+AzLsSrQlFd9FEm/7O1Nkfvaw8aQ1Qzap/Mw7pRwjCnwvYogqkJdl/QEdsWMjnEHaj3ENURmKr3R3SzUeuEQJsPBMbd6tBkIpzTvs9jMqcnasp0cRGsHSZTTatjO5RdBn121Bpg6qLGvWFLirmb7dS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281957; c=relaxed/simple;
	bh=GZMsjzBuZ6dzSwKbYpDA5ciEstLbQI9uDXJuHtksAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZOKA0s8amNzZ094dqaRDhnKUuYjsAPVhyXmoUzRcK4EF4iCoaP8g1nEErM8AnBgcaKvlAJ0T9GJIawd4g4Idr4FsLEKXdf0UNgE5G3ea3BFqW+m8LyPSjov4H2JG/n/J+dbusybxkvdanu8QIgQxFQU5y0U8eKI5cY1nA6gM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxXWui7ENosxYPAQ--.40802S3;
	Sat, 07 Jun 2025 15:39:14 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxDcWg7ENo4p4OAQ--.42474S2;
	Sat, 07 Jun 2025 15:39:13 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 20/35] mmc: sdhci-of-dwcmshc: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:39:01 +0800
Message-ID: <01b6797d55562e124599663e859dd9b7d4e4d8e0.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxDcWg7ENo4p4OAQ--.42474S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF1fJF4kWr1rGFWDGF4kGrX_yoW8AF45pa
	9rJFWxKrsruFW0kwn8Jw1DZ3W8tw42ga48KrWrG3WkGw4akFyDtrs3Ca48ZF1FyFy8tw45
	K3WjyF48CF1DCFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYgNVDUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a20d03fdd6a9..ee6b1096f709 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -1387,14 +1387,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	if (dev->of_node) {
 		pltfm_host->clk = devm_clk_get(dev, "core");
-		if (IS_ERR(pltfm_host->clk)) {
-			err = PTR_ERR(pltfm_host->clk);
-			dev_err(dev, "failed to get core clk: %d\n", err);
-			goto free_pltfm;
-		}
+		if (IS_ERR(pltfm_host->clk))
+			return dev_err_probe(dev, PTR_ERR(pltfm_host->clk),
+					     "failed to get core clk\n");
+
 		err = clk_prepare_enable(pltfm_host->clk);
 		if (err)
-			goto free_pltfm;
+			return err;
 
 		priv->bus_clk = devm_clk_get(dev, "bus");
 		if (!IS_ERR(priv->bus_clk))
@@ -1467,8 +1466,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
-free_pltfm:
-	sdhci_pltfm_free(pdev);
 	return err;
 }
 
@@ -1500,7 +1497,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

