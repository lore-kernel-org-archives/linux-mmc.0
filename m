Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F318D;
	Thu, 24 Apr 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517656; cv=none; b=Bno/RrDv23ESPvwzlU5lVP52sE2w8uNef+x+vpvWd+5NbOkR866lQ+JfxXhRj5y0TVnrxuqLWjzrvCPjjrK8VA6O1jEgXb7FavU0cnbtMvQ7kjg2JNNhvVnypbUIDiFtJ0Bzcx76BynRzODZnxG1+UAlh5up2iTU8bWLFAVKz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517656; c=relaxed/simple;
	bh=I2Aqk3xSqsy9ym17LfDdvWjUNcKFRQvtoEpQyv9Z6bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNkQf0ZT6IUh19NfIpVb56xKxfa/mdMu1vv9kXb+m3xHJBh2llpBe1B2R0pzjM1Bh1jFIMA2cKhDwolK8IfKJsPrzAM7/OzijJB7xTkGezVn9Fut1UFEPojtnyp/2VD3NqVRqWIAvgjsKi0prv4Hk2dGpg9KaETMsILaj/ZQjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=scXv6w/n; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="scXv6w/n"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53OI0aNE1922157
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745517636;
	bh=/1jcslskYE+cn3dxBhaRoRiSx0ugXy3HjaxmHiZ15CI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=scXv6w/niLTMDHHIegOqcMuYGCIMVjBKI+jzmmyH1m6br1XxNlm2qkzNsvdbtTrY4
	 b5OdhfsoEiDCRWkgTqCwz0JVfxGL3luUp13UW4nbmS4WhB0btiDsE0hLnEjjWByLEn
	 U3v64RfJGZg+Stg2M9mAQ2GylO7voN3WwWvspKOQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53OI0apf025489
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Apr 2025 13:00:36 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 13:00:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 13:00:36 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53OI0acA054845;
	Thu, 24 Apr 2025 13:00:36 -0500
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
Subject: [PATCH v4 2/2] mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk to am62 compatible
Date: Thu, 24 Apr 2025 13:00:36 -0500
Message-ID: <20250424180036.1541568-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424180036.1541568-1-jm@ti.com>
References: <20250424180036.1541568-1-jm@ti.com>
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

This fixes MMC init failures seen across am62x boards.

Fixes: ac5a41b472b4 ("Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"")
Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
Cc: stable@vger.kernel.org
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f75c31815ab0..dd550587d48b 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -650,6 +650,18 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
 	.flags = IOMUX_PRESENT,
 };
 
+static const struct sdhci_pltfm_data sdhci_am62_4bit_pdata = {
+	.ops = &sdhci_j721e_4bit_ops,
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_SUPPRESS_V1P8_ENA,
+};
+
+static const struct sdhci_am654_driver_data sdhci_am62_4bit_drvdata = {
+	.pdata = &sdhci_am62_4bit_pdata,
+	.flags = IOMUX_PRESENT,
+};
+
 static const struct soc_device_attribute sdhci_am654_devices[] = {
 	{ .family = "AM65X",
 	  .revision = "SR1.0",
@@ -872,7 +884,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 	},
 	{
 		.compatible = "ti,am62-sdhci",
-		.data = &sdhci_j721e_4bit_drvdata,
+		.data = &sdhci_am62_4bit_drvdata,
 	},
 	{ /* sentinel */ }
 };
-- 
2.49.0

