Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185715FDA7;
	Mon,  4 Nov 2024 02:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730686319; cv=fail; b=ZJ9wieeiv3jwuqe/zI9v9YWelebLdyC47Y0bbyum9FBS4tON+H906k86Aop3T5eDEXhHx1BfshkeCEFA6qcdCAZjWDOJxQDE0V0ZDNGbENYoCQg3LNCgRiB8F2fxCxNLxfhca5KfqXELwodssUmZm34kNBCGyFQmc1S48sLxMbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730686319; c=relaxed/simple;
	bh=rxFyxgPcauA7ge110bipvDq3kr6DUs5NFLJYTkwzQXU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XM1jAmsnT0R+KeLbPhMebSw4ruqdwoGiph8uyzrrTIXDbbGqw57e6+BYcxWmZXrK8BxcNcFJ5FyTwW5/jRC7PdPrx8MN4EQXCFEuwTsqpmpMu3Oi1McHfz4ZiCMAbFqjkJDzdwqW7o47zZpNDnTkHgWn6dftBNAyuptRDONiMB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eHE5bUgB; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eHE5bUgB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8LSDlsBaSgFjZcehsruelR/XuBJHKA2F2ac02AIh9myg7smoMYQ7RRpCJnPL16t+AV8Thv0vGupocr9OALXJXdJYzP0pYsI5xUX1c7SurhGhnhau8Nu4k1otjz3MBuAOM2oVhjxRuyHQ9r5F3OskQtyqzKNZ8nwlnyVT4roDhgV/zrjY4QfX3hJIkHYnCa0GWKocG3/99BRoOfxw9iNWzDptUPn1VKidA04VTQpb1YsE/esxIHjY18wedrBv/QOMkP1T/JE68F+2+D9DTNi25aFcZdI0CmTwx9xTV0Wk6hi9lH1waLOJNZJR2rISFTeg1iRtX8crAwG+O7G3NuIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxFyxgPcauA7ge110bipvDq3kr6DUs5NFLJYTkwzQXU=;
 b=qt951/z9NjmW9pVkEVkz9HeoNXuFdfm7RE/0OQ30rPG9n/vd5uYaSIiZ0CY3e+6BFcsFTitzN1tJQQ6KYUnQSXEGKOwCapaavmdefDbpp/H94NOLPfRBnmnGDHMnToRkMGpfaIjimz3O9ejOT+dv/0DNql11GFUHKkk8mXHhzs4nK2eeGly32Wu+USLkmoTb5Af8dwyRGm0BWlKt/GP7EAWdsKRBcrIJBkaKpxrSK9OHavoZZqErsak5TuTMGdASVrRnHkWf1Viq0B1J3IBaxNfZskNYJGjY4tf8Kyk9stNMUjj4rI9Tq8Xy2W6/No4VOImBr695wqrh25mJ0au0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxFyxgPcauA7ge110bipvDq3kr6DUs5NFLJYTkwzQXU=;
 b=eHE5bUgB5E739L+yBdJnL7x1BlFyoGJmRndRwzeqSfFVyazHjtLfAKJ4arkPgeoy70iqcvyjXWnHbS9Otj9E28qj9C3st3EpFnIhvsvMA41tH1NvS/hEwLurUAxBnS4YjwyHxt4b95snMfdW6yyBxkMhfCj740qrm+Bw6HMIBgig72orSELbonR6XejGpo1C8zxUm+GYZ29kDHcXW9uJKzdIsVrj+CXIbjenZEhiA/c6S9KNz7KPqPDU94XzPealM87rk3XduNLHDoeGJgTosPfBLwexWSYK18LzU/bCa/DDaHLpg9adSJ4JiiRQe6Lt72UqtvjFSO06VDJUB5w9fg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Mon, 4 Nov
 2024 02:11:54 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8114.015; Mon, 4 Nov 2024
 02:11:54 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Josua Mayer <josua@solid-run.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Mikhail Anikin <mikhail.anikin@solid-run.com>, Jon Nettleton
	<jon@solid-run.com>, yazan.shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] mmc: host: sdhci-esdhc-imx: update esdhc sysctl
 dtocv bitmask
