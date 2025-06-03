Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84F1E86E
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953556; cv=none; b=Jh0SlOYjblKdZYdE6kRc3fAOcczkPsAt3In9sNZw4MkpGaEcFYJsKKo/hh9qmR+YOQyGs4rlHigUAoFkPNi8dvePQEl5+70MJypBi9+mQXgIQhqqZowLKDS/HOh/TfbNbu+37seyaqkmy7nB3Gd0F0+FKrG0lGSi6bALN1QFaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953556; c=relaxed/simple;
	bh=pldORo4vrtczycb75wTUY+o1sqot1L/pc7Gxbe3lRIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gywDqWPz/iiWVh1Avuo72HMzjBESUmZCctQm9SfmBDiBb5fZmh877Xq6wVK4tEoIT1yrnF9S0U6EdDPQ5loX6NzOWCmdqIi8eQLSyIrPeKi4pfRMFxN5GLlfBYUr52bz6+JVOKjhJvaIXO2jepr8i0WO0XnT0IfgRRnyrFv9kjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxquDQ6T5oZzUKAQ--.57686S3;
	Tue, 03 Jun 2025 20:25:52 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxXsXJ6T5oAQ4HAQ--.25382S4;
	Tue, 03 Jun 2025 20:25:51 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 06/36] mmc: cb710: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:25:35 +0800
Message-ID: <4ef97a91053fe8819c651f7968fb56209faa36d8.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxXsXJ6T5oAQ4HAQ--.25382S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1kXF4xKr15XF43XryDtwc_yoW8GF4fpa
	98J34jyrWDCF4Yg3srJw4DCa4UXwnFvayxKrWUAw1rZ345Zr1qkFnIk3W0vFyrGFZ7AFsa
	qF4v9rWruF1DZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0E38UUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/cb710-mmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index d741c1f9cf87..8787e7f49e94 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -692,7 +692,7 @@ static int cb710_mmc_init(struct platform_device *pdev)
 	int err;
 	u32 val;
 
-	mmc = mmc_alloc_host(sizeof(*reader), cb710_slot_dev(slot));
+	mmc = devm_mmc_alloc_host(cb710_slot_dev(slot), sizeof(*reader));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -741,7 +741,6 @@ static int cb710_mmc_init(struct platform_device *pdev)
 	dev_dbg(cb710_slot_dev(slot), "mmc_add_host() failed: %d\n", err);
 
 	cb710_set_irq_handler(slot, NULL);
-	mmc_free_host(mmc);
 	return err;
 }
 
@@ -764,8 +763,6 @@ static void cb710_mmc_exit(struct platform_device *pdev)
 	cb710_write_port_16(slot, CB710_MMC_CONFIGB_PORT, 0);
 
 	cancel_work_sync(&reader->finish_req_bh_work);
-
-	mmc_free_host(mmc);
 }
 
 static struct platform_driver cb710_mmc_driver = {
-- 
2.47.1

