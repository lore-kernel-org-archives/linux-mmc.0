Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687639B4BF;
	Thu, 20 Aug 2026 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252285; cv=fail; b=bMoo3VION1WdCOOoNkHlLDwDXaso75jEaAqs6UNCwWHYdP9CsmXvdM6qdfKfZFJC4hCEYyj7XveluTAic2MckOFrimQtj11PXI5iJQqPubElAxJQVlTR37grmLZmFIuakMcKO8+huSWCJlrgz7Sxq8qY6+L7XBXVYCM+xqA9fCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252285; c=relaxed/simple;
	bh=yrZgaxiCF7ifsbEKABKYEYR97DO4jClSvC6mgebxyls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RTSZYdlpms5kjJQeVt3XoMUZzJdcxnFNV6BTnvIM8vifQQVCCRdPD3txrt9aB3dn6coBE9+2pGxO49fgko41/PApsSiK6eNr/I3rr6UCYEqvuJluNFzIax+AphQOpdf5vdfQ2Obw4kL6xzSUc8dGgsU2bz++neJ5Fm7YEheMW84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PniMze+h; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="PniMze+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJZ5zQUNEWQlPNfK7RG1o06U6Ig1c5tBDO7u7gAlguzKmviiDcADc79L4dVxBIfdKpq0bjPE/Z+C28yk+80NwUjkiuM8MH+h+5n0DgDYIzS1xkjIARv5nqmxexndO7sLwOiSMjqQGxotdizmaVp6g1hEWMv0k/oKuEZztQV4KWJDofAnZxOHwfBvBdNKIL6qWt+6kx3V4jTmW66ip3Q1USm1hNZPXBkT9Lu6zqt2uZIK4x5HAj52XJbdQOoyOna3WNpUEJ6akANbOxORr/FJvhJLsopxJbonyLSqiYL8Mf+AzENWdbMoFcMxD8nRfGUT55EjFn8IDmfK82ROk4hpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4+Ed5hHMpklxBmR1g+MfX5Z3CeqXLQF87ZZ4SJAm3E=;
 b=Ac6q4NRPVWL1VC9Te1wRNdGSHC0PJoGeC0qR9b1fqhYlH8xUujSJ/v3rW9zcH59Yi026AJan+bu0l8O3iYvfxoSvq1Hh5XWBw81AvxlBLNhgIPmOVVbneRb9FGb8f2Af+nTifxU/4UG/ifmkx0mH1dPh2/HtAQdww3Ji0GHkkROEzA8AlECVBFZLU0m7XtWMwFXzHH9iPulFa9YEKQE7mgNYt6JagGVzTGKU6Ry6c4TeKxNNaxDOXm2YNahE2CYDwKAph2z51TAZHtj175vsHAiD5y7wuQFbn2e9n4lOuKwhUccTL/qCrNsK/ePZ8S+sLD4ZoxPEevPRBn1YlDl5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4+Ed5hHMpklxBmR1g+MfX5Z3CeqXLQF87ZZ4SJAm3E=;
 b=PniMze+hrYQ9u0aKFFo/rW7MheGFY/zwzh1EtP7m/zKDQ3EVR/tnvhx+jyXxmDt5m2z9HLl8fDY3XlUWdI7DyS+eRAz4kCkvwZz46bXF9+9TEbK5VWJIpMqppYw/ZNYc3fmEXPkRVsJE3ymjCfRjalM1uk0zbekYkBsePD7BUqUtW80P9wdb2OesqpoE73BCGF1k2LsL/sJWXIOCp6nbyScSePM+XG4Qyu9k4hg+vXcfITJeOQqTThzuZNPuF6jW7iAveBrRpZ86UOI0Qcr0SRQX+RYLo2lbg6B1AGFZQpCh8UQFPFp2zfJNsczgLZNsgalB79Tgw5yzA2zR5cKAAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BLAPR03MB5636.namprd03.prod.outlook.com (2603:10b6:208:297::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 18:57:47 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 18:57:47 +0000
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
Subject: [PATCH v5 8/8] mmc: sdhci-cadence: add Altera Agilex5 SD6HC support
Date: Thu, 20 Aug 2026 11:57:14 -0700
Message-Id: <20260820185721.22823-9-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
References: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BLAPR03MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0cfd41-5f61-4022-7696-08defeecec8d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	bYuokA8IdiggE9uvbq1T1e8Bp5/cX7jptOc3bXzbhJGjBMFJGA0F30QZ8R3++3NvCUQ0ZrsItkXandNcGMuaG4Xl/VXcSHnxJHFb0YPPHtIQ7/lyv1L4grrfhLSogb+BG8Rqk5OiJ7P131d3v3LECoa7Cj1Ei6xkFvDs7/ewqLiiP3wBng9U0rfJqRngR9OL9V6kJoLW3kEbKuLqN/67npYGxdSwW/rXCQT33T4PenYEDFL8tTfcmS5isJtT68RUOwiN8HWv+5u4INlGlMQDHd9Ul7TMtzz5ornIeHpbiOMA7i1h5D/WAUn0DZv1L6egh4BfHqiTQUXt+lgXFuI8M9M7q+VmEFQBiSd7vcCKLpcBo31XshAN++3t/i4ZW0Pjo8NI1XyAp3vSmTDIcEtOFty6cL1M8Ezqru+avjuELv5OLKaU7C3yi0kHMbBGYUoHAc+B7kj2m2nqy5RMK3BjI4a+2fUF/UP2oTnl91Et3gAMD9AJXlolAcTVJOXsLXcA0PeVEE8/UapSrCVM+7DV6Z14q/LaozHY8/GekDt/mcgZCY/GcCGqMG5dhA2FPz83i8/JndKQAxZsdGctAqAM+ViI5FM8v9YX91qrKHj/G7uZ0isgMFsvu06YRs93R3Rp8lv+q3kheEOpUKX0pZkGJO5zK1nV29TVonHJMRzIkLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nn7MqWi8Lnl3xksm5y7T7mbT4evhnh0t2v0ZFco75mlYnsldaPa9bcRS3K0W?=
 =?us-ascii?Q?XC7LzKjHU5so7KLurCeJCTIVMha4y0Fy16ygXV3OITYOyafZbZWi8YP3gOBl?=
 =?us-ascii?Q?mQqBtlqm4nCH4suA2vGQSWsZ/d99HlQBJlur72PaOwaN5SuQG5+08WAzDXXi?=
 =?us-ascii?Q?d50iyywX72eJ7Ff/J3SKl2OeZcCa4dDgMIwFCdMZSMlkhqVYKtH65RWFlWgK?=
 =?us-ascii?Q?p0zPuVfVF6zWaPvLGRKGDmm/gj74dv2ExekkfsTHIa6FDFJM8n10IT9TfU+q?=
 =?us-ascii?Q?c6pgHH8kyFffYQ3LhBwxJfIPwYvodbXJPMM7vWQhqGX0RL5lqMBcJWIKCk0e?=
 =?us-ascii?Q?HGDwSEEbA4nNuuqq9TeVr2XqrPNrawEbh+E37luhzkncBvmhc4NC3EHvWZTI?=
 =?us-ascii?Q?Gw8hFE+eKfeKXa5hqjqlXYDEkP4GLej0kHtCPT2OuH7rV36GEW9B6ovIdllE?=
 =?us-ascii?Q?InECZHSE+Y6AzzazGZbqNJrh0ggX/OMgkbWYdq3gKvT9MoNU34yj3t5lHmV+?=
 =?us-ascii?Q?eKPLUSm10hBEbSlVkKhNgmZBd/6anIKwvvmZCkOv5i5QXp+LLO8KX1ItaUgD?=
 =?us-ascii?Q?S37WgnYJadHx3A5uM2EwgbWk4tDpshT4EeCRZw0ghzBYK8FCzx0cHJPV7vX9?=
 =?us-ascii?Q?KEqJpcSE/C6ZBz+Sya776o2XIA9jI5SpeooAyQu57Zp6R7FGwUj1xvi3O2Lg?=
 =?us-ascii?Q?o0Lnyju6ij08Lm6WVFVGULZR31+uUYchCJCRS1Oejj2+81DXBIuZz95lM0+i?=
 =?us-ascii?Q?XKDNchXrBwXLV2HI5QX6cAJbQkQeUx+hrh2/3q3lb9sUCxTiSkG0IP8Ll+Nc?=
 =?us-ascii?Q?K2fA5EDYdMu1VKupTfP0o+2uYrkQHnyhPAPLwdA/8dZnLIOBVS+XJYFk2ijq?=
 =?us-ascii?Q?OMrvDh+tkk/uv8Z07c+JwQfJXv2fHD6GvHupH3P5Jkp8AbmBaEUivNErQ5sF?=
 =?us-ascii?Q?Rhcijus861Fshfo3ANQTePHZ5154teEiuRdrBONH3jmnaZWuFB2LTj5urNDj?=
 =?us-ascii?Q?EOhMdpGMv/4TZvAZ0nO0cggWNI0+m8FStv/jsDY8xgoK9gKxZtWbkWeZOlcv?=
 =?us-ascii?Q?zDmcDWFNit3tJYuaR59PiyU5lCEiNgkteMbF4Y5OqyfCukVsZukwplxSlBYE?=
 =?us-ascii?Q?oo4FPzOXpkOTbWJf8Hl67wOmK3T6EUaT9cyAQs++fSC+U1WXc3cqVi6kk9fI?=
 =?us-ascii?Q?5jK17DR+knL+pFJlCY6Ju+HMQYMRJVN9IdE5rYciQaTAGGRxEtoA45YlISj+?=
 =?us-ascii?Q?1wx6RUTPBesiYrFeBwkJSmGMdfpBbCknEpKmmdbpRScWB6Ar4D4OO4kXaumk?=
 =?us-ascii?Q?DvnHlTKYFtr2PPmMMNwt8vYYAlKaAh3IFlA/F74DEpgIjGGn8lNIPqXPaljS?=
 =?us-ascii?Q?PdaStW+hEg61LlvfemfmSYIfTQdzAHZeSTpgmZ43NLqyVbNMIg8D3yDpJ1UT?=
 =?us-ascii?Q?kOnBBU/0brzf2viCy6s8UZBZL8z3NGvIwlrg5kJ5sj2I5aaFg3M1Yzy9woxx?=
 =?us-ascii?Q?VuvmcH8aECSe0rJ4Ia5fyG6kKGVMofjYeXhCUY33pLzF9+LPUo+knjACTiDO?=
 =?us-ascii?Q?GE8tDr67JKYt7ffK68kDPlS8E8e/RxSTKBi5mO3XEXJlTTv2K+OSuWbH0m3F?=
 =?us-ascii?Q?W4pX3gEVHzsVXvtDmYvP7l+ldkzxuzLeVbBsTxlebk041GzWD9uHbhd42w3w?=
 =?us-ascii?Q?271/nFNo85f6ygFdSw6ThOFY4tnUvZZxPP0PnVZhP2Uil7+YzENBUfkPro+l?=
 =?us-ascii?Q?RW1Nc/DtKD36g/RTTsZ1XgB6zdMq1YM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0cfd41-5f61-4022-7696-08defeecec8d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:57:47.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+AsPgydhBMs7KRfp4XsTE/wL78F6iRoHBIUAPkHFXATb3rTrLWzOKyLp6zFScTZsOY70h4XHqj6PfXYtNieTjpyi4pkCRtnmFu7bUeRZsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5636

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
 drivers/mmc/host/sdhci-cadence-core.c | 85 +++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
index 18a5329f27db..e215f6a4c344 100644
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
@@ -462,6 +481,44 @@ static int elba_drv_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int sdhci_cdns6_agilex5_init(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control_bulk_data resets[] = {
+		{ .id = "sdhc-reset" },
+		{ .id = "combophy" },
+		{ .id = "sdmmc-ocp" },
+	};
+	int ret;
+
+	/*
+	 * Assert SDHCI, SoftPHY (combophy), and SDMMC OCP/AXI resets together
+	 * so their active periods overlap before all domains are released.
+	 * SoftPHY is shared with NAND, but only one of SDMMC
+	 * or NAND is enabled on a given board.
+	 */
+	ret = reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(resets), resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get resets\n");
+
+	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to assert resets\n");
+		goto out_put;
+	}
+
+	/* Hold resets asserted long enough for all clock domains to capture. */
+	usleep_range(10, 20);
+
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
+	if (ret)
+		dev_err_probe(dev, ret, "failed to deassert resets\n");
+
+out_put:
+	reset_control_bulk_put(ARRAY_SIZE(resets), resets);
+	return ret;
+}
+
 static const struct sdhci_ops sdhci_cdns4_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
@@ -481,6 +538,18 @@ static const struct sdhci_ops sdhci_cdns6_ops = {
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
@@ -508,6 +577,18 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
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
@@ -713,6 +794,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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

