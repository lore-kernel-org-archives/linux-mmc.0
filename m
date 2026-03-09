Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE13D3312;
	Mon,  9 Mar 2026 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066865; cv=fail; b=X8G8ymUyyczxpXlHP9QoCuqzxY/2rmZflixxJ86jIuTNnzd9ZJG4p53jmABtUHoNcEZ+NB92huBLYpMCnI4PeR0k1sXBWu/PBrH/GLHGbnIuLanBTH0ITi0IeRHFovGpuQ0WlXpy8gziS28mEwzAwfI+3VVNze1Nga53AY4ljAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066865; c=relaxed/simple;
	bh=ILhrfO8Efp1nLHwQHSPOvckZ70QBlinth/nMKWLrXxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCDWNh2sBZUO6xgNO9DUf4yvCLauCApiNzuklqM6HQ+JrNI4jOWA0Z2vuZxS421J+UUslE7/fRj0mfHxN2Dsdtge9tiLKAO3qpbupud/dIm6eTuQ2Gl2VHbkitQQ9S3diiW7uQOCm9OQonkSbgk9sDGX9F+lljX9YU5L1/MGHB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WwySKt+i; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WwySKt+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9AyPYBYN/2xurXpwNz3U3vmn9xOJ1/WnQInYg770uXNSyi+7Le/m25qwYXJjx+eLveAEs+FNvqRCL34DTMYeGyI3pNO5OA+kX66K7T77UiFqCU1Ja4xsuUcPSYVTKjr9WJE9SOutmIekfqBdEMtmav050Geuzou4/tzY8Dtna2h0piiHSRtYqmsJaYrnlllQSsioG7NY2kdIiY1Np+HKyoEPy8YNTURkDd5oMbCc1m1wUTH1F4y8plh0zDqZ7y4aeFlQLzTMYgKo5r2UwFA6uey2XN4FMqBdgK0tFIG2L+yWGoE9osVA/jL0DFVMSE5afSviE+BnkCZciwfw29/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05BkJVEhe3gSrrR7zwNYJaYt9wji3IaWLx52seYSMxM=;
 b=ALgGLHOC8JPw/ZjCsgZj3cPhLvQxWUpb9hapd2yGGPsnzyo4lFeWVAjG8g7lCPyKGL6n59qYOr/jaPslELorQse3m61tLKsAR87XeNwr0WAohpzf61v33rhQaBR6i0j9tnrx0bfWos/PvUoT3uDaM9B/VRrB5eUmCw2CXuMeUZPnjxccQqNq1NqI8+kF+H0eBO0DFhYOAj2SN7FbvEW4BKpFvtjBExTtcZ8TqWHReQrLClglnRvQ140eD+GRkEh3GVW/CCrmkRzMUlqTREDz8ju6BMHguUa4DbeFpbqEPnp+Rz5KL/gAMIyxwWePyNNSXgOwymfrVbklyN+pDGbv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05BkJVEhe3gSrrR7zwNYJaYt9wji3IaWLx52seYSMxM=;
 b=WwySKt+isMeEW/PHdVoyVeBbxlq6XEYEEwoTNeDrN7w64CaKH4EG4DJo2njUuyya44FWsls4BVhRBG3UiweUn4Lvt36XpdM//JMDbXbhfSlj8uQBqowAZQ/6Vr+t2fX0FuWszMFt5+I9PguvbXUotM7n5iCLlcdt+sd+k50wOTXuWmlbMk+OseMfTSEMFe80uJ9rsUaDy/lC6SLqeZNNu3jneozUNv0cnV2dF1vT9zyJSKRlDOR5qJ/2xXm3Fq4txmqkx72okek5D3JB6XEreV2159TakO4LOAJ6Udy+pT/ptgiWi/tkR7Do5fY9oeAHB8OOMkn8EUHiK8nOzaEVsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:34:17 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:34:14 +0000
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
Subject: [PATCH v5 3/7] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
Date: Mon,  9 Mar 2026 15:34:07 +0100
Message-ID: <20260309143411.8231-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
References: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 31c9fde1-0e62-4260-cd35-08de7de8efb2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	EE6TOTEjvdKNGLAI2M4p+BZPbCDiU+96cmp/Bxgmnpuai71MdB8Bc9m0IoH7fnYSaXN6pJeG5FtoCRMp9TvN6sPjsEDAV4AxFjqnKYPUdMdrgQgwxkbz3g38VLzUslMc6f8EgpmncKQS9PhYGzggMvFgzpSCaIQ+9cD07nIHpnVzqjO3sRIjlnnPsZR1tfCBMGv1aB2KB/AgApTxYfJBSxmtQ3AVQUb1teonk7XYWah7GcSCCDrTVyADTBZhKzFDYjAybo1QYqUPJAS8u/PE8rkdigW4QZRsTnfweWsnEiOFht5AtX8JT8mL2EMMf6O8w+tzMjCo9HLFDZlULVXHC0jJivGeBfkGVYU+ag8nHHRsZNYJsqsOg0l24h1GHEt46gYcxGuViz4iZLcXjO2oGhX+UHZPm1v3O8Aqp8pzykYNUbRB3GOATGSeUf9uNOePIIL9QBHeg1NxzkHtJagzLLa+ZH0VxjmCNfe324vu9MVxw8EskkgZ8wsyYeGFoigllSbiEK3H29KNJ3GQVt5ErxY0rUjNuzCFbpxIpxfREjb4qBvZbBodNquziirc2PDE85iSkYX3cyedqt2ruFvgkDnZGU+aP5xmjd9JV8rtqsw5kqfJZm2eXUfVpevQbOw8OdsHbPNUKVGuYSXcVsKqGXkA/q6EXG+7IAW2w3h0MKOFQBQju1QmuJx4eXt6tQXNm0V4Jhx4d9HeY+HTfMYyRbDQy+kv5dzwvj+tAD4LL76+7u3T84FySltoFsbowvUaHdBz9s7mD9Ffk2M/SyoD4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFd0amU4N3ZWRGE0ZkY1L2p3L2hKREp2TEphWCtDbnpleGM5dEI0RWJYUFg2?=
 =?utf-8?B?MTBEcTZTbng4MWg3VmF3dkFpMUNVRWlhWHdTaWtTQUU0SXpJOEtyRmhrUnYr?=
 =?utf-8?B?OFV5VkJ6Mmk4eGFtT29ROElOOVB4WG4yN1hWWDhObHJnUHJZQURsYXlUdWl6?=
 =?utf-8?B?OTEvajdqL2M4YVJYN0JVd1REZVAxR2NwYU04T1NCV1grTzN5eHNtS0xnK0Rr?=
 =?utf-8?B?NjVJZ2I4YTNOaVZuMHQwb1RseWRyZWVQZ2huTFM0ajV2aFQ1WC9Dd3R2eWZw?=
 =?utf-8?B?SVZiNVBacTI3cmFoUFFzSEpGREhWeWJyQ25lNnV3QTc4V3hSTklNN21DR3dz?=
 =?utf-8?B?VkVnR2Y2bGNpTkh1dEF6SXczTjJFczEzZGgxMEQxYVNyZXRpMWMrWnkzVldk?=
 =?utf-8?B?a2ZTWHNwUi9LTjh2cUxEOFpRdXhoaUpDVFMyQXo1cVIrV3MrZGJieUhJR1E1?=
 =?utf-8?B?bklMdDZWS2syNitXOXB1UkkvbUpDR1loT2YvL0FaNHA1Ri95dmhkTUpuTnU5?=
 =?utf-8?B?aWlxY3lwTm9mTEptZmF2SExLekk2Ykg2dWFWQmRObzA2UzZTVlBvVEF0MzJy?=
 =?utf-8?B?blQzMmFGeVRhUnFNL2x1T0Fvd3ZmYVdwc0VaN2xrNlpDUFg2KzRVS2kySkNy?=
 =?utf-8?B?Q3BMSi80aGZIYWVKdnY4dDBWY1pQQXZKU3lmQXk1RDU3RTAvbXZoZks3NkpC?=
 =?utf-8?B?c0JWdG14T0krcUNYb2cydmxnbC90ckRLWVVha21lSHo3RnUzeXV2blNabkRh?=
 =?utf-8?B?NStFSGdxRTFOb2F1bmNYblVFRmJIREhnVUJUbW9zM0k0YXI5bkNNVkYwb1Vr?=
 =?utf-8?B?RHdtTDlnTlJ0TG95ZUhtZFhjN0RmZ1BZVFI1TXZRVDc5d3hLemtoRktIMDh3?=
 =?utf-8?B?UFI0Z3BvWFdTMDA5c3E5NERYNGQ2VW4vdFN5Q05QYk5PZldSTjRMczhHRUZR?=
 =?utf-8?B?M2tXZVNoaUdFcnk3RlZmWnFHVnNyd1pQVTJFNnBhaDR2NGNjd2h4bWU0c0s5?=
 =?utf-8?B?YXpLV2ExR1haN3QvZkgwMUN0Qm1xYmdJRjZBaWJaaUtkY2oxUHEva0Y3MUJm?=
 =?utf-8?B?YjJMSUdjM0xkUlhYTndCY3RaOWJDblVtT3l1QndReTluYVJKdDZQRnUyeU1E?=
 =?utf-8?B?akswclIrMnFrZk5iQ1UxZ2h4VkNROXNoMGEzYkU1N05MRHFzNzkzdU1tRy9m?=
 =?utf-8?B?Vlk0b09VODdwRjBrZ1hnT3ZFdWdPRlpHajNpbUY0N3VEZmh6T1RpNVpJS2RY?=
 =?utf-8?B?Q2ZtTjlKTm9mZVNOQW4zcTdkYVBlSjJhTjJOVXcvckNuQVNrU1d5L2dCK2lY?=
 =?utf-8?B?RXdoK2VXUjdGNjloc1J3MDdiYjJac0JjUEtjS21yT1R5bG5td0N5YklHdW1O?=
 =?utf-8?B?MDZiWkZTZHZoYVVVbSthVnF0K3FIN0NPVzhOdExrVHlhTCtsS2tXOXlySElJ?=
 =?utf-8?B?NkgxTDd5NXR2SUdGOE8yTU55c2RGOFB3VDJ3S1BFcnVRbm93WTVkV29tRHZQ?=
 =?utf-8?B?Z0lDekd0MU1zdG40dlIwcXlxTmRPVVd6TjVTZTJFakhuMXY0Q0hlekZBTmRQ?=
 =?utf-8?B?bFhXZFdSMEN5RlBodnMwbTB6cE9YR0hHS3Y0UUxWSGR2TDhIbFhkbHplYkdG?=
 =?utf-8?B?YUE1MzdJMDBONStYK1hGSnBraGNsaUJnWUNnMlRmd2lrdytzOWx5cTN3MUZi?=
 =?utf-8?B?UncrcjRzQnVvM2NNL2FzQUwvVldsTjZ0amlLOHQyZ2RvY0kwbTVnNzNyRkZj?=
 =?utf-8?B?bWpZdWlPVVEvZmFYek1Kc2F5c2RmZThsLzV1c09naUczcUQyaVBVWVVhdU04?=
 =?utf-8?B?RHhCWGZpRmY1NFZkSmZCeVp0NW5pU24wYm85S3o3K28xMHNjUDJmUWQ1NWRD?=
 =?utf-8?B?cFJKSXhDOERTRFZlbXIyYWw4VWFuOURlRituRStoOWVlcnhFWHVKbE1vWjA2?=
 =?utf-8?B?aDlrRVkxdlJ3bGNTS1MzQ25JTDZHMjMzL1lXY1dsMGU3MGhyVDgwdFlhbVRx?=
 =?utf-8?B?ay9qM3FDZnJpaDZPbWI4RWJDSkQ0RWZ5MVFDSkc3VUI2Q2ZTampyRm5GVGRE?=
 =?utf-8?B?MGRJY29EcEt4NlZoL1VlTmVTRnVGRlhUVlMyWW1NR1ZSdTBsdjRnbms3Kys1?=
 =?utf-8?B?NFJWMGxMaUgxeFU1UUJMM01mVWhpODI5eVhDcW9sNXlNUTlsRGs2L3l3Y2ZH?=
 =?utf-8?B?eEVqR2tFWVFrNGdQRDc0QnJybW5zdGZhMkZEMGl2Q2ZaVDlEOHR5RDVzck9m?=
 =?utf-8?B?OXJoUHVrS0pSVUdNYXpRNk1sc1dpUGRVRGdZSHNrWHJGOEI2dEFZOFFLeGV2?=
 =?utf-8?B?RUlheXN0TUJ5bGVEQVBKVUhiTXowVEQwc053R1JJeng1SThnKzB0ZVl6VXI5?=
 =?utf-8?Q?K+SzRSBRwIo/LJM8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c9fde1-0e62-4260-cd35-08de7de8efb2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:34:14.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAbdgpc8SFrLdaxEc4Xm8s2oO70eohJKBWXWt0YVk+Jk3ofsYxxPantBl+15qAJtFFO1SNOvzhhBk8GMQ/3ccXQYiKBKdl07eaO7OtLBDUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree binding documentation for the NXP S32N79 automotive SoC
and the S32N79 Reference Design Board (S32N79-RDB).

The S32N79 is an automotive-grade SoC featuring eight ARM Cortex-A78AE
cores organized for high-performance networking and gateway applications
in vehicles.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 5716d701292c..415081423a30 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1827,6 +1827,12 @@ properties:
               - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
           - const: fsl,s32v234
 
+      - description: S32N79 based Boards
+        items:
+          - enum:
+              - nxp,s32n79-rdb
+          - const: nxp,s32n79
+
       - description: Traverse LS1088A based Boards
         items:
           - enum:
-- 
2.43.0

