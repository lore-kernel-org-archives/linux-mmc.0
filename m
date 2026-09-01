Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DF4A012C;
	Tue,  1 Sep 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288561; cv=fail; b=CZLxWXDPBtrq5IkcuV3Niv5SZPOeM0ev6BvMxsWvjiNUiyEFam6N1DER3DuQFEjukioaLU0/oewr2hSwcoDZISjkSbdxQIhzIkOtC8zjzK4SNXcUqZWUJjGst7jRJok+ckfSzJekbOFX7AcLclFx5tlUiOK0+BqK+Ei0MiX4qX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288561; c=relaxed/simple;
	bh=UwUWb/J3jeqLNdTZBV0DslmjXf48K7xwzZjpkdPWCjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBxbQXSTHaX+xPyG4McfoL7HjL/tesweyjsmZRYZvDAXMtQ6+kOJmv/YBu8MPVPXkfEML8mH2JKDJF5sKRBEcbZDU4jYRcxr6hYo1ij5qp7H6a73HbdVSCUVFkbff2clJF6GsBp8VF5WJECnWfOO6iCIE82JJTUpG+bQddmcEnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=b6+OWQFM; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="b6+OWQFM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3gBSaavG1Yc0XqRqUkgR7ZrztL3EJzAOS68GoHZ9jZFvhl+6P91FawM8NnitAPQM9WNaCMqUhrMacT0TGq3JI8IZSaLUrsWMAp7cAFLpu7RdiR8QKI7hlCOLDKhxJvNUmzeGoVWf+L3nGU6GR6jKJIehiYc2d2Mg39xP5uUaGZ4GONOqyJ1OwywalYQvo8dr4lAFAvdjfgjuLppCRrUnPbX6h9vtDPd4ZhY25PSK6LFbt6658qcFJs4cuPoUsW7hMk2n/sPD2tyJ1axVf5IRxOUsH3pXRYD2AkX14x/5gr4y4FW1mQFvtiyoK3d0MJkNDAYoWHLbVeaN+VKJtIkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmNVaO9lbgNpk4UshzTDn6d1DO4KbqWExSGWPRM4X/Q=;
 b=kkhXNkwZx8auvDknTCzf/LZK8qKOwUr0uSYP0LtPTvz1L8eLbx4YNz0qD1W3B6HBAT5o3UFJDxQdejNC6KLf3pd3aR05KxWd+DfbhnMAHr1xw7pMYNU46NuPi5dApGai3Lz8r2skySOHxwipVfs03JwjfowEe1dC4FuYCtmTAJOWQF42Y+DHnd2vJJORc3DCZPUnr56yD97ENYshZuE2AYuk5ChlL6QzJ9UnYFmlgLML/7g/sv5ISlLyKcVJ7pol9kxAv80jX1wPOgn9WKCO5PLIwMVRyQMUvDkiFjIDqYUpVlC0s0JJw2Jw8qLc2q5yKQMq1a8G92XnkufZEL/aIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmNVaO9lbgNpk4UshzTDn6d1DO4KbqWExSGWPRM4X/Q=;
 b=b6+OWQFMPqMn3n8AkTOWTT+YeVjmBEhmzCoQRAtUynpcDnKwv+xcUoj0wzAmrgvEzkLIy/tmq/jnIu6gSMfDCaGBkZ3MeHUhNZ2rZ1KSr01Evnh8ftvHIsRRelSgM1MepMx2OEbsSQ13ZAe7Ox1BavmueN5/YH/KRaVqwsMK91uP9CiYxGppwnLyTtXQdykH/931EFZZo2kxJ/U5vCayR/sdvq5cQz6BYH9DmqZ3pNYSuzR6cDEaUt9aQSnOo3ikwlQSe4kN46m/+PN1N2poXyhC6HR/LhidMEYQ8l0ZlnEXmDgoafHTSyzBfzbC+IHLa8iRGHAkM5q8gHKWh0seRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB5278.namprd03.prod.outlook.com (2603:10b6:208:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 1 Sep 2026
 18:49:13 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:49:13 +0000
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
Subject: [PATCH v7 9/9] mmc: sdhci-cadence: add Altera Agilex5 SD6HC support
Date: Tue,  1 Sep 2026 11:48:18 -0700
Message-Id: <20260901184828.15653-10-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1ad0f4-73a9-4107-c672-08df0859b755
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|11063799006|56012099006|10067099003|6133799003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xm6nRFd0VT2L8R945MjkyqyKrrLFPJUF3XU7FnLLn0OuFHsaUoQGJegD/jrNwxL25w0v8QUrGjy+1YPLlQmCadlj8kCmSgCISIvSo8oNALtrXcxPPTfsuvlNND3PniL9a3lEEmEvi+fIjPpLGngQrCxwhT/OU0OXrYKOt/n/8Au5nYUtmmXrftgeXIFb02Ew1tgEgVp/abG0eRJOEmxjH3gZ0q3AM7CMgtgAT8rREa4owKkPFdi7ESbijLZRiDf05n26BGjaMXp4qdwHAgvty3Zw068D0bm6YJ9TIC/ZKuMI8w8DL5IGIMuiIpcyzEPpEIh8sjEF9LrJyVRFsX4gLkr/h5cyEk5vwcDrFBoETrMBhRK7YhO3keDlXPnGQHC+Ka235xAL8l/0VdtxpU8l5va0mGDJqajNoSU1e8/JvTGZ1lULITjJVvSF++nQRRqGkPe48MXB5L1W7P3qwuwcaFhWLPAaog1Za/oUcAjX7sZeDMiqPh40q8Ugjv0GmwqGHOoNXJEpdmbgpXLBWaMNX9RMSUB42KCjXNSk83TSB7UlpfTr3lEbMOWHdfjiZB87q7NAFC2d22HlrG90wZlQIpi4/PxCG3bCJe5CxsUHfXj8We0KdoVHSneFJYVq2i5ZFThxGpv5HBb8+VFJFSsQ0RHaB/r5D3Mc/I5rVxSp2DU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0MF3UNkXslhrjCVcctvtPMnKaxdG0DeFgysuegR0aN7s84xj6r7ZYEmz8If?=
 =?us-ascii?Q?tselBKt8T2ZeLUYi3uLT8WdJment9hp3Edtek6a3J32dMFUkFf4ImBfFsKJI?=
 =?us-ascii?Q?VS5p4GgZhMP/x/yv0HuJpEOBd8w/9r8Man/P34LBSylvaKhBUYm2paCDyIJu?=
 =?us-ascii?Q?Bzfg7i3BcT0pU9UlkUmbLwGbQwgcar6ixxqULJBWDlFsWqcI+pvNrc4Cil4n?=
 =?us-ascii?Q?Vj2vvGMNyTEh5F5tXm2VNxckZLnhu97qfWjm0+NKqJgyQcrscPnmx3YufaG/?=
 =?us-ascii?Q?k9pb78CqXe/lrtGs+YJlC3ln8jTVSDG6bz2mnMACPrZEpAeEQ0YzfYBKmmwD?=
 =?us-ascii?Q?IkkEyuE0GoQ7bp7/8RxgC8EZ50+2zPBVzOhezGwpm2G1O9vp8/GQMFVRNN4N?=
 =?us-ascii?Q?KbRFry5+89ar6tddiC6qrZXSs7lZVcncf5nqpO6BihwYZZTSFh/ZKdPg1djZ?=
 =?us-ascii?Q?DyLIZW8X55071QjV1/yDTO5tPYnNYuDxAZM8fxuzTOSx8OJYmysxEWPhZLxm?=
 =?us-ascii?Q?auwbm2O0530u21xgx1VHjmwAH2ZUM/iWXCUb9l4LShns9WkjInorGR0ilUzp?=
 =?us-ascii?Q?XYcywAVjcIMhSSXVzB+YOLzleFm0peEtWTpF/Tf9W4iWv9YHFuCyM68OQxwu?=
 =?us-ascii?Q?Xy8NJLLG21Dh2FPsSDN85MKWBvxTthgV26z7h0N57eQvd4yTW7DNL4tW+xO/?=
 =?us-ascii?Q?LBfhT6BK2HdKw3n5jY3Zj4AtM8iO7ePrSAQ8Z9MRg54/Qkkqcoj6N+KsucmU?=
 =?us-ascii?Q?zZBLRLrPk2T2g+c51HcVw0tpfpyGVg4NmLi2TRzPuaHOKzsChImsNa6D7NQ4?=
 =?us-ascii?Q?2S/X+4n0xT0E6OCslxi/9jH4SCWDe6/y9GUD/35Jq7hwAsVCzBi7ibrZejVf?=
 =?us-ascii?Q?5METbrLNq3WruGWIAUjpdJ4G10MDTrDONQQMhJlEstvtkPW+QoMkUBlpaHE2?=
 =?us-ascii?Q?di73GkIWg3NMnJSrjseDz1sk1qbNKjHRLV5lXMq3nZXYUXDO+74p1uCT+xMg?=
 =?us-ascii?Q?JZqWl2e6oadNNeped4p3BEpDMwgN7NNzhZQEcUcQ/yQuOZkhTuuQD2roYeCu?=
 =?us-ascii?Q?DZib/9V7AvwY4+RuKivueUnB86L885ZrIv/QifwSNSsYj3bR+JSlb5Vo9cu7?=
 =?us-ascii?Q?13cWkehb9wA1Rug2qU0Ik5Pvza2+ekMcBnRgpLXLIuJU92pfL/ZplESALXCb?=
 =?us-ascii?Q?Rp8Z15y+fAjgbUs8MBGeJfsIj52ETwlM+hiSIjx91Dp1ZdE7YnFS2fQJVxIO?=
 =?us-ascii?Q?RNaIy1WS2CWFdTQ9tRkUn99USEW+BywGzDddpjgeoIzWsX5Am9VoZQ7pOlLA?=
 =?us-ascii?Q?NaIMR5876OiZOzJ/NgcwCYFRnbB+UfhqtEvu7vyhO+DMhB706EqTj5Ar0w+t?=
 =?us-ascii?Q?FGDC4p52AiCLPF1G8OJVsCIG6Mjinx8jTnUtZiIR2AVL0thBKunuxhkrOEsM?=
 =?us-ascii?Q?9vfYP9sZ40U3OgR0Xqhc1JsV4VsCTY9SQAmEosx8G4ARONfWihs6DxsgDVS3?=
 =?us-ascii?Q?1VddOwDGb7++MTsj4exTVtk+pxL54lqpAbpitbfjVWMM6Y+JS6JGtcRsdZsV?=
 =?us-ascii?Q?UFle4xNqwQjs2ecr4mr14eZvkRRzKuf+T/MIu1CiK8uqn7U20Y4e+OPAEyE/?=
 =?us-ascii?Q?hYe5j2aDywJb9sxILviEsMVAS1osdnkQkpWLVpkq3pd7NIh/zjfKq1AAGTUX?=
 =?us-ascii?Q?bheWlG3LGwSDz9MG0twv5hbavobuGyZo+UVFVoPJ9Xd2sRYsxPEUn95X3kVt?=
 =?us-ascii?Q?F7WbbIF8d8So8GlaMDcg/q6+PzNyM2o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1ad0f4-73a9-4107-c672-08df0859b755
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:49:13.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jl/tI8vWIAhZoslMOnI4mJ12C+DZsl34+FCAFIpVPDL0qWfCMLRwHZnmR48UE2Qe8fXc98OouOEGtZSKbDzAqNv2klvVDKCEOyy4BGdmzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5278

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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-cadence-core.c | 89 +++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
index ea2517e8f72a..745455743b01 100644
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
@@ -462,6 +481,48 @@ static int elba_drv_init(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct reset_control_bulk_data sdhci_cdns6_agilex5_reset_ids[] = {
+	{ .id = "sdhc-reset" },
+	{ .id = "combophy" },
+	{ .id = "sdmmc-ocp" },
+};
+
+static int sdhci_cdns6_agilex5_init(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control_bulk_data *resets;
+	int ret;
+
+	resets = devm_kmemdup(dev, sdhci_cdns6_agilex5_reset_ids,
+			      sizeof(sdhci_cdns6_agilex5_reset_ids), GFP_KERNEL);
+	if (!resets)
+		return -ENOMEM;
+
+	/*
+	 * Assert SDHCI, SoftPHY (combophy), and SDMMC OCP/AXI resets together
+	 * so their active periods overlap before all domains are released.
+	 * SoftPHY is shared with NAND, but only one of SDMMC
+	 * or NAND is enabled on a given board.
+	 */
+	ret = devm_reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(sdhci_cdns6_agilex5_reset_ids),
+						    resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get resets\n");
+
+	ret = reset_control_bulk_assert(ARRAY_SIZE(sdhci_cdns6_agilex5_reset_ids), resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to assert resets\n");
+
+	/* Hold resets asserted long enough for all clock domains to capture. */
+	usleep_range(10, 20);
+
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(sdhci_cdns6_agilex5_reset_ids), resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert resets\n");
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_cdns4_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
@@ -481,6 +542,18 @@ static const struct sdhci_ops sdhci_cdns6_ops = {
 	.hw_reset = sdhci_cdns6_hw_reset,
 };
 
+static const struct sdhci_ops sdhci_cdns6_agilex5_ops = {
+	.set_clock = sdhci_cdns6_set_clock,
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
@@ -508,6 +581,18 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
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
@@ -716,6 +801,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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

