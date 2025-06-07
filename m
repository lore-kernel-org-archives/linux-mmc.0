Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561C1E2853
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281909; cv=none; b=SdIwJQkjJ0lbEkajrXnhANe9xTEiIp2BVhME+sSpCbFsyb4n/euD+crcOfaKN6+tmDeN5+0VHg+u4u0s55FWHNoVPPjZOWZadL2zwVDqeHTkF5OKPXVoSRLCl6b6F5Ugr/IjlU3AjjWZ6lI9nuAhQNwcR9lu01kUgumwUis1J1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281909; c=relaxed/simple;
	bh=sTZ7euDHZbEeUzWLYTUUQjG+30sEjqq5Jlf6I031IRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0m2TSI2ilVYcRu9Rmfvj+0rRRCJvh9oax3E2V1HZ6ozvjZV6AP3XxFSZxOwUyuPFOSfVdl+ub5MU7DTafYxrdl5W2BfOhml4J1KukZj/BZN98I/dQxxlxlxfQzq1yejoC1f5gqA81KtfsMsKeZoEXJqYX+iQt/rWEMje1pl6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxYa9y7ENolxYPAQ--.665S3;
	Sat, 07 Jun 2025 15:38:26 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxbsVu7ENowZ4OAQ--.49969S2;
	Sat, 07 Jun 2025 15:38:24 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v3 18/35] mmc: sdhci-of-aspeed: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:38:12 +0800
Message-ID: <117c13ffd2d67a4c7cad980634591c4851f560b5.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxbsVu7ENowZ4OAQ--.49969S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4Dtw13WF4kZry5tr1UArc_yoW8Xw4fpa
	9xJrWrKr47GFWrKrZ8J3Wqv3WUJw4a9ayxKrWUGw1kW3y3KFyYqFsrCFW8tFs5XFy0gw45
	XF17Jr48Ca98AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
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

Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: linux-aspeed@lists.ozlabs.org
Cc: openbmc@lists.ozlabs.org
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index d6de010551b9..ca97b01996b1 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -425,10 +425,8 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		return PTR_ERR(pltfm_host->clk);
 
 	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable SDIO clock\n");
-		goto err_pltfm_free;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Unable to enable SDIO clock\n");
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
@@ -445,8 +443,6 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 
 err_sdhci_add:
 	clk_disable_unprepare(pltfm_host->clk);
-err_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -461,8 +457,6 @@ static void aspeed_sdhci_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, 0);
 
 	clk_disable_unprepare(pltfm_host->clk);
-
-	sdhci_pltfm_free(pdev);
 }
 
 static const struct aspeed_sdhci_pdata ast2400_sdhci_pdata = {
-- 
2.47.1

