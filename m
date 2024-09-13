Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C582D70;
	Fri, 13 Sep 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253654; cv=none; b=t7TFFIGQuJafrynIO5/ugYaUqu5aDB+DYpoQ2NYhTko8xdloOMKDrL+QXa9MlNrJPFVQbeu7YiCSbi3rQ/q6ABx97Si724CIM5Ui07JOmzDbHQu1lhQvqvIoxFnldcO/9e2xka09BE/Ymb8enMU1l64RQxcg7k568WznBQlxXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253654; c=relaxed/simple;
	bh=2umMFuyC59HJUchrynLNf3a9oiPhTTsMl8Qhzz8cPXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ss4l+c2aZ3trvmJ1kAnN004nRQvIr8udO+bnZMLl/knrBs9AC9/8MshCLQIGjs6N9MeTNPNFcJUUvb22pN7YOjFAHpuAp0H2kfoKfz/MnzHbU2dt9hVYnz+dqGjts+9Q3aS0uqL79pztcIjNVR576EAyVK+a/nWsjBrcJYOA7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iZ25hX07; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iZ25hX07"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48DIs3hI097808;
	Fri, 13 Sep 2024 13:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726253644;
	bh=9NplcwqAcUBPdkGVhuqmZ/8tZIV84nJKWo9I13pK8GQ=;
	h=From:To:CC:Subject:Date;
	b=iZ25hX07GExWlzx6dNmFiRuYev7waBJFqD72RHGqq2jgB5oRqv4JL+O2N87+pb4S3
	 KxCYoeAKD92XCr9cWMOScmim4GbSqBxuQEic2hqZqBp3zbmiqITGu+J4+/eb+mBCEQ
	 6lthyKVVBOenTfV5t+UmPti7hSoQNINe7y+ILY/A=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48DIs30J031793
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Sep 2024 13:54:03 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Sep 2024 13:54:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Sep 2024 13:54:03 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48DIs3km008526;
	Fri, 13 Sep 2024 13:54:03 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
Date: Fri, 13 Sep 2024 13:54:03 -0500
Message-ID: <20240913185403.1339115-1-jm@ti.com>
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
Changes since v1:
- Invert quirk logic
- Simplify sdhci_am654_start_signal_voltage_switch() and call
  sdhci_start_signal_voltage_switch() when the quirk does not apply
- Simply logic when detecting when quirk should be applied
---
 drivers/mmc/host/sdhci_am654.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 0aa3c40ea6ed8..9ff07aadb2d91 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,6 +155,7 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
+#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
 };
 
 struct window {
@@ -356,6 +357,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
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
@@ -844,6 +868,11 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
 
+	/* Suppress v1p8 ena for eMMC and SD with vqmmc supply */
+	if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
+	    !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
+		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
+
 	sdhci_get_of_property(pdev);
 
 	return 0;
@@ -940,6 +969,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);

base-commit: cf6444ba528f043398b112ac36e041a4d8685cb1
-- 
2.46.0

