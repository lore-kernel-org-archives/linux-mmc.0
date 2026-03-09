Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783AC3A63F7;
	Mon,  9 Mar 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066859; cv=fail; b=sc2GFmt+hWI/xvdc5IlKhAtxyeCOeghcHu8AqyIj1AjdsCIDmXpvXzmSgD9FZJBze2TM/EjPrxx0Itl60Lb9k/bDx2DMa6YcHzS1Hs0fwgLPAcw+rGSIuW6zbLA1PsRJzYx4G0ASFt1F801Nlp5cfBMsyEnkAaE6NUZ10ejCTyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066859; c=relaxed/simple;
	bh=0GYI0q7J7qz+qahtfiQK5FttotrKHOAW0VOjYa6wIfE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J1ZqFEc+KF5KUP8cGK0yE5f1P1DFtfYpeNc69FtbNYdR/QtAFbE4V4O4JXs6emsZ1xaEXW/mBuhL1RJBdFG25sg82+Bf0g1MuT3jpvWuV249A+zFsBHfLIZd5hhFn8W++hLlVBmaLO9hJcEYAs3pMEOpeQt8u6ItnhuWxERfExM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WTY1426V; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WTY1426V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTWMoXJguXe+Q0eRyJbFH9FVF5opCYCzMCVY4pALXaUqM1FOXug4s7g/UJBSO2x0fCkVMTlma6xZPoeNjv3tOggm7PMwdj4DSGAprbDzTrYdDilEKYVsQJWfqvDE6cRS+WV1tmtmQPaBV/ik2ywTXdX2Q3bwjFv7UcWjdtC7XModye4XrCGir7PNCA4d2oWHf/bAPQZbuPmplThh4wVWybR2R/XUlr43dVm4NFrl3HYFhaBZIaXjQdR1HlNgPmAAEoCYcEZK+Q0vZQD0qPQ9ftPWNKboejQB2icfb20bom8sr2VspJiDGEzdRW9tjgawTrcgKEcRxj0Auq7kWtP1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8CsB/7fyqCQ7iMjT6Wcm3xd2JmNHrofOq6YZrZJA/c=;
 b=citbBP8BBjnXnREdI4HPYBKwKEKh4fGDrdNduJTLAdk8RuTJq4pa7vWmK35l2AVHisyVgWArsbE3q4gHPnH0o48PQcsw50GRp+1jwoEVi0DDKx7spGVNmfWMkppJSpLU9sckNhHQD8yD6cOoONluIDs2Ayay7PB8zaAJeUdPhGkYW/9qOE1aPWplFf5F1NNWE4VCjLQPQYN+EqyIDLyRgEJhL30g6emdTsKvrsR2ekhUd4C6xI4gD6l+ZWNelo3801pOExde0DDnvJE1r4qlgJhQerHJWjNc5gODZ+76eXJqOY7NR23eiJYLtE6BTxT9DIFqz63WwKYV4OHTnqQ+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8CsB/7fyqCQ7iMjT6Wcm3xd2JmNHrofOq6YZrZJA/c=;
 b=WTY1426V6IQDWXIU0Afzobg2plUHEqFdlpsi4fagcO9rh00ZXBmM9zAOrhxYGQJjLg32B26DrU1wn0vLCuKNvIuKr+Ac6WrK6NHxnjobkCgnj5oVFj2+0/LBH+Xm7LgawqqcNfldr1OQfcgr8gHhtU3b6tFKedfRlz1rooTV3Z7wpurKhsfvANF32w4DqolqiyZoclRcAr7GHfgrcoN0ScWlc1fswh5FD40ustrLVXjO70NBgbEK21z2ARiQMDD2fIIjX9W6aBGHo8L7ZEIeUTyXf9ZciHDpfyeB50OVWHZ6s2Pq5l0h2fRdGWSeaJtork7GPkK0ZdCI7NSYst7mYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:34:13 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:34:09 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v5 0/7] arm64: Add initial support for NXP S32N79 SoC
