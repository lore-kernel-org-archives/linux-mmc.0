Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617A342CB2;
	Sat, 27 Jun 2026 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591344; cv=fail; b=UPCd0UTH0wFKLlcN77cI5ftBS5O0+tz8tpfjChrCFbNd6jxrCRZBRXVdYRfd4dinkjLtjxuSxCT9lyE2fhFt8v8z8bgsx7m6YWkRoSNyHmcKJrVMfj51Kzmn3hvBkL/UfNnCvD6bwXlLi9+qIzCZ0rmfTmrGoQm/C6YCLwGxqu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591344; c=relaxed/simple;
	bh=GZw4b7JWQE92r1+cTy8gmzqJuZ4cxpAbCG7I1nHbFhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pl9InoHv2JHUPRcELn45P540CVSoKut4D57IcmEMw/LaM2qFSo5AxbbLlz+47locz3MEW++nE6FO11qryhtHw1PCSj7G8AMfoZU/p2IQZFSh6iyOTvJBdgoYyQgZPy1EVvfhp+bElzpY5da6gsvXgIDXaLvHRzwBtyJJcUyZE1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=tIkMzWNQ; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="tIkMzWNQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppstWWfjsW8u/i5xyNZXerJXEk1TkXxDxtFkM9eQ1AoOrF8VYMrAjOlTfszE7K2CyD7nNwABFBpvqzW5YrSI6DuQ8xwqpBS9/NJw1tO7jg2LhHDFurRUsBBqAvGBtSdzmuJJNF98gKs+H9rD+EU0L3loPh4aLKYDO0Yw8CkwMjReqFBIZrwZiEk8DOCqXvOSfYB/gyj3O19wy8s6eKMO7kgOC7WLkzB+/byMwjwGpvgRK6LcHDiVGu45jLiV/2N8QZzfYj/h3m6h3kM6ZAp/vVxTrkO3KlkQwYjAPp469q6jNLE//HjN2+dwG/XO+FGre367QlICiQkqxeL/Mj16Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2APwRdOEgsx5aHWHY7paOPVLpTi4p7e6cA0wmEwKtk=;
 b=GRKcCZhCdBmj+aUwNgrBQ4ImDC20nsQiLlq2gl7A+GSd/Mq/eu0aRgP74U23hmEQH/T86DPm5ZeXeuM76ic2897Gqu9fjOEsa/VmTgJe44VQeFzw7H+iisQBPbaOfAv6fTHYYkngrq246qVwGtdNPG4KwoKMRFuMu3JtSYEhBYeHebi/cF11QF5uh/7e6Db3NtoCc34D8RpPOWvhmSIAky8L0XTsI9RLVsC106fUWNCQM8937pzjmqkKjfnW1bcsiSwZP2mZfwI9kD30+Rv3dOUPOZf3SqIzClcuPaw5Itk/xY4Z5qAJY1PWLUduURHy3t9Jd99pnNcnmBZh8AYAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2APwRdOEgsx5aHWHY7paOPVLpTi4p7e6cA0wmEwKtk=;
 b=tIkMzWNQU7ZjU8K67z/KeTNRa4bVjs6vhvSDTGmnjFYMCkmtZf7HqHHRjywZZ5lY1kTFcNDnnLTikxRWzy+A77D31rr+7O1A2ASPIHsqEqV/MgGvYNPUf8moZgM4rtY+hAZe+i8kudCNDCJ4809260aq+IUHK/J5Gck04ZmHE4Q2nmVFKZnefgWy5TrI9JyPEncVL847lJxR58y/ZZb68vrs3NsaEEZOCx64ocI54HyuO7GLudUODglywoxJ/bbbHU95VlyhrgINi9PKElKY2fQ3gHBISItZmpcqconh313Z8c2/OVMYEUyw9wGRmVPUu5E2dwWfkFnSol/81wIBSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 20:15:37 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 20:15:37 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] mmc: sdhci-cadence: add Altera Agilex5 SD6HC support
