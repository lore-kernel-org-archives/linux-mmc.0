Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57653F0765;
	Fri,  6 Mar 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813779; cv=fail; b=UlEVX6AVmTJjBlXGPfWqwF1iaGspLbutjrJCyQfebsq1ZtquWViEeE7ln+yFK+Fclu1k38Kz42U1N2v53XUV7tzDAH7f5qjtL7+9XoA5zXmKsblA2AUd6eLJEvPf1yXyqsR/8rz/vPFurcmrgYqyTxGQyGedCYQ+94Y6oYZ3SeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813779; c=relaxed/simple;
	bh=UvHka5wJXgV7+6Xa1KxxjTFfqzME9LZbQoaJ3La+pJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jF8UnW5CeINdOoxp3Qlb1vqtMQgZR0NeVZzSFdGQYQ5JDH4bax1Bnyw1mVJULjgtDMhVOmsKGy4z5vVlnYRNSZQVF2Ta9DK4TqR5HbHlolqTHOlqJRpDCXK4LYeDeW+rMg68ipjOn/Pw7fgi12wH/1JZzZsbP4GvFAU+g6rHkCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YJKr4WGE; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YJKr4WGE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO2cTqALhFDBBTi0aX5lR0G94gatTA/pouK/F/TfBeqKiQvcx/i429KEWLIxcfaHOgfTwEzeuQeohReJEqL8lcgt6mQqUs4nL27t2d0sxZC6gqDqUgNIHAxyXAjVp+MnXNElrQhLU7JigcqeLDAyu8FiM5MeymTyzTdg2Fjxq6R59L4ujJi0vd8g0cRyX+XzJABLUQHDVCLDLq+gii3/ujd2AJj6+8Pt+yalB1rTPLARkhqeWC2/U0LKDaOKc3ufjGsmcxYHnaG7gC44riX44hf5UecP0Gr0bj6DRmGz1EkFM4uhhGdbWJUKOLNKom7vsnAppmeJwcUenQNV7gCuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ti97obELoSCGJ7y2W2BNMgA1v6NMfett3h8Bayh27fU=;
 b=Z4pwtp3aobQAqAipdsWWS++faDo3zihaVTjYN+vnzf/1q6e1jSKjEYjG2lUqgSVygLVWm9Vy3D9C5IuZaDW1ZZN0cDtDZZ/q51u2y2Dr8M9c2SUs0ncdW9eLc2XMD4T2g2+RlrgEmiz1eAM6r9wPz0IbFNrD2YNyij6pmwFAUVtUB+ARiRnlYhQUnteUXlArsnMIEtBwjPYI5s+dgcwDOOu4/xbUeF7kC+KPWXvTX3T8OSp01vpn2Japn3tRUxc/WmYdm+4o8BkDHyOM/1MUJ3hMpDqocxHJAGTanmQbvuKKfJWG1pnGP1KcjK3s265xUahuWbBGL0uInrzQwuXxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti97obELoSCGJ7y2W2BNMgA1v6NMfett3h8Bayh27fU=;
 b=YJKr4WGENFM16EDMY1c9GwU2nzzZ48kCIwSCiPHATiLTZplGL89nQ3T/C4b6x3nA0YPHVdjO85hqj1ScfBQA07XLaqcryG59uiPjB43CPv8Il1Xk3/v+dZoogNeFchS7M4LZZ8xIdd0E4fpBGDPXLIEJMNofRgnXP70EwW7cfHhC2eE1F+C1DEsDr1qORGNZ3l6i5FlNVrKdMGCsJ8gHvB9i0Nbd0xkqKjV0YTIQh5G77vQ24jlgbeoFEbcGI3Ui7U741z2RrW5+sBDWsMeodrtwueEe3nHd0hRha/XowtyxYmHm8dqLyGBAMiFYHIC/QZ9X8fLUdr5eiXMVl+R5CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:16:09 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 16:16:09 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Andrei Cherechesu <andrei.cherechesu@nxp.com>
