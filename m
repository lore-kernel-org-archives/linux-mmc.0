Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66544160F;
	Fri, 24 Jul 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904632; cv=fail; b=KIbDG18w825IqgXRfYIQEh+6JVUnMMtdQdKOkxeKRubwUkernHyfgQOFe+ceZoP9Zr1koUWuc9+TVJKccFX+gaox/oGtqWEVH8O1O0ZXfJuv+fo4ltpND7fT/VML6n1L78+StXgLeLYFB6qZGdYj1PGtzVEgw1HrmEklGb0xjxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904632; c=relaxed/simple;
	bh=kZ40xiNpF1tSgRufjRh0L0J1IeoMBwMPK0PE3Z0V2DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ze58bO2QbFOGv3t5+bmmq3xO5tCVQsV2pbQgu8dYpCWu0ZqADCVdHsmxe2d9wuHJWa8amz+edhDKDWiILvpnnX3D0Cfin3TbecLO6MSS2uF4kgUCi/WGeDlCiMTRt6Ni9gt3jLnsexwbC1vgZTAQyTb95QBRrn2Cz06NOSaK4tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qWt+nzEm; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qWt+nzEm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTyAlMhLSew11d3v6ebC0XkyJEs8CvJoGhnGoN4iWlt2HbVx3Pv/VXv8Rbf7haXyR2g5gZGmczWwRZ0QYjHFxe2vVHSv7HusxKTaIQ+haXg2odSpmVoGoNeYJAbdU91fjAPI7ey1QMj0FCAoMCXY39b12f48UWLQ6a0q1woUrHcpA6cYZ8DjtCFyuGvYhUQW0kPfMLrkztt1SayqqUqX833Y70/F8vX2F82q8vmmAOoJx2T+TBKEQLNqVTFFD4LHGWt8Duj+Qt9o+qyCDTcy3nI5jVFabRt0fkshfCUmRp7juNqdrLuXMrxVVahCLqCSRwTloGgjxRJjMXM8tMfKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5qdT7cfl4vey3chcqnEWfXQXEz0gmvfVlgP6JeNCrI=;
 b=Vhnlmfc+XaR9csJyqV1WuGaLuBiCQhOd3d5iTaLOopahsILNKwVRTB4j/bpwjVgLIYQfKtkRlGyjlz9v80BzmRjabai09V0bbu/zghCRq42OI2FakdeRbzHUxfn+Cc+oQBKBzPD5W4sK1RjkKFp+7Z1ePWfsnWTFbxzpDGWxEdk2luNqB/aLt2zUB405jlb1gqX6vSyqQhZrbxN1uVtT2/ZwOsHV2IGUqR5ueoq4ocDReLid5N/5nxs7JgJ5R79wFWWZYye9BL0PS++q43Eg7RXOpy2Tgyba3XCfJ4wUuOzYOoqkRoG/fk0nG7eSt1P21mJXEYXeYBfvZ87sJhtAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5qdT7cfl4vey3chcqnEWfXQXEz0gmvfVlgP6JeNCrI=;
 b=qWt+nzEmr8f7XmXtDTVmUm+nnnBKAkeYeX6suajiFqbvaGKdONyh5cOh+uuE2cZazI3GXTVITVmr06mocICzdcWhd2uvbzMavD9603p5wKgtzpClhVfG0jUotY0nsKJozl99EFjp9sqNvb0G2mVpOstwWqYlLPUO/U4i/UeJQomfX1FaTAotn7x3z7Ox3db2MmvS2okeUspQ6kbqknajtm5+QXKwXA0xzsH+hN/q289fFTOAyk7HIKamUWuavOCoCGv4qCRHeLCnhqr3GQcG+viS/XYozeUj3Fjgoc4DaWXRlubuxR1UjkAn3uhIF6RrY+OWu8EoI8HcSlGkA8RiFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH0PR03MB6978.namprd03.prod.outlook.com (2603:10b6:510:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 14:50:26 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:25 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] mmc: sdhci-cadence: add Altera Agilex5 SD6HC support
