Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0661E2853
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281726; cv=none; b=Ptm35s4f99WSfa1PWitaLK+7/diLdHQ+kWDgIw44bDEPTWryfneHQdVvlhjxsQqDcN5RXtD8Ye2iO9SzJiPImZR5RE87wXmb2FpnR/O+8K18/+G6SuU04gCEw3GHIp7XlhoTHHwQXhdkcSwQysYryQjGISemsqCe1FDTrov8KX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281726; c=relaxed/simple;
	bh=EuViignEqGJ2xcmTanXp3nv41YCwmVpguTdePU2PsRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC+bfzkE27k3J3H4W3Gr1ZuR8uMhVj8TeYLig/+cKYU5fDq8xA/wtVtR0uIhI6Xpu5aFrMyyFWpPmyAL9cuAdlZ3eircylR7h9x+Ke1JD/Cs14aP0HbAHZtcAsx1Y9fDFdsia6HSGfuLhWk1nYzyADYe3gxLKJFz52rg7hORh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxPuO660NokhUPAQ--.5609S3;
	Sat, 07 Jun 2025 15:35:22 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3xu460Noj50OAQ--.58136S2;
	Sat, 07 Jun 2025 15:35:21 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 02/35] mmc: sdhci-acpi: Drop the use of sdhci_free_host()
Date: Sat,  7 Jun 2025 15:35:06 +0800
Message-ID: <fb7b0f915136b5e9f47ab2e72156fd96ae0d32bf.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBx3xu460Noj50OAQ--.58136S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF48try3Aw13Jw48Ar43Jwc_yoWfurc_Ca
	s8ZrZ7Wry8CrWvy34Utw1Sv34YgFna9F1kuFWrt395ua4Iq34kCayxur1rAry3Za1v9FW3
	C34rGr4xur4YyosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbh8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY
	6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI0eHUUUUU

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_free_host() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index e6c5c82f64fa..1e38a881a859 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -948,7 +948,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (c->slot && c->slot->free_slot)
 		c->slot->free_slot(pdev);
 
-	sdhci_free_host(c->host);
 	return err;
 }
 
@@ -972,8 +971,6 @@ static void sdhci_acpi_remove(struct platform_device *pdev)
 
 	if (c->slot && c->slot->free_slot)
 		c->slot->free_slot(pdev);
-
-	sdhci_free_host(c->host);
 }
 
 static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
-- 
2.47.1

