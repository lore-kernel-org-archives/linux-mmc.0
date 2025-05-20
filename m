Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F83E27E7F4
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741623; cv=none; b=jvFG63PKy2hhFUjacpN1K4m6SZQ8yhBu6djSPM+zS/a1acbtB10VPAYOXD3feB82uMz8k23kryvvvqL/N6aOge5Xg691HR5FSzVM560/BwJB4+goyEVY1/cwaX8Q+z0SOwm5dmcW6Tz84KG23/YWOKiXLp2p4c2XErruTRIEzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741623; c=relaxed/simple;
	bh=4/sz4zPGycuS+pPVnJvav6eibzPsFOAg4byIi/l6NaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNYhOkdQPadmeyvDWGNFtTK6vAbQWk0ZOWmK+LPv5KzwoUrGp8e2HWVvhkbRDkYCXtG1JhbxReudht6a2zFPPPWdXAPGOmU1AYQQ1nzXJXZBrAMzVSlyHYhTJ011rFsZBojjcembaEOWMCcoqwPr0UqMiZ1pp0NcHlaDQ1Hxi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxyuCzayxoIF7zAA--.586S3;
	Tue, 20 May 2025 19:46:59 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxPsewayxoyzvjAA--.60649S2;
	Tue, 20 May 2025 19:46:58 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 28/36] mmc: ushc: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:46:48 +0800
Message-ID: <e8ae0e905b92adbc93f95654a0508d4c2a82a142.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxPsewayxoyzvjAA--.60649S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jr4kXrW5XF15Gr4UuFy7CFX_yoWDXFX_uF
	yYqrnrWr1UCr93Wr1kKr4fWrWSyF4qgrn3ZF1SqayYya4vqFs5CF17Zrs5Zr4fZr4xAFZ8
	uw4rJryS9ry2qosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
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