Date: Fri, 24 Jul 2026 07:50:07 -0700
Message-Id: <20260724145009.7456-8-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH0PR03MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ac37e3-5cb4-46b1-88fd-08dee992e542
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|56012099006|11063799006|10067099003|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NmqCh65y9ByV9NivR6q2JiO3Pvouogw053AYPFctWBX+2Q7Gu6539fuHBgCz+uGk+6chviUPtaKpv8Ux15LIUlHvke8wGxtoS5soIbpc2D3VpujHuf/NIA9cPmlou/D8TgLKwg0YN68Vex2PL83tG4vHjlD7jjoz0RITcIeb+rSyq6Mmxc+l8wMMBQLAurAA79aVExbnCTlfG1Bu56bwNtY0wf93vZRmFPr3teHlsT1Yk37RZF4zgDs/mo+x/Ul2ndQkzxX6ongfUvdEr57yLiKOXoVKhrj9552dIZ+naqoqU/fx/h0gXsI+bBJ7ZeuQbFITPG9hj6V93Lm0dR9YpHxpAfo/ba0tSf/PMMtd9//TgrQTueIVukZJ2yd9O3jzL6B1Mfjzte+4tOyl32IswPz6IBK8a0mLwjduCXCOe8MrgEgyUP+1A8dBIqGIL3FEUdlv3oelIe/8iMO3Uc5T4oGu3uT4m+ZwzTay8OgX1OCjxhX4jNhx2hsY/3XLo2+NQXaKR1uDKjQ0OM+zxYvZj2JUR0KEZ5PObFuNpZ857FTFyB+XEOnhO380ZygIv5DC07rGF3FiDw4r4uYwH36Pkz6jlxD6IzflTRH1RVKD6dXmNPVdPYylM23kxySSfdtVbb6XwxIP5eDPiRKRzckZ1bUr+TwG/Kga9lDgYrQ8kgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(56012099006)(11063799006)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hO6A2W1aPqSkWi8ks4j1oHDfK7yfv6mYHHI3A6zIuWjZw3fV63ILgugqRbr7?=
 =?us-ascii?Q?nwGMEkhJ0ROR42OXWPD873MmANl92HI61+7bQKaTc4WyNPXTwZ5CIKLvTEdT?=
 =?us-ascii?Q?im3/noxc29OD8FjnmEF98awotc2rCpZv8Ls1TFURBnQDgmPMpgxG87VbP7id?=
 =?us-ascii?Q?oI34Gu98jebMoeEpHhfrEbSebbceTWHmN0mozTeSSY2VGq51D9Vmnn7PaBQP?=
 =?us-ascii?Q?/GkBBPsEbNLK+PNn9NuYK6QhuNpkwXTv47CfWF2cjmm76gwJa+qSCNxleG1A?=
 =?us-ascii?Q?Rj7y1DxKKfBJbAcpsTFXsFENzvvALCfN2HbBqT8wUeUbs6CkCvx7hQeRB0Ro?=
 =?us-ascii?Q?0Qpdl+v4jH11oAKJCHDAVYktr9G9olG2vXCa45ZEeLTt3r2OSOUiaXaT0QxK?=
 =?us-ascii?Q?jN2l9nkWcQ/8GU+M1l6JQIMWrmmADmSHejTDMhjK0yj4EC0m2v6gpq/zLyhy?=
 =?us-ascii?Q?VuTF+qdeTmtVV47Trz1u+duEvtuhrpyfAbh2BKxnVwdxck3fF14JHoDampn/?=
 =?us-ascii?Q?CaN06qn5Hdvesuv/Yma7oPyQkHRgxtNMQvwkfp5aEUf4Pg1SSBsKK2eF3Npu?=
 =?us-ascii?Q?c8dnQalEzWO0ipg7bB1UEJwlzyhZHSXu73TXH1r6/fK6s1FxySHbPPCplHBl?=
 =?us-ascii?Q?poePEFSZT9qr9+khbyqOE1kKj9igxiA2+w44xWL4hE1qwFBImIaFKvXEg9hN?=
 =?us-ascii?Q?jSae+CbMcezqJjn3rJh+i7i0YJbRlM5qKLJHmVZ5fKnqO15I6imyOrz+cAXz?=
 =?us-ascii?Q?G2n+9GW5vJjisOtDZ6t6Ru+ztQUObp0JjriOnFUaYGccaJ/wx8EEf5teb2d3?=
 =?us-ascii?Q?UswfmEa6PGTaS0A6Q3HQnfLqHsZbiCfA0r/I4n9+2UBAJZEAnN79lutd4COF?=
 =?us-ascii?Q?5fqkK1oVrrtLeTvCjjeC+HAyYN2My/uIb0S94hnnRNnKhWS7O0OqemXieAWY?=
 =?us-ascii?Q?UZGkOdKvUbDOTJIR4uZo60GfIc9kPdI3+KoNve/ueHWxjQAbte6bOAwKgt0G?=
 =?us-ascii?Q?AT/3i5CdQ/C496JqKUiJcsl168vvIoTVaJdm9H0BEk04/jD/VEfNc2jEWfxz?=
 =?us-ascii?Q?VxUpWwgvTj2IJ0PUWVY5Rrs38IMsc+jLAzqxUuifUjRI56MuURSGm6ASb7q8?=
 =?us-ascii?Q?05tQ38Tl8S5ASKTNs/Vfx2xtEzEkf3TC5fIx5/is646xuRTSylAa2ZpeIM96?=
 =?us-ascii?Q?6X5RcuLen5Vgoi/U6Afxc59ZsOZ1vHRHnlC0G7OtnhkQmH4CH5Xb9L6sI3gL?=
 =?us-ascii?Q?Y09pR5uwz0wxuD3ODJwiZfOS7a3WaChxr69hSAbvhOjEB9Q+w2E1V6UKiJb8?=
 =?us-ascii?Q?LrspK//0BuDgPAoSvJZomUi/7oVIIeQHvzGtz6MFVqY93ak1O9lldG4kDxfU?=
 =?us-ascii?Q?zQX2yGcf6VIYO1yupzSpJ6OYv6hoEwee7LWyuMsQhbWA/onZA5HOFpWgkgtx?=
 =?us-ascii?Q?YNgF1DnRPT5RIEJTz5znXcqxorxlJh0fYIV490j++OQlsYo99D+Mp6ZpHMjH?=
 =?us-ascii?Q?mubrJCdpu6lQPBZokKqUlQ3zD1UunRfplNmFFfMLoyrDPRNO5VXFkBdMvacj?=
 =?us-ascii?Q?87ied4QAgE00L2rx0Z+ZfUPxMrV+GjPN30j3o1WXDOhJjYvxzk9I1z8a9FlT?=
 =?us-ascii?Q?zNwIOwuL23QdqDsRdIkidvKjm3KbL60/k20LQIK7hlcmG0NQaxIsJd3ZXfIr?=
 =?us-ascii?Q?keU4nBxOB+g8GYYSeB4229DELuDTTlJYb8/HUPlznOEUKhBHc/+jXjdeUPHz?=
 =?us-ascii?Q?OTBmAoFQIHtxv3ifFGWsnDLu6WCbDyU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ac37e3-5cb4-46b1-88fd-08dee992e542
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:50:25.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKzAXYcaJz+A/riYS8O0LhvZS7NjwdA08u/h4nmcWnGl017HEL3mi8Q8idRAkKGR27B30C3adWdnlCQiNQKG0ALxWzAwkd4GXUUpMCyeZKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6978

