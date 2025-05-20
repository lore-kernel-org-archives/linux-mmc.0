Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79614277026
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741516; cv=none; b=CgJAgn2S0lrpayyY9zNfiqOxyIfUZIkrL9mr7HTWcNCLp0TKNvTP/MyeS+gLw/yOKhHkojdE6WqDzRbrfS0GuUwl/Xwkn++NFFUNJ7yZemyi37Zsj1pQl8nsslOAsM/8gyux5q9+ML6pf210Ui5lPga+sRcsumqINefVWN5UFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741516; c=relaxed/simple;
	bh=fxeOrNR68T/xBTeyHBAsJFkMLXKhUeU5lpbT4WgYsnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ut2/UfRXOK/4XQBfuRImWE4a5W7REeFiogglePx8I3RrNPhWLsYmFogm3pJgy0AWeKy6eN+depN5sCAgYJjtCkkG4iLSHvlwUDKOx4KWzByygyGBbk/o/lnOvvFMcSJCYlUh4Hpb4CMouT4+VxLjTwTxyURWJneXFRUbwyOC/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxvnNDayxoUF3zAA--.33201S3;
	Tue, 20 May 2025 19:45:07 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxPcU9ayxoEzvjAA--.56744S4;
	Tue, 20 May 2025 19:45:06 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 02/36] mmc: atmel: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:44:51 +0800
Message-ID: <7ff231b5f77652965efce2feb5f965236e79af54.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxPcU9ayxoEzvjAA--.56744S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW3Jw18tw15XF43JFWftFc_yoW8Xr1kpa
	y3Wa42yr4rJF45Wa1DCrZrKFy5J3yaq39FkFy7C3s5ZF1Utr1jqFnY9Fy3tF13AFy8AFnx
	Xan8Zr4Uuw1DAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8KNt3UUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Aubin Constans <aubin.constans@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/atmel-mci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 14e981b834b6..f72fe4b805f6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2247,7 +2247,7 @@ static int atmci_init_slot(struct atmel_mci *host,
 	struct atmel_mci_slot		*slot;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct atmel_mci_slot), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*slot));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -2320,10 +2320,8 @@ static int atmci_init_slot(struct atmel_mci *host,
 	host->slot[id] = slot;
 	mmc_regulator_get_supply(mmc);
 	ret = mmc_add_host(mmc);
-	if (ret) {
-		mmc_free_host(mmc);
+	if (ret)
 		return ret;
-	}
 
 	if (slot->detect_pin) {
 		timer_setup(&slot->detect_timer, atmci_detect_change, 0);
@@ -2361,7 +2359,6 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	}
 
 	slot->host->slot[id] = NULL;
-	mmc_free_host(slot->mmc);
 }
 
 static int atmci_configure_dma(struct atmel_mci *host)
-- 
2.47.1

