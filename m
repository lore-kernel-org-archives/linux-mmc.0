Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EC3D1CA2;
	Wed, 25 Feb 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026762; cv=fail; b=a7KGVaREuYRjSHs+vnVESKv2AGsQl/8LVDBDVK59wRjyk468sR6IWQMrtCJrVxdwDef2BhsVLqDWfDKs9aBpYSVeR+tGm8KpjxwBS/nDNyEBQFrUp1vLPS9Cp0YEZYWHg+U/c+1/oOuV1rt2Ywk5vwt91oSmj5wcJmsHxEtG93c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026762; c=relaxed/simple;
	bh=kNosUMJ7Q9Fd4AM9znZbrGrSwpsSf/UG82QuzhDL7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=As5uQanKD2wtOXuQHSeeZiDepgJkiz2pcabIOWhmP96AxH6V8fJk+DmGkgzCQDYiu+Yhi38zkp0z4LijYA0oj8UkgSq2GTnvoFoKi3jm+mQHPT3QC2l/VFF+dP/rsPWF9MW7QTkTA2Me8wdTrgnYs5114ShA1tQczurR6P62nV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KdcBtpES; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KdcBtpES"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jz23bnEQLtjm/THqhnH4n2DKuAMueaAN5+TfO3vYABB6SYYblguCMoUL2PMKmgNn7/DSle3OEByUC95XWk+NWPgIBf9sZ3oPEkLf6Na+5JzSnySg+rggxQyMjnNQsAv/JcVhNFDrxKP2P8nA1kEhic6pM5hYcGlK4bnpqFTem8MNinsgWE838Jt/tgdzgL1aWFM5XO9dLIAPHwRBkDk3AFFKCh+de+UoKhCavHAP4ga/WPkx7sj8unWq6LbusZKA+Hv+KbiMBYMXh9w9S5q3YTZahKJvuq/b0zgLc+/RupII0s7doac3MX1ajOZESl8v0B5ocorE4SHJ5RbfwxEb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnYqCUntM/NX1ErrsJ9YH3zVBd+3l/01MTP4+SFTKvA=;
 b=E5n57cCI2TOLaqiGJz/JDpdpNrKBP1VDk6gi2aAu78UuJ7u1ceR/gQjsXgayEavU6OPTvR0m5v/BTHHlAWeCgQ1lj4wo5mdE5PTVLgWkNGhXmucrmnsaQumiLNBwgOmmjF6O3Bdhgd7kEGikdr4XYD8RDxCqGBAtopztaydpEpk7Pn5utu0yI4qQQrp6WfpCnDlfRtE03ohOYr+N55+wU1/7YfWlMjLQ1Gyge6SC/DW1OheATuLXumJdu0gxjevYO0lGB9AavE8KN5rGKa8Vn9cE6SJtYS4YLuLfBWx5CG2KZgCREORcrhdHihHP70RtmLQN2CtyT6+oG43Jwy8/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnYqCUntM/NX1ErrsJ9YH3zVBd+3l/01MTP4+SFTKvA=;
 b=KdcBtpESiGpcotcE9aWOQUWEUNENDnffbHYi98JhIH82pNf4LJKuDGk4PRanDrVzCwbOAHBPq55iXovnc9IC6/nD2yVaSusRodv7zt/G68UltmpgqqqddcDCXjtUnR9fjoCQ5Nct5DMP54pF2zsJswNWRwvUDZbPZ/OP8jD/iBTsfBCaTwe7LqSAaIDWKkiZRBAhiwYAlv2T+ntGCPEUlhuyTvSWCcEboDKGBs1+dZlsPVazOBBeZO1nrDLM7rOyT9d5CTIWsRvqZpzeSw5Iw8lmcr+tbW2Vj+Ji3wVTHPvVuigOJnoMhw5iTqDBE/fU+d+VbbP/ku38oT7GzxUdQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:39:07 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:39:07 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v2 5/7] irqchip/imx-irqsteer: add NXP S32N79 support