Thread-Topic: [PATCH v3 2/2] mmc: host: sdhci-esdhc-imx: update esdhc sysctl
 dtocv bitmask
Thread-Index: AQHbLFMlLeKD0gGJ8USjux3UkFQLg7KmZQ0Q
Date: Mon, 4 Nov 2024 02:11:54 +0000
Message-ID:
 <DU0PR04MB9496E067FFC4B78C0AD0725490512@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
 <20241101-imx-emmc-reset-v3-2-184965eed476@solid-run.com>
In-Reply-To: <20241101-imx-emmc-reset-v3-2-184965eed476@solid-run.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB8021:EE_
x-ms-office365-filtering-correlation-id: b9fbd52b-7933-4069-f41c-08dcfc760d71
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K3Z3UTMrRXY4MlFtTktxdE5tY3V0Z1ZwS0JFY0VMMTc4NUx4ZjY1aUN5dFRj?=
 =?utf-8?B?SitSU2ZhVDR6anVXYWZEdXVVc2w3TW5xaXROZHVXQkphVTRuUTNYeUszLzl0?=
 =?utf-8?B?QmQyZUlFZllkZHJDNzdnRXFoRHM2WCtMYmRzbWdvK0xaZzgyNEVrY1FrOThV?=
 =?utf-8?B?L0plQzhBc0hSdUVqQStSRTVWcmlSTmR6VkhyTzYxa3dVSlhUVko1ZCtmTjV3?=
 =?utf-8?B?djkwdUJXWU5icnpXcjl3UjhrVHFzTzhHWG5tQ0FsR1NHTGowamVBVHBVRGdr?=
 =?utf-8?B?TEpvR1lLTysxdHpnYW1xaHpYdVBTNDJNb0pxMTU1MllJN09xTkp1b1RRNDhn?=
 =?utf-8?B?REFhNUVXenZQWmpnM1gxNVBLcEg3aVNqRzZla21yVGVCRVhRcVVJdWlYUGN2?=
 =?utf-8?B?ZTBHUDFyTWozUGIwMGhBa3gxVVprNzhkWWcza0hJN3ZNSVBwYVM4eGZDWVJs?=
 =?utf-8?B?elNIajhxYlN3M0J4QUtNSFl5djNHTWIvQ1lDbVM1MkVXYnMzQUFVRnFUNnBF?=
 =?utf-8?B?Szd0OXQ4VUNKVGxibXpTYTJ5MWVxVG9EUmdra1R5enhLUFZWWEVnTXlkMFpQ?=
 =?utf-8?B?d09vVS9QdkdLM3F3RDJBd2dKNHZtb3MwT1RmRVFkVU5hT1dVY2lXemp4eTVy?=
 =?utf-8?B?YjdLQmNScGxSS1cvbG8vVFBMZUtIMVdQdW40bVluYmpOdHR4MFpzMUxTNUs0?=
 =?utf-8?B?Y1liYzJPR1FIYUd5aGN1QU1LWkVweUV6cld1bkVwU1MvT2IrOU1PV0tmWFlV?=
 =?utf-8?B?L3I2ckV2TkkzVkh4bU01dzlpSG4vMmhic0xyUGVTQTJYWDNTUk9PMU4zcGhU?=
 =?utf-8?B?cE0yaUdVTUlzS283WVRDYzlrRjUxTXpNWkF2Tzl0WE1ySEppaE11SWFrSTI3?=
 =?utf-8?B?UXdTcGlhNmFmTmRVWmFhc3VXSEcyRHVlSVVLTU5SeWZ4RzIzclRVVVUxU3lO?=
 =?utf-8?B?YUg5TWhBVnorais5QkQ4TWNNK2ZSWTVwSFl5cW9QMmtJaUVoY3FSMjl0TWdZ?=
 =?utf-8?B?YlJ1ZUQyNFRucFlWcnA4TEJyZXF5VDJqbVpqU2RSL2VERldZVzlXQ3h5Rmhz?=
 =?utf-8?B?bi9qMmVmZnlNZDduNTRWM29yRXczd1o1MmZ2Y2laSE5hMzlXTEcwQ2JkSXk0?=
 =?utf-8?B?RFFlaVBVUFB1bG0zODByRWN0c0o5K0p2UTVzWE1xSkE1cjA1OHFnK05PcnZu?=
 =?utf-8?B?eDJVWWRJa2poMXRhQjd4dGhCRi9wTkltUHlCZmxneGRYR2lvblVPZ3IwM0Rv?=
 =?utf-8?B?RWdoa2NVdHArelVnS2JjYlRLaGJZb2pVL0hKZ2dEc1UvL3VJK2Nnb1c2azkx?=
 =?utf-8?B?em03WGhJa2x0R0VWN0g5VkFQYmIxUis2cXBSTVhwN241bkRFc1NXMENlaXJx?=
 =?utf-8?B?T1FuZlJyTVR3TUN4bnhoZjhXak1JTmlLSnhvVUErYVpWb04wT3pNV2FoQ0lL?=
 =?utf-8?B?eVA4em5NUGRUYTFOaVNOYUtEUW56Qk5mOHNYeng2WGFPOTVvaGFYalpsZnh2?=
 =?utf-8?B?Uklmb3piVDdzc0hrTWUvdzdvQnRpNFJJYWkzS05NbC9BRmNhQ2tyeG1YWnZL?=
 =?utf-8?B?ZGhOQWs2aTVPeWFrd0pCQjZERngxazYzd1pjZmMxRStiZ2pMajFFREJsRFpF?=
 =?utf-8?B?MlZESVJzTnUrK3BqbXpacHNaZit0eURJbGlZRnZDOUgvTlZSbG16eG0wOHA5?=
 =?utf-8?B?SXlRWjdSbzArYkNPMVcvYUpZSlJtYzdNRStnYy9kcDJvUVRVK01rRGdLVTVr?=
 =?utf-8?B?K3NXU0NiQ2w4QzRYVk5UcUZNT21UVXh2V0F1SnNjQTMrSDZscjJuU0JuZENp?=
 =?utf-8?Q?ETlFfZ6GjFb24jnCo+ueS/oK9d6BshznwOu24=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1A4MjVqempHSWJHaDBCSy9HbWR0aWl6RUpoRzRQNlJsNFA2UHFpUnZXWjZZ?=
 =?utf-8?B?cWJqNmlqY25HM2tlUVhFV0drcEp4OTNEckxqREkxdjBGNkVERExhT2IwdnZj?=
 =?utf-8?B?N2lkSGx3NFlsY05EaUt3N251d09zTUltRXpYTUk3SVBkNi91dGlQKzUyNXdW?=
 =?utf-8?B?WVNwZmk5TDJWZWdJQnl2VnNIOFRldkErMWNEWGdoOWRWZUpjZFl6cFB6ZCtX?=
 =?utf-8?B?bFF0aThPTXEwK01PU3JDYkJVcDJrejJuRW9zK1l1VllxQ1krWG15ek9uaGdu?=
 =?utf-8?B?R2tPWkQxNzdTY1l1ZVNLaHlGclAxdDQ4SW1tdEJEcE9heDZPWTFvTUtjVDIw?=
 =?utf-8?B?TFA4Qmc2aTJHU2ZqTTh1SnZONXFyR2tqWG1UWHpxSnNKU1JwRnpJQTZHUE5R?=
 =?utf-8?B?U1ZuUEowcHl2WVBoaTNsOGJZQWgrQzdsVkMxcExKQWJYQ3A4MTR5aFJYK1R4?=
 =?utf-8?B?U1hUU2JKajY4TkFFWE9UQnJJWE9NYW5UTndHUTJYelV0YzlTM0VKU0FscCtZ?=
 =?utf-8?B?M2pQalhNUDFYVjBRQ2ovL0ZqVm1xN1h1K0pLejdTa2RDUGFNOTFEU2E0dlVt?=
 =?utf-8?B?RENmbmo1OHc1dU93TnRQR0xQYjZoLzdOYUE2SjlXbVlaL1pLR3p0TkYzR0tP?=
 =?utf-8?B?OGF1RE04RThKdlNHOG04R1h3QmkvU3NxaTN0d2xwTEhReDNmTnhPOHRrK1hG?=
 =?utf-8?B?dFZnSEozNzBGRHVoaWJMZm5HdHE3dFowYnhmMFNoQWFyT2pST2JZRVdVb1h6?=
 =?utf-8?B?TjJNR1pyYndyZGJGcVZMc21ZYkU0NjdESTNlVXNJRERIeUVkSUtBSWdFejJN?=
 =?utf-8?B?Qyt3QkUwWGdLbkhGemk5TUxRY3dFVmcxY0JSYzY2SmxWd0d4eExwTFBwNlJu?=
 =?utf-8?B?c0VXbDlmemdIMHdZNlhnNUpSYldrRWlyRmlSSE1vLzN4YmZTM05RVHR2QjI2?=
 =?utf-8?B?LzBNd3dzc0FVb1loSHE1eGFqQnRJUi9PdmlJd3NFZTVCYWlaZ2l0VW9nKzJ3?=
 =?utf-8?B?dHQwNzE0ZFl3UG9OK1FKWjVxNldhcXFZdlA3Qm9xeW81cFVIZFA3SWcwZzFY?=
 =?utf-8?B?MTRrdWhSZmtidXlrREZqbEMrNWxNTHVyMXh1eFJiMWRpWVgva2I5dVRNR2p0?=
 =?utf-8?B?Tkhvek5DT1g5cU1LTW02TWxMaWYxb2FnZ1U0RlNZbzdUcEFKb1FtVXpFME8v?=
 =?utf-8?B?MnEvSmFnMjMyKzFUbXR6cktheFpsdGkxL3lZamZFeE5LQW9pNE83VjNvcVl3?=
 =?utf-8?B?WXFHeHFZcVovc3BlTmtlR3IvNUZLaE5MbDdYN00yVlVPL1hRUFdjUjQ3Q3k3?=
 =?utf-8?B?RGF3bXNDc2pXRlNkK1ZQUlRXKzNHWDB3K3VPbnVyS2ZQOThncWtVYjZnQ3gx?=
 =?utf-8?B?RjJXOU85R1JuQ09LYkhQR3hqRDZ5M25pbFoxcW1KMUpjdm15eGFReUg5Yk9Z?=
 =?utf-8?B?akMwT2lVRjBDZ09zZlBiLy9pbmtUY203SnFoM0hMdjhYQ1lWZGUrTzlsNklL?=
 =?utf-8?B?R2dzaUpNbGpBcVNMbWE5NHF2NENwVVErU1NCUWI4b1lpZVp5QUV3ZWd2TlFI?=
 =?utf-8?B?UlJmYnM4TlRwdHhZMUd2M0tPbVM0aVZqSjA5UzVwL0R1T0lyOGN3YkhTVXRW?=
 =?utf-8?B?WlF1N0ZTWVJnMXRmT2MvQjN6SVRLbUJZWWliUnZiVTVRdEE0OEg3VlF6RTNV?=
 =?utf-8?B?ZDVoMzB3OHBqN0w4dm4wN25jSGIzZEZ6NmVCVTNZZTVNVGgyK3dqVnBKQWJ0?=
 =?utf-8?B?U09uWUd1L2dLc0RVK1Y0b1hRRUtHZ08zNFQ5SmxjZDJIazNDZnZoeUZHam03?=
 =?utf-8?B?TitINVJQK3NkcHJHYlJWVmdWOFZhckU0eDhrMEhqOXB3cDVqUHNWNzZtOW1p?=
 =?utf-8?B?UWJuZnQzZTRvY0R4NUlSRGJGSDhPeUlybUxhMGNDaGMvMUZQWFpYT0pMbWEx?=
 =?utf-8?B?V05iMUI3WTRTa2xKR09ubVZubG4vMVMwUHl4aDVKd1VhWmRObVhNR0xvTksw?=
 =?utf-8?B?elhWUThodlNOY2pVWUhIZlRtV3A3WklkYXhMRGVFS2RQWVY2VkpHc0hwSDZa?=
 =?utf-8?B?ZEhZbjBrZFRyaHU1UWVSQVJmd1o1UXNMdTI5a3ZtUFlwS3l6Q3R1QjF6azZM?=
 =?utf-8?Q?0FM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fbd52b-7933-4069-f41c-08dcfc760d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 02:11:54.1445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjLGCVV4NLH3sjYuwuj9FNLWQw3z4zWbVVA3DwKUmZIEpfiKg0hze15VrFpkicEPZTWUAQoYfGI2V3ff85MFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3N1YSBNYXllciA8am9zdWFA
