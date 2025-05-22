Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A47E35893
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897234; cv=none; b=UzxDc89GAlfYPjJFna8IS63esBTgz3opoxrnbPlNLDNlPG4BuGQ7PTEeUKFkBvgwmy3xVj5COiHbN53A9Qj8IUynq8CYH87gF4JeKP2MXyrdB9yraZIQxrrH0mXbjEXeTkg1kVCtqdEvB6mjrpGUivMTcBjjuPHbq7WKigyTqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897234; c=relaxed/simple;
	bh=hM64ScQOZwP72iRGt+b5BQWbminI9wXNMc+JzQoSOos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECDOyfC89bOZhZS9smIEs6i0TzVG9D1ipYa2rrKrqJPMnSyGwJJJW8l9trLb40S9JDylNAa7lz5N93qC9O5YXTZQA8Gm1zMljXOhLcwYTN0smwna8ocblZpz5q0ysrpeH2D+FrcHy/PxDSwSUrvU9VdFV4S/nS5xc015rqhT4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxjmuPyy5ofSL2AA--.3656S3;
	Thu, 22 May 2025 15:00:31 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMSOyy5oQ3LnAA--.4626S2;
	Thu, 22 May 2025 15:00:30 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 18/36] mmc: omap_hsmmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:21 +0800
Message-ID: <21ef0c9eb527c17b0892af03ee010bca38207ad2.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMSOyy5oQ3LnAA--.4626S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4fGF1rtFyfuF17Zw17CFX_yoW8Cr47pF
	n3Xa47KrWUXr45urWDJa1DZFy5Wr4xtaykKFW8C3s7Ww15Ar4kKw1kCFyFvFZ5AFykCF1f
	XF48tr48CF15JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/omap_hsmmc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 59e36e0ebbbf..688a8ec81924 100644
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
@@ -1840,9 +1838,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
-		ret = PTR_ERR(host->fclk);
 		host->fclk = NULL;
-		goto err1;
+		return PTR_ERR(host->fclk);
 	}
 
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
@@ -1973,9 +1970,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	clk_disable_unprepare(host->dbclk);
-err1:
-	mmc_free_host(mmc);
-err:
 	return ret;
 }
 
@@ -1995,8 +1989,6 @@ static void omap_hsmmc_remove(struct platform_device *pdev)
 	pm_runtime_disable(host->dev);
 	device_init_wakeup(&pdev->dev, false);
 	clk_disable_unprepare(host->dbclk);
-
-	mmc_free_host(host->mmc);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

