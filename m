Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B111DC997
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525094; cv=none; b=J7w8Dnxx6msn6sNDteED+k7EYAUhkjOJSiHjxz/W1xJdFm6kvtPIocb2iP1NL/UvxoyiiIuIjKD8YttKTDuTHSrbKR/lqvIftgKEJPmK2mOuGriPJNg+2wQy+vfH06QQ7Oi4ZqKj7WZufxAJvVVKKyiMy6HVsfO5TGiGHNwQ4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525094; c=relaxed/simple;
	bh=xg2Uj8Gg93L/Tsv+nPGnEJnbujU7aivdQdbKQMqZ+vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PajwRgWO1RmfnqGmiW42hpWrUsfJRncZ5qIBuXVLrliyVy8o+RDqPtk5R7qMo/Bst8ufeJSu0Mzl4InO2jAsHcXYnNo/iBh0pCfSJfTHn7Gh0cqGEBvlPIXzdr3fT39zARl4G/A+73S5FRGK7t2MmWn7HOq/3hKva2Ht7uzjT/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxDGsjYDhowTYCAQ--.21727S3;
	Thu, 29 May 2025 21:24:51 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+UfYDhot8H6AA--.56111S2;
	Thu, 29 May 2025 21:24:50 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Hu Ziji <huziji@marvell.com>
Subject: [PATCH v2 32/35] mmc: sdhci-xenon: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:24:38 +0800
Message-ID: <b79920fa8bff8f7cf2f407863846446344d2eab7.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+UfYDhot8H6AA--.56111S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4rGFy7tw4kAF13KF1ruFX_yoW8Xw48pa
	9ayFy5Ka17WFWUKas0qw4DZF15ta12gay8Kry5Gw1kG3yakrW5trs3AFW8ZF4rAFy8Kw4f
	Wa4DtF48uas8CabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8
	Xw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUgBOJUUUUU

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

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

