Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A53C2791;
	Mon,  9 Mar 2026 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066861; cv=fail; b=k0cNXjAq4awk3gb01UdSx6EXDNjdP+A4reA2pYygK0do0t69tQD6J2qqAY3hUWWAE6QWxwu1Y27lchAyUa4obUYtC75J4KETB2KVoPImSEaXVP4rgPuAWLSrxkVAdXLD1mXv7WMaIfuklaR2Od8p9FPno+bk3XIc7HpOkhb5q0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066861; c=relaxed/simple;
	bh=1SF6sdOkcmkvfPHxDMZqRjmX2KRbLCB9j3/wSKd823U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5wjvMmaWePP0WLt2raFmATlXmUk4bxffPfJN2qYYCJvhJ1fN8mP3aHjFqkEUIa1DujZOeihyDJm85Qv2xmUu0QsgSvA7I9UVNVtTmlZiA1CqILG9mVxl8x38u0RYrKqckqUSgyKrd87VDKyZJdIqWITFwGeQ3cG3f3DRcCebHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZkBRdzZb; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZkBRdzZb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJEOa27LcFlpflDfBl133Ewf/SeI20g7M7/GKKRR0Tc6y+qj3ztMlbzZu1nq6X/qN9RqoZknfPUZRWQ332a3NwQ/90ujEIo+f3xx0dBaA2hFBYy4Kmc/3SKPLYHMAScehcrFlgKyEISvoDeffNi9nZIx5JCMTcZjFkrvLI0e3cE9Qel9ovEJboWQYDZGmVQVylGVhXXfy8endyTVqkUZEALEK05O3HTmSgK/pL865GcmcXkxtRVm1yKJA4VnBM7ROJzJJu6tkkVPJ3/e9RhJqtvX6ApyaaCI45GAwADvFj3Swg9kUouM2Ffv2sgXeMmBrEP19GaB1P42R5Np3rzgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roWpjnYjKT6TZ3yqhz0sPUh3Azim7Ka/UW4YABn3/D4=;
 b=mWgYusTFeq1GEA/DNQuB9QPTgpLjki+zqrD6qPJ0MmeSSVutaEn5Nn8rTs9fwIsstD5wWI6Bhgw7Mv8CuRG/2TMcADgSLvIMsoxz2AqG4o3izGsT5YXSXGvYHYfdhEP4iEyI3vittY5X0gFlxO0H1UJNYuPhzg0ctZjXsAbvUUanUS0sI1qDB41rggDvfDtBLgWsgYQOIXFVVIuBf1hPKEKyhzHfi/JZZFENtCZGnTiIdZCpVVzra3GBjFum5VrJZSYgqmjOkGv0Jgym7JD7/HmtQPmUEx3AkYSPshzhPHLF4v75iY3BuoD4hI9K51jjJnfXSPiV8YlwLScMt/RuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roWpjnYjKT6TZ3yqhz0sPUh3Azim7Ka/UW4YABn3/D4=;
 b=ZkBRdzZbLYk8AgqzTKtXLpyKKt+OPQpaLMSMrJ96DnrXaMMPyiBdo+WjSnby/Z5o1qFh8EXNPH+TP19Wu6yuIlySXIsn8/5CC0UdSySXDQwFD0CdNAQc/Y24b7apkb2oQNUnK7nj3quP1rDIs89EpdbElaG2CbvAU9BP3A2XdywC8lLTZGiejRY7rza+70Exp9OTft0G6K7d1iMxzIeWtoBfTJBTdgU5AkFQRw9QE33259e+NKd85pAgkScMM9mPvVRF61rc4fgB0zeRmpiqVb7Cxlz5zgr1lYyniowxk5Hgm02YNt59EzJ/IZAuxWqJBKS2zvqKnp8d859Eenle9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:34:14 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:34:11 +0000
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/7] dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
Date: Mon,  9 Mar 2026 15:34:05 +0100
Message-ID: <20260309143411.8231-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
References: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 76809b0f-e514-45c3-da69-08de7de8edf1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	5bXAd9OKVn734RiVKp4QEe8spDz8hV632xk8oBVTey5L7lgUK33lwzjmwASrhG5Hl7BSGQ7mNzzC5D+CsFyI72KdcYabgFlzXQY4Oonrbmye0WDBeY7tTWqXFWzAjfSL/VHq5y+Cl+JTZqhX072F1g7HMAtNejQocmuR3OvXS20+hVz7Y2TFOcK95tlTmml/Q6KQkjpyjY4+MiTEFcFFlJm5JNRX8r02u+r8y1FLcj9JRpeTP7lGA8Ui4gCYfYvW1EKc4Xtl1S/a5FOgwdq4SX4BThNrwC9FXO5TUierKz4KzJv8ndwOBeJRlGunNBOA3crzBVJybVHvJsbeQdolY4FMK0Hz2CMgPPlAS+ipvuMnL2+TMtoB0P8qK+QE5rt9NpCRjN8jDVmvq0Jtug7z7guS7m/5JryjKKxBU/yiJRoHyYT1jvA0eCszDbDy08JUeeZ1S+FxuS9Xk8xP4uoMrWj2h59JGs9r1EdT5yL2PA6quHG+G7CpIxPHVSP3yHqA4UfXE/QIJUywbslwCOZDlvu4sl7qdJLVaqbaveiIjm283sxan1W19KaUh42OdQLPKI0WigL8agHQWNud926i+XRSg+f0VvdD+dW4nhAX5K00jY/PDQ9O4SCY/a9yGaAfjW6GnT4I1ZYx9FZ7VwCsqvz4pTmXXgmPnUdfCZ3sHdxF3hDZf47qHqOBebquD9/WANTqvcoeUQY4MVEDpR8ioreGYAYcGGrQK1fKQD7zDhmBeFkmD7BKTUSZvmalL4vxO3G6lWeWN+srdWPC0ZsjNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXYwWWhJV21VWnRMSzlaWStWa1dQQk5pd3dpWE9hK2pJQzJlcnA0dGFvcGYv?=
 =?utf-8?B?aHV3QTBKTGp6YTJmbTJCYkpBZnZiU2psdGJVeVVWK0ZvdEtHMlFZejVieVJl?=
 =?utf-8?B?aGNQRHB3OTJ4T1lSZHlEb0Z1OE44aExDR1VaWW8yT2lod3luTDlGQlJrc0RZ?=
 =?utf-8?B?K0ROV3Y0SDJkcXRhT0pJTWEySmhiQTluMnhGYWo0TmhVaVQzTDJmV25nQm0v?=
 =?utf-8?B?L1FvZGdmWEd6NXE1QW5UYjNlaGNKcnhpcVhPNldJNWtjdEc1c3oyYTVwakF0?=
 =?utf-8?B?STQyY05PcU5wWk0wY1pXelJLUlhtZUpJRWpWbmlPQXdISjR2cDdHeDFBVGlp?=
 =?utf-8?B?dXhTMW9LYjdxKy9KcE9JYTFnclcrYy9sNTFKczh5ZnFQNzBqck9YMlZsbjRM?=
 =?utf-8?B?RE9BVFBFVGtXZkhIelQ2WTljdktyNVdTcmJTUFZZM1pEOTB1SXhZZENuUE5W?=
 =?utf-8?B?WkxuY3MzZGVGbGZNN2huYjBIZUdBVnozK0t4L3NsQzNhOWI3cEljTkdOOXZC?=
 =?utf-8?B?K2twTExSOCt6d0VLb0s4Zi9tb1JMSHhxSmthVDU2WC9tbXAyK01qUnA2bnNV?=
 =?utf-8?B?aDZzUDV3c1dsQW9XYzljQ2hvZ0E5bUxha0l0aEcxY2FXREZNMVQ0UTdaU3I0?=
 =?utf-8?B?eDg0eDRNVWlURlVsV0tLKzFXZXlXMzQ4eGhIMzc1NmNoOWs5NHZxam5GckN0?=
 =?utf-8?B?R2NLWFQ3NVNzN083bEg3K3ZHWDFrSXBuVlR5QkFQaE5FRmptSkNqVmJuTGZl?=
 =?utf-8?B?Z0tPUnJZUmJkelFUZFBWTUtRbTJBbUJvSDBzeGNVWkZiWHJUTEdkYlBLNEtp?=
 =?utf-8?B?YTdLYWpXV1pRcmxXeEhhUXBwTjBYQVBBNVNvS0Myb3VwSlNFbmlSUDF3Qzly?=
 =?utf-8?B?YXVrRzdoN1Y0R2trL1o2T0tWL2FWWkZSY0liUWNsS3pHbTJDM05pUFMwakxT?=
 =?utf-8?B?VUpCd3FHYXBGaUQxUXE3TFNUU09XK3dUMStUN0ZSd05wRGdKanVNelhmVGQ3?=
 =?utf-8?B?bE9DL3R1WGVWMGl5MWJxRTh4RkNpckltRTFmd1dRZDg0SHpsS0FENWlydll2?=
 =?utf-8?B?MGpFSytvNW9wb0xmMDdYbHBiVytVcTRIU3FSWWxMWUt4VTNYWFRCTGJONjU5?=
 =?utf-8?B?cWd4OGxxU2xEbzZMSTlqc1ZkYkVUeWJ2aWFHS204YlBFZnBQRSt4enNoL29t?=
 =?utf-8?B?ai9KQkNiRjROdlBXbW9FOUYxOXFnclN0bUNrdUpKaWRPc0d1Mmt4ZTZtcDM5?=
 =?utf-8?B?SXhBZGZhakZ3TUVENE55TTA2RlpjMEo3Wi9XYmZrVHB5bkJJaG5lWTBGRHQ1?=
 =?utf-8?B?S2JKc3RFM0RoNm4welEzc1p5bG91NkNML2M4RnY0SXVXdXA1ODRBOVUvUVBy?=
 =?utf-8?B?SW8zajYvWjhWZ29RbFVvOThDbktITStmSTJvdzZ3YWZYRGlLT0o5R0xBUVpN?=
 =?utf-8?B?ajBicXRWeTllOGtVY3ZMMFhkci9QTkprenk1ZU1nK1RLSDR1SGhnQlc0Z1lR?=
 =?utf-8?B?c21BczNDclpBSGxaTkw2WkYrUFNieWh6Mzk0c0FoZEhrcGtibXZqRlNjMk1N?=
 =?utf-8?B?S3hLMlFTaDNwWmFwb3JaeW15NzhJU2ZGK3hTNzAzcVFLZnJCRDZPbm9JYThH?=
 =?utf-8?B?by9DMmJlK0dWS3paY1cyWi95c1U3bkM1UkU2RXc0MkZXY1FzKzRQRWxwY3Rt?=
 =?utf-8?B?RVU1VkQ1MFZLaVJOeDVOQmMvR1hOK01oTTRiK2VWTEp3OWRjWjJ4UG5oV0lO?=
 =?utf-8?B?bCswOEJFalFabVhhejBWR2N5a3dEd045N2pUamUwZ251dEhiU3FycFJkUTlG?=
 =?utf-8?B?Nm1NZFVuSlVaS0ttbVFEUXZZblNpdnV2bnN2czlZT3dQai9mVGR0djBXMFdM?=
 =?utf-8?B?Qjd0SUQ3b25zY0VDZlFPdDU5VlMzdjVrbG5RTnRhWjVRVGpid1Z4Q3kyLzU1?=
 =?utf-8?B?N0lyRjdpOEpZU1NNRFRObENveGp4R1ZmRTNyTFlnclpCRmkyZktVcDdWRHRr?=
 =?utf-8?B?ejBhd1N4N3lpeVhtSitVS0dvakJVbTd3UEZ0MGwvZFkyb1I2dmt6TGJKUFNO?=
 =?utf-8?B?U3R4TkNIUlR3b2l1aFNtWDJOMXN4K1hSRVhiaWtKeGhHQnFqU1NKMXdzdGlI?=
 =?utf-8?B?QTNaRFUwZ0N4WmxQbWJVN2t2MVNFQjV5NXRDc28xNXArbjdoMUlQTFROMHE4?=
 =?utf-8?B?UUVQRE1iN0RLd2tVcDdvcGVDUGUxUDg3NnlVRnRIZUZKZ21JMXAyY2IwRDE0?=
 =?utf-8?B?c1dpVVFTcmt1YlkrTXAxZW91dnMxNE9ycnJ0WFZES29wdWpPdllwbVlycENS?=
 =?utf-8?B?WHNiQS93YjhuT2tTckk5aGVqUnBXQlI5bjRzc3FKUHVNelVCVVlWVnNMR2xK?=
 =?utf-8?Q?1wLfqA0FyELTlH7A=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76809b0f-e514-45c3-da69-08de7de8edf1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:34:11.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wpsukch3jshzLR4cBS/XorU8HtOWI/kIt5l8rnTrfe8I3Io9OQ6jalIVA8NOunON4B7uIw4ozlS77xTrIK+9TTh1AWsEKgxeA2omi+AdcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add compatible string for the interrupt steering controller used in NXP
S32N79 SoC.

The S32N79 SoC differs from the i.MX version by not implementing the
CHANCTRL register, but otherwise maintains the same programming model and
register layout.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/interrupt-controller/fsl,irqsteer.yaml           | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 5c768c1e159c..13cd37bf48e4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -12,7 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - const: fsl,imx-irqsteer
+      - enum:
+          - fsl,imx-irqsteer
+          - nxp,s32n79-irqsteer
       - items:
           - enum:
               - fsl,imx8m-irqsteer
-- 
2.43.0

