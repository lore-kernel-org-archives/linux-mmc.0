Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12580BF8;
	Wed, 10 Jul 2024 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594860; cv=none; b=OA/fTP1vVDlSs3+jOUTNigSUSBryAl7cUHArOeC6tPX989MjLXU2nll2wKVa4oJ2iWMok5Y+KzpoUOImYVlKuimgEDQleCKu0aHrIX0+OwfOVMS1OxLgLpgJQBWo4PkZWLhTqigHf2w/3PRTPJXHjcJoiin7evRCbMcB5xxLQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594860; c=relaxed/simple;
	bh=WY/+69caToVAW5kyLQ8q/hb0Eacuf9bFcTcP6mPygGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q/933pSvzECh/Y0UOYVXUgmwzRn2zAnCcx56fAtkil1yUlTBz43kgeocXbT7iTFiArIO0Z6U2NSkr9KaHtfj7uskJuYbYC8wbLn88M6kkJ0TYkRSs6AhmOqgXSnpxPLCYbGeq+QJpoBz5pDid+/UKjNvkoNZzt5wChOGRD+H0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAAnEyCXMY5m1lSGAg--.48744S2;
	Wed, 10 Jul 2024 15:00:50 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] mmc: sdhci-pxav3: Fix potential NULL dereference in sdhci_pxav3_probe
Date: Wed, 10 Jul 2024 15:00:39 +0800
Message-Id: <20240710070039.318658-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnEyCXMY5m1lSGAg--.48744S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWfuF18Ww4xJFyDZFWfGrg_yoW8JFWkpa
	15XFW5KrWUKr1fGas5Z345ua1SkF1Fv3y29Fs3Jw1S9FZ5tryDJan7CFy0yr1UXFW5G3W3
	JF4DX345CrykXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb0PfJ
	UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In sdhci_pxav3_probe(), mv_mbus_dram_info() returns NULL if
CONFIG_PLAT_ORION macro is not defined. Fix this bug by adding NULL check.

Fixes: aa8165f91442 ("mmc: sdhci-pxav3: do the mbus window configuration after enabling clocks")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/mmc/host/sdhci-pxav3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3af43ac05825..ac89cb2eb9f6 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -375,6 +375,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	struct sdhci_host *host = NULL;
 	struct sdhci_pxa *pxa = NULL;
 	const struct of_device_id *match;
+	const struct mbus_dram_target_info *dram;
 	int ret;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata, sizeof(*pxa));
@@ -406,7 +407,12 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		ret = armada_38x_quirks(pdev, host);
 		if (ret < 0)
 			goto err_mbus_win;
-		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
+		dram = mv_mbus_dram_info();
+		if (!dram) {
+			ret = 0;
+			goto err_mbus_win;
+		}
+		ret = mv_conf_mbus_windows(pdev, dram);
 		if (ret < 0)
 			goto err_mbus_win;
 	}
-- 
2.25.1

