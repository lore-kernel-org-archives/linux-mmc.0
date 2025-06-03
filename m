Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB023182D
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953675; cv=none; b=cqgUP3aj8uodF5Fg2DXlteHqJDPXElnk3odlCnxaaQKRM0mLU2VzkMVRycHNmACI0Fx6xr8tOSEIakLMsnYPVAeGr2PRsL9dAdD5UU6qxjKv2Khao5+hbaLqFcXh020G52q2nx8n28lW9/HVWnWphGgGBcUL9MIUPVPf0AAEPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953675; c=relaxed/simple;
	bh=eDVkwh8bYvYp181LnaxDTCaEvFJafXRydxC6apjTKzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUyCccCGhlsf07vFByl9Nd0qnBviwsTLJF4F7RyEl8EkvdfS972nm3+UdPETVzkU818RRFbZyJyJjgkaGBSMZobBDh+yION22wEUmDuhkmiSBQuDrq4cJK252IyAf0FnQ2QFh6EAZwCb6zJT44ToMiC6vEO2RPNByqHg4hcr5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxeXFI6j5ojTYKAQ--.32574S3;
	Tue, 03 Jun 2025 20:27:52 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxDcVE6j5o8A4HAQ--.21232S4;
	Tue, 03 Jun 2025 20:27:51 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 26/36] mmc: toshsd: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:27:36 +0800
Message-ID: <23c80160c93c868353d2444100a592e8ba5d2f90.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxDcVE6j5o8A4HAQ--.21232S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWfZw4xJF45Zw18XF1UJwc_yoW8JFyUpF
	WfJa4YkrWUJr15Wa4UJa4UuryrWrWIv3yrGFW0vw1xW3s8Aa4vqrs7CFy2qF1rJFWvyF13
	ZayUtr1F9F1Ut3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y40E4I
	xF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU5gFxUUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/toshsd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
index 497791ffada6..e5f7f8abafc0 100644
--- a/drivers/mmc/host/toshsd.c
+++ b/drivers/mmc/host/toshsd.c
@@ -612,7 +612,7 @@ static int toshsd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
-	mmc = mmc_alloc_host(sizeof(struct toshsd_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc) {
 		ret = -ENOMEM;
 		goto err;
@@ -669,7 +669,6 @@ static int toshsd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 release:
 	pci_release_regions(pdev);
 free:
-	mmc_free_host(mmc);
 	pci_set_drvdata(pdev, NULL);
 err:
 	pci_disable_device(pdev);
@@ -685,7 +684,6 @@ static void toshsd_remove(struct pci_dev *pdev)
 	free_irq(pdev->irq, host);
 	pci_iounmap(pdev, host->ioaddr);
 	pci_release_regions(pdev);
-	mmc_free_host(host->mmc);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
 }
-- 
2.47.1

