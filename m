Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF963BBC9
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897272; cv=none; b=r9b7aoIsyNtJM0zVCSQ+uNIMTeRjCoCUgJo8iKtazshrH2YH2GOc4VuSSAYwqXykcXEm7MxgMPdkcW3aeT7m30Nedmm0uprH5zBtgjYXk50um3fQei1Q0JCqun2N/cpUuBC8KUbPxiR8rqZCe6F7tVX+lL1jm/PV0xZX6AnEhmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897272; c=relaxed/simple;
	bh=EwSCQngrGkwW0AvpDvdiir1wQ5EjKCIazioB4GMep6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTWa3/eORkS2VHN47hvGMfaxKKdW7FC65Xp+c6dhuRQLDQtOydJfQM2PJG1HJl1bORKvFsbPbZ68aac70/xVo+Xc51x3E28LLFvbiXF4xLc3h57npzSQqUa5VE5IQHG0arheRjjeekIw/HrRb9EyYHNJe8r/z4o8YY3kYsCmgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxLHK1yy5o5iL2AA--.35391S3;
	Thu, 22 May 2025 15:01:09 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzxuzyy5ofHLnAA--.16960S3;
	Thu, 22 May 2025 15:01:09 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 29/36] mmc: via-sdmmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:57 +0800
Message-ID: <e5accaa377b6e7226c0ed3121815a70e344816fa.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzxuzyy5ofHLnAA--.16960S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4DJF4rWryfXF1kCFyfuFX_yoW8WryDpF
	WfXa9rKr4DJFn8u3yDGa1UWr1rX3W0y3yfKFWYgws3ZF9Iv3Wqqr1kuFyFqFWxAFWkJF17
	XF4DJF15u3WUJabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8Xw0E3s1lYx0Ex4A2jsIE
	14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y40E4I
	xF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IUYfsqJUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/via-sdmmc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 909d80a02824..083ab9836311 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1100,7 +1100,7 @@ static int via_sd_probe(struct pci_dev *pcidev,
 	pci_write_config_byte(pcidev, VIA_CRDR_PCI_WORK_MODE, 0);
 	pci_write_config_byte(pcidev, VIA_CRDR_PCI_DBG_MODE, 0);
 
-	mmc = mmc_alloc_host(sizeof(struct via_crdr_mmc_host), &pcidev->dev);
+	mmc = devm_mmc_alloc_host(&pcidev->dev, sizeof(*sdhost));
 	if (!mmc) {
 		ret = -ENOMEM;
 		goto release;
@@ -1115,7 +1115,7 @@ static int via_sd_probe(struct pci_dev *pcidev,
 	sdhost->mmiobase = ioremap(base, len);
 	if (!sdhost->mmiobase) {
 		ret = -ENOMEM;
-		goto free_mmc_host;
+		goto release;
 	}
 
 	sdhost->sdhc_mmiobase =
@@ -1160,8 +1160,6 @@ static int via_sd_probe(struct pci_dev *pcidev,
 
 unmap:
 	iounmap(sdhost->mmiobase);
-free_mmc_host:
-	mmc_free_host(mmc);
 release:
 	pci_release_regions(pcidev);
 disable:
@@ -1212,7 +1210,6 @@ static void via_sd_remove(struct pci_dev *pcidev)
 	writeb(gatt, sdhost->pcictrl_mmiobase + VIA_CRDR_PCICLKGATT);
 
 	iounmap(sdhost->mmiobase);
-	mmc_free_host(sdhost->mmc);
 	pci_release_regions(pcidev);
 	pci_disable_device(pcidev);
 
-- 
2.47.1

