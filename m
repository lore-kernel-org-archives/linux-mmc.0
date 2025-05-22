Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9EE320F
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897215; cv=none; b=MabOD7WaNBl4XojIKUryiDtPMFstoInWGA+FqfgZjM1bWRBnzwqJIcYn+GLayCh3695FJVuOdlIOcGNbcB9w9eN9OJt9hBDgqCW0qLsCJKWucGtmUuNFECvRqNH6xSB6XpbZE6kCVvnUXwhvv0wiGTUKmQO11J2H5/kseVPko20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897215; c=relaxed/simple;
	bh=8JjXbdhWXXey8dRyHJjhy2QzFRbhrOfO29R2qy9gLmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa42VpChWxWLUdyW8GIXIug8Aw1idmGPUGaGhS/dbppMXvfR1W9fZckfhil9fIn1U+pxzCg5LB1p9myHu8DY5Gj/0O2kJkKLxpxHPDy7gosLfGkkvSmdxLzgCZrHHj2JKCcXyXyuYtMHJqLDbFXQ63AZNg8dLVPoSkO3/lfkroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxnnN5yy5oRiL2AA--.34913S3;
	Thu, 22 May 2025 15:00:09 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcV1yy5oEnLnAA--.499S3;
	Thu, 22 May 2025 15:00:08 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org
Subject: [PATCH v2 11/36] mmc: meson-mx-sdhc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 14:59:52 +0800
Message-ID: <ee53a3dbe497a11dc390f82cb404724a06aa6519.1747877176.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747877175.git.zhoubinbin@loongson.cn>
References: <cover.1747877175.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxLcV1yy5oEnLnAA--.499S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw13Zr43KF1xAF17WFyDArc_yoW8WF13pF
	ZxCFy7KF4UJF1fW3yDtayqkFyrWw47KayxtrW7Ww1kua4YkrWDtF9IkFW0vFyrGFyvyF4f
	uFs8Gr1j9F43JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU022NJUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index b4e56ccffca2..fb49ea71289e 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -757,11 +757,6 @@ static void meson_mx_sdhc_init_hw(struct mmc_host *mmc)
 	regmap_write(host->regmap, MESON_SDHC_ISTA, MESON_SDHC_ISTA_ALL_IRQS);
 }
 
-static void meason_mx_mmc_free_host(void *data)
-{
-       mmc_free_host(data);
-}
-
 static int meson_mx_sdhc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -770,16 +765,10 @@ static int meson_mx_sdhc_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret, irq;
 
-	mmc = mmc_alloc_host(sizeof(*host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
-	ret = devm_add_action_or_reset(dev, meason_mx_mmc_free_host, mmc);
-	if (ret) {
-		dev_err(dev, "Failed to register mmc_free_host action\n");
-		return ret;
-	}
-
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
-- 
2.47.1

