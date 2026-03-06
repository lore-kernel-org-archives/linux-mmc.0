Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B03A5E92;
	Fri,  6 Mar 2026 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809916; cv=fail; b=OximVD41tgHUGUK3VNm0sqxQg7RSYhksHRFMU1LZzm5CkciT0w11WLpf/c1WhO1kqRh/9UY/WvCEV7noiTcC9+JGSW/5yUtM3EmY1LsHMqrvFChvbluDmYcUNQMEx/+5uxqNgY3dzWVblFZI64iD28KFcqAzKdNu+edC9LDsF+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809916; c=relaxed/simple;
	bh=KAZH+F+dEwUQBPaP/XA9VEhr1i+Wr4grN8iWStcd7U4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u6vQZsAyx5WcrpF1oudX47uQEUVmbI0Zcx1MtD+LeIjupbr8e0Q3GVL5ebzGYA7HmoFhvCe0AGYpGH7swdGdWLe58XMcTunzme+LvFG1Yj/okzmv2GyGeF5eBXYZ4xmpwYfnWI+72ibsmEc2fPx5+9z27Jr6KphxTMMvTzFMHEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JT0bytKN; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JT0bytKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt8YhMDE2PE9IBQiNasv4i/x1hAJt3DzXI+NtIRxR/Y7xWg3m3JR2S/dY3JDWGScqpH5CVn36Filp6Jnfe4GK9wFapqULw/0onqFzOmxI/6OPwOTohQMahmfNvGcGK6lUOl+XZjwEJIXaVK6COHaHdHbdR2Hk+LA6oUCrTJ6Kkg5w/qD716BKSj6tzEI2eULTQ1IIiA1lxniLcnzvfeFn+mCsj5ggg0r0TD175ubIILPIqmh21bycRpdoeEfYBaVkJDl3A+/trKlATFhto9omYQucWi0Gu2HAmfVMq+vIoHb9Obx/6uxH5HUvhzy/iYyJDJAPtPCYWXh5cjjlGBv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlFRRb52j6fQV3xLc0/cExy8OrDKJcQvtwB8my/TLyw=;
 b=FoueVB0+KrSrbOMDdH9k16NL3E8XHk+xWFfRthgThxn+pP7DBA0x+YVP72MKxirK8jDUrYpOhBPEMktMtU3FhfJhPbQPdfs29S6Ls4kipFHYY2onHxrNxPLU1QL5SgCoy9ZSB36IzanLG8YuKUniKK8Jgx4GhtPibH0lP3L9Xnl9Y9wowk+jFV14IKNs6aG5CpXGhZfRgpN6p9lYPgL0p1iQLY5Pg/eUujAiE7+s9lAeBu6iHhHEu7Jr2KduMVMaulxLXVm1b8recHTGTmdwNSAgrNflDVFryoDHpzIgqe2qFvStDNQNSnI4YneFQ2lPYWMzoth8dMr/jX3yTK0bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlFRRb52j6fQV3xLc0/cExy8OrDKJcQvtwB8my/TLyw=;
 b=JT0bytKNI2uf7b/HuWhBCD8UCt0o9TpC11+rvAqL84g6MgBdqMw0MtCJsi5ECCtgsSkH5yIRkNPu2ZFp7UNGonJBRMVhZ9A2A2+J5BHM7wtEGIQdLGuphUgNYUc9UcUIXo4dDgqlGkFavrEYGQUdgxcgRP126wckBC5JX9VLIL36zP2wmbMBerOeWZ2muELl+vQj5bjHf8JoQGYJyyd9Ya283F17VsqOxjwB9sBmSc5lZimzJCDMRzP/WIioPHkeJVqghDL+JLseJUIxtdvD/4/Bc7143AmJXMWlQ0RAxIOR4z/lq8czBJ0RBYvSSyeCzMZK6jOPkA/h+nfdEoJPwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 6 Mar
 2026 15:11:50 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:11:49 +0000
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
Subject: [PATCH v3 0/8] arm64: Add initial support for NXP S32N79 SoC
Date: Fri,  6 Mar 2026 16:11:39 +0100
Message-ID: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: f4874998-14e1-4575-69fd-08de7b92b0d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	OnP6LhxkgKfrt3UNoV00ZzH7VJstIB0VgKIwX19m8SAVEQlKXFZLJRLhFxtlS1xFJck78spktJPNgqoSjCC/0q8g9SIrgHU8yHE7DNRh34pNqBEdeeK433MU/18li2eSdDONy8cpSs077Cc/qivjvwCzhtfUFZcZ88sub6SZsJ5Ld2YZ7DnpdddvivYPTAP4qo048yzDE9F2TVHEb/43/+U43oCsQRSUyL/0Kmg/Vz65fS+jkSNKYq+bjweGVBZr33n5PWS3eNl9IpNoLatjmugTpaw3WDTSM6rgiFB1y8nLDtHUNQJDKJrDZG3s/YGp00Fn5VfATC9r1ntIFoNcbLnsjCnC9XRwJqEwVC6R7T0tiuxqzBdpOMU1ETsWEeO/xtVJb+IyVMkWzyfx2SPJ7yfQbKpFYspKSMdeHa5X5TQDdfrXDpS1GIqlWOXNw76uTwLs4szQVQFWiqML+PHirPkgEKzTYJYeBX1R7HPuRqJ7M7g6W1yZykoEzOzp5i5v0Gw66u5PXVKBwPY2mlqtCXnpMdI4NEgH7tnnZhMgfeZZfgLzcNhU4nsBLsXRY27RluIx9iBAXPZdWSzX3unQB3/Pyy4P5T3ggqF5/mX7Vhg+/6frhlRBKyW51QM87Rl+v+U/MbxWbRb3Su/iRRwy62EUWRXITN5O5ge7CkhOmYkUxo2IACeTxlgEsklBkQMCufDVQAZ7k6ShFGA05TR8ImwUmLzt8y52oCJEnLJfLAQeGNLubPLt3fSJJSr5/GM7yBKo551fTxSInaHKcOrY0eeuMbcFlyAXKOaz+2OUUkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtFNGEyWkZPaEY4RlkvSHlLU3pES25waEZIUW4vTlo5MzN2ZDNaUGZxNFps?=
 =?utf-8?B?TlRzK0NmVW5yUDhPYmkxN0x2aTJJRG9aNDhXQ1JmckNGVStYcXk0d2RRNmdy?=
 =?utf-8?B?cCtoNE5uRXVnY2dLZmZBVTE5QnN0MEFMNHp3UEJlWXpuc0U3bm1xdVJOaVJa?=
 =?utf-8?B?VVdUeFRFYkRRWFNOZXdUZ2pzM1RlOXllTGhsYldpMFRqWkE2SW5HTGs5dlow?=
 =?utf-8?B?c1l3bU9jWHZEcGdwU082WWoybUk3eVhiOG0xNGgyN0UrUmlPK0lSWUdTZTZ3?=
 =?utf-8?B?V3duV0wrRi85MDdZZVpaVC91STl5NTZKbHFzSG1BN3V2emtEWHBBSGNvdmN0?=
 =?utf-8?B?QS9XU25GTkJ6WXRnTmRIeFZPUGZ3Mjc3TXMrZThjaHdZQlpDUTVWS0dSd09I?=
 =?utf-8?B?RnI1bXdKeGt6MzZCc0E3bW9wMlJuZ0Ryc3drdWFSMnBhaHFOYTg1WlR6WjZT?=
 =?utf-8?B?MHdsMVZLV0RYTU9xUkVYWm50dXpYT01IbXVuMUpFRVhaWldURFo1UnhGQko1?=
 =?utf-8?B?L043aW5WTHBaV3pvTnpGWjV6R3lkN1QrLzd0bW8rSS9VNS9yWHl2WGlOMHVa?=
 =?utf-8?B?MmM4aHhlMU8zTURMMTRsbU1KNkJ3N2NjZkdlSjc0RzhsNEdNRUZxRitQRWpI?=
 =?utf-8?B?djgwVy9ubFFLSzBYSmgyUHhIWEh0cVpNZmhyNjBNdEc4cklRc0V4dkNBTUNr?=
 =?utf-8?B?MFBrSEplaUE0REpTaVI1SGRWQ3dmMC9DMG9SSmMxYXROaGpwVW1STmJkSlVr?=
 =?utf-8?B?bldRRW9ZZXh2VjVVV1pQMDlzUDBqdkEvUUZaWXVLYXlnb2RwQ0pOdHBrS0JU?=
 =?utf-8?B?cDRZdTMvTG1pWXhzTzJ3Y0Z3OC83eTZXeTlQamNyODkvZDdWWWx0VStEMVBh?=
 =?utf-8?B?Vmc5ZDAzVHZaZmQ2SlFJT0JoVGtsRUFuc0I2UWJZMGd5YUxSMFhIcUxDbHY2?=
 =?utf-8?B?UlJpYlNYSFdiNTJEa3piK2JyOTBGOTZDUFgxbGRWYXlPUXFoOGpQdTlyOEdq?=
 =?utf-8?B?THlxS1FEVzIzNG9tVGg0bHRqc1FWVGlUeU9wRXNNdW9XenRianVHWXNFZmox?=
 =?utf-8?B?bEZmaGRJcjNPV2k5L1JkMXEybVBnUWI3N0lrVlNNUDFQRE0rTlQ1cUkwODJI?=
 =?utf-8?B?Wi82Vlo0SFJIT3lGSE1JSzVJYWw2L1VwR2FLcG1TMWJvMmRIc2swN3dSeFdr?=
 =?utf-8?B?V05SeFZMNVhXNTMzVHU5c0hMcGxCSFFzS3Z6dlJKRjdFek1zU3Rydm8yY0Z3?=
 =?utf-8?B?eHBTT3gyWW8vR0t0VmZMUmhSUHJ6NXdsM0toMEhNVFBwcGpTQXJ5ZmxBWkN5?=
 =?utf-8?B?Z055N1dEYi9MZnd4eXIycDlUWVpHSUZaZXNhcXpOMDdtNXZ0S2FVK1MwMG5V?=
 =?utf-8?B?VUVlYmJnMmJYYnR4OUVtc2doaElEL3ptUVFxRnQ5RVh2T2Q0bXhsb0lmYVNO?=
 =?utf-8?B?VXJ5Q3lsYkIxa2VZMENZbjlBS0NIblRDcERVR0VQYjEyTzd2OVM3M3Y1NGp4?=
 =?utf-8?B?NEZuVWRBY3BaT0xaMU9WU0RqblJGL3hjWDhVTVVKbjNab1ZVUDBaMHNTMmlj?=
 =?utf-8?B?SXZxVE9rNEdnTk52UFNkUytNaXVmSGZNaEFVbkxRWTlvQzl2QVJMdWxXbTdk?=
 =?utf-8?B?Zk1TU0JyNFlDeWpUTVZIUjRrUDlqQkM4NFo2b3N3eTFYbGR3bDYyNEFBdi92?=
 =?utf-8?B?TDNRcXU0RWVVSWpaVUdzcVBKN3JKRjY1R09RQ2o0UFBCNTAxNHJlQXArQ3Y1?=
 =?utf-8?B?TFIzSm9kd3RJWjYxRFB2TXA1b3gzazlkbjJjdHU0bTJhZjVvZ0krM081MEVh?=
 =?utf-8?B?L0tXUy9SQjd0UGJxaEo1WUl0TThNTEJKWnM1dVo4eDlnQkFhWlNzWWkxM1Zo?=
 =?utf-8?B?bXd0SnJQSTQvamYzQTVkcWdjYlFQTEVIb3RrSm5hVGlJd1hTYkxWSElwM2VM?=
 =?utf-8?B?bk5OMk43SDZ1OGRiN1Z0bVFxdGZpNHRlblJ3RUhkL3JJaUhhV2NiNVBaTFQz?=
 =?utf-8?B?QnZ6R3Z1SlQwbzU3U1pzWklOQWpDM1RaWmV6ekVPT1l5TnJEQnRURXV0cG5F?=
 =?utf-8?B?VGZMTndlTFByc3RkKzdtcTVhS0JpV3lQb0JXRk51MU5vcUVORzZ5a0tUSUZv?=
 =?utf-8?B?NWJDUmlybk1Wc2w3Rm5pQ0dIMXZzVzJ4UVVlbnk5M3ZQQ201QnZqZ3MweEdS?=
 =?utf-8?B?R2RzTUprVGk4MW9kS0VTN0NOTENyemR0S3hjRnpDOUhmOUtDU0ozWnVkSkVx?=
 =?utf-8?B?OFE4OXdqTDFKbVVoTU93TU5NRE9lTWk4TmM2Mm9od0FTU3crN21yREE2ZlBE?=
 =?utf-8?B?a3lmYWU3UWlnV2tTc0pkWEN6bmhlYXpZL0lIaEU3Z2tNMTZETjlNaGJZbjll?=
 =?utf-8?Q?G5nnAmECw7eH7TY4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4874998-14e1-4575-69fd-08de7b92b0d0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:11:49.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyXU6J8FddY/Hp7d+YygjTDUAgfpyn2pPzclqDcC2ZFnbyWaNzvL3KMq1Yh0VS35h5F6fcOp6ny64BIR77tDip4HsmS5yt6F/Mtkwv5dqYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092

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

Ciprian Marian Costea (8):
  dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
  dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
  dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
  mmc: sdhci-esdhc-imx: add NXP S32N79 support
  irqchip/imx-irqsteer: add NXP S32N79 support
  irqchip: add ARCH_S32 dependency to Kconfig
  arm64: dts: freescale: Add NXP S32N79 SoC support
  arm64: dts: freescale: Add NXP S32N79-RDB board support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../interrupt-controller/fsl,irqsteer.yaml    |   4 +-
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  70 ++++
 arch/arm64/boot/dts/freescale/s32n79.dtsi     | 362 ++++++++++++++++++
 drivers/irqchip/Kconfig                       |   6 +-
 drivers/irqchip/irq-imx-irqsteer.c            |  35 +-
 drivers/mmc/host/sdhci-esdhc-imx.c            |   9 +
 9 files changed, 487 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi

-- 
2.43.0

