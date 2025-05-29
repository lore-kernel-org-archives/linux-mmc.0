Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F39221DA6
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524840; cv=none; b=crDjKxj399Np946Sn4rAODMyVPirNCT4ccJYrjieBP4CfTF2SyjiJrQ5e99HbzvgaD/tVTIvEFNgJDfB2qJq1UxeObgC9NQVxKhSShNArm+kdeGQ5m9pazwJMbbxdBuYo8DkFt9vQ2It4PnPyXfjqWrMuAoavZ2D3HO5sBDNoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524840; c=relaxed/simple;
	bh=aEo09SDN7IKz2C7iPCLvloc9yqfG67JoznHm8tjlwMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlXwrK+S6JbTap5Phph3XgePEEYsjkJ8gg+D6ncFLkfmjnmj74vvgVte7oBDCWTfML6Xpnpjpa8xJ+oVrcyfxA0osnl/il+9sDRnfUPv2IsYPZtSaRQA92XAIrk+yyV5BDMgML0jUFHlkJBA26Zb1q4XjNNmrwL8CgvyRY1gpMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxIK8jXzhoKDUCAQ--.19863S3;
	Thu, 29 May 2025 21:20:35 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxj8UfXzhonL_6AA--.58252S2;
	Thu, 29 May 2025 21:20:34 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 28/35] mmc: sdhci-pxav3: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 21:20:23 +0800
Message-ID: <4721a08735fe58d2bda536a7b63539a87b91d212.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxj8UfXzhonL_6AA--.58252S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1rGr17XFykJryDKrW7GFX_yoW8Gr1rpa
	18GryvkrZrWrWrKas8JwnF9FyUKF12gayFgFW5Gwn7GFWakryktF4fAFy0qFy5XrW8Gws3
	Xr10qr48CFyUu3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5HSoJUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pxav3.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3fb56face3d8..7173a0296738 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -389,8 +389,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		pxa->clk_io = devm_clk_get(dev, NULL);
 	if (IS_ERR(pxa->clk_io)) {
 		dev_err(dev, "failed to get io clock\n");
-		ret = PTR_ERR(pxa->clk_io);
-		goto err_clk_get;
+		return PTR_ERR(pxa->clk_io);
 	}
 	pltfm_host->clk = pxa->clk_io;
 	clk_prepare_enable(pxa->clk_io);
@@ -466,8 +465,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 err_mbus_win:
 	clk_disable_unprepare(pxa->clk_io);
 	clk_disable_unprepare(pxa->clk_core);
-err_clk_get:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
@@ -485,8 +482,6 @@ static void sdhci_pxav3_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pxa->clk_io);
 	clk_disable_unprepare(pxa->clk_core);
-
-	sdhci_pltfm_free(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

