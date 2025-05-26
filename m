Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CEC145346
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239549; cv=none; b=PBwllfAF3yJFffgcJS4G3ZlyIWsjEoAej4ST8dwYhwnNWqeQvP0qpPtojnyAzl1hOhsnJBhWwjMwoh3+AQwUFxbBN/wA/iskUpvnt17cDrIbiU1n+IOJhgoAbwcPW9V4rdZrwakIhwreii8ZHlxP0n/GUuOV+eMAqmJcOq/bxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239549; c=relaxed/simple;
	bh=gfpr/1wqtco9OvLUIFWOGhn0cdLJmwWVakMWvOH6p3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9SWP9992MRYy5pN00D7rz5daP1VmKYcXzN+tN6i6RReawF6qB/ojBzKaVEBXKTNKMVrLFjnn+IEH0X73pYtVmX3USIvLzOMEOl6Dtx48JJ5EELX1/YStL3jpft/naX9P1ZRiGPj9Lhx03GYZQsxDhh7SVtZxqXbmqmfnCy92x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxbWu4BDRoF4X8AA--.13522S3;
	Mon, 26 May 2025 14:05:44 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxb8e1BDRo2APyAA--.30366S3;
	Mon, 26 May 2025 14:05:44 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 01/34] mmc: sdhci: Use devm_mmc_alloc_host() helper
Date: Mon, 26 May 2025 14:05:30 +0800
Message-ID: <6fd5afb003982bb5edbf95f76b605686223730e0.1747792905.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747792905.git.zhoubinbin@loongson.cn>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxb8e1BDRo2APyAA--.30366S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1UKw1xCr1xur18ur1ktFc_yoW8WFWUpF
	45XryUCr4UGF15GryDJws8u34rWw1j9ryDK34fXw1rZFWqy34UGFsrCFWUtFy5AFyUt3WS
	qF4DWr15ury8JabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU2-txDUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci.c | 9 +--------
 drivers/mmc/host/sdhci.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 32fa0b2bb912..c40caa3f003f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4076,7 +4076,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	WARN_ON(dev == NULL);
 
-	mmc = mmc_alloc_host(sizeof(struct sdhci_host) + priv_size, dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(struct sdhci_host) + priv_size);
 	if (!mmc)
 		return ERR_PTR(-ENOMEM);
 
@@ -5000,13 +5000,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 EXPORT_SYMBOL_GPL(sdhci_remove_host);
 
-void sdhci_free_host(struct sdhci_host *host)
-{
-	mmc_free_host(host->mmc);
-}
-
-EXPORT_SYMBOL_GPL(sdhci_free_host);
-
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f9d65dd0f2b2..58291a6f093d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -811,7 +811,6 @@ static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
 #endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
 
 struct sdhci_host *sdhci_alloc_host(struct device *dev, size_t priv_size);
-void sdhci_free_host(struct sdhci_host *host);
 
 static inline void *sdhci_priv(struct sdhci_host *host)
 {
-- 
2.47.1

