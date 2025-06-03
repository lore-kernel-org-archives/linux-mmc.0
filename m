Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7542231828
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953591; cv=none; b=L/Go8VBZRBR2wK9mg/hXhaQWO6Cxpbxc0AQ5ISoNJGKGzh96DmR4CXqMlfEufB9ioTpveEP32AQrzHKcUNli1oCA6iKpAQe8Ut2esU3ZDiBjrCyb77LpYIONC3iunQfm+auPZAZAx4m9MQeCjH4BmXJYk2S6pVhE/wi6SWvO4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953591; c=relaxed/simple;
	bh=5H7gtOo3jCK5NZiJRalER5a/AaiPIkWHkuqenrwqkHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2Dyt4K3X+9y5nbycdhDuMZBtdtl2K9FAvUBOOnjI6rTEkuxjWQG0BXzh2uDj7uLYVKimNbHubccpv4xHoIWSiEcVhkRj9vombmqwv3L6cFZW4YAjNJE/mOw0ozLFtUvFEyEtUj7RwGKO0BZfiD3hkYATo5CtEmOCXb76x5nLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxYa_06T5oszUKAQ--.58565S3;
	Tue, 03 Jun 2025 20:26:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3MTx6T5oNQ4HAQ--.23320S2;
	Tue, 03 Jun 2025 20:26:26 +0800 (CST)
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
Subject: [PATCH v3 10/36] mmc: litex_mmc: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:26:11 +0800
Message-ID: <8eea32bf0fb1ac95497355ccd5ea732ce619238c.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBx3MTx6T5oNQ4HAQ--.23320S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw18CFWrXFW7GrWDZFWDtrc_yoW8WryUpF
	43GFyakrW3GF45WryUJ3yq9Fy8Ww4Sva4Dt398Gwn5Xas0yryDKFyDCay7tF95GFyvyF4f
	XFWUCrn5ua1UAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
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
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Acked-by: Gabriel Somlo <gsomlo@gmail.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
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

