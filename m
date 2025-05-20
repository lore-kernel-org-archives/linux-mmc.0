Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62392777FC
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741517; cv=none; b=I1vZMPWfzUM6d6nDcqLMI/GH1f7CgBxivPvzTJDZWF81cntduYYqMO35LITuUQFRG/M6BZSScOTXJVZ7dDu+bwDyZ0Rpz82ZQmvR/91+phXmMypyVWfdxEgn0PaI+kjakglVl+thTJLDS6UMu785gqyIniPloN+AB/Kp2/HwGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741517; c=relaxed/simple;
	bh=Qv6CWuN6a7NeOPmTVq7luqvOIoI6PPElY9l95AZ6BN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bd69ANzm+vhlqtHyLGEo7w9rGgzBxbFVswqDE3qeTR8AmVPihzrRYbD8k6MFISD10wL50/v3634Xam2s5reHXjY8hkJvT3PWCepgLxhABYXxrpnGKYYqXx8L1LIRPyvFyic/sgefr+/oj4v/0FcTnaxgWWHt/jyea/5Rvy/o4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxrnJDayxoVF3zAA--.781S3;
	Tue, 20 May 2025 19:45:07 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxPcU9ayxoEzvjAA--.56744S5;
	Tue, 20 May 2025 19:45:07 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 03/36] mmc: au1xmmc: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:44:52 +0800
Message-ID: <a95785e6abbb341687e171990769963bce69a68f.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxPcU9ayxoEzvjAA--.56744S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1DZr48Aw1xGFy5Zr4fWFX_yoW8AF15pF
	yfJa43K3yqqF45WrWUJ3srZa1rZr1xt3y8G3ykAwsaqa45trWDtFn5CFy09FyFyFyvkF4a
	gFWrJr18uFZrXFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Manuel Lauss <manuel.lauss@gmail.com>
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

