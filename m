Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A619ABB6
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525315; cv=none; b=jnXXy+BAozZBj61Nx4s1IwW5QEzNEN4S2gSVRo4s16hmL5hCi27omcNbrf8MSGrs+FvcCTa8gFoU+OZ7MfZF4NryPzmZsxpCiy65FwH5F8JCocFkCs/hNaslOjSI5b+cOl+Tf1lcc2C0a15D3FcRWiQMjsN/0N2hsnmtBYST6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525315; c=relaxed/simple;
	bh=EThD0uoKX65lqL99A4Rw4RlszGGeFkI2ed46uRhpGNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmH0QWY5pjPMqBD0ys/4PLlWwjGVdvOEDwJZaNFdxB9QjsGEabRgin4Aq24GI6KA7F+2MG90yHb8vRuXi6qIhz4E0DKus+zvSb70kihYU/klt8nUxKipw2mhr+eyhOdyJ+3raDQbc797Bl/7tq4aZlNuSWq3BzO5By8z0XJA7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxOGr_YDhoTjgCAQ--.24864S3;
	Thu, 29 May 2025 21:28:31 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxn8X7YDhogMP6AA--.57071S2;
	Thu, 29 May 2025 21:28:30 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 35/35] mmc: sdhci: Drop sdhci_free_host()/sdhci_pltfm_free() definitions
Date: Thu, 29 May 2025 21:28:18 +0800
Message-ID: <57ce5c1bd33badc3f1519c446509a1538663af4d.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBxn8X7YDhogMP6AA--.57071S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF1UAFW7JF4rJw15JFykCrX_yoW5XrWDpa
	15Xry7Gr48GF1rWryDGw1DZ34rWw1j934UK345Jw4FqayUK34DtFsxAFWjyry5ZFWDt3WS
	qF1qvF1rur95J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5Q0ePUUUUU==

From now on, all calls to sdhci_free_host()/sdhci_pltfm_free() have been
cleaned up, so we can just delete their definitions.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pltfm.c | 5 -----
 drivers/mmc/host/sdhci-pltfm.h | 1 -
 drivers/mmc/host/sdhci.c       | 6 ------
 drivers/mmc/host/sdhci.h       | 1 -
 4 files changed, 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index aedbcd32713a..7f6ac636f040 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -146,11 +146,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
 
-void sdhci_pltfm_free(struct platform_device *pdev)
-{
-}
-EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
-
 int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
 				  const struct sdhci_pltfm_data *pdata,
 				  size_t priv_size)
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index b81d5b0fd616..9c32e8a289d6 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -97,7 +97,6 @@ static inline void sdhci_get_of_property(struct platform_device *pdev)
 extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 					  const struct sdhci_pltfm_data *pdata,
 					  size_t priv_size);
-extern void sdhci_pltfm_free(struct platform_device *pdev);
 
 extern int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
 					 const struct sdhci_pltfm_data *pdata,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ee5a5ae4db31..c40caa3f003f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -5000,12 +5000,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 EXPORT_SYMBOL_GPL(sdhci_remove_host);
 
-void sdhci_free_host(struct sdhci_host *host)
-{
-}
-
-EXPORT_SYMBOL_GPL(sdhci_free_host);
-
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f9d65dd0f2b2..58291a6f093d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -811,7 +811,6 @@ static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
 #endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
 
 struct sdhci_host *sdhci_alloc_host(struct device *dev, size_t priv_size);
-void sdhci_free_host(struct sdhci_host *host);
 
 static inline void *sdhci_priv(struct sdhci_host *host)
 {
-- 
2.47.1

