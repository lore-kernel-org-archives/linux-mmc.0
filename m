Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E312248B9
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523514; cv=none; b=p8LyKxRxs0hSZBDzwz3OXWjiwWiH6YhUPAJxmNzDrL1ljCrOA7mhE0+ielue0TtXB1bWWCh1Poj5SF/NEzvd41oSnt1ZbY42ISlgpKDR04V+jy0bjAOoTf7h8xtLNsKUdX1A4MHCCqlSk97pgSne6GGsd96TNDnYhJRiTs62xU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523514; c=relaxed/simple;
	bh=5d11tTRtQO2mRDQJaugb4Voeu8E174QjBaSNlBtyFpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMJ6uRIvenQ0j6TDub5o2QnxTB0rikfI8SW+DDQGCjmDeoT6W3EVK37llMQACPLtNNp5N0ilsg9MveXwF4FZ91Zk47wmQgP3ZUupWMpQs7HabMUhEDFCkJDI2GB+4ztjH8hALpzCKE7i7UHh1wTX3zIkbmB7UHmNB7Tlapm4y8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxbWv3WThoVyoCAQ--.21872S3;
	Thu, 29 May 2025 20:58:31 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMTyWThonbL6AA--.57145S3;
	Thu, 29 May 2025 20:58:29 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>
Subject: [PATCH v2 03/35] mmc: sdhci-milbeaut: Drop the use of sdhci_free_host()
Date: Thu, 29 May 2025 20:58:16 +0800
Message-ID: <2bc20782d2c04586fdf83d15f6791622ac928fb6.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMTyWThonbL6AA--.57145S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1DWr1kGFW7AF13Cw4DGFX_yoW8Zw4Dpa
	1rXFyFyrWUuF4rtF93Jw4UZ3W5A3yxKay8Ka4rWw4kJa1ayryDtrnakFy8Z3WrJryktw43
	WF4UtF48uFWkZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0Ta0PUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_free_host() is no longer needed.

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

