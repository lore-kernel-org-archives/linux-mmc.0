Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013029.outbound.protection.outlook.com [52.101.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E59101E2;
	Mon,  8 Jul 2024 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438958; cv=fail; b=P2Bmee+exmFummERzOZYZfRc2FD+y85oIJsIFluherdA8xrzWgcdEduHtN1LAWWXb/Rd8/d1WNw8QTsAsi7D/xTcC5da78w4Kz/6Et52yPDbG87O6UeXFpAyItZ2wtdT1oC65Teo91PLD6vMYleQNa3h0fjy1JaRaE71th4iGxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438958; c=relaxed/simple;
	bh=X7+9YeT/+ZDgN88nMmQuQtLJCEi6hyWaJWM3+k4M/30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZJX6LF7DGaC2hlXf/FooLsdiGLbr/BfQsRZH0hzsM9PF/F9zuQJsJVLrhm7B0E20KTmVNNnPWZL01owHfpHjqhwM0z+ItEM9AfCvfTTEC48p3I+t1Nyedppz7bQqz1PgA7+2yj50Nbx+n+PtpYeFdIjU3pMoMMBh89nt4o2pc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dQPwoe9X; arc=fail smtp.client-ip=52.101.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dQPwoe9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY3R+gd/3Eknv9s5pp+7ItqgkInPBUXK1+10S+ZSLhwSaqPv7M2vJTCvcwgq9OKagqL3EoeNCgY1GGIanBAtt3uZmjo2ixRnAFCXR9m3SIHqPyEX3C7/uJ92Xn1Z9VnR5XStHZ9Oei15lZ0nJIAObUAAC6gC117pK1zSt4vITcV910SSm6/8qp7DQrr2SOL8CbWyEm6Tol2rOGJNtVu4TnkmcUBNnOm9pgm709M38SpcHnzjauKcEXoknRraISC4yrG6kGE81mKw8npmw8BnEBWMZeaDM9HS72CGhWQyX+HvEoOxNHEPSv1cMQPHexMjvWlT9warjjlM5orL9y46+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE/r2t89XnFfc3mVPBjdpR6cMj1if032yFlHxMtczh0=;
 b=oE5DhHZ3Yh/d11x5CqNuZVUrZaXNwa9cNLQ7uzU4dEoahdHbyPJFK37y7F2xcfF0JdoXvA4mFqC42ArYELNEFrRkuoQDb5y1Z5x8hMbdg4OQ0D+RDxDFgjbqfqaYYlrGqEHtv8rYQZVNOehPCQEUKn1h3ufWNSXhQ0ctfeDgOAQJbl7obDVF6kiYvGbeGPZZZuDG6mTKM+u/469eGfYwrPO3EeTikerpu6AeYlNo13wmsdjFpHuaF/T3cRDsq9uF4wk73F0xqkmSA4/nhyd17nBVcKPzkXQJ4InwUlW0EnjssuksvQtxQhSRnOi8Ufc9EJOdsYDDC1bf7rbD6dYpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE/r2t89XnFfc3mVPBjdpR6cMj1if032yFlHxMtczh0=;
 b=dQPwoe9XOP45ynNaQR4hLJv5Ry3oMnZrF/WWBj5xdypSKpbPiI9AKmQlhi7fA12o/zcORyHuMNeWXFjY0wwIM4YfkiLMtcnvgHf1d5CWVEygDeYQ2USSyb1HJQVbRTqDvaNsmd8cnGJ5muR8ugn2wu2bpes60Wy1Jjb4tUFKKLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 11:42:31 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:42:31 +0000
Message-ID: <39ea3a66-a874-4266-9788-50e87b9160e5@oss.nxp.com>
Date: Mon, 8 Jul 2024 14:42:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mmc: sdhci-esdhc-imx: add option to not change
 pinctrl state in suspend
To: Bough Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>
References: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
 <20240705134647.3524969-4-ciprianmarian.costea@oss.nxp.com>
 <DU0PR04MB9496E9EBCF92568D459F3F4290DA2@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <DU0PR04MB9496E9EBCF92568D459F3F4290DA2@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:208:14::40) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a70a96-ddb7-44a8-df10-08dc9f430cf9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXdyVUJnQmR6bDBrQXF4OFlGditGT2UxWlFGaEJNL2tXNElNWjhNMGFEWUNn?=
 =?utf-8?B?Z29IcldobUdydm9nc3dJWVp3NktJcmE0bVdoTjRxZ1Z4MGJqV1JKMlVDSUo4?=
 =?utf-8?B?UWFvdy9zVFNYaDYvazZqaXlLVkNPaTBIN096Zmk1V0hsdEF2U1BpdEhENG9s?=
 =?utf-8?B?NmU4OTdFai9PYXFxR2krcG9tUWNmdExTL0Ywb1h6Ry9RWk1vWVhHTUtuc09H?=
 =?utf-8?B?RUFYV2RlRkpDLzUvRWNya3JFbmdrUG1LaGZwTVJGVjh4ZVNnNVNoMDFzZ29Z?=
 =?utf-8?B?eFBFdmc0WUhJUVVtcWQvSkk5N1lEWFNYZXNhaysvdzZEMkQxU3RHakxhRjNU?=
 =?utf-8?B?Y1FxZGNZK2ZWRlVhY3NMVTl5Y20xMGRFSUszdmJRWkRYNkJXSlZkbVRyYVZX?=
 =?utf-8?B?dEcyM1dHSFB1RkZqa3VKZ2xrVnZ0U0xoazNha3hHK1l3c241d0ZJRlc0dUF6?=
 =?utf-8?B?cVFhaE1SZUlHdk1rVzEyT2JMdVRKWGdhaXByaENLNXB6aFZ5SkNSWStFam85?=
 =?utf-8?B?djArNnpJVmg5M1g0TldsM3lKMlZCYnM2bVNpZXczUXl3ODlqcG5KdFdHWFJ2?=
 =?utf-8?B?VmtiSlFiS05NeXI2RmJjV2RxYVpuNlFBNnB0U2NQSlRCRFdOcEt4ajc5UFFP?=
 =?utf-8?B?QjcxSHJ3RmFBVGxZOExhWVJ2UlUxVXBYeEFqVTdkT09URGRQNTRCQUNTYXRR?=
 =?utf-8?B?L2dEWi93Y3RNV29rVDZqMjFlU2I4UzJsYjMydC9uaS9nd09UMy9yZ2dYdytE?=
 =?utf-8?B?aEhmNnFTRWdWMjh0bmY4UmF5KzRqRmZhQ1R3RFMrQzZ2RUJnUGRDazJRYnZl?=
 =?utf-8?B?d3dicTBNYllrQjZQWUsvVUFha1pZdHhqTFNrVnBIZzhPNnJ4MUR1ZnBZa0dw?=
 =?utf-8?B?bWMrUE5DZEVVVnZKNWY5OTZkZWtoeXJMK0liZkRNclFZeFdPT0twWlBOSGdi?=
 =?utf-8?B?d0JCSWFOVmhZWW1DcE51YTFSMHdtdGlzM1VPZFBGQU9WbGc2RHp6RTJMdVQ1?=
 =?utf-8?B?ZFhTTTRzYTZtTklOaElCSkRXbCtOTzEzUlFIbzUzK0tmNFl2c2x5QkhRRlla?=
 =?utf-8?B?Yk5ndDVPa2RkSjFzRG51bkJ6RlZqTUxnN3gxWmxxdGRrcEFhMjJEZDh5ME03?=
 =?utf-8?B?SlV4NWowb3hwbDVyYUFwVkw0c1pNY2NBQnFwaFpPeXl0b0JjV2R4cEdoUnl0?=
 =?utf-8?B?QWQ2dzl3QWh5YUhOQTNha21JNkhpL2ZKa2M0cGZUZDdESDlaMkRrTHZlLy9w?=
 =?utf-8?B?RmJRWFhwYnVSRiswVEFreHlrd3krdlQ4N1VDWVJ2aERXSXdFVVQ0cnJ3Qk5X?=
 =?utf-8?B?VnZOMXdkdyt5OVArZzlUKy9tN2Z4M3VkbTR0dnpCYzVlblc2alJWY2NKVmRN?=
 =?utf-8?B?bG9PZkt3endUWUJuZkpYV0RrbmJER1NmVklrVUpPMFBDcjJSZHhKNVdWTjln?=
 =?utf-8?B?aldmTytReUR2V1pOSThiNVR0NXJ5Q2xpZnl6S0tiWHdEeDg4NGJHdVprak4r?=
 =?utf-8?B?RHZ0N3hsUVBTQ0NwM2t2eWtHdEdkRWpUVkFtV1lnc1FEMkErMW9CV0NUc3lN?=
 =?utf-8?B?NWZ3dHBzczFrVUZaTldqN21tdVYzMzRxK3grZHMyNmc2a1pRcmtwT2hJRjkv?=
 =?utf-8?B?dFJjaHY3Y2o0R1MwT1MyTDVLZUcwcmpSaWI0QlAwTU5NWnJMaFZmNk5kU2Nk?=
 =?utf-8?B?aDltRDVHTGdxRmVZZlcycUE4Yld0ejNFWEptaUp3LzZBT282NU9uV1MvbWts?=
 =?utf-8?B?dDBOSDZqenRNSlY4RnRyQStkL3ZiRWdReHVuYW5Fd1IxdmJ1b1hGaGhrcHo0?=
 =?utf-8?B?bTdWR1lxQ3RTVnJqZlE5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlFwR0k1VDJyamd0Y1lqTHQrdlZoMTdpb0JOQ05hNXIwQ0xjWmlBUk1ISkJz?=
 =?utf-8?B?aVhSamJaUlhtWWFQeXZCMkRieHY1OTY4OStZNjh4clNrVXd3WGtsSEwzc3JR?=
 =?utf-8?B?cGZNSm1SV0x6dVYzRmdUWFVkQk9pYW85UFBReFRwa2xRSG9ZV1V3QW4wMlY0?=
 =?utf-8?B?aWhiZm16a2xPeXdWZlZvclpxcVpVbGVDdnJuL0JmU3E1d2RVd01GbFNsbHdW?=
 =?utf-8?B?RDUzc1JsODROcTE1UE9OZVluc3BvTkV4UkdGejJqOU00MkxHUHpzSVdvaVhH?=
 =?utf-8?B?Ui9KUW9ta2swNVFTcUNKWHpCSlJBeVdhNU9JYkxVWS9xdExNRXVnL2VmZElJ?=
 =?utf-8?B?OXBoRTExaW9KNEpoRzB3RHJwRjg2ZldQMGR2eUhyK3A4VEM1ZHhuSTJsMHBi?=
 =?utf-8?B?YzdrWkUycGVMc0hLU0M3c0pBVTZtMDFYZWxMTUlnczFpMWFVNXlvNDdGNy84?=
 =?utf-8?B?ekQzRnBWTnYyMkwxOUorVFBCUXk3Q2NoOTVhSTJEeWxISmVsenBObmNJd2xx?=
 =?utf-8?B?cGVQaGtSK21kZlc5d3BsOW13ZSszdC9tOTJYWkRiam1VNHQvdm5xQ2MrLy91?=
 =?utf-8?B?Rkc0MGlLdEJ1ZWhFNUgrVG5EMllzczVFb0d4cnI0Wm1JNkN1VFAzSUNVZ0tK?=
 =?utf-8?B?bmc5QitiUzg4NlIxejREWDkxZFhERG9zKzVuZ0hLclV6OVZvKzhZMWlvcUE1?=
 =?utf-8?B?a0t1bFl3R3B4VE9LdkVBK0xYdTFJSjJOVjVNeHhlU0I2dG13dWk2bVNlREI0?=
 =?utf-8?B?NFViL2JXbU0xZDNZQ1BMaXJRb3R5TmpqY081dTdGM0xuVDNpN1B0MWE5Rzl2?=
 =?utf-8?B?TG1qeHBmR0V5ZW9Xc1hWellqRnlmOENtMUtFSG00eUczVEpiR2RiUnJ6a2RQ?=
 =?utf-8?B?Ykg0TVF3YkdEWXdMUjdKRmIrZWdEZUIzeU44NWx4eXpKaWR4WXRKdWsrdGZy?=
 =?utf-8?B?OUR2MThnUVZKWVJGTVdPOWpsNFQxU1M1QjRTdGkvdjBTZmJpOVdsaWlSckpn?=
 =?utf-8?B?MWJhLzNiU2lBTmtUZU1GVDBrL2pKZUxaektIWHpuU0liMjVMZnRDRW43Tjdi?=
 =?utf-8?B?eHhXVjRGSHU3dEJyWEJzbGFSWG9hUkNZa1hJUE53UU1KYXU4WFhRRm84cC9u?=
 =?utf-8?B?Q0QwamlvS0wvWVhQOHdpMTZqMjNuSVE3S1JwQXFjWG5FYnptVXQ0V1dUK1Vl?=
 =?utf-8?B?TmdCQng4Q2tIaEFJUnMzR1dLQWVkelFEZkZQZFZ0bzk0SGZOSFkxMHpNL1pQ?=
 =?utf-8?B?V2c5bFZMdzVmVjJTa1VKNElBYjhNakl4Q0s3QzB0MzZaRUtYbC9wbk4vekgz?=
 =?utf-8?B?d3dTYVNXdFdNS0o4SkR4RXUzclFJOFl4T1c2ZElDL0NOUGZIYlhqYjhvNWJY?=
 =?utf-8?B?ZXVIUC9rTGZLdkhmcWhqU21VbzNrOUQ4dDVReUV3c1l0bFdwMnJoOFlBWTBo?=
 =?utf-8?B?bWxKdm9CNWt3dHFlQ1Z5SDY1ckVqYjFYeVBaUnVTTnR1MitHVHpLdVRLaDFv?=
 =?utf-8?B?VmV3NmtPMndHeEROaU0zNSs1SGh2TXB3cStzREZUTU9IU00ydnp5eTZBRk5N?=
 =?utf-8?B?bDRjc2MzNnJSdGtLUHRORlRQN1h3d3pablpFMkNBcTFmTmdlQTJUSDNMOGtQ?=
 =?utf-8?B?cXhrUU5ya3Z3QzRiamlSYXR2S054cWpEZURUWjVKL3BqZTZaNW5nMXE1bmNV?=
 =?utf-8?B?SzdpcVZUUUdjRXBzdi9maloyNUN6SkkweXNFN21QU2tGNk1mb3pkZ1NJV0FC?=
 =?utf-8?B?VTgyNU9HRXRXTUY0RklYa05lL1VoMDdxS2YzSkFLYzdoU09OK2hXL0NLbTBa?=
 =?utf-8?B?WmVNRXo1K0RueDlJS29xaVpyT0lVbm9HOHBqemk3Z2dPMnRzL1pnY09UMWdG?=
 =?utf-8?B?OFE3TjE4ZTFOb3R3Y2dCM1dSYkxDWFhwR2FUcFFUb0lkUHlBRVNvTGRwVnRM?=
 =?utf-8?B?ZTZZamNLWXRiRnU4TTZmM28xNHVWS29ZcURrc1dUZzBkYi9wMEFZZ0psWXNr?=
 =?utf-8?B?TlVIZTdKdSsrWXZDcS9Odm5IWlE1M0tUa3FXM1RuOXp1MEdmNXZsK2x5eDA4?=
 =?utf-8?B?TjlPYm4vbXc1VUZJSTBsMm5NbkhZTXFHN2UybmtuSTA5bjBhU1ZRZHZJNHQ3?=
 =?utf-8?B?YlluU1pSQ05md1kyK0JTNFJPZWdRTWd1VVgvT2JoRWh0VlJKYXg0TWxFa1hB?=
 =?utf-8?Q?Jf0+390bUEyp07mB4MoFcaQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a70a96-ddb7-44a8-df10-08dc9f430cf9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 11:42:31.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCk0oxi25/QBazHM2RiJcV54vKzOYxNsNacwYVBhdtPFYCqUGR5aBgXa3UJ0douu90warKo1nPWGbmzxBROnDZz6RUvfduIEArM+QQjuc/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7055

