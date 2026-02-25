Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AAF3B961D;
	Wed, 25 Feb 2026 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026751; cv=fail; b=RakW+OoDR0B4PvskUQ50Bbzo53j9yMkYeBLYLvnNEq4/BIjvLrPPwrd/IDANfpZ6kxvG25FwvIzccec/UBZRqEOjqb2C+eHvTNO91OC5AK5raYfjOaL8rOXvl0ekRcVZK4BWRrMVZGQW5L6y0zyLscVA7CGBiAxJPlCdhBjhmhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026751; c=relaxed/simple;
	bh=jiLgjin10y+xHab4T5SGF+1pQ/J9bktzPkym0UZnVHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlqPk4CIJOqj76LXK/jSjUJ4PFTqEn15m1g2ovpjjbHkssQj2TROtxaLXog+xiIobZZw8SGTO4ExPBzxOobSjS9CC2URC8dpTnolXl0rDgas18PQyYVfaeLsZodP4dZIQS1dxEFdqrLoDiYLGuGjMnLsMI01W+cVKg3d/X4uFrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JMMuROTP; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JMMuROTP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRUKAUorghVzkYtxu9yzEW6fFlUMqaO1grT5rpaxVEC/vp0N9yiA/G61+HulwB8yL6lUO9bVFSaooghywCg9Cr43Pn0XzTMk7mVbxHQgkc3+G4IJ3ZfGAxOemrHEREuwxCh5Epezt7nydZAYdqF8laXiibn8CqxZAHI0cDE8ZgBdFW3IejFIqFKD7OXyfXR1kVVJ/r4/s/AAuHObMdNn0LYxOJvKyisLdZV5YFhmMnJ18QBjqNicVwqfMCHFXeztQpF2y4XdrZWOMztu1VKl2V4U6LmK3TQvsqkCTdA0cTFT00RskMTbkWdR5q7aYKweJaxJHuKCG2/ouhLxp0lILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYaHZoOgGRL7OLNCU0XTn6cZonlsuVmV9uEkjz43sxU=;
 b=WmFSD9WDqWA8o1gspqQWDh/sofN6z+dj+HQmdEa7Oza/DU7GhjKs1VDpwOkGttqbr0Hp1MNCD2zb6NuEJCYhgudG6rmGW4a6WoK7TLyiMuphmA/59JP+mFgB/Jei5RIT1Ldt+OWasiiSGyfAXBJMCi67sPEPFMSuURv1Hpx/EX5zTMNsiatShU8iHh4mB82qj5OGRGbT/6nhZ3LTJ/EVI01w2UjrYyiTN0esXLXlgf8f2O3jLSPeX75yBHa74Mb4TtMYhenTzZyaKAgq/l2dhri0brVvEmjpyMuJe1fEiEkjT0MCJjdfjuSglr6q6yd4maJefMQ46nh+g+Q214t+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYaHZoOgGRL7OLNCU0XTn6cZonlsuVmV9uEkjz43sxU=;
 b=JMMuROTPhpU9XqxTRPhStDUWz5zgDBw0CzbHC2WDRcWkc8N4pXGnNRnjmzK6GOCGCq4rd1fjibUwv7NPXDRNPe8kEcVYDcZGrTbDN0B7y+zCisDJNNfRu3KPanqpS+fFluqiGWK6m8SORca6fwEaC7MxMhqavBjsMWzxwCTNv1yUeBVRDDIgVfDvEYa1F+GZs4utTCUaO4DvBoQrxSvxVm8TKuC+gO32IcV1puqV54egPHlkTvE+qfb/Sn6nCOs3Qngv1YFeP1iyrVl03AAE98FEnHXkXkT2arun+o3L6wb4cypeIOyyK9941y2OBP+xRnF1wXfAeFX6KXcH12zPzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:39:02 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:39:02 +0000
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
Subject: [PATCH v2 1/7] dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
Date: Wed, 25 Feb 2026 14:38:52 +0100
Message-ID: <20260225133858.8026-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::11) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 26251fdb-cec5-4bb3-4579-08de74733ca9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	+bn1VCT4hAJG/xF+kWdQRJh3uS/0mVSjkM0rLgUhNFY4cYj3M1mXRs//gpyPFxcG6ocjvelHUj9ETGczhpr0QyevwdiRizJwbxUqbR+2xTPAU4vCy53K0100JPQankZ0b2qYVSmv+NlPv2j8mzpsvvFNj49m6oURy988Q5Rns98Xx/UD523bt6lx4mcCTUvDublLeFkz4rzQQc8InZtZWNw7I5m96sROAV89iso5fnR+z82xh19uJLk33ns7A9dHbLJ6Ufka5mT2t+Cex0NORH8KF3vFU2G5ZtSMxovppPLcpiQSqI5GTgkiD3LkwWjMgFuL7ypb7XC2iOex5oEOSMQzfqq/H/6772es7gAOB0mLhlg6mGH6BJY2LtncoZT5xpzkO0hx+JL9zaNG+/25zSU+b1LYYDQT/UlkC5bm3aoG1gYsroXJNK51GMMN0areuH7TcnowSHvgDMTAfuHpwSaL0DEclWv0Ad+357iuK3c7k1QdREX0rV9oCka5lkNkUeDjZaFIBCuinlMsvwy2UQEtqWQt6kEzmCBNPrz/HDADoaI4dfqVMwzsG25mXSkDvzcgDkPF8tWE6iyn5hw89Deb4F0en7k7l6ovaxNNXmnDhtXuxww2Yk/rhhFHdls+bZ9l3cApbGYL9ck9TM5eTZLn/paqDe98kbMf/+4Bj2fRiO8J8iZ3YLStaV7/369rRGYGdoIrrCo4zP26CGQQxYWFtMunp0O2TRieHSpXxDaILR+POnrpsWHe/X1Z2O6gjJUV4Mb6he6FdGXUG4Gmog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0NWQjMzS2NtV1BmWTY0ejlPaWtkL2FhNEFYVGwzTmsrR1R0RVJKR1R2QWdP?=
 =?utf-8?B?WHorNWxJUEd1cjVvTWRRN0FTUlFMR1Y0NFpUZlh6QUpFMEEzU0w4Y3RUWTJy?=
 =?utf-8?B?YkViWnM5YTZjbTRhTUE5U0M1TE0rTWJQM0xPR2ZabXZSZjc1UjV4Z1EwT1Vp?=
 =?utf-8?B?ZzBIbEp3ckEyanJKWnFMaTUxVWRwMjhsbFBOUExrcjVTN08rb2YwMnkwUHRG?=
 =?utf-8?B?TWVJMUpsUWZYdm5vQVdsS3l6ZWNlaWdKMFpBYS9TWEtOTW9hSnI2UHJHTWRy?=
 =?utf-8?B?cWZXTEFxZi95NDU0VDB4WnBhT2tyRFhjVEV6ekdGd2VtaExicXplYlpEZWN4?=
 =?utf-8?B?cndUQlptL3poQUlCL090ZVA4UXVhNVBGblFKREJwaklJT1RjZDBObWxEOWUy?=
 =?utf-8?B?Y1hsNndpS3pKczVRQVE3YW5nTEErcG5lb3dKR0NQUEtETFlDZGFYbElBZjR0?=
 =?utf-8?B?MU94NWJMTGVUZFEwaGRleEhXSFd1UnhlUFA4UGhXWGdYYmhGL1FISXpidFBU?=
 =?utf-8?B?ck0zWGVtRU1JMllUYXR0NUFVbHgvMFg2M3p5WCswcFdReVRyVElaYk9vV0hK?=
 =?utf-8?B?YzlqeWFva21obFozVTV3NjJ3Z2lXcGFsVGxTL2wraVdiR3BndzN6QnhiWEdo?=
 =?utf-8?B?UWtOaitUQmZSYTI0dHlSK0ZtcklxaHJmcjlDZ1lXU0s5V1JjWFVVZmNVM0Qx?=
 =?utf-8?B?V3JvNjFDb3JhUStkQWp3VzJJZS8yUHQrTXFZWkdxTkFwTlJ1ayt5VUJqdEpY?=
 =?utf-8?B?aDE3QjJNMlRtN09NdE1YVkI5SnhGKytPZ01LdUR6YzN3Qkd6LzNka21LWWF4?=
 =?utf-8?B?UjAwVWFWQjZxVVBIYTNxRkIwblhMN1VHMkMwdmlGbllmdnNKK0crTWFZTEkr?=
 =?utf-8?B?UmMxajBYWUgwc2VzUzM0djUwYk9zR3g2VlZQVm83TWJINzV3QlBKS0V3dmFh?=
 =?utf-8?B?YmsrSHhDdzBtTncyUndGRUY0bzlCRExMdXY5WkdENHhEKzdVM3VicnNnVmd0?=
 =?utf-8?B?ZXc3ZXczK0Z6Qmc4QW9BdzRxVEVMbDlHbi93RTM3YkF4ZFFKaXBtK2MyZ0Fq?=
 =?utf-8?B?ZFdmNTdlOW9OaCtVemUxcDMxNGNFcVUwUFZYSE42dlUrWXNDTmJFcitBV2NX?=
 =?utf-8?B?OXU4V0NQa2dMb1lvWFRkbWJjTzg5US90bUN0SlhWWEZTNTZlUG15M3JBNHNj?=
 =?utf-8?B?U1BTbkE5WXJCYU5pOTBvZmFVUGkrdzhlayt2bHZESHVhdjF0Y1ppUkg4bVo4?=
 =?utf-8?B?VmJjRXFwMjh0bVlGS1FVTW9yMUMzaFRlSk9ydWR5Y21GKzJRUzg1eE9HVVFO?=
 =?utf-8?B?dSt4UHpEWWJ1VzhKYW5WMGNaVVlIUUpBN3k4NHNtc2pzN1AwcGNaQzV0QXNX?=
 =?utf-8?B?M3hMQUQyV1UvYXd2STdNUXc0dGZLbERveUJtdmtnNXNMWGxydkZwaDQrM09S?=
 =?utf-8?B?NXczWlV0WnBiY0RxNzNWWEJxZzJET1hrTnNKbjlVV3AyUjhCeWFCY0RxcGx2?=
 =?utf-8?B?Q2VNVVJ6dVZXdHRFVVVlUW50ZVZySUZVK2llWGFaV0RKcmhPY2hYUlNLMmhi?=
 =?utf-8?B?d3ovcnZGVTZTK2tmTVE5RWNzcXRUaEwyNktpQ0FSVUZVN3I5L254YnJvTGRW?=
 =?utf-8?B?OVBiaVpPdkVoQVFRZ2ViNlFNZkpyNGY2VWhLQkNSVUxmZEpuZC9BNnM5ZDkw?=
 =?utf-8?B?OVJXeTVkSExidmg3c0ZvUnRtRnU4akg5MThtTXZpNkxlbDVMNGpGTThITHRy?=
 =?utf-8?B?MW5NTko3SGxZdTJTS1UyOWVoWW1XaTRXdTVVejFKVFlEOWxwWUR5L2xVdHo5?=
 =?utf-8?B?eVVNKzc0eVdrTndJOFlMb1NWQ1RpM0w3RW5CWXQ2MERSOW9vWXBVdU1oaUJG?=
 =?utf-8?B?MVYrUUZkUXlPVkVyY2xUOU9lU0Uxem84Mml3OWdqMVpPR1Rvc1d6RFpyeTYy?=
 =?utf-8?B?UVZZenpsR3VXZllkOXJ6d1ZoVVcvOWJIVFY0Vytxcm5DNllkSmtYWmg1c2RG?=
 =?utf-8?B?Z0xlT01lNThXaVAxaHp3TDduUUFnL2pwd0gzR0JTeWNPMlJRRmFMdjgzR2ly?=
 =?utf-8?B?OVJnNDh6Z29XSVVsblRaMm5GWUlIdHlvZnp2SE5lUEM2cmJZZjg4YXc0cGR4?=
 =?utf-8?B?TTNIbURSemwraWw4Uk9HcHZWN1VKNDdGOXI0a0NxbEZsbU15eENmcktidFI1?=
 =?utf-8?B?NDJvNnZKUXhzZzJVQjlZSnI0dlcvbUxwTmh5VmRxVzNOSE0yL1paTkRhZGRt?=
 =?utf-8?B?ci95aWFsaWxYWmlGeGRiYm8zOGlTeHd6VUltTnJETkpyMnowUlpGS0lrdlIx?=
 =?utf-8?B?Y3hGS3dOZnVkZTlnaWxFSHgveDdjRG9CMHJrbTBzQXF0T3gxVVFqRzg3WFRW?=
 =?utf-8?Q?ZIyC1rh/KZ+SmcW0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26251fdb-cec5-4bb3-4579-08de74733ca9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:39:02.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTJnTipu60lNn7EFaeHVGqyNZRPOCbC8r55Xcy8yE/Fi3UoLAt/F/Lv1YqIjyW8te06U4W69JsOVD9Rf6yFZj8tAm0vNuwyVy7vK9XPtNUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add compatible string for the interrupt steering controller used in NXP
S32N79 SoC.

The S32N79 SoC differs from the i.MX version by not implementing the
CHANCTRL register, but otherwise maintains the same programming model and
register layout.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 5c768c1e159c..caf3e4a1f26f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -22,6 +22,7 @@ properties:
               - fsl,imx94-irqsteer
               - fsl,imx95-irqsteer
           - const: fsl,imx-irqsteer
+      - const: nxp,s32n79-irqsteer
 
   reg:
     maxItems: 1
-- 
2.43.0

