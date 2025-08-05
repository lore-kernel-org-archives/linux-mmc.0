Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27A2BDC28;
	Tue,  5 Aug 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437814; cv=none; b=av8ox0pLxcXcAsG301faUWo6BPH9VNshujeGppshgT5l+svtz+TQbayngeV8mLwBI0M+v6opH6sNi8///5BQKnyRxgFXIkdBl6V1sToOg/4o4QcFb0MOPy7UzGd/evfx8WI/Lw/TQpZzDwOme8VCqx32XuiYylF3C04UVrrxCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437814; c=relaxed/simple;
	bh=y98rTCimIcBocg28bf5ZEqKcHSDMG73+7zkKaAH92OA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkvL892Z152/75TSMerWCMht0zICKh+hWFYE8cYIkK1HZP3hoiPIMZ8NcB2pBd2ikMqfXuThcuBFfZSPUcRlzttg18qPRP3usOam6yIFvoIwr/u76cf5HtZbXtVvKkRnFCf6DxA9BM4SiYUyA6+cEC7xvRA7/FMMiCgBDR6Ph5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AXk1ifyi; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AXk1ifyi"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575NnpSv4145370;
	Tue, 5 Aug 2025 18:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754437791;
	bh=UvHxejtAmgIijopXkaZv3LCB715mK7PNsMCmeGs/1aQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AXk1ifyiWw/PWZOtRCvyC/xEbzQ8A3XnNuPXKZiktd9q/W33Ru/MUzXJmPwl6oxK5
	 ryhZhdtJvR+hYk7VDldLvlXTPr3CbnxHi77e3riLcDx3fT4GWuxgD6LQ3BLxbfKIPM
	 +FHUzBbecX5SBZiHRfyiqzDjVWEjRp3EBd7vuCSE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575Nnpgp3796005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 18:49:51 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 18:49:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 18:49:50 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575Nno6o2624898;
	Tue, 5 Aug 2025 18:49:50 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 2/4] soc: ti: k3-socinfo: Add support for AM62P variants
Date: Tue, 5 Aug 2025 18:49:48 -0500
Message-ID: <20250805234950.3781367-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805234950.3781367-1-jm@ti.com>
References: <20250805234950.3781367-1-jm@ti.com>
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
register, so introduce GP_SW register range to determine SoC revision.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 82 +++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index d716be113c84..9daeced656d6 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -15,6 +15,7 @@
 #include <linux/sys_soc.h>
 
 #define CTRLMMR_WKUP_JTAGID_REG		0
+#define CTRLMMR_WKUP_GP_SW1_REG		4
 /*
  * Bits:
  *  31-28 VARIANT	Device variant
@@ -62,10 +63,63 @@ static const struct k3_soc_id {
 	{ JTAG_ID_PARTNO_AM62LX, "AM62LX" },
 };
 
+static const struct regmap_config k3_chipinfo_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static const char * const j721e_rev_string_map[] = {
 	"1.0", "1.1", "2.0",
 };
 
+static const char * const am62p_gpsw_rev_string_map[] = {
+	"1.0", "1.1", "1.2",
+};
+
+static int
+k3_chipinfo_get_variant_alternate(struct platform_device *pdev, unsigned int partno, u32 *variant)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	void __iomem *base;
+	u32 offset;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	switch (partno) {
+	case JTAG_ID_PARTNO_AM62PX:
+		offset = CTRLMMR_WKUP_GP_SW1_REG;
+		break;
+	default:
+		offset = CTRLMMR_WKUP_GP_SW1_REG;
+	}
+
+	ret = regmap_read(regmap, offset, variant);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static bool k3_chipinfo_variant_in_gp_sw(unsigned int partno)
+{
+	switch (partno) {
+	case JTAG_ID_PARTNO_AM62PX:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 k3_chipinfo_partno_to_names(unsigned int partno,
 			    struct soc_device_attribute *soc_dev_attr)
@@ -83,8 +137,10 @@ k3_chipinfo_partno_to_names(unsigned int partno,
 
 static int
 k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
-			  struct soc_device_attribute *soc_dev_attr)
+			  struct soc_device_attribute *soc_dev_attr, u32 gp_sw1)
 {
+	u32 gpsw_variant = gp_sw1 % 16;
+
 	switch (partno) {
 	case JTAG_ID_PARTNO_J721E:
 		if (variant >= ARRAY_SIZE(j721e_rev_string_map))
@@ -92,6 +148,13 @@ k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
 		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
 						   j721e_rev_string_map[variant]);
 		break;
+	case JTAG_ID_PARTNO_AM62PX:
+		/* Always parse AM62P variant from GP_SW1 */
+		if (gpsw_variant >= ARRAY_SIZE(am62p_gpsw_rev_string_map))
+			goto err_unknown_variant;
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
+						   am62p_gpsw_rev_string_map[gpsw_variant]);
+		break;
 	default:
 		variant++;
 		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0",
@@ -107,12 +170,6 @@ k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
 	return -ENODEV;
 }
 
-static const struct regmap_config k3_chipinfo_regmap_cfg = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-};
-
 static int k3_chipinfo_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -121,6 +178,7 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	struct soc_device *soc_dev;
 	struct regmap *regmap;
 	void __iomem *base;
+	u32 gp_sw1_val = 0;
 	u32 partno_id;
 	u32 variant;
 	u32 jtag_id;
@@ -163,7 +221,15 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
+	if (k3_chipinfo_variant_in_gp_sw(partno_id)) {
+		ret = k3_chipinfo_get_variant_alternate(pdev, partno_id, &gp_sw1_val);
+		if (ret < 0) {
+			dev_err(dev, "Failed to read GP_SW1: %d\n", ret);
+			goto err;
+		}
+	}
+
+	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr, gp_sw1_val);
 	if (ret) {
 		dev_err(dev, "Unknown SoC SR[0x%08X]: %d\n", jtag_id, ret);
 		goto err;
-- 
2.49.0

