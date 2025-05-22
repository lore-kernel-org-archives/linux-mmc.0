Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457922156E
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897258; cv=none; b=etl7IAyw0K9dJlgR9nxOcVFt4U1tkBuC5HofBBdJ3xEXSLuKofmDELnAlPrBqynpGsmDvBXOOOcKiiM68pdN71Qx6r0WNfLzOXfWotdOmcyW6g5slYitf4IMCulwu+Frc6tCCrApvc+UkwW/0Q7K0BA/y1I27JVibBE20MS8FZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897258; c=relaxed/simple;
	bh=3nMEEDtD8WAV22pHQ1VyPTCnTu4WVmNeZfMxFNYFQL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfiJh1nF4ojz+KA7Hv4MwJ6DZzVrcAcbYeEfPmkfQuTu0+eKuH12DgP5rwb0R+C+Gn22Xq00cqIjaGzZar6o7FaeFMpcJSgBTQUUD/GTxIaHmF4JOcMXLPkdfQgjAjLsul1Q9g45Vm1H9GtwnlM0BSrJv7cudhldy57iK21po0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx63Gnyy5oxiL2AA--.4610S3;
	Thu, 22 May 2025 15:00:55 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx_calyy5oZ3LnAA--.8457S3;
	Thu, 22 May 2025 15:00:54 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Alex Dubov <oakad@yahoo.com>
Subject: [PATCH v2 25/36] mmc: tifm_sd: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:43 +0800
Message-ID: <a9f54172b8733e6d31f8e8bcb169d2fe57f2c875.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx_calyy5oZ3LnAA--.8457S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr47WrWrXF1kZr1ktry3WrX_yoWkZFcEk3
	y0qFn2gry8AFZ8W34Ykr1fZry5tw4vgr4q9F1rtw43AF1Iq3s5GFn7Zrn8ZrWUuws8CFWr
	Aw1rJr1xZFyDWosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb38YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26Fy26r45twAv7VC2z280aVAF
	wI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvrVCFI7
	AF6II2Y40_Zr0_Gr1UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73
	UjIFyTuYvjxUg5C7UUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Alex Dubov <oakad@yahoo.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/tifm_sd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 713223f2d377..92b438003576 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -947,7 +947,7 @@ static int tifm_sd_probe(struct tifm_dev *sock)
 		return rc;
 	}
 
-	mmc = mmc_alloc_host(sizeof(struct tifm_sd), &sock->dev);
+	mmc = devm_mmc_alloc_host(&sock->dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -982,10 +982,7 @@ static int tifm_sd_probe(struct tifm_dev *sock)
 
 	if (!rc)
 		rc = mmc_add_host(mmc);
-	if (!rc)
-		return 0;
 
-	mmc_free_host(mmc);
 	return rc;
 }
 
@@ -1015,8 +1012,6 @@ static void tifm_sd_remove(struct tifm_dev *sock)
 	spin_unlock_irqrestore(&sock->lock, flags);
 	mmc_remove_host(mmc);
 	dev_dbg(&sock->dev, "after remove\n");
-
-	mmc_free_host(mmc);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.1

