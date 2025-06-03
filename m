Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4322A4E1
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953539; cv=none; b=SICT6eQQ3TOrimBPW2yD2O1Mvm3cuPvJSD3bw98GGF8xZoM382KqmAKqdfBSnX+P5aDyKZZbZ3ET08+BW+iYpZLLiiMpXUaQAHoADuHniGE3eJ0URf8eimiNLUF1D9ccPFEKbltJR72wGy7T4L0Rm4U4J3/78L/rsAHCFQ0VSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953539; c=relaxed/simple;
	bh=MFmz0+gO4fbiFb9Ataj4h3ZnFpoSC+tSG9qq59oeNOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X51bOAh7J4jD42kVOx0RFL3mSjssnYkjB2zYMObrWOzHH65at6pD0nTJN8sM3rLvnK3SiOXXsCBOREXKNdPzjllaUdgMFeDgYcI6wC6G9tn49wKQPNTR9RyWuq5KRdbylf2FTOxdYvnHc+RZCMLQQEaEmTE8qjmWKL1hstedhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxIK_A6T5oPjUKAQ--.30787S3;
	Tue, 03 Jun 2025 20:25:36 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcW36T5ovA0HAQ--.22246S5;
	Tue, 03 Jun 2025 20:25:35 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v3 03/36] mmc: au1xmmc: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:25:15 +0800
Message-ID: <7da94643484f7184be40fa517a8a74ce3cdefe19.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxLcW36T5ovA0HAQ--.22246S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1DZr1DtFyxGw47Jr4rXrc_yoW8Aw1DpF
	yfJa43K3yDtF45WrWUJ3srua1rZr1xt3y8G3y8Awsaqa45tr4Dtrn5CFy09FyFyFyvkF43
	WFW8Jr18CFsrXFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Manuel Lauss <manuel.lauss@gmail.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/au1xmmc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 057d42307832..85470773650d 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -937,11 +937,10 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret, iflag;
 
-	mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc) {
 		dev_err(&pdev->dev, "no memory for mmc_host\n");
-		ret = -ENOMEM;
-		goto out0;
+		return -ENOMEM;
 	}
 
 	host = mmc_priv(mmc);
@@ -953,14 +952,14 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&pdev->dev, "no mmio defined\n");
-		goto out1;
+		return ret;
 	}
 
 	host->ioarea = request_mem_region(r->start, resource_size(r),
 					   pdev->name);
 	if (!host->ioarea) {
 		dev_err(&pdev->dev, "mmio already in use\n");
-		goto out1;
+		return ret;
 	}
 
 	host->iobase = ioremap(r->start, 0x3c);
@@ -1109,9 +1108,6 @@ static int au1xmmc_probe(struct platform_device *pdev)
 out2:
 	release_resource(host->ioarea);
 	kfree(host->ioarea);
-out1:
-	mmc_free_host(mmc);
-out0:
 	return ret;
 }
 
@@ -1151,8 +1147,6 @@ static void au1xmmc_remove(struct platform_device *pdev)
 		iounmap((void *)host->iobase);
 		release_resource(host->ioarea);
 		kfree(host->ioarea);
-
-		mmc_free_host(host->mmc);
 	}
 }
 
-- 
2.47.1

