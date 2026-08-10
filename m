Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917243CE69;
	Mon, 10 Aug 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388488; cv=fail; b=CmnkhznXEIx3GuPWnhQezSlmW5Sy2474lIkRurIhdd3SPbO9/Lr0n6VMceLCf7BRZ/L9wHYnETpn60xdwiZevBQyC71liEq48SAaqs3pHxFWw/4TeM99HmDDpVFf6taHCD+dimj4zpyP0NOEMFlTfrP6RXakHwup2Lk1Ho8NclU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388488; c=relaxed/simple;
	bh=yrZgaxiCF7ifsbEKABKYEYR97DO4jClSvC6mgebxyls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PT6muR1h+BdtIAI2OhTDyG2AaXuQsJEDigy3G8k+CtdsPZRhCpBi2gBUxrdl36F5PDKwDRjWcOBEhsqyNs4AiTG8IZFgrkn5KTsU9cHhCd86hd4TThqWLptibBVY2BKr0gpfdeW65x1+e9Xi9iZbBpxEipbaX0OTYda/G9N7egk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=E6Zf8pcC; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="E6Zf8pcC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPgloPD5woJwl3wlMl49ZsneOfQQiuYF5b95RNt0uhPnhHylC1Y+KyzaiIqfES82WZ1XddDWVhbDPtzgkKWpGi134cB/amaqU6F9rkJs3vRaWcYWCN+E47TscVf4ICwP/Xo2+cMAArqyWqeEyrF1iExWqy3S3t90dSG711OuQBv0jd8L0zwtvZDyggakwz0zMHbEooADgHUlP6oHEs4XCPSzzvi5VEebVnN1cqpYegSkufp/lyuKo3WpiG4O7YqbhhWxwNvaU2o/KRYPXU3XU/5n3nFlFFD4jq8mn++GbPJ4PRhlSIqd7bHBzFEcEV3YCPWQOvMBCZuvPPttc14jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4+Ed5hHMpklxBmR1g+MfX5Z3CeqXLQF87ZZ4SJAm3E=;
 b=DEGlgYrDvVWem1oGAvonzg6UXjEHTaV0fXLfNXhbo7lWM+bp18B8n83J5cra45+nDyl2kbLkq2Echmglr0E1sr61lqkA//qBz2lsyP3iM7owY6LSS7JCJkgnM+qYZ31621OMsxsLbRq3KcbcPpMbMN/brLapiUL05kHisGcbmpbI/w+ShwiPpeFU72gkjGKzRf0ufNuinUsZ1UJ2WKx8wkP/0VJ0eevi/rrRH2S9kQhqLVLiStUeksfH8NWWTEPvP8JbdWPF4CmcRI4PAOtIx+JtvxNIFK4QIvRBR3vSWQdv1o8sCAyN1mHmo3SCVPlmfZWw4LJKiVIcgIiIHrT5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4+Ed5hHMpklxBmR1g+MfX5Z3CeqXLQF87ZZ4SJAm3E=;
 b=E6Zf8pcCFWHFEm3YjO5/UOGNrjwjpcbgipuPtUeOu6q/CDvS/8ykoIzAlijuK3N0Rfz/18rC4JmFgV85/AylV+oWOKa/8eoz3UfKP3dWVUUJEBwY1fcMZlVEMYNwk9IEfvU/6BkmlQLe+nNqVvCEjE8K1aRbgaH57zSt4BWT3K+CJl1yMw8GvdFQ73RGfnp2+lRdMKk009TYptrufm8wSq4YzzUqxTKRAAqs3WO+3Dvf2BrZ7cepQvnDm1zXK5Rlq87w74ZwLvenLMlBMjJddoeU0cC96T4JBiZfm/O0DBvJ7m+u/ZAETwwmtoyJDdyuJIUEihjuTDApVB4mU0mlYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:44 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:00:44 +0000
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
Subject: [PATCH v4 8/8] mmc: sdhci-cadence: add Altera Agilex5 SD6HC support
Date: Mon, 10 Aug 2026 12:00:22 -0700
Message-Id: <20260810190025.25045-9-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
References: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: fa093831-0cef-4218-738c-08def711ae68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UasTSnkcbO44W4WqwOzT+IVKk7FpG5W/XNY2yAUrrwcWaz4Cjb2ktGhWB4B8PYqARnBE+gZZdBgDAMMcGxJit6ntgn9fV+W2/+nbJC40CqC2mcdrKDCCH//IsyDUONw5Bc9lC/i0mdZmu7eqvZlgioFYpkiYnCl7YrPe/lVOkq7HEqxzB/Smw1kSjXrh/V5aYiYSi4d87TBksy4W2TAKc7JLjiaiD04wb+0lLd5hgoeWGPK8hwflsneXIVh6qXtKxYPBwufldThUOR0qD3Chr4JOYYTaq0wYXJ48iAE8HuoHh1tpGrPIFMWC240TOfa7Cq2DqeV1a8jSNkMu1uMmzfLmtQ3sZSTaF6XEeej2AnEBBWCUusXb8evgh/3oHvq87ggUshhu/qFaDHyHGTprt8tJ/Gg0BQg0v4fz5alv+148/FM8wVe5Gp0dCHGaCvfzxdz3xVihqbqyjOqhu2lIwagIpxj2JQDYdwvGuV3v9/B+JtQ0ZA/sPZUMjQeuJS59wwPXkPx2wxb5J2BJQQONPu5WCwFSF9QZMnqXaeHrXeu1k97QTt6DzGn94rG5sVwimDRmdelJLF3eJFhMqPC+V6NK0w0y45788I/L6k8t+osJ9qZKbGsuycV3FVyEa535mmgIgH5Est3l9U67IaSHsemwhR4g+WSWzUB4Sg7McuY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axsnquPp1NRcnsQUkS56am3e6FOGjGqOCVFKrpTHj7KsOCyAofKsNTBtLp+i?=
 =?us-ascii?Q?EwTBY90wiDI4NYxTfvKZZrKItqhHVDcUjpYdoWqfM2q8vq1M7/bSwn+1ZsyP?=
 =?us-ascii?Q?GSi8KTtLLed37ALUJFJW0WlVKD3ke1OrEDynz0vJFPHOqrFKwH96MYL++BJL?=
 =?us-ascii?Q?SW6KTqsrrrWMni1JleDHqiQimFkvf6WM7HA270aaWa3VFatv8eJFfiezLHUA?=
 =?us-ascii?Q?t2X4K5McMUHvbCs7y+f8vJSFAHiBy7faaKmsOdHct3SkC3N8gvHaJSOP3+PW?=
 =?us-ascii?Q?yXMj5PaHsYUstcoN3h/J8ynpMe547cya6kHR6xG4+JYY9iaReT3VKTP97ITB?=
 =?us-ascii?Q?Mk67/e2wjrs+p8QMV9hC+gu6IPaZmFticzbG4OiLmkwWUGAHxYydl50r6JB1?=
 =?us-ascii?Q?GCBnOv5HqpJLWH08yPvWR5ZO15+i4XQpi33hNNaCDgUdyKUjy9pRMGaIy7aM?=
 =?us-ascii?Q?FeKPVvwrsPCeP8wkjIBWxuZchHCv9BIyx1fNFbwqLDmprngdyd5zBZ6cC6qI?=
 =?us-ascii?Q?dv1LzIznopqMjD/8BOdjteiCXLS7/bpTJ618QyjxBa764q57nRNmHX5qI+7I?=
 =?us-ascii?Q?iWLejpjouJ92U1FXA63wjx9p19olRL5nxHFuBFEgMLDwGWQy0Uoc5DFFGV2W?=
 =?us-ascii?Q?7UprVNlZ0Ud9zRG7/AS+5+ELOUr2KN3wN30Cx2G5/bSK372T/5TySRUP3JdX?=
 =?us-ascii?Q?YLqehBkvgwWLw2xsEQohl2aQqlOVMibq23icX+6ZkPp+zNVaIzYk9YxKNRts?=
 =?us-ascii?Q?V8CoOD/zgDb7fnuRjtRkWsWqNVvEApxmsYPAwP/DULeypxWFDLUId/0YFJAg?=
 =?us-ascii?Q?kBsVCQE7PtKEHiX4Nf0Wp+/qw/MAm08lR7pM4UtMzqUKnEaUBOunYXqAwWkA?=
 =?us-ascii?Q?ZoKwrHSTtd4944AUWL/yTtWQdOeplv4uUb4YBsjlCSatZfNsQKZz1BUAvAcU?=
 =?us-ascii?Q?iWhd3YPq3XtJLtwpxWeDSlR7Egn6z8PP7ShtS4/1PToaP3pcN36WRBxEqv7c?=
 =?us-ascii?Q?WlhAt3/OzaO8wAH/eVryEKEvjaRtgi6UY7F84IfiIJ8UKfxFP3MvXPBCROhh?=
 =?us-ascii?Q?o/vXY3Z4nTzrDJAELSUrPNtQE8LBXXrxNpbJOi+AmkYfbgEz5H84KkFlEOU9?=
 =?us-ascii?Q?/Hn4Q7I3Kh8I/8uXk1GtdPG1t+dDFJs73qK43qyjd0Nrp1vDR3rggcym5ifE?=
 =?us-ascii?Q?vKWCEfSk0w23s5Gs4QEw7CqvfktcA6Innx6DJCczTVXydTenVmmYH1zAIghx?=
 =?us-ascii?Q?gEK6slMS/11zSeXpfpOvz1B5hDV/vWxCDFfY8BRgB810wFWzI44t/jei4pEO?=
 =?us-ascii?Q?5jhV3kMGGfbOqKsnFtnc2QSQ9fa2L6amIfrq93aoPy4CjHaR6ZsTwaS4gVh7?=
 =?us-ascii?Q?8gN5en7yVGY1meCsMBsYI/JxAARH8MsAcwlKAVi1eXYtfXwH/dRI/k8jeBxn?=
 =?us-ascii?Q?9tHVO9llhPxepci0edS0ssxg6rp5mjrGoZH/2rE+upSkg/kuEm7FaaIejB+l?=
 =?us-ascii?Q?UD6EL+G8Skm1nCZsEYYCvqy1AT32Pjn5qy8AbE4Eo48Umdo52iS7FGXXcwTx?=
 =?us-ascii?Q?FHZp+Ww8j8VmH07C811Bt2ME9KGjaQGEP5sZnibaNFHNI012YXkJGBcs21ns?=
 =?us-ascii?Q?N8oO5FGhoDDNCcD0ZUMxy7JTG8481x6x/Vxqs32TvJ4qaZuFXZwCB+IXQHbq?=
 =?us-ascii?Q?pq0g0tw2LPlH+1llYLFNC7PjXR4X6VCTh7+Jeoy5yyMNF0J8mG5UmbaQbaWL?=
 =?us-ascii?Q?WoSd5D1NjK6XH37cU9RUKMM2oyKeZl0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa093831-0cef-4218-738c-08def711ae68
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:44.7495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YS4TpxxPihPSDkYRSQhnKjEWiTTAjEyT9vi/ke/ehKqqcd5peQ+hv1evTR20DNxBGKL51LwFN4FHvvEYdAwJkaOn5Sgb3XgowW8TFnsjcKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676

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