Date: Sat, 27 Jun 2026 13:14:54 -0700
Message-ID: <20260627201457.12318-10-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c17c4f4-ee3c-4a47-6ba1-08ded488d9f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	LYLinG8zjoLlQlzxfTPqf+UqZQkzbtz2lngEU1FVcZXZ5rwBX/eeYTYOgYG+2DRpTfqh5x2MkMSmuxXgfjsIF7eCZ6TXPSzjN9Exz437llX2VzOl0FKNTMHJHYwQyUNBWPwjTcuFp9ZRpUumpTMNiXYLh2jOB38ER9MWhA3kLHwYHaBMjII0VvSM8TP/yymwh68Pwd/8NEXot+h72naDigy500LvxjP1TjmTntuoOxg4FImHip2Eg+sfImEAzZl/3GOAfWsLvLCZU0pf/O5tPCohG0/3gDsaeYw5E9Np/k3oiCiL09W6IRjp2x1/aQtNlpCuiVUlXMh+EuuiapMI4tA8s7WLbdAf57I5TqYvjRWewqoGJ1UfMqXZ2BtysoLAGmskZzixWj6u4rkRSHcDoiq1EKNFNAtRjnHjhRT82eAlytP7bBPYgE/D+YOwIcE1KKGcrkploXt0IRoJ1U2W/uGLrGkMK3O1VmuHyWrEXl2qHazXjnF4gXJyE+BeTYF5no0OjSvY69jMA6gaAeQ0VvD6xgsXaXQHgLS3KV6BfaFTX/qAOIIBBUK7Kw8z03IHeBQB28ABAVuEOVrUy3okmj2wSrYeiRRapqowPeUIhb4Ed7psuA8olsQGIavz5SKQq94dxM7DEGU7ASVKzpeBCvjhw/TS+FpGDY0NMr+tRoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dRyQ2P59vE3pjHHoCrFgGIMFzopQlOxxLqgxaF6dcXmHbiWa+/th0iUeZaBC?=
 =?us-ascii?Q?zkjCFeQzd6j/6C8QnB+71xkcNQ0icpBP8njGGXjkzOY4S82vXVUrfApv2XVC?=
 =?us-ascii?Q?4hBbA3UnADRp09oU5WvJ1f55TwJgQLdcQRGv9AOrR0e6O0A8jvQnbE0GVW/9?=
 =?us-ascii?Q?B17ndkwmM/0oan4PfRR2gaof+N0im3gRNH8q6hlWEPhCZeAc6a/wL1bDpsvN?=
 =?us-ascii?Q?3OKL+TMp1HoANJidrVGICJNVRTWehVhLxg7K/2o2gAdNLZrongZMEGiBv8Vc?=
 =?us-ascii?Q?cJ7mlT1RA6ly0FI4PeJ8dKf23h1AJojUDa9d6DIZvWeUJ3m/RD5OQPE1sBoT?=
 =?us-ascii?Q?Fl33h0b9cdHRYKwpBUQ9bnlhXpLCkyFyiPuZutokhdqKNDWTKtgEs2zsGLPK?=
 =?us-ascii?Q?/UhtjZvFFhE1TA1trajjWdoXj92GQRwWz2JQnp+QLnSF3K/gPe1PctHZ3TI0?=
 =?us-ascii?Q?Jfy2FwsOZnTelJPm+KcQDuCJbuKYo7SixUP6Np/qc/sWs2s56KjB6uWSfAqn?=
 =?us-ascii?Q?F9fgd3gojAC5nbSFjlDlewX9gfP4X9PMB0r4u+d3n+88XeqEptYsGXm9t/pX?=
 =?us-ascii?Q?edP5dd5vPeZeza9znKMaysGVIGPbeN3FL7U60QbayW2o4A04Nokfk2dYiRvs?=
 =?us-ascii?Q?njhYvEv+LGBFLdUtSEqPOpdz6f8Hq5OSG4equptWtwm6A6l9cPP44ICy9nQE?=
 =?us-ascii?Q?ZAqAAjQ5l/AMlWnBjJytsEQc0GanHcdFiEGOqkC2MSPmxhUfE7XmvoqSDrXJ?=
 =?us-ascii?Q?K60XXiBxj4cyH0KLLVpYZkasTA3wA2/4IIHxYOhzu+N6WcxUkOQsvC7CLUkY?=
 =?us-ascii?Q?/4JExK7NDCu0rkhOYLiRAkJKsn8U5dg+O/uW9bDv5SvNTzFF6Bqe96K95tjF?=
 =?us-ascii?Q?3y0vjU0PFrjiulXka4TrSeedmuxMpkBxZypJDkfXo9QyQZfg/8Kgh0bckjdv?=
 =?us-ascii?Q?aCCsc74+yAE1mF0r75hFeT5yz4vk0I56TnaKiqLiBiQ1B8jhigF3MxUHO0vz?=
 =?us-ascii?Q?ta0RHEocUvXCWyVMjoXv9N9x2f6IyZyEm15UmeWsPX1+iisuPsgAoN8iWlVd?=
 =?us-ascii?Q?rNDdM8fw2McTYGlNVkBrbCOE41iwuz/WwExH56wo7kvSA/aqicI/6jdDLhEG?=
 =?us-ascii?Q?5TcWlCN9G5+qxGQgZ3WLyPDg9g4Kqd1er4lpFsuWhdfnGsy1+3mV5bG0LatY?=
 =?us-ascii?Q?FkHDJl22v1asw01fUaATbjurRnm0fsbBtM3iuBeEUFZV/HJ+TdQwuwKhr7OW?=
 =?us-ascii?Q?BXV0uNJaxL5hCyCZ1xj/a5s9BhzDfM6CnyIuv17R2u+Yd17J5ixkgj0hWNKi?=
 =?us-ascii?Q?vxVbpKyWTaS9eMIZUm5yEmN8kyFs2ZUiPnluKE9AO8LA/LTfje0cdVRQsfX+?=
 =?us-ascii?Q?FTMILfLHhV2d+EtLnHv7Eonoie1bJYNK6ifR+gU43fYsBZHWH2QB9KevH5/e?=
 =?us-ascii?Q?JVHrO8NDzfsYbpqydZQmXxo3a30E1hK/BX89XaNfRZGJpKUGTv4IcBzCOdJ3?=
 =?us-ascii?Q?HECFJ3wwY6JINBxi6oGdpSeD6CZJJMWhs2aHamdLokeMNO445cdxtnKBP4CB?=
 =?us-ascii?Q?J1ESU2LXbgnA2wGMrOtMLkC2kZAYW0qjUVsidn7nx9yziBZeOUJH5FMycVPg?=
 =?us-ascii?Q?JO30NVuV5xL52Q7JuQj7tl7+ZgQhQxRaTc8BWrKjhVJFioJ5g6GgWzbK/hR+?=
 =?us-ascii?Q?RDU6fjDV8WZoZhlH96SU2d7qaeHajJCzkgS8g1+vNFzFnDIVtipDxt0wJHui?=
 =?us-ascii?Q?OdRluC4BpwGvaDI0AcpU0W9wmELpkn4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c17c4f4-ee3c-4a47-6ba1-08ded488d9f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 20:15:37.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AEEVY9S3kh1qrsHIGC+6M9OGBjHxKKIDF2BSWm+SPYy5vRHP4YMsqv8A+2X0zgAiRAv13ae7r8iwAyRiDElrz2cUIt7TT3XxLgX0DXlTY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837

