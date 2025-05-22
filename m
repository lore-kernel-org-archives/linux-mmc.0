Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5C846F
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897185; cv=none; b=OumgOflLP2j/2LUS1+XQrQcxLyG6BP/Akuuhxvi77J9dpsxnobc2WFwNLMds9ixdAanfDhrnEFh3fWlYuapKtKZhKt2lLj1OEoPBgMnFnqjIT5Qo3p79I3qXkdpK+dttd1WqnTuKLACMJAmlcc1UwE4iGoFOwu3jXlcFdbVwvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897185; c=relaxed/simple;
	bh=2v8ombbjI499li/9hcdjWumYPUeg18hpVX36K9gu4SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/xP5vVBVn3mAxJXbkPQBYUPomwkhoMkHjc7HhW5+2SN5VAKuTB9dm1JBjFXQKMmLz5RgIimdN74obp9plIzBqvV5nHsgJnzOAAg32MzQNcC2sSkb3ELjsdkoPDd9ugA8TmIRB9br4XpcdD/6gk3L5X0wgGpNo2Hepb/mI4l12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxmnFeyy5o5SH2AA--.4530S3;
	Thu, 22 May 2025 14:59:42 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcVdyy5oznHnAA--.496S2;
	Thu, 22 May 2025 14:59:41 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v2 04/36] mmc: bcm2835: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 14:59:29 +0800
Message-ID: <420f01093b8d12ea1c7a4383d0426931b6bb2c44.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxLcVdyy5oznHnAA--.496S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5uw1kWFyrWry8tr4UKFX_yoW8GrWrpa
	1rXFy8KrWUGF4Ykw48Ja98CF18W3s2y3y8KFWUWw1Iy345AryDtrnakFyvqF95JFyIyFWS
	qF1DZr18uF1kJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/bcm2835.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index def054ddd256..3dde5c367ddc 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1371,7 +1371,7 @@ static int bcm2835_probe(struct platform_device *pdev)
 	int ret;
 
 	dev_dbg(dev, "%s\n", __func__);
-	mmc = mmc_alloc_host(sizeof(*host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -1450,7 +1450,6 @@ static int bcm2835_probe(struct platform_device *pdev)
 	dev_dbg(dev, "%s -> err %d\n", __func__, ret);
 	if (host->dma_chan_rxtx)
 		dma_release_channel(host->dma_chan_rxtx);
-	mmc_free_host(mmc);
 
 	return ret;
 }
@@ -1473,8 +1472,6 @@ static void bcm2835_remove(struct platform_device *pdev)
 
 	if (host->dma_chan_rxtx)
 		dma_release_channel(host->dma_chan_rxtx);
-
-	mmc_free_host(mmc);
 }
 
 static const struct of_device_id bcm2835_match[] = {
-- 
2.47.1

