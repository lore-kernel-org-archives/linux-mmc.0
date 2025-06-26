Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB22248B3;
	Thu, 26 Jun 2025 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979698; cv=none; b=GoYR21uxMprf4HPiCO1n1vlGuy/QDKT2uRzDcuVYtZ4ezt+Jf3IAAhoPcoIoeswawRZHBTzv5HTVSAB2ERRJxN3Ct5QcJwzoY0WizlzDkOxYhAAer8ekYtZSnO9gJlQ8u14/dXU0I9xBNc+xG4zDEjtnEWDg720deXc3xVXNPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979698; c=relaxed/simple;
	bh=fk8p9KMCoaUoBwdZllXsBYwYaEmIv4RjCoPM4Ek8oVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f/jjcSJvwPS9+lyEmsYum+bawzXlA2mYhJB1tmMYsU2U7W5UwZJkA16da2K3ZNgSB45v/sEc5SpmbUQYqWcCFCl8r+8+NTUoQWjUoamRbFsUonNf/WchJwOO8cDRbB4oh0q+EstlD0GCY9uU3KwaSjtv0s1V54Qir7Nml4c8TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w1Fcz8k6; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w1Fcz8k6"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QNErfg1866078;
	Thu, 26 Jun 2025 18:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750979693;
	bh=X3M2xnySk4XeHRTFPNC0WLhM6pqnnTecchiA5LMXI9s=;
	h=From:To:CC:Subject:Date;
	b=w1Fcz8k6G2CngKUgP3Ohox1PNNVIVbUWRvd0R0YDHuOmgBEVoO011ztGhVZxpELCQ
	 wQaLgQd2AlsvitBFKLZc/dSLwATKnNggB3YVY0t4KIo5ezKmhm75ofYu0+Y4+yf8fQ
	 /bIB6RR5tbQKzyd25SL7Geg4GcW2J6EUZQ0YBjDY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QNErPC2408025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 26 Jun 2025 18:14:53 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 18:14:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 18:14:52 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QNEqql2059317;
	Thu, 26 Jun 2025 18:14:52 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian
 Hunter <adrian.hunter@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci_am654: Workaround for Errata i2312
Date: Thu, 26 Jun 2025 18:14:52 -0500
Message-ID: <20250626231452.3460987-1-jm@ti.com>
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

Errata i2312 [0] for K3 silicon mentions the maximum obtainable
timeout through MMC host controller is 700ms. And for commands taking
longer than 700ms, hardware timeout should be disabled and software
timeout should be used.

The workaround for Errata i2312 can be achieved by adding
SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk in sdhci_am654.

[0] https://www.ti.com/lit/pdf/sprz487

Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes since v1:
- Split series [v1] according to Vignesh's review comment in v1
- Add Adrian's tag

v1: https://lore.kernel.org/linux-mmc/20250624221230.1952291-1-jm@ti.com/
---
 drivers/mmc/host/sdhci_am654.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index ea14d56558c4..86d87d8e0675 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -613,7 +613,8 @@ static const struct sdhci_ops sdhci_am654_ops = {
 static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 	.ops = &sdhci_am654_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_am654_sr1_drvdata = {
@@ -643,7 +644,8 @@ static const struct sdhci_ops sdhci_j721e_8bit_ops = {
 static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
 	.ops = &sdhci_j721e_8bit_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
@@ -667,7 +669,8 @@ static const struct sdhci_ops sdhci_j721e_4bit_ops = {
 static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
 	.ops = &sdhci_j721e_4bit_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
-- 
2.49.0

