Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19FF145346
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239561; cv=none; b=Kb9ttPhnVNBjfBuPJC01Oe89z8n3vNoRty1wBEMw8XtaR35Akpot5g5gBaFOcb8c5GWwqQWBfC0eQ8z/YPmUXD7gQsV9OvZiinz4Q8LshSwdbEFg/2q4zQcg8T0PVT1t1D1cL/Z67F9ADevKrNalTsMUUulBLIpz6WTZoEjIEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239561; c=relaxed/simple;
	bh=kYe1bUmI+HPGg4kah3Ur3kNSMST92XotGbPqNu8pS1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEyg8RsclqmACnPaSwSfV+qKqc/tVcWympRWnEGGnajFJPqb9hw9f0o0ou9QuLQPbA2oWmlMaq05BIFn7QYfJ9AkUsr/Aj7O2aj4aJ6BeRMcZEOKR3g9VZf4dqakOr2XO+GjO53kThl2NZTk3M2tbVEEhRJtfwzN720xlFPxZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxOGrGBDRoQIX8AA--.16439S3;
	Mon, 26 May 2025 14:05:58 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx7MTCBDRo+QPyAA--.32601S4;
	Mon, 26 May 2025 14:05:57 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 06/34] mmc: sdhci-spear: Drop the use of sdhci_free_host()
Date: Mon, 26 May 2025 14:05:45 +0800
Message-ID: <bac1fbf22f67b427782bbf83c7085115130e9061.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx7MTCBDRo+QPyAA--.32601S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kZF1UZF4fJFyxtFyktFc_yoW8Cry5pa
	93XFZ3KrWfWF4rKrZ8Jw1DZ3WYyr40qayIga4fGwn7J3y5tryDtrn3CFy0qFyrJF95J3yf
	WF1vqry8CF9rXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0XAw7UUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_free_host() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-spear.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 770dc12b9ae9..fa0f8aeb7ee0 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -59,7 +59,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	if (IS_ERR(host->ioaddr)) {
 		ret = PTR_ERR(host->ioaddr);
 		dev_dbg(&pdev->dev, "unable to map iomem: %d\n", ret);
-		goto err_host;
+		goto err;
 	}
 
 	host->hw_name = "sdhci";
@@ -67,7 +67,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = host->irq;
-		goto err_host;
+		goto err;
 	}
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
 
@@ -78,13 +78,13 @@ static int sdhci_probe(struct platform_device *pdev)
 	if (IS_ERR(sdhci->clk)) {
 		ret = PTR_ERR(sdhci->clk);
 		dev_dbg(&pdev->dev, "Error getting clock\n");
-		goto err_host;
+		goto err;
 	}
 
 	ret = clk_prepare_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Error enabling clock\n");
-		goto err_host;
+		goto err;
 	}
 
 	ret = clk_set_rate(sdhci->clk, 50000000);
@@ -110,8 +110,6 @@ static int sdhci_probe(struct platform_device *pdev)
 
 disable_clk:
 	clk_disable_unprepare(sdhci->clk);
-err_host:
-	sdhci_free_host(host);
 err:
 	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
 	return ret;
@@ -130,7 +128,6 @@ static void sdhci_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 	clk_disable_unprepare(sdhci->clk);
-	sdhci_free_host(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

