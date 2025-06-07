Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA01EA7CC
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281728; cv=none; b=Us/66D5lPKOlEoXoj0dDoIw/TxVZrdUFpjatXJDTHBs4YQzFIl90ieh0tpRWsrqrfTztVCwdfczJsreS+cExgQzTfysLkhp89UQPnFkutvsFOaA/KtxDNnloFmKXRSAEx4yAml05yrDdyoe1d7kJVBNyhJsh4appqU/vfXbnjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281728; c=relaxed/simple;
	bh=5d11tTRtQO2mRDQJaugb4Voeu8E174QjBaSNlBtyFpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feZOvouPIgNnWKI7cXUIgxp6/A+wvJwEK8oQLs+GxzJl6wov6EWeF7N78h6exLKbaAX1OwZMscPfWAZ1uxWhNNQSgI5VnXutxYvMEXjmqGPJ5TsPKvVZyWVnDw1wRKg+RgDyka5x8lI41sPQpevLOvQJ+FH4CP1/27JhDE0ZC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Axz3O860NomRUPAQ--.40271S3;
	Sat, 07 Jun 2025 15:35:24 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3xu460Noj50OAQ--.58136S3;
	Sat, 07 Jun 2025 15:35:23 +0800 (CST)
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
Subject: [PATCH v3 03/35] mmc: sdhci-milbeaut: Drop the use of sdhci_free_host()
Date: Sat,  7 Jun 2025 15:35:07 +0800
Message-ID: <6d6ac2f5eb1962b96d63de70e6f52ad8fc785974.1749127796.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749127796.git.zhoubinbin@loongson.cn>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3xu460Noj50OAQ--.58136S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1DWr1kGFW7AF13Cw4DGFX_yoW8Zw4Dpa
	1rXFyFyrWUuF4rtF93Jw4UZ3W5A3yxKay8Ka4rWw4kJa1ayryDtrnakFy8Z3WrJryktw43
	WF4UtF48uFWkZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0wqXPUUUUU==

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

