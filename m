Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3A216E10;
	Mon, 17 Feb 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793157; cv=fail; b=p4n63tDpJn7MEd+/xuUy9B7uRnsllXzbsBw3RRsC4+p3hsTu6ea9iPlwA2CT3i24ARBemX828VfvQURHfWPQviDH5JhN2ySrTeVAmd+VWNafbbJe2ehayQaZGPwN5TlQuoTZqCgPafzixlKbJQdmV/HsLoR2ABFkYSeSiI+W0dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793157; c=relaxed/simple;
	bh=n2sspGzd4ByDMxT+Ppn+AWCu590Iz7B9tLGrjnnekvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hVHRzsMayzb6tzaxsPL+irQczPU/S9GTiCnrQMJHE+aNWHC+RcOEGqOphAdTqQ1YOAxxw0oGYrfiwXxclzoMtVhIAtH5K4Ja6JTRo2J6LdS4kl6Jur1zMz3doZhg0588BEWCw8xpEZKTV8eoVN72FawjjGmfDncsCXOWttMIvb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NhQ65uSp; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NhQ65uSp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IooTbhfph6Q85h5YhHzYC9ql38Edo3RLUKVFUwvI59YqeEAxm1T5491uFwVIRD+qiBTyy0D1R3j2xkAYstaqwL8WGp3XL3r0q0AdMcnu5RLuhZrlX9fxyd5cSUu750G01sPMWnchkrLwUy8IMWNO3qxRH0h6fCdXyHuVUZyagctLN/4GqZ/toWz2OgdJtryr+0fmyY84KI+B/B3b475N8mydyfB8Y3vdFdnZVX9smpvckyQK018Ow2H+Yi51j/B2bxHlkWo0eH+/1BBAv4c8chZBE5Gp5bepRU9+DTF49sF3Cgar2bgGusTCC6Zpfb1qkZqFCtyR/RBg6K4cabKXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2sspGzd4ByDMxT+Ppn+AWCu590Iz7B9tLGrjnnekvA=;
 b=RPzBmxb2U8tBS7oF4jXW3adwDMG5qy19ecICAaPNrFIRh4qaVsvQOWzwYBZ0jR7nnBlDC85E2Jki4xq67OElW8/kmQoxqsvlAcLo4cf3VhwcwXo5PeqY1x5PJGrGhOw2ngUkQPyujFRZB8mWwTR2GFQDoJlu340Q7NWlgxwBy1lAyEO8lSVqobxQjG/whfbFZCRx2k/i6n2ajHweEdx9GruN69nFQ5pCthbnGb0gmIiUMdjxQIK/t/z1j8Pit5qVmtHWcy9CYIgM9IXlODgT5K9B3OsSHLqkFg+r6E1IrYwUgvDSLDGSa7QOk0TaNdPsTLG6Tb9OB22bJqmXEDxE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2sspGzd4ByDMxT+Ppn+AWCu590Iz7B9tLGrjnnekvA=;
 b=NhQ65uSpz6fc/djNPTP1XtcF+yo/gbds9d23bJH0c7T1fd9bLTcoj1IJok0hPR8cgmH+Vp17I2Jb1jUcEihQOqH44Eqtz7fJ4NSuTCPU2kMY+aRDwN+ws0t1ubdRUXJ9s6ennP2WNnHE86h4QcG5ztSN/bDgvpjK2iI35vssHBC0P9epuYfBFT7RGP8KedoFHTcVQHWBU28sPuZXju0FACgehqbH794sPiaUQNk/v0+JcoQqAJKbDUnRVjPm5uGvbcBUsQVMO7T5MzcDaeHEY1DqJXKg2oXrVzF26viDjhtZFMWxx04DhCvIRfTN1mOjbnT6ALm71nHXRXdPwcUdlQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB10744.eurprd04.prod.outlook.com (2603:10a6:10:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 11:52:31 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 11:52:31 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Luke Wang <ziniu.wang_1@nxp.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd read
 performance
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd read
 performance
Thread-Index: AQHbgSveBDHbBOGcckur9iGzCG/sZLNLYdUQ
Date: Mon, 17 Feb 2025 11:52:31 +0000
Message-ID:
 <DU0PR04MB949671481C88F04CDCD35DB990FB2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU4PR04MB10744:EE_
x-ms-office365-filtering-correlation-id: 2b63f216-0d42-427b-e3c8-08dd4f498f8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?SXIvOUpxSC94cC9SYXg2NGR6WDNyek55emYrVGtPczhpd0IrRGQ3c0Vhc1F4?=
 =?gb2312?B?bVYwbll3UDk3T1RyeERDS2hqQ2xuWTJTUHd1cmQ4dVVDL2R1RWdvY0hkaG1p?=
 =?gb2312?B?K1ZYOUlJaENQemlldGZxMGg4UjBqOGdSS1FuaFBIVTJpOW52aWRncVdCVitO?=
 =?gb2312?B?eTdhSlR2Q0ErT3dwTEhiZDR2RStVeHR1Yk83U3Zyay9LYVlGSTB4VS9FdzNV?=
 =?gb2312?B?aGZFN0o5Q1BNbmNrQjVwUk1zSzU2WUptTmZWblNDMGIzcEpxcHJyb0RFbWY2?=
 =?gb2312?B?dEJPSTVPVTdsOEE0Vm81Zzk0ZG55NXJBOHZkNktXL2lmQ1UvM3oyMlZqSUtQ?=
 =?gb2312?B?RkwrK09DVzRRSnM2M2JoYUlKYWFmUTZqWDFHVUs5MURvRnkyUzFHd1Rvajgz?=
 =?gb2312?B?azZjR0Y1R0MydjhuT3lVcmJiMWlybUJjSDFOYVpJOW9mVlMrcGVDbUJ2Unp4?=
 =?gb2312?B?ckdhWndxNW9nSDc2Q2hnZmh0THBsbmdCaFVKaW4xKzF1UEFEcDhIT1ZLTElu?=
 =?gb2312?B?elU1bEhkSDZMN01mY01VNzNQenREeUV0LzY2d2VhRlI0SXY2cnZQRC8xTkhW?=
 =?gb2312?B?bld4RC9TMVllV2hPSGlBb2NHMjRTLzJtUXZBMnNwQmhLUThvMFErSW1RTE5i?=
 =?gb2312?B?MU1OTldSLzFzSExjQmY2c1U3ZXQzNndPeE04QXNmbzY1aTltbS82R0FUS042?=
 =?gb2312?B?USszMjEybGtJNUk4ZU5XZVVwejVaZDBQVjl6ZStvZVVyYmNJM0JTc3JUbkxk?=
 =?gb2312?B?eGZRaFZYVU8xZXQrZUNaZVpQMXFCUkF6Vk41dGw0aElhSmJyb0hyVnBpeFBG?=
 =?gb2312?B?ZGJqMnI4ZENFQTErZ3d5ZXpCMWxPU1hIVDRPaUNwV25hc1pEWlNFL2lTRFBu?=
 =?gb2312?B?azk3bE1QR0tEcDAwT1A1MHlOQkFYNWhwUjlMWTlzTWhGRERhMUp1OXdNU0Vj?=
 =?gb2312?B?Sy9xY0NwUnpQSkRvVjQybTRIYlR2RGVEV3AyUGNnQkJMT3oyUUNKZUJUa0xG?=
 =?gb2312?B?MjJIREV4UVBhT1NmWXJTaE10T3Q5L2ZlWDNzZ2xTU3dJVzljblVodU9RTzVH?=
 =?gb2312?B?YUxXZWpWa1BsWGtQTDFMcGo4OU0vNmpwb1VhWHRtZUJtWTBpbU9mOW9jQVJB?=
 =?gb2312?B?NldnY3JlVFJMMlJzTEo3c294ZFpzb09JNTFQcENReU1TcmpUZ1NjNnNyNjhV?=
 =?gb2312?B?aWFTWisxRjRHbWI2Z3NuV3lUdnBYMDlucEpuTThFbzRhSmU2WFk1OGMwZ05D?=
 =?gb2312?B?YkR6TW9JYnZiWXRZd3U4MnpxcFpHbmNMMlMzRnlxRCt5NkxKeEROdWJwZ2Vx?=
 =?gb2312?B?cVFiRmJsMUJpUVRiWEdKUUZFOSticmk1VU4wN29sQ2xMeSs1Vnp6UU9JeFBs?=
 =?gb2312?B?TDNLWDM1M3VEWTRTeDQyYStlZ2xnbXNTRDlmSnRnVWlrZTJFczFGRGswNXEz?=
 =?gb2312?B?Ym5GTDhXZkwxOTNlUEVOVTN0d2hHaVVyWllUeDJaV0ZnR0hmY1FERXR0WEp1?=
 =?gb2312?B?MkZaRStlMmp0aUpkMHk3b2V1RXdyVmFYTGpRQVRpdFMrNEUvSEVTdFEvVVFO?=
 =?gb2312?B?RzRjNW5LRitQOVdEajg2djdhQkZQZzJHcjVtSGJoN3BnNkJiSkRSU3RZcVdj?=
 =?gb2312?B?eC9rbEszQzdhV2l3d29XRkZJK21Oc3AzOURudTJJWGp0TTg3ck9VYjJyc3pp?=
 =?gb2312?B?RmZOUTNFOXE2V2d1MDZDNzVpeHQwbVdWRGNhT1pHQ3RyM2x2a05pMmU2SWNy?=
 =?gb2312?B?Y0RwRXVGYk1UZWdKczAxUHJ0dUtlQWlEbDJOVXpNR016ekpiT25CRk80SDZG?=
 =?gb2312?B?a2RNZjRET2JsSmdjaitENEtBWVBLSFdmODJocks4d1Y4UEdEVFk1VXpidW5s?=
 =?gb2312?B?U2pPY2tuSW1hbnlYaWFJM0dGWHIwb1g0VFNpc1NEY0xEazBpcWIvaHZhdTNR?=
 =?gb2312?Q?S2iz8Td7Z+uj8YA6fFOU6hHi+hTJrbaw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QnRWdlpyVWNNWUN6NGh4em5QWlhZMEdUeEFJc1E1ZHpKQ3ZZV1BjelFubWFr?=
 =?gb2312?B?VzZkNFlxSUJ3Tkl6SWNuWGdsM3U5NHVxWVFNSGJxOUZ0OFNLWUxFYkNHOVRK?=
 =?gb2312?B?cGZrK2R1SHhYTlhlVzlMQlNUZjVCK2VjSTFlcHNHUjEvdXJ2QzN2Rm1Rejh4?=
 =?gb2312?B?amw3QjBmS29NQVMyZ0NYWmNndzdTSjNkRm5hamdxZHFaREk2NzMybTMwR0F5?=
 =?gb2312?B?dGVnajBBaVZQUy8yZFk4NVlmYVI1V0hCdlN1eHUveEg5dkx3ZStlcUNNd0c3?=
 =?gb2312?B?aXpxYlhRbFVwV2QwamhseW1lMVJINlVRbVROaDc3MktwRk9RSmFjUnM5ekQw?=
 =?gb2312?B?U1JPMkw0YnNvek9kZUZ4TkQrK3l3RFNJQ0dZSkRhZ2Q3MWhLSVZwQzAxVHFj?=
 =?gb2312?B?cjJ0T01lZVplS05ramd2MDRQRG4vUlRqeW9UQVAzUEwxcTUyWXZJdUQ2eWxO?=
 =?gb2312?B?bjBDUDd3YmlTcXVDSk15Um5BektmZjZCRk84TlBKNVJPUUFDK0crN2ZSWEtm?=
 =?gb2312?B?cC9wN3dSeVl0QmNJb1RVckJHZnNveTBla3FSK2tNRlFhQ0x6Wjc2ZWxwYUFO?=
 =?gb2312?B?SW8vQytyaGdGSklPN2Q0Sy85Nmw0dDVkUnBISkpEZkdqVXdxblRhSGx5bU80?=
 =?gb2312?B?UXhNNW04TXMzMENKK0JFNlBWdGZ2Z1h0czZtNFg2NXRzbUw5ZGpzS08wL1pG?=
 =?gb2312?B?SmtBYjFaenV3UWQ0N3hSMjN2NE5LM05XditoMk9HRGRweVZwbGZqekdhY3hI?=
 =?gb2312?B?MDM0bktuYXN1YnhGZ3ZNcWRHMWdyWWJMUnZxRUdiQmdWU1ZlWTBDcjc4Ykdn?=
 =?gb2312?B?Qk9yWDlHOEVIVFNHNVdGL0FReUQ0NzZieWZhNjFkaW5IeHdFVjY4dEdnUlFw?=
 =?gb2312?B?SjA4cURDMXUrMnZXa1p0bHZvMnVhaVpvM255SCtuZzQvcVlqQ0NPYlpmbm85?=
 =?gb2312?B?UVFWV21NZEx0by96OWRhMjB3cmZabG9RTFh6Q0dxODlPRldxaSsrOUJ2bHNn?=
 =?gb2312?B?YWZ5MUJxN0ZtcWFrc2Z6TFB0VWh0ZWJsb1JPSFVMZXQwNW4wRS95OUZJd0dt?=
 =?gb2312?B?WXRQenY5RVo4aVJXM3RTWmg3OTVmSzMxVkxSbXE5WGFkRGxtblJ5YytpSVRI?=
 =?gb2312?B?WnBMclBBTk82c2lwTWJNdnBHVkJTcko3U2Q1djhFOVBzN3NWdlI4ZERxYzl6?=
 =?gb2312?B?cGZBc2NNVGZ0LzF1bFJqQlozR0FjQ20wNElEajRhallNSGZNQmt2eGNsMWFS?=
 =?gb2312?B?NXFNUVA0bmVWQVFqRTJxYTRzMmFzNUVMbTVKSFB3SXlUaXJzczBZNE0zcDRR?=
 =?gb2312?B?R3ViYW5ubDFKVUxtdlRQWURiWENRWHhCS3N2YXByWUhGMWlCMUxld0swSm1I?=
 =?gb2312?B?SENoK3h0dHdlOGJZQUFUek9UOTk5Sm5TZmRuaEFPYlM1aHZoNU93Q0NTZDBy?=
 =?gb2312?B?a1kyUlRoMnRzZlIvZHk0ZzlGK1dnMjNEaG81NHcrWm5KTmc3WStVeVI2NHoy?=
 =?gb2312?B?Nm0zY2RNRk1yQnMvMkt5bjlTTVlaM1crTmpYTFJsZEt3Uk1JcHJIdmk1V0tr?=
 =?gb2312?B?clpKQzJCa2VkWk16dWVBcVZRYzNmaXliblBGM0d5b2s4NS9BVlRIMnI1VHN2?=
 =?gb2312?B?SFoyTHRiVWJsb1lVR2IxYkNxOXlRRVBPT3JKdGFGam5YZ1RBQW9XdjZzNEV2?=
 =?gb2312?B?V1ROYTZDL0oxZitqWmU5OGgxRkZTbnY3MGN2NHI2L2dRMHJXeTlpWUlCL0VV?=
 =?gb2312?B?VFJGejdZaWlwMVg1MzJVTkVZSTZ1WWJlNlBGWEpxZ0FOSStsQ2taTElLSW9C?=
 =?gb2312?B?ZE5uaFB2NWtERzQzb3lKcWlEcFppNXEwc0t5ZGI0dWZLZXh4SkQzQXpJankr?=
 =?gb2312?B?WlZLdUt6UEJxN2VzSDZaSTZaTjV1WXRHQmtITjBXbFhJR0NPTkdKQUhueW9w?=
 =?gb2312?B?d3RJSDl6V01VbU84MEFoblVRbjJpUWZvNWhWKzFRSW5KTWc5bkx2dHpEN214?=
 =?gb2312?B?c3lEZzNzUDI5emx6UFIrNTNHMlBnNGxhb0NhK0J0N25CKzFDdU9md0ZEVWhC?=
 =?gb2312?B?cXdFVll5VlRpNzVuUjVZcTFFT0Y3cy9wZHVrS0hIa2wza1ZJNUxsRUxsdUR4?=
 =?gb2312?Q?uWQk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b63f216-0d42-427b-e3c8-08dd4f498f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 11:52:31.6194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7DHr/soy9HJP0XQKEDFmDuoOah7kxW1ZlGbyxQARhTXfzXcLla0MpGvCWM+gr8nxzfJRBrBTwhYQy5fE1znVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10744

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiBTZW50OiAyMDI1xOoy1MIxN8jVIDE5OjA2DQo+IFRvOiBhZHJpYW4u
aHVudGVyQGludGVsLmNvbTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZw0KPiBDYzogQm91Z2ggQ2hl
biA8aGFpYm8uY2hlbkBueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRsLVMz
MiA8UzMyQG54cC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBtbWM6IHNk
aGNpLWVzZGhjLWlteDogaW1wcm92ZSBpbXg4bXEgZW1tYy9zZCByZWFkDQo+IHBlcmZvcm1hbmNl
DQo+IA0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiANCj4gQ29t
cGFyZWQgd2l0aCBrZXJuZWwgNi4xLCBpbXg4bXEgZU1NQy9TRCByZWFkIHBlcmZvcm1hbmNlIGRy
b3BzIGJ5IGFib3V0DQo+IDMwJSB3aXRoIGtlcm5lbCA2LjYuDQo+IA0KPiBUaGUgZU1NQy9TRCBy
ZWFkIHRocmVhZCB3aWxsIGJlIHB1dCB0byBzbGVlcCB1bnRpbCB0aGUgaGFyZHdhcmUgY29tcGxl
dGVzDQo+IGRhdGEgdHJhbnNmZXIuIE5vcm1hbGx5LCB0aGUgcmVhZCB0aHJlYWQgd2lsbCBiZSB3
b2tlbiB1cCBpbW1lZGlhdGVseSB3aGVuIHRoZQ0KPiBkYXRhIHRyYW5zZmVyIGlzIGNvbXBsZXRl
ZC4gSG93ZXZlciwgZHVlIHRvIGEga25vd24gaWMgYnVnLCBpZiBpbXg4bXEgaXMgaW4NCj4gY3B1
aWRsZSwgaXQgd2lsbCB0YWtlIGEgbG9uZyB0aW1lIChhYm91dCA1MDB1cykgdG8gZXhpdCBjcHVp
ZGxlLiBBcyBhIHJlc3VsdCwgdGhlDQo+IHJlYWQgdGhyZWFkIGNhbm5vdCBpbW1lZGlhdGVseSBy
ZWFkIHRoZSBuZXh0IGRhdGEgYmxvY2ssIGFmZmVjdGluZyB0aGUgcmVhZA0KPiBwZXJmb3JtYW5j
ZS4NCj4gDQo+IEtlcm5lbCA2LjYgdXNlcyBFRVZERiBhcyB0aGUgbmV3IHNjaGVkdWxlciwgd2hp
Y2ggYWZmZWN0cyBjcHUgc2NoZWR1bGluZyBhbmQNCj4gY3B1aWRsZSBiZWhhdmlvci4gV2l0aCBr
ZXJuZWwgNi42LCB0aGUgY3B1IHdoaWNoIHRoZSByZWFkIHRocmVhZCByZXNpZGVzIGhhcyBhDQo+
IGdyZWF0ZXIgcHJvYmFiaWxpdHkgaW4gY3B1aWRsZSAoYWJvdXQgODAlKSwgd2hpbGUgd2l0aCBr
ZXJuZWwgNi4xLCB0aGUgcHJvYmFiaWxpdHkNCj4gaXMgb25seSBhYm91dCAyMC0zMCUuIEZvciBv
dGhlciBwbGF0Zm9ybXMsIHRoaXMgZG9lcyBub3QgaGF2ZSBhIHNpZ25pZmljYW50IGltcGFjdA0K
PiBvbiByZWFkIHBlcmZvcm1hbmNlIGJlY2F1c2UgdGhlIGNwdWlkbGUgZXhpdCB0aW1lIGlzIHZl
cnkgc2hvcnQgKGZvciBleGFtcGxlLA0KPiBpbXg5MyBpcyBhYm91dCA2MHVzKS4gQnV0IGZvciBp
bXg4bXEsIHRoaXMgcmVzdWx0cyBpbiBsb25nZXIgd2FpdHMgZm9yIHRoZSB0aHJlYWQNCj4gdG8g
YmUgd29rZW4gdXAgd2hpbGUgcmVhZGluZyBlTU1DL1NELCB3aGljaCBkcm9wcyBwZXJmb3JtYW5j
ZS4NCj4gDQo+IFNvIGZvciBpbXg4bXEsIHVzZSB0aGUgRVNESENfRkxBR19QTVFPUyBmbGFnIHRv
IHJlcXVlc3QgdGhlIGNwdSBsYXRlbmN5DQo+IFFvUyBjb25zdHJhaW50LiBUaGlzIGNhbiBwcmV2
ZW50IGVudGVyaW5nIGNwdWlkbGUgZHVyaW5nIGRhdGEgdHJhbnNmZXIuDQoNClJldmlld2VkLWJ5
OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNClJlZ2FyZHMNCkhhaWJvIENoZW4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDEwICsrKysrKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gaW5kZXggZmY3OGE3YzZhMDRjLi5iM2JmOWMxNzFkNDYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMzM3LDYgKzMzNywx
NSBAQCBzdGF0aWMgc3RydWN0IGVzZGhjX3NvY19kYXRhIHVzZGhjX2lteDhtbV9kYXRhID0gew0K
PiAgCS5xdWlya3MgPSBTREhDSV9RVUlSS19OT19MRUQsDQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBz
dHJ1Y3QgZXNkaGNfc29jX2RhdGEgdXNkaGNfaW14OG1xX2RhdGEgPSB7DQo+ICsJLmZsYWdzID0g
RVNESENfRkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfU1REX1RVTklORw0KPiArCQkJfCBFU0RIQ19G
TEFHX0hBVkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDANCj4gKwkJCXwgRVNESENfRkxBR19IUzQw
MCB8IEVTREhDX0ZMQUdfUE1RT1MNCj4gKwkJCXwgRVNESENfRkxBR19TVEFURV9MT1NUX0lOX0xQ
TU9ERQ0KPiArCQkJfCBFU0RIQ19GTEFHX0JST0tFTl9BVVRPX0NNRDIzLA0KPiArCS5xdWlya3Mg
PSBTREhDSV9RVUlSS19OT19MRUQsDQo+ICt9Ow0KPiArDQo+ICBzdHJ1Y3QgcGx0Zm1faW14X2Rh
dGEgew0KPiAgCXUzMiBzY3JhdGNocGFkOw0KPiAgCXN0cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0K
PiBAQCAtMzgxLDYgKzM5MCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlt
eF9lc2RoY19kdF9pZHNbXSA9IHsNCj4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg3dWxwLXVz
ZGhjIiwgLmRhdGEgPSAmdXNkaGNfaW14N3VscF9kYXRhLCB9LA0KPiAgCXsgLmNvbXBhdGlibGUg
PSAiZnNsLGlteDhxeHAtdXNkaGMiLCAuZGF0YSA9ICZ1c2RoY19pbXg4cXhwX2RhdGEsIH0sDQo+
ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLXVzZGhjIiwgLmRhdGEgPSAmdXNkaGNfaW14
OG1tX2RhdGEsIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXVzZGhjIiwgLmRh
dGEgPSAmdXNkaGNfaW14OG1xX2RhdGEsIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14
cnQxMDUwLXVzZGhjIiwgLmRhdGEgPSAmdXNkaGNfaW14cnQxMDUwX2RhdGEsIH0sDQo+ICAJeyAu
Y29tcGF0aWJsZSA9ICJueHAsczMyZzItdXNkaGMiLCAuZGF0YSA9ICZ1c2RoY19zMzJnMl9kYXRh
LCB9LA0KPiAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiAtLQ0KPiAyLjM0LjENCg0K
