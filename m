Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA31B87CF;
	Mon,  7 Apr 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744064832; cv=none; b=I57V/G13QxxUjPryTdDgSdYfKs/jt+Dynu1IfztFo11FNd9PVPfd+LxDs/T98T8AP/4RD/JTVL4wGFlUqlhUHtemTNuHki7QC6cE/ShuMY9feWVwBTffZlli8KG2fRD8Yrwtiu0mGxhGlYOE4Qc8LhYvOy5X1ebJMBcWd7TGR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744064832; c=relaxed/simple;
	bh=3J1mh/9jr3Z1l1jEQkPqepNo70bUmp7B+1t9mwsfq88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYlE9IKTxFp/v/RHKukmIaoxNv2u/tkFfdX+RhvX/TLb++xKZwvH1WKplcfmFjVAGQ4jpQe3gKMqvCeOWKPQrvjjMKsulyRuIif65k8ztjqFOs/p1jXGKQDFMun0Vb912CYhpo9iPQv/yM0rSYqATbqH9Uin7PRw4am22iKONwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NSQ99gxV; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NSQ99gxV"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 537MR2Tr1032955
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 17:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744064822;
	bh=YqPz2JfZvQwqwnoxsKSQiaQzed7EN3WPHYpwbOPCQEE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NSQ99gxVU1lCWYR+IbnjitnuPudRqnA5Y2y2UVoEjROqBtnCd/5L6lAtccAZTJqU8
	 mX9Hpsv5vM76fuPY4a0gHMpuKfd8SahcEmqrEdJkzQmuVw7a7sKchqZi1R+YnUQVOy
	 eBT0vrexkjEdLWOe98D6Fk+xh+bgxsWdT9/rRiBM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 537MR2Mh084617
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Apr 2025 17:27:02 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Apr 2025 17:27:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Apr 2025 17:27:02 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 537MR22A073249;
	Mon, 7 Apr 2025 17:27:02 -0500
From: Judith Mendez <jm@ti.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>
Subject: [PATCH 2/2] mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
Date: Mon, 7 Apr 2025 17:27:02 -0500
Message-ID: <20250407222702.2199047-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407222702.2199047-1-jm@ti.com>
References: <20250407222702.2199047-1-jm@ti.com>
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
V1P8_SIGNAL_ENA determines whether to launch cmd/data on neg
edge (half cycle timing) or pos edge (full cycle timing) of
clock.

The sequence is to switch to 1.8 IO voltage, set V1P8_SIGNAL_ENA,
change bus width, then update HIGH_SPEED_ENA & UHS_MODE_SELECT.

During bus width change is when eMMC failures are seen with
Kingston eMMC. So, do not set V1P8_SIGNAL_ENA by default.
V1P8_SIGNAL_ENA is anyways optional for eMMC and only affects
timing on TI devices. For switching to DDR52, HS200, or HS400,
we should rely on HIGH_SPEED_ENA, to switch to full cycle
timing after the bus width is changed.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 67a64de4972c9..4e1156a2f1b8e 100644
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
@@ -819,6 +844,7 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	int drv_strength;
 	int ret;
+	u32 bus_width;
 
 	if (sdhci_am654->flags & DLL_PRESENT) {
 		ret = device_property_read_u32(dev, "ti,trm-icp",
@@ -860,6 +886,11 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
 
+	/* Suppress V1P8_SIGNAL_ENA for eMMC */
+	device_property_read_u32(dev, "bus-width", &bus_width);
+	if (bus_width == BUS_WIDTH_8)
+		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
+
 	sdhci_get_of_property(pdev);
 
 	return 0;
@@ -956,6 +987,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);
-- 
2.49.0

