Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E313B5840;
	Fri,  6 Mar 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809922; cv=fail; b=kr9vWFNvfritmCK5v5ukcyZzYJJ/bZZpNcoYNNLyoTI/e1hwvi75SWL+qwEZdEJPP2E1ccPnUIJOWhBVKJSM7L2MKFLR43WL7QtV+J+G/gOQU9z6soXHBjKFSeS5i+M2ejdNuSkFPPwk0/u7iHwdOySRWT2pPCv915N0ZMFOTWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809922; c=relaxed/simple;
	bh=G625wDxJWKjl/LMSQCIBUXPTaU0T74g7tM1j8Nk3wkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sJzUa8XpVnqFgwEOPXr1Uy9TBPGW2tsVZ0EhDQ9YhqrbqWRBc1Mq849oCfxoojtaG0HPnP5JFC0mC/Wvv5TdheFXsbNoP821FCn7Y6xH0/BOSTIFQnnq/99xK4shuZU70NmsOJLzIqFGjQ9+VDez9gjkSczgGDg8LhvXCRCYlA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dAd5rV4T; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dAd5rV4T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uuft1OQoh6ia83ldHOaW7yPzHYNCeEx1tXsycXYV4X3kdN3/U7BCeZbAx7cGwu+qNFfokphCyZxwbh4SF/3w8hBC/anEuFWs8gUh5Mx8fQlNf0ZL8ZzTNJ33vmpk2Y3M6nHD8wbk3iYhyQ8CsRh+CyTmLMmzON+blncA0OYAac86gdXpmLXEAr5+J8KWObPGRpRgUzTo96J40HtfQOTIGSVdJU3XUvHhm862e3MZoxHDv7y01O8iIMz7T2c9GGAvpNfpuIfmk36tf8nS0piJKyfDGQRqaORVhwjpoGHh7AypdZS7TX6El5mLt9peT3267ZQpJKs37Ht08ArXZhSPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrXKJx/LPC8KGC0hxXhELZvufGKE0Ey6sYq/g0s1XHY=;
 b=er1r4k/ZXctbYzNPInl6BfNqoDSqdNFhkw8NFTyhxsaselZ16h8gpLKiZKgT/o0simf5mMjNYdViqGrf2CynT1xLbBDvYQd9/094fhm94beEfge2Jdy2K2j5/7Qrgrwfj+ZMTnyFYZPaol892jGDqbLiuriUuq+e72co9RqPx5acjphfKScZ37TVtV6aXA4QGUOGD4l/SKUj7+91Vjkx4FHOP2mKRbX/MflYSYONXIw98eIGpUhET0T2TFwUSMMA3cxezSJxxn/FOIzgo//utxOgzY6QhWuD5eEndfM2S339tbmKd6jvc70d6ubVPIe4s77HDII8GdZEb/nriQfwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrXKJx/LPC8KGC0hxXhELZvufGKE0Ey6sYq/g0s1XHY=;
 b=dAd5rV4T4L1i9af++vIa4LazSFbKzRxbKt+GLNzBEGW6wG119mY/YkEdDr3vavm0m+FTXxJljSfsDpI2ZT91f9/x17vcaJYVHY8FArOAI4FXTKVsGTi0LQgAKe+cvDft3EFN3MZpniPJVQEMZWA7wNwJt29zbtbd9/6Supm1uvQUsJBhAjN1clJ0hc1jrWUSUrBWk8Q0+9MCvVpUeIwJmF1hNrE0aFfxhAigdVEjDl/XbQ31i899UAW9elFQZ7KWfH5yYV+XvEoTo/Iea4Xf7r+0o7URmK+fHAWLLdgEx4erbVCF36h0vNNuEVZgLeQ6be45RX3myjlMZtStYAdPQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU4PR04MB11908.eurprd04.prod.outlook.com (2603:10a6:10:61c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:11:55 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:11:55 +0000
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
Subject: [PATCH v3 3/8] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
Date: Fri,  6 Mar 2026 16:11:42 +0100
Message-ID: <20260306151147.24446-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 67f8210f-4aeb-4b12-99f0-08de7b92b3fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	EGLRQMmy7UY+6fUJJJxCC3DoFLRdv67SRYiWUOoXEWYMt2P+eXKE1OBqFQMTalClFe6+zfWX7idK5qxOHYr5Tk/3T8BQFcJunkVBh3jI746Ntoe1sbAYe2v8u9uYJ5vaftmqR2ylTHopHHNrnZm9GvJ6xaH/d8fGAmMjcAnOSl8nc4z09IFvtbCIluWmQ5DcVs6+z7qlRY6y9w4hH9bF/uvUQ3oNbLZf9Nm4RTVhsNG+cKj061dVQXmOEVjjfcWqv4uB/9dTxXd5rZXYwDXIkIn2ebyiuxVio+y5x3LiupuBIOkJUtFlhHXiqHVxZKglgQbHHTY3kUK5cVP6SMWkPSwxxN9mTTMJEC3dKBYTV5O4H/E0Ckt4for9EWJDqzbFAji06LwJwSt0wgLdhyYvnB3c3+yNgOYorLGNmW1XVc/IqGD4zkZTgqec6OKSw+IRd4tAM2fyJbkU/22u+Fwg6Pg8Tmy+VW7ZjTlmlG01+c4SnWtk3xsdythQi1UpLLb5PASj2q7BXrTYFGDJvXWwCed2XXpWbq5U56icM7tMCgdbzp9RlxQdg0bAZxI6JOY2ffmSqDLq7X1OJ8zmNpv/0pDNdOTz7dlQR20PGrDCvqcxWhEbYakSvsEfz3FYvGKVWCVEd3nmgpMX1GaWfWs9vxwPoCWGH60Ubvo1REzdQrPc0BD+YDkW/3T3WofVORic8W5nvjwk9FT2NAHA0tdzVa8y49cgoaO5FgwpHMtFVRRiKz3b/1VV0+iU2GPNd5uQvwrICZK2EleCmnmF6MB5tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VzYVlqbkZFSU1QQXgvTFkzengwSUFCcFowb0FHQXJ5bTNIU1Q2cTlYYWZm?=
 =?utf-8?B?Ulp4WnIyK1FQNFM4RHd1NGFVbkdSdkdoR2hGRzIwcUtCTmdOY2tRSXJlUEdE?=
 =?utf-8?B?dldVWjJXeDVUbTgyQWN0TG43RTBtYlEwK0ttNjZTdHF5Y0ozNEV1NEJ2ZHdO?=
 =?utf-8?B?NGsyWjA4dlRNM1lGdVczWU40R1doYnlRN2h0bVJMZ2JnRythTzRhSnQ3dCs0?=
 =?utf-8?B?SlhnYWFHRG5WLzJmYWVUbGo2ckNrdThIV3dhVmFqUVYxbzIweHNCMThMTFZY?=
 =?utf-8?B?Q3l3elVsbmhMQ1k5b2hPaDFPSEZBTnRpUFhIZ3RxaE9JdC9VNzFMT1lnNjU0?=
 =?utf-8?B?Y1M0ZXB1V0hENnNpdDZQWTdYN29mN3Vnc1pwelorTVJkL3JkbVdLQlpvUnRo?=
 =?utf-8?B?Q3FMd1lTMzdCVUR4VWkrR1ZwZzZrcHpmUkt1YkhtYUlPM1BpWEw2TzJ6REhM?=
 =?utf-8?B?RTFuOWR3TExvdWF0ZjJ5ZllsWHA5NW1UQU5HMGQyZVNmM2lScHlGYzh0RVRF?=
 =?utf-8?B?aEFxQVJRemFPSnVsMmRiSm5QaEFqeTYwcXdwdWF2NHF0cDB3TGJTbWJCQmNo?=
 =?utf-8?B?THZOSU40L3E0Z2hXY0UrSlhuK2NsVDhxVFVnVzVCNVY4TVhQNDY2anhXRStn?=
 =?utf-8?B?THB6Q2NqSUpSUlFZZUxCRytZVDZER3J0N1ZZNHFlRDRKZi85bnZGWjJ5WTBM?=
 =?utf-8?B?ZHJaQ0hVcVZkdkZBdVR6bENGSHVCeTRMVThRZGxIT3BTdkdaRHJSbmNlZXF6?=
 =?utf-8?B?RUU1eUNMRXN3R2ZuK083WFJCTldTb3Q2dWo5Ulk0a1VSVkh3dFl1SjBBNUVr?=
 =?utf-8?B?UDRVWDRsaVpJVDBqOVFkMDNzQTdqSVZ5K2ZGYjFZcEk4dXF5OFlIcUhodkNN?=
 =?utf-8?B?Tk15czlWRExENUhhNHI1SU9EVVJSK2o2NitJZkFSZVFpd0tPZXhiRkJkem1V?=
 =?utf-8?B?cmU1NDFOTDlNWUROQXZDRkRoZXc1NlVCeFhyQkNuUmNEWTVtZkdJbmpMVDFv?=
 =?utf-8?B?WWpKWUM4NUx0QmpHWmFQTW5peUdlS01xVHBQSll0UHFheWVJS2Y4MnZabGZz?=
 =?utf-8?B?aFpWelVCM2RHdCtFWis3QVZYd0Z4Q09jYWZMUUhkcU9FRndUakxNOXpOZXdC?=
 =?utf-8?B?T3R5Q0NVVUloY2IxWTdTUEhZWkNucktkTm05VllxaDg2RUE2UW91UTlaUHJ1?=
 =?utf-8?B?UlFPZmNSRDVUSWI0Nm9qczdQV2FZZzNDN1JLdGh3NnJIRU9QMXY5dThzY1Jq?=
 =?utf-8?B?R1puOU40a0lhUmc4bFpVSzk0ME5oa29FWXFNSTZtRFpQMzB5MVNVUy9vckFq?=
 =?utf-8?B?OWtsV2h6b0p6TElUUEFTTmFLeGtnVlBFdExtK25aM0IvbWkzanNEWHFtLzZP?=
 =?utf-8?B?eTBxeXluazhJZ1k1MWJpL09qSmJNZzdRMG9UMWo1UGwyVWp5Y25xZnJ4YnlP?=
 =?utf-8?B?R0NTc3NIOG1VZ1pHVDNhaWRKdXVmZUpka1NyMTJBN1FDZ0ZuUTJTTGxVekhv?=
 =?utf-8?B?RWJrOWhsSUZRQzlLM2hoTC9uVFQ2Snl0MGN0WFlvQ3czbmdhNmYrSEdmM29s?=
 =?utf-8?B?Tlo2SCtoNzhXZVRmUFVyc3V3Y2hvVDdpTDV0Qm53RWg2SnVMZDFEYVV1cmhy?=
 =?utf-8?B?QVRtbGc0bG44WkRIUjU4NVQvd3U1RXUzR2xOUk8raGVhKzY1emFPbUZWbVFk?=
 =?utf-8?B?MThQYmhPT3ZpTURiTXhKb1paMER3VzF3VEFySkxGWjdTYTdVdDNqYzV4YUUy?=
 =?utf-8?B?TFowSGNJaWl2a2VTQXcwL2J4bmJOdTdQYitoKzZWclFZZ1hXbmNtY1NmSVE0?=
 =?utf-8?B?Smg3VktCckVQTWtQcHN6NlVmaDFrT1JEaWljbDVFZkt0KzllZnZkelpBV0tw?=
 =?utf-8?B?bU1uc1JOYlBROUVLeVRxQ0RpRnoxc1J3cXRQaTFLMHhlajNhSHZhdUsxa0ZT?=
 =?utf-8?B?cEpYNEg4aE1YMm1qY0tDUHhBZU9ONjJUTTdGaHBCMzZqNlhHcXJvbmxVWE1m?=
 =?utf-8?B?ZTJoTENIQ2RpNGlhMlZaQnNZd2xVaWQ1NmxIT1RqbG5DWU5xd2ZIN1hRVGta?=
 =?utf-8?B?Y2duNVFNOTd4aFB4QzFQbFZ3bGpRTlE1NGRLRk5pS2NuK0lUSGJZWGNHc0JB?=
 =?utf-8?B?eGU5L2xIMlAzZ3R0dDBvc0FmVWpSWnYzUW9ORWtNYmdWYlVoWllyTGdqWko4?=
 =?utf-8?B?VUpHZTI1WkllM01Nd1A4Z2ZmcTFCWlJRaHJYQmpIWTMzZzlLR3RyVG52VGFO?=
 =?utf-8?B?T2lFVm8wTDNGa2wzK0UyVHYyblowTSs2UWNUc2tBNS9NMDU5RStoRnNZOTVi?=
 =?utf-8?B?bUR5ZGlHOElsaFJDQzc2NjNaclRVamFNM1Jad29lamhONjdLTTR5bHlFbUp0?=
 =?utf-8?Q?XjUuPOhPw6r1iq4I=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f8210f-4aeb-4b12-99f0-08de7b92b3fc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:11:55.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lc3SD08napj3uMlwCiRcmDWGRO28yGNdZqZInvd7zFDcEw57fg0Zkd825FcszRY99JAdz7fznSoR4dk16JcR6E6z72dUU9YXvxfzj0sJ5jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11908

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree binding documentation for the NXP S32N79 automotive SoC
and the S32N79 Reference Design Board (S32N79-RDB).

The S32N79 is an automotive-grade SoC featuring eight ARM Cortex-A78AE
cores organized for high-performance networking and gateway applications
in vehicles.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
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