Subject: [PATCH v4 7/8] arm64: dts: freescale: Add NXP S32N79 SoC support
Date: Fri,  6 Mar 2026 17:15:54 +0100
Message-ID: <20260306161555.9000-8-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0155.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::22) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9bad1655-e3cf-4a11-5e2d-08de7b9bad4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	2ueXrLwEcllJExlEsQlNVQ0+4EDJBcuj23h0yyJGkn1wYDkm28fKS6TO7Nh59okmx26uW+ehnnept7FsH/qdrWhxesAY13ejlfqp3hLIMQON+B1Ma+3k/YGJBx8cCLkoO615+l3brifL3SveCJH+6HlHYIlOBgorIRsgbMqjENS/Eo1lCUw179ipGX2HtVlGTcsljDdqig4A1SezgQ6nJZTnWlmxLPMoxf7HNwdVslj5ofmAdOUywMUNTe9yW11DbdFOiTBo1oeHtqwOyNqmOv1sjfJkCNkdqU8wm4rmPREOmiL+MWX2g0A7r7ZZW1jXJHsMUFRscAVs1AtBDeVU7ihDDNo35MvpQjPNieHErQJbngUsABKHPGDpJIHlp8MQOiqQfjTCt3gNJvbB3u7KC+4XYP+VEJMRds9nOcNfiVUgNH8deO+zicXZAR9OZe6N7LUISOCvUwWWaFFpDhfCRNlTMtdKHTCTIp6F980Wk7qW2YGRACXoPbq7s/xY+u2G2/sw7ssVmBQ5SG8F3XtHLu6gzfcXxm1tGqoIIbD5HegVxsVbJ9jVvl5V0Lj83wGuRaUR1sLPt5c76MGBoBJ2rkacSbsTrH8mAOORySTh1FJD9naMdxuac4Kc8rTMwzvnXqNIKBDcF7jZbcghaVzxSWnP90/jJpIjhPJrp7yLhiedNnGMwOH2ZweVObkwHxYsMoAXtMmEfdwF+z7y0PvdO8FNWOuVJfOa115bYkfpJWKYiOOZVrzj9EuMkc/S/6OaWGCD3zbNoLRNwhTmcUA0+eOw2sc6B9cvXW1yKIyEDZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1BtSTRkdFRqaXgzdit1bStNTUxaWE9PMzdiNlAxMm4xVTBxVUVqczBSNG92?=
 =?utf-8?B?ZXRWb3lEMGJuak9OaTBLSENqZlcxNmU2K0pSMThoM29FVlNWTFI4SVBCYUZ6?=
 =?utf-8?B?RDRqbG5RZXFLOVNyb2kvUENFSSs4dGw3QXdvNURMTnl5ZUVpS3ZsSmQrSHJt?=
 =?utf-8?B?L0JTTlFCYXIyOS9RbFBnTG8zRzhWaVg1QzNxZ0F6VjVUV3B2VExmSGYvZUVV?=
 =?utf-8?B?MklsVUtnOUt5MEcxYVV1VFNVMVNVNG5SN1RQVnkvekE0c1AzREIrd2Rjc2FH?=
 =?utf-8?B?aHM2OFNVd2ZFR3pnTHhJNlUxTEhQYi82S0QraU1NSWxkdFQ4NHp4bU5RWjJD?=
 =?utf-8?B?UStlTUNodTVydytpSDlvU24zUEV3VmJJd2c2QWdlNW9uckxaWGxBYm80azhR?=
 =?utf-8?B?NnpzeTlpRWhBT2t2czM0NVMyTkg0dmxFRmZJS0VmdGNGa0Q1Ymt4cjJ1NzAv?=
 =?utf-8?B?NzQxbE05OFgyMGVQNnNkOEhDdjY4NXdCQU1paTNmQ2J1bzBLSlFjajl6Ri9r?=
 =?utf-8?B?VGo0VUNzYlUwYmlsMW5qYmV0Q2Z6N0l1bEcrVnN3cDNTajFUTTlsRHQ0TWJF?=
 =?utf-8?B?SkM5RUtEUS82QVByTk9xNGoyeTk2a3FDajg5TnZvVlN0V0Q4ZFZpdXhVZDVh?=
 =?utf-8?B?aVBNeFl0WExSaDc1L2EyRjhtTVRKVk85RWVEc1BBcCtYbEhqYnY1alAwcEw3?=
 =?utf-8?B?d29VbVQ2Rm5tTWZqTzZYdUhTZkZLbFEzK2R3YjIxbmNRSkw2Rmw3MWZsc05o?=
 =?utf-8?B?UHlhdGdxd0dLTVFMWnkxaUErWTRDczBLTlJUeUhlWkpHbU5DQ0VncG1pWlVq?=
 =?utf-8?B?ZnpPd3dONENzN0FPVjlDUjcyWmg0V2hPVmVnOS81T1RDMmdOcEoybi9kYzdK?=
 =?utf-8?B?MzM4MkZpUjRUb2FlZERmanNCWDdNbTFJRGRtRERzM1lwUlNRc0FNZGtHSVo0?=
 =?utf-8?B?MlZLSVdkakJXSzRoMi80S1M5VlZZRkFIbUdtTjQ5SkZkNGhKYWJsRUp3b2NP?=
 =?utf-8?B?Z3RwUDlVV3VSbFBkcnY4U0t4R1VvRlRoK01pdE5zd05seEVTYmQrbWVFR1dY?=
 =?utf-8?B?aE90MzhWRHV5bGpyencrMHRiaTFYV29ROGtlVHk2UCtabTVoem8zOGxtL2w4?=
 =?utf-8?B?S3owNndXSmVUeTFJcnNFTUs5NFY1ZkY5UFZwVEphYUlyWGtLTmV6UnZVK0Nj?=
 =?utf-8?B?MDl6YVpFNDVaSUZIS0cySkxuWDFQRGJ6aGhKYzV1SmR1V2pJVUt4M3JwY0pH?=
 =?utf-8?B?VXgyR0h0bm95SmV2UEQwQWVtZzlwSzFoYWY1SjN5VlZaOXlFUFcvcDFXWW81?=
 =?utf-8?B?dGNtU0xkaFZHcFNGNjJCL2RFbTNtSEE0TkxUZmpDZ1lNR05WRzd2Zi9ZeGl5?=
 =?utf-8?B?dW9PL0Qrek40WXplaVhWSEFoenhVbTBsZGw4QnJZS0EwRy9paGFvdVJNMW4x?=
 =?utf-8?B?bHEwTEFNY1ZpRkRLcUFsZkRvWGRlbEowREJOT000cmtPdGh0dzd4Wmg1SEVG?=
 =?utf-8?B?WHp2WXpTVCtsMDFORFBEYXBtYVZzZG44R09kbTd0RHBvU2ZSK2VkYTZIU1F2?=
 =?utf-8?B?dkltNnduYW1SQlFZZHQyUFFNUDZhQndGT2laOVVGRFMrQmZGOWpnWHRSaEtS?=
 =?utf-8?B?SklRR3QzTFNuQnI3a0w5SVp1bGhQRy9teFdsak43V1dRUmYvTmR6WlRYRFpz?=
 =?utf-8?B?VXRCWEtyczNWSEZIa2ZwenFLSEJMQ0FEUysvb2tXNkxyUHl0NVg3R1RIUm13?=
 =?utf-8?B?OXpOeS9lTUc3YlRaTmxDK0RiTG0rV0xVOU80OG9QSTlLbENFQ0lqSXAxS2lj?=
 =?utf-8?B?QmNNY3BacEdYQXZRcUJuSUFTV0M0S0hGUnpTYm0wblZsS2E4L2N5OWlqTkh6?=
 =?utf-8?B?SHRJRHFvdnFNbklhdkErSWZpVVNia1BxM2lkL1Juc2ZzdTBwVDhXaVU0azZ6?=
 =?utf-8?B?bzRLekxmR2M5NWxlenY4NEgxbUpsLzAwakZXRmJhUjBSMTI4L2wyaHBiK284?=
 =?utf-8?B?c0FqSlBiNFBhdXVpRUJCOUhFVmU3WHRqUWhXUFNNelhJYjRPSnRBaHU4M1p5?=
 =?utf-8?B?bXRSMjhRa2tITy9JemJCSnRWS3QrNVBtYkgzZlpWUmx1WlZCUWZOcENtWFBa?=
 =?utf-8?B?SjRQUlYrUlY4ME1xeTBxSU9kN3UrMjJTdGpXcWNBcml1dXp2b3BJYjVvRmZa?=
 =?utf-8?B?ZFpiR0xVM2xsZ1hPRnhOUGtRcTMrQmVoQUlldXZGNDFRaTFBb3V1M0Z0WnZh?=
 =?utf-8?B?elhXN0pjT0JqY243aG1ua253STJpdkxrV2FMSW5Fb29oNDlKSDdpWmYwdmV6?=
 =?utf-8?B?UlJ1YVhXcWxkZzJMcVhRNTBaanFNWWVIODJGdStHMHlsY3NUZzFoR3I0clJW?=
 =?utf-8?Q?nqN/SinBglxJdIak=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bad1655-e3cf-4a11-5e2d-08de7b9bad4b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:16:09.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHBVifBTN6qWTDvXqUS8T+XAG0dGXfX8KlmYbdSxAugujVdYCfJdtUWmHpNgqpkcw71VdyXRlPs7MNEubDEqwc1fyXvtyXlv4yWO0qh+LpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree support for the NXP S32N79 automotive SoC [1].