Date: Wed, 25 Feb 2026 14:38:56 +0100
Message-ID: <20260225133858.8026-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::10) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8e94c54e-d7f5-4e40-977d-08de74733ffa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	4fZiGZx8zQB+OkYo1d//Qtme9KVgmgDCbA24nzPQU9bGvGyCVD2soyNqnDtyNqAf5QffRmKUrG2HhYDmJrhriIiTfs2x61lRJEVXgsgdgIWxsoZDAVsokAJF4Z/VLwQdR+XC8DTql1ZMl3QwzCei9UTOm6bUPO6WWKn2fxv5sayB7VU4s0jpob7my0Kej1bWABCdxilYoD11TnSAzBrrpxfZJ2BaEe9gwhW9gwbkNcFUcNnbMHz3TEV5BFgMGiqMrqNzWzPuywi42yECn6Zh1fb5wk8/ygatuxnsEYfPEIYCIFztKlN8X+Em6Zx9ZYIkPD6bD8jIRXyhZeDLrxJ6dam8aOcd+B/FioEMYZ7LGPYvj2SE8elXsC3sVMSD6R+3AhdsDZM7d7X3OvzERC5ey+7u/39hmh7gZB7uWyaOowB0oGdfaa59TUNBmFKpSygMStDJzmlEn/xL6AG/bwh5MnEe67cS/vRizFdz1Xupo70JFLEcQEJe0L3h2zrxpv+gtojDS2AsL8gTzR1Ft4tYn0lcNIs/ezSwTcrPaDPex6gCOBx7n7X3I5X75IE/V+nV6McxCL1aNeZ0G5E/YM9LFuhZuhgdthxD+G+3UpAUYfMMlx0uKlttlLtgctwqMXQsyfygJosFPW8Hy2c6VRSeEkiAxVL6nAGY2Y37H2N0OfxikN0zsGD7nId8lvSYqKK3HvhD4Qw3t9tGaKU6t66zRI+hfOrTsnQsKpdhoUhKmx8WEvgnvtSro83NnBvRe5z8hZk1jPD1a8J8SOMRGmrVuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykp5eTBpb3hKWnFTV2g3V21aUncyK1NGTlh6MTBDaTVYcXlHbjliK0Zvd25I?=
 =?utf-8?B?TGphNDdvcDNwR05HQmFFWEQ2akhFL2dSOWU2REs3bDhHbEZXV29XNFJmc2dI?=
 =?utf-8?B?UlVXZi8zNXorZjZRcEdHaGdCZnBPZytKRFcwWHZxS2UzZDZSOHVTSjdJNTV1?=
 =?utf-8?B?VEl0YmpPRG9NSUx2b0V5N3BlcnRseEJtTXdaNFBETmloQ1R5QjFSMkczTXJr?=
 =?utf-8?B?cGpXYVJsWEpaMzJZZjdrSXo1VW1hV0ZzM0dEa09yMmZzWnI0bndEeDRmdzhZ?=
 =?utf-8?B?aTcyZlRqNmxxZnNxSDEvbkc3b0pQbWN1RDR3NFptTmdIWjQxY01LQ1VTa1py?=
 =?utf-8?B?MTJMQjVKQi8yOG5menVhV3pmM3Fqd05VYXJwTWtOSFBhN0J4eWIwYnZ1M2Q4?=
 =?utf-8?B?TGh1azMvZkdsb3dEdTRqRStRRGdNRktlYkEzSWZEZVRoazRCSzc0VFRnMGlI?=
 =?utf-8?B?dFByRlRCcURRazJEY0FGZkRKenhHTDdMbENzeC9TL2MwR3JrZStLbGxjWTlJ?=
 =?utf-8?B?bjJwano4dG56aUxTWU1nZk1NbEtGQk91c3pJTHRnYmlacFhGVE9tbjc1a2NY?=
 =?utf-8?B?cys2QzRTSGlZeGh1ZWtnOVdVb2VjdVFjRHQ3bkJ2NVRyOWdiL3lRbUlhaU9T?=
 =?utf-8?B?S1NVMld2c1NrMXd1cGVZOTlFSWdsRUE3RlpYL0R2Z1lNNGxnYkpUeFdvakVn?=
 =?utf-8?B?U3NGNHZHcnc5RXdJbUhaMXpPa29qNUlHZkNqcDJ2RjMrRHdkQzF5OERWVGhu?=
 =?utf-8?B?RlNoWHMvamRVOWp1Y2ordUxvSEVVWHovUUpGeExEeStvR1NzYXE4cXBIMnp3?=
 =?utf-8?B?YTF3WDFLOVQrNnRHSEdHc0lESnlqaSt3TGd1REYyWnJyaFVJRzI2cWh5Y3Zt?=
 =?utf-8?B?N3hyTUxGT1EvcExkYldLZnNJZXN5TnZRQTlUcGtTRHkvTWVYTWh2M0NUZjJh?=
 =?utf-8?B?M1p3U2VUOFZQbU03b1BjUTA3UnJicDV0WjJtTXhaUXZHTlNzeXZhRlpvMndq?=
 =?utf-8?B?ZGdVNEttdGRLaitueHVnbXk3MXkreVo4Y1J3ZDlUQjk2c3JhVS9rZ2RPZkR0?=
 =?utf-8?B?bE5oejY3Z0pQeVRvYVhjeU05MEppN2dLSUd6MGtIZFJKWHJ4RVF6d2IrVFB5?=
 =?utf-8?B?ZUgvYlVxcCt4YzBoeXJleGZVZ3VBY0dpV3FDRk9QN2dnWGJGSTF2SGpxTkVj?=
 =?utf-8?B?eEVtalhJbzdXbkhiMG1raWJpMjQ3MU5WVEZ6YS8xZVBwQlpnTnl2WmRONVRx?=
 =?utf-8?B?V096MFN4RVZUWGY0VU44UzZneXhLRUE5cjBvQjVFMU5tTy9XOWRVU1liYmhP?=
 =?utf-8?B?UUZmRDJySFpXYS9OZnpuRmlqK2tGUk5SbEpQMzd3ZXE5b0I1VHZ5UnI1TUZh?=
 =?utf-8?B?QTFTRUtJU3FkTTR2cWFZMlF5WUNiMDR5TXU2ejNJVGsxdEE3WVdSaVY2dWo1?=
 =?utf-8?B?MGNOME1SZC96RHFtd2YzcFFTcDluL004K05VTnkwLzFrVzc3NzF0ZnZZQy8v?=
 =?utf-8?B?djROLzEvUUVYcmJyRmY2N1E2ek84S2U4d1VJMXNZczZjeWY3SmtSV2hoM2Y5?=
 =?utf-8?B?NlVmT3duSkJIQXFvNDVTYTBwdWNlbUphUzBKYnluTzZRQ3hrSlQ5bEltTVdM?=
 =?utf-8?B?ZTlzL0pKNjY2R2l2Q2d6RlVyYkZQcXE0NVJjYm83SjY3UThwaGF4THFjMHRj?=
 =?utf-8?B?dDJVaUpYeUFzSGRsaWlaVk43REFCQWNBc0MyNXpSMkZxR2IwNzBJNWRha0k1?=
 =?utf-8?B?SzUwTUZLRS83L3Fyek9WL1NQbVdodHBoWEdDMnhhQTZmbEFIQytHSGZ6Tjdj?=
 =?utf-8?B?OVFHc0ErSlZGaXVRdHBKRG51ZG9ENEprQ29Ld3dUNlczR2cwSXc2Q1I4MTlw?=
 =?utf-8?B?NWgyUUw5bENmemEzZ1F5VEFPckh5MkpJbUxOcGF6MUhPSVRNcUVXVGdBU3BB?=
 =?utf-8?B?czFNM01obFZXYUtITXhZN1ZTRmdPclkwVGxjVFRObGNKdHJZSUVSdWhORWZW?=
 =?utf-8?B?SXhXQmRsOXkremxPYTc2NFhFREp0NGVRenI2dkE3K1MyN3cwT1ZnRGlVSlZU?=
 =?utf-8?B?RjkrWGE0WTFOVTUwazBOekZOU1dmTWxJbFBHRDBvREFGd1FOemJncXl0TDZq?=
 =?utf-8?B?bDd6cW05T1VCdGFBdlVhb2NSS0Q3aW95eEhVNmdRenNreFFxTzJscWFYWlE5?=
 =?utf-8?B?MnVvWjErUGUvN1pzWDdTa1NVSWNQc0JLbThRKzhoczhFLzdBdDY3bnM4TkY3?=
 =?utf-8?B?VXFxa2R3OXdjTkxJUW1nOWRBeXVISk12UlIzV2E0QTRJblQ5Nm9MNDJqczRk?=
 =?utf-8?B?RFVBdm9hL2lFRm1EL3hRWlNPVGUwMFpLL2RGeW9EZjR4SDduTDJGeUxtN21h?=
 =?utf-8?Q?96U9To1kDe75O/wM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e94c54e-d7f5-4e40-977d-08de74733ffa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:39:07.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1t5bTuUILADZsgin9S4ebA0tWJ5CWbIBXli6fojnMIRqtKv7oK02dDRuQ+hn0zfB5yP+Lo/WmItCLZmWcl0+pomCPvYhwIdo8+DERIoo8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add support for the interrupt steering controller found in NXP S32N79
