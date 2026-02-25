Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241973C1967;
	Wed, 25 Feb 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026757; cv=fail; b=qYfwALNA6gUzac8vLz4J8InbVChb8DdxIgfdxImo934C8dQLdz6bzrkREvAxs4sbme6TdZNoZ+4LZYtg1RaOY0iSi+6h00UVK/j1xnHES0JdHasZFFX3kTQwOYDP2O1ein7RNOtOkak+FvgRLO4wIjINLyUipIY1TLo1UeySB7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026757; c=relaxed/simple;
	bh=BNFGGBPM3NKXXTHWpurUJlv5loSpPHIYzbpPb2YTeqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SD6hU2YRKlzGwUnim/cF34Ve8Q/d1cCHrkrfzHtWZeJ0U3chd/eGdyIBSlXxTedzDtOK9a8taO3FBjwkO7Crlvc3KV7/VKFhAfiR+Jp43z8d5mMmOnKeaH+0bXJQZmfzBddREerXfKjajuV14mmta6x2Bo5eN/yG3hlu1TGsX9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BXf0oF++; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BXf0oF++"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrwQa6+xXO+hscOY+zDdcuQt1dCfGRPtfkrEDTOej+9TRjAZn2pK29+D2bd4p6wD335b7iPvngmO/Zo5Vn9F8/qXrbOLB2jFuAyMTf5GzE5AWfUbfshNOs/YR1VwFgYG6XIaOhebAQ0z5wlcfnQgVmrgCYreV/dpSF8bov+HsFQcZvTipm2kzA67ErKu9lOt8lYsXheTEmI4sG+g4gE0QRlwrSJWotbPAMhZyJe3NTyfvLAPZHg93Nn6KxD2V36yxMlajGhg84Y9Ge1KzVAWaqgtJebIWySpeUdzkqS5PE0A9ZodXTNIDdKgG22vZTeIpo6ZPCPmem3Xf2BxYtO+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhpopCPKvuwkj6FC9iA/wvM7/RzmN7Zdv6rgKnpBY0M=;
 b=M4H26okqKaBgCgvMYpooJNidhDfseEJQIlNWyu++qYo9RYdI1DGpf/49zESMSR6EwNayjYTPVfJkO97jsx5hhEqOoiq6gwj2VGeZBA6UXwx9avSodf3sdXF4C7Ni2qsGNKPKENQOQARs3VZrSSCiDPMdoKtSAdmc4Jr/daLkBH1zEEip7iEP6E7k3CLjhtQ+taxl37hSUikkXzferq4gwaiQ98YM6LCAVBFlHbmb8oPCbJeBNec1qGrhb4uYIB6M1K3MmLO9sBfkoBmbwNXOY/k5e+KTCke2wQ1Fu7xinWBRtgfZzbMxV6y8+eticMJS4KOhVsoPQIixNDTatowwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhpopCPKvuwkj6FC9iA/wvM7/RzmN7Zdv6rgKnpBY0M=;
 b=BXf0oF++lb0jfqfCOnhD33VsphQN36hximb1iHcKdOGXAitRNYCHOSIVLza9tkdn5meBE/c/uXRkjThVP7DAFeF/PkkDc3g7R4rQRTHgxb8VfFvMgr1a2gmWVt9K+nhg/DFC6WmvmGtIAhCJQ120lBrYxZYU0KfkhAdmHOz82H20F22ZG7m8g82Di9d8LyELh6JCLp4d6f2nvlfHEeDTOIs+dSVYJgsJBZ/5iGV72yXWoVtVin2V/SN7bUXEV7AlJfRFyzcxJ+1FPYIEOCmfvLR7wouRVD89U4xau3YlPlz9qgkgld/eP2jpjp+XrDxArGVFUHZZJ31WbC5y6t0QKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 13:39:09 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:39:09 +0000
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
Subject: [PATCH v2 6/7] irqchip: add ARCH_S32 dependency to Kconfig
Date: Wed, 25 Feb 2026 14:38:57 +0100
Message-ID: <20260225133858.8026-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA4PR04MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: c145f4e4-4ed8-435a-665a-08de747340c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	drxKg9fH2pCqZFh9BkLYjBQiZxZ5nYKTpikkXVigJxi2RKEkYfNSeWHDiwxIgQTVx9edaN3/JY3eumHK+V8X1poTuRJIZQ+1CqrNycqOh11ad1sAzTM5hWfI2hOAN/oGZ+UdLxtiLJLtgoDvuL/vlk8A0ArwFR4r0LUBN928+qhL+BEMA1Z0uB/kDRjWb9AwrT9altAmHeEwn2A/ycf/IeEVjTb0eGlWj50j28xwTCPZoDVTzEDdA6f98HPMvbSGXVOdqDs78vFGaNIr88QF0ebzEWa7cMfOfLNkj+QQ7QiE3geo1aw3D01XFsw1/J2xt9E9UFxJ6aPozeSh2evpdf4JP8kuQ2TbmQHdhigdZTgScZGlJMCtj3Js4d0zkUMp/1nutWIL5uWZhmx2bgHQJy+Zzt/CBkkkvMh7EEadIeN34bjPRizrqC3sO7nvDBK+TU129h6uBBQ4mENSLCzsEKTVN7otnOjEP30SgYXsaN4UUva4q5KHP+xs1JAdqYI+5WO3Ap5RZ3GqrrCAH7TsQNu+zueKG+ix4n8agaB6ItlUeZEzxCZYHNfrVGoIs+wXdxXHcejCb5uJRGnNHvcdtz1wNjM0SUnSdZIewfL7QL+E3EEzcJFrtvzanSw759KFkOoDt8xjeX5gB18/XP/yBtTLBuqPdjc+EB2q1+PwlyPSeBFy82DctXpwkyI6DsW3M8tewZElSzAxSfcSjB3zT0CH4fS/Bv48OTKjyM+661K9BwhVCaCtezaGOdSBoV0b7rpp0LudK8Sg5N/n7KbxtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1lHS0dmT2trMVY1Vk5SKytpRVhieFZGVlZ0a3hUUTRaaXkzRG8xUVUzSm1z?=
 =?utf-8?B?UytDNE9Ka0RCSExBejYrL1ZTQVVycWRDN3BOZ0JxTlRHdVBROW0vOHhjNnUr?=
 =?utf-8?B?RS8wZWdHT3pjN0haRGkzTmo3bmZYYmI2S2IxLzd0R1drSDhSdnNMRVNFQ3N6?=
 =?utf-8?B?UzhOVUJoN3VRVlJ5SngzTmdxYzEvdEUzT0l1enRMMGpDK1FuYTgyWW12VjNB?=
 =?utf-8?B?c0F2OVZwMHllbHdJUk10MzRlZCs1MGhhL1FRaXN6VjRJb1Q2SWhtQnFHSGlK?=
 =?utf-8?B?TW1LeDdqdDZiTytmVlp3VGZINkZ2QnNxRXc3aEViRElRV3hSYjY5VHF1ajJ6?=
 =?utf-8?B?Qk1ROERMQTNvaFZnSFh4RzJ2dHlYRTdxNVVHN2VtZDM0d1BQc09Od3ZhMWpU?=
 =?utf-8?B?T2xRQjNmckVBS3pUUDJ5aVl2VHBXamx4ZXJySUFTL2c4SDZWVnQzc1ZLWmw1?=
 =?utf-8?B?bjBLbm9sczFwYWQ0WjVHUFMxei9OWWhBamltdndJSFY0aG1OQyswNFQzUXBq?=
 =?utf-8?B?TEk5NzBNVlVnTjB3VlhRak45Uyt4UFZHd0NUcmNlaTlDSU80dmY5M21abXor?=
 =?utf-8?B?dHcwNVZCVUwwUFpRNTJabWUyY1pMNG5RZ3hLYUJpSGYzZnhBWlZCbW13V09Q?=
 =?utf-8?B?RUF2UWRjLzV4enFwUmZhbmRxSktwWGFDS0JnTEZDZElNa21LRG95VXN3cG1N?=
 =?utf-8?B?QjEwUEt4MU9mdXhLODJNZno5UXZ1bnE2UXNlSGpCNjJhMDRrM3RPTUhMWUhh?=
 =?utf-8?B?eVhEK3dWcGlQTDY1TWljWllySllrcFUrdEJYVHpwZGRvWlB3ZnQ4MUpDMVZo?=
 =?utf-8?B?M2p1MTlkSVpUNVlseSt1aHlOdnNVNWNMcy9zN0p1bUlQTXZ4QW9nRXhQVmUy?=
 =?utf-8?B?eXQxcEFZRnlOaFJpQzAzcWxBNmtoOXYwTVM4OFdRTDF3SWFGZWRvRXYvYmxM?=
 =?utf-8?B?ZHh2Y1h3bHVkRklmU0xrMUR2VUNycThhTXBYamFxdHRlZ0g3Ulp5YWxtSzJE?=
 =?utf-8?B?UFhscUFhTVdHbTZKUU9OOWpVTGswSmlBTy9uVm0wM3VyeDdIWGFuZW9QaVVN?=
 =?utf-8?B?NjVDVFpjNUxOd2J3aW1Cd3dWZUxnb3k5cEZrbUJKeC9iVlJ1SUVwckgrT3dQ?=
 =?utf-8?B?SHZEV1VUd2FDNFpOU0RvWmdhUnFmWWZ6UUlPZHA2RnlHVlJYZGVBZkJ5QjV4?=
 =?utf-8?B?RFJFWmxIbGpPNHRmV01aN0F4Rjk3ZWFqN3N3SHpsZDRiSlhSZHZ4eThZanRs?=
 =?utf-8?B?cU5pTUVOZUdta1JqaU5WeVVMbnR5QnhWN3dDaGlRRDlPVEEyRTViMXQzUzJu?=
 =?utf-8?B?QVhsTG1CNDB1TGZmcWJUclJkRThMUGphMVRNTm5nNEJoemdJK0p5ekRJQ1VH?=
 =?utf-8?B?dHZPZm9SbkFPWUJidW5ZZ0NJVDh1dmM3UHRzdW4rKzd0empSQkFFZGtBNDVk?=
 =?utf-8?B?OFBOYm1SM2RQT2Y1WFdIdGI3SXpPMFg4aDVVd01La1luekE4UXllU1Nxd01O?=
 =?utf-8?B?aXpJdnZ0YmxhUGg2TUVMVzNzaHBzVHluaWNWWlhuZFJoWXFQUUYvV1RpamRF?=
 =?utf-8?B?YzhCZ3gybTdzd3NFOU1CalpyeFI2SFNFTmlHSTNVZ3h4Ym5IaERTNmQzZGQ2?=
 =?utf-8?B?NzQ3cW81eFNRZVljejQrSDMxUm5rQUxtdWl3elFIR2x5Y2xEWnZia1oyM3lR?=
 =?utf-8?B?YzJtZkhXMytuZkl3M3hwR21DYTlCOW5Obkt6M1crbWl3UG1vWnh1bnhNOUtk?=
 =?utf-8?B?MkdPVHQxQUY3S1pDWVVsSlY1dTYrT2pRajhtNHRRTHZSaVBzeU93Q2JmS1Y3?=
 =?utf-8?B?UkJkOEh0RnpqQ2llZ1l4bFUxaGZvUW5ZaXAvVXptc1B3KzZYRWx4aGhlRm5J?=
 =?utf-8?B?QkpFcE5YSEpvbUIxRmJmM2F6UnZhdGZmdTNPcTFTYVVBVHZXZ05lT0dZVCtZ?=
 =?utf-8?B?MnZZa1dKaGI0TjNBd0cxTmV2cnovdjdYM0tzUjZudVVCNHQwNDh5ajZSaWVN?=
 =?utf-8?B?TFE4akp4TTlpTFN5dXJ2ZWUwc3pjaDhBOFpIcXVpc0s4NVoyb2ExNGJmUHI0?=
 =?utf-8?B?d3llRXcxWWE1bFRkNjBJWStPSjZ0Zkg5TUswSXZTT2hscDB0RUlRUlRxdzI1?=
 =?utf-8?B?RGpZT0hHcUpJZDlLcGxLcVJDUmZMbVZPREdNZnd4VDVNU2YxSEpTTUxBZHVw?=
 =?utf-8?B?QXFhdFFIeVRuNEVaMHRENFdueGVQTUVrWDNHSWwrTTJQNWtwVUhzK2dZdmpq?=
 =?utf-8?B?TTQvbnZuc0hhVDlWTDJxVW1VamhncHJEVWxKT2JSbEZzOUpEWXh0Q0FFS0VR?=
 =?utf-8?B?dnBoNUlHMGNRejhnUTZWR0JEQU01eXo4ODkvdG9LOVg1cWNoeWUrajBsUmJz?=
 =?utf-8?Q?j7nqGoIH4hDCgs7g=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c145f4e4-4ed8-435a-665a-08de747340c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:39:09.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUYNu1hzD5PGCKua1mB2LycVjDZR7wjhv7bp+qA/gEQtEmXJ1deY7Wsu+cWcwprLw5HG17DnFzped5ItiNxr0s3IZKmuwNxTWwS3anl1dBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640

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

