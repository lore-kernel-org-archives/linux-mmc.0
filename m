Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534923185D
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953677; cv=none; b=pAXmfY+21pNfO+7bQwNdSA73oBFBblabRkA+cR3s4B3Ni5hA6fzDWiFhWQFyhrV+gFiuh4dA71iUOV06mKspkLTTB5OVuXf3Xik6hABDCon1eEfsbQFjGswCa1gOshF0lgnZKnV3Tpu5e4rQEWmWAFOMKWIHm13wy+TdbDn7sZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953677; c=relaxed/simple;
	bh=7DYCqrcpvxLRNM29XQxviWkvv2FB4OmOJAVNqwPoYso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyQj5O+PCb48d7BdoSmP588kb2WJqLINgJ2fMjUTmMEJPgOe71tDpVwFkpCwn8U2Phzaam/EFKXY/t+6OzhJh003FM4lBnV53bNp0+Dldw3jqZyPBIGcEmlojm0eHF9e8gCY/hi1w9N0gL0KqAp5sYz9SrYxnlkes39HclCC66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxC3JJ6j5okzYKAQ--.32996S3;
	Tue, 03 Jun 2025 20:27:53 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxDcVE6j5o8A4HAQ--.21232S5;
	Tue, 03 Jun 2025 20:27:53 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>
Subject: [PATCH v3 27/36] mmc: usdhi6ro10: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:27:37 +0800
Message-ID: <e236d2ee9cd6bb9450e3500577eda17c8fb53c1c.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxDcVE6j5o8A4HAQ--.21232S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw43Zw47Zry7ZFy7ArWrZwc_yoW5Xr43pF
	s3JrZrKr18Jr4Yg393Gw1DA3WFyr4Sqay7WrWkWwn3Xw15ArWDtwn3CFyFvFs5GFWkJr1a
	gF4DGF4UCa4UWFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Gryq
	6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07ba1v3UUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/usdhi6rol0.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 49efb960a052..85b49c07918b 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1762,17 +1762,17 @@ static int usdhi6_probe(struct platform_device *pdev)
 	if (irq_sdio < 0)
 		return irq_sdio;
 
-	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto e_free_mmc;
+		return ret;
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
-		goto e_free_mmc;
+		return ret;
 
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1785,30 +1785,24 @@ static int usdhi6_probe(struct platform_device *pdev)
 	mmc->max_busy_timeout = USDHI6_REQ_TIMEOUT_MS;
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(host->pinctrl)) {
-		ret = PTR_ERR(host->pinctrl);
-		goto e_free_mmc;
-	}
+	if (IS_ERR(host->pinctrl))
+		return PTR_ERR(host->pinctrl);
 
 	host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
 
 	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(host->base)) {
-		ret = PTR_ERR(host->base);
-		goto e_free_mmc;
-	}
+	if (IS_ERR(host->base))
+		return PTR_ERR(host->base);
 
 	host->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(host->clk)) {
-		ret = PTR_ERR(host->clk);
-		goto e_free_mmc;
-	}
+	if (IS_ERR(host->clk))
+		return PTR_ERR(host->clk);
 
 	host->imclk = clk_get_rate(host->clk);
 
 	ret = clk_prepare_enable(host->clk);
 	if (ret < 0)
-		goto e_free_mmc;
+		return ret;
 
 	version = usdhi6_read(host, USDHI6_VERSION);
 	if ((version & 0xfff) != 0xa0d) {
@@ -1878,9 +1872,6 @@ static int usdhi6_probe(struct platform_device *pdev)
 	usdhi6_dma_release(host);
 e_clk_off:
 	clk_disable_unprepare(host->clk);
-e_free_mmc:
-	mmc_free_host(mmc);
-
 	return ret;
 }
 
@@ -1894,7 +1885,6 @@ static void usdhi6_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&host->timeout_work);
 	usdhi6_dma_release(host);
 	clk_disable_unprepare(host->clk);
-	mmc_free_host(host->mmc);
 }
 
 static struct platform_driver usdhi6_driver = {
-- 
2.47.1

