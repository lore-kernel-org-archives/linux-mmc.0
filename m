Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB048230BC9
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953629; cv=none; b=kGkEcS4HQUu9N7bIJvFqCwJkbuVhVY664Hot/i0jZah0Kw1mmxUAs4UXHFnrL1Pd96KIx+bctCik6T6Z9BGNh3kJQU88NyTQ5rVSxAIhcw9u8IrsczXifO/cv+IY8LqaQfAorG0sRO+PtTr24Ivuw2kdeB8tYCvgbRqr5rezLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953629; c=relaxed/simple;
	bh=uKUtvVgcE1wvi8/0LdX9Mn4vARfDlOZd9TimsxqxDcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHuXRwCb8y1zvhZu4ZDMehojCXIrMIOm9NjVM1YgyUKTQES6VBj4tl4aBOejERkG8cgbbJnWmoAmaBxP9WeTH3PJ2ok97xQTuYHKcJakiGEwZMo+0JW2sQ5r5fO1WPlWYl/6Ws1nNfbDk3fLjp78EUVpM6Htf9uRFBWBE4JRVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxYa8a6j5oDjYKAQ--.58570S3;
	Tue, 03 Jun 2025 20:27:06 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxj8UR6j5ofA4HAQ--.25877S5;
	Tue, 03 Jun 2025 20:27:05 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH v3 17/36] mmc: omap: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:26:33 +0800
Message-ID: <f172097638a161d622dcbfbc1ede6d4bb8aeea0c.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxj8UR6j5ofA4HAQ--.25877S5
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
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
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

