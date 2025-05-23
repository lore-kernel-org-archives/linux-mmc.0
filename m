Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3728750E;
	Fri, 23 May 2025 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987731; cv=fail; b=SS8lblLbJhIiwN7uRO48A8cWEiXkxWYTe/+22KLxSVzYQtwyxV1TMuDJ/6CAyTe7uJgt3cLPa52WrtF6WwXASBBwEvNR1z3BADVqu1E952Q/P7KldZTJXIvbKCxogABA7pH5sAIu0cjOFPCcRR2/gMFXyjXbN2PZA0ZIj8bYU6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987731; c=relaxed/simple;
	bh=D/mVjCP4Reb62XQBnTfGCEBv+dKgstgDflRJPJqX7rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hX7cCpsG93YuZrCVm1Du4sEAaTHN8KlGOCbLmO+/XLyRRTT9I9oEWGsC/M1Ej293rqx6LiFl33pYpTrRMgn75Ffc9SQSlK18zPeLZhnGPR17Yuku4ljs2HZmv388sIKfzUufoqNex9HWzDTfpp3kpXfaC6KrEu7YeMd/22GdLWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G/FT6HyU; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G/FT6HyU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yh6IYdzdgFLxBzCnCs4FbEU8A2p5XTWuTDl+fpjwnyF9EPpYJDJbpb74U0WS3+mETYmnxVyevnTvp+IDePs8ZYBrrh0ekiyQ4DYl4Ryjz+Thx6bZL/+8WtieptWzetsqgozauonZZGKuSJommaZCaDCG6TmnPnHsPvJTpGNia83WOHVheOEclKzJIWpkSKEn2UReZ6RfA3xngWvcRvldLTCuwWmenQnP/yIuVfRo2ZYkpUfTJQSrtzo6xfQGCQBs8KsVz3WJVK6th+fof8FSLr3cnjAIUjAR1kkjsmsqls3whykeD9m70dZ/Mh7b3WTkG5sAGtjS7tBWBVqyLwwhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/mVjCP4Reb62XQBnTfGCEBv+dKgstgDflRJPJqX7rc=;
 b=EQpDRbc4gyboHybVMfBz6lOTCHRSFlxYbYTsiuObxbifovTVmbn2S0MrEYssIV9OU3ug93AHUXF8lMjRr8dROG/6KnEU+BDEtH4Pz/LvKglILw70lHGnVDSpHQmjNvNhk+XEyupExsA6heaANGVznZv/vcP74LWX2inyH+Klq1xpFTt1XXncr6S5CRgXijk3KKpzKIaCK+3F5+vlkY9ZyX3SRwaX7xOl5v9uBnWU8njrOX21M4CyIgCXGaaM2Ha/NJ3mtsmuL/1M7KDGTeq5ZSm1f3mb2LmH9WLpyzZWjz6ZZvSQSOhFcHJ/+BhQmM1kDsnhApl8XFSwZ9G9qcbmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/mVjCP4Reb62XQBnTfGCEBv+dKgstgDflRJPJqX7rc=;
 b=G/FT6HyU6ktql2011IuQUoRXmHU84QN1ZeX0mMtyy4+sFUxXj6y8VnLHZ3k43PqPBz8uZcVELW5GhkwQlAQ0H9aKdlQHqKdUm/j9vd16mW7OcHkengo36qUIY7+3jwIoPZHFojk0i9R4MRnNpngexvTwfc6BwwM+k3jx5y/H/2ePoXNfkxRWLhi0TJhtiosLu5jUyY8L9T+qgOe2vDX2qelz/ntKI6ikL2lqouYWRgAa7dPjZTaGeSG+C5YNoQOC9junW9qFu+FtFta5HwBnygVw9rWrx6nJP0ousHefNsGnKE3K/1xxOJXB0wxUPorl+R8xax7gshnjKf/liF8QrQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU2PR04MB8581.eurprd04.prod.outlook.com (2603:10a6:10:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 08:08:46 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%3]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 08:08:45 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Frank Li <frank.li@nxp.com>, Bough Chen <haibo.chen@nxp.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: do not change pinctrl state in
 suspend if function irq is wakeup source
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: do not change pinctrl state in
 suspend if function irq is wakeup source
