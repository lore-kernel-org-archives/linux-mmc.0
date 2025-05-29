Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F281E521
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523539; cv=none; b=FDZvhGVbYX7DuOYVRjU6sCUkzhJACpKCCBLlwz73L0eBLs+MuiDs7MqeUe5KLsQYXkRWbWIy7MZiIP06PhLTHA+J9mDAzUjayW0KUkdGHbrgtptqEZpCPwHzM5gBDZ9TyM2YvIW78XCjjf1hWwLjikGcbYipIkzfr8j8v2EC8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523539; c=relaxed/simple;
	bh=/yJQnZkvEk6D2CfxI6q+h+dsBMMY3pKQSkqOtdoRWWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCatsePV9rSyUR+fjf4/TqkaPR4kHsvNt/18mDZ9J0QQRbb/WxdEEuBSpF5vFTJg0KMQXsxJSS/ecTZgbNq47OLLJUKl9uSg4m8Ge+bFFbgFSbPMAEjDcOhGhV34zLGgWyGF3TJhbyFbHfLoCzWTKbrA//oKIt3A877EAhEux8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxCGoQWjhorSoCAQ--.22100S3;
	Thu, 29 May 2025 20:58:56 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxPcUJWjho5bL6AA--.55364S3;
	Thu, 29 May 2025 20:58:55 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 07/35] mmc: sdhci-pltfm: Drop the use of sdhci_pltfm_free()
Date: Thu, 29 May 2025 20:58:42 +0800
Message-ID: <75e3f5ecb5e7c3ec182e678a00286b4e388a187a.1748515612.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxPcUJWjho5bL6AA--.55364S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWUKrWUArW3KFyfAF4xuFX_yoW8Arykpa
	15JrWxGr48WrWrWwn0gw1UAFyS9w1293yUKry8Cw10v39xKFn5tFs3CayjyFyfAFyDGa1S
	qF4vvF48CF98A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07bOeHgUUUUU=

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

