Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526F91E86E
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953552; cv=none; b=so/Mk529c4pd1mlPLWNFwxoGOmvYlaeOQ0InMwOTdWg/7QoWjEmVfV4p8HsoeaQpnuDblln8HRPTPXwWbx6ets/ao6Ay5RTOK5xbQGzmX+Nl9r9oWKgQ+ojGETxuzaZZoAvCuAnN9oGWzf0BpTuShETBSLxqY+sqh3Ya/N+LVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953552; c=relaxed/simple;
	bh=CoQeVakWcLGgx3+M70yiSsG1bDecOjf8JKubErvRzUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cni8EgQ/mi+Iv6VGpBuJhIWD9+meA5r2o1SXFXJ0y1p31uJc+uGj1z2QkLNTSheKy11UNFhLipB39ppICs4WtAgKDs7cLKAyWfY505/JraHZ4HxsvviNjhbsuk+q+CKos5fiIuxE3UcVA6d3Th8JzS8sukCL/T/WkerK3UDsRGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxbeLM6T5oWzUKAQ--.60577S3;
	Tue, 03 Jun 2025 20:25:48 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxXsXJ6T5oAQ4HAQ--.25382S2;
	Tue, 03 Jun 2025 20:25:48 +0800 (CST)
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
Subject: [PATCH v3 04/36] mmc: bcm2835: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:25:33 +0800
Message-ID: <37a95baec1889f906134deb2dc761a98e950dcd1.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBxXsXJ6T5oAQ4HAQ--.25382S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5uFy5Jw4UAr4rAFy8CrX_yoW8GrWrpa
	1rXFy8KrWUGF4Ykw48Ja98CF18W3s2y3yxKFWUWw1Iy345AryDtrnakFyvqF95JFyIyFWS
	qF1DZr18uF1kJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
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

