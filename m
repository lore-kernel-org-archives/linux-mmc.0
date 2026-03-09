Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA93D332C;
	Mon,  9 Mar 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066874; cv=fail; b=B6bBh5NdWRP4NC+oIQAvN/kpggx5XoNnGuLqdaV/XtAQCRQRwxG6vptTbd4BNIV8iP8+Ig2vQeLnweYY7ttlMTD3XYDEza5j2ftBbuHkqpooeZ4d+WPwv8lWCQdK80FtiVNtsbv3RTLOv9k5O+HsRTUF5jO5cV1NNgP4H4KXRGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066874; c=relaxed/simple;
	bh=2lcGIy+Qyvde+myTeWz6BEe+y44KlkRHjjIdKDezc28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDczjIyo12++VO+/eqYK/48j/ipbxPD4h9y0dgfoLemLHFMQ5nLiQM6KpInFnOJtwEMOb3OcILlVK1VTZlAaSTIWWLsrDZsfpkfvNse7s2886W8XIncpxl/KeI5Y14evixhipuVw9OAO5zRqyAchUO5r6nLQJVFOKJrP/HoVb5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KgdPMm3l; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KgdPMm3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/m/cXYg90lf5cAf6dEJST/sHaRwbqLXyWcF3P6LIxBrq+ZLZp93VnejfmgLqrOzbDX70kbr8icLJaeWpFB+yQCIU19TtAdS68oWWGBnJuqFaYN3sS+QoBpnQs8bKd75F/PmIv6imChCV7jDatbR88JfA60bPkX6+9mZFUUyv0BDnlX0Eo3BRjcaG1FvdTiT4CQObhYawHmz70g7/Tj/125ej+Y/HG4HymZnu7e/wpWpin7V+Hir1FBLeFe6Kxw5wX3L+k3JLJlFH22NhVuwXVVs2HtnPAzDdMNwe0Olpk0OfNcfPdCbtaUEAlME6SyL9AQod4IoKIhX5vqHBmq28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwVnINIIKCMDXVmX3jxEIphYNHcStiiPBe2ofhx6SZE=;
 b=c0J32xJpvTF1Af6mWUU6V7u4tiW3YEGBDmL6LEPJlfx6Z+WauROQAxaMQoTTd1iL2U5xXRj8tpCq/U5UVxVisXiF+FztXJOnBbRo1anSTgZHwprstEq5C3oDpXVNYumiv6VV2QuwodR+EEX6dD/+SDoRDCc/Gyxo8YEsWrl1zWpOWYu0avCgsQekxRj4iSEReTeZ7Nir/Qv28bJTERKWzJi8B6wZ7/M7FoXGjdbariBl2mZPbPuh+bfoQyi9Qtz10YeTAGPQqErEYOmQ/cjrkvYQIFxJhLjRGKuWlLBFtPRkwCm3uQ4iIM+qfP8DWoyFKv3XMO/gQvYJcFGuu6irlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwVnINIIKCMDXVmX3jxEIphYNHcStiiPBe2ofhx6SZE=;
 b=KgdPMm3lIY+MvhkUlbEv7BoRoE6qqmE5C7KOee5kmJOi2tlXH22PHdN62cD1I0ZaE7PZ726rTWupYinpm9QQteC7FO0+5E3FTUb3tZ2fesuKGBqbl0syM/HNKCtZTa3ceIHqSmF7kqtf6vKljjgQfI0Dgsftu1ppDNzTyZ9V0dnPj80P9jRIRGnWOHKxoOY+rgo3Z5e2ooekUNktD7uZLQ4wes2b2O2DAoohOQ0aYBz2AFHxn10G50VmHoxojhmvuc6mlzICWNJotLCNpjKMwtoq16cfCIVtrk4x9+AcO2dxrkun4Syqa1qflVHisgcJDyznlDASMCy0NQLu/IupGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:34:20 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:34:17 +0000
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
Subject: [PATCH v5 5/7] irqchip/imx-irqsteer: add NXP S32N79 support
Date: Mon,  9 Mar 2026 15:34:09 +0100
Message-ID: <20260309143411.8231-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
References: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::7) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8bb55e6d-5ce8-4dfb-7b6c-08de7de8f17f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	G4wGZFRZe8IrUFgLu50gRtbB7pbisg8c10VgiRbvEThsa0LqVmdAzMNKwS56eMhhH9t33mtHANcRerG8C4vGYlM1l2an5CytVIdJg5Hsv/klCsQ7RbENPj1drOa/AkkzwjPZPld2pkZEVxaFNoTxDHRqLvXXr0TCNZM+Reh39ZT0yuqTGNa1y4+tHPjQMjN2MsTspnTAQZRi9AMXn2gY8YmDn7kbEKooK6OrlyEt6mxxt6l7I5K8dWfJDReeycTMbYafruG6EjdRoaaap+YmE9NEYXg4zagaq5QcZL0forgVFJGrwBbir+FAhmEfeOqUVdVz5L1z+cEN6u04K1LcC45L5kKdxbRlaVcGWTXaD5SKAdN+v0tmAuwB9WaUeY7SLQnauCRHBBwUR19hGwfVuoqmEYQzKzxG+zp22trqkVo7NBA4yxwlp1KMTQYzyzTBIRw7huB6A4yNKjpy+2DhkBOWL9o+QQTiIMI7wuDSpHA42SzvmZ4MrY4ePpuu+8a5eJdTRZH0Sp6AQGAtp+aCQ01fTqektTuMMG2DRKNxWhEmaGtHCO9QPO2a0oXGKL/NjLWz7Xg2DE6jQo3v7M8WjKKzAkRHakh0lS+TzrwdaqtLnuokUDW1Xs1XHs5nnHSzCfg3va8cYhpEFmUQBcnN/P2UxakFWf+xXGRA5ncRy2YAONt3FtFeY6Bb8S4z/ujUmjbaYgZWyjk0pKfnY7Y1sB5Yq6bNhunmRE+Zrto5Bc8+AReXiaz0xaDmoGeVO3n3u87534XkAlSL6Kn1fQvflQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3BFQWdZZGt5T3k3ZDBUbTZaZEdBVlZEdFh2cStFMURSc2QrQkxtNGtqQjAv?=
 =?utf-8?B?MWh2aXZTYXgySkpDL3U0VURvcW9Na1BpczU3OFZKVmNOaVo3emozelU5TUtX?=
 =?utf-8?B?eVZvMkZEOGh5ZEZaWUQ2VnVSSXc5MFpnOXZEUnVGdEJXTFJlQkQvTXRkSUdZ?=
 =?utf-8?B?UU1YcG13aW1YR3BVYm5YSnNJa2NwanR3ZEE2a1VIUHZOaEhuY25FZThEejVx?=
 =?utf-8?B?VWdEQVUrUlRWVmlVTXNjRndTeDdwS0UwNzNaTkFsZ1hmVEdiMjg3R3dNZzFN?=
 =?utf-8?B?VkJ1WmhZYnBUM2hDQ1FyaVlUQjd5Z1p6SDJFL1c4LzBRL1UwaHpSVzNxVCtI?=
 =?utf-8?B?eCt6cEpvUGlyK3pQSHBDbXJRYzRKME53blJvUGIrQWtXSDBYdVQ2VVdRbDhY?=
 =?utf-8?B?R0c2UDFoQW9uRFM0NjBKMDRvRVJKR2ZWbkJ6VkQzZ1ZJRGQ0TnNaN0c0Q0ZP?=
 =?utf-8?B?c1JrTk5yQ2JHYTlubGlvSDRLVGNJZjZpbU1hQmthUjdDSExEWWtHdlQ2b3d4?=
 =?utf-8?B?Nis2VGV5a3NTcWtQREVxSjBqUTc2MnNrZTNzYkI2UnNDOURpUExkTjBGd0dW?=
 =?utf-8?B?VnVEcU4vT2hyMmhCMjRmR3laaXpBZEdFajAwRTFsVjkyM2QwbGZseWg0N2Q1?=
 =?utf-8?B?a1VjcmtMdmRPU0VzbGRpM1h5c3hNVzlicUFyVTM4R2tOSjNpeHdmU0Z4Mmdy?=
 =?utf-8?B?OFZQTHlYczYvRmpNYm5wbFAyTjBLSnl5aWkydFd3QlhmMDdnc1Yrby9TSHVB?=
 =?utf-8?B?c0dpSm96aG5PMmJRTDFpM1lvRnArRXlqZmd6anR0SDdHZ3I5eU1uSXM2Q1Zl?=
 =?utf-8?B?UTlOSENzV1pHdVJQT0hhalNyN0FkWU5Cb3pGRVRZd28yVDBuR1FMVC95OG9C?=
 =?utf-8?B?S0U4S1AwYXZaUlg5SG9PK1ZDOFJ6TmRrSEFtT1ZLa01KYTU0Z3g2dWRMbE93?=
 =?utf-8?B?c3p1bnNWaDZ4djZCREJaMGdTbE56RU1TUEc5RG9vR0kwWmFqanFpa2haa01v?=
 =?utf-8?B?QUFGNlZaTnJxY2RmZHlzR1o3WUlkaURqZUxlZk5NZ0tqZHJVMFlMYzI0akdR?=
 =?utf-8?B?RWgzOFZuM2draGNJQmg0RDRiTU9WQ2tJUnFLajVnV3FSdTNXU2Z1SDlVcW1K?=
 =?utf-8?B?NXg2a0g3bFNHRm5pbW40MzRNdml4SHE2ZWRMdkFjeXl2Z3pMc25ORFZZVGJw?=
 =?utf-8?B?YmliRDRxV0IyVmE3ZERjc1k2TUFXakdYeXNPczBnUjdjUXk3dFV4RGVDY0lN?=
 =?utf-8?B?RUNvMUp5Q3FFUm1GOWVVUnRWM09oN0NkU3FUL3JuOTltS1VNRFFvdzZmL0xB?=
 =?utf-8?B?YmFlRzFBTWZDSVRRdVVBUXVWbW94Q3lkRzhiRitRYU0ydGw1eDRxOXFYYTVM?=
 =?utf-8?B?YnZqVDlmQXJ5RTJYQU9oVWJKZjRXYVYvK3Rqd2ZsczJjaURTUlhiU25JaVhD?=
 =?utf-8?B?Nkd3TXloelhpY0FQNXB1WFcwU2JXdVh6VEdjdnA0aHVEcGdYY2dYQ2ZCR1BN?=
 =?utf-8?B?bkQvVjlRRmdoc3VtRHU5QTVsbURCeUFIZkViTkFXQjl2S2RVeTF3dW4yYTYw?=
 =?utf-8?B?V3h4czBlNTQzQnRkUlhXRWRxWmZZNklOOVpobFFzTGVuVHF0RnZJcE1CVkRa?=
 =?utf-8?B?UjEwdVpTZnR4NUtCd2lnSkpMblBKbVZwNFRPSnNvV3QrajJ5aUEyRVEyQzJE?=
 =?utf-8?B?cThRb3hnbmYzY2dLRWdQSEtCR1dhKyt3cWtvVjdCM0IxUUhjRWN4eWkvWUtz?=
 =?utf-8?B?MTc3Q1NXTEtaWGFpUkR0cDBhMlNaWmpzZG90M0hoaEEzMzMrZXBaMnhlcVVF?=
 =?utf-8?B?SW9XSDJ6UjZZTGxvWmFIM2RINzQyYkhROXVHNnFTYVZmRkt1UXp4N3JPQTBz?=
 =?utf-8?B?QzJEYWt6ZU9BNklvVXJhcmxjQVhVU3hIVHBEVDVib2ZwNlEyaHF0aDBuMVFN?=
 =?utf-8?B?dzZiUEtncjdJQTZqSHBWaC9lQStVSXh5MVFKVzdrNEdRVmxGNStIazdrVFZR?=
 =?utf-8?B?dHBEdFBiVUM4MW5BNkJFK3p1TStmalM4Ym53ZFVQbTB5UkJMZllSWkQrd3ho?=
 =?utf-8?B?VzlsUzJ0c3JOZ3p3a0xZQXFSRjBzaWMyMG5oOTA5TlBMSG41VnJwYlYwWXFm?=
 =?utf-8?B?YURWQzU1SGhSMzhvMmFzd29IRWhKQU1GZWZuY0pzREdXQ2dNaVRQdGhqdElq?=
 =?utf-8?B?cnYwVE5ienBJNjZvMmNFZmNxV2FBOGFkRkdSN1pVU2kzUWl1eUVsbmVQMitX?=
 =?utf-8?B?Uk9HTUhrZVc1b25TUWRuY2dnOWRlTFl2eDdUNGJ1b1dCRnYrcWZDalQzNzJh?=
 =?utf-8?B?RTFaWWxlSE0vejNzbHZwNk5oVUZxYjF3VElFcDNWZ0dRMDJjRnNRQytZd1RE?=
 =?utf-8?Q?kS7/FSvXVXyGYi2s=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb55e6d-5ce8-4dfb-7b6c-08de7de8f17f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:34:17.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK+ArMD6XGF2h6wStHtcAAZrs114KXtmM0Dhza165dtItAurMa7IQwRo/B3WmrZi8du1islZGCxO5EEBcsxv7YKkleuI2goOWkFZiqZJHlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

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
 drivers/irqchip/Kconfig            |  6 ++--
 drivers/irqchip/irq-imx-irqsteer.c | 55 +++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 16 deletions(-)

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
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 4682ce5bf8d3..0e88ec4667da 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -26,19 +26,40 @@
 
 #define CHAN_MAX_OUTPUT_INT	0xF
 