The Altera Agilex5 SoC integrates a Cadence SD6HC controller that needs
platform-specific configuration to operate correctly.

The SoC requires three named resets: "sdhc-reset" and "sdmmc-ocp" are
exclusive and must be asserted together before being released, so both
clock domains cross the reset boundary simultaneously. "combophy" is
shared with NAND and must only be deasserted, not toggled.

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
 drivers/mmc/host/sdhci-cadence-core.c | 112 ++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
index 5b8a83c9a0aa..0f9b9dd2d2c4 100644
--- a/drivers/mmc/host/sdhci-cadence-core.c
+++ b/drivers/mmc/host/sdhci-cadence-core.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 
 #include "sdhci-cadence.h"
@@ -84,6 +85,7 @@ struct sdhci_cdns4_phy_cfg {
 struct sdhci_cdns_drv_data {
 	int (*init)(struct platform_device *pdev);
 	const struct sdhci_pltfm_data pltfm_data;
+	u64 dma_mask;
 };
 
 static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
@@ -193,6 +195,29 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 	return host->max_clk;
 }
 
+/**
+ * sdhci_cdns_set_dma_mask - Set platform-specific DMA mask
+ * @host: SDHCI host controller
+ *
+ * Limit DMA addresses to the physical range the controller can reach.
+ */
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
@@ -460,6 +485,65 @@ static int elba_drv_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int sdhci_cdns6_agilex5_init(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *rst_sdhc;
+	struct reset_control *rst_ocp;
+	struct reset_control *rst_combophy;
+	int ret;
+
+	/*
+	 * The combo PHY reset is shared with other peripheral (NAND).
+	 * Use the _deasserted variant so devres calls assert + put on driver
+	 * detach, keeping the shared deassert reference count balanced across
+	 * probe/unbind cycles.
+	 */
+	rst_combophy = devm_reset_control_get_shared_deasserted(dev, "combophy");
+	if (IS_ERR(rst_combophy))
+		return dev_err_probe(dev, PTR_ERR(rst_combophy),
+				     "failed to get combophy reset\n");
+
+	/*
+	 * Assert SDHCI core and SDMMC OCP/AXI bus resets together so their
+	 * active periods overlap before both clock domains are released.
+	 */
+	rst_sdhc = devm_reset_control_get_exclusive(dev, "sdhc-reset");
+	if (IS_ERR(rst_sdhc))
+		return dev_err_probe(dev, PTR_ERR(rst_sdhc),
+				     "failed to get sdhc-reset\n");
+
+	rst_ocp = devm_reset_control_get_exclusive(dev, "sdmmc-ocp");
+	if (IS_ERR(rst_ocp))
+		return dev_err_probe(dev, PTR_ERR(rst_ocp),
+				     "failed to get sdmmc-ocp reset\n");
+
+	ret = reset_control_assert(rst_sdhc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to assert sdhc-reset\n");
+
+	ret = reset_control_assert(rst_ocp);
+	if (ret) {
+		reset_control_deassert(rst_sdhc);
+		return dev_err_probe(dev, ret, "failed to assert sdmmc-ocp reset\n");
+	}
+
+	/* Hold resets asserted long enough for all clock domains to capture. */
+	usleep_range(10, 20);
+
+	ret = reset_control_deassert(rst_sdhc);
+	if (ret) {
+		reset_control_deassert(rst_ocp);
+		return dev_err_probe(dev, ret, "failed to deassert sdhc-reset\n");
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
@@ -479,6 +563,18 @@ static const struct sdhci_ops sdhci_cdns6_ops = {
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
@@ -506,6 +602,18 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
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
@@ -704,6 +812,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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

