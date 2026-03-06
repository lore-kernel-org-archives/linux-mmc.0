Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5D3FB059;
	Fri,  6 Mar 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813781; cv=fail; b=CcfASKJAyOlw1vHqtiJKik+N+9+CuVXyxQAPnLoOWI5Mk7sPJdo/O7o9F9q3V3SfH0qSVB13Swkn6CMlZ5BO39pgKGhoiMEvlEnAQgDVWD/2akl9YQaC3e06bWC5ka0d+BUlpZ6KJYcPCdtVJ0JLWEqXrdVN5ZGPpdFjkVzE7a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813781; c=relaxed/simple;
	bh=srwFOP26/LhqQeGngdrZr+PQkMzumgbe6HCaVj3XMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/X5YH8R1k3OQcPrxD4qGmzmr8u+omIHLa6LROOFPvVn6VufZi02zCSOSogem1pBUnFTQf9cVVWhf1nwdv67TM8ssrbZ8B9+tBSFxah34ObzZsdfW5CjgTVYvm2a83DnWre7KDaqJIglWSpvwvZV+Hlzih8J5Ari4n9ijYrezMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xk4uemjf; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xk4uemjf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/0MmUSwX74NquaQBHR6C4AjEDmEg9BPCGGO2buez0ad2ULyI96Q/tUHDei4vLJudBTKiGEh1Vc+Jc9a4WSpjY9m5p9x+pSRxgX/I7FIu2N8pmTQH6GXD9BH5/3bNVxxpZg/jFpiqwufZLSe06hgfeSo0Fxi44Pn7FRnsJbUQdPz+N0Ld5TeeA52CiL+wuC7cRxBjhAR3jlgyproR6XdPx5s4RaW3MVbbq4hsvH/JwBT2dzet8vNalQCfue58j1KBEFRLL+nWrxsTDiJzlq8qASw8roUjfjswIUsxzXT1iuRDSTTZUL8zZMGbBaKXPvWgBbGROYkeb4baGvAPkOQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f6tJDxO+YDBxoQ2sgE9H0AbR9iXMTu4rMgME9tppII=;
 b=HB3y+vZlDUu7cipCmXa3+vLCIPJLb4TL01gB5GKNehoYS1DX7oSOCufETPHlnggzqL+QXgkCkOMUwslAisxe71qzePrTsv7ae7w2StXn3MDV6Gwn1A+fJk/yucmAXa8kK162yFDFVIiyU1zC5IOXk0JDK4c6tdUZBk0E+xrETXeb+F0rti59k+K9bomZOB2p2JFeqa94UwTQdegN0a4gQ6oj+7fT0aREdHdv8Lh0rW6l6lJMUZfkbP3nFQlTWAmeLYUnOf53TI6JK1NK0KVvvUinmQL+dVqDnR5wasNLamjsqc2gZme9ZlQN1ZAKlvLIZArls/yKtBHfelXh3p4nMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f6tJDxO+YDBxoQ2sgE9H0AbR9iXMTu4rMgME9tppII=;
 b=xk4uemjfhKtzIkL/9PfSjzQb2zjdB/VFmv9uG1PzvgIS5/Mb3RZ4uuioqpg3H3wgK7zdmQ7cjNah5pMA1/iyp9wpvJ779Aj2i1LCZI/RQZ1rCPAcAbCDQq2ijr6cJBjjSWYQZD1F5AReahzxuEVmTKrJ62mDW7H0wDHJc6dadsoR3CZFP/1FjwgsCOl9jluVRsqv/WUHXLn/ZjFxFBaVlOdrgiT/LGNi8OKkmFbLXZX4nTrpxgO2jNKTY0EkGtpyv1DrQlFsjwcwWL7ElIpQqADvUnST15rb/8eD56QnDuQ7bfEv57gAhW4hp9oB4k4fqM2SxXl/Wcvw66hmlkFA/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:16:10 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 16:16:10 +0000
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
	Andra-Teodora Ilie <andra.ilie@nxp.com>
