Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40A3B95F4;
	Wed, 25 Feb 2026 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026749; cv=fail; b=SlAKnT4x2URfGUwg8juN1P5HyKIvWqzvPv4Nl/qwHWA2XFym5Li5aF8Lvfy6KNg/pCNG8rhOOeBz/seJI/S6dR6QVPtq4ejDEUuqh0WEptKB4JQGPi6j/Ek7aUwpcfQQKs8Liq14zX+Jq06R1CpgXJ+XOdvw26cp8sciggEugcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026749; c=relaxed/simple;
	bh=lrl6QcG9E76b7Tc6pXR69/A1HB3TXpP1roWLUYoQKoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gyIRkCjOErH0J6paadFBJ/TJb10RngVgxWxflpDdkuiStcjiMep1WWjV7FzhAj67kOIFw3aVWcCFwVJZSuQNyujEIclGznDiIwbWbZH97VOzqEjwKactAxASIXPXouQ32ww1WOvc40JU44UaQF6W+kls7UFEAC7Ov/OEkUiIvB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Pzf9Ws9b; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pzf9Ws9b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtITKTllXZ1uCRjdtUN6bMWAcnLROw2W+kIO05PK+JxU73drp6ueCehfmeiSfKsdq6Aar2h43c9q2grgJguxIFJROmJZBEMnj7LPRpISxFGN84tZ6ku4su3MOPbZIi4d6u/xCqJcvWeP/cTwocN1Y77PAMUMgkoVIkOJq2jNDLkGi8X8X7MfUGA5LDBdrSdkrWnThgByOivr6+p9bF3r/26Eju5g+LO167p0vUSdl2l/q0eVKQ+ATixlXaCRXPTaRNSckY4mBRL3Uujtur+QrWzuDpCyCmV9gqY/r0H/Idb5f/SLaEe82bkaY+7ltfaJKJknUjTWtmrhR7NM6WVCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Loea3pPtk0mRHwStRULjCN4ydjOA3gSTpYfnhsi9B30=;
 b=OOyKD6pw24UbnkcHaEHZ51wFumr5zZtc/49Yy3syN1imu4Hw/VoFePy3RDTjvmOlNAubgSP6gNKG+6X1XvCmga3BQ9jhrV0G1ZOkEWD4QuiNK6xvU9RDnbrcX4jD7zrlR64oOHnHx6QoMw62+0jW0Bcppg1vcGzjV+G+TFsHUCr3utO7ydar4zy7TMwDeSpmjZ35mNoxYS0LEUrce4dHz2bs7l6trvEtt/jLbdNYbig+UmueQbEMAkN3BArnjDAwWRUL7uuTEHDNVVDhXH/Kibicr8GmySxtNpbCvKS77da5r4OnKe35X61AqqzD5JjI29UfKGaLnVhXlU9S9ePC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Loea3pPtk0mRHwStRULjCN4ydjOA3gSTpYfnhsi9B30=;
 b=Pzf9Ws9bqELglpNqFoy13hoTYDu51ARgXqD2/MCkQ7916vXqXZEXFD0XSczKZgUNEi9U0jrwPIdK/Baz802ynHhyp58FG7CK/1t/QaiYyNJotYmUIS3VoIOglvW3D6oshVtWp7XcACbOPrEU0zRFjkJ+Kdk4cf8eYYk0HLhwfr1fsewv/aK5/zHcP/vEwZdJLMjmKScL7LcIU2usOZnJaVZ1xXHHJoGddisDEQM90aAwbeTkMvzInBoaVMP4htKe04NIyHpaEVOHWjF5qaP7UU8GWcQ4ZpEzM2/u7e/hoBGJ3uHOFW96uheCFQmL5fjtsVTdQuawk+DAPrhn6s6pSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:39:00 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:39:00 +0000
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
Subject: [PATCH v2 0/7] arm64: Add initial support for NXP S32N79 SoC
Date: Wed, 25 Feb 2026 14:38:51 +0100
Message-ID: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: e14f4dfd-0c92-4adb-97f9-08de74733bb7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	28NRgiTtoen/4r1/c7RNFQaotCXJcFo6gcxqoef50XrOCav/0kip6RaCeq9XjQ0eoeYDpYO1wg8fFvMt/rGYZ1KpH7n3lfR7nABUcZ3kNPJ3Zg+0WPTmxAroaxLc2oBAYdzEDE9zufWbhmqGcHKupu72gRZbydawwIFiSwgcTqcmtuxM73X9EbGd9Z/lWX4vTxqASQHPu1htiAz3ELGc3vcuOxtrHnBlvrLXnjpz19VP3kQFO52HOcY3PwtBOee+GUz0qzi4Z0SCM83YrP5dGFS+C79BEJ4XcLVg453h4svg2VbESvDoo+HxjcwmXq4FXcEsqlPeXpFTJo4kaUILzVIUas0GnqdNmbzWBBkZz/mRUDJMRcR5xY/NSNYG2q8GGkLhkTlQ7YBafXONWHTVVAc58ne02YEqlmdw1xOr0oSlLoZrxBKSdVLcUHX+3V9pN3PAXlFFzXiNf6VZi7ZHDm7eWAqIg9F95rTyZ/fHFm/uvKHcnZVBLCSvXoptVUPKif3t6rBWnKJjf+bjbRZTF1YSncm9d57uksF+kz7/8/R7iqjKax1vJOog4XBcz6/0+rlZUDSI6kp6JBB9N02cjWrpbEadg3g3wpnY+2hAeFUtaRDLwomFQZSnAzzBnlpxB4Gf88nNKo04Szz2RVJPeBo5w73GtmesDcn5IQaFMULJv+srULgKlENNmwWEWPHDHSA5pdd+kiXEdgWHqIaVXQDqQn8NIt/7+SRtvi8o+E339I7wpK4ZuiR20LYd3VSN+2gvmHCn+Of9vZIoETrVLmiYuaoOQhtLPkKOMOnmn3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGR6WVVFVmlYRkdsenZvVVlHdmVzRHNDeURMelljY1Mxb00xSHlKcnNwNE5M?=
 =?utf-8?B?c0RneFdaaUJzVG5VcThuNmk5Z1VjaDhTMlJsclM0M1VWSUczMndLZW1NcmNV?=
 =?utf-8?B?cGw0NHZPTXR0ck1pSUs1TS91aWlqb2lQdURDbWpQVXJWV1lWZ0JUYVc3QkVC?=
 =?utf-8?B?YkNGLzhITlE2R1BZYXp6YlFpa1VwRzNoVE0xOHpLeXBpQ2Q0cDI2TVh2OFFN?=
 =?utf-8?B?UTQyV0hTNUEzRUpJaVJrQkR4ditWbU9lc2xTNURPWHFkOUtKTzk4Wld0SHNW?=
 =?utf-8?B?UFNMbFF5QXV4R1pmQkNKOFI2aUdGbDY0OUV3bnl6aWVVcThxMHpac3V2bFBt?=
 =?utf-8?B?S1JrOEN2c1VaRGxTcDFsMUVoT2Y0ZmM1SnN4Ky80SmI5d0J0cU5qSHVzUkwz?=
 =?utf-8?B?cVdqTHdnRWJHNGRKcmJEZmJhOS9UNi9MZ0h0QzRZK3JOYXBJc1NXK2pxMXlv?=
 =?utf-8?B?MndtTFpZUGlBNitCWmg1SkFlSE5Ib3g4L01lbUZJN21CU1BmZDhJMzZEVkh6?=
 =?utf-8?B?WnNPTWJYb1J4R20zazVlaGQrbzIyYUlOSHozQUpaWVA0TnIvVHdDbVpXdVd5?=
 =?utf-8?B?S3ZNOE9pTkFGcG5TQzhDcnM4SUlBVndXY3NRaVA5TDkrM0U2NzBjd0lLWVdO?=
 =?utf-8?B?bS9QNitZM29ockNJTDBNRUVFRmYrUVRsYTVoOVpub28wVThTby9zZDh1NVZI?=
 =?utf-8?B?UGZZRjBnakVWdUFnbUxwN29zQ0dNaUxVSktjaVNhNkxoTi9kRDAwWnRBTHA0?=
 =?utf-8?B?MG5uTFBRbDg4NGVNWkJKN0hZeWZvWUkzVVVXbkU1TTRpOVJQL2pMcHhlNnZ1?=
 =?utf-8?B?ZU1nYmpjR0d5ZFQweGdjWjJQTEx5THBGVjh4QXBvNGg5YVczRDFVT0NBZWFV?=
 =?utf-8?B?YWEvVEVVQVRiV1VNNXcybDRSMEt2OXBxUGlXQk1pUmE4eUoxMThqL0ZoZzNN?=
 =?utf-8?B?RWQwRkJzRlFoNFF6Q3RrNURzWm9lL2Mwbm03NXF2ZUxjV3htMFJqR212WWlR?=
 =?utf-8?B?RVMvVy95TVlkY0N0bm8vSlNiUEM0a2xId3VRNks1OGNBNmtIbGlld3pzemdn?=
 =?utf-8?B?S2pidHpxakpyVGs2MHJkbUMyait3bDFzK3djR1JrNmJVODRPbTlmSXYvbmpP?=
 =?utf-8?B?U0ozVXY2cEF6YWtJd2I5NjZ1bUVvWW5pZzNLcDRHamVScnA5ZjhVUjA0UktJ?=
 =?utf-8?B?OWJPTkhhbjJWUCtqSG5UM0Z3b2lJaFVFQU92Z0FGYk5HOCt4YnM1UTRUQ0tz?=
 =?utf-8?B?c1FyMGRiWTR5K1ZweS9DSWtRVDEzUXZqTk4xc2tQZkdSNnh5UDN3Sm4weVky?=
 =?utf-8?B?S1Y4MWQ3a0hiODErMVUvTXo1SkR5bGRHd3hEQmRoV0w5ZjNud003MTc4Uko4?=
 =?utf-8?B?OG9kc1JiQXZUcmRzMXNLOWFDS2xId0grQmJWeHUycW1mNVNPZy9lN1Zjb3Nq?=
 =?utf-8?B?U3FzRFFOQWlBTWF5WkNNSjJlamRoaWZ1Z1dBTHFuQzdpTms3SlAyU1FhSFo2?=
 =?utf-8?B?MktiUm9uc3UzTXlvL2tZT0V5SUV6ZllMZEMzUVRzVjNtaDZ4amFnT2ZGR01r?=
 =?utf-8?B?ZXZvTnFGQjRFNDVRUlY3Y3BjaFU1RmdjTHR3OGNhcVY5RVlZY3FJVjFqcU5D?=
 =?utf-8?B?dTVTMjhieVFBdk5JL1kzbzgvdjlpK2diOXB2U2FYa2FQSEpld0lyZTJzbXdz?=
 =?utf-8?B?YThlOTY4NjBVN2ZiRjMrN2lqbDdSZGZRY2JOa3YzaXRLaVdqeTJ3cDJkY1M2?=
 =?utf-8?B?dHY1NWd6K20ranltbTNIRGtwN0Q1UExFdGk1SzBib3dVeGFpaGs2SFZXV3U1?=
 =?utf-8?B?TXpVU243TUQwbzhBd0FsWnRlTlRNQ1llM0RUMm4xaDkybEFYbUpzM1E5Qmkr?=
 =?utf-8?B?Z2NGb1VYeU40SDZlWW0wbjliNklOVm4xUDZjYzFFWnBVWjBNTHhQUXNaU2NJ?=
 =?utf-8?B?WGFLb3RjWXVNME1KZmdpVnRKb1RhOEhkUWcxNWpGOHc5L1dBb3lQZXpYT0Nu?=
 =?utf-8?B?bEsyN2luSEx0R0dlQStIL3RmbW14ckhHQ1BXcGU3OGxnR3lNNmRFSmtKdkFr?=
 =?utf-8?B?K3JFSTlIVEJnYjdtbnduazcwS2JaTVFrUTlCRnIveEpFaGdRWEN0RG5DdHpa?=
 =?utf-8?B?RWdVU2lzYS9kZERDZkU1SDRBdVpJZGtKcjhqb2daR05wM1NDd3RnRnRITkFp?=
 =?utf-8?B?SVhSUnlRS0psNjJMdThZcEt0eGJLRjVGcThDV01CMDRTRDVZaTV5NW00KzAw?=
 =?utf-8?B?bmIxMmlvUzFNcHc4K0hWZ1Q1aFRMcUNSNERNaFhaajlmdXUwdU1xd3FVZGZZ?=
 =?utf-8?B?QmFCOXJkQ09HN01SNlhZbGM1SmF3RE5yKzNMSzUyOUFSMVBjOEhrTFZobUVU?=
 =?utf-8?Q?RpWgkhCvPDc7xaXo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14f4dfd-0c92-4adb-97f9-08de74733bb7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:39:00.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dn8PLYxb28efBGa6nm6tl1VE/LRkrccbpgMIXViTSSW/Ufw5pQKofyF0Jrtg5xHO6dFaiRB4uTzYl3zqhqDCXJpXDxttGLpxEmgZaLtw5IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

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
  irqchip: add ARCH_S32 dependency to Kconfig
  arm64: dts: freescale: Add minimal support for S32N79

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../interrupt-controller/fsl,irqsteer.yaml    |   1 +
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  70 ++++
 arch/arm64/boot/dts/freescale/s32n79.dtsi     | 362 ++++++++++++++++++
 drivers/irqchip/Kconfig                       |   6 +-
 drivers/irqchip/irq-imx-irqsteer.c            |  35 +-
 drivers/mmc/host/sdhci-esdhc-imx.c            |   9 +
 9 files changed, 485 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi

-- 
2.43.0

