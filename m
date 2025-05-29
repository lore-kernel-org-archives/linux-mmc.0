Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC61E521
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523516; cv=none; b=b2DTfhMwj7fgvmpjuhJfsCaPxnKGFsG4x5HLcU8gSXwG1wtwYofsQRQFQrU9X0XTiwrQmmYbE182eB5JhKpWy8ewkySj6YQwySNich7kg+acbA/8kIZ/YcpV3UscT/Biuu0yle+26lUnYbb3GTd5iB808DXd9nzbLV1gtlDVi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523516; c=relaxed/simple;
	bh=p8CwtF0ze41OHl5NQUVir4TW807YOg76/G1K64ooe9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URhby7QU35VgnWvlbfj4E/K+O8g5a4HtEGy5pnGWgMsWISp/HuSvowzpnOBoPESWc0F7PjP8s6nbLftoHUGZGRfR/Ej9ngroWck8NIbKO39pqk1/kG3vHznpIZCMA1GR2Dz+s1wmDn3RKnN95/M8ThX19/7wopv9QG96SeI57cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxyuD4WThoYCoCAQ--.22248S3;
	Thu, 29 May 2025 20:58:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMTyWThonbL6AA--.57145S4;
	Thu, 29 May 2025 20:58:31 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 04/35] mmc: sdhci-pci: Drop the use of sdhci_free_host()
Date: Thu, 29 May 2025 20:58:17 +0800
Message-ID: <767c0157d762077b50a22945c01c4069b7bba244.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMTyWThonbL6AA--.57145S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kAr17Jr17CF13Zw47GFX_yoW8WF48pa
	15Xa4YkrWrJF4Fvrn8Aw1fZF1Fkr1jqrWYg3W3Xw10qF1Yyr43tFs7CF1rtr98XaykWw4f
	Xan8ZrWrCFW8X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bOrcfUUUUU=

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_free_host() is no longer needed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pci-core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 13a84b9309e0..9f567b768c42 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -2173,7 +2173,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	ret = pcim_iomap_regions(pdev, BIT(bar), mmc_hostname(host->mmc));
 	if (ret) {
 		dev_err(&pdev->dev, "cannot request region\n");
-		goto cleanup;
+		return ERR_PTR(ret);
 	}
 
 	host->ioaddr = pcim_iomap_table(pdev)[bar];
@@ -2181,7 +2181,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	if (chip->fixes && chip->fixes->probe_slot) {
 		ret = chip->fixes->probe_slot(slot);
 		if (ret)
-			goto cleanup;
+			return ERR_PTR(ret);
 	}
 
 	host->mmc->pm_caps = MMC_PM_KEEP_POWER;
@@ -2242,9 +2242,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	if (chip->fixes && chip->fixes->remove_slot)
 		chip->fixes->remove_slot(slot, 0);
 
-cleanup:
-	sdhci_free_host(host);
-
 	return ERR_PTR(ret);
 }
 
@@ -2265,8 +2262,6 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
-
-	sdhci_free_host(slot->host);
 }
 
 int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
-- 
2.47.1