Thread-Index: AQHbygCqfqhdZ0YogE2DbWZdbU+gV7PdPc6AgAC97ICAAP8PAIAA4n9g
Date: Fri, 23 May 2025 08:08:45 +0000
Message-ID:
 <DU2PR04MB8567893317AFD9228E7CBDBAED98A@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250521033134.112671-1-ziniu.wang_1@nxp.com>
 <aC33qfRFEvNbwSRn@lizhi-Precision-Tower-5810>
 <DU0PR04MB949685245DB01F28E15C24D29099A@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <aC9s8DLW8NcvF4e3@lizhi-Precision-Tower-5810>
In-Reply-To: <aC9s8DLW8NcvF4e3@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|DU2PR04MB8581:EE_
x-ms-office365-filtering-correlation-id: 3e5248c5-acad-46dc-6cc5-08dd99d10a72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFFsSXlFdE5PMDU4WE1QYkVrdUl5TkgwMlBkcWpYVmM3M2ZRQzlDSm5jQVFQ?=
 =?utf-8?B?WUhWazVzaGJOMFlpbWZhL3JHTFVRLy9BbjJadVJTUFQ0UitOL0JUWWpHQTA5?=
 =?utf-8?B?L1hnVm9jN2h2eFVUenRHdlBua0YyTytTRXNCM2RDMnhtdzNWY2REZ3ZmV1U1?=
 =?utf-8?B?cmVvWjhOamNlMFoySmxmWmt3c1J2blVmQmlYSURKcFFSTzFxU0l4eWt2Zkcv?=
 =?utf-8?B?TnRiNlViODkwUXI5dDkwbXY1bzVrMmN0Lzl6Q3YyOHFWVTVKU25ZNHhabFN4?=
 =?utf-8?B?RVpGZVIyYVc5SkN3QXBQOVVFeVNTR0JKRFZvSlZrWURtVjNVSGtDQklWdERn?=
 =?utf-8?B?QmVpSWRseG5XMUFEUFBFRVp0c3ovUVRldFNVcFQwNjdEM3BIYjR4UjlrdEJY?=
 =?utf-8?B?TGtaWTlYQXV6cktmSDYxYit0VjBOSGtkODhFZ29CVFExUVNJMHV4Z09pRmo3?=
 =?utf-8?B?TGhPNi8yeDRhT1VjQ01aYUtXVnJRQm5EYWlGdVlmRDN2a3FhRnFHRkVyY2FS?=
 =?utf-8?B?VmRoVVgvVDBDclh3UzVCV0MyTkRhd1VMNEh3dUs3MTdZajJSSXg0RHQ3bUVk?=
 =?utf-8?B?YjFTd29DemlmdEZXeVlsUXpDSnl0eXRRQnFvNlYxbmxXRkNzalh5aG1ONXM1?=
 =?utf-8?B?NFVNb2pWdzlYN1BRMzZIOCtsN3gyeTV1RDBvL3dHREZOM253Q3d1eFFmWGti?=
 =?utf-8?B?WlIwYXhyWGROZVo1bllBd2I3cTVOc24xR3RRQVdqQ0xwOHEwYmpjZUlvcVlC?=
 =?utf-8?B?aHVoNXV4OHJJTjlUYzZzMWF1c2JkblZ3RjIwV3ljWUkrSENoK0h0UmRlbTZv?=
 =?utf-8?B?Z3QyeU1ybU43Y0pwZWFpOXp6WUpyMThVdm5kZ2dOTEJJZUU3cGM4aE1YTHBF?=
 =?utf-8?B?VU5PRlZEME9aWVR0ajJ0TUMvZzBUZUdISG5Kc3F0am1QVVBLQ0xON0lWUWIy?=
 =?utf-8?B?V2dBTWV6S25QNUtaa3F1NXZ2cU1VSlp1MTlNbUoxb2Vtc0FkK0x0ZzVudlZj?=
 =?utf-8?B?RWdUNkRyRm8rYkxsWko5VWlVelNlcnlnbkFKeU1BTkJETE10MWJlKzBmczBX?=
 =?utf-8?B?S1MxREdtUWptYjB1bG9rNEpiZGNUWmZmN2p3VENTbnZZcDdTRjczVWRVeURH?=
 =?utf-8?B?VHk4QW9aWVM5dVNweHFMTHlJUFBtVXZHeWo5YnRYQlJQWDJBbVdIZ2F0Z1NC?=
 =?utf-8?B?bzN5Ynd1OEI4cWRCRFIvdDdGVnVxdnN2MTdIcmhvYTFtRzRjSjkrUzRrdGxs?=
 =?utf-8?B?cVdJZ3dpK0pzS1dzZzAwZllEYUdtRlpVSk0zQkZLd2hiMWRDYnF3azE3bmg5?=
 =?utf-8?B?QjR0b3d4cUdaeUZTZFV2K1lUMVdZTnk5NEVacE9DZkFveWlaak5keEUyRHBx?=
 =?utf-8?B?aTRIc3I1c1RaMUk4bit3MlB3eFdkVHJMR1psaXc1VklGNDk1SC9qaitLQ3B2?=
 =?utf-8?B?UE81ZFhKNEdwV016RWsxK0lza09IajR2ci94MlZrSmxrRW9SUThiTGY2VmtN?=
 =?utf-8?B?Wi8xc2I2K1Q4T2RIMG1NL21lNkFkSkNVYlBBc2V4eVB1RkNZbGp2WDB4RGQ1?=
 =?utf-8?B?Q0hpUFZHc25vMnBxTCtJQVB0MlJjbkRKRksyQ3p5NU9MbzlDam04TWdBMWtB?=
 =?utf-8?B?U2pkZUoxMllWM1ZDY2tvWFlJL0lTc2o3YmRqZkE2NmdjSnZZRDk4d1QwN3dq?=
 =?utf-8?B?NWVJdTQxY2lsUFVaVnhEY3BRcGcxajVWY2ZwMDhWMjdPTXhrU0tjNnNCSFdM?=
 =?utf-8?B?OVU5ckpiVU9JVTBMTlZhL1p1dElsNGF2dWtobTJ0YTlmNk1YamI4aUlmKzdi?=
 =?utf-8?B?TUgyc1NDZERZdWJzQ3pjb1VRQUYvL3I4YS9QQVlUSURpSC9hZ0hqM0NNOTh3?=
 =?utf-8?B?U2RHeHFnZDhtSWlhOVZTVDU3OC9hUXJqUXhWY3FhNE9ib0xLSkVsaW00WXFt?=
 =?utf-8?B?eWg5OVNmNXlIOVRCMm43OU1Rc0tnSDV4K3R6K3BmWWJyeHcyK0UzdkdDUVJj?=
 =?utf-8?B?eXc2YWZwc3VnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2ZNSWVQTzNRT1hscm5MZVRmTzNTdWNtdk9JSEc4ZVl1V3IxOUh5bnlWN3I3?=
 =?utf-8?B?cFZXdmhwbWNrYmRJaTJWN1l4YkxabnBLVk5mR3o3TU45cVdGN2VnUkRYY0p4?=
 =?utf-8?B?UitIZWc0a0FtbTJ5czVEbEZJYlZtRGorcnpSUDl1bUlpQTd6TFpESzg2dU5t?=
 =?utf-8?B?Wi9FREdnVWpPOFZqVHFMUjhRUjFTRFgyWlkzVXJmUStNSEY3SDA2elNQZ3pz?=
 =?utf-8?B?UHVleklzR05UbVZiK0lYSHRXK3c1V0RlY0pCODUzaE1XL3I1akNIa0taQWM3?=
 =?utf-8?B?a3lUV1NnaDM4L3ozRFpoSno1S051a3p4VkpodEJuUkpkdlhQWXlDK01DbVVJ?=
 =?utf-8?B?eHc0YksrR0RPNGtVMVhSMkNJZ0lPSlNKbUtwSW9GNUxXb1RZdXk5ays1aWdP?=
 =?utf-8?B?R2NlVUI4eDIxMWl1b05zNzgySzllR2dPVU00NUV0SUZyUkl0enhvcmVxUDdo?=
 =?utf-8?B?bjZYb3N0S2ZYSTB3UEVqR3hyQVQ1VTJKV1ZyOUxSUkVzZ0RVUDZZQ054Mkdm?=
 =?utf-8?B?aU9Qb2xnSHBQTjYxL0VIeWJSK0w3dVlxQmJ2cTlmMXoyNWliZU4vSmlNcGpK?=
 =?utf-8?B?SHAxa1NBS1oxRDlTREwvQnJRdXlPNnRnSHMxOW9YcUU0ZEVWbGVTUEFpL2NN?=
 =?utf-8?B?Qy9KSjRJVCtKTWR4V0tRMkxSUmd2Z0ljbEFydWFrbUJFaGh5RWl1TDdXWjZG?=
 =?utf-8?B?WnFmQnRwZGppMVg2NlZmM3ZWVE1NSzBLY1dGcFFZR0g2SitDOElWM3loZFBH?=
 =?utf-8?B?ZXJRbFFUMk9uUXNYUmN0YkJ4OWJ2Smd4VGVQYkRyQWI4clJyeThoSjVZQTkz?=
 =?utf-8?B?b0RVREdlMitQc09DdWpCcmsyME9rZGtSeGx6aTZTQjIxR2hLdnI5TDRDTHdv?=
 =?utf-8?B?U25McEp6WGRzcjA4dEFMb20zODBIN2pJM3U1TkxZTVpuUithMG85MzNqQTIy?=
 =?utf-8?B?WFZsVDM2QUxWWGRqd0lEQi9MRnd3TkFFRXJiblNralJON3FtYm4rckcxWFJF?=
 =?utf-8?B?aCtmb2VLcUF5NzJMMTVmV3J4dGhybDBlQVZBcGdNTUs4NWZYbVU5TklyU0pI?=
 =?utf-8?B?NW45eExnRkNic0RDVXg5OVBRaFF1dDNCYWRzRTV5WHVYNkZ0TG5MZTZMUmEz?=
 =?utf-8?B?ZGJCY3R2TXlNMWVRVVNTRWM3YktSNXJQMDAvQzhSc1Q2SWNLQ3pHdnA3L2dh?=
 =?utf-8?B?dUQyTVZpNkRaMzZMb21QN0NKU2lCbDlqQXhWaFdETS8xQkJXQVZCRjFpbEZ3?=
 =?utf-8?B?THJ5dWhXZWgzTysvTnB3QUt0ck5FZTl4R0NNczlYYVFrZ3VhVkloemcrNW4w?=
 =?utf-8?B?VTRCZ055YkFjS0g4UTJPcUhtR0UxSnh0cWY3bU05VDU2SjV0TFJzZlBvd01P?=
 =?utf-8?B?Ykt1RWxVbVB2ZHMrZkVrRWJvMU5IWnlsSm02ZHJ3ZjRUWEdHQXl0TzlhL2tH?=
 =?utf-8?B?MHIxUkp0NDZERi9INWEwRTcvaVIvVk8xZ2ZOZTBRbGxxNzJ3cjIrWWZ1dFBp?=
 =?utf-8?B?Q3NOMTU4WDRwdDcrOUdSTi82alVUbFliZ0xBSDNMS0FhR3JpMHRMTTdocUlB?=
 =?utf-8?B?dHBXTnVsMHVQaHlvdFdxYkErb3ZWTHlSOUpqWk4waWliOTdnbTZ1TGpFMW84?=
 =?utf-8?B?aWd6dU54cEJ0L2MrZHlnMEpXKzBnRll1ZmIyeVNUdk1xOCtuYUtJdVJHbzZi?=
 =?utf-8?B?MVNZZGhVb0RhTlh0TDRiYThFVmIxU2taVTVMVGo1V1pZR29WMW9JYzJQUDIy?=
 =?utf-8?B?UytHdmZuOUJ2aXNwcm5YQ3J4R1phZHpkTDFPV2J4bjJ2a0FMaFlwQ1pZUTVr?=
 =?utf-8?B?LzRCeVdkU2lKTEhrUlA4RUNVK2dsZWVqOFljVGt6UTkzUTViS3g3ZVRnS3RN?=
 =?utf-8?B?bFo1bFM4QXorbEtxZzhrVWh5ZG5IMHdaZkZUMEZFRzFSVE5HUENaWVl1Y3Ux?=
 =?utf-8?B?N2V0UXhRekZtU0VOSjc0amp6d0t2amdIaDBJZnlOYklYbk4xMGxvVjlpUHJR?=
 =?utf-8?B?SDhza1NKcTEvRU1wdHpvcSt4M21PNzEwQ3BvVll2a3BrZjM5cG44UlR2RThh?=
 =?utf-8?B?VFJ5TFFqeUlKTFRSWTI5WThWcWMzQXRQL0lWZzBvazREMWp2YTZVeUFsUTNW?=
 =?utf-8?Q?s7RpCzpcAmB5THY/rFMasvmIb?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5248c5-acad-46dc-6cc5-08dd99d10a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 08:08:45.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcUMicDFNp1TQKz9FTzWz5AB9+N+tZfXvZ/tP7Sk4X32FIsxcfncAaS7l/IiC/2M6SFdAveEEJAJC06ArHPlew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8581

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJhbmsgTGkgPGZyYW5r
LmxpQG54cC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDIzLCAyMDI1IDI6MjkgQU0NCj4gVG86
IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEx1a2UgV2FuZyA8emluaXUu
d2FuZ18xQG54cC5jb20+OyBhZHJpYW4uaHVudGVyQGludGVsLmNvbTsNCj4gdWxmLmhhbnNzb25A
bGluYXJvLm9yZzsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9y
ZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0
ZXZhbUBnbWFpbC5jb207DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGRsLVMzMiA8UzMyQG54cC5j
b20+OyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogc2RoY2ktZXNk
aGMtaW14OiBkbyBub3QgY2hhbmdlIHBpbmN0cmwgc3RhdGUgaW4NCj4gc3VzcGVuZCBpZiBmdW5j
dGlvbiBpcnEgaXMgd2FrZXVwIHNvdXJjZQ0KPiANCj4gT24gVGh1LCBNYXkgMjIsIDIwMjUgYXQg
MDM6MTY6MTFBTSArMDAwMCwgQm91Z2ggQ2hlbiB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4g
PiA+IFNlbnQ6IDIwMjXlubQ15pyIMjHml6UgMjM6NTYNCj4gPiA+IFRvOiBMdWtlIFdhbmcgPHpp
bml1LndhbmdfMUBueHAuY29tPg0KPiA+ID4gQ2M6IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5Abnhw
LmNvbT47IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOw0KPiA+ID4gdWxmLmhhbnNzb25AbGluYXJv
Lm9yZzsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsN
Cj4gPiA+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVz
dGV2YW1AZ21haWwuY29tOw0KPiA+ID4gaW14QGxpc3RzLmxpbnV4LmRldjsgZGwtUzMyIDxTMzJA
bnhwLmNvbT47DQo+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1t
Yzogc2RoY2ktZXNkaGMtaW14OiBkbyBub3QgY2hhbmdlIHBpbmN0cmwgc3RhdGUgaW4NCj4gPiA+
IHN1c3BlbmQgaWYgZnVuY3Rpb24gaXJxIGlzIHdha2V1cCBzb3VyY2UNCj4gPiA+DQo+ID4gPiBP
biBXZWQsIE1heSAyMSwgMjAyNSBhdCAxMTozMTozNEFNICswODAwLCB6aW5pdS53YW5nXzFAbnhw
LmNvbQ0KPiB3cm90ZToNCj4gPiA+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAu
Y29tPg0KPiA+ID4gPg0KPiA+ID4gPiBwaW5jdHJsIHNsZWVwIHN0YXRlIG1heSBjb25maWcgdGhl
IHBpbiBtdXggdG8gY2VydGFpbiBmdW5jdGlvbiB0byBzYXZlDQo+ID4gPiA+IHBvd2VyIGluIHN5
c3RlbSBQTS4gQnV0IGlmIHVzZGhjIGlzIHNldHRpbmcgYXMgd2FrZXVwIHNvdXJjZSwgbGlrZSB0
aGUNCj4gPiA+ID4gY2FyZCBpbnRlcnJ1cHQoU0RJTykgb3IgY2FyZCBpbnNlcnQgaW50ZXJydXB0
LCBpdCBkZXBlbmRzIG9uIHRoZQ0KPiA+ID4gPiByZWxhdGVkIHBpbiBtdXggY29uZmlndXJlZCB0
byB1c2RoYyBmdW5jdGlvbiBwYWQuDQo+ID4gPiA+IGUuZy4gVG8gc3VwcG9ydCBjYXJkIGludGVy
cnVwdChTRElPIGludGVycnVwdCksIGl0IG5lZWQgdGhlIHBpbiBpcw0KPiA+ID4gPiBjb25maWcg
YXMgdXNkaGMgREFUQVsxXSBmdW5jdGlvbiBwaW4uDQo+ID4gPg0KPiA+ID4gSSB0aGluayBpdCBz
aG91bGQgYmUgZHRzIHNldHRpbmdzIHdyb25nLiBEb2VzIG9uZSBQQUQgc2V0IGFzIGZ1bmN0aW9u
DQo+IGltcGFjdA0KPiA+ID4gcG93ZXIgbXVjaD8NCj4gPg0KPiA+IEhpIEZyYW5rLA0KPiA+DQo+
ID4gSSBkb3VibGUgY2hlY2sgdGhlIHBvd2VyIHRlYW0sIG9uIGlteDkzLTExeDExLWV2ayBib2Fy
ZCwgRm9yIFNEIGNhcmQgb24NCj4gdXNkaGMyLCBzd2l0Y2ggdGhlIFBBRCB0byBncGlvIGZ1bmN0
aW9uIHdpbGwgc2F2ZSBhYm91dCAzfjRtdywNCj4gPiBGb3IgU0RJTyB3aWZpIG9uIHVzZGhjMywg
c3dpdGNoIHRoZSBQQUQgdG8gZ3BpbyBmdW5jdGlvbiB3aWxsIHNhdmUgYWJvdXQNCj4gMC44fjFt
dy4gKHdpdGhvdXQgd2FrZXVwKQ0KPiANCj4gT2theSwgSSB0aGluayBpdCBzaG91bGQgYmUgYWRk
IG5ldyBwaW5jdHJsIHN0YXRlICgid2FrZXVwIiksIG9ubHkgc2V0DQo+IERBVEFbMCwyLDNdDQo+
IHRvIEdQSU8gYW5kIFNFVCBEQVRBWzFdIHRvIHNkIGZ1bmN0aW9uLg0KPiANCj4gWW91IGNhbiBj
aGFuZ2UgcGFkIHNldHRpbmcgdG8gIndha2V1cCIgc3RhdGUgaWYgd2FrZSB1cCBlbmFibGVkLg0K
PiANCg0KSGkgRnJhbmssDQoNCkFkZGluZyBuZXcgcGluY3RybCBzdGF0ZSB3aWxsIGJyaW5nIGJv
dGggZHJpdmVyIGFuZCBkdHMgY2hhbmdlcy4NCldoYXQgYWJvdXQgd2Ugb25seSBjaGFuZ2Ugc2xl
ZXAgcGluY3RybCBEQVRBWzFdIHRvIHNkIGZ1bmN0aW9uIGZvciBTRElPPw0KDQpSZWdhcmRzDQpM
dWtlDQoNCj4gRnJhbmsNCj4gDQo+ID4NCj4gPiBSZWdhcmRzDQo+ID4gSGFpYm8gQ2hlbg0KPiA+
ID4NCj4gPiA+IEZyYW5rDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBGaW5kIHRoZSBpc3N1ZSBv
biBpbXg5My0xMXgxMS1ldmsgYm9hcmQsIFNESU8gV2lGaSBpbiBiYW5kIGludGVycnVwdA0KPiA+
ID4gPiBjYW4ndCB3YWtldXAgc3lzdGVtIGJlY2F1c2UgdGhlIHBpbmN0cmwgc2xlZXAgc3RhdGUg
Y29uZmlnIHRoZSBEQVRBWzFdDQo+ID4gPiA+IHBpbiBhcyBHUElPIGZ1bmN0aW9uLg0KPiA+ID4g
Pg0KPiA+ID4gPiBGb3IgdGhpcyBjYXNlLCBkbyBub3QgY2hhbmdlIHRoZSBwaW5jdHJsIHN0YXRl
IGluIHN1c3BlbmQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4g
PGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTHVrZSBXYW5nIDx6
aW5pdS53YW5nXzFAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMTYgKysrKysrKysrKysrLS0tLQ0KPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+
ID4gPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ID4gPiBpbmRl
eCA1ZjFjNDViMmJkNWQuLmYyMDZiNTYyYTZlMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gPiA+IEBAIC0yMDU3LDEyICsyMDU3LDIwIEBAIHN0
YXRpYyBpbnQgc2RoY2lfZXNkaGNfc3VzcGVuZChzdHJ1Y3QNCj4gZGV2aWNlDQo+ID4gPiAqZGV2
KQ0KPiA+ID4gPiAgCQlyZXQgPSBzZGhjaV9lbmFibGVfaXJxX3dha2V1cHMoaG9zdCk7DQo+ID4g
PiA+ICAJCWlmICghcmV0KQ0KPiA+ID4gPiAgCQkJZGV2X3dhcm4oZGV2LCAiRmFpbGVkIHRvIGVu
YWJsZSBpcnEgd2FrZXVwXG4iKTsNCj4gPiA+ID4gKwl9IGVsc2Ugew0KPiA+ID4gPiArCQkvKg0K
PiA+ID4gPiArCQkgKiBGb3IgdGhlIGRldmljZSB3aGljaCB3b3JrcyBhcyB3YWtldXAgc291cmNl
LCBubyBuZWVkDQo+ID4gPiA+ICsJCSAqIHRvIGNoYW5nZSB0aGUgcGluY3RybCB0byBzbGVlcCBz
dGF0ZS4NCj4gPiA+ID4gKwkJICogZS5nLiBGb3IgU0RJTyBkZXZpY2UsIHRoZSBpbnRlcnJ1cHQg
c2hhcmUgd2l0aCBkYXRhIHBpbiwNCj4gPiA+ID4gKwkJICogYnV0IHRoZSBwaW5jdHJsIHNsZWVw
IHN0YXRlIG1heSBjb25maWcgdGhlIGRhdGEgcGluIHRvDQo+ID4gPiA+ICsJCSAqIG90aGVyIGZ1
bmN0aW9uIGxpa2UgR1BJTyBmdW5jdGlvbiB0byBzYXZlIHBvd2VyIGluIFBNLA0KPiA+ID4gPiAr
CQkgKiB3aGljaCBmaW5hbGx5IGJsb2NrIHRoZSBTRElPIHdha2V1cCBmdW5jdGlvbi4NCj4gPiA+
ID4gKwkJICovDQo+ID4gPiA+ICsJCXJldCA9IHBpbmN0cmxfcG1fc2VsZWN0X3NsZWVwX3N0YXRl
KGRldik7DQo+ID4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+
ID4gPiAgCX0NCj4gPiA+ID4NCj4gPiA+ID4gLQlyZXQgPSBwaW5jdHJsX3BtX3NlbGVjdF9zbGVl
cF9zdGF0ZShkZXYpOw0KPiA+ID4gPiAtCWlmIChyZXQpDQo+ID4gPiA+IC0JCXJldHVybiByZXQ7
DQo+ID4gPiA+IC0NCj4gPiA+ID4gIAlyZXQgPSBtbWNfZ3Bpb19zZXRfY2Rfd2FrZShob3N0LT5t
bWMsIHRydWUpOw0KPiA+ID4gPg0KPiA+ID4gPiAgCS8qDQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIu
MzQuMQ0KPiA+ID4gPg0K