The Altera Agilex5 SoC integrates a Cadence SD6HC controller that needs
platform-specific configuration to operate correctly.

The SoC requires three named resets: "sdhc-reset", "combophy", and
"sdmmc-ocp". All three are exclusive and must be asserted together before
being released, so the SDHCI, SoftPHY, and OCP/AXI clock domains cross the
reset boundary simultaneously. SoftPHY is shared with NAND at the SoC
level, but only one of SDMMC or NAND is enabled on a given board.

The IOMMU maps DMA addresses within a 40-bit physical address space, so
the DMA mask is capped at 40 bits to prevent allocation beyond the
controller's reach.

The silicon requires the MULTIBLOCK_READ_ACMD12, CAP_CLOCK_BASE_BROKEN,
PRESET_VALUE_BROKEN, and ACMD23_BROKEN quirks. Since
CAP_CLOCK_BASE_BROKEN prevents reading the base clock from the
capabilities register, the maximum clock is supplied from the platform
clock instead.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/host/sdhci-cadence-core.c | 113 ++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
index 18846acc0b11..24130655a385 100644
--- a/drivers/mmc/host/sdhci-cadence-core.c
+++ b/drivers/mmc/host/sdhci-cadence-core.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
@@ -90,6 +91,7 @@ struct sdhci_cdns4_phy_cfg {
 struct sdhci_cdns_drv_data {
 	int (*init)(struct platform_device *pdev);
 	const struct sdhci_pltfm_data pltfm_data;
+	u64 dma_mask;
 };
 
 static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
@@ -196,6 +198,23 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 	return host->max_clk;
 }
 
