Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A360F22F767
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953706; cv=none; b=lpALS8TM1e2RRs/xDf99juWgO7Mx9ujeQchvo34G0iRYlsZ8pGnFYdlBHMCNDP84ncMJdexT/OAs2l6XIDgf+fxvfR+/M4ru9fzW0YpNHdZwDR4Pg9bo+/ltR8LJ9avkN6YcIKFBTnzNdK6sbftDAO6igXdi2sYxQ5Ur0VjLuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953706; c=relaxed/simple;
	bh=BGNTMOol2QieUGfKTuOqJDRlULfX3tgREw4wcwAYPxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCOnjw3Li7fZY/GeSdUPRlw3dFY/x0onLYMFEn9gppAXhjK+eyu1Z+zkN5XkmzZd9ICnv4yxu4hx/HB25Y/uj0eoc1RvU158kchUkT1nxEtgAP7/rHdnXHNYNJRPwiMgrdDTVfGspaOAfSzEMR4bXgCcCPfwY0wSdZ2WWf2u9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxvnNj6j5o2TYKAQ--.201S3;
	Tue, 03 Jun 2025 20:28:19 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3xte6j5oVA8HAQ--.36867S4;
	Tue, 03 Jun 2025 20:28:18 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v3 32/36] mmc: wmt-sdmmc: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:28:04 +0800
Message-ID: <81a288603ffc77b39678ef9f5bea7284670e6b60.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3xte6j5oVA8HAQ--.36867S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWxur1kXrW8tF1rtr1fuFX_yoW8Wr4xpa
	9a9Fy5KrWktr4Yg34DWw4293W8XF1IgayIyay5K3ykZ34ayryqqFn3ZFyYqFn5AFWvkF4S
	gFyDAFW8uF4DWFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8Xw0E3s1lYx0Ex4A2jsIE
	14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y40E4I
	xF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IUYfsqJUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Alexey Charkov <alchark@gmail.com>
Acked-by: Alexey Charkov <alchark@gmail.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/wmt-sdmmc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index cdb36a9f9e38..0d2929cfe397 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -774,7 +774,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 		goto fail1;
 	}
 
-	mmc = mmc_alloc_host(sizeof(struct wmt_mci_priv), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*priv));
 	if (!mmc) {
 		dev_err(&pdev->dev, "Failed to allocate mmc_host\n");
 		ret = -ENOMEM;
@@ -808,7 +808,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	if (!priv->sdmmc_base) {
 		dev_err(&pdev->dev, "Failed to map IO space\n");
 		ret = -ENOMEM;
-		goto fail2;
+		goto fail1;
 	}
 
 	priv->irq_regular = regular_irq;
@@ -873,8 +873,6 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	free_irq(regular_irq, priv);
 fail3:
 	iounmap(priv->sdmmc_base);
-fail2:
-	mmc_free_host(mmc);
 fail1:
 	return ret;
 }
@@ -910,8 +908,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	mmc_free_host(mmc);
-
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
 }
 
-- 
2.47.1

