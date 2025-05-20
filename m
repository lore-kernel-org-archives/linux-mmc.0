Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71FD27D77A
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741522; cv=none; b=K04GwlWB1MUGwSqS6JK0nW6e51rG9TVrncAZnWlpJXsFHw+1g0+6aCHfdl2U/FK2bPRr2PNYQYD1VKso+O228Lvi5+G1ikVP9C/z6LabKNszcaupManUO66PZ/XMqzI1z/krGGSS6aiiUEqSTxos+1q6yrnUUOv+0fzDEQaWAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741522; c=relaxed/simple;
	bh=Yo7uQGZJqyEqDJ1VLAJoNoc9o/4tHSljBgVRav8ls0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuZ+1BSeaG3sfrtJ21Y7TJZhFLzhpOhspHLa8h3jX4uQ5I5r+axPPI4pbxFcfbbG9IIplG2LinsjjGN6rRjGmbTp6niPKyKZXbkJNvzle0HbW7gaF0V0BU8d2+uOYs3oxj+inSjCgQUvb0BRsqnVwb6tpm8/jHRGqn6QxHjQMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxQK1PayxoXV3zAA--.48830S3;
	Tue, 20 May 2025 19:45:19 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+VNayxoLzvjAA--.57170S2;
	Tue, 20 May 2025 19:45:18 +0800 (CST)
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
Subject: [PATCH 04/36] mmc: bcm2835: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:45:05 +0800
Message-ID: <bbb9a49ba4bd3fe5d27727dec85e642877e6dcfd.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+VNayxoLzvjAA--.57170S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5uw4xJFWxZFyDGF1rGrX_yoW8Jw1fpa
	1rXFyUKrWUGF4Yk3y8Gan8CFy8W3s2k3y8KFWUWw1Iyas8ArWDtFnakFyvqF95JFyIyFWS
	qF1DZr15uFn5JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU00eHDUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/bcm2835.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index e5f151d092cd..b75c9c0136d3 100644
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

