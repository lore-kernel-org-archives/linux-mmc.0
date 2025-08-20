Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A836CE00;
	Wed, 20 Aug 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718253; cv=none; b=n1BDswKc1RLxX1eg7hjgz4yS/FXF1MNeEMkD85AFSnuvzHHFKNTesW/mhgt7dG88ecYYx7SSGb3RbUX8oCZ5D1kYQGQllqKvEoLzsqXjKpIIZdLb4odwH7CdK7hf0N+Z6WmYOoTVvlvfsl5saEbXKrLcD+8L6gbWy2Ng4O8RKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718253; c=relaxed/simple;
	bh=2MgdwlJeSwaisuGzVs4brwSIi7VbS7aJ1NanT33mDBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iNRziegV2DjlunNO2kXPLO0W4672LsnuqOsDMK5h/KaistUKXpsoCV7faxCWxVjrDby5QowBvrm78prUDpb9EPqGz7HiZDly9F1x3q0/bn0XSl9vFmieIzCPFht57JosqkB1JCh28cWRf7RioXSdNO6uIB3R20wjc5SjX7H+xFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ysf8YzAw; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ysf8YzAw"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KJUlpv3266977;
	Wed, 20 Aug 2025 14:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755718247;
	bh=IeWsADdri0ocUxlQVF4mtwR+WyA8x/GO9o64bt18pvw=;
	h=From:To:CC:Subject:Date;
	b=ysf8YzAwt65yJWCe14kuzy5/ck8sxwfp8i0wNfuA1biIWbV1E2w4l47/tbF7eWCj1
	 5du06waYRSK8+KdovXFQxZmec8FOiBY9C9i87KjB3K4Es5oCE3ck6wa4dStYqMpT9l
	 NRe8EUnZQSHi0Fjaxul+tz20cS7Ci0ivHWNa69C4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KJUlAL1577857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 14:30:47 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 14:30:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 14:30:47 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KJUlBt712398;
	Wed, 20 Aug 2025 14:30:47 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v5] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
Date: Wed, 20 Aug 2025 14:30:47 -0500
Message-ID: <20250820193047.4064142-1-jm@ti.com>
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
Fixes: 37f28165518f ("arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
This patch was separated from [1] since it will be merged to
different trees anyways.

Links:
v4: https://lore.kernel.org/linux-mmc/20250819152854.3117844-1-jm@ti.com/
v3: https://lore.kernel.org/linux-mmc/20250818203310.3066985-1-jm@ti.com/
v2: [1] https://lore.kernel.org/linux-mmc/20250807225138.1228333-1-jm@ti.com

Changes since v4:
- Add fixes tag and cc stable as per Ulf's review comment in v4
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

