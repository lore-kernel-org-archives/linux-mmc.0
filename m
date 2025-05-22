Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C92221FBB
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897218; cv=none; b=lZoZwULYBnqewKHLNMBNgSc6zwT38yNThwYMn6OdImMPUS6lrA2rlhM6O86Z/IT0EJRw5HCcAKcs9yt+Etk9ebPP6xc9hbtXOZBdejIKzgRrMrFZNPHMy9F8LYeg81HFWyb69ENajaxnHpLkpXKN8T16dNFJNXJPJjR5yQ0Xk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897218; c=relaxed/simple;
	bh=pDgP9GZA7sYlb2Ze2sJjSvtrBEAhbUhgHxd7KvWrNoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y45FysjWgnUbfa8iuLGGUoLnuRr7C/ASRbAIWuq4RQ5V1M8CBuB5MT6/xUsVLu3MNks0TlqlYfK4CL/OUuTW3ZIOyoLP+mJwCS+jEnIvSTKFD+RzCyca8iRfD6DEa9ssiaKoZBbxNqFH8PxoyBKwxZGEmXej35BilD7Dzocd/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxHHJ7yy5oTyL2AA--.4622S3;
	Thu, 22 May 2025 15:00:11 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcV1yy5oEnLnAA--.499S4;
	Thu, 22 May 2025 15:00:08 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 12/36] mmc: mmci: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 14:59:53 +0800
Message-ID: <898e7bfb0b29fda71af14eca89a4baec6aee186d.1747877176.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747877175.git.zhoubinbin@loongson.cn>
References: <cover.1747877175.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxLcV1yy5oEnLnAA--.499S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryUXF4xKrykCrW8Gry3trc_yoW5XFyUpa
	n3JasIgry5Gr43W39xJwnrGF1rWr40q3yxGr97W34xZw1YyrWDK3ZY9FWFqF95AFWkJF43
	WF4UJ34UuF9FvFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8
	Xw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07Uio7tUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/mmci.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b790c3c3c8f9..c70c64f8adc4 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2223,7 +2223,7 @@ static int mmci_probe(struct amba_device *dev,
 			return -ENOMEM;
 	}
 
-	mmc = mmc_alloc_host(sizeof(struct mmci_host), &dev->dev);
+	mmc = devm_mmc_alloc_host(&dev->dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -2234,7 +2234,7 @@ static int mmci_probe(struct amba_device *dev,
 
 	ret = mmci_of_parse(np, mmc);
 	if (ret)
-		goto host_free;
+		return ret;
 
 	/*
 	 * Some variant (STM32) doesn't have opendrain bit, nevertheless
@@ -2242,19 +2242,15 @@ static int mmci_probe(struct amba_device *dev,
 	 */
 	if (!variant->opendrain) {
 		host->pinctrl = devm_pinctrl_get(&dev->dev);
-		if (IS_ERR(host->pinctrl)) {
-			dev_err(&dev->dev, "failed to get pinctrl");
-			ret = PTR_ERR(host->pinctrl);
-			goto host_free;
-		}
+		if (IS_ERR(host->pinctrl))
+			return dev_err_probe(&dev->dev, PTR_ERR(host->pinctrl),
+					     "failed to get pinctrl\n");
 
 		host->pins_opendrain = pinctrl_lookup_state(host->pinctrl,
 							    MMCI_PINCTRL_STATE_OPENDRAIN);
-		if (IS_ERR(host->pins_opendrain)) {
-			dev_err(mmc_dev(mmc), "Can't select opendrain pins\n");
-			ret = PTR_ERR(host->pins_opendrain);
-			goto host_free;
-		}
+		if (IS_ERR(host->pins_opendrain))
+			return dev_err_probe(&dev->dev, PTR_ERR(host->pins_opendrain),
+					     "Can't select opendrain pins\n");
 	}
 
 	host->hw_designer = amba_manf(dev);
@@ -2263,14 +2259,12 @@ static int mmci_probe(struct amba_device *dev,
 	dev_dbg(mmc_dev(mmc), "revision = 0x%01x\n", host->hw_revision);
 
 	host->clk = devm_clk_get(&dev->dev, NULL);
-	if (IS_ERR(host->clk)) {
-		ret = PTR_ERR(host->clk);
-		goto host_free;
-	}
+	if (IS_ERR(host->clk))
+		return PTR_ERR(host->clk);
 
 	ret = clk_prepare_enable(host->clk);
 	if (ret)
-		goto host_free;
+		return ret;
 
 	if (variant->qcom_fifo)
 		host->get_rx_fifocnt = mmci_qcom_get_rx_fifocnt;
@@ -2491,8 +2485,6 @@ static int mmci_probe(struct amba_device *dev,
 
  clk_disable:
 	clk_disable_unprepare(host->clk);
- host_free:
-	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -2522,7 +2514,6 @@ static void mmci_remove(struct amba_device *dev)
 
 		mmci_dma_release(host);
 		clk_disable_unprepare(host->clk);
-		mmc_free_host(mmc);
 	}
 }
 
-- 
2.47.1