c29saWQtcnVuLmNvbT4NCj4gU2VudDogMjAyNOW5tDEx5pyIMeaXpSAxOTo0Mg0KPiBUbzogQWRy
aWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBCb3VnaCBDaGVuDQo+IDxoYWli
by5jaGVuQG54cC5jb20+OyBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IFNo
YXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT47DQo+IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0
cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IENjOiBN
aWtoYWlsIEFuaWtpbiA8bWlraGFpbC5hbmlraW5Ac29saWQtcnVuLmNvbT47IEpvbiBOZXR0bGV0
b24NCj4gPGpvbkBzb2xpZC1ydW4uY29tPjsgeWF6YW4uc2hoYWR5IDx5YXphbi5zaGhhZHlAc29s
aWQtcnVuLmNvbT47IFJhYmVlaA0KPiBLaG91cnkgPHJhYmVlaEBzb2xpZC1ydW4uY29tPjsgaW14
QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgZGwtUzMyIDxT
MzJAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSm9zdWENCj4gTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1
bi5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAyLzJdIG1tYzogaG9zdDogc2RoY2ktZXNkaGMt
aW14OiB1cGRhdGUgZXNkaGMgc3lzY3RsIGR0b2N2DQo+IGJpdG1hc2sNCj4gDQo+IE5YUCBFU0RI
QyBzdXBwb3J0cyBzZXR0aW5nIGRhdGEgdGltZW91dCB1c2luZyB1U0RIQ3hfU1lTX0NUUkwgcmVn
aXN0ZXINCj4gRFRPQ1YgYml0cyAoYml0cyAxNi0xOSkuDQo+IEN1cnJlbnRseSB0aGUgZHJpdmVy
IGFjY2Vzc2VzIHRob3NlIGJpdHMgYnkgMzItYml0IHdyaXRlIHVzaW5nDQo+IFNESENJX1RJTUVP
VVRfQ09OVFJPTCAoMHgyRSkgZGVmaW5lZCBpbiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmguDQo+
IFRoaXMgaXMgb2Zmc2V0IGJ5IHR3byBieXRlcyByZWxhdGl2ZSB0byB1U0RIQ3hfU1lTX0NUUkwg
KDB4MkMpLg0KPiBUaGUgZHJpdmVyIGFsc28gZGVmaW5lcyBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9N
QVNLIGFzIGZpcnN0IDQgYml0cywgd2hpY2ggaXMNCj4gY29ycmVjdCByZWxhdGl2ZSB0byBTREhD
SV9USU1FT1VUX0NPTlRST0wgYnV0IG5vdCByZWxhdGl2ZSB0bw0KPiB1U0RIQ3hfU1lTX0NUUkwu
IFRoZSBkZWZpbml0aW9uIGNhcnJ5aW5nIGNvbnRyb2wgcmVnaXN0ZXIgaW4gaXRzIG5hbWUgaXMN
Cj4gdGhlcmVmb3JlIGluY29uc2lzdGVudC4NCj4gDQo+IFVwZGF0ZSB0aGUgYml0bWFzayBkZWZp
bml0aW9uIGZvciBiaXRzIDE2LTE5IHRvIGJlIGNvcnJlY3QgcmVsYXRpdmUgdG8gY29udHJvbA0K
PiByZWdpc3RlciBiYXNlLg0KPiBVcGRhdGUgdGhlIGVzZGhjX3NldF90aW1lb3V0IGZ1bmN0aW9u
IHRvIHNldCB0aW1lb3V0IHZhbHVlIGF0IGNvbnRyb2wgcmVnaXN0ZXINCj4gYmFzZSwgbm90IHRp
bWVvdXQgb2Zmc2V0Lg0KPiANCj4gVGhpcyBzb2x2ZXMgYSBwdXJlbHkgY29zbWV0aWMgcHJvYmxl
bS4NCg0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0KQmVz
dCBSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8
am9zdWFAc29saWQtcnVuLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVz
ZGhjLWlteC5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4g
aW5kZXgNCj4gZjEwNmUyOTFjMjc2ZDBjODA2M2U5YWM1OWExMjZhY2Y1ZTllMjM5ZS4uY2RhM2Nj
NGNjMjJjZmEyMTQzNjlmNDBmMDkNCj4gN2NhNTA5Mzc4OTg2MDQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMzAsNyArMzAsNyBAQA0KPiAgI2luY2x1ZGUgInNk
aGNpLWVzZGhjLmgiDQo+ICAjaW5jbHVkZSAiY3FoY2kuaCINCj4gDQo+IC0jZGVmaW5lIEVTREhD
X1NZU19DVFJMX0RUT0NWX01BU0sJMHgwZg0KPiArI2RlZmluZSBFU0RIQ19TWVNfQ1RSTF9EVE9D
Vl9NQVNLCUdFTk1BU0soMTksIDE2KQ0KPiAgI2RlZmluZSBFU0RIQ19TWVNfQ1RSTF9JUFBfUlNU
X04JQklUKDIzKQ0KPiAgI2RlZmluZQlFU0RIQ19DVFJMX0QzQ0QJCQkweDA4DQo+ICAjZGVmaW5l
IEVTREhDX0JVUlNUX0xFTl9FTl9JTkNSCQkoMSA8PCAyNykNCj4gQEAgLTEzODYsOCArMTM4Niw4
IEBAIHN0YXRpYyB2b2lkIGVzZGhjX3NldF90aW1lb3V0KHN0cnVjdCBzZGhjaV9ob3N0DQo+ICpo
b3N0LCBzdHJ1Y3QgbW1jX2NvbW1hbmQgKmNtZCkNCj4gDQo+ICAJLyogdXNlIG1heGltdW0gdGlt
ZW91dCBjb3VudGVyICovDQo+ICAJZXNkaGNfY2xyc2V0X2xlKGhvc3QsIEVTREhDX1NZU19DVFJM
X0RUT0NWX01BU0ssDQo+IC0JCQllc2RoY19pc191c2RoYyhpbXhfZGF0YSkgPyAweEYgOiAweEUs
DQo+IC0JCQlTREhDSV9USU1FT1VUX0NPTlRST0wpOw0KPiArCQkJZXNkaGNfaXNfdXNkaGMoaW14
X2RhdGEpID8gMHhGMDAwMCA6IDB4RTAwMDAsDQo+ICsJCQlFU0RIQ19TWVNURU1fQ09OVFJPTCk7
DQo+ICB9DQo+IA0KPiAgc3RhdGljIHUzMiBlc2RoY19jcWhjaV9pcnEoc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QsIHUzMiBpbnRtYXNrKQ0KPiANCj4gLS0NCj4gMi40My4wDQoNCg==
