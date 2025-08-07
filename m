Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184891E520E;
	Thu,  7 Aug 2025 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607118; cv=none; b=rTCQ6P3q4if60pO80wdwCBORcmQNwFDTj/Dl3Di5+wvFI1PdPlnU0KvngEogzyFNwzVTYu/14XWyKDajmzpOIxBeYOYL9bKT02g+rcoCwKiRZavCCUSVOFrKsf6kfdxzYekvZ5AsFEyF/tnsPK+4cRf97ofbECvrwYZUK8NbTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607118; c=relaxed/simple;
	bh=ifEk9XiHBUJhrgRppkVnNbmG6CicxlImAh/c3lOPQ+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGgZbaMFBBk5gpA7xxHSRmJcK8lTsd+cTAHI7uxSjssq3dB3AxwR6NsBXt+IDS1TaD4UQc4lAwqCnPr+L9zcfgkJg7DooNkAgNCIchnOJVbUavK4FZmYWtgrWsVbcDGQ6L6Hme1qSqUXfGElmMGK4MYXnBNhAQGpVHxfz5AEpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oGRfFef8; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oGRfFef8"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 577Mpd6j455842;
	Thu, 7 Aug 2025 17:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754607099;
	bh=IxkJSvKRuzPA9t8eldc0BIsl4eC3AOj1pVeWGxFhkCE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oGRfFef8uj+phBfLv7KTgfXqCDd0f/QDYUvrrGySRTlSj4NULKGRiPjqsgDV99WDU
	 EaE9nyCwlQ8AuyTTJRIlrC8jgKu1t+33houO3G+ejhWeSnomAdsANx+b3+m9wMCYVO
	 9zEAMgXTq7YQxkzMuGF5tRRczY1Ki8f3c2MjybJo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 577MpdSF1137035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 7 Aug 2025 17:51:39 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 7
 Aug 2025 17:51:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 7 Aug 2025 17:51:38 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 577MpcBk2086622;
	Thu, 7 Aug 2025 17:51:38 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/2] soc: ti: k3-socinfo: Add support for AM62P variants
Date: Thu, 7 Aug 2025 17:51:37 -0500
Message-ID: <20250807225138.1228333-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250807225138.1228333-1-jm@ti.com>
References: <20250807225138.1228333-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This adds a support for detecting AM62P SR1.0, SR1.1, SR1.2.

On AM62P, silicon revision is discovered with GP_SW1 instead of JTAGID
register, so read GP_SW1 to determine SoC revision only on AM62P.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index d716be113c84..81d078f15cd2 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -15,6 +15,9 @@
 #include <linux/sys_soc.h>
 
 #define CTRLMMR_WKUP_JTAGID_REG		0
+#define CTRLMMR_WKUP_GP_SW1_OFFSET		544
+#define GP_SW1_MOD_OPR				16
+
 /*
  * Bits:
  *  31-28 VARIANT	Device variant
@@ -66,6 +69,10 @@ static const char * const j721e_rev_string_map[] = {
 	"1.0", "1.1", "2.0",
 };
 
+static const char * const am62p_gpsw_rev_string_map[] = {
+	"1.0", "1.1", "1.2",
+};
+
 static int
 k3_chipinfo_partno_to_names(unsigned int partno,
 			    struct soc_device_attribute *soc_dev_attr)
@@ -83,7 +90,7 @@ k3_chipinfo_partno_to_names(unsigned int partno,
 
 static int
 k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
-			  struct soc_device_attribute *soc_dev_attr)
+			  struct soc_device_attribute *soc_dev_attr, u32 gp_sw1)
 {
 	switch (partno) {
 	case JTAG_ID_PARTNO_J721E:
@@ -92,6 +99,14 @@ k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
 		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
 						   j721e_rev_string_map[variant]);
 		break;
+	case JTAG_ID_PARTNO_AM62PX:
+		/* Always parse AM62P variant from GP_SW1 */
+		variant = gp_sw1 % GP_SW1_MOD_OPR;
+		if (variant >= ARRAY_SIZE(am62p_gpsw_rev_string_map))
+			goto err_unknown_variant;
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
+						   am62p_gpsw_rev_string_map[variant]);
+		break;
 	default:
 		variant++;
 		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0",
@@ -121,6 +136,7 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	struct soc_device *soc_dev;
 	struct regmap *regmap;
 	void __iomem *base;
+	u32 gp_sw1_val = 0;
 	u32 partno_id;
 	u32 variant;
 	u32 jtag_id;
@@ -163,7 +179,14 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
+	if (partno_id == JTAG_ID_PARTNO_AM62PX) {
+		ret = regmap_read(regmap, CTRLMMR_WKUP_JTAGID_REG +
+				  CTRLMMR_WKUP_GP_SW1_OFFSET, &gp_sw1_val);
+		if (ret < 0)
+			goto err;
+	}
+
+	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr, gp_sw1_val);
 	if (ret) {
 		dev_err(dev, "Unknown SoC SR[0x%08X]: %d\n", jtag_id, ret);
 		goto err;
-- 
2.49.0