The S32N79 features eight Arm Cortex-A78AE cores organized in four
dual-core clusters, with a three-level cache hierarchy (L1/L2 per core,
L3 per dual-core cluster) and 32GB of DRAM memory. It includes an SMMUv3
for IOMMU functionality.

On S32N79 SoC, peripherals are organized into subsystems, such as:
- CIS (Coherent Interconnect Subsystem)
- COSS (Connectivity Subsystem)
- FSS (Foundation Subsystem)

This initial support includes basic peripherals:
- GICv3, SMMUv3 from CIS Subsystem
- PL011 UARTs and IRQ steering controller from COSS Subsystem
- uSDHC from FSS Subsystem

Clock and Pin multiplexing settings for the chip are managed over SCMI.

[1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
Signed-off-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 362 ++++++++++++++++++++++
 1 file changed, 362 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
new file mode 100644
index 000000000000..94ab58783fdc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP S32N79 SoC
+ *
+ * Copyright 2026 NXP
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cis-bus {
+		compatible = "simple-bus";
+		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		gic: interrupt-controller@4f200000 {
+			compatible = "arm,gic-v3";
+			reg = <0x4f200000 0x10000>, /* GIC Dist */
+			      <0x4f260000 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* GICR (RD_base + SGI_base) */
+			ranges;
+
+			its: msi-controller@4f240000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x4f240000 0x20000>;
+				#msi-cells = <1>;
+				msi-controller;
+			};
+		};
+
+		smmu: iommu@4fc00000 {
+			compatible = "arm,smmu-v3";
+			reg = <0x4fc00000 0x200000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+			#iommu-cells = <1>;
+			dma-coherent;
+			status = "disabled";
+		};
+	};
+
+	coss-bus {
+		compatible = "simple-bus";
+		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
+			 <0x4e000000 0x0 0x4e000000 0x1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		uart0: serial@4a030000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4a030000 0x1000>;
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <264>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart5: serial@4a060000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4a060000 0x1000>;
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <269>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart6: serial@4aa30000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4aa30000 0x1000>;
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <270>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart7: serial@4aa40000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4aa40000 0x1000>;
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <271>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		irqsteer_coss: interrupt-controller@4ed00000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x4ed00000 0x10000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x9a>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+
+				core1 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+			};
+
+			cluster3 {
+				core0 {
+					cpu = <&cpu6>;
+				};
+
+				core1 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+			next-level-cache = <&l3_0>;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+			next-level-cache = <&l3_1>;
+		};
+
+		l2_2: l2-cache2 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+			next-level-cache = <&l3_2>;
+		};
+
+		l2_3: l2-cache3 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+			next-level-cache = <&l3_3>;
+		};
+
+		l3_0: l3-cache0 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		l3_1: l3-cache1 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		l3_2: l3-cache2 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		l3_3: l3-cache3 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu2: cpu@10000 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x10000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu3: cpu@10100 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x10100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu4: cpu@20000 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x20000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu5: cpu@20100 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x20100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu6: cpu@30000 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x30000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+		};
+
+		cpu7: cpu@30100 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x30100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+		};
+	};
+
+	firmware {
+		psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+
+		scmi: scmi {
+			compatible = "arm,scmi-smc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			shmem = <&scmi_shbuf>;
+			arm,smc-id = <0xc20000fe>;
+			status = "okay";
+
+			clks: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+
+	fss-bus {
+		compatible = "simple-bus";
+		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		usdhc0: mmc@5b490000 {
+			compatible = "nxp,s32n79-usdhc";
+			reg = <0x5b490000 0x1000>;
+			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x58>, <&clks 0x50>, <&clks 0x5f>;
+			clock-names = "ipg", "ahb", "per";
+			bus-width = <8>;
+			status = "disabled";
+		};
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
-- 
2.43.0

