Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0E27C87E
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741514; cv=none; b=BAdSKlVt75YQwIueKG4cLIjgjqshWre265ux8bHjZAaoy/9iEF664MLMbiCn3bKMvZ5N7NDs55eyaVHfLea3XPGoHhE+ZKwB+0pTdZR1GUVo2cuYnSoCFy+ULHbpr5CeiyxtoPgQvl0/yTHbbEhJYI8yoU3PRmwmVvVUWGlcO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741514; c=relaxed/simple;
	bh=Xm7awgsoYHdebx2/VeZvKM5GHEOHPchFxPEaRSVxd2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5osuTeJSnt/Cd32YuqvLVo6OBvLATqsxrIlcdw9AzffkOWKsRNnd1uUa+qSlbQ1g0z1rAF9jcVfNEtQB4B3CWPuWf+OgPLyVubYfQAeOs81voXD/yyP/vXJ33LTTzQN8APlmaVm6jGNtV+prUajnXEfMIbbNspMtkYhhUaBzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx7eJAayxoR13zAA--.30533S3;
	Tue, 20 May 2025 19:45:04 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxPcU9ayxoEzvjAA--.56744S3;
	Tue, 20 May 2025 19:45:04 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Feng Wei <feng.wei8@zte.com.cn>,
	Shao Mingyin <shao.mingyin@zte.com.cn>
Subject: [PATCH 01/36] mmc: alcor: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:44:50 +0800
Message-ID: <4ce6a9d1611932d970e81cfa1724a18bf22a69f7.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxPcU9ayxoEzvjAA--.56744S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFyrGw4DJF4kXFW7KF4UGFX_yoW8ZF13p3
	W5Xa47KrWUJr1Yg34DKa1DZa45Ww1Sq3y2g3yIv34kC3s0vrWDtwn5CFy0qFZ5GFWkJF4x
	WF4DZrW8CF1DZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Feng Wei <feng.wei8@zte.com.cn>
Cc: Shao Mingyin <shao.mingyin@zte.com.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/alcor.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 24abd3a93da9..288c3a91a0af 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1084,7 +1084,7 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	struct alcor_sdmmc_host *host;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc) {
 		dev_err(&pdev->dev, "Can't allocate MMC\n");
 		return -ENOMEM;
@@ -1102,11 +1102,9 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, priv->irq,
 			alcor_irq, alcor_irq_thread, IRQF_SHARED,
 			DRV_NAME_ALCOR_PCI_SDMMC, host);
-
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to get irq for data line\n");
-		goto free_host;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to get irq for data line\n");
 
 	mutex_init(&host->cmd_mutex);
 	INIT_DELAYED_WORK(&host->timeout_work, alcor_timeout_timer);
@@ -1115,15 +1113,8 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	alcor_hw_init(host);
 
 	dev_set_drvdata(&pdev->dev, host);
-	ret = mmc_add_host(mmc);
-	if (ret)
-		goto free_host;
 
-	return 0;
-
-free_host:
-	mmc_free_host(mmc);
-	return ret;
+	return mmc_add_host(mmc);
 }
 
 static void alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
@@ -1136,7 +1127,6 @@ static void alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
 
 	alcor_hw_uninit(host);
 	mmc_remove_host(mmc);
-	mmc_free_host(mmc);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

