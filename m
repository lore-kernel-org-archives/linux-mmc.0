Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE13AE6FB;
	Fri,  6 Mar 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809918; cv=fail; b=skJR9fLh+LjP3ABG098lATh/S+97jRAsROJGkjXbb5bvhdBj58ByFKuKy3VV4hZBUyXFrVxdocmF1UkLRVI++sGbDyWGZKvjzOYsTSuTJ9EtnWO9w0OY94/mb88dl/i0qYTBOBuvTUY2R6TYXtc62FZJJi4EtYdQWuQWn8xNhr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809918; c=relaxed/simple;
	bh=IG4Q2BS8R5pzXZEmuwOuXzur4HMLvSJcePtNrmqTHkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDeqiSnSU0iJGa+HWlNtSNupzbHKnjXCLPl3pKTHAP9UyMfH4CB9+bzT+HOIzPmIAOPk59jAEZyCzs3mdlBSTVPX///2725kD1as431Rlzawrtj+modoofD5xxANykYpyOw1+ACmN7kyym/4hBcGmJCuSD78dnxthTZwXMn5Md4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Jeov9c+v; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jeov9c+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COqULh0Bbo/gDIEY8mp9iUii6M9ZxrNesJoD/n8AI3NynFuhMzui7L7M5nhHG01NbURKRa/HLnJYVT8vLSq1AfuZe0iHBZwym2lDECdXo4KD7pu56caNcBOMa5XWd77+ppLur78AqiSbOg4XSDAyr5vNaB9DuJZJ8XOa7YOfIasBmCi7S/4TprByNMSnh6IwjZ9wbsW2tj8nIy9GvYGaoCgbpiJN9OAQTxNlgwIAOL2vb0s23Z/9uTpRPeh/HUijmh6nJAr87Py/oGaXlBQvB9OZ2TwTO059ihX6Cz5QQRArZUzygfYXzhj18ciz09/LvvRyRizP+12ZENkqO71iYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTpL4oxtGqAc7MbYn4ap6a/tXkYV8vduPpyHFcU4nmQ=;
 b=lAaad9bmRMl+E5cwLFMMNzjLZ6bHcZv+VDhQECKOZJqZR/eGmrt20kYc6DIcWWpxs/6tq6IaVA/w+EkjVTUXL4RMhUzm1WOGDOcupkMFhNEE+sewtNgARnd8V5g2nPro9taMZPKIhmMsCiL453UIcs7Ec267pR/L0QUWk3yTRwEiusLFQiImaHtQDji5Y6Jib9LbpgyNWLGKu0RTIpv33IvyxBEbBcDc8WZQkf/WsHjsYbSTy50W1MHuHyGRl/XCxpXYlejMXQ1kxxHmZ8Csn90pI2xrKD/G1e9dVyZH44Srkuk93vckUEPwxOHBGGAopmlUdBQKKaxFxHst52Xvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTpL4oxtGqAc7MbYn4ap6a/tXkYV8vduPpyHFcU4nmQ=;
 b=Jeov9c+vvlh06HYBWrEzbclEXJe8L6dLlVOf5Os8xjnByUasJFCrVMrsCxH5to8848yMZyUJzT8QJm7rMty5zJyStLrms0gWRkmA/loc/3cBrRPJJbYujCrurMNZpWnr4Geakrky20qq9lyfjkgrVRXYRzVxH5QkaJcIVuSjZW7SgskoX9KTEislNBbokTlz4I2obhI14ZPYUfIFsrtG1vY6QjBafoeGG/xbyYLWGfmrb69SuSIA7inYtrkwQwubQzqRBJdPrW23H2JNl8843v7YUiEgZqUw2zsuxipNB9+9NfvEP9xMZORsGDV0uKW6zyOR5JmHDlKd3NGllzbUIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 6 Mar
 2026 15:11:52 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:11:51 +0000
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
Subject: [PATCH v3 1/8] dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
Date: Fri,  6 Mar 2026 16:11:40 +0100
Message-ID: <20260306151147.24446-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::10) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dce5e1e-d349-4103-ef7d-08de7b92b21e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	GK+iO/lZv/hyAowUvuBvIBGKXaKw+fQBmu5mUVMca2C1lUTTA+7x9PyW9dGgXvy+Wx6JAwt1lJZf8DseyjJC9DIj4K+c8JxuF1HtBMMkIrtkipljvF0LzrgdewY3dCijMxomN0MLV1UWdVcEd2Eb9pRGnpc0kjqrUtxymmI2qG95M1vTGcMmzHzTFWTMFPel/6X5KFS+np/HPFKwKtq81ctQL2GtvZh0/oBuAa/ynngHYPL1xMYU04MDSL+QRhYvrro50IVOHPVrWGJXpzyIFnmSXUIcLr+ByyiZbcJ7RW1MbMkId2Q3HaV0Wi2M0SSTorJtlPm2hMnUZBOETjspGkHbj+fgvoRiTJgtrOvC2+4cDFxcwRzK/VUEDm/R2yvIsYqsiAjWkU9CJGm3Kf9t7SZGIAXVPpIsp89X0rFMf26sj9pJA94P5DfA+sTJTvsypLal9XwF0beCvjjkkNbd/vb6gJMqaSItPU4XkvkeR2e/w4UPPZzh7qEylW2TD/BpiqVLJsq3i9hTLCG6+VOYW7TAHSvWpPDmqhpSj2MHiaACnSQ7k/9oI7Os3jnF8pLqsd7ffhzWU45bYViMBe1Y5Vie9uUjPHLoRmCUNYvoNIEU/UTW3ZwcyIsbvpbU1BN2ariweiD4AoONVd4PxXXdXSRkwFfgESSpWw3i6fo4qI1N/XTh13lEWbqlzhZbOlyNZ8LaZtforlBXfyoJbl1826KM2FpPahE4I0RQfyVRrQvzBewl8AulHaYn6duoCiDTi3iwrha0NdWBze75UWtt1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmViRnluNXp1c0VrKzJiTE1rUzIxU01ybDM5QWxvUWtQNDR3WWtaRXZqdGto?=
 =?utf-8?B?cGJBT0RYeE9ac0l0c3JKdFJoaWc0VE04Z3RBbnpoOXdoMmNYdVZ1a3lTRW1Z?=
 =?utf-8?B?VEN1cEMzR1dJQWFjL242cmFKeHFoY09mMHpyS1AzMVdwNXlabndIT0luWXA5?=
 =?utf-8?B?RDU3N3E4VloyQUNtQWFleXdCcGFYK2N3S3h1bUNmN0JrVkxvcVQ5ZVRtVXZE?=
 =?utf-8?B?RlNXekRaRGlPa1Y5cVZyNkRsWjVxV3UxdlNvaHA5NVJYUW1MMnZndXh0emVw?=
 =?utf-8?B?UVZub29STnZsNGVWb0RNQklxd3hCSzFXb2lidW95QVpsT2duWEtJZGtWUHFr?=
 =?utf-8?B?UFRKckpldE9OS29TRDh6NUo3R2VKTDQxTEUxZHk1YUtrZ0cyd2FJRDhyT3dW?=
 =?utf-8?B?c3hxM1BpVXNRZ3dDQnVLWklBbU8rakFUQVdlVWtkMXdRZ1VhMFVRazVVSkFU?=
 =?utf-8?B?WGVzUDFJNXI1WXdHUFNrN0tLREhBSXdiUk5DK09KcnptbStQSFFlMForTHNE?=
 =?utf-8?B?dHBDMGwzRXpVYkY3cHZ4djJVTllUcTliWFRkMHdMUUJLOEhtQ21qQlhzM3pU?=
 =?utf-8?B?Zm0rOTQ2Z25KR3I4eVNuNmQyNmgrRmxBS3h3d05HZ2NwNENJU2tmMnpENC9t?=
 =?utf-8?B?L1pYaUZMa0NaR2ZoZjBXemNTZ0Zpd3NrcThqMUZqdk05MWFKc0ZteS9SQitZ?=
 =?utf-8?B?T3ZaN2FCNko3azFRckFOUC80SC8rWGtPa1poZktWNE8wd3RCRHg1bVVJYTVw?=
 =?utf-8?B?NTJBUjV0d1RIYW0rbWg1WU9kcEk3aFBxVkRmejl2KzRGU01VY1N0cmZZVFdP?=
 =?utf-8?B?VG5DTjVycGNQeTlxUitheFBPYnIzVXI3NE40b2pzQ1lZZmVKM3A3UVVDcVdK?=
 =?utf-8?B?a21pclRncHY2K1pzQXBUbnMwUlE4RzJVU29LZzN2MGdtUWhRNWpQY291b3R4?=
 =?utf-8?B?bTF4M1lQK0VrQXhBejNnSXRuYitZNTBlQlFseTVhcmdxQ21USWRRc2kvVmQ2?=
 =?utf-8?B?RDBiRkVKSWtyQUI0TzN1VFAxWlZaZXAvTUR1NmhpaFBpZWVpRUxQcnp2N09D?=
 =?utf-8?B?dCtvUmg0V2FCcjAwOGNsSTFIRWgyM2d2d1dvTTZoVXZEUGp2a0hlbTJDb0xt?=
 =?utf-8?B?aGNtUEIxckR2cHFhUlhZaXpxSUJKMTEvazVydFQxN0ROemk5cE4ydEhEcHla?=
 =?utf-8?B?T2VZQUViR1QxamY3Q0FzMndUVFd0NUpLZlYwSFowdDl1ckh2d21wMUlFZmlw?=
 =?utf-8?B?MzRZNitPMXVubk1RZ293bCtPdlRUSGg4Z09kSGR6RklqLzVUSnBhRVBPOExn?=
 =?utf-8?B?NENqcEt3ektiMWk3RnBBVE9hQWQ4YjJNVE5POGdWZUpkeER1YVZQanlpbmwv?=
 =?utf-8?B?N3dRTURoTW10MEV2STkyNFJlVEdvckhhK1IyREl3THB1a0VLL3htVHpKd0JL?=
 =?utf-8?B?VjYzT3hibVRtaHZhbmZlK04vNTA4VzNZdGQ1ZFBGWXNvSlU4WGVoSUt4MHVI?=
 =?utf-8?B?cEVWZVlzV0RhZ3BrUnR2eUpObnVQa0FDQzl3YzZSUGx0Q1YwRTBxUWtSdGJn?=
 =?utf-8?B?N0UvS2p3TGZ0WHQ2SWh6Tlc2TzExRnFDUUM5eDRLbXNuR0Mxa2F3cS9yQUJ1?=
 =?utf-8?B?Lzl4K2pOYVNibllUck9IYnRsTU1ucVFmcmxobzFvWlBYN0xSU1QxbmFMUmFy?=
 =?utf-8?B?RWxnamIvZm1xaGNPci9UL2w1dERKWmpqWG1lR0dzUXpaWSt1bEtsUTlZbFFB?=
 =?utf-8?B?VUlIVDBubHJCN0JkYTRHZnZDdlIzVi9kMSt0VlJTa1dDekNqOEd0UEc5TExW?=
 =?utf-8?B?LzRHWkNuRWdJSlBVMnoxN1drM0c2MnZ2bTA4WkNOZGtjdWVoRFRhdFpRVXcr?=
 =?utf-8?B?WUE1RzVIZHl2YitkMy81M29sZ2U0bW43dW5adkVLOVJYVGI2d1dBcGJRMnlP?=
 =?utf-8?B?aE5XY0NsdkYxSDc3cFFRQWMxOUVKVzMraVc4R1IrdEZmMG54M0xYcVk5dmtW?=
 =?utf-8?B?SDN5SGh4U240TVdNbWdrdThud2tFSnIxYmx3eGxEUDRXWkNHRWpCMUVjMm5J?=
 =?utf-8?B?aE9JUUpTMmFpd1lyZmlZWmt3UHhrZXpXN0V5MXJoQmRFU296WmliWlpMZlY3?=
 =?utf-8?B?R1M3QnhGd2lVZ1pLZzd5QnZkRVlJQmJCV0RiRTBXS2tzOHNLZ1k4R0hEelJW?=
 =?utf-8?B?RVEzWHovQjcydjBEbWNrVXpNSzlZNUh1N2lvd2Z0M2tVSzc4ZTFCb3BERVJh?=
 =?utf-8?B?SEV6VGg3RzI2cmQ2bGN6RXh4eklEeFgxZ1hKQU56enFQZ08zMVRvbGdJbnFl?=
 =?utf-8?B?YVdqQ1IrSzM0U2YzN0xjdTZ4cVlYaVh2Wmg4bzdBVVIwRE1NZ2FiQzMvWDR0?=
 =?utf-8?Q?au4AXo8TZDsL+dwQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dce5e1e-d349-4103-ef7d-08de7b92b21e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:11:51.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfH2zBpgLprO+qMYEMpChB/ZcQX6qtqwVifOz3FF/WEb1AFIz1oA+ioagyI8qPZf8rPpLdZQCCBgBVmu+67285l+ngPPKxu/fuIDKTIi8lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092

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

