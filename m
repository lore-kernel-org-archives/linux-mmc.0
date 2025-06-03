Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EC3230BC0
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953597; cv=none; b=Zxho6j/3T1VwfCupbMtfm1aVW06JmftJ15J0BFI7Mn0eHfnXXQuCKc9b2A056LbhHRB3ipzXAcLhrJtIALGLcZkXn2cc/c/fp8Ya5V81MNLCgpdmJ0wCGfYbb7ux/I8COCgiF+04iVCEu/bu+J4cmHQbtFlLm9Qj0jzuqkeCvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953597; c=relaxed/simple;
	bh=yRvt0nP1BFWvwyi5QmrlWqAgzsUqc6KPDDcxINnCZKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnlsOGTWsZl9F3mHLS0QMTGgVe72SqLfq6E0/ouZdYpduDhB+fFWXIapMoG+6A6R6IqWiRDmdQoVKLQHxbKnb4mhtVcsWgFH8j5tiBQNIn7W5I593FMAF/OGS6Grz39rrjlbipGgJpGdIAlRNoll/SShsqbuxYjqStCY++eFLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxzOL56T5owjUKAQ--.32701S3;
	Tue, 03 Jun 2025 20:26:33 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3MTx6T5oNQ4HAQ--.23320S4;
	Tue, 03 Jun 2025 20:26:31 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 12/36] mmc: mmci: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:26:13 +0800
Message-ID: <f2da882c5c41c25372d82b769506a7dd60fd0d4d.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3MTx6T5oNQ4HAQ--.23320S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw1kAF13AF1DZryDWw1Dtwc_yoW5XFyUpa
	n3JasIgry5Gr45W39xJwnrGF1rWr48t3yxGr97W34xZw1YyrWDK3ZY9FWFqF95CFWkJF43
	WF4UJ34UuF9FvFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUx_-BDUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Russell King <linux@armlinux.org.uk>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
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

