Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47253D331E;
	Mon,  9 Mar 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066876; cv=fail; b=lzkkNHfXreEwyExiqq0H/OZOtlq12dZZkIqKNaTjZtnuhAwcRTw1Xr0N1uRUoCMPitbCpR307Hk2vF6pqW2QoYgqfq0GSCEOXFATBfJkVyK9LgPhJLfd12yADeXYimZHgs2HCspgU5z5aQ87G43yvLPwHFNRWq4J94pojtVs3HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066876; c=relaxed/simple;
	bh=UvHka5wJXgV7+6Xa1KxxjTFfqzME9LZbQoaJ3La+pJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NpNB6KgaGGjJDyre3hzLVgI3RaCqxAG3gJvdssFHN1/KTuMhO4ijpzkhpj8e3xBL03Db7zzSAIv6XIClkfse2jKO7zFChADdtK58MgI92ryNrQUcbSxIqTeUpWWmByK4r4Jhyv2k+Q9ytSI9m8Ad9CkU1pLBM8jPthl7wDiiMHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HiAubG9A; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HiAubG9A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqqoC4LcGeWk84rN1Uyx9VVbHlGbxtqzhqUykicDMEHrEjU2YVSWjOiYClvsdIwYQ/R+/FG8sIMbRDDMe4wHuctqvxL0qqVGo9u6ZldXSvuuzJROdgIpTwsl+u3o56oFHydeUK6gGda5XIL25KdvFT8iNDoC6ha2sHNc88nf3XDrYb/KttjFjGR7870cvA76KBeGgP9t4mUzM1diqUdR7MvNnFtTuDz0xt2/Kxu12jTNYGoKwBI8I0c2DQEJ5FitEhW5YlCmYP1sQgFr2YT8GozSl3Yj/D/eY4Mx/6lWuUT35o9sHzZIT3/kAb2yKlpZs0GnZlPlrPZI1ksmDC/sLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ti97obELoSCGJ7y2W2BNMgA1v6NMfett3h8Bayh27fU=;
 b=Y9MlvToP3hrJ1N2xMrrFOm++stEbqsrwq9H1hhDoyyr+Ekt7nBKVbU6N/TX2ldBbRuGvzlirZCjYNm6JKsXIB2ysQyYdIQT+ipYTI1Yl+NmAlYUrgfOoWcei5AfklW0F2VxO0hppN03d4MXDTYe/T8Lioquq4MgFWHmg0HSwKqceyN/w18UdBZel/MBKF5h+sy2t5b5BsEx0CyjRNKC0KlaZy7xLkGEZlnRvfSf6j78muNCdx17G5mbnh1IWzyTntImpQlngbFbSpdVBJZdEhzra5cQ0NdfvWpsieLIBcDki14Mprot17wH8gUj2/ezQHqW6Q1+fxRy4CV/YPPUsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti97obELoSCGJ7y2W2BNMgA1v6NMfett3h8Bayh27fU=;
 b=HiAubG9Axsv1ZIvd1fEeVbdR9MrCA1iJFh2bTkRcNGh4SFSuIox8Ad8DtF8ajKTOyW6yPdkMQEQLIXdbhPuRQm3dFchEDTVdvacE/fMYKYXxUvQmFBg6cnoOrLVbdXEDaitA3730+1fUDIrN+VAvhGQAJlbuashTek88TGzArFqxWgGOD6sd8yXiAeocgIgDQV7jB+Vwgvs9KUoEOfVTcHGM1q0IMq0kB5OsLFaLpOpmBinLVybRcsY/9eNdBwvOJpwEaqPR/KKrC0l9GaqwICHUaRX2jdlaEULRVT+bdvikXczM4NnIGOWwx29qP2mlfa/H00l840iJf45rGoE+sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:34:22 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:34:18 +0000
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
Subject: [PATCH v5 6/7] arm64: dts: freescale: Add NXP S32N79 SoC support
Date: Mon,  9 Mar 2026 15:34:10 +0100
Message-ID: <20260309143411.8231-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
References: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f11d9e13-8aa5-44cd-2dd0-08de7de8f26e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	InFowtWGJJCTjKSJnsimFmKDRylmMDq0iSmjaMeWs2NtfNZ52Apgk+qY51S6dmEBRhiG+8PlFvHSNo1bRKK7iBCytiwhzJcXmlZyy9idD1QerrP+dMY1C3eKMCV9iVvzfk7Qki923mU3FzrFZW5dzwmf4PhTromlNc4Fsqd5HgkVF8NhCC6+KQAs2cmZsLjs3Gu8TLvINOPqW2+Tspj5XWULTD5WlSBQjOEKEhRhwAwpbXWob0VpaynInB9kv1enbLl9h/bG3o+CMs5d9639rDQ2Krvjq0Df65/nPuPcfY5+eJvvI+sGtClK/z/UZKJZa7S526krP91gw/Qb1ND6xf72P1JwfG8V+7A67TpdPtZVuDPfu96Cn84pT5Gz6HZCNUcs9DAMjFiZv94/+m2yWhw+WEfDb75K+lXd4IYHqJh38V7KZOuU7qoagqvlWKRr8j4fKguoiqid8SZZBA9fCEOqYsOCp1jOMAJeaKbVVpYpbRGTAKx4wbPy+xXFeUk05EbBdY1myu/hZMiQtA4isnDoyi2nga1F8m1x0ssUtrxumyd0Ax6JMxo8tWxwkUo1P0lxZhr2TMEae4iXGycKYK7hH6NsaU7os+IAiOrGaPENqmokXY/3Upct6fRZIMIS0flM5DJV1cDdUugCwXC6A1FFOuMZXoPcJHh8wYPLD6eTO648qfHhNbsa9+6VoM3FTKc2EuV4/lNkBRvjAAkl3Cg8Rp6zPzfhRbKT3eUN57UOyrOOKgSSIhTj8OE4s/ihLHcts8ygfiQzLJxTVQQAZElwhbvuTB9XOrczVXNQ/j0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkVqUFVCeFRnSWpnNGRSM3FxbkJQZ3dNejZpd1YydDJuWnBpcnd0NDBpUWZt?=
 =?utf-8?B?L0tncXB0cnduVHRKNWhCd3NaZ1grWnd6aU1xeWRUTVBMdStybkVXRW81bkph?=
 =?utf-8?B?cFg5WXZZOEc2OXNDMjBHYzlNcjVadDk1UStRMC9CbmtYM2Q0a0pUVWFSN2Zq?=
 =?utf-8?B?UTRiRDNHOERnMEVXbUNjSWRwTzRZYW5pQXlTVVdIU0owNU8zeXQzY1dIQlBq?=
 =?utf-8?B?WVI0T3FFM0VCQzh6WGY5U2Fsakl4bW5TQmxKZ0QzMkQrR25TdkhNdDVITjFi?=
 =?utf-8?B?M3AzQy9paFVWZDRyZzY4R2dKTlpaZlpPTWk4WVNkTDUrNDFSVUlLeW05R05H?=
 =?utf-8?B?NkRubnpJM2RaTjBWcVZpb2t4NFRSZXozQTBkSU1qSGNDZ1FVUlRDL3hzaU90?=
 =?utf-8?B?TTRGd3Uwd2JMcUJVN0dJTGpaSlpVcStkRktLVm5rbVFSTkpFYXhEZklhMjA4?=
 =?utf-8?B?aUFOUUhNamV5TENJV1hLR0N4cnBpd1BnQ1lxeDE1VGxpeEVROHkvR0ZCMk9l?=
 =?utf-8?B?bWZTNnd4b2NHRXNwZVI2TGpDb3hPS0RtdHlPbEZ5Y3p2YVh4cFVQQmFQYUsv?=
 =?utf-8?B?dC9Bci9MWjNSYlVFWjFCbVFGMEM4T3IrY2YyQWJOTU8vTnlablBaRmo1aDFp?=
 =?utf-8?B?TEdjdnBWUVNHWk5OR0YxbXhuc1Ivd055bEUzSE5uN2Z2enVaa2xUSXE4bSs2?=
 =?utf-8?B?LzBha0ZyWEcyNUFpcHNSYmkyWUxFWGRYREo2S2hPYit0dVdKdzZzTUU3RlZm?=
 =?utf-8?B?S0xzS3JCVzdRY2RrVDVCTTJ4RnFlTnJiM1BHdm5tS0o4VDN0cGI3SWc2anZB?=
 =?utf-8?B?ZEo5dFBwZWJ5c1JBZEE2WFRQZ0VDb21FZXYwVHVFQWVzOWJzMjZDVytmTHFh?=
 =?utf-8?B?S2hLWWtkSTZ6M0pVOXIyRVo4YnZvVUsrVERrVi9lMisrQWJuQW1hNFpDWk8z?=
 =?utf-8?B?L2NMS25ia2RWMURnNjlQbnJ0enlTMFFrRGlRQnRXeVhVQlN6YW5GZ295R05G?=
 =?utf-8?B?elljVFBLaUgySDBpN2p3OE5HSnhaYVlKVnpTUEpKZHJrQ2szQnV2U3RzcG9K?=
 =?utf-8?B?V0ZlRVJqazMxdEFZd3ZPaVJOSGxId2I3alBYV0pBd1Y5L0p0YUgwUkJXbjRG?=
 =?utf-8?B?QVFnTXU4TlBvRVRMRkxNZ3FIenZtSUlBTHNFL0FSMFc4Mm9leVRreDJiVG9h?=
 =?utf-8?B?ZEZqeTMrSVZDNnlodWlJS3lUT0tNQXorZktLMjZSdFhhaWppZmxidUtqN2ZM?=
 =?utf-8?B?bTZqZVdzMENYd3p3MFptdUtVNmNCTk5KbjJsVEZRTlowT0VCSWJhTEwyd0li?=
 =?utf-8?B?ZWllaTl0ZjFCRWt3bGJSdjEvMThkbVNYTk5od2hPVkY3Z2QrYmNQS1ZyWU1Y?=
 =?utf-8?B?MmM4TUc0QXNWUGRZbTd0Z213OUYzcFVybmpXMm1yVDJQbjBPV3psNmdxQ01U?=
 =?utf-8?B?QndMSEZoNDVic2FNUG5jYS9hTlpNK3Zmd2Vqcmh0V2RIbldveFRKbUZxM0xv?=
 =?utf-8?B?VFV4ZUxDVktFT2poa3BMZ2xYMEs3NkdDOVZjR1REcnJVSzNocFlSaE1LMkRG?=
 =?utf-8?B?Rit3cFFNaXBnNDNRbmM3c3BmeGs5dmZOYnJleEFmRUFmNjY1Y296K1JGYThO?=
 =?utf-8?B?bVFkeVhOaE5iT2EzbUhQbFJhanR4YU1FNVBMYjZGcitDdWExeDZiQllQNVBZ?=
 =?utf-8?B?OFZtRDdVQWRzU1RtS3c5QlM2RXBQZjI3ZlBPZlE1ZER2R1A4RTlxT21uS0h5?=
 =?utf-8?B?QUYyR2dJZ0FNaEx0ZTRkcjFBb2V5KzZheHN4YzhLenNLNTg4bXVJWnZGR2pK?=
 =?utf-8?B?TUxmUjNEMkswckxlbjBPTzY2bStkbDcvNlB4REpKNlZZWFNxcHM5aVJnWUdL?=
 =?utf-8?B?ZkpLQWRMM3QxWldTbjlnemh3QkxLYUxQUTJNYkdyZUo4T3haK2hEd3ZoYkR0?=
 =?utf-8?B?VEFzbWJvUnVCOTBCVkthbnBwQWVaQzRkYTFxK0JRQWQ4ZDNyU1ZBdk82T1FI?=
 =?utf-8?B?MXh5YTEweU5tdlhjbS8rTnZva3BtTFBuVVJ1dTFqcE8vNWE2Q2dyUmQ1SGgw?=
 =?utf-8?B?TjVST2d1Ny9xM0N4eEExR3BNWUkrdVVLL000ZG04OWZxQTcrUHpCUGt2U244?=
 =?utf-8?B?Q3Zjc2h4U0JVdjhjTnQwTmFWZFZmdFlTalhPSmJEL3R6MjlUZjhHeENmcDRY?=
 =?utf-8?B?Z090STRLMmR2bWhwd0JUMVFDMjVTOUFmS3BkYU1zVmE0QnpqcGcwd3JVTG9m?=
 =?utf-8?B?dGtYZ3Ruc2xDQVNzaGd2Y09lWEpBRE04NHJpSDdrVTU5Y0REaEUrNVhRWGxj?=
 =?utf-8?B?b0pEWmFGTk5NMGdueURUaVVEQW5oa2pSV0MzQmlHdTV4eGdIS0IvK1NSTHZY?=
 =?utf-8?Q?HfzN6/sRN7CyQbv0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11d9e13-8aa5-44cd-2dd0-08de7de8f26e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:34:18.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngXtKARhj+OdBadY4+XdHD3XGEyIaQNdOpawBl85/ChV/P37Ryh0a3Sv6CQLii6pMwI+hePrEsei3eUT8spBpZEdVnxSwONlUiXNc8bo2pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

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

