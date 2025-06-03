Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355C22B5B8
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953553; cv=none; b=X/ilGVf7haFfKiNQm++jnoJoDxncpUsqka9HfIDccKOHDuFn1edga0rtTwFKhPowYVt6sdFoFP+HazuhxVjq2qmc4atsONFZDdkmTlEu6t/vIcC3jcHN3OHweIpqBicCpfGgq46OaRZCqUl05AHj7vsuP3ImLe3lKCisbGUQOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953553; c=relaxed/simple;
	bh=DVMANO8zdpJp4Sd49rCKAnT2bobgHfOTqQXuZGHfCSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw7GpDtBQB/y4iGG+uJJfmNpFQlbd2csU4hFJ0jbp45LqYSh9gSOMhRvqLwYhKs9IUio78RbKjg16NAqYYTe/3NpgYSjn/MQhS+5brJvEg28Y6EdRpFZNCMnuDNgDRbCb6qBq6DPS4vxaZbGFeWs226U+nOWHi4uYY8fcq+H1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxquDO6T5oXzUKAQ--.57685S3;
	Tue, 03 Jun 2025 20:25:50 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxXsXJ6T5oAQ4HAQ--.25382S3;
	Tue, 03 Jun 2025 20:25:50 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Robert Richter <rric@kernel.org>
Subject: [PATCH v3 05/36] mmc: cavium: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:25:34 +0800
Message-ID: <9a7715ac3045d925cf2e88e23dca7acb17376468.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBxXsXJ6T5oAQ4HAQ--.25382S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFW3XFW3Ww15Jr4furW7GFX_yoW8XF17pF
	4rAas0krWrJF4FkwnIva18GFyYqw1vgFWkKayIgwnYvr17Kr1DKFn5CFyUtF95AF90gFyx
	XF4DGrWUuF43JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Robert Richter <rric@kernel.org>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
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