series automotive SoCs.

The S32N79 IRQ_STEER variant differs from the i.MX version by not
implementing the CHANCTRL register. To handle this hardware difference,
introduce a device type data structure with quirks field. The
IRQSTEER_QUIRK_NO_CHANCTRL quirk skips CHANCTRL register access for S32N79
variants.

The interrupt routing functionality and register layout are otherwise
identical between the two variants.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/irqchip/irq-imx-irqsteer.c | 35 +++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 4682ce5bf8d3..82e64af87c0b 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -26,6 +26,13 @@
 
 #define CHAN_MAX_OUTPUT_INT	0xF
 
+/* SoC does not implement the CHANCTRL register */
+#define IRQSTEER_QUIRK_NO_CHANCTRL	BIT(0)
+
+struct irqsteer_devtype_data {
+	u32 quirks;
+};
+
 struct irqsteer_data {
 	void __iomem		*regs;
 	struct clk		*ipg_clk;
@@ -37,8 +44,22 @@ struct irqsteer_data {
 	struct irq_domain	*domain;
 	u32			*saved_reg;
 	struct device		*dev;
+	const struct irqsteer_devtype_data *devtype_data;
 };
 
+static const struct irqsteer_devtype_data imx_data = {
+	.quirks = 0,
+};
+
+static const struct irqsteer_devtype_data s32n79_data = {
+	.quirks = IRQSTEER_QUIRK_NO_CHANCTRL,
+};
+
+static bool irqsteer_has_chanctrl(const struct irqsteer_devtype_data *data)
+{
+	return !(data->quirks & IRQSTEER_QUIRK_NO_CHANCTRL);
+}
+
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
 				      unsigned long irqnum)
 {
@@ -188,6 +209,10 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	data->devtype_data = device_get_match_data(&pdev->dev);
+	if (!data->devtype_data)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				"failed to match device data\n");
 	/*
 	 * There is one output irq for each group of 64 inputs.
 	 * One register bit map can represent 32 input interrupts.
@@ -210,7 +235,8 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	}
 
 	/* steer all IRQs into configured channel */
-	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
+	if (irqsteer_has_chanctrl(data->devtype_data))
+		writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
 
 	data->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), data->reg_num * 32,
 						&imx_irqsteer_domain_ops, data);
@@ -279,7 +305,9 @@ static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
 {
 	int i;
 
-	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
+	if (irqsteer_has_chanctrl(data->devtype_data))
+		writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
+
 	for (i = 0; i < data->reg_num; i++)
 		writel_relaxed(data->saved_reg[i],
 			       data->regs + CHANMASK(i, data->reg_num));
@@ -319,7 +347,8 @@ static const struct dev_pm_ops imx_irqsteer_pm_ops = {
 };
 
 static const struct of_device_id imx_irqsteer_dt_ids[] = {
-	{ .compatible = "fsl,imx-irqsteer", },
+	{ .compatible = "fsl,imx-irqsteer", .data = &imx_data },
+	{ .compatible = "nxp,s32n79-irqsteer", .data = &s32n79_data },
 	{},
 };
 
-- 
2.43.0

