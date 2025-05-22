Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07C221DA1
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897215; cv=none; b=CZlA3OYD8G8mRy5QB/+Ot3OGvq19/Yu7tL0tS0r0uVQvQk/25MXGxavxkbl8N8gjAV6VhfA22v4QOv+MJzXboPuWek2Ml/B00hzvF7c5J32ck4YM8a2RujlxZAjZdRl396G8ZYAs2XT52TT7bMU9QWTztAEimUXhLqCCS/GtrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897215; c=relaxed/simple;
	bh=XSaa54ej+osETIcZo7OBgYIilFL2nsRFTNC852p8bys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEz6FKP0l8bSOE/DhoBwVg9XO7qpg8EmUiz7hw3EG+fDGEAByhXqPSQqEcp6E9Bihbv9E6rhj417CaGdDkIAXrH48KmEaK0LgIJmyq18ZbqnmdBp/ZhAL2HSFys36j97aAPrZ0FlElYtzSnTwkzD3VO9/N60dl/5bALXfwftLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxbWt4yy5oPiL2AA--.4608S3;
	Thu, 22 May 2025 15:00:08 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcV1yy5oEnLnAA--.499S2;
	Thu, 22 May 2025 15:00:05 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 10/36] mmc: litex_mmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 14:59:51 +0800
Message-ID: <692dc1743391fc4b3c107db5211107b5041ff100.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxLcV1yy5oEnLnAA--.499S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw18CFykJry5Gry8JF4xuFX_yoW8Xw18pF
	s3CFyakrW3GF45W3yDJ3yq9Fy8Wr4S9a4Dt398Gwn5Was0kryDKF98Cay7tF95JFWvyF4f
	XFWUCrn5ua1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0fhLUUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Gabriel Somlo <gsomlo@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/litex_mmc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index b338ccfa8f33..d2f19c2dc673 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -506,11 +506,6 @@ static int litex_mmc_irq_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void litex_mmc_free_host_wrapper(void *mmc)
-{
-	mmc_free_host(mmc);
-}
-
 static int litex_mmc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -525,15 +520,10 @@ static int litex_mmc_probe(struct platform_device *pdev)
 	 * If for some reason we need to modify max_blk_count, we must also
 	 * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
 	 */
-	mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
-	ret = devm_add_action_or_reset(dev, litex_mmc_free_host_wrapper, mmc);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Can't register mmc_free_host action\n");
-
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
-- 
2.47.1