+/* SoC does not implement the CHANCTRL register */
+#define IRQSTEER_QUIRK_NO_CHANCTRL	BIT(0)
+
+struct irqsteer_devtype_data {
+	u32 quirks;
+};
+
 struct irqsteer_data {
-	void __iomem		*regs;
-	struct clk		*ipg_clk;
-	int			irq[CHAN_MAX_OUTPUT_INT];
-	int			irq_count;
-	raw_spinlock_t		lock;
-	int			reg_num;
-	int			channel;
-	struct irq_domain	*domain;
-	u32			*saved_reg;
-	struct device		*dev;
+	void __iomem				*regs;
+	struct clk				*ipg_clk;
+	int					irq[CHAN_MAX_OUTPUT_INT];
+	int					irq_count;
+	raw_spinlock_t				lock;
+	int					reg_num;
+	int					channel;
+	struct irq_domain			*domain;
+	u32					*saved_reg;
+	struct device				*dev;
+	const struct irqsteer_devtype_data	*devtype_data;
+};
+
+static const struct irqsteer_devtype_data imx_data = {
+	.quirks = 0,
+};
+
+static const struct irqsteer_devtype_data s32n79_data = {
+	.quirks = IRQSTEER_QUIRK_NO_CHANCTRL,
 };
 
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
+		return dev_err_probe(&pdev->dev, -ENODEV, "failed to match device data\n");
+
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
+	{ .compatible = "fsl,imx-irqsteer",	.data = &imx_data },
+	{ .compatible = "nxp,s32n79-irqsteer",	.data = &s32n79_data },
 	{},
 };
 
-- 
2.43.0

