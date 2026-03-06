Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953D3EDAB3;
	Fri,  6 Mar 2026 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813768; cv=fail; b=a2SP8EKRn1LTElJ+Cn7+kFgNRd9lfcozPd5h6aZWCUhslFGUTL4v7HEnsCniryoowJnRg51afAbImnT6uhJQQowOHpYzyFM92dOdaY8TaAWMwkmNg4t6LWu3rzTkHFi4fkkQ7sHR5WLGeLNDEf67u81SUPqOFxfqaQV01WZDxis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813768; c=relaxed/simple;
	bh=Eu2Lif7oig1sXrYKU/aknIXv/YBvB2sXfsGPQ0GKT5c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IYzrdg1hMujMwM1rDbRVUr6wCKui/NxIHsNJPdiwUTSsIlw3w8+fcjcVFYVBdRJ+lFo30Vur+e5iuHc4/NgsIKBnVfQEpOcoLhVw5fWXXV4ioJkdi4qQMmMiY7McAt2pysDfdt8hjh0P63VRdkG+QV4rvhPOGj3CB7XR8bhnh60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=krJ02j9C; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="krJ02j9C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qG+AlEhEjBaxfPxPE6XsRVJz0Qoiy7eDNTbnXOiuQFqG+cuixncNj6zAxM8hujLbxH24V9n9d9peRo0ibWUtUYB3P/e4ozXVjTBQlBvNM9cU9kZfAy5HJij/eeEAT+TTp5F4cus+8X68cL4XZVMrmn49vBqHZVDhtXl78N6B90x/NynRXD1F+vFIOOPfXvExZOnUucb7j8RQAyNVNIvDLK31K9mRmU47nPXLXnhGBxyAiNNJnGy8fKeD6PaBByFwxVX3NA7NB0uDgyl6zVBxIGCEAWdgu1w5GLtPGXnMu2Pmcc5zjYzTk7inbvyzQUM77vyt3I9+o6i+7ws42VHZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVi7I4JstooUzY8vLtDMgtxO71ejk1UGX9CpYpnrqZA=;
 b=pmjwDmE5wXGGaOknevAzICr6t/bxFyJisr/ZxX3amOydpeqA0VNfX+81t3kilvEYwaxziEaH/ADWtxTf1SduI7ccZU2OSJyJXdRULoN490jMnkpdgzR695Dpjha3RZWmkKKspSo7aSutAu62bWfsm23cCS6KP64QD5eLE8xqsRzNda2EEDOo9HHrMC+eIHynEozPTXFDyjRBLtEGxHsN5oH5VG8CFQyZNQBhda91BgmmPXEyI6BlvZrrfu/UVGmnDFEcnIuixgHVp+izItm7JazQTfnXdQcqRHMTvY4ppUSfsfi4eGItmqbVRiBrxw126nPupOeZfKoCTI0GC16/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVi7I4JstooUzY8vLtDMgtxO71ejk1UGX9CpYpnrqZA=;
 b=krJ02j9CCkIpKFNQRNBeonh5WUHYN5I4stlnroNyqovHFZpZrFKuLq1xFAulr70f6DBSFFbS5A0+JqxtvcyHqoq98PBHYJSCEg/2ZmibQ8JI0JWaQhCSPmmeGATJ+C5ZfDav0bs4AlyC7MjV9a0gJZ1yGHyni7B5CjHkPR0HYZBBTqYhlRt3TvqjjyH1T0EOc7t619EFS11MDc8WNPU7zt/IIISMOK7nXlmYbWvSn6CnhNfksK8NhSllzDAkk62YnCPD8wqdBLpejV42n8+r7iUjqXw3S1JN1ltBeB/1RFmDZrPgBFkqi4kioiy3h8oPhAQGk5konJ1SuLXdAnE3oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:15:58 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 16:15:58 +0000
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
Subject: [PATCH v4 0/8] arm64: Add initial support for NXP S32N79 SoC
Date: Fri,  6 Mar 2026 17:15:47 +0100
Message-ID: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0147.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::14) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5852be0c-e6ae-48f8-f366-08de7b9ba6c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	oyEffVtpnM8WWLoLwqtNJS0+nwEYDIHevd9nhm1lurg6lK/zQ8l70IDFu4ADss9zOveEriXmlRuSzDIFezRGEGdUYay4CQVi8oXgv9WpVAns3QFLPJF1/5XTwqiAH+ZLFTW4tn3hWVtq5YNgGClecVZdkZj+SBldoJ0ZIKt+doDCEXGPMO2jwyIQK1i/Q079dslEZK9cKnr6h/3hyfOncZbyM49s8JgjDC9HBvsN9kuQe3xPhEgxViNaOrWQW4+WmrlVJvibdK6UlDdJzrFEpKAusTI994OPBvhH70mXsPZKhr2VjKiy4EkIh5Eb8MVL05Ls1Y6zoxHCvsYYWmB2X7AcYC0kI+KPyG0UKit3XogxxVdq+9uxUtaGSFpuvNeShPN5eu9ynJ0Gjs0ypvfrLvBMwNKNgzpIV5dss4c0l9eLHtyYG3pBykVdwboD3O+lHjqBHUyRguyO0vSIwjaU9NNc60v3RptRerzwpKBH8nU84ALB2OKI81bkX1udg2WtFGI7IEqgOfHi4Z7V0gFMjiE8JyReRWF7thD+cyBV/4haqlOTplVnvsZ4jh+zPMtry9eryMsuN7Jpzzl4uYyW3if2Nxy9BQaFDoXkAHW6ccp5Nqt7iBrlpoO7qcMjztfjmjkAvgxGWSCzHOIsGRdnILL2MhVX/AViZCnQOGzthYgl/ICZXKis8USL4tA+fxylMVOYi+n+9u9R9yucf2NbgNuROJt8W/JUfSlsUdKMnjLkC4gmAFqRp9gChmVEwPlKSK2SpCQp/oJ50aBZxZXW63DN03imSFcHda1S8xCLPbQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0M5UVVDK3pPakIrOGpubjl1c242K1cxTTdxdml4VzVMaUtHN040QUFvWTJJ?=
 =?utf-8?B?SU9IVXZpMHN3ZnUzUTVUQjdCM1RqcFBaQzJPSmQrR3o5V2xsRjk5Z1dCV1Br?=
 =?utf-8?B?UWNBQ3EzeEEvYXRuVjBTOGtYc3hhY2wyNUtCbFFRQ2FiWlJKRnpZeTdFS1Q4?=
 =?utf-8?B?RkFQZWpYb3BJYVE0bTRucmRlRjByZlZ5QTNaeFRCcGwxQndpQ0dVd0dtSU9p?=
 =?utf-8?B?V0pLb1k0SlpubWFCRWNTWDJpWWhxQmpzckVpTzl5bjdHOHByRHgzZDM2UFJR?=
 =?utf-8?B?TVMyaDRsd2ZqZCtzaFU0V0REMDdHOTdxZkZsUXpZcUhSOEhIQ1dMMVJrZGFD?=
 =?utf-8?B?bE81QTFBc2M5bHVqbk0rODdDd3ZzaU5CeVFLNDNRdllyT0FGbDl0NTljMVgr?=
 =?utf-8?B?bGdOVXRCa1FmSVhmYkdFdlkzYVpvVEU3QVkxcHlRUnVzaVk0Wm96Uk9TdVBP?=
 =?utf-8?B?dEQ1KyttaXIxRktrOE1kNk0wWXpjQ0dTOWtMMWpVTUFPMXI2KzRjTmYzMFhq?=
 =?utf-8?B?MnAvOUhxTFdCc1FtMVR2dkQwdUtXK1E5RWoxTEo3WjZhZlp1TFo2dEMzOUM5?=
 =?utf-8?B?dEdpblhMbFIrMkV2SjVBNno4ZE5OK3JVRVB1WFVpbFFUMndISTFYTjh0SkFF?=
 =?utf-8?B?Nlhad2M3WjRmQVNCTzJ2VEllbWxKSkovcmk3M2x5RFNKU25lM2JrNmZCR3R3?=
 =?utf-8?B?SnBwMWlVaFN2QjFtQUZ5K2VpWThOVDA1VDBNaWF5TWYwMWE3RCtacGVuNUpi?=
 =?utf-8?B?aGx3eVM4KzdMOE10dS90N0lzQ0liYzhOdEloUjNPVmE1bVgySFBjMXhQRVBW?=
 =?utf-8?B?ME84TklZWVVpeHhSM3ZSK25aNHZGMm83WlVSTTBMWmVvNmw5STRPMGd4czlT?=
 =?utf-8?B?eTRkdm1xclpscnNVRkdRSXloYkQ1Z0ovdkZvbFBWWVczSDJFQ1FWVlpaRjlF?=
 =?utf-8?B?VHBBTXF4VG9GTGJEMVVGbld6R21ubXJQNkU3Smw4Qi9BQjFuK0pWVld3aFh5?=
 =?utf-8?B?aDlVeXFERE56UlU5ZUNaaXBvZ1BxMDB0ZGplVmhZVGQ4Y1J0NnNIRk1LcENl?=
 =?utf-8?B?MFd4Qll6cWY3a3dIT1ZnTzdEbnJRYmdzMGZZbjNGWVpKQjl3N3JER0V5cW5J?=
 =?utf-8?B?SFplRmpqdjdoYy81RGh6T3BwNS9Vc1liKzR6RmRISXpITGE5MFg2Rk5Lb3pY?=
 =?utf-8?B?QW43eDU5Zmo0RC9rcTZ3bkhoaHVwZDZPdzF2TFpmYjB3c0NwbzRBSUVLQVdV?=
 =?utf-8?B?czVXb1hNRFVYaWhtQTFzY3RDbkV1cjEwZmZSSXhVdWwwVFMyM0JnSmdEVUhC?=
 =?utf-8?B?OVFaYWZwbE5Ud0hhYWR1VG1NS1p3TE9GQ2VwQm1WQ3NYeUhMQlFiQlRrbVBq?=
 =?utf-8?B?cU10SFFGK25vWHpRQ2dSdjhoZlRiOGkwRlJzdHRqR3M3bE5nRkxxWjVMNkRk?=
 =?utf-8?B?MUVaZ3dMTTJVRVgrTm42MTFxZm1TM3Q4Y2xwSFRkZHlmMkdPaGlFRUFadFNE?=
 =?utf-8?B?M2ZFN3IzclFZV1c4aWw5NzV6MGNLTGVkVmJma0RmZzFrYmhMUzRFdEY1OHNR?=
 =?utf-8?B?SndaRDVCZ25tZk9jd2YrMUhvT1lXSTFIYTNZUVRaR3dRUjZwOCtQWC8vV0c4?=
 =?utf-8?B?Lzk3L2FJcXVzZC9ucGJ1a3h6QmIrNzNYVjNRb2JiS1EvbUhUQVpiS0hkLzVy?=
 =?utf-8?B?N3h0ZjNpMThmZUN3NWpBc0x2NlI2OTljSzhDWEc4cEFJU2V4M1ltK1EzRXNZ?=
 =?utf-8?B?SWphekZ3MmNmdWZMdGlLOXVOTkpnTFVMc1ZlV2JxWFl5K1k5dWltTjQvdE1G?=
 =?utf-8?B?cVJtSU9DMDY3aGlMQ2c2RjNuMHo5RzNFcU1YMXU4WkZudHZzUDhwZU1OZk5s?=
 =?utf-8?B?VjdJd2thWXp0RjFmYk5OYjJKOGljM3lVbDVNdVV4STMydXRlc1UrTjkvTGdH?=
 =?utf-8?B?Uzk5T1VEa1hpZHNrL28walVQRWtteHlDQ2d3QXo5aVptcHRBY294RnhRVlo3?=
 =?utf-8?B?b1o4NzN4UnNIQUR5ZDZBMWE4UWY5K3IrMEVHQVNJR3NwYWg5dHZlckg4T3pQ?=
 =?utf-8?B?eTI0TTNGdVp0TmUxT2g4OWdSTlQ5WWx6SUpUeit0QnZuQ3dhbk4xM1I3djFR?=
 =?utf-8?B?d1Yvb00rM2Fic01iamxUdklxaXE4N3pXMTMvTmk2OFUxeEgzczVxY205SVBP?=
 =?utf-8?B?MU1oazFWaXBndEE0MHozOFNtOTAzbkpKVUlyVW04THNPOE93Uk95SWZyL2Rh?=
 =?utf-8?B?MmRFd2hmUmRxQVhCUkZOK2ZseVlSMnJjZU01dWNLODlZUk5jTUVxWHZoMTBu?=
 =?utf-8?B?SWZpclVoTHQ0VktVR0lZNHBlZkRVSGVmem92bUtvTWVqajJvc0ZoWERzbEE1?=
 =?utf-8?Q?kpHPw1FYqYPNiJJA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5852be0c-e6ae-48f8-f366-08de7b9ba6c6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:15:58.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9vKCtuaPJtlXVMz2+ldoQOwdpWsEB79X0krDww0b0fr6NN4ebr/GFC+EGxX2OtiOxMTyNgK3gm4sT9LJOBYgjbNVwbLX8OMeOzg4oLHbos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

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