On 7/8/2024 5:33 AM, Bough Chen wrote:
>> -----Original Message-----
>> From: Ciprian Marian Costea (OSS) <ciprianmarian.costea@oss.nxp.com>
>> Sent: 2024年7月5日 21:47
>> To: Bough Chen <haibo.chen@nxp.com>; Adrian Hunter
>> <adrian.hunter@intel.com>; Ulf Hansson <ulf.hansson@linaro.org>; Shawn Guo
>> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
>> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
>> <festevam@gmail.com>
>> Cc: linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org;
>> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org; dl-S32
>> <S32@nxp.com>; Ciprian Marian Costea (OSS)
>> <ciprianmarian.costea@oss.nxp.com>
>> Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: add option to not change pinctrl
>> state in suspend
>>
>> On some boards such as S32G based, changing the pinctrl state in suspend
>> routine may not be supported.
> 
> If so, why not dop the "sleep" pinctrl in device tree file?
> 
> Best Regards
> Haibo Chen

Thanks for this suggestion. I verified and pinctrl node is not yet 
upstream'ed for S32G2/S32G3 SoC.
Indeed, 'pinctrl_pm_select_sleep_state' would not report any errors in 
case 'sleep' pinctrl is not defined in the device tree file.
I will drop this commit in version 2 of this patchset.

