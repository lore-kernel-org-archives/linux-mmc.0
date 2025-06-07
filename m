Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FB1F17E8
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281728; cv=none; b=BxOfSiny9qZv4Ik/IZRLytV8NrfKhBvmUMkAcIQ/nvFkzCUDUQLis+dr1NwDSF1ZQ4xOZhonswPFFww4KW0IFC/i1VfXuxSPu66ZbhHhi3nbpOoQEbigvR6qxp82SmaZnDQrCv73sfRwz+W7qiS9iXHfBYZWqiqUMpJstAlw3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281728; c=relaxed/simple;
	bh=p8CwtF0ze41OHl5NQUVir4TW807YOg76/G1K64ooe9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1NEHh8E60ZtpXOMX+d6ORFpUozFJZl0ARXoYrGagr9BhdWdfwZOg6OEWS2MYTfRvnELK2r4wD5TO2orvh0FgbIn3vCLIr8hgVAW2YlhGJIAYahasu+yAsFPDb5yjGEYMtUwYYI1vYENRpwFyUMhhknt69K8QcWyik3ClJCPYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxvnK960NonxUPAQ--.41919S3;
	Sat, 07 Jun 2025 15:35:25 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3xu460Noj50OAQ--.58136S4;
	Sat, 07 Jun 2025 15:35:24 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 04/35] mmc: sdhci-pci: Drop the use of sdhci_free_host()
Date: Sat,  7 Jun 2025 15:35:08 +0800
Message-ID: <48c54b92b6c4151db0bfee1a74645225878be1ff.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBx3xu460Noj50OAQ--.58136S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kAr17Jr17CF13Zw47GFX_yoW8WF48pa
	15Xa4YkrWrJF4Fvrn8Aw1fZF1Fkr1jqrWYg3W3Xw10qF1Yyr43tFs7CF1rtr98XaykWw4f
	Xan8ZrWrCFW8X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU0rhLUUUUUU==

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

