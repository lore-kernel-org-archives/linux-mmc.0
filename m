Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8E2571A2;
	Thu, 17 Apr 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914428; cv=none; b=RGHVfWIUwmRdObDJGaXKeN+71WeM54p0tgFJpNrDrvfpGkc+c1p50+TUeouH1QsAIo5V/NYxEgH2WJCQXoQDSVrlQS0N/nk+rhIW9e5Ni7nojQazjRt6WUWCHVokJMM3q2G5my65pYQjJstDTdCrw+cIEndkqKdul0F0WPwwQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914428; c=relaxed/simple;
	bh=H8Gg2/vmGXAh1NRzYa4sj4x7tuVsEvUxUuM05P0cWTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKDChbn6+6jMH3frfQR/TwLGKhNlNfhvz6x+5v2TNNkv3OCZcM2xFX5+gb7bN23mWVgdWtAtrvY54uyJGq+PnUdLe/Phmm4g96+b9dbySnMqei6DmWKoxTYHuRWgEPQsjAOcQbarTeCWGHJZJ15YejRjggi0z7eg4h6+z5qK6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w2Nwi3CE; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w2Nwi3CE"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HIQqih090275
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744914412;
	bh=Rj9Gdvv9SiqoqsOg8hwrpex+4pw5LevQJozBqu2sNWw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=w2Nwi3CEp+oCtCLVBvkVITK+hjFaNBwc2cFFFK0bQjfW8VKdkNNuKKQDoH+d4NEXn
	 1SdDe3OsOPR6ESEjK7gZpv8xKfp5czmt/a+dU8FPFob/yg87RH/NSt4wcHU8y1y5R2
	 osvEbdDh/5bF4ZuMReX6bfFpRujz3ksDj6OVJwEM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HIQqG7062727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 13:26:52 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 13:26:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 13:26:51 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HIQqh6078217;
	Thu, 17 Apr 2025 13:26:52 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>
Subject: [PATCH v2 1/2] mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
Date: Thu, 17 Apr 2025 13:26:51 -0500
Message-ID: <20250417182652.3521104-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417182652.3521104-1-jm@ti.com>
References: <20250417182652.3521104-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The sdhci_start_signal_voltage_switch function sets
V1P8_SIGNAL_ENA by default after switching to 1v8 signaling.
V1P8_SIGNAL_ENA has a timing component where it determines
whether to launch cmd/data on neg edge (half cycle timing)
or pos edge (full cycle timing) of clock. V1P8_SIGNAL_ENA also
has a voltage switch component where if there exists an internal
LDO, for SD this bit is used to switch from 3.3V to 1.8V IO
signal voltage.

The sequence is to switch to 1.8 IO voltage, set V1P8_SIGNAL_ENA,
change bus width, then update HIGH_SPEED_ENA & UHS_MODE_SELECT.
During bus width change is when eMMC failures are seen with
Kingston eMMC and various types SD cards across Sitara K3 SoCs.

So, add a quirk to suppress V1P8_SIGNAL_ENA and do not enable by
default for eMMC since it is anyways optional for this interface
and parse DT property: ti,fails-without-test-cd to apply the quirk
for SD cards.

Signed-off-by: Judith Mendez <jm@ti.com>
Suggested-by: Hiago De Franco <hiago.franco@toradex.com>
---
 drivers/mmc/host/sdhci_am654.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f75c31815ab00..2d9f1406d06eb 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -87,6 +87,7 @@
 #define CLOCK_TOO_SLOW_HZ	50000000
 #define SDHCI_AM654_AUTOSUSPEND_DELAY	-1
 #define RETRY_TUNING_MAX	10
+#define BUS_WIDTH_8		8
 
 /* Command Queue Host Controller Interface Base address */
 #define SDHCI_AM654_CQE_BASE_ADDR 0x200
@@ -155,6 +156,7 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
+#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
 };
 
 struct window {
@@ -356,6 +358,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	sdhci_set_clock(host, clock);
 }
 
+static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
+	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+		if (!IS_ERR(mmc->supply.vqmmc)) {
+			ret = mmc_regulator_set_vqmmc(mmc, ios);
+			if (ret < 0) {
+				pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
+				       mmc_hostname(mmc));
+				return -EIO;
+			}
+		}
+		return 0;
+	}
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
 {
 	writeb(val, host->ioaddr + reg);
@@ -803,6 +828,7 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	int drv_strength;
 	int ret;
+	u32 bus_width;
 
 	if (sdhci_am654->flags & DLL_PRESENT) {
 		ret = device_property_read_u32(dev, "ti,trm-icp",
@@ -844,6 +870,11 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
 
+	/* Suppress V1P8_SIGNAL_ENA for eMMC */
+	device_property_read_u32(dev, "bus-width", &bus_width);
+	if (bus_width == BUS_WIDTH_8 || device_property_read_bool(dev, "ti,suppress-v1p8-ena"))
+		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
+
 	sdhci_get_of_property(pdev);
 
 	return 0;
@@ -940,6 +971,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);
-- 
2.49.0

