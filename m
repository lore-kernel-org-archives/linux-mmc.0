Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541819DF6A
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239550; cv=none; b=MV7VZK+z6UVAbSllVtpUvCvf9LoZ/IfjZG4FYqTD2dt1yvkc/bOHxA9HD5Gv/0+9oS5hir8OCb5dlkwJkkjsr64k1y3qbLvZwTle37K8wbYQs5maDuXMZeMXXwzQCT2jHoruUGHCLnMkPMvIk/XoMrX30Hp9ZPP5mNX6haz4hfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239550; c=relaxed/simple;
	bh=qB1XSwb1Lqs4IsbZe4N/B9iDE2TCaWSuBi/Hp8S85n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+kQpLSetFR/lw9mRyKwksLjqVyq90WVQK1WnVBpt/u4r5V6VshmYcCPd20i94R9IaXn8F8PcpNbGkgVYWlZ7ne2wt0poUqX7/2YIShOeBjAByy/Pz18DvdB9LZh7/O3SBj869noCawLwj3c5hnki2pMosCCvmAaVHY91aTODLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx3666BDRoI4X8AA--.61344S3;
	Mon, 26 May 2025 14:05:46 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxb8e1BDRo2APyAA--.30366S5;
	Mon, 26 May 2025 14:05:45 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>
Subject: [PATCH 03/34] mmc: sdhci-milbeaut: Drop the use of sdhci_free_host()
Date: Mon, 26 May 2025 14:05:32 +0800
Message-ID: <2e29a64aa3471f1dd80d7bc4e561847519c56c63.1747792905.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747792905.git.zhoubinbin@loongson.cn>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxb8e1BDRo2APyAA--.30366S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1DWr1kGFW7AF13Cw4DGFX_yoW8Zw4Dpa
	1rXFyFyrWUuF4rtF93Jw4UZ3W5A3yxKay8Ka4rWw4kJa1ayryDtrnakFy8Z3WrJryktw43
	WF4UtF48uFWkZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_free_host() is no longer needed.

Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
Cc: Takao Orito <orito.takao@socionext.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-milbeaut.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index a4675456f9c7..bda71d5966dc 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -258,7 +258,7 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto err;
+		return ret;
 
 	platform_set_drvdata(pdev, host);
 
@@ -267,23 +267,19 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 	host->irq = irq;
 
 	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host->ioaddr)) {
-		ret = PTR_ERR(host->ioaddr);
-		goto err;
-	}
+	if (IS_ERR(host->ioaddr))
+		return PTR_ERR(host->ioaddr);
 
 	if (dev_of_node(dev)) {
 		sdhci_get_of_property(pdev);
 
 		priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
-		if (IS_ERR(priv->clk_iface)) {
-			ret = PTR_ERR(priv->clk_iface);
-			goto err;
-		}
+		if (IS_ERR(priv->clk_iface))
+			return PTR_ERR(priv->clk_iface);
 
 		ret = clk_prepare_enable(priv->clk_iface);
 		if (ret)
-			goto err;
+			return ret;
 
 		priv->clk = devm_clk_get(&pdev->dev, "core");
 		if (IS_ERR(priv->clk)) {
@@ -308,8 +304,6 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk);
 err_clk:
 	clk_disable_unprepare(priv->clk_iface);
-err:
-	sdhci_free_host(host);
 	return ret;
 }
 
@@ -324,7 +318,6 @@ static void sdhci_milbeaut_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_iface);
 	clk_disable_unprepare(priv->clk);
 
-	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
 }
 
-- 
2.47.1

