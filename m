Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F73AE6FB;
	Fri,  6 Mar 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809927; cv=fail; b=QGK7cVKQ8nmkY98rWmfEUtfoi7JxRz9d4yGb0T45G79KFeIHyLPfn5v9CoPIvYermuL1o53mkdedPOF5RNT2wGx9NCSIXX7xEaxxJsNas/BoP9j0CxWzcYxP0JjGudRUkOEBFCDT1DdAP3QjUdaaI0n12iM1LHNC1/qtOJn18Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809927; c=relaxed/simple;
	bh=kNosUMJ7Q9Fd4AM9znZbrGrSwpsSf/UG82QuzhDL7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGYi88vhpTV5nue778tZwINi0cmFxVWcetoiIh0pAmSCTX7GL3DAQ396eTSKwlkYN6CrAEA8jZr2kRAb//S70NXwnnbZyEdikZ92pDI0058+OF0F8CkJoUHTf6XuCOhOTaRwrlCy7aDH06Gtbmm5PMJ+A9B8ncKsoh0cqPauyVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Awj7QKkQ; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Awj7QKkQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3iD5hlBP2+pbwP8hG896nKkeX96LX/C4z3yYMY5QJ6GoPhV7EygmYNEGPUc7jr49uapeGNQAxZTzF0/EAjnbtD4xcQzy4Kfsvea8OFgQRigqk46w3w2nfqsBB20YVSpYWdsacS/1MPZB6VhrSnUHzjq4AILLsJ9LJrV7OoB71nzgKb9guEBcrS2sO6hlHrz1FAGudr5Vkl4VFq8tB+k5Mkqi5PKP1ei6Mm01x3APrKEYrKpOUQjT0DjgGtukfZuFMgcViG2mFe/BZMdDefpb9GgtOF42ecoC6/OXbj5xe2Og9oUb99jf5U4lfolfeEvpHv/B6NWx9bjoYlMbyS2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnYqCUntM/NX1ErrsJ9YH3zVBd+3l/01MTP4+SFTKvA=;
 b=kkivDmHZEmkL2wfbI8pg2F18fgEHCAyctAotLlP+YKPiA8y7V0/rBligFfbeldQ3bVo3YoFeF3yY4sOuNrvTjdw3YuDsKAwl/IJSWZbMbUPFAJMKkRLQn03jvNm4WK4tXgeak87FMC0c3AjB/y3SmjeTmFcSWqnHVjwyBtYKcnTj6NsP7tgGL19dm6FfOhjk+RFwnUI4nA7ADSjJwBAO/rA4HsEVe9vXxumxJWoVNhg4qj1JwpHJooLKMK9R/Gil5PkeKZRMD9dqefPHFfvAjxjkzok7s2cLAX7nqQG9QbnoEkoyEmBgojRQ1AvquE3YBD2MqF6SHJ0hgE32qq2q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnYqCUntM/NX1ErrsJ9YH3zVBd+3l/01MTP4+SFTKvA=;
 b=Awj7QKkQ0v2+VLLUm//HC/9SV2ejmTXrIFi/f7/E7tGtRNWoPJpl2klQ8Ub5KxwWA5ifR/Oda34HiKS3fYFnOZiDvOTPSoAPXAhE3f4xooHTjt6Q+Pn5Y5Igckb6LbSIiQczqoI+pfLZMH1xC3nHJ+DqGFwpqE95RIe2vOXORxmgtXun1e0gZ5tiNC+XTQgsxca+lIH6HSICDDuk1+gAoFHCMiCJk6fOHjiRt0a5JhQjBshCrxVHAKZGtAvYcFTxfuCNMwygheE6NV8wGb3WnASn61zz9qvxjtAD9J0/zVrQ97/FRNTKMQnR/JAeNYV6eVU8d/vzec1P7L5BoJ4tjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU4PR04MB11908.eurprd04.prod.outlook.com (2603:10a6:10:61c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:11:58 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:11:58 +0000
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
Subject: [PATCH v3 5/8] irqchip/imx-irqsteer: add NXP S32N79 support
Date: Fri,  6 Mar 2026 16:11:44 +0100
Message-ID: <20260306151147.24446-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU4PR04MB11908:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8edb67-6a7d-451b-78f3-08de7b92b5cb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	NIhD9Q8/wsfDJzSonolQiIuynJBeLBwLxB6hgY6kvR0ve40xGt8EDggH3gqqXzZmFFsbrtK+aNTnZLt3m0KWtKOKwkYWMSEGTyZh3xKzqMwOUoNHFwRO9HtVtO+6CwR3lhPGw7pNk8EtVk69UShoyMdhakM3305vwRlPsUXwVIh7ydtsiE6dhOdXEC4fKJKpK8qBEaoazMPux+S2t9ePV8J4M8qhPePSkvoR0IjaqKl/IiQySZES7YGYtgFh1uz8EP071DQX3cOTqt854TQHTkqtQCpoVN07mEbDm+PstAu8CQ4UdWnULL/H3LNiw3TZL9gaZ4oJmsUP4FJWw9a83pa1nGmoV76fd/8RJJS2ERD1cUg3MJ7xYk12/CgpsEB5GIbhZ6JqYQ0uMe60bvSiB0fx3GeZL82gkLValkuW8TcFIMdLgEUQ3mNCWWR/l3Biq5Kiu1yLUkfP291Co30EuADnRZYptmERlrUtlB19elUJeSeKV1gEmjbJflpN7BijTZ52dDVhYL/d/TL9ikHOOklwNdBN4qq/XExBboYE2EKLR427QvctB8ejTlC+cGNVnXMWj80EhbM5G0bkQA2kUjmA9OAvFXkCoO5IYwZ5HRh2mI2Q1v/Iuy9v6EqMeRKp2tvr0dt4JXycmFhb5aat6F6W1wKFM+br2PF0J3YNlnAn4LjvmRr+KkHXdh2CdBrN2HJqpA0ZqZU3zOw1CxV2Gev+Gnt+e53Y5J4t3PuAn7o++jvjZxnAms36hqPXn7/E5ckChTqyf5pJC0+PaB8Xuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTlTaVRrbUkwbEVLY0xJM2l6Yk1Ld2IxaE9CcnB5MmtRMUFXN292QnM5Ly9t?=
 =?utf-8?B?a1N5bG05QXBibVI1RTZMZGNsOTFPTy9McDYyNW9rekpGYjZ2Y250RW5pN0h2?=
 =?utf-8?B?bVVnVnlvUVpjOGw5cUg1MmhESDZxTll0SW4vWkZiUkE5MGcvTmw0S2ZVRks0?=
 =?utf-8?B?S2FoeHB6RG9FOEowVnNoYWZmdEY3ZFVKQnV6cmlyU3VCbzFEK25vdEZXelY1?=
 =?utf-8?B?YThnaVlHN1pJWnV3S3V6NEtacVNEYlZjcURHa2ZRTDVQS1ZuUjNCRXdqc1JD?=
 =?utf-8?B?ZW1QY0E3OVd5V2tTWGVMV2Z5M1VIaC9hbVFrRFNZV0g5OGJSTVMzZ00rckRM?=
 =?utf-8?B?QitlT2JPak9Wcy9qMkFwRnorQ3V0SE9KanpnQTZSWFVJeXByd3lxU01VYzNH?=
 =?utf-8?B?NVcxTjdiSTFWd0VSZ05WWVY1NlZNLy9ZZ2R3Y0dFZm5xd0tRdVEvRWJWZWtJ?=
 =?utf-8?B?MXpwMWZRclNya1pzVWJtQm9CQzF3M29Zek5DVEhxai9Qa1R4a0tqVGRJeGZa?=
 =?utf-8?B?TjRXLzVOZzJpN1JTbDhOTG9OcVdqZkdQOEc3anFabVJLeVdEWUZoQ084Wlp4?=
 =?utf-8?B?UVBmR3JUNHpWV1BRa0gzQWlsaE9rSStvY3RNMmIzNDB1dUEzK2o5Y21RRlJT?=
 =?utf-8?B?elJrd01IakV3bVhTdEhRRm4vbzVnOGdzMHc0L3ZJbHljME1RWk5mc1FLUHFi?=
 =?utf-8?B?VGhZeVlna3FCZVREemJHVnBRN1hFb2FKUW9tUlRSSVJKSmZSQ0JQOEVxWnBs?=
 =?utf-8?B?bmtEb2JXQjBFUUhhL2xrWm1yZGsrL0VjcVdZdEp5MUd4MWM1TnJEWGFycTZU?=
 =?utf-8?B?OGtDekFxLzhtSndMOW40ZndWM1p4OHQ4cHRJVWlwZ3ZkM0ZUcDNuem1FbFJR?=
 =?utf-8?B?ZStPVkVIYjRiYkE4ZmFiN1hOZ1BoOEtRSmx5OHFHZlJGaU1BVzJkN3NCUzlJ?=
 =?utf-8?B?Q0xXK2pxNEdWYnRHUFlNckpTMlZ3RzVuNkRaeTVnOXlacTlRdmc3ZTRmR01I?=
 =?utf-8?B?V0wxdUpia0tGcFlWeDcwT0hOV3ZHK1h1OG5xMEk5SWxzWEoyZWhSalM1cUVj?=
 =?utf-8?B?RDRwbnBjanRndGpvNlV1UzRRTXN3bDhpeTk4NTl3aitYeGdvUzAweFhsbDdk?=
 =?utf-8?B?MFRTWTg0elRQZ1d2N2pNbm1IRFFFd0hCOTJURlQyQzg2OUpKak1CTVdRaGZo?=
 =?utf-8?B?L1NTcGZqcWJJRHNuYlBtMVdsTWVuMVo5Y3p3WFg3UUF2Mlpkc05xeUhocW9j?=
 =?utf-8?B?TUlTUjNqZzVZdVFPMUx2ZzZTSWE3aGdtcDdjK1plQlRhMVhNRmtKQU92ZHB2?=
 =?utf-8?B?WFRKSyswZUxqVmlpb0RRRS9MdlJhSm9KMVRGaStRLzVibzRQYUN1YXRrUmQ3?=
 =?utf-8?B?R1NuU3dtTzl0aEFhUExVNGZkMVZVTXE1NzI3RmZRNzIyOXhQRFJIQXE5aHlG?=
 =?utf-8?B?TE5YQnJCTDVZMGUydUZOM1BncUEySExGZHNLZGdxcjdOdmV6bnluNWRhNkE0?=
 =?utf-8?B?M0xTN3k5anhtbTdzdnlXWWZMU2JkbDJHNGNuRVAzVEFGbnlGcWVMLyswTldX?=
 =?utf-8?B?MlU0dXdGVnQwdlpGV1krZWIraGFGYkhGbTJuSC9IY3o2TEhyMXhaVmRSY0Qy?=
 =?utf-8?B?RjNzbzR2ZUFqa1YyOHZFNGUrZlRDZmJIU0VhdDBReE4wQUFCUm5sVjJOSnhL?=
 =?utf-8?B?bU42RHRnQ2JIM2lsdEtmbnJFOU5EODFHSC8rYnBRZGtrQnlRVUJqREd4TXNy?=
 =?utf-8?B?WDFKUjF6L250ck1ITnRleklGa2tzUEwyU3hOUmxHTFc5RHpSQW9qZFdKNUwr?=
 =?utf-8?B?T2RqcUxPSU80REpJdUxvZW1UYnRaTmd3NjdHUXFFcCthMzVWSkFCaHdYNlVk?=
 =?utf-8?B?SVVjV1dnYWhiSlFJV3Rtd1RtcXk1RW1ZRkpzTlNZZGs4QTNjU2ZXQ3g5MTA1?=
 =?utf-8?B?R3ZiWStGVWFEZjBDNjFKZFJ0d0k5UDlZU3R2YWhqZTVjUlMvRWdwNnBKVjU1?=
 =?utf-8?B?VnNRMTk1blVOLzV2cnZVQ2ozNnJQbkFLMmRXclVSbndSSFFTNkZOVnVuVXMv?=
 =?utf-8?B?OGpUOWtrVTlLRXdOS3VUSmJWb3JBZ0RaM2V2eDRqMVd2TDdibnRLUm85bE5Z?=
 =?utf-8?B?Rmh3SUNPcU5RQkZtOTVZNDhoRlFCN3dRNndBNG9tKzJtMG56NExLd296ZE53?=
 =?utf-8?B?eE00NU5DV2x4WFVEZDlJeEs5SEIyck1EbmJ2SittS2x0aE1mV0pkdnowaTJB?=
 =?utf-8?B?YmpaY0I2RzVQZ3VvQXdQQU5zRk1wa2JndUtrclBXbDFrWVpEZGVVN0dVL0ln?=
 =?utf-8?B?VU5yUHRUWWNaVXI3c1hjbFRGTkIwZU9JcE81cDd3MjcxRFd0WjlyZ2loYXRV?=
 =?utf-8?Q?rm+xuAM2uSMnj96w=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8edb67-6a7d-451b-78f3-08de7b92b5cb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:11:58.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5QTDzfJNI9pbwhNhDVdcuygoK70Kh22I/oaOd9eCwlBouVXBl1sPLfN1j4fyivbO26Z7e7zfgKav/yq4nOhfgqMt+0Eyf2gJBm6PEz/J0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11908

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

