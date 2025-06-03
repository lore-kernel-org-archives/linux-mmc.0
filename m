Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46BD1B393C
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953720; cv=none; b=uAtKmOE/BcVdgGYiIyOKKUsBqdIuCL13F4dLkoLDHp4hsDry1bwTROemw4vlgyVoV7dfOLNI1Y2mbKyUCEFUo0UC60aRdLRlJzdVNPx6IkN+2EjB+p7mXrnFI/jqomcFCgAsnbBdJ7Dew9TVFKZsyGFgveI+6O5uYoVk3xI/xHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953720; c=relaxed/simple;
	bh=WPKsYfBAGHlmnhzA64MhEHjJ1ndlu6vUzmhwDRHiZWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVxOS3FCdUnGLK5XgOL8eiGxFzaHzdboUlorRUpugwAWpkYfk9JPIqK1Mm0XSMZIGqVQ/PQKtN2L3h3IKwNnpycGkfyoOwEmmA9TOHyiV71bl6jsQpng9rFBT/hQ6SnSriVk8ESkdhD+NB964psY4wIzhTkvdBuwlmlNOg9zw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxnOJ16j5o8zYKAQ--.63576S3;
	Tue, 03 Jun 2025 20:28:37 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxj8Vv6j5ofg8HAQ--.25897S3;
	Tue, 03 Jun 2025 20:28:36 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 35/36] mmc: mmc_spi: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:28:21 +0800
Message-ID: <3f1127f02ffd7f1cc09122fd0d3c71473a030a53.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxj8Vv6j5ofg8HAQ--.25897S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF48Jr43Gr1xKFyfWw47WrX_yoWkuFg_Cr
	yFqrn7ur48Cry0qr1UKF1SqryrKr4qgFsY9F1aqws5tr1fX34kC3WfZFs8ArWUZw4qya1f
	Zw43Jr1xC347AosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb38YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r45tVCq3wAv7VC2z280aVAF
	wI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvrVCFI7
	AF6II2Y40_Zr0_Gr1UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73
	UjIFyTuYvjxUvG-eUUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/mmc_spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 47443fb5eb33..35b0ad273b4f 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1185,7 +1185,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 		goto nomem;
 	memset(ones, 0xff, MMC_SPI_BLOCKSIZE);
 
-	mmc = mmc_alloc_host(sizeof(*host), &spi->dev);
+	mmc = devm_mmc_alloc_host(&spi->dev, sizeof(*host));
 	if (!mmc)
 		goto nomem;
 
@@ -1305,7 +1305,6 @@ static int mmc_spi_probe(struct spi_device *spi)
 	kfree(host->data);
 fail_nobuf1:
 	mmc_spi_put_pdata(spi);
-	mmc_free_host(mmc);
 nomem:
 	kfree(ones);
 	return status;
@@ -1328,7 +1327,6 @@ static void mmc_spi_remove(struct spi_device *spi)
 
 	spi->max_speed_hz = mmc->f_max;
 	mmc_spi_put_pdata(spi);
-	mmc_free_host(mmc);
 }
 
 static const struct spi_device_id mmc_spi_dev_ids[] = {
-- 
2.47.1

