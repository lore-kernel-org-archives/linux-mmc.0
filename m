Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C03C0A1F
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2026 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325349; cv=none; b=efxwnuveAm8RLuP17BszBcw4sMlAboMfEPjox++370eaVar3HyaW4cM3qlkOfVLzNkVQTDXJopSiCvnSFCE3gc/YzaKZU9idkdsMT1+n+wlRDEv+2QuoK/dWCLiTY1Dl5iN7uLMXbqu3ntoFcA9ZFqGpW1o5TMbcmKE0kpUYErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325349; c=relaxed/simple;
	bh=Lwcth8VZwUW7i1htoiDe+rqLnVzhWp+xmsjmBDa33Uo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=liI30DPSaQzu6liReNzKzdHMpFk1vD5moXRHcSn5dqJXRZ4BdUOaXBaZ0+jOEMpNeHfMS4XWf4VzpYF99P3ktgk3IUKgIuD9Pamk2I+hWNk4j8bdQ7uHCMsRmywYpz4IWIFSItU/rWvAFNnjwFxq0bUa0cNWaysovIcdTnNS/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.2.227) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 1 Jun 2026
 17:49:01 +0300
Message-ID: <dd3aa530-d06f-4733-ba5a-ccc95d8fa91a@auroraos.dev>
Date: Mon, 1 Jun 2026 17:49:01 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Subject: [PATCH v3] mmc: sdhci-of-dwcmshc: check bus clock enable result in
 the probe() method
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

In the driver's probe() method, clk_disable_unprepare() for the bus clock
is called on the error path even if the prior clk_prepare_enable() call has
failed (and the same thing happens in the remove() method as well) -- that
would cause the prepare/enable counter imbalance.  Also, the same problem
can happen in the driver's suspend() method; note that the resume() method
does check the clk_prepare_enable()'s result -- let's be consistent and do
that in probe() method as well.  BTW, I don't know for sure what does the
bus clock control -- if it affects the register accesses, the driver will
likely cause (e.g. on ARM) a kernel oops if it fails to prepare/enable the
bus clock in the probe() method...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
This patch is against the fixes branch of Ulf Hansson's mmc.git repo.

Changes in version 3:
- dropped stray comma in the subject;
- dropped unneeded word in the description.

Changes in version 2:
- mentioned the problem in the remove() method as well, somewhat rephrased
  the patch description.

 drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index b9ecd91f44ad..29af07561a86 100644
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
