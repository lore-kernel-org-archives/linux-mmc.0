Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3713AA2E
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897257; cv=none; b=kn76dy+ZCofvb8X5gL39iSi/+XQSP/eGk/vYuJ4abbM+rjlKyd9Y69lfu1Ddfp8JedLAilO8UOFo+DauEbH9pbpC52ChAoGCmcwoYRL4RCWGLzBcBsqV+EvI9s7kQHr3rd7ctaCxT8g2BgsA1TaFVm0Fguwi8CG7rQAL5rVbvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897257; c=relaxed/simple;
	bh=3mRy6EzDPR7LKdkVAvxAL5Ux1obAvfbhfatdi7rFosg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrEQAiTWcZcjH7JWuSSmamUYHDSBtbjcmJPDDXzoN0ovbT98b5Qbg8KNksGZQTIWUhAMYxCTj5D6JTJM+EcV8fmcBf25xwJUkclWunbJlj/uBl4xTupt7uen59N4yfj4fCMpGO6Ss7mmKVL9YbDGG04DzPYnZY31+/L0YUHYoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Ax3eKmyy5owSL2AA--.31608S3;
	Thu, 22 May 2025 15:00:54 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx_calyy5oZ3LnAA--.8457S2;
	Thu, 22 May 2025 15:00:54 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 24/36] mmc: sh_mmicf: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:42 +0800
Message-ID: <514a1547eeb631aea6e9c9261af3831a2e78fb12.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx_calyy5oZ3LnAA--.8457S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4kWFW8AF45ZF48XF4kKrX_yoW8Cw1DpF
	s3ZFyxtFWUXa1ag34DJw4UZFyrAr1xtayxW3yxW34kZ3s8tr1DtFn5CFyFqF4FyFWkJF1a
	gF4DWFW8CF15XFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y40E4I
	xF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU5gFxUUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/sh_mmcif.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index ce60cec26b98..19f84584ecfa 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1444,13 +1444,13 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-	mmc = mmc_alloc_host(sizeof(struct sh_mmcif_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
-		goto err_host;
+		return ret;
 
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1481,15 +1481,13 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	host->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(host->clk)) {
-		ret = PTR_ERR(host->clk);
-		dev_err(dev, "cannot get clock: %d\n", ret);
-		goto err_host;
-	}
+	if (IS_ERR(host->clk))
+		return dev_err_probe(dev, PTR_ERR(host->clk),
+				     "cannot get clock\n");
 
 	ret = clk_prepare_enable(host->clk);
 	if (ret < 0)
-		goto err_host;
+		return ret;
 
 	sh_mmcif_clk_setup(host);
 
@@ -1542,8 +1540,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	clk_disable_unprepare(host->clk);
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-err_host:
-	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -1568,7 +1564,6 @@ static void sh_mmcif_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&host->timeout_work);
 
 	clk_disable_unprepare(host->clk);
-	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.47.1

