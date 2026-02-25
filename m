Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B03C196A;
	Wed, 25 Feb 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026755; cv=fail; b=HXuKz61UIifAtFjd3lOckZJjdac6ZWC301IcbBCiHwW8pDWo2Y7OpySvXUKFjvaBiyaWXoHutLObkgCo1eQucomqn+N/qcNNpQLGyNAobAkhhpwoGYbinz19DsdzyLBTxt2open4AmEB7OFqlicyxuxlx7CxTkVGZF8Vx3t3gIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026755; c=relaxed/simple;
	bh=QiHb4JIcMzBgqtOKXT8cpt2Sz9PNgNu2kirDG0ni5gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/PO75M56fcY9qCV1mOJaGZuugtM7ZqUzH4cU0NjWci+8u4rhL6GQlElpgMKN2e8Z2y9grRGGcWnZapS4FgABDqagvRGTkou8zaHdSpCkz/5JuWuo+H75x++7K+Stvqp7ho5d0mymWXsLl1MnlqDwnK2IqPvVtphxZCB4UXAf1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JExndqHr; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JExndqHr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmDLesOJ7/ZvH5TQrsZr9S3zzJmraNXPY6jueLVkUSamqp08zN4Wx0jeQZ9o4hKS90CpXF+SKsk5zgK0gmOq3XJ2B2yLrSip+a0SJcv/gOFI+ytbMEPgIu6erTVhNwrRyeAWtpGZRmec83T+ULseE4n9py/u49/3zXREqDZLC2RQHlcDsaNTaZ46DcEtf7QDeuewJJVLaC5VNBjXrUH3fcHNUQuik6E7qMZnXS9mLsZ0mMxyvgVP9Ciz4H7eH1DSvtoAo/4suX/YxEWk270N0wI1AO+N8NFFD7xpMLwmdGeZenRovfyZzQILHmVIl3gdJDjgqlzzLwLqXn9iQVm5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5SIS7GokQUC8ftlCPPmg4XbQf+sFIKPTSrqHAUeYX0=;
 b=CtQ3xR0HIeRG1ybfKPzYaIvJvmJGTJqrdU9qV7MKxRwdpyYVP+iShAopWfFmz1UrQJkB2gHMxzj1YSr2+HfPmsHuBQ/ovuXqrsdTHb7WlAV+Gx7PQ1AfUOBObTF04M1WtxAbnhkBBN398E2alD3YJCWUR8kDAU4+HO3p2wqBgIdskbgbLEF5Q0Qvt8TFp2Kf9G8Sa+Hj/CTwFDlt+zbV5RolBjiC7S+Nh4RkaodJPfjd6ViV4E6hAbdtV9lmARorxhd1kWvcV3SaPWP25Evu6Itff1RIRGFtNDWlJRsMtYxNlntoqSauLuvQXE/qqxLdCePmOBnSz1jdbV14p1rcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5SIS7GokQUC8ftlCPPmg4XbQf+sFIKPTSrqHAUeYX0=;
 b=JExndqHr4H7K8Jq0t2q5vLY5H22HfcY/1A2T2G0Cx5Q0bkACFjFf7prrzvfebob0YOLUnU5nxepdd+GLY8GwbZRzX/Ns2zQV1T+rrpOv1DkKG7b7Ez/AWYF1WNaXTYkYeup0VmHyiOJLqL7fabaw8p2N1ZYKZaZkAaKHEqDM4KCOlXIQ9rsxH+dDAAtrFgCu2ugc/th3wzchgpZnxvWkFyMU83sqeLr/WZTZvh21oQg2wMcT2IZ7S9m6sndH63bFeaQ46qOQXewXNIjk1w8d8QRrnBs5eco2qTfAQeRl9Bx7WahG2Obb0HQv1EObpGPMxZDUd7ELLDHw7E0EFDG2sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:39:03 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:39:03 +0000
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
Subject: [PATCH v2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
Date: Wed, 25 Feb 2026 14:38:53 +0100
Message-ID: <20260225133858.8026-3-ciprianmarian.costea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 193cecef-d9be-4884-16ca-08de74733d7f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	XGbGjeY6sV/9GaVG00tmY1yoH1tS/DaUjm7D1a0U3UmkQjAFBIJgEB7+tIQI/F95nFnYAdSDExWomILxdDYu37vg2JapRB9ciWRwrOGMKbc/rJUz/x8yYqsAJ/YFzGvIBsTRXfpAhvQsoDteUyOhVsSsxOhsI3b73LsP8bCWVmABxpYNMy2ZDyEu61TRTe8pCvnsc+w7tWovjMP8Ihp0Y08SvbiJipYjewRyN8aTmgpb161PGOPyPLK1gJnVO0e8Y7yvntOba5/07J6+b1niH+5zpT/zhQzWu9ShNhpNeDZW9NjirNEqKaZ2rW4YQHFmTg4BzHZ8yTpMmgVlyFuAvaxNDG7TF0fssKTMu/CEHDyvnnkpLKd/83C911ZAQUmqTeLiPF1I56ap2evQcZ7rK9f8Rbif06Snw8Dz2Jto/+fFspOh8DCvyRwFWrbjRmHJf/7/CEZhjF+kwOgeJR9fSdrVR2Q+MZRQSGegjnmdbhDEVeP28dR2hSUVWJfjJfJSeJ3f44JFvTjrMknR+EPeSK59cCQ2k94cvqzJ7sDYsiqMrzaVPj87PsYLRCCUK7qJt3Jh835hFk4WcKxVDXpHOUwF8fEWXif8u+0akp7g7GbHn2/pcSwplMaVSsdS03oUPwRjMbmfgyzNO4zVZ6T6O4/8AIPUu4IxOUm3zt1L4deztxGivbyp/Yx3rF7/05xkXvYWpHElkoaIskcCAlYqJOg45h+cW8Z64fD+vwE9mPr29zusFZCn9/WCViSYr1G0V9x1AP3kwJfFNt9E+PNC3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVNibERrSW5WNGc5TWhDUnozdlc2cGh5ZzdqcUk5QTRIL2pLVjUyK2h2YjI2?=
 =?utf-8?B?TWxIRVlTK2FqN3l5dXM4MDBCYjEwM0pybUdlOFpOTW45a0FkQ0cveksremN2?=
 =?utf-8?B?MDI2UVArSzdQSFZVSU1KN21KM0htQUllTHNjMGlKWFpUOCtzVlcycklsbVFh?=
 =?utf-8?B?cGVzTUlCRHZoc3hEVVFaelQrRWtFY2QrTVNhVHJZK0xubDhHOGdiM003eFN2?=
 =?utf-8?B?SllZV2hKRHA3M0FUWVduSGhNOUNuZnA5dnI1VURFblNQZW94bDBMaTNwWUpU?=
 =?utf-8?B?R3ZyZmNOVlNnQmhqWVJjQWV0cVBkOW5jajhlUzFIeEhhaVgrckNtdjhFazhm?=
 =?utf-8?B?dnV6OWJvL0VHWkpQamx1ekFrMXh6dDMybE1WUnpCVHpVempYTzJMeVJzM01H?=
 =?utf-8?B?enQrSS93a3dMUTJqWEMramFGbU1XWkdrd0RmU2Ryb1BON1lOTEN1aTIyQ0pO?=
 =?utf-8?B?OENxS0I3MmNqNk5FZmUyVEdmdGZQQm1KcnNOOXp1T2x1NEp6R1hsbmIrRllw?=
 =?utf-8?B?WmZUWHQ5YU56YVFDaGdXWGI4Vm8ySWVjWUtWUVkwNDArQWI5NXdkUlkyY2kz?=
 =?utf-8?B?RWpGZGJsbklQekZIZGtDaVZ0U2Jrd1JqUmtkNlkzNnZsTHFKMnM0VzA3NDV2?=
 =?utf-8?B?c3EvTGVJOWtPaTBrRzJSdU1MZ3lld2lUdWtEeEsrL3lmMUhZcC9IZC95N3dy?=
 =?utf-8?B?SFR6cUxiekE2T3lzc0dETE03aTdVTzQyR3dmU3VIeW8xZG5ESDJIckxRczFh?=
 =?utf-8?B?U3QrN2t6RFNmandJWnBOcmQwclQ0K0E5M2VwNG1WVGw1UXY2V1g1cmZNcHAy?=
 =?utf-8?B?UEpiTmJmWGVYTUxXdWhyS3kyak0xcTB5cU5rVUVnd2ZWQy8xeGdid1QzU0dl?=
 =?utf-8?B?T1Zpb2RFZEkwZWFnUVN0MTZpazUzRFpxb3YyMnEvU3ozSzRkV1M2U0U1MVdN?=
 =?utf-8?B?Mzg1eE1oczhhbE9JN2VLUks1Q1MyVW5KY0hHamEva0kwVDNSWHdzcG1aY0ph?=
 =?utf-8?B?L01HUVpLS3g2WitISzRnNloyK0U1WVdZZXBzNWhPREY4aDY0M1l0WFNMV2dy?=
 =?utf-8?B?OEJHQ1pPblNFVmk3WWg2M3VWalN5RFlJcWdRVUpYWEVnQk1rSDQrdkwzQ0ln?=
 =?utf-8?B?bnp3T0l0QjZnUkVXajlPRzZTUEtOTTB5K05yb1k0NWpaak12WjVHK1NaYktx?=
 =?utf-8?B?TCtRQ20waWFRSkJSQ2lQaFBtdlBaZ3h6dUNXYnNlN1Y1TEVzWmVwa0IxYnp2?=
 =?utf-8?B?dG5WU3Y1Mk51RG00aXpYc0lwWGdjTVBQTDFHcjZhaTNydmp0R1hjTnBPcUhQ?=
 =?utf-8?B?Sms1S21UcUNZcE1pS0JuQjdRc2hEWW1VVmlBd01ma0ZZUkNCR055T3dhNTF4?=
 =?utf-8?B?ekhMellGdjhBcHBvQVlWaUFBOFZDeHB5cGsxTWEwazhzYU0wYUZqWjZmWlRO?=
 =?utf-8?B?RFRzYmc0TkNEcU52L2hhNTRLRVdqcnBLMFNBVXpUN002SVgzVlFUSEJXZi9I?=
 =?utf-8?B?NlZJaTQweDBjMCtzWUgvRkRVejVPQ0w5b0R3YSsvSU1tTGl2SjdhZDUrcnM5?=
 =?utf-8?B?RHQrTUJSdHZ3SzR1Vyt3L2tiOWRiUmZyanVMRUVhbSttVlRuNVpNUkNBekVF?=
 =?utf-8?B?S09jR0tJZFo1OFpMUW1lQmZUSDVFeU5iRXB1dlE3QnJaVkduNjRsNXVhM1N4?=
 =?utf-8?B?L1ZQT2ZYOHMwdlJob1VoS3JYd3RUeXJwWmxKYkozYzBIUkpYSWtxWDUzclJB?=
 =?utf-8?B?b3FDdkw4eUZRRjdYZTNPMWFQeGh2VEZrSENPV2g0STBSVk9FRXVYY0lpaTFY?=
 =?utf-8?B?RXo3Vkh1K3plRnA3YjRKTm90ZExKQ0Q3aUxJYWNtaUxqR3ZCejBYU2ttVDI3?=
 =?utf-8?B?SUVQK09jd0FBcGhKSk1teUpyVWVKclV4ajQzYzQyZXNyUVRva0ZmYUMrazZy?=
 =?utf-8?B?aUZQc09tUm0zaWYyTG54aG4zaXBIeG1MY1E2ODRzOXJ5WHlJZ2VhTGRWYUtJ?=
 =?utf-8?B?alU5OUNsQXlYOVhyUnk4dHlJK1E3cWk1L096cEcycjJoVjQxcGZwNWNOUHJD?=
 =?utf-8?B?aVdTQndwQlBpWFhvN2ZCMXJoNndnS0tnOFFBVDJLNGNyVC9oWG5RUk85bzFH?=
 =?utf-8?B?OVhrK1dmcCtBTjNTYitadzZiVjF2c093b2p3bVJhNEc3aUpESkdzSGQ0Vjhs?=
 =?utf-8?B?SDVlaFM2QTQ0Q2NsYzQvN3FQOG95TnhYaXh1NkpRa1FRME9COGZrVTlBZTZ0?=
 =?utf-8?B?SWhpWmhkbzVUNzljOG1EdWxtMlVNQ0s2NVlzRDNBT2QxaGsrZlJEVTc3clBE?=
 =?utf-8?B?aHh2TXFtdkQzUy9IL29BMURGYkRZNFJmVmUvaC9sUm4yd0p4Qkp4QWIvUC84?=
 =?utf-8?Q?sfmPLdiu/WwjrXXk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193cecef-d9be-4884-16ca-08de74733d7f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:39:03.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD9a2wQspeTD3WDT+3MVtHZOT6z4lbMKxfcN3Z6JOyEhV44wgfK8EAKW//b4J3pBBa6BT8zWqquN8GTvhrxtsjTkrVL4B8pgSMvEUbaN79I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add compatible string "nxp,s32n79-usdhc" for the uSDHC controller found in
NXP S32N79 series automotive SoCs.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index b98a84f93277..014b049baeb6 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -35,6 +35,7 @@ properties:
           - fsl,imx8mm-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
+          - nxp,s32n79-usdhc
       - items:
           - const: fsl,imx50-esdhc
           - const: fsl,imx53-esdhc
-- 
2.43.0

