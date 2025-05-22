Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3882D221F38
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897229; cv=none; b=QQ6Oci3gGmjDIP84XO/GXwzJSFV5yuhrag9MzkVQ2E3y7lsf5HW4KJ3ymKYI/7HxUhDehcMY392NuzXG7JdsZU69p2ulXDLta13sEjRR0w7Qm68WJdZv6xUtWsxZZuxD/YE4P9gqJQ6JzIgwEu/+V7wL6CODww6c1DBHNG3Vxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897229; c=relaxed/simple;
	bh=dJi9+XYQIm30AlxCKQQIb11GsQ8b1uiQ0M5VCtLFvj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwszvaC1tonQ4KkhgE6PE+icL3XCMRvdQ1QdfUkxoORiI01Oqm/GV0cbxpq4l4Akq1JIGtRrbYwvi4/OoNKyaaWiWD+SAUpluOXxJbgoqjlGhm1gwxh0OMZiI/Ws9xbgGeRZnt1ATeyuKakkba2ro6TywR7kGfXDIV3RlNd80vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxaeGHyy5ocyL2AA--.26468S3;
	Thu, 22 May 2025 15:00:23 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMSDyy5oMHLnAA--.4625S5;
	Thu, 22 May 2025 15:00:21 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH v2 17/36] mmc: omap: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:11 +0800
Message-ID: <fe389dc0ba1b2b37d2f9c89c0bb7f35885dd6c7d.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMSDyy5oMHLnAA--.4625S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw4fZr17ZFWfXFykZw18Zwc_yoW5Jw18pF
	sYvas7KFyUAr43WrWUJa1kXa4rZr1xKay8G3929w1xXr13AryDKasakFyFvF95CF9Yvw4a
	qFW5XrW0kFZxXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x07j4GQhUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Allen Pais <allen.lkml@gmail.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/omap.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index c50617d03709..57699095ae68 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1258,7 +1258,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	struct mmc_host *mmc;
 	int r;
 
-	mmc = mmc_alloc_host(sizeof(struct mmc_omap_slot), host->dev);
+	mmc = devm_mmc_alloc_host(host->dev, sizeof(*slot));
 	if (mmc == NULL)
 		return -ENOMEM;
 
@@ -1272,25 +1272,21 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	/* Check for some optional GPIO controls */
 	slot->vsd = devm_gpiod_get_index_optional(host->dev, "vsd",
 						  id, GPIOD_OUT_LOW);
-	if (IS_ERR(slot->vsd)) {
-		r = dev_err_probe(host->dev, PTR_ERR(slot->vsd),
+	if (IS_ERR(slot->vsd))
+		return dev_err_probe(host->dev, PTR_ERR(slot->vsd),
 				     "error looking up VSD GPIO\n");
-		goto err_free_host;
-	}
+
 	slot->vio = devm_gpiod_get_index_optional(host->dev, "vio",
 						  id, GPIOD_OUT_LOW);
-	if (IS_ERR(slot->vio)) {
-		r = dev_err_probe(host->dev, PTR_ERR(slot->vio),
+	if (IS_ERR(slot->vio))
+		return dev_err_probe(host->dev, PTR_ERR(slot->vio),
 				     "error looking up VIO GPIO\n");
-		goto err_free_host;
-	}
+
 	slot->cover = devm_gpiod_get_index_optional(host->dev, "cover",
 						    id, GPIOD_IN);
-	if (IS_ERR(slot->cover)) {
-		r = dev_err_probe(host->dev, PTR_ERR(slot->cover),
+	if (IS_ERR(slot->cover))
+		return dev_err_probe(host->dev, PTR_ERR(slot->cover),
 				     "error looking up cover switch GPIO\n");
-		goto err_free_host;
-	}
 
 	host->slots[id] = slot;
 
@@ -1350,8 +1346,6 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 		device_remove_file(&mmc->class_dev, &dev_attr_slot_name);
 err_remove_host:
 	mmc_remove_host(mmc);
-err_free_host:
-	mmc_free_host(mmc);
 	return r;
 }
 
@@ -1369,7 +1363,6 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 	flush_workqueue(slot->host->mmc_omap_wq);
 
 	mmc_remove_host(mmc);
-	mmc_free_host(mmc);
 }
 
 static int mmc_omap_probe(struct platform_device *pdev)
-- 
2.47.1

