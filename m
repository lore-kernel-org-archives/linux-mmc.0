Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73117BA5
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525215; cv=none; b=qkBx/fKbzXxJF0D3cglPHu/M2xOdU4iMkGLuxDsb3FqsvXcifOTljg+tJiTdDikyNS/0wUWHWNwxgacWLHlTYADa+Pdc9RdqdOkXrim4knVvD/Lt4tsmFz6f1jq5zMca8RRru4LspyASTkb1MsvIwbaHlwmdVfSGOF+ok3Awcmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525215; c=relaxed/simple;
	bh=rVF3aQGH+Yn8v6IciWZUi4ekpjWBlpKtAqmWaKH/Ads=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxuDonWMb2z1wFxeyQdkyx9BT+qmbTIB87KzT9Bz4/gP+q9VBOfKJVJuwHnJe2nUN/2C3kSHPeDSLlvKhmsHUR9CC9Cd2eoVt6D4T5pmYL/Jlhr4Ynf6aV2nPU1Wr8+VsZHaL/auiUvjsO4PzO6FkngWrEuqZdyRBbc2DF2VAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxDGuaYDhorDcCAQ--.21735S3;
	Thu, 29 May 2025 21:26:51 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx_caYYDhovcL6AA--.61312S2;
	Thu, 29 May 2025 21:26:50 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 34/35] mmc: sdhci_f_sdh30: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:26:40 +0800
Message-ID: <67f1605538ad3e0994cbac5297178032da39290b.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx_caYYDhovcL6AA--.61312S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF43AFWrJrW8Xw15tr18Zwc_yoW8Gr48pa
	n5JrWvyr48ur4FkF98Aw1DZa1Ykw4xKayxKa45K395Ja1Yk3s2yrnayFy0qF15Aryrtr4f
	Wr4UJa18CFWDuwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
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
 drivers/mmc/host/sdhci_f_sdh30.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index ee66e4f3683d..e9b934e159ad 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -133,20 +133,18 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (dev_of_node(dev)) {
 		sdhci_get_of_property(pdev);
 
 		priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
-		if (IS_ERR(priv->clk_iface)) {
-			ret = PTR_ERR(priv->clk_iface);
-			goto err;
-		}
+		if (IS_ERR(priv->clk_iface))
+			return PTR_ERR(priv->clk_iface);
 
 		ret = clk_prepare_enable(priv->clk_iface);
 		if (ret)
-			goto err;
+			return ret;
 
 		priv->clk = devm_clk_get(&pdev->dev, "core");
 		if (IS_ERR(priv->clk)) {
@@ -200,9 +198,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk);
 err_clk:
 	clk_disable_unprepare(priv->clk_iface);
-err:
-	sdhci_pltfm_free(pdev);
-
 	return ret;
 }
 
-- 
2.47.1

