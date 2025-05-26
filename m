Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C21922FD
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239594; cv=none; b=c0rmY+19DxAZIbn2hzKCjsU7XqrVjV9O9g2oNhztZn83NzngtrJ0lsu0IOUAAFPgSCiqhQ+L0ViUbJmyvN3jGDHCywXAoGbUjE0mAPddO1bjkKDSSHHvXpmNRZMu/++i2EbFxpbFOwcEeYRAUeIGxEZFG32ZOL1/eftQW1DCJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239594; c=relaxed/simple;
	bh=Z24i3FOQ9M7TNnxXse8SH4NmNvKqkJ/fp8iaylQOub0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHL1/ydkp++Wb+GoSk3l8/BJ9QGKYhokdok2/7zmXx7p0g1CrRrtw6MX7o4/FK5sNu1kRdwnnuTcotVUMKjdl3W1nyAnbDB6o13w0Tgv9C18DXWThkZR4w3qa3anf/CBDJYN46bsepCvvS/IHiksCxWnAYHubGKeoB00NoaebLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx63HnBDRomYX8AA--.13978S3;
	Mon, 26 May 2025 14:06:31 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDx_MTmBDRoQwTyAA--.30214S2;
	Mon, 26 May 2025 14:06:30 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 14/34] mmc: sdhci-iproc: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:06:18 +0800
Message-ID: <4164cad8076738157d7a952d1b715e5daee82c7d.1747792905.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDx_MTmBDRoQwTyAA--.30214S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw45Gr4DWw4rGFyxXw15WrX_yoW8Xry5pa
	nxJrZ3KrW8uFWrK3y5Xws7ZF1UAw1Sgay8KryfGw1vq3y5Kry5twn3AFW8tFZ5ArW8Gr15
	XFs0qF1Uua4DAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3
	AVW8Xw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jsTmfUUUUU=

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-iproc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 80b2567a488b..35ef5c5f5146 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -379,7 +379,7 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto err;
+		return ret;
 
 	sdhci_get_property(pdev);
 
@@ -387,10 +387,8 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 
 	if (dev->of_node) {
 		pltfm_host->clk = devm_clk_get_enabled(dev, NULL);
-		if (IS_ERR(pltfm_host->clk)) {
-			ret = PTR_ERR(pltfm_host->clk);
-			goto err;
-		}
+		if (IS_ERR(pltfm_host->clk))
+			return PTR_ERR(pltfm_host->clk);
 	}
 
 	if (iproc_host->data->missing_caps) {
@@ -399,15 +397,7 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 				  &iproc_host->data->caps1);
 	}
 
-	ret = sdhci_add_host(host);
-	if (ret)
-		goto err;
-
-	return 0;
-
-err:
-	sdhci_pltfm_free(pdev);
-	return ret;
+	return sdhci_add_host(host);
 }
 
 static void sdhci_iproc_shutdown(struct platform_device *pdev)
-- 
2.47.1

