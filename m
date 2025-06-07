Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592321F17E8
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281731; cv=none; b=a0ze47b6uBTKaHLUTH0+EMU1PD7jKBr5GqP1iojozzRG0N+pAs8evDNrpx5Wl3HhJigSCE75y5Gkq6SiiBzVLTGwuQ4fU0meMoV2KoXu0Gz7ygBXOoa6MrS0f+Nb7EV9jo9nqtwMJ1IQGjiEZ3lMFPkxZG8VZZ7FBpBYWN03/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281731; c=relaxed/simple;
	bh=W85MBCxfQQGtZ6jIX9xyIbINI/93AwLVBkOiCLwSFrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejrYQOMhypwPKzS5cxzO53qdTo/fNPN7TgORjmXQvzVuDZYyauQ99V/BgQh1ZZh0ym7HvB8bzfEkFRkjJwdkhjUeWy/+SLSl7NcZWYuvMgtxSnnaoDS4jcMnu1c+3ByWBNAwAv476LCrgwhX/Kdr0JwSc4GIYqJF0Rq/f0RjhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxPuPA60NoqBUPAQ--.5611S3;
	Sat, 07 Jun 2025 15:35:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3xu460Noj50OAQ--.58136S5;
	Sat, 07 Jun 2025 15:35:26 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Ben Dooks <ben-linux@fluff.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 05/35] mmc: sdhci-s3c: Drop the use of sdhci_free_host()
Date: Sat,  7 Jun 2025 15:35:09 +0800
Message-ID: <f22a17de11dc03c5bdeb4ebbdc6aec8429c1c20f.1749127796.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749127796.git.zhoubinbin@loongson.cn>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3xu460Noj50OAQ--.58136S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kZF1xCr4UAFW5KFy8JFc_yoW8Cr4DpF
	WfWFWUtrW7WF1FqF98Jw4DZ3WYkw12qay8KrWrWw1kAFyYyrWktF4S9Fy0qF9YqFykGa13
	CF4Utr4UuFyDXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0wqXPUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_free_host() is no longer needed.

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