Date: Mon,  9 Mar 2026 15:34:04 +0100
Message-ID: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 662c46ee-d690-474f-329d-08de7de8ed13
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	Zhky5m5FlIyPdO2PfFkypgAkXAnAbPTKREnrlsafTzo3PqaTlYTeglOGoX81ma0pI2SuQCgO8jKj3DN08GEDw4RzJnjhr/EJUFGcux75GnZojCb+7TWuZM1ofbcFHC4tSl0tRuCaTX60dufc8N121uKT6NDwEADqGrbG6AGmcdZvx9WOG0FmwYTjmSSqcQRsYLyUzlLQzx1xJzqbt5yoACkY+l0xU87KaY6SvKzvDXsTA1Omq9ZTg0lkuOhSvBjREc6+3GcktjaiTPNVylH6l5pS1hzpUD0oux3mB34HPguhVtfJ6jH4ySLNno0Sr7l928SRRPy9fLd6I8nSHSbkrbmBMQfmpq6n1rcq4i5e9a/LN7+NJf5kwS7wgNHz5ykN7ED0aa0ntzpEi4U3EkgcNpc0ypDM/ACQ6LG1Fdffp2iKuzKyXA0XJFv508cWhPoquUnct39COlloz0YAzWXJRk76dn/48ct+BChuCZfDvyoXSc5+vIlRgasz6arxlPnwXft/M3dviVqDNfmQvST8emtIqSz7OgQ8pqsE99qtM52OrVjVkCh19/sd/CzSDd/KMy6t+yvWHM6iCuG8yw5gzm8ZZIRPUI5vDS8TEHnxC9WxaWAk3bh+nwqt+6S9Zpu5Gq/i00MUgEl/H8B1/vPCsmdusjqkffFnNJyVUBmedcGE8K7XK+dyuEE7dMru0Zy7y3IfTZu8anAVp2aXlB5INWw5qVOBtY7TPz6wtlVoKmxnj4BFcZNp61YIncFhNUOyvHJW0CIL4T5WSwUdyefamDDbw0BIujuJGLwjwqRijto=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3BqUU9QdlE3WXpBOERTczZ3Z1JIQkNScnJOeG13ang1dHFRbDdoRFIrVDhG?=
 =?utf-8?B?VWJlR3p5YUZMdmd5aU5IVWFjVDRNVTdNNWN2aEplZlpSeFdibUcvOTdzR1Na?=
 =?utf-8?B?QUExWlRmUkQzTXdlYWpsVVY1a1lDWWlZeDJLdVluTi9COGoyc3VaUm5oUFND?=
 =?utf-8?B?bWlJZlUzbnFTY1ZIOHE5OGNSOFlMSTVRMlF0UERWcVVud2NlekxqdDhSb1lj?=
 =?utf-8?B?aWxuREtESVJFbHBkaGFML0M4dUE3azVJcFBPc3UwZHFBcEI0Y25DaW5XZ2N1?=
 =?utf-8?B?WnJTTzBFKzZ1czNGbTdlZ1UzV3g4RWlIeGFiUkc5WVg3MkxvN1BVbHE2Ymdh?=
 =?utf-8?B?VHBhSngrelZHRVVRbDZlcGFzSEthZWlWYnRubElpTGxUaGp4Q0pEdjZMbWlj?=
 =?utf-8?B?clBWQ1FsUE1wSkdkNEdrWlFpS0FvK3RWODFRNjAxU0JNWWRuT1Z3RWJ6NDBU?=
 =?utf-8?B?VVVqUjJiV2g0bGRRWkN5RlM1UFVWYSt6N215RnE0dnVTbGpTNGROZjFQR2s0?=
 =?utf-8?B?RDd5V3k3QURkNG12dlZaVXpKdkhVakJmTHI5cU8ydEhndHFoa2hwVnQvUGZx?=
 =?utf-8?B?d3d6dXIrdk9ab2ZiSVhraDBCU1BMKzFzVXlEdThLVzd2VFpGVzhDUUM5RlZK?=
 =?utf-8?B?dCtPTXJobkZVQXBYYlFqSnJJNDZKVng0RHE4Zm9tNEJuYUc5L1JFcytHcEFU?=
 =?utf-8?B?Sy9zeCtsdmdmZ1FUWGVtZDgrWlFzaUc5S01VR2NCeW40RkoxVDRXaXU4QmRH?=
 =?utf-8?B?UG8xcEIyN1UvUFJOMWd6Q1M4aFBuSldxRG9XWHBrU1JlQ0h6N0pKZENnR2Y5?=
 =?utf-8?B?c0x1Q0JDeG5VZmhPZEpoZkFKL1l3M2FxNDJ2QlAyaXNOUU5LbWY2R1RydEk2?=
 =?utf-8?B?ci9NZCtSR1hHWDNTUnhpV2RWSnhLSkVrRTFTM3hnS1pCK2ltdFo5dE1jTXhy?=
 =?utf-8?B?R3FoL3VtU3Z2QVpzUUFvZDh3ZHFCMEdqaVl1Yit0RXBScFZrZTJuNHdIOXQ3?=
 =?utf-8?B?YXRqKzB3UUl0NUZ5aU8zNkFrdTBUNVF1eHlCOFN5Q3dEbkZOeXNQNDdYRG1i?=
 =?utf-8?B?RFN6NjNzNHB2UGl0NGFNaFIrbzVwbWFUSm11Z1pVMGpnandiVFZHTitIRENS?=
 =?utf-8?B?TExDRGlZaTZ3b1ducFI2eWdSRDdYNkNRamNjYzBrS1hpM1RzUnJVcTMyWlZy?=
 =?utf-8?B?Y2wxVG5MTWU5VHlyaDFqVjJod05JUjNtUkxFQWxGbWFGTzZwbW5uejFEaTBE?=
 =?utf-8?B?emNDTXp4Q3YvcUJLcWpRRDZxT24wSlZqZWtUWDFJMzRhdXBaSFpjc0poeDZ2?=
 =?utf-8?B?UFlxY3BIYVVDK1AvZlNtQ252NW01UG02VVVxeGNTRnZWV1VGNXNOUVJHMDNW?=
 =?utf-8?B?SVVHdHpsWE9xNFFaN1RiMjlsd2IwSFlsYTVtUFhBUTlIY3o1elVCazNpVTFS?=
 =?utf-8?B?NVZuRWE0RzZGbmE5WWE0THZsR1NPT2EyRmhOeUZKNzRiWUF0UjgxNjZMRDFs?=
 =?utf-8?B?Rk40aDlzVDU1Z1JDMFNYTHpEZHdTeDU3N2NjZm1YYllWR1dKSXFpa3IrZXJX?=
 =?utf-8?B?TGVTVTZWd3duekRwZUZxVDBBVGFLb01CalF2WWNzYmc2ckdPWFVUN0VZeWxl?=
 =?utf-8?B?NlBhYy9OcWFqS1IyVVFjUEUxQURDV0g3KzVNTW9mK0p5ME50cGtHYXJ1WjZr?=
 =?utf-8?B?VExkUDM0K0tndzlqUU9xbFNQUnJqL0I0REZoNzFkaDJwZ1UxdmNWZDB0V3Nv?=
 =?utf-8?B?VnVLY05Mc0JBNU5BOVQ1dkc3VzJyWkxFRkhqQ1J3eWYrd09ITGo1L0dYZVAr?=
 =?utf-8?B?Y256Y05xSTYyNEpMWjZ3NVBjRVNKYnkwSW9GNlFDYVpPd1ppNEhLU2hrRHB6?=
 =?utf-8?B?Yis5Z3UrVU1DNTNtcnVJRXJ2aWRDeURINEFMUjROY2pNUnVPMVBsQVc1MmdF?=
 =?utf-8?B?S0NMVWhLL1ZLb2hhdnJheHdCQUpTUDE1aUJQN1pFWSt2dmlIWWlXTXBQMG5v?=
 =?utf-8?B?eW81YUNRUENBM2xVUmxvcHpKQk5FSWp4ZVRuUWx1Sm9xdTZ6cGNYMmRPVTRo?=
 =?utf-8?B?NGt3WDZLQjNVQjErKy83N0ttaWxJSnlFaGFlQ256QWdGUHlBeHBxWlNsSTRk?=
 =?utf-8?B?Sjd4aFdUVVcreTlMcWhwak9DL2Y1NG1jMnJHM2wyS3FFNDJHSFdvRk1SN1V1?=
 =?utf-8?B?d2J1VGtlamhFQ1N5aFNhMDBVNjFCMld0YkZaVGRYVmM1OWNRYUhiRlgzVVNG?=
 =?utf-8?B?c1ZiY3ZrTlo3eHc1TDFGb2VXaUY5b0pCQVNmUHNSbmZWU255K0tsUnZmOXUy?=
 =?utf-8?B?QTF3T2ExMCtidlNxMkZUVmpCa1U5MzdrYytQZUxxTU1xbUlIK0ZqbmV5bzkr?=
 =?utf-8?Q?QesnT79q+XgBwfkA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662c46ee-d690-474f-329d-08de7de8ed13
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:34:09.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s03Uxl12NPTXm2P4yAb4JzlqxKO2nYowZK51xd4Lm3TeCkf/1Eu8+Y2WLvZCPgIafn2hu6RO69bCYV9KsZNTwv/2tAe4VK3VFoXDrpaBLP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This series introduces initial device tree support for the NXP S32N79
automotive SoC and its Reference Design Board (RDB).

