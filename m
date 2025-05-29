Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428FE1E521
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523536; cv=none; b=EdisSQs4qA6rGE2OuBVuBmVlKM1DmHGZ8w+76K1x+jutljcQdR/kS+P0pHtyO6QIXOLUC4GW995B8kwokvaLyhNUDf0jp7uzwRT5yDF1kcTapQ954G/Fa7RdAA0PvcVunD9/CCwm3Wigbc5bsYrawSEjbyPdIkEMhU6aAhXJa4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523536; c=relaxed/simple;
	bh=KYGXxpSi9PfoZaHWreTYDSznlMU9tjDg6fBQe1fnVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BD/LuWcnm0MpNjV9V/s2F6sZvGYI73nmwacpd6V5JYU9guGqytr0NG9rJjQ6bskMOSIc6d8NLl/10lFMinir9L7etX2gGfSp0AadH7ZAP/OI2rlNN32nHxhixejTqqXydkMm5PitLirdDqPck4Arvj0c/l9DEVgkKJQlZdfMrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx32sNWjhopCoCAQ--.22177S3;
	Thu, 29 May 2025 20:58:53 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxPcUJWjho5bL6AA--.55364S2;
	Thu, 29 May 2025 20:58:53 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 06/35] mmc: sdhci-spear: Drop the use of sdhci_free_host()
Date: Thu, 29 May 2025 20:58:41 +0800
Message-ID: <bd89c99938a0bd5dbd84c5f9d962a7b2ae0c95fb.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxPcUJWjho5bL6AA--.55364S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kZF1UZF4fJFyxtFyktFc_yoW8Cry5pa
	93XFZ3KrWfWF4rKrZ8Jw1DZ3WYyr40qayIga4fGwn7J3y5tryDtrn3CFy0qFyrJF95J3yf
	WF1vqry8CF9rXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bOq2NUUUUU=

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

