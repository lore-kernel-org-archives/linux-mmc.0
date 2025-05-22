Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0AC1AD3E0
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897175; cv=none; b=oPrYUd+yyfvib6s3zgOrI1/byPEwwDoIcdwFaNrcue2ZKjAtpIh4wDV1hB2p2oe4pRTz3fLy7P045vKdZo/0yvPeeCwgwPz1/VwJpi7phuZW9qEitRO1xKwUYNeEDXCvfve679mvw1053QpWZmCll58bkalrACsCVZ+NT0AJ1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897175; c=relaxed/simple;
	bh=0MTnneG8nqGcMGvB/u++zu269wOFi5QDUjPiPshNvvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyQUfh7jaUMdqULmEFQzk+Z3nZlFG3TEJ6I+zwIRT+dQcok/VO5UQP0qeaeta7XygwyQUG0QYQrricC5u+w/UKaFHTCJH3z0AG5eZhETlLwM8MPul8Elw2zspdMakXo9uuA1jdcyBLUuUYAGms9pqjkm9RdGzIYpHh875yivaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxbWtUyy5o1yH2AA--.4604S3;
	Thu, 22 May 2025 14:59:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3MROyy5otXHnAA--.2109S5;
	Thu, 22 May 2025 14:59:31 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2 03/36] mmc: au1xmmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 14:59:19 +0800
Message-ID: <2b3e8eabb5d91d70c40f280ec72ba8a2e0c26bf2.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBx3MROyy5otXHnAA--.2109S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1DZr1fJFy8Wr1fuF1Dtwc_yoW8Aw1DpF
	yfJa43K3yDtF45WrWUJ3sru3WrZr1xt3y8G3y8Jwsaqa45trWDtrn5CFy09FyFyFyvkF43
	WFW8Jr18CFsrXFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5l1kUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/au1xmmc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 057d42307832..85470773650d 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -937,11 +937,10 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret, iflag;
 
-	mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc) {
 		dev_err(&pdev->dev, "no memory for mmc_host\n");
-		ret = -ENOMEM;
-		goto out0;
+		return -ENOMEM;
 	}
 
 	host = mmc_priv(mmc);
@@ -953,14 +952,14 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&pdev->dev, "no mmio defined\n");
-		goto out1;
+		return ret;
 	}
 
 	host->ioarea = request_mem_region(r->start, resource_size(r),
 					   pdev->name);
 	if (!host->ioarea) {
 		dev_err(&pdev->dev, "mmio already in use\n");
-		goto out1;
+		return ret;
 	}
 
 	host->iobase = ioremap(r->start, 0x3c);
@@ -1109,9 +1108,6 @@ static int au1xmmc_probe(struct platform_device *pdev)
 out2:
 	release_resource(host->ioarea);
 	kfree(host->ioarea);
-out1:
-	mmc_free_host(mmc);
-out0:
 	return ret;
 }
 
@@ -1151,8 +1147,6 @@ static void au1xmmc_remove(struct platform_device *pdev)
 		iounmap((void *)host->iobase);
 		release_resource(host->ioarea);
 		kfree(host->ioarea);
-
-		mmc_free_host(host->mmc);
 	}
 }
 
-- 
2.47.1

