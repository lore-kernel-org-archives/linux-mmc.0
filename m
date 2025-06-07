Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7142A83
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749282723; cv=none; b=O1fXva4DAou5OtKTX88wdD56+dsXQ7I+XvjCKalSwZy5yM47cmNzJNyxdwFjgYQsrXaOLly7LQ4OrnvWJ4s9IEgFGMSOoEaqErAdNUUqG9uz1SlgCSNYBTe6VYeBLx11US+7XW7sbRySN+wtrW9lCuHPQKLaZEF60Pra+c3iBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749282723; c=relaxed/simple;
	bh=Z4qqAR2GNpPxfVoNaeKnKDpD+Caj7nqHLVhAjJ1Uj+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cToR2AKAxWoA0p49YB66n7r3vP0JRPwmxGtoMzJkxyVHgp9NruVADrXLccEKLo6TfeYt8erZFXje7ag5Z1iO2Vw5yQ48r9jNSsn80VrUBUPnilcGk7k+2/T1ds6LJwaGjfaOYF09XhN1Wd3IrxuZb/tF1Mns9LwywNBFQR1h+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxWXGg70NoHRkPAQ--.41245S3;
	Sat, 07 Jun 2025 15:52:00 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDx_MSd70NomKIOAQ--.43644S2;
	Sat, 07 Jun 2025 15:51:59 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 30/35] mmc: sdhci-st: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:51:48 +0800
Message-ID: <5fdb2403bf553ad43e2336d072007dd7ea2b4143.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDx_MSd70NomKIOAQ--.43644S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZryrtF4rJF4ftr4fJw43urX_yoWkuwbE9F
	15Zrs7GF4F9rZ7Wa4UK3WayrykKFsYvr1kury8tw45Kr97Xwn8Jay7urnrCr43ur4j9Fy5
	Cw48Xr4xZw43KosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbkAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r45
	tVCq3wAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r126r1DMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxU9zpBDUUUU

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 4973e08a98f8..9157342ff7a4 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -380,13 +380,13 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed mmc_of_parse\n");
-		goto err_of;
+		goto err_pltfm_init;
 	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clock\n");
-		goto err_of;
+		goto err_pltfm_init;
 	}
 
 	ret = clk_prepare_enable(icnclk);
@@ -423,8 +423,6 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	clk_disable_unprepare(icnclk);
 err_icnclk:
 	clk_disable_unprepare(clk);
-err_of:
-	sdhci_pltfm_free(pdev);
 err_pltfm_init:
 	reset_control_assert(rstc);
 
-- 
2.47.1

