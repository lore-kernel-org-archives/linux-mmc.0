Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58913635C
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741595; cv=none; b=TFFxDTIKXqoB/GW+llZ4lPAb1FDwqUch02wDaSsMOCnn5YjUoNWCGm0t9LgFexFDbrYfWJzNg6AKMkbnz/JYWqfSsg4diuw2+sXcoK7Gc7Fq8u6vE0/7pnN50yvr0E8yelRpVCye72REptwNlbJxCwnG7109WhU39VSqvbW7K5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741595; c=relaxed/simple;
	bh=bFKtZr01sDR9wTaPjaJ0aHKssimVSQ3vZUljPf9Ikdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DatpdgpaHkBzxcvHdFMUdk+4msHWN+YYpGT9Pu//CW/lZeg0CZv3mIUwL5aLdL3dk4PYDHEOWZgEKtj3Zfw7Mn0DxRPIBI9jrn2ljTzWu7N1NvPIl04Sw1hLSXfXF3ckWFdhLXY+zxVhP//PBKe/RdXP3Rre1THaut1q9FA9xAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxzOKYayxo9F3zAA--.358S3;
	Tue, 20 May 2025 19:46:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx7xuUayxoqzvjAA--.55558S4;
	Tue, 20 May 2025 19:46:32 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 22/36] mmc: rtsx_usb_sdmmc: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:46:17 +0800
Message-ID: <6405ce02fcf3039e09cf66c8460e3933730722b3.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx7xuUayxoqzvjAA--.55558S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4rJw17XF1xWrWDtF1UJwc_yoW8JFyfpa
	15XFWxKrWYgF45K34UJa1DCa4rCa4aqayI9rWUZ34xXwn8G34ktr95CFyaqF1rJFykAFsI
	gFs5Zr4ruF15WFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y40E4I
	xF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU5IoGPUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index d229c2b83ea9..9c5d695d04b1 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1334,7 +1334,7 @@ static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
 
 	dev_dbg(&(pdev->dev), ": Realtek USB SD/MMC controller found\n");
 
-	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -1368,7 +1368,6 @@ static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
 #ifdef RTSX_USB_USE_LEDS_CLASS
 		led_classdev_unregister(&host->led);
 #endif
-		mmc_free_host(mmc);
 		pm_runtime_disable(&pdev->dev);
 		return ret;
 	}
@@ -1406,7 +1405,6 @@ static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 	led_classdev_unregister(&host->led);
 #endif
 
-	mmc_free_host(mmc);
 	pm_runtime_disable(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 
-- 
2.47.1

