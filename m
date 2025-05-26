Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58E21BF33F
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239561; cv=none; b=M51ZWqKu7FiD4bZIdq9R1kRgtXVTJp8+KJkKTTUsyHBSiKPKy8vcgdWkgOznaNhDZoQIce2sjo90Df6ZDbIwMnuR2ekNW/lDZ29z+qAEPyHRvBFPUzCgA4cPc7tYUXr0ceMHdYP7Bl8Pxhr4FBUSN4PO0f4mRlkXe9C700tiTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239561; c=relaxed/simple;
	bh=8zE+3oL6D0HfhGKtAMZ05EAy29BHVQUcNJ11oRiIazM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdnjt8GCisJYbdXSNuoTfBjzMUha/bM7v/LK9fW85bGj4BpdcVBBV69GantzrEvcWSgmGrP3dmudla4cOCWopZIH3yURT/ZyKe6ZHIcGfOFGwJSwhgwk9jX+cRNZZ8v2MRrwJoZjHl9B+skIFuJ3Lk3ajhL7+S2ekWJOS/2Jb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxNHDGBDRoQoX8AA--.13016S3;
	Mon, 26 May 2025 14:05:58 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx7MTCBDRo+QPyAA--.32601S3;
	Mon, 26 May 2025 14:05:56 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Ben Dooks <ben-linux@fluff.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 05/34] mmc: sdhci-s3c: Drop the use of sdhci_free_host()
Date: Mon, 26 May 2025 14:05:44 +0800
Message-ID: <4df6ee651c0e10fad2c731b4519a729db4d4b55f.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx7MTCBDRo+QPyAA--.32601S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kZF1xCr4UAFW5KFy8JFc_yoW8Cr4DpF
	WfWFWUtrW7WF1FqF98Jw4DZ3WYkw12qay8KrWrWw1kAFyYyrWktF4S9Fy0qF9YqFykGa13
	CF4Utr4UuFyDXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0XzstUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_free_host() is no longer needed.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-s3c.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index bdf4dc0d6b77..51d20d483acd 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -507,15 +507,13 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	sc = sdhci_priv(host);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		ret = -ENOMEM;
-		goto err_pdata_io_clk;
-	}
+	if (!pdata)
+		return -ENOMEM;
 
 	if (pdev->dev.of_node) {
 		ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
 		if (ret)
-			goto err_pdata_io_clk;
+			return ret;
 	} else {
 		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
 	}
@@ -532,8 +530,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	sc->clk_io = devm_clk_get(dev, "hsmmc");
 	if (IS_ERR(sc->clk_io)) {
 		dev_err(dev, "failed to get io clock\n");
-		ret = PTR_ERR(sc->clk_io);
-		goto err_pdata_io_clk;
+		return PTR_ERR(sc->clk_io);
 	}
 
 	/* enable the local io clock and keep it running for the moment. */
@@ -661,9 +658,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
  err_no_busclks:
 	clk_disable_unprepare(sc->clk_io);
 
- err_pdata_io_clk:
-	sdhci_free_host(host);
-
 	return ret;
 }
 
@@ -685,8 +679,6 @@ static void sdhci_s3c_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(sc->clk_io);
-
-	sdhci_free_host(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

