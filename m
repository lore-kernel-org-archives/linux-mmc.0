Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3D21FF2C
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741555; cv=none; b=FnUbrr9U0K758nKptD2VghdK+vFKha47fKZzejfmYLBfCFUGV0cfxIehIoVvYgEm9+xZj4da8uTOMDFfNJXhbEEUz8JdLIK6zwiqjogIIHUC+efGmgDNEfdtEYzsHcLrRdFowkWwOXV0YAK5+UQ3COE441xrkzdj52aGz7fr1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741555; c=relaxed/simple;
	bh=g28jRjRs8LNPgrmnKEy6zW+Vb9cDE5oGxGppfu01gh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUTHrbZTnQzAx2Z+BctGWaY/S9tMc9RcqLaNBG1OmfTGpaFs5ni/E4Nd2m5MS+9dePVcKhC8iHtpdbcAuL0oTILZtx+PRKp0T2BAQxw/NB24KuL6H56MlJTfnIiPxbl2NJjxu81rQeZRQz7SX52Sot+e7z9+0NrbaG/J5mG8jSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxXWtwayxosV3zAA--.273S3;
	Tue, 20 May 2025 19:45:52 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMRoayxoYTvjAA--.58140S5;
	Tue, 20 May 2025 19:45:52 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 13/36] mmc: moxart-mmc: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:45:34 +0800
Message-ID: <28efb157a845c3fb2b97a58f54b1c396f0aac97e.1747739323.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747739323.git.zhoubinbin@loongson.cn>
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxzMRoayxoYTvjAA--.58140S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww4fXr43Ary5CrWkWFy5WrX_yoW8KrW5pF
	Z3Ja43Kry5tF4fWrW8Ja1DAF4S9r1jgayUG3y8Wwn7u3ZrAr1DKws8Ca40va4rAFWrGa4j
	qFWUJF15CaykJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFrWrUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/moxart-mmc.c | 40 ++++++++++++-----------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a12048e5de63..3dd8f232052f 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -558,41 +558,33 @@ static int moxart_probe(struct platform_device *pdev)
 	int irq, ret;
 	u32 i;
 
-	mmc = mmc_alloc_host(sizeof(struct moxart_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc) {
-		dev_err(dev, "mmc_alloc_host failed\n");
-		ret = -ENOMEM;
-		goto out_mmc;
+		dev_err(dev, "devm_mmc_alloc_host failed\n");
+		return -ENOMEM;
 	}
 
 	ret = of_address_to_resource(node, 0, &res_mmc);
-	if (ret) {
-		dev_err(dev, "of_address_to_resource failed\n");
-		goto out_mmc;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "of_address_to_resource failed\n");
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0) {
-		dev_err(dev, "irq_of_parse_and_map failed\n");
-		ret = -EINVAL;
-		goto out_mmc;
-	}
+	if (irq <= 0)
+		return dev_err_probe(dev, -EINVAL,
+				     "irq_of_parse_and_map failed\n");
 
 	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto out_mmc;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	reg_mmc = devm_ioremap_resource(dev, &res_mmc);
-	if (IS_ERR(reg_mmc)) {
-		ret = PTR_ERR(reg_mmc);
-		goto out_mmc;
-	}
+	if (IS_ERR(reg_mmc))
+		return PTR_ERR(reg_mmc);
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto out_mmc;
+		return ret;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -686,9 +678,6 @@ static int moxart_probe(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_tx);
 	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
 		dma_release_channel(host->dma_chan_rx);
-out_mmc:
-	if (mmc)
-		mmc_free_host(mmc);
 	return ret;
 }
 
@@ -707,7 +696,6 @@ static void moxart_remove(struct platform_device *pdev)
 	writel(0, host->base + REG_POWER_CONTROL);
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
-	mmc_free_host(mmc);
 }
 
 static const struct of_device_id moxart_mmc_match[] = {
-- 
2.47.1