Subject: [PATCH v4 8/8] arm64: dts: freescale: Add NXP S32N79-RDB board support
Date: Fri,  6 Mar 2026 17:15:55 +0100
Message-ID: <20260306161555.9000-9-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0146.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 46fdc6b8-aaf0-4101-e9a9-08de7b9bae27
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	0eXQLjcMSYnGDG9flLoN0fI4XjdldmuffsQhQLhstmHkxv0BtiT73icWroZUBQc8MlUo1zOPYm0QdW14SD1gOwkK/u7uKyJsrU35wi6HQRKE2cE7G1lqUxPB4CstRTFdJY89ktyzxS2Ko/d1PwIKIEtPHORX/PNxBYwuh4GwiR9sKDpcbAyy2r2MIHQzfLNhrdCnPp1GomJ7Z+FkpX+4BzHnFMjVb0Z7QNQLhPZMZMGsWi+3g78Z71oQNq4vl6Mp/CipyuAe7h/BecKvgGIpMkU7lKj/7d5FseBahLC6ARo42SwJ9XeIqwLFOL/6wQURCIkpqCpruGIjWaWJu+0+ynJnM07eVXfc450d5eSMof+8v4DGQVeRWO+qowVW275yDmb/NX0br2PQR4YxSj8Ww8wXSfZsnmfbI5cWDLzsA7XXFTscoTE+5sTHX0jlV87muJ2QFZEoEF9buo8W9GGoRhOtD7/OVcZdglkEaL0AxGQh1AWkU6sN1R/Ccng6sTf75Tc3K6AGr5/YudpHu15Br6QH2oUbmYJjjoyFh/0hR2S2wHWLxbJOLhcQIftgr4zIUN3qYC+3R8Lr9WwWTOLT01zF4Qc415CMfwNicHouzYKkXfYC4H9j8amqI6vGH/DNA/5O2xnMhSGduOpViBVH/VSRkKIsC7kaNrmboO9bqvjEUGC7nbhOR5lQK5yyhsFOxi9No1ise3epjTDD92ubFHC+E8k/wFNNAr2Ceiv/3NkUOc4VCRD82v3iexeU839fbNbsY5GlMDb1X70iXcBOJW7oibdB/NdmsQxbm+3Ohbw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRHVUs0aXZ0RzNHZ0ZQTHdzd2Iyek1nN2taMU9MdWMyakFEQzhydnI3bml1?=
 =?utf-8?B?VzdacEcra3B4LzRhSzNDUlVOUlV5QkRjb1REWjgxZExtc0llV3MvM1QyZU9h?=
 =?utf-8?B?SlBCMGpHcmtIdHdwdzFsSFo4OUJ1dWNOYy9IU08vanhHMEdaMlNEdVA4c3lK?=
 =?utf-8?B?MHhaK0YxUXhUZ1FCUUZTUTZZbzNFVm9xNURidHQ2VFRSNk1Ka2lMTVd6ZDZu?=
 =?utf-8?B?NTFOUmlMdUVzRVk2QWRENmNqbkd3ZE9nbUxDMHhrbVhoS1RWNjVvYTVacTdk?=
 =?utf-8?B?OWRpVHJaSnZDVThoUVJlT1VUam8rcmtSdjVTSjFKNnBkcVhSRVRGNUNUbFRM?=
 =?utf-8?B?WDN1WTlnNldrdyszNDFhTjJCKzVUTWdFdXVRa2ZLUHBmMVo1ZjRqenQyZWRW?=
 =?utf-8?B?MDkrb1cyclc1dkVWNXBtWTRLd3FpZ04yRFlLUlE2eWFkOVlXSFErTmFCME5v?=
 =?utf-8?B?ZVVXdFdTby81QlZEZVZwWXBSbEpaYmF0cDBwaEhjdUJ6a2xIOFJaOW1BSDh2?=
 =?utf-8?B?SngrTCs4N1YzUmtueW1hNjErU1VMN0Y4UkFvcEJ2SnlFcFFBdldqYTNrSEwz?=
 =?utf-8?B?NFFYb2Z1MlNibXcvelVGYzRsemRGN1JoNXZrcjY5WTlpaHJQaVRyYStOdzVC?=
 =?utf-8?B?RlR4RzVNNVJ1OGI4ZGhvWFZMUE5mZzNmQ3pIOFBHOUU4Mnp2dFdwdWdGMkNK?=
 =?utf-8?B?ZURMODd5cXRCWnVBY3FqcmJLS0cvWTB1d2pBd0pyYmtyb0xxNGZuVjg1ZjdP?=
 =?utf-8?B?cWh0Zm9pL3Vhb1hyeTdsTGNnM05SSzdYZCtYckVGbWFLeXpnVk1zUWErL3Jr?=
 =?utf-8?B?TWdSNFdBYjR3aDdaczl3NkVRVW13ZTZhdWYwelV3SERoM2ZBRmVIekVrMlhM?=
 =?utf-8?B?UXVyQ1UwRDNhNVRRSFdmYW5mUXJsU202TFZiSXpJWmZ2Tm12SjVZanprM3NT?=
 =?utf-8?B?Q1hBREw1Q2I1QjkxTlZZTU1NMjdDTjZtNlk1VE5XbENndUtHbHBnQ3A5Zmli?=
 =?utf-8?B?UVRYSmFYMEp3R0o2K20wY1RWWUY3TzF4VlowRmt1cDRWdyt4RlhwMTh1TVZv?=
 =?utf-8?B?aExpRm9KenhJTkFOUk5TWjJkVGIvY2JPRk9hUEpMTWJSQWFmMHZqMVBEQjNv?=
 =?utf-8?B?WUFwM0l1cWdrZGJXN2xGcFVPbUhEdVJPUU94N0U4UDdpUUtJT1c4TnNJQjl3?=
 =?utf-8?B?RDV5WUVKRW50NStjSlQzYXYrZGpzeDNTMCs4U1JkR1E5Z1h1TnUrSzJXaVcy?=
 =?utf-8?B?Qy9tSDJWek9tY2tqL1ZZeEhtU1JIblNIM2hIeFIxRDVUNmNRdFM3REhTb052?=
 =?utf-8?B?aHhJRjJBUDJOc016cGxQQ2tkNGd0Mi80NmRvNVlmNTBNNGwzdEgrQmtQVVFm?=
 =?utf-8?B?aFdmcjVqZTJHSjIzZlpOb1NRK1piYi96OHRzdmdMemNkYWNsNGkyc3FzSDBU?=
 =?utf-8?B?TnM3Mjhhejk1dkh3Q3ppTkJrMnhXa2IxTVh4TG4vZzhNTmJKd2JEWW9CVHZE?=
 =?utf-8?B?OUZYMmt3T01iTEoxMUtpYi96aDIxcGtCaDlYR1dtS2xVWGZJZ1VxcExadUNm?=
 =?utf-8?B?UElHbmpoVTRWSGN4UHR6ZjZpS2U5MUVRc1pZS0FPYVNpOGtQcHF3YjNkdUZq?=
 =?utf-8?B?WTJhOUlYb243eHNNdGRRdmxtRi9zV0ZDeURlUU8xWHlZNTJtZktjQ2o2czlq?=
 =?utf-8?B?U0RCSnpPOUE4dCtqbUp6UTVYNnVKOFg3dVA4aUNPbS82TDlEcmhyakFCcUQx?=
 =?utf-8?B?c0xnV1E5RnpwaDFJdFBhR05QRW5uTUxoSmNDNDBEZzNoUmhKT0NMRkd4dzBE?=
 =?utf-8?B?YUdqYVNBSTVLOWdVMi9aR3BYaXBEQXcxZ3I5bmFzNEF3SlgwYktHV25YQnF4?=
 =?utf-8?B?azBwSC9mRnhOWFVuNnJ2Z0U0Mkl5ZzgyYVdkN0hIZW5BeGQvSHhqTFkxNUNm?=
 =?utf-8?B?SnNZTlhpbmVORk95dHpGNWhMT3RNYWdySWRKNU4wNk8vN3Q4cmRncnNIYVky?=
 =?utf-8?B?dElwcVh5TG5iVldRWEFrM0loeGhpK3JXaWpzQTFwWG5QZWlDOC92TVFad2hD?=
 =?utf-8?B?b2R4eWN3OVlyZ21keEFBK2JtSjF4UG5ybnJXb3RRWDJidjhhTWdUUlY2YjlF?=
 =?utf-8?B?OURYcy8xVUYzR1AyMWlBWXJWZU5sekZSM2RIVzRyZEhBWGNnYnVtWFhQbXVo?=
 =?utf-8?B?ZnBQeEZ6WVdhSDlwZFpUeVpQUmVCaWZkdjF3U0k3Tzd5R3BQME9LRG9ucUFj?=
 =?utf-8?B?d2RsTXovNnRVNGZkcHNyL2luelU2ZVVsakxTRk82TXlMMTJzNUptREY1Y3kz?=
 =?utf-8?B?YVhZaXhuRU9BMlRiR2srNFZ6WWdmaFp1NTY1Z2JZTU9xekpUTStacGRUNG8z?=
 =?utf-8?Q?q6ybUZ2NZXQ6iM/I=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fdc6b8-aaf0-4101-e9a9-08de7b9bae27
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:16:10.7825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+N61NApmFtt7Sri7p2E0NgggwExsigKoPf3saLerhhQLKOyHSxgF0mEPUgmCXhzHxviE4G4/2+TrEgMyI5yTb285e86Ua8CHqaqVF0h44o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree support for the NXP S32N79 Reference Design Board
(RDB) [1].

The S32N79-RDB enables the following peripherals:
- PL011 UART controllers (uart0, uart5, uart6, uart7)
- uSDHC controller
- IRQ steering controller

The board has 32GB of DRAM memory with 28GB usable and 4GB reserved
for ECC logic.

[1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |  1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 70 ++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 700bab4d3e60..e79807bf1820 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -501,4 +501,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l-rs232-rs485.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
+dtb-$(CONFIG_ARCH_S32) += s32n79-rdb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
new file mode 100644
index 000000000000..1feccd61258e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * NXP S32N79 Reference Design Board (S32N79-RDB)
+ */
+
+/dts-v1/;
+#include "s32n79.dtsi"
+
+/ {
+	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
+	model = "NXP S32N79-RDB";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart5;
+		serial2 = &uart6;
+		serial3 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		scmi_shbuf: memory@93000000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x93000000 0x0 0x80>;
+			no-map;
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+			<0x88 0x00000000 0x03 0x40000000>,
+			<0xc0 0x00000000 0x03 0x40000000>;
+		device_type = "memory";
+	};
+};
+
+&irqsteer_coss {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart6 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&usdhc0 {
+	disable-wp;
+	no-sdio;
+	status = "okay";
+};
-- 
2.43.0

