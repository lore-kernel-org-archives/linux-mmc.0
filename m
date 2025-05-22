Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628EB1A76AE
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897186; cv=none; b=i5XDPFWLaUTLKZIWU1ZI22FLheUl73eyM3eJsqq0xYSwSx6uuu5cKldLPE5lZJVTLJCKef8vrV6FnUxCFmjN9h9Q80onZ7CwfCPO+19diUZRRoVuayI/Oen66lTNMiK4DnVmFy2KTks4NRZGpVAQNkXoANAl1Cqof/XHOu52n18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897186; c=relaxed/simple;
	bh=Nj73ZNbPVLXBHcRHN1KBSrpX5XkA1l+ZyJk6GMefZwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8Xq86+IMREa/pW38veql3ZOo5+ESM5yDNWHaIhXnyBcKM9r7KLJSZdElGLGYuG5G8wpoqw2Kny2pfo3Wwvcrurqhpz35y0F9wmZbu3QQTGfMDsI3bgfRdlFLRfpqsQxUqncDXozJ96n2RnF+J7xNgAUn+fbdg7+QDmgwsWH6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxXWteyy5o6iH2AA--.4576S3;
	Thu, 22 May 2025 14:59:42 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcVdyy5oznHnAA--.496S3;
	Thu, 22 May 2025 14:59:42 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Robert Richter <rric@kernel.org>
Subject: [PATCH v2 05/36] mmc: cavium: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 14:59:30 +0800
Message-ID: <9156b2ba2b5a54051aa14766d1261606bea273aa.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxLcVdyy5oznHnAA--.496S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4DJF43tw48uw4kXF4DZFc_yoW8XF17pF
	4rAas0krWrJF4FkwnIva18GFyYqw1vgFWkKayIgwnYvr17Kr1DKFn5CFyjqF95AF90gFyx
	XF4DGrWUuF43JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Robert Richter <rric@kernel.org>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/cavium.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 95a41983c6c0..9a55db0e657c 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -1012,7 +1012,7 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	struct mmc_host *mmc;
 	int ret, id;
 
-	mmc = mmc_alloc_host(sizeof(struct cvm_mmc_slot), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*slot));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -1022,7 +1022,7 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 
 	ret = cvm_mmc_of_parse(dev, slot);
 	if (ret < 0)
-		goto error;
+		return ret;
 	id = ret;
 
 	/* Set up host parameters */
@@ -1066,12 +1066,7 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	if (ret) {
 		dev_err(dev, "mmc_add_host() returned %d\n", ret);
 		slot->host->slot[id] = NULL;
-		goto error;
 	}
-	return 0;
-
-error:
-	mmc_free_host(slot->mmc);
 	return ret;
 }
 
@@ -1079,6 +1074,5 @@ int cvm_mmc_of_slot_remove(struct cvm_mmc_slot *slot)
 {
 	mmc_remove_host(slot->mmc);
 	slot->host->slot[slot->bus_id] = NULL;
-	mmc_free_host(slot->mmc);
 	return 0;
 }
-- 
2.47.1

