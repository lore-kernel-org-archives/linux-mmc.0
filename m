Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD918FA26;
	Wed, 10 Jul 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609175; cv=none; b=pgZdL7DNt4P6X8iQ1dtsG9RvD1PNBaFPtVMEbgEAEBYFWYiMZlqnl3U12OQd4GMVTksS4KvWmNwqNhiTLUKAZoYSYVO5YZ/BNZwkGgbLOeA8Y6CDUE1pSdo0tEZ6CMkxJyy7KXiesmG1UeKfc6ZDAJjZasbTfZFSqBvbmhnFhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609175; c=relaxed/simple;
	bh=E/a4FQDoam0Lp6sh3PoMJFMZ/7+BWLYYRATRzpVRUQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fvh35rgpeVAkLyYmQqPak1c+xqIrl++dIO34VDzwXVZ6g0peMbJBK8AYBQxVXEfo3OmnAMAExdPEWCHyae3k6IsDcWQU2USWduMI1sHrhgza2IFKCtfna+DimwR3Wc5scUjIdynaKx+VDC9Qs04ZYqkrTy3hBSL0b3FydcqMXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADn7+eAaY5mo5mNAg--.50742S2;
	Wed, 10 Jul 2024 18:59:23 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	thomas.petazzoni@free-electrons.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] mmc: sdhci-pxav3: Fix potential NULL dereference in sdhci_pxav3_probe
Date: Wed, 10 Jul 2024 18:59:11 +0800
Message-Id: <20240710105911.2076942-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADn7+eAaY5mo5mNAg--.50742S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF13Kw4UJw4rtF43GF1Utrb_yoW8Ary8pa
	n8XrW5KrWrJr4rGa4ku3s8u3WakF1Yv3y29FZ7Jw1S9FZ5tryqqan7CFyrtr1UZrWUG3W3
	XFnrZ348CrykXwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUq-erUUU
	UU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In sdhci_pxav3_probe(), mv_mbus_dram_info() returns NULL if
CONFIG_PLAT_ORION macro is not defined[1]. Fix this bug by adding NULL 
check.

Fixes: aa8165f91442 ("mmc: sdhci-pxav3: do the mbus window configuration after enabling clocks")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- refined the vulnerability description;
- provided similar vulnerability's reference link[2].
Reference link:
[1] https://github.com/torvalds/linux/blob/34afb82a3c67f869267a26f593b6f8fc6bf35905/include/linux/mbus.h#L65
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=d48d0c5fd733bd6d8d3ddb2ed553777ab4724169
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

