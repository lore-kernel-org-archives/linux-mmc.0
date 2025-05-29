Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE7E1E521
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523512; cv=none; b=MwPZeHDBSPUktiPGcVHg4KPLDxqG/8yhRb58pTOTNhz4ia19olSUUXWQSCBSwjWJCXM+GiQag6bR7/z98vhOZe7g1mKsJ4cmsQXTQY44sxbY95v865rt70elLS+pQTh0DG7dtEPbKmdTA4hrQ+c+7m/bfJ2L+Iv5hzr+pdf5H8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523512; c=relaxed/simple;
	bh=EuViignEqGJ2xcmTanXp3nv41YCwmVpguTdePU2PsRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T03LNbQQ92ZZJ5rLrcSxu54gkHdxX09A2pmB07NEWyovRtQDjZumqeHFdmZeJ5H4X6H0LciA29cHFPWs6VzLxhuzATaEnAK87ArzKX3V0l1kA6bFzVv7SWWMu4QSqRG47j+/Yzqbtoi71+FTCB5L7EpbztFHndXmrJT7m1WjESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx3670WThoSCoCAQ--.3987S3;
	Thu, 29 May 2025 20:58:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMTyWThonbL6AA--.57145S2;
	Thu, 29 May 2025 20:58:28 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 02/35] mmc: sdhci-acpi: Drop the use of sdhci_free_host()
Date: Thu, 29 May 2025 20:58:15 +0800
Message-ID: <1445d38edc9d40758221bc5c6db349e916ef3247.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMTyWThonbL6AA--.57145S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF48try3Aw13Jw48Ar43Jwc_yoWfurc_Ca
	s8ZrZ7Wry8CrWvy34Utw1Sv34YgFna9F1kuFWrt395ua4Iq34kCayxur1rAry3Za1v9FW3
	C34rGr4xur4YyosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07j4WlkUUUUU=

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

