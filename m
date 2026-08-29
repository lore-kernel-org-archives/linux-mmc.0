Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6C415B68;
	Sat, 29 Aug 2026 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788029003; cv=fail; b=E86yrCDi+T/VRTjieWxtb8SnHKfdwSInGhjViaTmnKKps7sYcinwS0tzGr18YFRFsa/kRwT04xHKcAQqSFRCtBA7BgFwm6JogpUsk2Vvc61xJGHo4j35pGseHjTRAKBfRZKMecHVEhooWURe8TWIELTOsjCxW3fmvjDf79TAMC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788029003; c=relaxed/simple;
	bh=VC1OCAaMCPpOP6NYYYGAQbjDyBqeXUE36QVDmm2QhWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWYyMOe1GW7ABEZDWl/AqG5iP0oobRWkpDICz2Cv6iGyCzym6q68Ke/3dE+RN9ClSHiTHo/LHVEUmtb2N/mT3EHvMHA+MxliRiV9CnxMEUVWLor9hw1n60RCmDlG/G5V+4ox+PiupdaeU0XHhfBAhJvzYiss9IsGSEXBj/8kSE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ewoGHmZP; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ewoGHmZP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw7W9cljoMUWaqaj7og8Mz7n14rCVThJ0krC79SFoWhaJCUaERFDWFtRIwIgU9ERe7lbAI5YKXpThwYlIDrQOMWPKfSIXnw86En16R7VwS8j2a29D1MFBRcNYB0IpOxbLV8mU90FTT+WnO46X0k8YKk8X98gy92ZCYnEtxmXhCzt6QeZTfpmoLJKPfQvvZroQPxb61VECGetm9l0FLeA/rFsI3GcPes/A9YhhONtxWIy30Z8z0wlvoHJe/MKwfPpGeHOf+Ly9l9vmUmREM4yXX82KnEleoTzbvU4o5jvZ7SG++4c7s7KP+h4upZ0udy8rSdv7a5QXuogWxpfRMzS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zEJxAM6uwNGRpZay4T84eHX703h2821KvekUVlx3IU=;
 b=qqERm6l9TG8bkqmh8mkGTRG70hwWq+xbCbxHyXxQkzPE0bc3akspfvYOGie7ZsejdQ8pZFtkSpT8QkksrJ0jocIQLLchW17i/uEjvhMeEs5ut8UBRxfb5zkoZNtjMbh9A6DkYinrtNXcqgeLmm8k/R2xUA6Jb68/n/Md0+hVQyHZ3oDFL12cLv/SXgV/qHQetfOJrnQi7dUFKN3E1h6MIQ/vGrdc4JJs6ogrtX86fDqGFJ11TK0tsb+WxXmEHXks0tbXDlFHyjczyna8EHFzdSzqeaK+qY9qA7+2OpyWjmlOKwR7ROm5x44SFyQHSRbmAMvTMa6GDxZAOQM7WUn1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zEJxAM6uwNGRpZay4T84eHX703h2821KvekUVlx3IU=;
 b=ewoGHmZPho2rWMi24rSCb2n1r+Mkk7xZzAHNXwX6Hov6bQ0EXrY+0we2Eau0Mh9otFkX+hcVxebWCzLaScMqjk/Ljp81M+aWZNK7en1JCAAtXqK+zZjlZvkDpghuFijdfXMmT3vh7CteB8ANMRAgVU7dkWPgHYeW8144r9uHp3MWlBj2fYVcF51kSEUNsnrNk4pOEaU9LyvQHgY7X8hV2a77GEAkcFajje75paPskcAxOWUmqPhgKiIv2IzjROdbweb9pM/Htb0q12+jeJ4Wqwm6m1mYgZOQAkum1rbqTRjEIwZ6VTq26mwvNUSmHUvhb7UFC85OkXhdrXpJSPlNfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB4926.namprd03.prod.outlook.com (2603:10b6:208:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 18:43:09 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 18:43:09 +0000
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
Subject: [PATCH v6 8/8] mmc: sdhci-cadence: add Altera Agilex5 SD6HC support
Date: Sat, 29 Aug 2026 11:42:50 -0700
Message-Id: <20260829184252.27644-9-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ca41fe-ed26-41ed-770b-08df05fd5f67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	KK1FivprMw3+aG1dF9jnOLIWyBHPhRMrVTpf9WKc2lAxntdOzmiW+JVYM6KKz+YzagYnzzwUg4ub9/GvH4/VFZi4AFtoDaWrgRn67IC4MccITZcbPa1bGghwiBZgV3RIAnTrEg6uVg8lrn8C5dx1jytB77w1WAEN1gGZ2s2wqpz1hVw1fOVMfT1QTuA8UH9/v6+qs4dj076iay6Ue80GskxdsX0PElR5jugqVegIH9l6S6qC8A0fdWSHP7c199XJRYnYt9HG1AZmbH5e9oPWQYjeBRSvWRyYn8S1VOHESm+xn6MliZjWgrxb0vfYkg3Ym1GRZsiIG531ZTFw3UAlwwwY4mupKFE8cXMvKbMbskInYgZ3KYZ432ilwNW6ksld55vEgDUzbb9xX/U7JQLKgKe2n6ccrVKozMCNv2H/99cab/VuDB8j2Yo6QGczX1YbLa9/yzl642uju/6hO+7Kt8VBPzo4or5TetdTrvtV0+PtIe8aMgUTrB6SB7jwoF7VWFBgydTSAaHlb3QvUbsQagF+DrFy/1v1u4z9s/qLhHSjvyutlBl2InSL9571CVvtofmNp0f1JqghJJSp/wfMIPr3I/aKgCRhvXpGUHB/t+iQhzMbA/hfr1iA0YFSNzaQk7IgYLp/mjKZmjq1q/i+cZ63qqqfGHzNCslnads4o7Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fE2WG8HTViokCfDbfdQU8r2Kfi9tNGKZVPqCyqZZDzapbLX4AYg/XZtOTSxd?=
 =?us-ascii?Q?cFD2vpM37XI7dpomwM92CmH5I/+Xh01avfOAEtw5h1QdYsOaPsOcAd/HVJnK?=
 =?us-ascii?Q?D2gj1V886/irf1x0t08bHKHUraUjWDn1knPNM84jbQOHiYLCa/u5vLfiqjWw?=
 =?us-ascii?Q?wdoAzx1VK177skeE0dvW3k/WE+zN7ymEtG4GgbwnDVcy7Ri1/HCIPixvdUs6?=
 =?us-ascii?Q?tgt4TPCa+cahCyULu/z2YEHsNbQKkCVg28xuYtxQGOpVZpgZkrRWiTM+jt5S?=
 =?us-ascii?Q?UR+taFMXgi15WLF6Ud2gDHiSWEVdWRZlLhd8LwL5BrwN5QfLyBzaF547WmR4?=
 =?us-ascii?Q?XeVpr6+W6bkGokDcGQFpYW7cO+O8At3YKEvlv3ktve2Ji5duPPD3yoVORUX6?=
 =?us-ascii?Q?UmMXPyJjbeWFYJzWwAkq5FWX/zehhD8jt25TJMfvLOgDuxw63Ziv4tqU29HJ?=
 =?us-ascii?Q?WtfNnseEVhGr0Idw2wIemIENmkUQ6UN9HXQ08LcA2YR2Y9wfOyHVUsZ14NH2?=
 =?us-ascii?Q?AdQj0giRwlv7oap8hLBMY5FlWdSJz3nzdtOR8E3OUn03Bw8LymTi2ecYncrK?=
 =?us-ascii?Q?SIaINUjMsWQL5Ix1DJm0NRoE6GiNzQodFoIDqdnZqynZ7+JYGpECfvA/Jfk4?=
 =?us-ascii?Q?Qkx4M0KimGG5mWo3j7JF5YehfcH3yrz01g8uf8fokhu/UNE2Oo8vFwj5T9NP?=
 =?us-ascii?Q?MAVlB3qslL6LWmnaeprSZlX/STb8pk/QegC3qDZ/EOpDdsQySlGXfK8rst4/?=
 =?us-ascii?Q?B1x07Qi3KNWgjv6wdwHcO6xLoFuK3fLNytaW+c9PhuiK5bMM5zjQ4SNsslPO?=
 =?us-ascii?Q?2WQpTofOHJM+wjj3Yigf7JBXP3018FUeAjkBPC0Lefg0gnfrZWdcF1HnC2TS?=
 =?us-ascii?Q?IolQDo2qbtFd1Y1wXddzX/rhxdM0ISXLeOEqa9GUBVReDxttB17sQIcs/Ffe?=
 =?us-ascii?Q?j3OopKUHQeW9iDNS7npyDM+JqWgdyIH+/0pioFcvvC/+LQFmit4Tmi2Un0XY?=
 =?us-ascii?Q?ixvrDLM0dVxIh/VaMm1corBh1xNt3NR1NTbZecefTeAwdO95PKjaaebaL5zv?=
 =?us-ascii?Q?8PBmDBz1vwirQs/NZQD2Ndhx7Po1RJNepcFiY05jmRW8wM3+EYx5BEFVUIHH?=
 =?us-ascii?Q?IUWCVNgltBBDgQlXpDrK8N3doy+TS3sfiWGO808dkD6svc0EPu8S4PYnPD0P?=
 =?us-ascii?Q?z7O/4yMu4sujXcZ6Iq6G+SEfpQpFmNyipcrnML6ffKvIHgqcATVwk41hrEJk?=
 =?us-ascii?Q?lr+RRLHv4H4c1aE3kKyRsyYFNWucR7/aL+gzeQf5BTTC1TfH8l0b8wbAKrkW?=
 =?us-ascii?Q?2fFI4EcJoqof4MqTflRvne7WhFS8SK2U0Xaf4UCb7OR13jRQSBSF+oSWo/RI?=
 =?us-ascii?Q?zb2AQUydFWOxau+eXOT4Dnb6e0Z4n+ogiYRj3zAaV0AXLvFOVLcR3qGb4gfN?=
 =?us-ascii?Q?40l8eEJCuwOHrXeDSSNb1eyH1diUAatAi9r0nXINxhVUaM6uYm+VU9RURTAM?=
 =?us-ascii?Q?cYI/0+zwvDZSoZBXu+x3WRc3TFCUtQNZuY0B5WEpRdn3+/k3+Z5OEoMI3a1s?=
 =?us-ascii?Q?8ePknPyLgFhKBq7Bu9M8h9MEZ+edOqtMOPRpfWrxdK7+5KbjvPYnj+d4NPXE?=
 =?us-ascii?Q?INvyUPs/B2aRUDQKiuEw0QzNd1rEEISfQPe613ZUGIJBqGIoueTAMGqRONeN?=
 =?us-ascii?Q?d6VsE32ParSN2TrmzoVwk81Qv7+k2ivGbIe9Ni/IuMzf3TJxyw1epr9wsppX?=
 =?us-ascii?Q?8XoB0PaSEVv1NR4MWXlHWcNoE80ZuCY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ca41fe-ed26-41ed-770b-08df05fd5f67
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 18:43:09.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKoA5ahPKKU7LhnppBo6mSZGFujzhUMMotAaJW+B/6rZz0XQ5HAQZAQzA61nKQN6GanwKEUdS89mIqqC+F4NmE8yueOk3JY9LYNVe+BrbCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4926

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
index 18a5329f27db..2f4dfdc04ae7 100644
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
@@ -713,6 +798,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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