Best Regards,
Ciprian

>>
>> For this scenario the newly introduced flag 'ESDHC_FLAG_SKIP_PINCTRL_SLEEP'
>> is used.
>>
>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
>> b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 8f0bc6dca2b0..c3ff7fccd051 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -204,6 +204,9 @@
>>   /* The IP does not have GPIO CD wake capabilities */
>>   #define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
>>
>> +/* The IP does not support transition to pinctrl sleep state */ #define
>> +ESDHC_FLAG_SKIP_PINCTRL_SLEEP  BIT(19)
>> +
>>   enum wp_types {
>>   	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
>>   	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
>> @@ -301,7 +304,8 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>>   	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>>   			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>>   			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>> -			| ESDHC_FLAG_SKIP_ERR004536 |
>> ESDHC_FLAG_SKIP_CD_WAKE,
>> +			| ESDHC_FLAG_SKIP_ERR004536 |
>> ESDHC_FLAG_SKIP_CD_WAKE
>> +			| ESDHC_FLAG_SKIP_PINCTRL_SLEEP,
>>   };
>>
>>   static struct esdhc_soc_data usdhc_imx7ulp_data = { @@ -1884,9 +1888,11
>> @@ static int sdhci_esdhc_suspend(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>
>> -	ret = pinctrl_pm_select_sleep_state(dev);
>> -	if (ret)
>> -		return ret;
>> +	if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_PINCTRL_SLEEP)) {
>> +		ret = pinctrl_pm_select_sleep_state(dev);
>> +		if (ret)
>> +			return ret;
>> +	}
>>
>>   	ret = mmc_gpio_set_cd_wake(host->mmc, true);
>>
>> --
>> 2.45.2
> 

