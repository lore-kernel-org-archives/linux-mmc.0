Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27533F390
	for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001862; cv=none; b=eFQGmuy1AZUfVoITBG7IFjcgIKHa5cRugiN/wp4n9t0K1wq3NpH4nPOqsZamieRqNF2sU7T6e+sfoFYH+sWLwJy4kJYCo2teZpmMgPBmlav12cDyzQcKPpi1gQTAO83LyPEr7wlqhhAjCMz8tfbDsRPlvpeQi8UoP2Xh7feJfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001862; c=relaxed/simple;
	bh=Glm0UCw/KINXn+sbhASsbcD7YlimuYyg/aqmy2yjdiw=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=cAnPHfl1E55scEHTFfVFu2RHi+EKHxZ1fb5XTKcJUewk2BOFccgBrfxY/9OeW4cFuNuUaAZZKkLZ7lfKVXMGP1lmNArV0WEHQMIYaDg8oNU7enuQieFFITSPlc2hKxNhAMAna06ezfB3Mj/CAoONY4bqgZ9VWxRJwrzfJ+nyOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.6.82) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 28 May
 2026 23:42:27 +0300
Message-ID: <34ef000c-907f-40b2-86e2-0c4fab094cfd@auroraos.dev>
Date: Thu, 28 May 2026 23:42:27 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: check bus clock enable result in the,
 probe() method
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

In the driver's probe() method, clk_disable_unprepare() for the bus clock
is called on the error path even if the prior clk_prepare_enable() call has
failed -- that causes the prepare/enable counter imbalance.  Also, the same
kind of problem can happen in the driver's suspend() method; note that the
resume() method does check for the clk_prepare_enable()'s success -- let's
just be consistent and do that in probe() method too (BTW, I don't know for
sure what does the bus clock control -- if it affects the register access,
the driver is likely to cause a kernel oops iff it fails to prepare/enable
the bus clock in the probe() method)...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
This patch is against the fixes branch of Ulf Hansson's mmc.git repo...

 drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 0b2158a7e409..83af8d2048d7 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -2441,13 +2441,16 @@ static int dwcmshc_probe(struct platform_device *pdev)
 			return err;
 
 		priv->bus_clk = devm_clk_get(dev, "bus");
-		if (!IS_ERR(priv->bus_clk))
-			clk_prepare_enable(priv->bus_clk);
+		if (!IS_ERR(priv->bus_clk)) {
+			err = clk_prepare_enable(priv->bus_clk);
+			if (err)
+				goto err_clk;
+		}
 	}
 
 	err = mmc_of_parse(host->mmc);
 	if (err)
-		goto err_clk;
+		goto err_bus_clk;
 
 	sdhci_get_of_property(pdev);
 
@@ -2461,7 +2464,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	if (pltfm_data->init) {
 		err = pltfm_data->init(&pdev->dev, host, priv);
 		if (err)
-			goto err_clk;
+			goto err_bus_clk;
 	}
 
 #ifdef CONFIG_ACPI
@@ -2507,9 +2510,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_rpm:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
+err_bus_clk:
+	clk_disable_unprepare(priv->bus_clk);
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
-	clk_disable_unprepare(priv->bus_clk);
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 	return err;
 }
-- 
2.54.0
