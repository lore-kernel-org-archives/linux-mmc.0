Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A71E2853
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281761; cv=none; b=lK87ECw8AbwEwTkoHstzuJe81xk0/eXFf5u8bp1yEs6CUzCEXpIBzfjHMPWSHRtYo/5ORUyUEyLedb7pfI9QcQn71p3shjxd9NaA7GmrkU/rt0jqO0H+wHM3VmlV9KOMFXEsjZHHY3QhWlA2fdCDGaF60n7KBh9O8r+AGOedaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281761; c=relaxed/simple;
	bh=/yJQnZkvEk6D2CfxI6q+h+dsBMMY3pKQSkqOtdoRWWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K56iv5PLk73YGu944NYgeTEx6OEFjgjt0KiSHDrJGZ+Aa64O2iwLOZPYj4Lfd+ifgDt/7XbQ2PTDQIZMnpI/A6Y3VJvTrAdSGvIN9oY7WkwM3tloTnb0T4Xzbc1w2fXFVx5fietfPDFhxt4WsK8E5c/Ts07AUIcfdfEavRXT0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx63He60NozBUPAQ--.41070S3;
	Sat, 07 Jun 2025 15:35:58 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxPsfa60NouZ0OAQ--.49038S3;
	Sat, 07 Jun 2025 15:35:57 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 07/35] mmc: sdhci-pltfm: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:35:43 +0800
Message-ID: <67e8881bc46f12aadbe82c655ce373b9c6907182.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxPsfa60NouZ0OAQ--.49038S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWUKrWUArW3KFyfAF4xuFX_yoW8Arykpa
	15JrWxGr48WrWrWwn0gw1UAFyS9w1293yUKry8Cw10v39xKFn5tFs3CayjyFyfAFyDGa1S
	qF4vvF48CF98A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0oKZJUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

To avoid causing drivers that still use sdhci_pltfm_free() to fail to
compile, it has been temporarily set to empty. And it will be removed
when there are no longer any callers.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-pltfm.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 62753d72198a..aedbcd32713a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -148,9 +148,6 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
 
 void sdhci_pltfm_free(struct platform_device *pdev)
 {
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-
-	sdhci_free_host(host);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
 
@@ -159,7 +156,6 @@ int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
 				  size_t priv_size)
 {
 	struct sdhci_host *host;
-	int ret = 0;
 
 	host = sdhci_pltfm_init(pdev, pdata, priv_size);
 	if (IS_ERR(host))
@@ -167,11 +163,7 @@ int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
 
 	sdhci_get_property(pdev);
 
-	ret = sdhci_add_host(host);
-	if (ret)
-		sdhci_pltfm_free(pdev);
-
-	return ret;
+	return sdhci_add_host(host);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_init_and_add_host);
 
@@ -181,7 +173,6 @@ void sdhci_pltfm_remove(struct platform_device *pdev)
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
-	sdhci_pltfm_free(pdev);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_remove);
 
-- 
2.47.1

