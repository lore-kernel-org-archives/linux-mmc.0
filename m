Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047E22F152
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953687; cv=none; b=GfYXORkT7TCvt0irKL0gMjpqoLdREw3rjpWe5nthmgEJSRkyyFEjIOETM03BjPUSM2IkkeZfiv6QBLVgYKQP8xb/cZMQqy7S0Umphp7NlrLU8XF3ERbBWK1W9wHoT2xu8B/6aKKaorO88Fm2AUy6UB151Fnv8ic9uMVEhtSENzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953687; c=relaxed/simple;
	bh=5KlAmBT7v/ML+54ruZCYeOVkRIt5QowogJLa5Yq4630=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC1WgGqQtM28M6h1G+WjtmZOWk/HmgFROfqddHMISwL8/ZRUxqE0Vdu8DpiUcEBZNLVO//j0y7kCtUrYU7CyCo6Usc0UwQDV1j0/Bl5aNnZ/5MHkg+1Q+gQZnMBPyl2L5rNnu5iIWdFaxib34TGKKPd39ngXaanDytUpQj8Hl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxyuBU6j5otzYKAQ--.33720S3;
	Tue, 03 Jun 2025 20:28:04 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMRS6j5oLw8HAQ--.25132S2;
	Tue, 03 Jun 2025 20:28:03 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 28/36] mmc: ushc: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:27:52 +0800
Message-ID: <dde4d49481fe0cc6bd3289e9bd4b33433eb27cea.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMRS6j5oLw8HAQ--.25132S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF48Jr43Gr13JF48Jw4rCrX_yoWDurX_Cr
	yFqrnrWr1UCr93Wwn8Kr4fWrWftF4qgrn3ZF1SgayYya4vqan5GF17Zrs5Zr1fZr47AFW5
	Zw4UJrySvry2qosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb38YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r45tVCq3wAv7VC2z280aVAF
	wI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvrVCFI7
	AF6II2Y40_Zr0_Gr1UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73
	UjIFyTuYvjxUvG-eUUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/ushc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
index 9a6358fd9512..2b7456e942f7 100644
--- a/drivers/mmc/host/ushc.c
+++ b/drivers/mmc/host/ushc.c
@@ -404,8 +404,6 @@ static void ushc_clean_up(struct ushc_data *ushc)
 	kfree(ushc->int_data);
 	kfree(ushc->cbw);
 	kfree(ushc->csw);
-
-	mmc_free_host(ushc->mmc);
 }
 
 static const struct mmc_host_ops ushc_ops = {
@@ -425,7 +423,7 @@ static int ushc_probe(struct usb_interface *intf, const struct usb_device_id *id
 	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
 		return -ENODEV;
 
-	mmc = mmc_alloc_host(sizeof(struct ushc_data), &intf->dev);
+	mmc = devm_mmc_alloc_host(&intf->dev, sizeof(*ushc));
 	if (mmc == NULL)
 		return -ENOMEM;
 	ushc = mmc_priv(mmc);
-- 
2.47.1

