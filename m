Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABB27E7E6
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741523; cv=none; b=i16jgtk9uu5mKsRookW1wwYfilyY0xGiZmHq2WrNdfgslggY5ZSoJTwd/ipSUncf0VX99kfz3q3X8Z3TE5ZHNNFB967SPmMMJqKjqqngo4J5+AYsT3oJYcIUP9qFIU/pw3xh764DWgh/6s/QDDp+peVx8QJkmFjv0Kgt49icvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741523; c=relaxed/simple;
	bh=5joksnLKFcstcrbtXrSqIONbuInVjTisD9OhIe8HHjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOPNUhrdmpwyHx4qlFvpnk5hg7SgAECP0UCKqDI7H+VhLkbyOBTAMx0PjL8ajYRvEd8dAGmVoaCoBY1eybqRT7SnC3/i++jmpDKO8O6BDWf6KbQxNks9WA9sqEhrOGNeThNzz6moIam4RSRxXKKzniQHGAsyQ+IDzX+xqbC+Y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Axz3NQayxoYV3zAA--.65219S3;
	Tue, 20 May 2025 19:45:20 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxH+VNayxoLzvjAA--.57170S3;
	Tue, 20 May 2025 19:45:19 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Robert Richter <rric@kernel.org>
Subject: [PATCH 05/36] mmc: cavium: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:45:06 +0800
Message-ID: <e1ba17d07f8ce7cc8613113a7618a21782ff1863.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxH+VNayxoLzvjAA--.57170S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFWrCFy7KF1xXF4fury8WFX_yoW8Gw4DpF
	4rAas0krW5JF4FkwnrZa18GFyYqw1vgFWkK3yIgwn5Zr17Kr1DKFn5CFyUtF95AF98WFyx
	XF4DGrWUur43JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Robert Richter <rric@kernel.org>
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

