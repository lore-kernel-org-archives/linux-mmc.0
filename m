Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91B2EDD6B;
	Wed,  3 Dec 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758121; cv=fail; b=oie6WeTTuT90D0QfxrB0hbgOy/oFuHksnIRjsqtd3zjkg7k5Hc2lfI7o8GYMfUx6MzV9CTsUjN3aPVIYsfCv5QegVgoNbUBBFY+SNlafH2/J4sPdyTkYQhiuUR8pJpPlprXbRUhAkcW4BKUsELS4g/WMx5ypUZguxH17J5SMvIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758121; c=relaxed/simple;
	bh=O1/vcuQBxYw5GLJYQbcyOohxh+8vu0vztQ2g5zE7zRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftAxq2hJwswFfW2efSk9lI/4UFg03Z23foGV19ZfCYK0NPDk3+8UA7P9Y56fly4x1R+vCs9U0li/2bSIVdGd77UESEjqXls+5lx2VF9fcyBAGaYr+DjO+t9vvVPRWAxIW4Q8jCf8yrXLjLhImP9oocU8jeYDroCoJI3P5kvj3kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jfG4kbl/; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jfG4kbl/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVRecy6dwn4Lt+QWmwTeodYobFxmB/vBcBUrzIbybLmLLadu6d6Xz5SwFAhc3F8RHoh9M21LINCuBlabblK5SyUAUyy0xdH+0+Kpb3bkx0FZMFlhAREgPZLfcNIbmsXbGXVmrv/N38Cilv5k2s8SEvDhsCQ3wsd9Xbq0jeTZkX0XsCL/a4RHvcGrqFo27mZr7p5z56NsuhCPyWZwJDmi2DMzsKWYehYQuW3nu2ZVejQ0/gylg12zxJnhs8Qlv8EmBOZHT4t5PzWzqcrme76RO8r4lxFy3AIcZeB1BjoUUyuoTUO936ejIMI0L0SfrysT0l+h7tXTooHP7nxrQm9Xng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1/vcuQBxYw5GLJYQbcyOohxh+8vu0vztQ2g5zE7zRk=;
 b=lGqAEzGDyZpAOtWv+jZwKw/+vVqtu+8VMhaz0pbwskcBAe82eJc/J52vurk5mtZ7jWrzAN6iHuFAmSGGx4ziTj07/IfoOKfrnLaQYnSNs3IBP8akZ0+xHs21bRJgB/fJmKkyohA+gK+v7yrZmFfoAizK7ySj/2C3IJ0M+N1Vi0h10h7Ae7MkDFI+mURcEOXBG2LRAu+HfszjVS6u++w5kdplyG8UifedMY0JDtR9Zfppz9fgKbS6eLI1aaVcYWRsVDnSb4Y/3Jl8Yhkigco9hEShCP70rxzn0PIkpiO/2hwb7+YTzQ2DBegD+oN/bBtBAzlvUprTsuo8yEu814cpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1/vcuQBxYw5GLJYQbcyOohxh+8vu0vztQ2g5zE7zRk=;
 b=jfG4kbl/0s646c6cvRq+TboDEk4uxkRK02pEcjVplh8B21u6ClRBosgfDTuZoHI0S7Aee+vsndvxmC4fc03T/NU4UNOIftkXz4wG3I52jScar6HTp2wZ3CwcRcdJQ/R3/+77/m0rs4TD2P7f5ZFREGCmQpLOdW5GTHtv2r149aIdaH/U33rgfrRTaoYoHqq+f5tIVDuFFBtvZdjpjmsK6qLyG4FxEvF1Vd8hQkyw0djHjsM/wTO863zDgbRStMPhZq2x0pOBCB398Pk/J1KmLdqeQD5jpyLPccOD053WG6ynoLbbhq83e1yjvFb/2Dk51+C7yvCMrsPDnUaQ0/79ZA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB7989.eurprd04.prod.outlook.com (2603:10a6:20b:28b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 10:35:13 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 10:35:13 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Luke Wang <ziniu.wang_1@nxp.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: wait for data transfer completion
 before reset
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: wait for data transfer completion
 before reset
Thread-Index: AQHcZDsw9uKZLrYYo0WU/WwgrZSDuLUPssrQ
Date: Wed, 3 Dec 2025 10:35:13 +0000
Message-ID:
 <DU0PR04MB9496B18892369C11ED3EEAD790D9A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251203095850.4019706-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20251203095850.4019706-1-ziniu.wang_1@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB7989:EE_
x-ms-office365-filtering-correlation-id: 63ab253e-66e0-4360-e019-08de3257a447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?bGRPQW0zcGQ1eWduV3YrU2YwYVdEWU01ZmdYdXEzLy9XVENheitYcEVoWjVV?=
 =?gb2312?B?VUVDakRzd2gvbUQ5VENpWnArQldubW9zZzNGYTkyNlM3RXgyK3BOUVU3d0NB?=
 =?gb2312?B?ZXJoWGVqMG5oNGR1dkw1NUVEY3VvZ3ZmVFBYMnozR3hoV0pKRFhXb25vbGRS?=
 =?gb2312?B?T3hGWWZycTYraHFYemxpYXV0QWplQmRFUHVQZ1dEYlFCR1hibVUxYk9lU2RS?=
 =?gb2312?B?OXE0TytDOEtieWJvZDlIT3dWa2NvVUNmTHZnenlnYkZocmI0T1ltd0NHSXM0?=
 =?gb2312?B?Y0VXcDdsK2ROem03RU1mcjlRUnd5c0JaRkZ1Y29EanpMNEVTaytjUDNmN0Ev?=
 =?gb2312?B?WTFQSUF1cUZuRW9rQnU1QmNJOVV5ZWRLU243WjJ4Zkw2eVBGVmxoYnRnZFlE?=
 =?gb2312?B?Kyt5YTgwZDNaRHRrWFVpay9vRXJCMmhzdnJWdWw2M3VzSUJNd015L1BWUWpx?=
 =?gb2312?B?TWZIY2xHcmtUUm10Y3REY2tKdm1JTkthaVBzMXh6VW9nMWxKMnpraG9xRFox?=
 =?gb2312?B?Z0haNWpId3REdUVJeG5BV3lwMTl5TW9TVXJXeGRVdFN6VXdjWnIrT093RkM4?=
 =?gb2312?B?bmw0M0NZZ2JiTmJJS2FJU2F0emdnM2VNZlhDZXVlKzZuRnhpWi9MRldVSndH?=
 =?gb2312?B?T2hCcEZTWHN5YUhoa2tRNWNiMDdLR25BcjRKYzV4M0l5MzJLN3JGMXJwYnFv?=
 =?gb2312?B?dzYweERtZ08rb1Y3QlRzaE1CcHFhSWswWkFGT0JlWHhwWE5Ub01hN09oZlhz?=
 =?gb2312?B?SXR3TWNCV0FTRTUrWWM0WFVmR1dCU0VGQm03MHBhMHRWV2h1aE8rZEtGVzZa?=
 =?gb2312?B?YjZkQkVHWURuMFkxYlFZbE5wdXQzbWh1UFkxUFpLTUV0NFIxNE1wcDMxV2lE?=
 =?gb2312?B?NzZYREdDQkVLVzIxcUpQaTIxY0tSanhzSk1qZHQway9hT1VMYVFGcmRoMFpU?=
 =?gb2312?B?S1lwTE8waWQ5dE40VDBOZjNwbGk2OFNuTytpZTR2NzJXS0l1UTdkSTNya29E?=
 =?gb2312?B?eGloeTZPYnRsZWxxcUxZKysvK21GTGZ4RXFzSlpHSnJEOFY1VVpYWk9kL1Vw?=
 =?gb2312?B?U0R5K2o5TWQ5aGlQeGV2dnU5VHQ1MXM1L1hnUk40ZStmZk9WTVJvZDJuRlR3?=
 =?gb2312?B?a0VRbHZDNWJqcXczNVhkL1FJSTdvcjFwZmtVSGV5Vmg5NEhWUlFFdHVscDVX?=
 =?gb2312?B?dlRTdnY4NXBxVUU3TlVRc2p0VVhVL2xVZzNDRGNHbHZWQ05sNmdhbWIzRUpn?=
 =?gb2312?B?RW10Sm8xMndWS1NTMmh4S0lyS1ZLdWFXa2tJMEtUenl3b1V3Vk5VbEMvQ2lh?=
 =?gb2312?B?cFpEenZLdlp0R0QzRFYzOWVsRGpzZUM0TmlnUjhPZmNhSkF0eUFXSEpPektL?=
 =?gb2312?B?dkV4ZnFTdklJWDF0Z0lNNExpUDNMcUY3N0hmNnJ1UlZlaFpCdVc0YkhCTCsx?=
 =?gb2312?B?RDVkNmxGK3liZG8yVkxNU0k2Z21oaDZSRVBoclo3VGhudDBISHhGRlJZTDV2?=
 =?gb2312?B?WHpGZEhoSzlDZVVrR0Q2cUUvVlphNnpMbERVcThFUzl2a0llQ0oxbmdhMllx?=
 =?gb2312?B?SGVoZzJMQWZBekZwaDBWTS91YXRSOHJ6T2xHZ1Z0cUdBZGVNa3dEMmhXNW9x?=
 =?gb2312?B?Z211K0F6VGNObG0waFVUamRFcTVXa1paYmI1b1Zoci9XZzlSQ24wTXU1SVA1?=
 =?gb2312?B?dEtjQWQzcFZZYXN6Umhpc0s3ZzZvb2xSRFpZeHBJeWo5cDRVOTZPNUxYbGsw?=
 =?gb2312?B?ZXlHUlFXMm1rdlppeFNIdmw3V1czWEc4WGlnRHR3TVVLNmV1QUdYTWhYU3ow?=
 =?gb2312?B?Y3lKMDZHKzc1TlV5UnRHNmQ1RlNvYThYTlIrSlpqaFVBMmpGcUNCUTlNSFVJ?=
 =?gb2312?B?YVNrMm9yTUtQYnBqeVhqS1J6S3lyZ29jVHZoTmVjLzR3aGZhNGdQVG9GMDg2?=
 =?gb2312?B?RmFQbmFZL1hYMzNFWWRRYkgvekRYS2R5L2c2dHFXMXRURWQxNmlyNHFHampS?=
 =?gb2312?B?QTZ4a2xkRHpZdTkrV0VWcE05UVlicDQ5amNLSUNRbmNqb2Y2MzdOaHNHNkls?=
 =?gb2312?Q?riHRNR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dU5RYWIrRU1aRXJoRjN6cnpXNklWTzdpalJvN2JVNFQ0MGRHb2lYYnVYdUwv?=
 =?gb2312?B?SktpbnZDZWZ3ZFFvaVhoRE9NUmpUeVByZUdCZjVmVjRzckNVQ09HUW45K1hy?=
 =?gb2312?B?RW5DZk45c3gxa3VvVFJPODV6YTIvaDYwN214cUZvSStLVWFuM2szTTQrcENJ?=
 =?gb2312?B?Vk9GUHRHYUM5MWU3TkNwQjcvN3Y2UjNGNWw1UkJWQmxYWFZHM05EaXlvVVVQ?=
 =?gb2312?B?SU5PYkpHdk5nb3lhMXBhaDNFdTdmTm4yK25LNXhZaDJGMGdxUHdwS2Q4dUhY?=
 =?gb2312?B?RHFzYmw5cFl2aXE3MjI4d3Q4MERUVnRYeUQ2VkFvYjRINzE1OGo0R2lrTmtr?=
 =?gb2312?B?MzFxaStSc2FvOVlkTWxEZE1GSmRsek9KUkpWaHk3a3RPYzVkVEZZM2N3OVp5?=
 =?gb2312?B?TDhZci92ZVdWeVF4a25nb1UwazdPYzJqZEl6YmFwd0E3emt2c0Q1MlFtL1Bl?=
 =?gb2312?B?cW5HWG5KRXJiYzhtWFpjajdPRTU1aWFOelh5cVdaV0NHQkV6K1k2dEZSRVo4?=
 =?gb2312?B?MTFNeFhsMjZoTGV2N3Z3b25SNXZMY0pyUjFEQW5SR3FCU1hnSEpXVWxaQmpX?=
 =?gb2312?B?cE1XZENRWDUvNFRodXJVc1ozalgrY1lqaUJIVjFRdXBuOHRaTi9FTDJ2RVN4?=
 =?gb2312?B?Vjk5eTBlWnhOM1pDbUJ4SHpxQVhPVWRNVzYyYVdpcEdUQklGSHRsVWNlakUy?=
 =?gb2312?B?eFMxSzlac2NPa0ZEK2YxNnpQQlpEMFFLVXBwVGM4QnI4S2xuOE9xWEdobE9z?=
 =?gb2312?B?Smp2UVpxcEtCTHJQUGp1WHpQQTMwNnZjWkZKTkZnNURmc2JiemFYMzZJUmpJ?=
 =?gb2312?B?c2dPZGxHMU1NWkVLUVFad0VEMTQ1MTQvNG9rSSsrZEx2Z2g5U28xck1aT1Nm?=
 =?gb2312?B?QTQxRGM5K2NiOVVGTHc2OGdtQzRIQWVoTGhnVURvOTlaU1hDRCtZTVcvdWhz?=
 =?gb2312?B?azg0bmpPMU5rS056WTZOM1MzYzVWTU9jSVZselZEcDYwcmlzUUJJVk0rOElm?=
 =?gb2312?B?MEp3T3AzdUp0RGpoYVVNeHF4RW8wRTJvUkorQ1hpamNQUmFGV1BPR1VkVUNx?=
 =?gb2312?B?YXdOMEVYUWY0bDJNUjFJRjNGN2xYZzRMME1WOUFSbU9VMHZMWTFFbThISXgw?=
 =?gb2312?B?ODJWUkpsZ2xmaHZpaXBmMW9TMlNkS1g4ZzQ0VEJCaFFycmZiN0pSOGg0cUZR?=
 =?gb2312?B?a2tDcXFJNmFlanA5QnBKbGE0SW13MmpwSUNXTDNXNVhUQlUxRWl1SjlYNXBl?=
 =?gb2312?B?Qkk5NExVeFBIbXZqQ2FuNkIvYVppZ2NSVG9oK0ZDSU5CSUtnU003U0h2T0hl?=
 =?gb2312?B?YW5PQ1I0cE1vcG9xck5YNkJtb3VlZW1FUXZrOGpFZFFuSUYrTE9RUDZoVVpm?=
 =?gb2312?B?S0Q3MkpML2hudXFPdE50OG1uNFdRNXdwcVJOZkR5ZXZoVzliR0F5WVBuNXl0?=
 =?gb2312?B?YkcrQktXdFVUNEhBRDR5aitwc1lHTW8zTXhzTGM3ZFVmaHM0eXVpMHNFMWRn?=
 =?gb2312?B?d0ROT0VaUXJ1ME12djd4aTR4Qy91bWJKK1E0MVRSUzl3Tlg2aHVZYmEybWJN?=
 =?gb2312?B?WnludktUbjFtVk5UbC91d0kxRUM3YjhaNldSSGRjMmRFc3d0K2crbnBRbUlX?=
 =?gb2312?B?SGxNQm9adnZuZEhxS2lRQ0JFUElHbjhGTVcyUFVJclY5dm12blZId1J6LzV6?=
 =?gb2312?B?bUVBQU5kbFBaeERWYk5pY29DMEQwL0VzL2hIeXlNOWFKaU1DM2lnL1RLREZM?=
 =?gb2312?B?VWo1d1dUa1VrMUtVdnBhcStjSkJjeGxXaFFWRzUzN2V2ODQxa2dneUR2WktC?=
 =?gb2312?B?V3VIYk96YkdFMTFKeFozN29qeEdUUURJUHZVbmpRd1JIRWZrVG1wbVhsTWFD?=
 =?gb2312?B?UHZWL1M2c29nTnk2WStsS1Q2QThuWWRmbFBSd3M3U2tubWphNDVLREtLb21Y?=
 =?gb2312?B?TmYxQlYzL0cyVkp0dXYxR0ZUZmhsa01uVnF1RGpScGFkME55VVNxbGVrVmZ1?=
 =?gb2312?B?QjJFcUhObTg1bmc4bmZRUVZCWEFVYXBEQzM4RDhuTkUrZ09Tem9CQUkrN1Rm?=
 =?gb2312?B?cmVucHNEcFQ0ZlRyVzBCdXpUamZSMVpGY3BVRHpXcWNoQ1VnZHB5VzJEMVhC?=
 =?gb2312?Q?hIuc=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ab253e-66e0-4360-e019-08de3257a447
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 10:35:13.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+6dNrteU+w2WCd+kVvZlLEbaIBsvSWlsOFefPTCGGicYKX2cCFPOaei9BO3tsBxICtcSXNMoh+xhheLuU1m2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7989

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiBTZW50OiAyMDI1xOoxMtTCM8jVIDE3OjU5DQo+IFRvOiBhZHJpYW4u
aHVudGVyQGludGVsLmNvbTsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsNCj4gdWxm
LmhhbnNzb25AbGluYXJvLm9yZw0KPiBDYzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5j
b207IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRsLVMzMiA8UzMyQG54cC5jb20+Ow0KPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBtbWM6IHNkaGNpLWVzZGhjLWlteDogd2FpdCBm
b3IgZGF0YSB0cmFuc2ZlciBjb21wbGV0aW9uDQo+IGJlZm9yZSByZXNldA0KPiANCj4gRnJvbTog
THVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT4NCj4gDQo+IE9uIElNWDdVTFAgcGxhdGZv
cm1zLCBjZXJ0YWluIFNEIGNhcmRzIChlLmcuIEtpbmdzdG9uIENhbnZhcyBHbyEgUGx1cykgY2F1
c2UNCj4gc3lzdGVtIGhhbmdzIGFuZCByZWJvb3RzIGR1cmluZyBtYW51YWwgdHVuaW5nLiBUaGVz
ZSBjYXJkcyBleGhpYml0IGxhcmdlIGdhcHMNCj4gKH4xNnVzKSBiZXR3ZWVuIHR1bmluZyBjb21t
YW5kIHJlc3BvbnNlIGFuZCBkYXRhIHRyYW5zbWlzc2lvbi4NCj4gV2hlbiBDUkMgZXJyb3JzIG9j
Y3VyIGR1cmluZyB0dW5pbmcsIHRoZSBjb2RlIGFzc3VtZXMgZGF0YSBlcnJvcnMgZXZlbiB0dW5p
bmcNCg0KV2hlbiBjbWQgQ1JDIGVycm9ycyBvY2N1ciBkdXJpbmcgdHVuaW5nLA0KDQo+IGRhdGEg
aGFzbid0IGJlZW4gZnVsbHkgcmVjZWl2ZWQgYW5kIHRoZW4gcmVzZXQgaG9zdCBkYXRhIGNpcmN1
aXQuDQo+IA0KPiBQZXIgSU1YN1VMUCByZWZlcmVuY2UgbWFudWFsLCByZXNldCBvcGVyYXRpb25z
IChSRVNFVF9EQVRBL0FMTCkgbmVlZCB0bw0KPiBtYWtlIHN1cmUgbm8gYWN0aXZlIGRhdGEgdHJh
bnNmZXJzLiBQcmV2aW91c2x5LCByZXNldHRpbmcgd2hpbGUgZGF0YSB3YXMgaW4tZmxpZ2h0DQo+
IGNhdXNlZCB1bmtub3duIGJlaGF2aW9yLiBUaGlzIHBhdGNoIGFkZHMgcG9sbGluZyBmb3IgZGF0
YSB0cmFuc2ZlciBjb21wbGV0aW9uDQo+IGJlZm9yZSBleGVjdXRpbmcgcmVzZXRzLg0KDQpZb3Ug
Y2FuIHNob3cgbW9yZSBkZXRhaWxzIGhlcmUgZm9yIHRoZSB1bmtub3duIGJlaGF2aW9yLCBsaWtl
IGNsZWFyIHRoZSBETUEgYWRkcmVzcywgY2F1c2luZyBidXMgZXJyb3Igd2hlbiB1c2UgRE1BIHRy
YW5zZmVyIG5leHQgZGF0YS4NCg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAxNSArKysrKysrKysrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
ZXNkaGMtaW14LmMNCj4gaW5kZXggYTdhNWRmNjczYjBmLi5hZmZkZTE5MzY1MTAgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMTQ1Myw2ICsxNDUzLDIxIEBAIHN0
YXRpYyB2b2lkIGVzZGhjX3NldF91aHNfc2lnbmFsaW5nKHN0cnVjdA0KPiBzZGhjaV9ob3N0ICpo
b3N0LCB1bnNpZ25lZCB0aW1pbmcpDQo+IA0KPiAgc3RhdGljIHZvaWQgZXNkaGNfcmVzZXQoc3Ry
dWN0IHNkaGNpX2hvc3QgKmhvc3QsIHU4IG1hc2spICB7DQo+ICsJdTMyIHByZXNlbnRfc3RhdGU7
DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCS8qDQo+ICsJICogRm9yIGRhdGEgb3IgZnVsbCByZXNl
dCwgZW5zdXJlIGFueSBhY3RpdmUgZGF0YSB0cmFuc2ZlciBjb21wbGV0ZXMNCj4gKwkgKiBiZWZv
cmUgcmVzZXR0aW5nIHRvIGF2b2lkIHN5c3RlbSBoYW5nLg0KPiArCSAqLw0KPiArCWlmIChtYXNr
ICYgKFNESENJX1JFU0VUX0RBVEEgfCBTREhDSV9SRVNFVF9BTEwpKSB7DQo+ICsJCXJldCA9IHJl
YWRsX3BvbGxfdGltZW91dF9hdG9taWMoaG9zdC0+aW9hZGRyICsgRVNESENfUFJTU1RBVCwNCj4g
cHJlc2VudF9zdGF0ZSwNCj4gKwkJCQkJCSEocHJlc2VudF9zdGF0ZSAmIFNESENJX0RBVEFfSU5I
SUJJVCksIDIsDQo+IDEwMDAwMCk7DQo+ICsJCWlmIChyZXQgPT0gLUVUSU1FRE9VVCkNCj4gKwkJ
CWRldl93YXJuKG1tY19kZXYoaG9zdC0+bW1jKSwNCj4gKwkJCQkgInRpbWVvdXQgd2FpdGluZyBm
b3IgZGF0YSB0cmFuc2ZlciBjb21wbGV0aW9uXG4iKTsNCj4gKwl9DQo+ICsNCj4gIAlzZGhjaV9h
bmRfY3FoY2lfcmVzZXQoaG9zdCwgbWFzayk7DQo+IA0KPiAgCXNkaGNpX3dyaXRlbChob3N0LCBo
b3N0LT5pZXIsIFNESENJX0lOVF9FTkFCTEUpOw0KPiAtLQ0KPiAyLjM0LjENCg0K
