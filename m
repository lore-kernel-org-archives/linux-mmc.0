Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D442264B2;
	Thu,  7 Aug 2025 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607119; cv=none; b=dnazkQImf1fpoRiGUvXDnAjYCQ/nSiKnoImzfjrwZFM/9FV1ss0c0RU9eRYT/twrwSzY5Wlj99UzBQ5+xPG82zQ90W9hbBlzJGpz78HzhlIJdGJ0w5WfcgMuI2fiNzd7xJE9tqzi5GoONJWDfJNyK3fQLHO9zi23UX7k5VcBdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607119; c=relaxed/simple;
	bh=7U9zQQu1+XgQN/HKqws/bMTf3PW9EtFNaXj8T8wJSxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWTzOHr5M4mm9ohTMFQoHgA6ib9dHaDKuvkggtjtih+5DAQc+EHRIaXjrLn977NHS68oWZonioYDU+DXyGZWvrCvzAo4oj1rqej6ZAcZdowoqSLyKRS1sZDlhmrUKDjK7wbmLY1psFBV//MAE14dWQnMeohPtAciP6JQAeIefS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZGFygSQ1; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZGFygSQ1"
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 577MpcNY455838;
	Thu, 7 Aug 2025 17:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754607098;
	bh=qHunNEMGxpCcQqPo/qp2CxmR0lat3CX2feywSyaG5+A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZGFygSQ19nfzaZcHmcJEhHBSPrCCy5/56d0EyYe+p+9DEl6dOoz7McobhFSPH8tgI
	 DqD3zTFz3vPJ0LJ0rT+dLRSwX6Jd2cHj0NeNhPWE52+ssRDk6Ii6D1kfrBv5HBJH06
	 iMGb1e1PwouzvH8G1WY2B5wV/j8MfyYzsTtD74vo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 577MpcQm025953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 7 Aug 2025 17:51:38 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 7
 Aug 2025 17:51:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 7 Aug 2025 17:51:38 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 577MpcBl2086622;
	Thu, 7 Aug 2025 17:51:38 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/2] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
Date: Thu, 7 Aug 2025 17:51:38 -0500
Message-ID: <20250807225138.1228333-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250807225138.1228333-1-jm@ti.com>
References: <20250807225138.1228333-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
due to errata i2458 [0] so disable HS400 for these SoC revisions.

[0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e4fc345be7e5..dc4975514847 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -156,6 +156,7 @@ struct sdhci_am654_data {
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
+#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
 };
 
 struct window {
@@ -765,6 +766,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	u32 ctl_cfg_2 = 0;
 	u32 mask;
 	u32 val;
@@ -820,6 +822,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (ret)
 		goto err_cleanup_host;
 
+	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
+	    host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
+		dev_err(dev, "Disable descoped HS400 mode for this silicon revision\n");
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+	}
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -883,6 +891,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct soc_device_attribute sdhci_am654_descope_hs400[] = {
+	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ .family = "AM62PX", .revision = "SR1.1" },
+	{ /* sentinel */ }
+};
+
 static const struct of_device_id sdhci_am654_of_match[] = {
 	{
 		.compatible = "ti,am654-sdhci-5.1",
@@ -970,6 +984,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "parsing dt failed\n");
 
+	soc = soc_device_match(sdhci_am654_descope_hs400);
+	if (soc)
+		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_DISABLE_HS400;
+
 	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
-- 
2.49.0

