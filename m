Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32CE3BED46;
	Mon,  9 Mar 2026 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066864; cv=fail; b=NQniVZTlA1oqmheA8023m3LY6kaTlMwjkEokRtKehp0GweH1KaE9d+OG+cMV7XxJxAb0qaRf3SqlcRfBzAgC1EP2qDOsVHsNBKfxF2TEGVI/+yrOHXs7iP2qNNM9Kr9RmD5IiIk94pCN14qI1VtfhFttk7xUgq4Ws9cNXiBHNhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066864; c=relaxed/simple;
	bh=fAjnDLiq/9UDa+cdypIFe9fPmQFvWXDc5GmEkgQvUsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGOm1ouYXRGv7hZaDVV81aOAIeKJNoO3NShjr3bVAuHKhHYrwDWX8oMR7lFe42Pp52PBxDv1163SKFkIXdXt41wWReZGkJTN8/RaoPVaemAkWD67ASHmCFrsAF6XnAo1mvswE4Gv/k61addlImqrNQr5DhpkW3y4iu1JVtCHjk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xFtlmKdu; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xFtlmKdu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHosED1PrnweHz24Ay1DRn8008AuJsiPplAeiySn2AsoaS02s86r/pb6U+EyC6jLg9n39+jH+gkEHNCafyEBeLPW6SLiiZ37wJy4zagb9uXrJOY0VtEFyFdHd14rIwbnCiLo0SvX/tQLuBDyvqsq+RrlS9k7yOT2noroM0iFb23cfiWNaxpYa4d3lI1B1a5plC1UM/cT9UUReHqbwvj8xVYWuRVZcg6Ww/Ij0gWoXMWZMjjv6P5mHRbWw+/NbeZOcbyxjc4EBJF5bhVioPqMHJGFF4h0mlTOWDeDc1VgJ7LqoDL5KAXBWeez47IuioP1qM3yE9UcVnNzIAY4qSpN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXk8BK1qkdnln5l3xtWlgdGdnVyboSfDc1hrS8iqkVI=;
 b=ltaaIgXGUXqUPNh1QnHicEwMW26Q0aD3exXjHw/7Zli0BdGVYHa0YeLgi5bUNZPun8BtYD6EaRPSxG3E7Ng+WMMCAZqXM2hhR1SkctpOK00YUPL0UelUwOKQ1A52mXMgIdV/FTwhcUmLSEynNJ9U1sRna8H4q0/x9urhGShcWOEYnFmDa4+JXZpICa587EhYAeLZ7IFthRTHZ96+IqvIZzmSs/BWiaBJjHZYuPAOGvsG4iF1zAaVEMZQEErc43pNKlbJaojv56hhUBbLhyY/i2AT22MV3SLkyKcXsanGCjBPbESVturgM6GR5wKV2gLhCJPoVqgW41EKG3D9fjE3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXk8BK1qkdnln5l3xtWlgdGdnVyboSfDc1hrS8iqkVI=;
 b=xFtlmKduJVRR2r1Y7i1Gzlg8QfVhqK4j9DMhKYyAApotM5SOhj1v6S+2oqqZtdCmAVr8y9fy7lpxw+cKqc1gubXw74oGIGHOCcaENPIm7OIYaagjAiePZCas9AZcOdDqZo8GTc6mMfcqZuVgbPBflO7t+wISbvPj/juQU0aCsqorBdYulyK0eBeS4nvmClXTIyRYepuFpkc2OFniqrKIoP0JXi3uT8Cu6ApRvIiCnKvCTE3pLcaIeBD4NyP5hsMTw43YTX8cDOrWAFShnC9grz3ir3/eTXM0KXnfSDuFSH4xhubn2vP0fP7sJk0CNSrl8sScPzBVgQRwr04QROI30g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:34:16 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:34:12 +0000
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
Subject: [PATCH v5 2/7] dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
Date: Mon,  9 Mar 2026 15:34:06 +0100
Message-ID: <20260309143411.8231-3-ciprianmarian.costea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6823fcbc-0300-4fca-ab32-08de7de8eeca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	M73FITJ/KqBWxB7anwR9aSDax9oy35z3h2XIvC2/FNmgt1ZacD3KnFK85+OZ8HbsGG0z4SlYgjlGrFdfvkdN1yDCPkFd2pxh22Y9EzwVPhpaLfjFaEEW3H8vMy3dgAwhkUI0g7yOVsk5QFgaAF5gWd1s+/0Uy/7ozj+9z4nV9D3f30Wh/Z2EkBoyFMJz2YVJCZuiHDDvLM1HAtM6mfybCp/j8SF6cW1YqPr+tvOZGyIYDwmL57JltpKqn540APpMup+Bs7c++GReMVUBEumTfXJOM6i1DkhuASkOtr2Uw32J0UeChZO9sSQHYLxAcRJxSz1SSFltWtZrkCzraqXMer9UEJALLteFx07QMT0ldIji3Y4E3Ked208V0riSGQWTYqWIfWI3X3QavRD3SnTBV/71B3fyPRfmaS0vyFxfKZwhtGrNUVSaoGjbrxud/cggJWg9s/lSvWPCCb35+MG/p+wS5kR5UI2qSzRr+RNQzSGBxxyo/n6EnyGMKfPgm9NifkPUlX55cTX8bFr9h8mOfFEtxfAbc1MzvNM5Yce809I+qQh+4fiOpvK+uoaigBjjL0ZifWNUG62hi5omGIZxQjTZOtNXueG1WWhIhUpq2/C+X1Kw/yKNs+3V6a9UZp+KtPRLofbqAxph0VwEg8f392Fq0VTnxMW26cfw87jBkI2AUgKpBfWObEj2EC5LwrFMznLUMKfk2zgO0QypHxBiMWg616DxbD0ENZdc6ZoTMrPREsH15b4zfBFRL3wQF7MSMiRNss/sbaE968EefozzlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czJGWUYvSiswVnZVQStxL2hRbFlnejRLSkUyVlNWRjlsMFFYbEVOaUVPVzhB?=
 =?utf-8?B?akdjMXBJSm1PM3UzRDk2RE9Sa3dSOFI0T28ycjd3ZXVyWk8yMTRMV0tpbXZD?=
 =?utf-8?B?alA4NCtFajJBVENCME55eHl3RzlZV200RTBHSlZJTVdvVXAvdlFBUVZLbHdu?=
 =?utf-8?B?clk1SVZkTUw2NWxWUE44cklnUjR0YWl5ZGUwYUkxbHo2Q1NkTUd3Y2VJbWxl?=
 =?utf-8?B?c2liTW5xanA3RmFGK2dNNEd6eEg1M09wVVUrYnZtYWtiSGJsUUFXVm5WZm1Q?=
 =?utf-8?B?VDNmRHBveXVNM2tpU1NkVjR6QUNySkxvNmtqMzNRbnFXcnptUHE4OXpIZ2wy?=
 =?utf-8?B?OG8vOEt2aGV1aXB5LzQyQXRpbU9XUkU4aWV1blp6Zm9qcVpvUnF5OXpPWVVC?=
 =?utf-8?B?a1lPbGRlQWNnR2NmbS9tZk52d0k2dE9kalhTYkppSHVQQ1BSTVdjRkFUSVZU?=
 =?utf-8?B?UDZ3S05jclQ4NU5hbWxuSjU2Y0dEbWFyQnRDTS85d0EzT3NXSjZZMGF4eVVD?=
 =?utf-8?B?YVNGc3pxS1J2MUNkc2gzOGcwTnZ1Sk41VWVnY3RLTldwZnhnNHVKL0JIemZY?=
 =?utf-8?B?aEU1SGhDNkV1SHdPMm1QeXoxY3JlZGtPMVV0dW03TGd3SERReDBuUlJZV3ky?=
 =?utf-8?B?dlE3aERWV2tiV2RHVjQyWXM3TXkwQXFHV1VpMllzUUJXWVNlZWN0ZDNVRzBm?=
 =?utf-8?B?ZDViNEluT3Z5V3ZpNkEyVjYxYUlkbmV5aTZNYm9jRFVQeEE5UlRheFI5MDNS?=
 =?utf-8?B?QjBDcmpkMkJ5Mm9HT2JaTmI4N2Y3MkpKd1lWcUFBbVNxMXhxVTM1N2JySTJ2?=
 =?utf-8?B?SlExZDVucUR2M2E5Ulp4d25aTG5wSnVGZTR4R3Y0WDRkTzNLNVZ2MSttTjJq?=
 =?utf-8?B?eUJrSUNabDVNSEs4MWFoY1RpTDR1aWtqc0FQRkJzRzNDWWxOUGltSlY3bGJT?=
 =?utf-8?B?cHNrc1hoeDBab3NxZUdySjZTZUwwdEl1WlZ3V2x0YThrU1hQQ2llVHZIWlZq?=
 =?utf-8?B?YXo4M0cxYUZVOEhleVFPSjFxcWlDRlQvTHRGSUlJN3p0RmVrTnlZdkx2b2hE?=
 =?utf-8?B?eWxNK2FyRkhPU24yaWVyVWxUSnBVcjk3cis3MVhqRmppWVN5NnBBUDlOTGlt?=
 =?utf-8?B?Y0NLMnZPQlRVb0kveUFkMFVNR2d4U3pnMlpCVi9GU0tEeGFFQ0E2M01sSGJK?=
 =?utf-8?B?Zi9KbnJVd0F0d2ppZjdLTU15aVkwN3prZ0x6RFk0c0JVRnVZNTlpeEVjN3pn?=
 =?utf-8?B?WjdpY0FuQ3Y0UEszOGZSbzdTcUxHNHBNU1B2Nm9Oak4yamRqWElsNktrc1FJ?=
 =?utf-8?B?TG9GNHZkR29CeVJ1dE9zbDVFSTFWTHhuL093SUFET2cyVkJvdzNzYlYvNGtR?=
 =?utf-8?B?WW9uellpOEM0cnVzTnB0ekJCaTZQSjFaNkM3ZmtWV1hSTnNNRmIvUkF0ZGov?=
 =?utf-8?B?ejYvcmdZRS9QU2xqcWtmYnlWLy9Mc0VLOFlGK0R0a0thL3ZBd3M2NDlHSXZo?=
 =?utf-8?B?YkxFOFB4bnR5RGI3K3E2eG9kUDhKM2tkZW03V2FjN0pRakoycVdjMDA0eGRP?=
 =?utf-8?B?M3Z3dC9FVGtBanQ3ZWVXNWdXMHdjZW9iYmR0NDdMaXQwNmZ6YUtObGNvTFBu?=
 =?utf-8?B?QVFqV1BYWlU3Tzd1SDl2V1dFOFB5T0J4UjJmNFZ5Ly9XcGd3dGxzVEM2ejR3?=
 =?utf-8?B?elJVbEEveW5CT1RKRzNkTWJwR3RvNzBFMjlUT29qaXNrNmNSK0Y1aE4rZEhM?=
 =?utf-8?B?M2JvYmV0YW4zOGpPWFdtZ2Uvd2VyQTJiODBoTzhqN2lUeTFKV2YwRDFzemdq?=
 =?utf-8?B?WHdlUmNvK3NMUWowK0dsM3hRSG9ZMTZMSWQzWVlqOTFTeGJQeXhCOWhzN096?=
 =?utf-8?B?bDZ1ZzNDbWFtbDk2ZVZNZkpORFNsckJXRTdwbFY0YkhqVXNIdG51cHVyTUQx?=
 =?utf-8?B?SU92TGhKa3lEY1hWSTliN25TUHZiWTdHKzFLZlZxY3JjZWhSaVRNU0hmNTlN?=
 =?utf-8?B?VUtWbjUvQ3N1dlJVeW9hVW5uZGM0bzRIQk56ZTV1M2lDQ2JEZ2pDT2N2d3FD?=
 =?utf-8?B?REZuSHdYNDM5VVhaMHhkRlBkRXE2YVJFelIzV2VnVTNFNUlNRHp5cTByQ1Fh?=
 =?utf-8?B?Z1hUNjl2UC9JSjdGRzYyUTdUYmtQSXArSXdGcjlQaFE3c1FhZlBKc2wvemY1?=
 =?utf-8?B?SUdSZVhYMHdQbm50UGkyUDNCUWNFdW9VOEF5a1V2NWs2Tjd3cEJQWUN6V2N1?=
 =?utf-8?B?SXZMak1LSTk1QUwvRnFsSjJxQmhFNEVtVGFjSDloUXlBMXJoS1V4MUlYTWpi?=
 =?utf-8?B?QjRKNWJLSkRlMHNBU1NkTmhFVXJpdnl4RUNOUWk5d2tnbkJYbGw5VUdNWUhU?=
 =?utf-8?Q?yiiXcbS4JU+GmoEM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6823fcbc-0300-4fca-ab32-08de7de8eeca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:34:12.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxnhdDRHDFIsvFqc4FH+agxoLBNqXc/YEHMQO6bJK5Bm2jsGh6mNshCpNENFR8twXaaSJjFJ/z7uxNL7nL9r9Hgqa5v20hRWqHc+fC9hxCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add compatible string "nxp,s32n79-usdhc" for the uSDHC controller found in
NXP S32N79 series automotive SoCs.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

