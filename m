Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7EE35893
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897271; cv=none; b=CqdRN+mYq7NOdxwIzqH2fI+6n2VcZgmsL07lIMLgv1E7hG3BIAA4jf6jpbgOZL62cQSzJ/VN8zc/UjKzGhOA6S5ifNUPa3Qieh6ruBJY8oqMKlq8aOjVyrrY9REVr5RMP6KXYjwh5IWd6Gd7fZsEm0aCrEttCl7vb6DZQ+JIRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897271; c=relaxed/simple;
	bh=4DhANkl2SLTaxs/vjkfUXlN9HEyIYacuQbCW4s6WAbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUBQwyyRXSWDPjyGo6ibR/fkO//BB5iLXQoS45dDj882BUJTUy14r8Jx4a3FlxYIIgv8iuimBVcVR6/iodlp+BikoXiIJzRafP01WQI4rPh6MqKu2Sg7NwoBGYM3mL3Hz8Fd8COPciGxvk+hwjsdiF+ef9QIXVRaSlQxiruGri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxIK+0yy5o4iL2AA--.2574S3;
	Thu, 22 May 2025 15:01:08 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzxuzyy5ofHLnAA--.16960S2;
	Thu, 22 May 2025 15:01:08 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 28/36] mmc: ushc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:56 +0800
Message-ID: <7e927fac03edb8c987531f467a7f07b1ec98ab36.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzxuzyy5ofHLnAA--.16960S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jr4DAw1rXF15tr4rAr4UWrX_yoWDurX_CF
	yYqrnrWr1UCr93Wwn8Kr4fWrWSyF4qgrn3ZF1FqayYya4vqFs5GF17Zrs5Zr1fZr47AFW5
	Zw48JrySvry2qosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
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

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
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

