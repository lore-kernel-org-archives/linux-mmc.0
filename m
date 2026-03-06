Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A83EDAD0;
	Fri,  6 Mar 2026 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813771; cv=fail; b=cgwwpLER/5kNGn8VaKYya5LqgEpaInFHjrP2slQk8SgEVhgixukipKcpl8yh9L5y71H4e1Wkt9yIRTq5cl/BNArAD7vvUTfhLDiMi51+KA8BTaqS2EnLhmeR2or5vLIAYztvXtCgUuAtf4D9I1h++WM3YUGpvYtKgGgDrZveVaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813771; c=relaxed/simple;
	bh=G625wDxJWKjl/LMSQCIBUXPTaU0T74g7tM1j8Nk3wkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJv3VcLqUewmTtbug/3FkiJLJkOZBX0rwFvkGYrNdVNO5VLyiSpyQ2r9hhbMU0eu2E9L2cPVTTMddAAGknCfAUgPGwdH2jEXXsYcKYuY8bhjQtkHw5nGBZ2GamUjmbo9gzfydfiGbmM6TKiFQcRPt3SicIYhx65vk0EgTop272o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FOe+CaIp; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FOe+CaIp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xauQsUToNWgjfQ5WileiGkfBklszpAXRfPcFSkys8zp4MxqyFGGbj52rs3YTpVure79A2zGsvRMQ6LZWroCG0qgduEYnWQTEkuyJkYrN8Cx842kQzjHu5Lnk78VukvUunGLk7a0MS5kCmz+5gTjTMEvJ8kYESgAwDGfTa09dRlespI7F7X95rzp2m5qE+7HxU6g8jzyf4UYu06y6M/YwoNFX8KjwFS2xh8o1tC2U1Rm22/kiA0Nn55WMl98aeQ/a/UHmrHu6sjKQoLf3yfFsf39iOPKh77Lac+LDORM+6lUB7wtUzN4kiTO76d1qUesVEVh1KCt3pyWpCaE7uRo9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrXKJx/LPC8KGC0hxXhELZvufGKE0Ey6sYq/g0s1XHY=;
 b=O0+0HzyjIsM7e1+NsxrWJfUhH7ez4CwyhCCtjlpntjsBsub9q78RqdZ4Qbhy+enKuvD8x2dTqqFT95jMB8EX8Ab3ut8BXBqL6Qmm7K98m4KJnzgHO6j0W8ONmZ6r5BEfkxNDtx4J7lk85nRmHXNNzgUc25SUTQJOQtEFcIZz8wR8FYK4Ek9YST4iMRsaZYNYKJ71lSbWh7ruocX1pqtiEAK7+KR5rye/jg6Im9OW+ijLhvC6f+3s5XT00YqiMpRoMb01n/28YFlq0+WwLbJlZVE8/B4rItxLd+nd5z5G3I+WFBv3LAOBv+WESWTsBR3SpiUk9i82HN3Z2neIA/FAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrXKJx/LPC8KGC0hxXhELZvufGKE0Ey6sYq/g0s1XHY=;
 b=FOe+CaIpb5cwWwB4CDUD+nhKkZOq8a7T8ujdmHwtsZE+0ElCrcEIAjrRjC16m1kK5Vw2eMRRQ/aLSiiYJk1+XS8FwHkjl2vSS2VbSjCWnEv5VrfnQSaKLB7EuxIm+n/EaFBEy8lj03jeByzIjFe+H+2Xeq79Q8Y7LLL8zlSXZXNzId8iElUY1dvQIHIYaB/zr+Z5gj58JV28pS6d8jJMJ91VAVXPS+e7dgN4UNNJkhC5DylGb4eGllfsYZPUe0nBz8et8URMQ4bh7u1870FGAsRsO8c2sfAkruuTqcaR5lr5+XgHydFpbMY5pToaWOwgiOsrFaZU4PWKqJBi0X189Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:16:03 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 16:16:03 +0000
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
Subject: [PATCH v4 3/8] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
Date: Fri,  6 Mar 2026 17:15:50 +0100
Message-ID: <20260306161555.9000-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0142.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e983b07-251d-480f-53bc-08de7b9ba9a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	Twm1Jx92nc7K+J64GfpNu+Ck3qXDEUQ+aAdmyCrhqr1A5OpEg1q3acCOA7g/ebQFYRHAAxLFxld1xbOYOKGnGM689SgIApgvuRXbNmX/dhjR7VOzsPRtCKbwtlyd/xxI8BYF8LYHa1TGYEdmkeya8keyw9/GdboeKKBK1Lc/653F/x+CXQXzQBvt7RUIMvjy6lADYyLbLFni6tHyOrEsyb/3qKRnlzUI5cOiHv14dsSzDWOpXVGN3d/4q4qfC64jMLgemsQYnB2/pPqtV5NR36DpO3VEb0EOOy9vbdHPs7zjPFhcPULel4isU2qM1BFz29oWfzk6EAj6Mmx/twIR2i2R4mnpUuegpKQRhnXrJtSJwLrbWZV76n+MSwq7kjhje+5/Q0NlWAbiYW2TsWMEsodUUSo/YnnyiQ9ywRw54FBTdix1aB7bFZrVtnbGdiiAPnzs88kDEPZ6/Z5OOOlY8oU5UmwS3mB9Ie96pYVyaCg45Q1xtq1gQDh6sfqtBOSRCiuyDDISar6nLs1owku/0X+sGeE5VDffBhBfEXCLKT4v4oS/kLKDhElDYHlWvvLc396eH2I+3SmeUuC7I6PTR3+SQp2EU48mQjOE/hHry5AlmE/1aG1B5FN8dQntrorGj6QpgrIZLy8dg5dtCYHqfiGg5ajz/eVGTnaRotYNJsmy+yyPgjA6g6dJOiVwukvhr5/ahXAnga0J+Z12iGtsbtlb1HKF5qKN//qQKMUHIhoJhztdx+xf/6DfOfz7qc150UBf95nVxvyfF3gx4FJacQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGtxRUZRRnNpRGpxTGdVcmp5UWdwOWtsb1R1VGZIVWQvUzNqUFdRUy9NT2lV?=
 =?utf-8?B?Qkd3UnAyWkRsOENQQ1RUWS9qSjhJSXNvRkxWZlpmRkp4SThDbG1tY2l6cytQ?=
 =?utf-8?B?QVZhWVF5NWNwbWs5djVJeEx4ZFJMMldtR3l2bjRlTEd4aEo4VTArZzU2TzBo?=
 =?utf-8?B?WE5YVElyVWdiWXpHSlV1VEF5c3hvT1ZyQzl6ODYxdWVIZkFkb3IzbHI5L0JL?=
 =?utf-8?B?ZkxMVUZBNUNrMTIrcTNKYUV3K3hPbExsUVVFdDFjWXFTN2QzRGlkaHJIT2xZ?=
 =?utf-8?B?M1E0TXJkbEZoMyt4MGt3MEprY3hqYXBUeDhtQVlBS3pRZVgza1dKSkIybzMz?=
 =?utf-8?B?RGhkbllHVHBvT2JoUWlnQ21lMFoxTE8wQnBvSEZSSkFqY3lXRXdHUHdDZzNQ?=
 =?utf-8?B?Yk9mVTNyVUc2MlMzLzBLTktmcEMwc0JkUnR1Tk15NGRDQVE5VVFVTGlCUnAx?=
 =?utf-8?B?UmIwRWJPeUs3S2tPVlBjUEtudWdWM0hodUlmeW14a0tNV2YyYWsxcFYvSVNP?=
 =?utf-8?B?VnIwN2QweXpwTU9BMTU2cWc0Sm14MFhPV2lySVhwbXhwMzBIMVlmNlpmdWFj?=
 =?utf-8?B?YXlsTDI2Wk5NZVdHTWtBdTJERndaQ1B1Q2RwUVUxMStwT01Pa1h2eTJ1SzNE?=
 =?utf-8?B?QTFrR2syaW4zV2NPdlFpR1E1WnJhendpY3NSZFVQa290eTVmNDhmTlRuOVhi?=
 =?utf-8?B?QXhDQXZXVU5OWjNGd1Q2N0tEQTZZNjZ4OGY0ZDRyMkorOFRyUzNXY0NsaXk2?=
 =?utf-8?B?R2Vhb2ZrNXNCNU1TK0RNcGJYZnZXSEZXb29wQ2FtZS8zNG1NOUpTb3UrNGpI?=
 =?utf-8?B?em8wMTh4MUJMcUdyOWVhY01Sc04yQlhLWVFRTFdUQ2F0TWM4WVU2VmtZOGdQ?=
 =?utf-8?B?Y2hEMjVxcVA0UzJzZFg0M1hCSVIrSGtLSHROcWRmc3dDZ0F2SUtyN2hGNTFC?=
 =?utf-8?B?aHFqS1dqaGtpdnR6c1pnMVdBWjdCeGh1bVFLQmszMUxTcEZ2RUc2azZTa3R1?=
 =?utf-8?B?V1J5NU1hbSt1eDY2N2hKQ2F3N0REeU85SmhoNWJobzV1ZnU0eFdSMDErN0VF?=
 =?utf-8?B?VTNCK0xZTzhGemswTjdhcGRxeVcxNFFwanlIYTQ5RCtSSEQySmtYTVpicjlR?=
 =?utf-8?B?ZHE0NTNSaXJjTHVpT0N3UFVDVjExeDlVYzRqa0FXdHZ6dWJ4UFJVb1RXVEJQ?=
 =?utf-8?B?U2p3djJjQkVYNU5kTER2SU1tbmdXb3BlYmdBakJpZjRXcUxoOVJpWWR3WlNv?=
 =?utf-8?B?dmpQZjNHRG0wVDFad0RuRnJwWG9rYTdTVkt1d3JGK200VjN6cUJGdmg2S2FH?=
 =?utf-8?B?ZVVuOHZiOCsyUkV5b0h2Z3JIM0xXODZwSXErV0I5bTl5ZFp5SFI2NGE0MVFJ?=
 =?utf-8?B?V3RJS0dxV0srUGNaV2FkMENLV3pRMHFpOVJJTTcxZmpwdjlFT1hRU2VQRmJs?=
 =?utf-8?B?TFRFQUI5VUZDTUFEaURhdUdNdUdhQ2M5U04rVjRYdzExd3ppRTBnMFRIWm9o?=
 =?utf-8?B?VGFHdHZUSFVUOGVKNDU2NGJteHMybldzdGZid3EwRTROMTFZU2d0cTBOcEdW?=
 =?utf-8?B?ZFMzK1RHU0QzT3JrOExvangrcEw5a1BDaXJSNGYwS0NlZFByUzkwRFNUNDlW?=
 =?utf-8?B?Rk4zYlE0aUFEQzk4eVBWNElQWHFkKzU5VDM2TVlPZS91R09OKzhPcU9obWRV?=
 =?utf-8?B?VkRiQjI1a0Rmc1A2NU5mcVMvTzFkSEdYR0ZadEM4VHU5L2FJTkRpdGZIVDk3?=
 =?utf-8?B?WWZROXdDaGVTVkFEWktycUlKVmZMMkszSUNwbjNjdCt6T0s4Z3NhZjRqQk9J?=
 =?utf-8?B?dkh5NFk2aGNUdzNPVTJiYTBXNWprc2h3UnhGUG1KQU52WjY4V1h1bzRBU1FL?=
 =?utf-8?B?bFlzUE41a2tEbm41VHpsb3Z0UnkwTnYyOW9yTVkzN1A4T3RCWlBWVEdHODFl?=
 =?utf-8?B?MlRiOVlOZ3p4NE1XaTRBOER2ck1sRzlDaWlMVDh4QXM3V3o5Qzh4dUVnZ2wy?=
 =?utf-8?B?WVRxNVdEcTNUNG5YbzhvY09kWWhkaWZCWVhBd2tVY1l4U0MzbHFnQWZQeU9E?=
 =?utf-8?B?amNqMGdSdWw5UkxEN3JJT2FKdHJDVC9BUFlOTUFESk9lNDFVWnRad0FraUs2?=
 =?utf-8?B?QVdYNVJiSm9ScnVQeTB3d1dLR2RYY2xFSElObHJiV1dzYjZVWGxYV1JlTjBL?=
 =?utf-8?B?Q2VUOTFEWUpuOW55dGFyWEVFSS84QmhaZUtuamxWdVdDQWd0WU9kazB0RTQ5?=
 =?utf-8?B?YnlXTFZhV2xBTm41aVhLMUFHSmRreXVSTm0wQWRHbFd5OVhLVnpqcC8zZ1Jp?=
 =?utf-8?B?MEFjK1R3d2tKSk16a0FxTU9YMUF6TlBkWEF6U0gzYWVuRTJuc2d6U25lNURW?=
 =?utf-8?Q?lcKiWCdxvevpOePk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e983b07-251d-480f-53bc-08de7b9ba9a0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:16:03.1324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPZPOSeToRObGoq6N5L4ZJrV96954GTvLmy1pDGlZecwReWCR30ou0TBv8Ne1p2Ev2uToP9tigAfVT3PLT9zUW3B89JqPSi5pgIADTp/xvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

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

