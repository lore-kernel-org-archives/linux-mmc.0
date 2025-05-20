Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F09613635C
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741566; cv=none; b=kA9SUIjHRQ3G6ZUmxPEWTCJiKLDRAyrKHMkl4U3w3lPgJcdrH3knFpriLvktPGOjNfA5d7a338w0aScT3LP3+hgInyWoWh1ayltQT15lU+qXRYs9Ynfb5NWcPDwq+OpY9P7LL0MWQ8OnuWHBWokV/3GCG1dMZE+okLZBnZJzjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741566; c=relaxed/simple;
	bh=NnFAqEiN0hN25EaNXIwTyH16oFrNI6tR4YM+qirO5hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhswzFOb1WP/d8EZ173VKRPmJZryYuFsF622+ktDvz3sISTC9XTVW+zANghYN59vQ9vtbsKuFrhLBclKBi/7NOauT+MUJ1+woBCCHn49wQAOdFQUDCqLrM5NWu3vUo0SyVJFCja7TnSoZANGRJ6tgaCNSPHUlBblLsCzWnIcNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxDGt7ayxowl3zAA--.178S3;
	Tue, 20 May 2025 19:46:03 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+V5ayxohzvjAA--.57175S2;
	Tue, 20 May 2025 19:46:02 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 14/36] mmc: mvsdio: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:45:49 +0800
Message-ID: <774eb17d8df663f1adde6084c89a76d98dda68d4.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+V5ayxohzvjAA--.57175S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFyrtw18Cr48tFy3Ww4fXrc_yoW8ArW7pa
	s3JFy3KFW7AF4YgryDKw4UGFyY9r1xta48KrW8Ww1kJw1Ykr4qqrn3CFW0qFZ5AFykGF1a
	gF1UtFW8uFy7AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUx_-BDUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/mvsdio.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 912ffacbad88..5c738862054b 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -706,11 +706,9 @@ static int mvsd_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
+	if (!mmc)
+		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -724,11 +722,9 @@ static int mvsd_probe(struct platform_device *pdev)
 	 * fixed rate clock).
 	 */
 	host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(host->clk)) {
-		dev_err(&pdev->dev, "no clock associated\n");
-		ret = -EINVAL;
-		goto out;
-	}
+	if (IS_ERR(host->clk))
+		return dev_err_probe(&pdev->dev, -EINVAL, "no clock associated\n");
+
 	clk_prepare_enable(host->clk);
 
 	mmc->ops = &mvsd_ops;
@@ -787,12 +783,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	return 0;
 
 out:
-	if (mmc) {
-		if (!IS_ERR(host->clk))
-			clk_disable_unprepare(host->clk);
-		mmc_free_host(mmc);
-	}
-
+	clk_disable_unprepare(host->clk);
 	return ret;
 }
 
@@ -808,7 +799,6 @@ static void mvsd_remove(struct platform_device *pdev)
 
 	if (!IS_ERR(host->clk))
 		clk_disable_unprepare(host->clk);
-	mmc_free_host(mmc);
 }
 
 static const struct of_device_id mvsdio_dt_ids[] = {
-- 
2.47.1

