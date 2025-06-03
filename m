Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE91CA81
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953641; cv=none; b=jiJTv49bWdXDcaBjdSDDNnFxDZ8469E/hkOGJUH0MOZ2AcnEuQRGc67+l+cDDLq0Yl638Ym5wSj592y8UUVIz3LaoF3in6CoQStBtrkEwSifTqWhvTGE0fIXykqyUM3X9hS3sIzYOZ3MUAsK39A8raSNFi+4DNAIG+ge8adSnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953641; c=relaxed/simple;
	bh=WxlO2pVXiTqfK4hzuvIwyeruHpBGUnV06gqeYyKdvEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJuB0WsxvZFK1PdNG4w/FElHs82A5c3RQMVz2FzspJfJQq4dlu0zvK04nRD4xmMj+HqY0NHY0sppzMfRdF4bx1zj4gEZfR/1kHjDYq6utSmGPux0PhiShHzpEURoQUgidP164b/e58E9Wb5AObfIdM0BTUbQ0Psx1eWVFtNX4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxlnAm6j5oMjYKAQ--.32674S3;
	Tue, 03 Jun 2025 20:27:18 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3xsk6j5opQ4HAQ--.36860S2;
	Tue, 03 Jun 2025 20:27:18 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 18/36] mmc: omap_hsmmc: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:27:05 +0800
Message-ID: <bd5dd68556d8530295bb61dc44ac68b619130d1f.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBx3xsk6j5opQ4HAQ--.36860S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFW3GF4xJr13XrWDtFy3KFX_yoW8AF47pF
	n3Xa47Kr4UXr4Y93yDJa1DZFy5Wr4xta97KFW8C34kWw15Ar4kKr1kCFyFvF95AFWkCF1S
	qF40qr48CFn8JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8RVbDUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/omap_hsmmc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 59e36e0ebbbf..bf3b9f5b067c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1798,15 +1798,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	mmc = mmc_alloc_host(sizeof(struct omap_hsmmc_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
+	if (!mmc)
+		return -ENOMEM;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto err1;
+		return ret;
 
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1842,7 +1840,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
 		host->fclk = NULL;
-		goto err1;
+		return ret;
 	}
 
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
@@ -1973,9 +1971,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	clk_disable_unprepare(host->dbclk);
-err1:
-	mmc_free_host(mmc);
-err:
 	return ret;
 }
 
@@ -1995,8 +1990,6 @@ static void omap_hsmmc_remove(struct platform_device *pdev)
 	pm_runtime_disable(host->dev);
 	device_init_wakeup(&pdev->dev, false);
 	clk_disable_unprepare(host->dbclk);
-
-	mmc_free_host(host->mmc);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

