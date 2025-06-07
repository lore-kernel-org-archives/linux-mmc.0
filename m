Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B81AA782
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749282834; cv=none; b=TH+FKRDG/Fgnhqqs6mbosXO6Ivk7igA6LWtM5aA8e1xHtuVGSIoGsycZWU02m1ks8eqKPLAg0b7PncFl+IrM4lGoCl4eLSK1wnYFSwuaVchooh3gQY5xzpCqXQFC1egjU2/SOWAz3katu6O2plLh7jQGbn2gbxUOymSPWGvkzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749282834; c=relaxed/simple;
	bh=CsrGz0hDqk0AF+LrfESh4dbCN64U6pQ8+8TNS0S/Y00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcTZG3j03DKO5jaO3oy5dVr3TcLP+ak7q3k33NyjddDoKVjOL3YEkhDyEtq87AwAQPz8yR+hEsw0EWTRMhw8XLAk7fnUBRku68V8Gv0T4oy/zyIArfYK/XZmLJW0ATIZMivlMHd+kHZBfpM7IO46jUk74vCMzNdm1EvyLpM3ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxvOIP8ENodRkPAQ--.43703S3;
	Sat, 07 Jun 2025 15:53:51 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx7xsN8ENoKKMOAQ--.44817S2;
	Sat, 07 Jun 2025 15:53:50 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 35/35] mmc: sdhci: Drop sdhci_free_host()/sdhci_pltfm_free() interface
Date: Sat,  7 Jun 2025 15:53:41 +0800
Message-ID: <8adcfef00fd4bc40f33f5fd42d2e5e73d72e68e4.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx7xsN8ENoKKMOAQ--.44817S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw1ftw13CF4kZFWUCr43XFc_yoW5Xry3pa
	15Xry7Gr48GF15WryDGw1DZ345Ww1j934UK345Jw4FqFWUK34DtFsxAFWjyry5ZFWDt3WS
	qF1qvF1rur95J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5Q0ePUUUUU==

From now on, all calls to sdhci_free_host()/sdhci_pltfm_free() have been
cleaned up, so we can just delete them.

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

