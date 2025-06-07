Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7361EA7CC
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281759; cv=none; b=DkpZiios4lXzVSoyHue4huYT4ZgN9qWE27kq9gWOZAsXfB6JdrzrIaUTAi85PHZK7z3qfLZ1jpFgRy4qdj55iIhRfqrJZgKpu/XnzbtBhDWpDKr18JGexPlqFisOQMgVXgc7EYG88bwGxPoRNH+7uWou/P7wZo3spHngRbwd9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281759; c=relaxed/simple;
	bh=KYGXxpSi9PfoZaHWreTYDSznlMU9tjDg6fBQe1fnVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itc26Q/lXqFWIHQbcHs8yH+VsFPGPHT0lQiY12xzHyUc55/JZat6laU3cgWbKcoBG3FjxzqEH809kFvhoky8WM24zdLfx3N3GpD4nRX1pdDxxU/2p/Jh0n081HeL4+BGlNxPeTuEx/Ve3B6DXuaZND0sFGOxsrCnSw3uHp0qlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxDGvc60NoxBUPAQ--.40668S3;
	Sat, 07 Jun 2025 15:35:56 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxPsfa60NouZ0OAQ--.49038S2;
	Sat, 07 Jun 2025 15:35:55 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 06/35] mmc: sdhci-spear: Drop the use of sdhci_free_host()
Date: Sat,  7 Jun 2025 15:35:42 +0800
Message-ID: <fde959d1021c165ede971644f3db7e06ce7c6180.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxPsfa60NouZ0OAQ--.49038S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kZF1UZF4fJFyxtFyktFc_yoW8Cry5pa
	93XFZ3KrWfWF4rKrZ8Jw1DZ3WYyr40qayIga4fGwn7J3y5tryDtrn3CFy0qFyrJF95J3yf
	WF1vqry8CF9rXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU0rhLUUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_free_host() is no longer needed.

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

