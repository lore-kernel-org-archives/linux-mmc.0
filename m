Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2925A659;
	Tue, 24 Jun 2025 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750803168; cv=none; b=PXIiI/NW1lH/r+H/kHMB8heIXsXTnIwVj/6GW6zY6l8hpo79mznFWWb+nuB2VNcUaFNrvLEZqqMS/jXNFrOn6fE9/OTg7eDHHE1I3pC64IlnhOPmvpThPiutMxuSIJPvSa5qVV+fXVDhfNpx1tdwZylRZQjvUPP3Vb/JfcFSl8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750803168; c=relaxed/simple;
	bh=xt9KCza3hF+I3TXVvossfA/VxjFiivbpY4QJvk6e78Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUPiSw4E/omnPi0YVgM9l9XxmM6lnuOkNxnvv3+avpZUtz9ZFGP7J9D0YHH7gMp6K2PaOx1paL1nyfXiJWlrofa1+Nv+fth8ni2S3onzs24GcMtOlGqhN/rHY5WYApI9KgHPQuhcRw6Z/FUn+fK3O57ZHdP/JLlkSMZt9MylB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q/C8aypI; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q/C8aypI"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55OMCW091932981;
	Tue, 24 Jun 2025 17:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750803152;
	bh=ojILrlT5GdYiZsRAu4Z0+07jzeXbFv6th3HqKBTAOPI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Q/C8aypINr0GbGpr70qx+72VWvjCZs7FLnJTrZxQ1iQYcgNLO1A/9yGg+Ljb0nV/K
	 bULy4zbhqQG95V94gIm8SyfbY4s+x7wKa0Tcn9OAgzMosO72H3+8JICa3NRoApZeko
	 MLAC5Zm72cqWdoCxOEPe1BcbjBXIROeo0BKq9f4o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55OMCVPd398618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 24 Jun 2025 17:12:31 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 24
 Jun 2025 17:12:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 24 Jun 2025 17:12:30 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55OMCU9K2248346;
	Tue, 24 Jun 2025 17:12:30 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian
 Hunter <adrian.hunter@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 1/3] mmc: sdhci_am654: Workaround for Errata i2312
Date: Tue, 24 Jun 2025 17:12:28 -0500
Message-ID: <20250624221230.1952291-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624221230.1952291-1-jm@ti.com>
References: <20250624221230.1952291-1-jm@ti.com>
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

