Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CC3C1977;
	Wed, 25 Feb 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026757; cv=fail; b=jf18HzHm4q/NVgUW6Wn3jJhvRXaGMRNQVNODkViQq0nnyf7lx8LCpO4xclKJ2BXish9xLJBBCdG46lZJIYEVv+RxxtiuCleYHOUG2VrOPZYHMtFpkb+iEUE9nYrm26MRzkbLbMelNNb149njgPpFfIpXXnu74lzbwQh3kLZTjY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026757; c=relaxed/simple;
	bh=G625wDxJWKjl/LMSQCIBUXPTaU0T74g7tM1j8Nk3wkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPje2UU3vJSdXumtxoDbmEjcLgCFOjfLeyIZnYGQRun35o/EsaXmGNN8ZADBuix9nqxfvsK9U8S95k4x3DtyPxnJqR50h1JTZBf2CTfK8pLJ68/nAZi0FT7BzEo6x/MB2EAkF/Th2gM5lS+ScWwN9mri61T8Tu6/I8uT9OTFoMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DaodMmaO; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DaodMmaO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsNZS2th/O20bsbzO536eOeXcav8Be3fE4RyuuDH36TKWrAkKk2R+9Ix7kFuj96WldAMxSCI3OameiEjxBjTBDDB875AsUgzGAVxVawHDp540Mnsvsgo7q54keRIhC20v2xoXQex0sjnHjqrY7cZm4MgOlqaxzliifvlI1CFLwDSkoxEI7XhwuEHRE8l0D0KaUxKCijL0HAHsVrRHOpcvTyUVnGDBfy37xT5EQb4DHzfOnLSdJ4pklWDbPOJsYzeNFhLGSm6jl/43pvZOtDPyF7Jp2fuiojOwUn7R0gxH3mvH/ZyaiSzawfQNkF3I3mRt4fDOqQzfRsr8C+/7cAjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrXKJx/LPC8KGC0hxXhELZvufGKE0Ey6sYq/g0s1XHY=;
 b=ih3LWYpPs7YahpdK8DSP2GOWNGWA8U2DtqxRSzGIWZEV2ZIwIxt0dAvnCKGgZ3Gr5ihrUQ4SR3iHJgnrnd3ptaqhpfwRHKs0EogrghzJdeW4dz7A0Oi8XJQWFOHq5yon45C0IXlzFbuaV5WFmo3IwLBa/CV/UiY/aj1ZgEQg6d2wTi7YLrea6D1XmsqB4xeeX1TcEn1Fm84nA1C5sCFxWx92uJkehxmA747kbTzM0KOmZRp97jr7GTGbHZm6KUe0bNQzkan0XhayDLcNaK5L6suyRRS5GkxHFzrMJJL5/9VkzemYkf6WV0hjkkvO+ZchgKcqOXQsM7371+9s9dWmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrXKJx/LPC8KGC0hxXhELZvufGKE0Ey6sYq/g0s1XHY=;
 b=DaodMmaOXDdM4PC3z6rHOJBj9oXiB5FEYvwCW9ZXZylYTYNUBwqGaNCRPjRpJh8Lhn0BsJAGlqrSVUSfh5KbjCGHYs/mnunNlR9/zhykf+FHXP2J0B6yaSSWKpQp4PTtMBjMZ6zWy++HApvKQa0TGdHNf8rEwd4o0Is2t9byCZSURcpvs7V0sxXCFrakYYEHLZQXspi1h5Tg9Kwz53rKN54FQ/ns5vTihHQQpUckTbUYn6Xx13bkwz3c2PJg9+HHrpfn0MYalm3dW9qCYpKyNxAA4JoCrVtgMbhPWnX+RGOHUliiZsYoq0vu8yPEM+QY6YarQoTyHllGXc2BWjdD3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:39:05 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:39:05 +0000
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
Subject: [PATCH v2 3/7] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
Date: Wed, 25 Feb 2026 14:38:54 +0100
Message-ID: <20260225133858.8026-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::14) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 2d988315-dd33-45c9-6d10-08de74733e49
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	uP9P10RLS/bgh/EW4MFeMV7qLpt4jEBx3I1pTI18rhayrXmVkBq1aNHvoZlmgs96tOSi9kSdAy61DuJ3h+QWLEXjWMWi2pxhPSGBrTgqQBEHKqMQQZfqogDYFVjICZGwtI97NXOMfjGQx1Cd4RtXVNEa7UllkFpidSruX8/SHDS2psosBRrrqfHU7T5FnJPHFcyVPXPncE61M4mw6hby+9pi2zCPKu6KlyA5YNhBvM4agWMpdaNP99VF/XqZ5sKuD//gMm75/7EkgiPIkfLZ6tqeEmCoXtWLLb29mOqXXe7k1/mXsfi5jHgIaFVrO4T4higiO76MLGu1+dIeqgsWDetFgRlrCjLOj9uebwOFB2Qi6/r40u6WP293KgqHqwg0GJXcHhN4Ucc8ny7iNx5j7nS8A3Fhp02k+RzEnGWWT9S+wQ5tN6udqyYtIcWcfRQEOAqNVjxE8zxksJ7T7/aq0uxQYJtcSFqBUOp1RPckqCoI4l1dciTKjJ8IwPt2Vj71xu+ByCWY1N3AcIB9h6X6oVmIYgvaEr4HL/CYM3ldrRWveHZf6rHuvUDuy2AAmTjwYrS62G57D+BhcRzfG4GG7vJUmcRDbfm7CN0s+zCQX+GlVIr8bKBFBcyAPx0a5bsKc2+GtycNYzECpxpGoyYBost0OVWVJcwW9ru1JdjiqgoHU0OsO2hAGU7qlzQWtqsp94EuT6pWS5saZyqQgc6s1X1yRT/UGqX1vqY+zhuqeTCgMn6el6gasBL3PBSwvmI+YRgsP2AwuuLWlAoBhI3MqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzZXZFpQaUFJZlFNS2RuMmZJZ01EMWxkQ08zQzRVVml0K2tPeHhkNGVuZWg3?=
 =?utf-8?B?VlNmUVJ4cEFQeWo4TW1DaGdSWVU0dzNyQXl1QS9oRnVvNWVvVEUvQ3N4NXd1?=
 =?utf-8?B?OCtKTG12Nk9VODJKUmozTTBoek10cFJmbXRhL0tYek1JTTJLenI1aEp1c3B5?=
 =?utf-8?B?anhtMXdHKzEwVFFXdnBnZDZYb0NoLzZLaDlkT2owYlJIaEYvcDN4ZGdjNW0y?=
 =?utf-8?B?UTlxZ2F3cTlDeEtIRHJVcEdWQkc5VTlOUU5MczhDM1R3SkwrTjFNRVdZcGpx?=
 =?utf-8?B?ZWQ1UlkwdHJnZXpNRTBJY1d5WmxLT2FteXYraWhNMWlqcms3SDU2b2Y5U0hF?=
 =?utf-8?B?YUJkRUwzWlB5MDBVU2ppaUNzeUFyR1ZVU2grUmt2bUxVMGpwWVl2NnYwdHFy?=
 =?utf-8?B?TzJxcHIyNTRQQzNxRzNJYitTTXpLbm1VTEpod2xtQlF4MlVZYlBIRjA0VThi?=
 =?utf-8?B?ZS9Gek1IbDlObThiUTVoTnVOZkR3NFA5WGk2TjZDRkVMMjNlU084bC9Ga3c5?=
 =?utf-8?B?aFZqR3J5SDdoTGErcElyMGsxTEdEWHcrdEY2aGJzdzIxNkZlQ1ZxUHhGSDgx?=
 =?utf-8?B?azhsTnk5NTUzRHhLQXlNbTV5TFZPbTdRL0dISjJpMnZiYWV1NWszOUV4cmk5?=
 =?utf-8?B?aDNjU1c1ZzMzaXJHa1BmWW9STUlYRTZPZ1BidU5PWUNzUW1WZ2E2SVprL0xL?=
 =?utf-8?B?ejRhSzZEWG0wcVV6OVcyUTlpclFENzNUblhDWW41aWppcHUycXZDWWZRYlhn?=
 =?utf-8?B?MFlxbFdJWXptQ1NEdW02WWRmODIybXc5VzdmMUJXNFYwMzdrQXNyYTZwVDJ6?=
 =?utf-8?B?UE1sYzMrQ0NPSVFlTmlkWGxKbHJIMUNXci9NRXZOVngxUHEreFhKUmdFYWVl?=
 =?utf-8?B?Mmc5aWxUc0w2emp1N2hhZDA1Skx6QVZqSkVBNExWTllQSE1FdzhGYXVEbU1l?=
 =?utf-8?B?a0pYclIzZUZodDcvOG9yak9qWFBXUWlJOEdVTkxuWFRHc1Q0SExwelpXUHd5?=
 =?utf-8?B?K2N3NmJhQjJWOU1vaWRwdWRoeW8xNHQxOGJIZktBV2lIUkc3SEFxbmswVG5l?=
 =?utf-8?B?aitqKzZJN2NNN1RwSGlqblltUEIxTW1jK0dtdytRZXdBUTdiNWJKYjFBZUlp?=
 =?utf-8?B?ak5RV2tLaTlKeVY4bllaZjByYnRJM0hvU2Qyb29RU3RmdGEzM0gvQ2UvTXRR?=
 =?utf-8?B?SVJ5YTIyeEdVRFhZUWgrMU4vcGM3TEdyVUw3dmphZlcyUzE1Z2dqblZtVG5r?=
 =?utf-8?B?Tng1T2t3b1hVVWhuT2xSSE0wUVNzcDNURlRzWmVDVWE0a1lVZ3JXTWNOY0dj?=
 =?utf-8?B?R0Zpb1dsekhQRDR4WVRpd0V3Rmg2eUlDeXNESnZJVGVzU1VRQzdUVVRudk9U?=
 =?utf-8?B?aGl6b1FadUczYmdLREl0Y25aUTNuN0dUdkF5eTAwMmZDY1dBSHJnZldOUXpp?=
 =?utf-8?B?MVJXSXgyaWhHczlYZ2E4UnBrb2ZzKytMWFd1SGt5ZFRXcDFtb0RKa0RNdWVJ?=
 =?utf-8?B?bGVETW96dXl3ekFMTXhOS2I0YnlRVUZ3UmdaekhOSWl2cnhOMjdPOXl3MXF4?=
 =?utf-8?B?SWZNSm8zR2hsUVJoeUJqMmxVU3ZiYkVEczlIOFpiSjRFWmVTRzNHKytyem1Q?=
 =?utf-8?B?dHBwNkdFZTFNd3ZMbUZONUJnTjcybWlUT09scnpEZ0cxSkx0OTZJNmJpV2JO?=
 =?utf-8?B?ZVFyL0dMZlFyc0hKbnNQQWV5QmRHeGdGR2RIWTFCemJrZ1E1OCtJTXZJU3NC?=
 =?utf-8?B?THU1cjljMi9RU3lGdEFuRnpDb1VkVEEzaEdIZTRFaTdpaHg5aDMrVlBnSUcy?=
 =?utf-8?B?clVuUGpQZnVGK3VjMm5wWjg2UkxSUzlDRW1PZDh5VStPNU9sYXpjamlWeTVp?=
 =?utf-8?B?RGhCbTFicWpSaStyYXdSNTVsOU1iSDVYbzRxZnAwcENtU2Q3cWM5bnNhM0Vk?=
 =?utf-8?B?Qnl5Smh0RzV4bENDbGpkYTRHL3JaamF6SlQ4WWg5ejdkd3FOZHdtTEJmSVR5?=
 =?utf-8?B?ZUF3cUExTlVlQlJiUHdhSXVacStYUFo2RVJYNHl0aUNMK3BtRk80ZytBUkR4?=
 =?utf-8?B?bFZBdjFNeFVQRmdzZ2g1N2JyNEVYRlZGVFFsQ21zUkNMRFNSNUY2dGtHK2JD?=
 =?utf-8?B?M09Td3RYNFJYRHpZWmpQTDF6UGtkL25SVG1oRnZ5b2MzYVZPQS9RWVFLeXB1?=
 =?utf-8?B?SWlJYWdIUFBRaEwyVDUveWxXRWVBM0hMcDdKV1dPdHVpeEd3a1pHQXl0cjFl?=
 =?utf-8?B?eE53UVZsYWRkbGEvS0RJK0hQRXFzZEZJNlVBczlkbTI5cXY2TVhmYTE2M1Bw?=
 =?utf-8?B?SzFvYmF6ZVRqVzBsNlR3dTF6anVOSVA3K1lQckxWWXZNTE5ZWmZERDZpNVR2?=
 =?utf-8?Q?QYQnbO+4I6jQJktk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d988315-dd33-45c9-6d10-08de74733e49
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:39:04.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDwTjmFowQj0syctVPKB390C/iyy3IvASPyDMWn4LWckIYW89iunoIw37iVYXGK5s1gfVproTYVuPKw2YLq7WIGjKcY1G22I9dYyiJKq+nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

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

