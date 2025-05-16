Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24452222B2;
	Fri, 16 May 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427500; cv=none; b=YAFNF1CKFW/xv97rQKsdKGIp8s5eIHB9pYbMtfesQf8taW3noJcthgOZEDa/i19uTI/b/zzld5UeTcmQ+O/z0DQz9n7T9tyOYrRtQAaFKkv4eAWZAiL6oEB/3wC7jwAX2GJ9KBYRwwpk5gZYKfBDEuTdFhGSxS8/PscU83bC0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427500; c=relaxed/simple;
	bh=qTJ9PhQppKfr6sTEGZkSzY3sxbqWKV4iAdv2JVLwdh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HtTy1yQwWNJ1w4WibJVVkjs3Efll+saj6OiVEv7/bgyaAjtoW1HsHPEanOrcLdUZx/ub0v34/r5oYFhk67QWOuGSsmbGfAaHBKT3ZmXgR4L0aLTA7s7I1rKJWIeJ9NRBqVyq67XKLQbtTGbpV/+jpEqc4nvGwKMZ+bXWR3cwgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KFfuKVI4; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KFfuKVI4"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54GKVMEg3823228;
	Fri, 16 May 2025 15:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747427482;
	bh=q5jd8Ds/yfDobLR7+jYkuWBZogZM9/eXyQcFuNW2VFY=;
	h=From:To:CC:Subject:Date;
	b=KFfuKVI415YzdgFKokiz4dnQ0gNrn7QgHjeDd8ASyuLJpfa9DukQGk+SN73Gdvyh6
	 gPDOZVgmeBCrdLGzSfZ+cJ05XXqbiy7VzUCkzuJLFIF93Mj8NtknRsmxGsLyxpc2oY
	 c+nv8UhPQyIlMznRiGCCpUzi57iszYGUCWJHsuwI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54GKVMMJ156872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 16 May 2025 15:31:22 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 May 2025 15:31:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 May 2025 15:31:22 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54GKVL0a020449;
	Fri, 16 May 2025 15:31:21 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>
CC: Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>
Subject: [PATCH v6] mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk to am62 compatible
Date: Fri, 16 May 2025 15:31:21 -0500
Message-ID: <20250516203121.3736379-1-jm@ti.com>
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

Add a new struct for platform data for the ti,am62-sdhci compatible to
apply additional quirks, namely "SDHCI_QUIRK2_SUPPRESS_V1P8_ENA", to
host controllers with am62 compatible.

Note, the fix was originally introduced by commit 941a7abd4666
("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch") but was
found to be applied too broadly and had to be reverted.

This fixes MMC init failures seen across am62x boards.

Fixes: ac5a41b472b4 ("Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"")
Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
Cc: stable@vger.kernel.org
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes since v5:
- Drop sdhci_am62_4bit_pdata
- Pick Adrians tag
- Add note to commit message

Tested on am62x SK, am64x EVM and am64x SK. Tested-bys are welcome

Link to v5:
https://lore.kernel.org/linux-mmc/20250514002513.1179186-1-jm@ti.com/
Link to v4:
https://lore.kernel.org/linux-mmc/20250424180036.1541568-1-jm@ti.com/
Link to v3 RESEND:
https://lore.kernel.org/linux-mmc/8678d284-db12-451a-b789-2b75f9932f9f@ti.com
Link to v2:
https://lore.kernel.org/linux-mmc/20250417182652.3521104-1-jm@ti.com/
Link to v1:
https://lore.kernel.org/linux-mmc/20250407222702.2199047-1-jm@ti.com/
---
 drivers/mmc/host/sdhci_am654.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f75c31815ab0..73385ff4c0f3 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,6 +155,7 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
+#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
 };
 
 struct window {
@@ -166,6 +167,7 @@ struct window {
 struct sdhci_am654_driver_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 flags;
+	u32 quirks;
 #define IOMUX_PRESENT	(1 << 0)
 #define FREQSEL_2_BIT	(1 << 1)
 #define STRBSEL_4_BIT	(1 << 2)
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
@@ -650,6 +675,12 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
 	.flags = IOMUX_PRESENT,
 };
 
+static const struct sdhci_am654_driver_data sdhci_am62_4bit_drvdata = {
+	.pdata = &sdhci_j721e_4bit_pdata,
+	.flags = IOMUX_PRESENT,
+	.quirks = SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA,
+};
+
 static const struct soc_device_attribute sdhci_am654_devices[] = {
 	{ .family = "AM65X",
 	  .revision = "SR1.0",
@@ -872,7 +903,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 	},
 	{
 		.compatible = "ti,am62-sdhci",
-		.data = &sdhci_j721e_4bit_drvdata,
+		.data = &sdhci_am62_4bit_drvdata,
 	},
 	{ /* sentinel */ }
 };
@@ -906,6 +937,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	sdhci_am654->flags = drvdata->flags;
+	sdhci_am654->quirks = drvdata->quirks;
 
 	clk_xin = devm_clk_get(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
@@ -940,6 +972,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);

base-commit: 8566fc3b96539e3235909d6bdda198e1282beaed
-- 
2.49.0

