Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432727BF7D
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741635; cv=none; b=TSgK2kjp/QUljnTnDAL3K3y7HW6o5wab9PJ0m0QlLEHlelMDypwM09oAmrd55lXiovMVh0VkwyptWiw5q58AThaRe0555z4jrYrw3b98yNJ5cOnYb3Su6vnR0JCgKGNRVBuQNNuG5/2Y11Fu02WEiP5mgVgt1vkzVOlelb+U1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741635; c=relaxed/simple;
	bh=TdSTXce6Dg6CUiCRyM2sjU2NoAu1GPlmmiwiRZVWZDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2cQ7T2RlnP5V5uFtYpPsoJ7/IWZxKKc/mqOK146uMGigSum6l0lTdcCF/HImOIPtr0BdtM6iIKLq5kaybpGdtCYxfwaOMWH79p9TcNXHKsupJvo79Uy7Bo1hgFgh7mz02IJzLJWMxyvjqIWkhIiTe6XE5cU/6R2Vilv0Z11vGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxYa_AayxoRV7zAA--.25596S3;
	Tue, 20 May 2025 19:47:12 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxXsW8ayxo3zvjAA--.57954S4;
	Tue, 20 May 2025 19:47:12 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Alexey Charkov <alchark@gmail.com>
Subject: [PATCH 32/36] mmc: wmt-sdmmc: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:46:59 +0800
Message-ID: <67c3e1fa54a40ae118214791df1cc9c5de0a9df0.1747739323.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747739323.git.zhoubinbin@loongson.cn>
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxXsW8ayxo3zvjAA--.57954S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AryDWw1UCFW3ArWrZr4DKFX_yoW8XryDpa
	9YvFy5KrWktr4Yg34DGw42v3W8JF1Igay0ya45Kw1kX34ayryqqFn5ZFy5tFn5AFWvkF4S
	gFyDAFW8uF4DWFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	nUUI43ZEXa7IUYTbyJUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Alexey Charkov <alchark@gmail.com>
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

