Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E4F1E2853
	for <linux-mmc@vger.kernel.org>; Sat,  7 Jun 2025 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281874; cv=none; b=AwJ/zPfl7aklCcz0IPZq15ih/bPQT7TBw1orZ4nO0bEA+J/P5sB+l91StCjAdn665k+HLt/I3BeJhCzFSoJToKV/fVyLsv3M07Lpob2WA/sGnEH/TdcgD2q6M4JAVPbld3muePsaCRkQNqR9c/7KdlJ5xENcTsSwdukzvA4Q3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281874; c=relaxed/simple;
	bh=wbZc0T2MdD+sTejaJUC7ZGxu/pA7cTBaAzSlOnl6JXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+xhztYlX3D+TYRrYhEQLB1VKslwmbplOrTx5W5ycpK9ZQLZAI/cWfHAUdSTmWJZTmsqbTqYjjb9M3gCVsCoMsat895wmcXDWyiB8Zy5umVUUddPwb7bReiijQnCIeqrw+3UaIrWKLV+rCtXwk31D7JryWD/p52sNbRuE3vg7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxWXFP7ENoYBYPAQ--.41224S3;
	Sat, 07 Jun 2025 15:37:51 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxvhtN7ENomp4OAQ--.58650S2;
	Sat, 07 Jun 2025 15:37:51 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v3 14/35] mmc: sdhci-iproc: Drop the use of sdhci_pltfm_free()
Date: Sat,  7 Jun 2025 15:37:38 +0800
Message-ID: <c6496a92e47bfc70550759db5f6eba5564bb4a7d.1749127796.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxvhtN7ENomp4OAQ--.58650S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw45Gr4DWw4rGFyxXw15WrX_yoW8Xry5pa
	nxJrZ3KrW8uFWrK3y5Xws7ZF1UAw1Sgay8KryfGw1vq3y5Kry5twn3AFW8tFZ5ArW8Gr15
	XFs0qF1Uua4DAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8
	Xw0E3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYyMKtUUUUU==

Since the devm_mmc_alloc_host() helper is already in use,
sdhci_pltfm_free() is no longer needed.

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

