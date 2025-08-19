Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DA285411;
	Tue, 19 Aug 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617340; cv=none; b=nPA1Q0D/btvpF/FCauBVSrWBlvhksgyuOlI8m0t96eOfmMtoHXVt6g32CsZhCtvBcNiTgmETAGk5I52wRPsOTnSeAx4POO0dzEOv5IvqYciIjisjiXfh3IzOdWG3Leklrfu4QQ21rk8swygNKhT8GXtYfjAKNfclag4AXaOMJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617340; c=relaxed/simple;
	bh=zgvlTB/9Mgr8xfjna0mDUb0bd8RYBObScO80xJpDHL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sc7kxRgTivB8TEfXEiH7VFuaq6Nbhs2IsC2m5u/qe7KWFSWdD84XHRwgov4rBtOc1FlaYroPpvTVdZtn0oEwp6ghHHGODg/w5un13BFHvcVjq6z/ZdxZL+0drG1fnZzde51mv0idga6xzKm0Y+Ly1qtyxRBbCJvi6W+khtubuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OasIbiKM; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OasIbiKM"
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JFStLa039595;
	Tue, 19 Aug 2025 10:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755617335;
	bh=QZQ9zIe102l9089xY/F2kdBLqeykgcKI5+b+SszuE2Q=;
	h=From:To:CC:Subject:Date;
	b=OasIbiKMhePjgj3xuYLCBhIE/u9fONQzrrVI4Ml4niPNf9KVw3vZkwww4YYqq8SEG
	 DRap6aYh9Lr4la/Xi/9RZzse+lCMW7aPcAZ4SVs4f9WyfSkDBi72nqN9f3OngYyzYM
	 SYWHtN3/bT1WyEaith+9zYEq75L/Ss+1J+flgng4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JFSsID496830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 10:28:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 10:28:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 10:28:54 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JFSsmE3217113;
	Tue, 19 Aug 2025 10:28:54 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v4] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
Date: Tue, 19 Aug 2025 10:28:54 -0500
Message-ID: <20250819152854.3117844-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
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
Reviewed-by: Andrew Davis <afd@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
This patch was separated from [1] since it will be merged to
different trees anyways.

Links:
v3: https://lore.kernel.org/linux-mmc/20250818203310.3066985-1-jm@ti.com/
v2: [1] https://lore.kernel.org/linux-mmc/20250807225138.1228333-1-jm@ti.com

Changes since v3:
- Add Andrew's and Adrian's tags
- Fix message to user as per Andrew's and Adrian's suggestion
  in v3 to a less imperative tone
- Fix commit message reference indexes
---
 drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8a099508b939..ffc45930c240 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,6 +155,7 @@ struct sdhci_am654_data {
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
+#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
 };
 
 struct window {
@@ -764,6 +765,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	u32 ctl_cfg_2 = 0;
 	u32 mask;
 	u32 val;
@@ -819,6 +821,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (ret)
 		goto err_cleanup_host;
 
+	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
+	    host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
+		dev_info(dev, "HS400 mode not supported on this silicon revision, disabling it\n");
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+	}
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -882,6 +890,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
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
@@ -969,6 +983,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
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

