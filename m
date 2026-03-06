Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225533EFD29;
	Fri,  6 Mar 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813776; cv=fail; b=IO8JvR+TeFFy2xiP6zShqQjWwRxNHEmP81woYBS+9I1o3KxXB7z6FZ+0ufKL+ayc5iDhEe2ETY01FzL7ymW0L0xR53uuHU6lUcIN+KbBEPCUM/o5XRRc/5pQn3ELCfhSCwnKf5j6lBc78bpzMAUVlYEgSFcXu0SO91KokENnKIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813776; c=relaxed/simple;
	bh=BNFGGBPM3NKXXTHWpurUJlv5loSpPHIYzbpPb2YTeqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VEgIkjUxwsG9Ns+Vy3uGDWCXQRA6nIn2egkqYZ9RgZQYj/RjuxkMQB29OKVysnmhbkdQpSRG2Q2h609P1WXkhO/p0W0beQ8bnx2pmZmzHUg2kfxq8XFnMdfbwGEZmR0P0rYeCfLuggOtEkoaJdXUgZ2CoIvwBINUUNRp5CPIOBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EKciw4Zg; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EKciw4Zg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8AZZBagiRgEHu0+ZCxMBUWEf9s4MVLc6rAgcE/sbGqN4Z4S6JAoVUsCjYS7b594SYLGHPjGEbPYZ4cjqiuAIkQwaPatYBrcxNi3L7RXJk3TAfsniPI0c6lC2dkjQYdw/DjDL4NqSvEWJNReL80oI1Z0GJwxNSZNPDtElgV0JYNLopmHUo+BLh+nWz1CkZTguk2Qz9HoR8kNV4Z+vVV9EnM3K26KrBvkqnpUUChKtKBror+r+jUDFO3W1+TERMYHyqYfYe92M6qbddWDFbR/6SJxrw88YXMvs4soQqmjqwVdMLFXpXazy4IsTbCmMVUBdFwDwFtGYBPK7eeoL5QUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhpopCPKvuwkj6FC9iA/wvM7/RzmN7Zdv6rgKnpBY0M=;
 b=ShM3bflFnus0j1afK7TMQskZ8GG4Gsw3v17i/vq9QVpaLBpqiHZXPAmqX5ybV4u2HpjxQE5W7kpi8iTrxjjA45jzpHR69k1Pd7P6VjjAiQoM5CExlUCUo/fWgEXErwyksO+lfRXBPfRvRfn21ocqepQvN995PcGn1fcnr2I7MkdydaEJMjFyI6QuozprQExcjm/5I9ohEWAS/qe+C+wKssPCfnRubxQ6La58YDPcI2wCm7Atj95RTcucLrm3vmeM4eEoyghaRcqcsZ5B/pRqzjDCHgCCC8f8vRsQFfoENu7zHsOF9ixLFiFmT1oMsN5gYQXck/TbQlgXQk5VTYRpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhpopCPKvuwkj6FC9iA/wvM7/RzmN7Zdv6rgKnpBY0M=;
 b=EKciw4ZgXdnEhUFLTx0E4uF0Mn8CcINtBxyEaINyWqCQ7o3pUNo31ag5AXEq9JiSAVbb5RRMBBF+qWn86jrCfe5sDQMrROHBys/6PAIe1KQrsqWz5dh1dWErLw+iIK7UOYXn8vg90o77/3Y68EdWDkEpXeDlBWYooWrJe/SpFmUrMhjG9U/TDKdarqFmVpns51yLwsFska27U2QRmRdqtgkKnLnpWqaBFM3qTzxQnT6oJlx89X9GVtdLhxSFqN/YtbX/C48PYUUibmjJM/IujfSjXbRGBgB3+frvXz36C25wnKC5iDa3eBl2Pigzbv0zypEV45K3IQByktSTPgWKfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:16:07 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 16:16:07 +0000
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
Subject: [PATCH v4 6/8] irqchip: add ARCH_S32 dependency to Kconfig
Date: Fri,  6 Mar 2026 17:15:53 +0100
Message-ID: <20260306161555.9000-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0168.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::35) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 81209f80-4ec7-4bb7-4ee0-08de7b9bac4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	AZBq3XT0G0JN5DdyzmfEnERplk7HSYJWACXdC+0kZjL2lW0ogEYVxs2Tpm1c2chyff33ZMp2s7dZ/A6JzWUxPvIzLAejf8Idv0rdzC4a49gvsDHHjMmpdVCeJtpkMcZFWY2CU/efOJCuTwEEoq+96Ekfds024WgryEb+0HwY3y/bmPz1Rw0rDmgGvdtyGwmgmDg2zB97FkiYzC2VBtHbj42ippkWRz+CdZ49tkjx24nDthbARPDPez3nD9YBdKI0ldz23bzKeQyjW4sXVL796/ao2IO+RodAZxgY2DyjDUBi+oOMEhPLLQwUvOuSdRf7tGuFZ+LLMS5MaCXUODENVNtZNW6zN9h6RkkUQ7lvb9ZSYflJxVzmikNBVZHMzN+BTHYEIEQQnh4ZzeHPSuXTpCq+zA5hW8tZZR31pVMQZm0I4Cu11K9SIfG4OuecOcgkkDUTM59GICEuMv5gVyYgES5sDFFT6F0n8R6zGrirVIcRWOQ1f5qa7abd4/8/GzaS8+uZf+DNeMWl+aHpMasagH1w/lTenJL4GWlyAiH4drLkgqflSZgTAWb2DeC4LD6mkdceauhRRIU/pWPJXHC6JlyYPOjkuFS28hqWdzCULmi3+hT4InAR5J8Ip3iT308/jKDi1uNCk0D+DltvnfpX/2irevzgMxjv5kwkH8QagAYYcP6+ONqwu+RHRTUbaSW/YNoDBOpHZurdDDlBVQ3F3I3gzO8ftv4rkR5El47h6LoU8SDrKs/FgdBWN3IwPqVUdQHP+MDnL+OrYKBpCwcC5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhkT3NqaFF3bDdGUWs0eTJrMlE4a1VCVGViMDhhcTF4TEhHd0dsT3Z6OG95?=
 =?utf-8?B?L29vQXIwL1JWaGRVNEZNcFZUdFpXSU0xa3hBdEV3bHhMMmNHazE3eXFldmpM?=
 =?utf-8?B?ZlZqci9ZY2dFanBwQ28rT1p6MmpSUmwySmFYZHlWSFlrd0FUQTBMcFYzbHFK?=
 =?utf-8?B?OUQ2Y01Ydkl1VHo1cTNyZW5LTW9qSkdIVFhNenFlT01zS1lyYzJyUEVQM1Rz?=
 =?utf-8?B?K2ZtV2tBRVdzejRTU0hPb1NvaUNlNXRtZEV3VUMwWmZTb1U2bEd5QVN2NXA3?=
 =?utf-8?B?L1NZelhwYVQzQ2MyZldGNE9UTVZMLzVpdXVoNThYay92SG9QeDQ1N1FUOG5L?=
 =?utf-8?B?akZSRU5ja2VZTUl2NzljT2o2VWtzZ1NRY2FRQ2Mwd2g4bDVjQWU0VzdFSS9I?=
 =?utf-8?B?SDJQb1NrSStPR2ZXKzV4L1RvOHJJS2drdUVkNkpDNVlBNmtQY1FGUjBLV1A2?=
 =?utf-8?B?aDEwMmp1aWRtM1RvNGdFRHVTSWFvcE1qbng1N0VhY2luMXp3V0QrVTRxOHZP?=
 =?utf-8?B?Q0lnSzhHb3E2YVR3WkE3cXNIeStsZ2w4WHVlYVAvSUZFZkxzdW9JZldXb2Vv?=
 =?utf-8?B?L1N5eHV5ODBrcENhTkZ3aHZ5N3ZyTDdrTW5kQ1hzQ1doL2RMN01ZUjZKRjYv?=
 =?utf-8?B?RXFDMzJXbGlFQ0VYcDRCSjR1Q3hqbFRTdm16SW1qcFVMUWdBZEIvdEIwQVpO?=
 =?utf-8?B?NFQvMWZITVlkZEordFBXWjZIb3lmMGR3cGFFWGEwVGFKR0lZck5oUGpGcjkz?=
 =?utf-8?B?VG1CZ1h5SG1FM3VDcndGU245ekdrR2t1T1p4RDRVZmt2dEJNVkgzRTM4dlMz?=
 =?utf-8?B?OUs2L1J1dzFGRWFPZWFhb2phOENQdXdwRlV6UE5rVVRUZVdrK2IrYlR3MjY1?=
 =?utf-8?B?SDQxMFNhRVZZL0VGNSszNEN5NThrUnZKcjJzdFB6OFB6azdzeWNFWEs4cndl?=
 =?utf-8?B?L2RSZjEyeHdXTS9ac09JYkF1SEhsbXlzdjk3L3Z3cnFtV1pxalprMnZXTHVQ?=
 =?utf-8?B?OU1SeFhmYXZKeENNZXF2b1laek1LbkJkb2tGZHBML29IVWNwQWZtMENXeDVs?=
 =?utf-8?B?allSQk1mVElhSFNZMmVURzJ3eFdwUkFob1BTQU1aaVVWYUJwMkdTWS91ZzRx?=
 =?utf-8?B?TzhJWkNZZzhuNUt4SzBJazBMZDBDUnBPVGZJT21NbmIvSnRra1RXT25lbjRE?=
 =?utf-8?B?YmQ3UGlybkg5elAzdVhpRkM1aDRqcVQ4ODlsNThsOTZycDQrbE9kd2IzWnhB?=
 =?utf-8?B?Y2FRcUdaL1dyVmEzV3l0Rm0wVUdiSW9wcGZsMGpvaTZuNVRua3o5QmsvY0Q3?=
 =?utf-8?B?ZEttM3BSMERvblQ4TEEzVFUzR2FhVVRUYTF5Rk93LytPSms0MzVhbXd3TVBj?=
 =?utf-8?B?SVpXdHVaRUZNTzQvVEx0OTJZVUp5blVDM3J3UXIvcms4cGYvUFdLUk5ldFhk?=
 =?utf-8?B?b0RzbjQxMTY3MjRlSFNIZUFDV05zTll4QmRxQ0hrVGJyU2Zrb21Nb1BMeE15?=
 =?utf-8?B?TXppb2pNekpycjR4VVhZYUtBTGt5UVNEdlJxTTJ0ZXhYdThHYVRDTmR1QzZn?=
 =?utf-8?B?UzZvS25KQVdjZkJnQjVtZU5OaVQ4WHdXSDY5MjhUUnlOZi9HYmZkL3p0SkRB?=
 =?utf-8?B?d0tjc2loY25HTmc4UktnUUIyV2t1cGNYUEs0YzNwc0dHOVZGajdKQUFpVnFt?=
 =?utf-8?B?RGlCMGFqcjlDcVFxWHM4ZExxc05WMU0vSHdINlhjTldLNUtmK2hySU1aWHpI?=
 =?utf-8?B?MzA3N3RVVHkzRkRGMm44WDFxZlJ4Zk5VMnNuRG4vZEhpYVlwVXFBekRXYWtY?=
 =?utf-8?B?TFg2aHg4ZG9GVURhbHdZVEhITzdSQXpTSXZjZzBSOEd0ekNUbllVSWNGUlRz?=
 =?utf-8?B?NVFyV2VPU0FEYlI5bkFIcGYwVS8xUFQ1RW15bmJMRDRpbFpYczJWV2tLYnlG?=
 =?utf-8?B?L281WW4wMGgrc0h2NWVEN3ZQbkpWV0ZCMERvOTljM29JT2Z4elRCajk2Nk1T?=
 =?utf-8?B?MGZucktzOTVLb09yVnpKK1RUamMzTitNaEJheGsvcTdvbXZlYS9EOWhKQjll?=
 =?utf-8?B?cGFVeE03VEwyYWkvN3pzb2ZOTTVTQ0M0VXZHT3NtOXo0Mlo3S2szcHBuK0M2?=
 =?utf-8?B?SzVDNHp0c0ZTdzBmKzZFOVpyWWZSQmRvUXRoMHRienlrQSs5Z1dwUHFDb0RY?=
 =?utf-8?B?b3JaVWxXenI2c2t5ZkxadlNZdk1tOHNuVEJvbHQvODdJVkdXYjZXTUxiRTQx?=
 =?utf-8?B?cUc5cHJ4cExDdmRFU2RaWmV2Tm40TkdFYWZUUm1ySHhVQ21JSkl6WVo4MllY?=
 =?utf-8?B?VnBvS0ZuWkFxRzlFaDdOcDVDT0NMaXM3bUxYSlFhTStrMkh4b1VEZDNPRHpG?=
 =?utf-8?Q?cucKi9jv1CqfulKk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81209f80-4ec7-4bb7-4ee0-08de7b9bac4e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:16:07.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JG928vy0XaCfrGXBQhiSHaBOwjRKzAJglmlgdEkcfxPijI8LBkYYpvYq1/HRNw4relNYH8+by+4YnafqXgEnMBfWRiCEUzFtDXZcvWe28SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

IMX_IRQSTEER is also used on ARCH_S32, but only requires ARCH_MXC. This
can result in unmet dependencies when compiling strictly for ARCH_S32.
Resolve this by adding ARCH_S32 in the driver's dependencies as an
alternative.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/irqchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f07b00d7fef9..ad32a084afba 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -541,11 +541,11 @@ config CSKY_APB_INTC
 
 config IMX_IRQSTEER
 	bool "i.MX IRQSTEER support"
-	depends on ARCH_MXC || COMPILE_TEST
-	default ARCH_MXC
+	depends on ARCH_MXC || ARCH_S32 || COMPILE_TEST
+	default y if ARCH_MXC || ARCH_S32
 	select IRQ_DOMAIN
 	help
-	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
+	  Support for the i.MX and S32 IRQSTEER interrupt multiplexer/remapper.
 
 config IMX_INTMUX
 	bool "i.MX INTMUX support" if COMPILE_TEST
-- 
2.43.0