The S32N79 is an automotive-grade system-on-chip featuring eight Arm
Cortex-A78AE cores organized in four dual-core clusters. It is designed
for high-performance networking and gateway applications vehicle
architectures [1]

Hardware features included in this initial support:
- 8x Arm Cortex-A78AE cores (4 clusters of 2 cores each)
- 32GB DRAM Memory. 28GB are usable and 4GB are reserved for ECC logic
- Three-level cache hierarchy (L1/L2 per core, L3 per cluster)
- GICv3 interrupt controller with ITS
- SMMUv3 for IOMMU support
- Generic Timer
- IRQ steering controller
- PL011 UART controllers
- uSDHC controller

This series also includes the necessary driver updates:
- sdhci-esdhc-imx: Add S32N79 uSDHC controller support
- irq-imx-irqsteer: Add S32N79 IRQ steering support
- irqchip Kconfig: Add ARCH_S32 dependency for IMX_IRQSTEER

Future patches will add support for additional peripherals such as
networking controllers, PCIe, and other IP blocks.

[1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N

v5 -> v4
- Squashed irqsteer 'Kconfig' changes with the actual driver updates.
- Fixed tabular layout in the irq-imx-irqsteer driver
- Added received 'Reviewed-by' and 'Acked-by' tags from V4.

v4 -> v3
- Added missing Signed-of-by's from one commit removed in v3 by mistake

v3 -> v2
- Split S32N79 SoC dtsi into separate standalone commit
- Renamed a memory node in the S32N79 board dts
- Fixed IRQ STEER DT-Bindings support for S32N79 addition
- Updated S32N79 usdhc driver support commit message

v2 -> v1
- added driver changes required for S32N79 uSDHC support
- added driver changes required for S32N79 IRQ_STEER support
- updated commit message for uSDHC dt-bindings
- implemented fixes for 'dt-format' tool findings on newly added S32N79 dts files

Ciprian Marian Costea (7):
  dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
  dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
  dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
  mmc: sdhci-esdhc-imx: add NXP S32N79 support
  irqchip/imx-irqsteer: add NXP S32N79 support
  arm64: dts: freescale: Add NXP S32N79 SoC support
  arm64: dts: freescale: Add NXP S32N79-RDB board support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../interrupt-controller/fsl,irqsteer.yaml    |   4 +-
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  70 ++++
 arch/arm64/boot/dts/freescale/s32n79.dtsi     | 362 ++++++++++++++++++
 drivers/irqchip/Kconfig                       |   6 +-
 drivers/irqchip/irq-imx-irqsteer.c            |  55 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c            |   9 +
 9 files changed, 497 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi

-- 
2.43.0

