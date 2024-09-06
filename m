Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D811D45FC;
	Fri,  6 Sep 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645044; cv=none; b=MXZ2MkeDAesQpkTNrvz19rgXf1uoSSYkLFL6Wgvnb1ftBZ0+IszuHs7fUUeKVp3CrMwAz1YTasOQzlP/gkcK0mauA6AurA7Nz2RnBAZpGOV/Bc1PNzMoXYgSh3dCrRozJ2A7rDmoDJDEcJhCBx3ST/i1CPNSr2UH4lVTxCLCQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645044; c=relaxed/simple;
	bh=qnM8hlhU35M3xtiCRyv3k0FxZWw3r79XUzia8TXb2Io=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hoje6Yj6nBxT5Fwnx/Ww+3zPzSJEgy5tfhQX0kNeoB4x3jtB/zTB/HnxGPAm/BF6XEUschkjBSRX/82gudQ7wtFxxbeO327RFsxFCd1yJYg8HhrGi2xIFePtuW8Hybf0CujryHfBXEMU3u5DzFYSN3mE4druAJfKAvXxlA0yZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ds5Cidgf; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ds5Cidgf"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 486HoWTO023850;
	Fri, 6 Sep 2024 12:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725645032;
	bh=YxjEcHGuRXhYWOYUfSPSYWTdKQah+2cnC/OEfC3+NwU=;
	h=From:To:CC:Subject:Date;
	b=Ds5CidgfJOXF1f8tKxzQeGf3EgnVwQSxtiPefw/hqGDG/VRIIMuXdF7S99SVg07n/
	 kk737joX7cVovSESEl7QNtm57FN5RuW/eZi+YSXXA1yMPsASNsyB1japnVu9wE2kBl
	 RbMoV4O+JOyv7yUvsMVj/tVm+1gWSfAmewqviMLI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 486HoWlG003332
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Sep 2024 12:50:32 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Sep 2024 12:50:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Sep 2024 12:50:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 486HoWwD096056;
	Fri, 6 Sep 2024 12:50:32 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
Date: Fri, 6 Sep 2024 12:50:32 -0500
Message-ID: <20240906175032.1580281-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The sdhci_start_signal_voltage_switch function sets
V1P8_SIGNAL_ENA by default after switching to 1v8 signaling.
V1P8_SIGNAL_ENA determines whether to launch cmd/data on neg
edge or pos edge of clock.

Due to some eMMC and SD failures seen across am62x platform,
do not set V1P8_SIGNAL_ENA by default, only enable the bit
for devices that require this bit in order to switch to 1v8
voltage for uhs modes.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 86 ++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 0aa3c40ea6ed8..fb6232e56606b 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,6 +155,7 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
+#define SDHCI_AM654_QUIRK_SET_V1P8_ENA BIT(1)
 };
 
 struct window {
@@ -356,6 +357,79 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	sdhci_set_clock(host, clock);
 }
 
+int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc,
+					    struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	u16 ctrl;
+	int ret;
+
+	if (host->version < SDHCI_SPEC_300)
+		return 0;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		if (!(host->flags & SDHCI_SIGNALING_330))
+			return -EINVAL;
+
+		ctrl &= ~SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+		if (!IS_ERR(mmc->supply.vqmmc)) {
+			ret = mmc_regulator_set_vqmmc(mmc, ios);
+			if (ret < 0) {
+				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
+					mmc_hostname(mmc));
+				return -EIO;
+			}
+		}
+
+		usleep_range(5000, 5500);
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (!(ctrl & SDHCI_CTRL_VDD_180))
+			return 0;
+
+		pr_warn("%s: 3.3V regulator output did not become stable\n",
+			mmc_hostname(mmc));
+
+		return -EAGAIN;
+
+	case MMC_SIGNAL_VOLTAGE_180:
+		if (!(host->flags & SDHCI_SIGNALING_180))
+			return -EINVAL;
+
+		if (!IS_ERR(mmc->supply.vqmmc)) {
+			ret = mmc_regulator_set_vqmmc(mmc, ios);
+			if (ret < 0) {
+				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
+					mmc_hostname(mmc));
+				return -EIO;
+			}
+		}
+
+		if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_SET_V1P8_ENA) {
+			ctrl |= SDHCI_CTRL_VDD_180;
+			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			if (ctrl & SDHCI_CTRL_VDD_180)
+				return 0;
+
+			pr_warn("%s: 1.8V regulator output did not become stable\n",
+				mmc_hostname(mmc));
+
+			return -EAGAIN;
+		}
+		return 0;
+
+	default:
+		return 0;
+	}
+}
+
 static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
 {
 	writeb(val, host->ioaddr + reg);
@@ -801,6 +875,8 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 					struct sdhci_am654_data *sdhci_am654)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *node;
 	int drv_strength;
 	int ret;
 
@@ -844,6 +920,15 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
 
+	node = of_parse_phandle(np, "vmmc-supply", 0);
+
+	if (node) {
+		node = of_parse_phandle(np, "vqmmc-supply", 0);
+
+		if (!node)
+			sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SET_V1P8_ENA;
+	}
+
 	sdhci_get_of_property(pdev);
 
 	return 0;
@@ -940,6 +1025,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);

base-commit: cf6444ba528f043398b112ac36e041a4d8685cb1
-- 
2.46.0

