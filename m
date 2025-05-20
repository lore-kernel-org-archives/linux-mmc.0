Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556BA13635C
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741580; cv=none; b=tWMNSFP2oLfZCb7vnjNjVIukT4uMimQvdvv4PQ64KFaX/AVpkPcgysH9HPVdcLdVejmcHg2n4a63HOyhaunVsRZTFS/ka5TPplTiM+ZigWUdkxtVzv+qTToepWatsTLltJpA5jGZmR2NdZs0EifvVP/gGeLUaFeZAM5hjvmL4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741580; c=relaxed/simple;
	bh=aEV5mBt+4iW7d8SYI4JNMfoxUuysn7rjq53dgBnxV0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWiaHWQezvBPVcPbgkvaEeZqQElcSIVWLrzdd3Bpt5VgCTafLXkcGDPmdPNtixitdp66thCtcAKsebGMDyAZhTLy4eEJzlKSPsqvcdzIU13kBhE4N6A5EFoseVsQuGrtrDnUF0L2lI/PRz8IgpTWXV5gYwc4F9pDm+gtSiabadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Ax3eKJayxo213zAA--.27244S3;
	Tue, 20 May 2025 19:46:17 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMSHayxoljvjAA--.58144S2;
	Tue, 20 May 2025 19:46:16 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 18/36] mmc: omap_hsmmc: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:46:06 +0800
Message-ID: <a81918f83a41b2b81918469831debb8cf86d3ae5.1747739323.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMSHayxoljvjAA--.58144S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrWktrWUCw48WrykWw1rAFc_yoW8AFyDpF
	n3Xa47KrW7Xr4Y9rWDJa1DZFy5Gr4xtaykKFW8u3s7Gw15Ar4kKw1kCFyFvFZ5AFykCF1S
	qF48Jr48CF98JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8RVbDUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/omap_hsmmc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 59e36e0ebbbf..688a8ec81924 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1798,15 +1798,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	mmc = mmc_alloc_host(sizeof(struct omap_hsmmc_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
+	if (!mmc)
+		return -ENOMEM;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto err1;
+		return ret;
 
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1840,9 +1838,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
-		ret = PTR_ERR(host->fclk);
 		host->fclk = NULL;
-		goto err1;
+		return PTR_ERR(host->fclk);
 	}
 
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
@@ -1973,9 +1970,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	clk_disable_unprepare(host->dbclk);
-err1:
-	mmc_free_host(mmc);
-err:
 	return ret;
 }
 
@@ -1995,8 +1989,6 @@ static void omap_hsmmc_remove(struct platform_device *pdev)
 	pm_runtime_disable(host->dev);
 	device_init_wakeup(&pdev->dev, false);
 	clk_disable_unprepare(host->dbclk);
-
-	mmc_free_host(host->mmc);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1