+static int sdhci_cdns_set_dma_mask(struct sdhci_host *host)
+{
+	const struct sdhci_cdns_drv_data *data;
+	struct device *dev = mmc_dev(host->mmc);
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data || !data->dma_mask)
+		return 0;
+
+	ret = dma_set_mask_and_coherent(dev, data->dma_mask);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
+
+	return 0;
+}
+
 static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
 {
 	u32 tmp;
@@ -462,6 +481,72 @@ static int elba_drv_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int sdhci_cdns6_agilex5_init(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *rst_sdhc;
+	struct reset_control *rst_combophy;
+	struct reset_control *rst_ocp;
+	int ret;
+
+	/*
+	 * Assert SDHCI, SoftPHY (combophy), and SDMMC OCP/AXI resets together
+	 * so their active periods overlap before all domains are released.
+	 * SoftPHY is shared with NAND, but only one of SDMMC
+	 * or NAND is enabled on a given board.
+	 */
+	rst_sdhc = devm_reset_control_get_exclusive(dev, "sdhc-reset");
+	if (IS_ERR(rst_sdhc))
+		return dev_err_probe(dev, PTR_ERR(rst_sdhc), "failed to get sdhc-reset\n");
+
+	rst_combophy = devm_reset_control_get_exclusive(dev, "combophy");
+	if (IS_ERR(rst_combophy))
+		return dev_err_probe(dev, PTR_ERR(rst_combophy), "failed to get combophy reset\n");
+
+	rst_ocp = devm_reset_control_get_exclusive(dev, "sdmmc-ocp");
+	if (IS_ERR(rst_ocp))
+		return dev_err_probe(dev, PTR_ERR(rst_ocp), "failed to get sdmmc-ocp reset\n");
+
+	ret = reset_control_assert(rst_sdhc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to assert sdhc-reset\n");
+
+	ret = reset_control_assert(rst_combophy);
+	if (ret) {
+		reset_control_deassert(rst_sdhc);
+		return dev_err_probe(dev, ret, "failed to assert combophy reset\n");
+	}
+
+	ret = reset_control_assert(rst_ocp);
+	if (ret) {
+		reset_control_deassert(rst_combophy);
+		reset_control_deassert(rst_sdhc);
+		return dev_err_probe(dev, ret, "failed to assert sdmmc-ocp reset\n");
+	}
+
+	/* Hold resets asserted long enough for all clock domains to capture. */
+	usleep_range(10, 20);
+
+	ret = reset_control_deassert(rst_sdhc);
+	if (ret) {
+		reset_control_deassert(rst_combophy);
+		reset_control_deassert(rst_ocp);
+		return dev_err_probe(dev, ret, "failed to deassert sdhc-reset\n");
+	}
+
+	ret = reset_control_deassert(rst_combophy);
+	if (ret) {
+		reset_control_deassert(rst_ocp);
+		return dev_err_probe(dev, ret, "failed to deassert combophy reset\n");
+	}
+
+	ret = reset_control_deassert(rst_ocp);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert sdmmc-ocp reset\n");
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_cdns4_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
@@ -481,6 +566,18 @@ static const struct sdhci_ops sdhci_cdns6_ops = {
 	.hw_reset = sdhci_cdns6_hw_reset,
 };
 
+static const struct sdhci_ops sdhci_cdns6_agilex5_ops = {
+	.set_clock = sdhci_set_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.platform_execute_tuning = sdhci_cdns_execute_tuning,
+	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
+	.hw_reset = sdhci_cdns6_hw_reset,
+	.set_dma_mask = sdhci_cdns_set_dma_mask,
+};
+
 static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
 	.pltfm_data = {
 		.ops = &sdhci_cdns4_ops,
@@ -508,6 +605,18 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
 	},
 };
 
+static const struct sdhci_cdns_drv_data sdhci_cdns6_agilex5_drv_data = {
+	.init = sdhci_cdns6_agilex5_init,
+	.pltfm_data = {
+		.ops = &sdhci_cdns6_agilex5_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+			  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			   SDHCI_QUIRK2_ACMD23_BROKEN,
+	},
+	.dma_mask = DMA_BIT_MASK(40),
+};
+
 static const struct sdhci_cdns_drv_data sdhci_cdns6_drv_data = {
 	.pltfm_data = {
 		.ops = &sdhci_cdns6_ops,
@@ -709,6 +818,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "cdns,sd4hc",
 		.data = &sdhci_cdns4_drv_data,
 	},
+	{
+		.compatible = "altr,agilex5-sd6hc",
+		.data = &sdhci_cdns6_agilex5_drv_data,
+	},
 	{
 		.compatible = "cdns,sd6hc",
 		.data = &sdhci_cdns6_drv_data,
-- 
2.43.7

