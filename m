Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E186EEC5;
	Tue, 29 Oct 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169235; cv=fail; b=R4M/ESguke2OjHRz5KjXAp/vpFo21BvY2pU8YuJuvCB4A4rPM7RmZe70QgAnRAW64L5CagFwFkU0xlKc8GlSDhP5sMYYIAeb/8OIZBcoEn8ZM0uGWgpbg/IRxMH5nk1HS78GabRI+CZLUzSXt1DfsYh3q5tWsTBORXjQ7T1ZTtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169235; c=relaxed/simple;
	bh=4HwFMi6zkUuKk9MpaAt8eD5UmBS8bAsvvBp64lq8gNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbfIeCbqPTQX+h+b4TB6wcUJEevdSd2wJaCfto9QuTrSjupy/lfD5+LWPqrEuw3ZhyaUbFXdTUthZ8uEDPHo1kBryHNEfIDLtg0MS7DzGdCyFALwJAScy+Pq21zvilgvp7yLOjovf3YpCD6FXyXGAd2I4pe3CdOfOySYlZAI8bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d7+kgB07; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d7+kgB07"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtAaO5EitvBRJW5cgFLZET4Hyq5jbsAmnSLu9tRx2SdOz0DXwN1mdDGe688wup9p+5oSmy6n8CXNFpwZmh6XJx+kAs4nHbGYGyUkMt/dpJIFgSGQhzNQ/VMQl1kuxY3I3QT0mg8OKPPKNixOzx0wKyTKG8To7LSC4b2JI1v8pWNbrKWuBj1qwaYRlvzP6KQ6E8HNt1sQnYsqAk9kkCkm8WqT6R+cHAXSrYCi3pVB23CzCPI68jChFPTjWP4zLv1jFD+GkmnJWB4GqfNKzumBRAQ6Z82kLQJkotq2delMwkc9LC3LPA8v9W7cKIeEIXzUhQIh7r0aBdzVSt03wz3lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HwFMi6zkUuKk9MpaAt8eD5UmBS8bAsvvBp64lq8gNQ=;
 b=CWsQsTmcboSpNtvuVjpj4GQ+YiLUOTHdspRkBHAvy9nZoQlCfa7Rybo+w/kQoh4gVEvqSUhk8el/0E+1hm1DECTaeEKBlXEDTFOJQTlFEJnR8MJKKIC4jEUtNrslgH35N9ugtwiR8Jk62kbp1yWrM5r+/OFJ1zDu7Ef7BO3wE7ZWB5fy8NaJMfNuHEkrNrvXhyy29qQCRywXYuHk5VSblrQIRjSf7SfdpwQ8mZgqRroNuIdVQJr6h5SjOElLxD2SBOThzi6vg0ALYS/w53iWMB1tZ0tDEspOO5DAwLqarqlf9HGpdYxsP+XB0vDZoZgK2F0wQbVBXWOpqqKJMjQPjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HwFMi6zkUuKk9MpaAt8eD5UmBS8bAsvvBp64lq8gNQ=;
 b=d7+kgB07d2SZbyfn1WhcVrLozmHfZ7a7jDui/PC9x6GD8+pWrcBu0v4ZI/mJjic1saPr7IvRHFJrB0D66CgmmgcQHFM2kFrXk+tRKCx1rcHt/CFT24yKdAz1vM2BT1NWrupvvsM/ZKRVjvRTpFwaftJ0m/B21xRANbdD9ePWopCVeErcdAe06wXXEdO2A4W+deG96VrtjOUx6LbcrmYk2nxQ5ylC961z+QpXw9jLw/m/1ZAW9YVfZG5xYd3H3D8RU3xNL5PyKG/Td9qPD7jKq9UKczcEkt3RPGCWauByj/Yd2Wz7fFDubl8vuPode0mcFD5nURIUev4zLF0cs3I0cA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10942.eurprd04.prod.outlook.com (2603:10a6:150:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 02:33:48 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 02:33:48 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Josua Mayer <josua@solid-run.com>, Peng Fan <peng.fan@nxp.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: yazan.shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware
 reset
Thread-Index: AQHbKH5LcX/pcU7hiEe46rC2ml7debKba/0AgAAN+ECAAIIsAIABBbYw
Date: Tue, 29 Oct 2024 02:33:48 +0000
Message-ID:
 <DU0PR04MB949630B1EE9A0F19DACE3414904B2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com>
 <PAXPR04MB84591664B7A4455E6F0BD19E884A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <DU0PR04MB9496769805197714F198EC0F904A2@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <913d8706-ec58-4197-889a-0d2d94c67ccc@solid-run.com>
In-Reply-To: <913d8706-ec58-4197-889a-0d2d94c67ccc@solid-run.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|GV1PR04MB10942:EE_
x-ms-office365-filtering-correlation-id: 029be7ac-f6b3-435c-fc1a-08dcf7c21e49
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlYzTW0vRDhqTVFqbHdBVmI5Tm1MMmJCeDB4bmdpOC9TRWt4b0ZhaEFDVmxr?=
 =?utf-8?B?djVmN0FIbkpVVW4yUHdKM3BMSmFIRytkaDFuckhaRTR1R0hyREZZcnZlaGsv?=
 =?utf-8?B?aTRDZmEwbVpudGlwSXpvQnp0SW4xa0JPS3MvbVJGeEszU21tTWFqSkhHYi8w?=
 =?utf-8?B?SHVId1F5OXB2T3hjLzcvUDZQS3QrcGZyd0xPWHJpUDBtamJoRjRvSXpqRVpi?=
 =?utf-8?B?dU9yYS96dENlQTROd3lWVG5wYXRYbDJ0ZG1kRVJ4MEtLWFV1eU9nN1FWTXNm?=
 =?utf-8?B?MWZhZjZqRnZQcFNTVkgraS9iL1RGZHBTOVNlQTJ5N2MwYlIrMXVQeEZDd1Fz?=
 =?utf-8?B?NzQ2Q1NrK2JCVVJ2V3gxQlVXNVJVbTFQSS9IUDJEMTI5ZmpvT3RTa1VWVmNH?=
 =?utf-8?B?cHRNdDRsOCtoajZwVGJ1bW9WSEdkdTQ2ZDJqV2FML3pUZlE1VmxmeEh2b2oy?=
 =?utf-8?B?RGhteHJCU3VEMEh0eTJmb2ZGWUFoYVhRNk9NblFLRVJXNi8xY2lTdGxGUnE3?=
 =?utf-8?B?dDFwWlZpUGVhK0dYZzlFbTVER2lrZldZQlFGcEhMTndiR2M5Vy96MWtOeTB3?=
 =?utf-8?B?RG94YXNVQy9HMW9vMnNzU1dxbnhsOEN5eUlxS0xvRWNtOW52OENaZThIV3Jq?=
 =?utf-8?B?YkUyakpnYWJOcHNNYTU2U3lWVU1ac3NkdEdhWGNiOC9OcFVvKy9uNnBnRE5L?=
 =?utf-8?B?QnFUUm8xWUVpbUpiU0ZsaGcxWHp0eG1wc2l3ZG9lbjgvREV6ektEbGU2UEc1?=
 =?utf-8?B?V2NRODF5V0cvQ1RyYk9uUERQdWxneGhCTi8vNXBrWUxQRGQxTjB1UzU0anBD?=
 =?utf-8?B?Z1JBaHJiU3c2WkhSSVNBNXR1b2NWWkloU0RTMGUxTlNDQnlSZjV1c0wxd3I3?=
 =?utf-8?B?QW9iQmpyK2NMdjhwbG1XNllXaXJpT281OUNwaStDM3NUejNSMnhDc2w5UHdI?=
 =?utf-8?B?NFVFbnJlV2VqS1RERkRpaEFRbDc2Uk5DMFk4QVkxU3BHMEVNSU9lQngxV1Q3?=
 =?utf-8?B?aS9JNDRrOG9zOE01eFhHL3VtYnZyZ1J3Zkt1bEtHRjVJeTdQNStKbXorekZa?=
 =?utf-8?B?UkVtajRZQXhCVXE1YjREdW9zMng1Rm1IUkl1SE40L0ZGbmZ5Zi9ySjdDR0VC?=
 =?utf-8?B?QUozQlN2d1BJYlFZQ1RYVkwzOGtsaEQzVVpYZG01elljR2F4RlYrNk14dzFF?=
 =?utf-8?B?YTZZNTBqRVZXRVBrQTc5VjlCM3dqRXNyQ0dTalFlaGZ4UnhsdGVqWVhXdU1k?=
 =?utf-8?B?cm1xOFNFUzZSMm1ZSVo2NkdZU2lnOE9PSjBwWUhmc2p5cDI3V3JUYUE5NGNh?=
 =?utf-8?B?R0VkaXNCSmczcUJYckg0US9zV2p1NkhBU3NzNzVpSkNwcC8rTVpzU2d5S2dJ?=
 =?utf-8?B?K21pRDZGWE9UNVRvZU5TalRKSkdrb0IyV0h0SG84OW54ZnMxLzRTRzBVRW9h?=
 =?utf-8?B?T3VhMS9oYklzMVdWM1JsSU41K3M4T09qaVEwYVIwdW9ZbUErdU45Mmp5MFI4?=
 =?utf-8?B?QnZ4Rm1qKzFIUEtYVnovMU4wR0U5c1ZMclluMmRJL1lOcTIwT1NyQjMweCtx?=
 =?utf-8?B?dFVhVDlKQWpFeGZRNGlpTGVrbGxKWUNrbTJxNkUrcGRBRGJCS3A1SHdDTkVI?=
 =?utf-8?B?QkFkY1dGMnN1U1RyVGU1QUNadVdmYm9VaXhKNWE1eUFqMEtNQnZTT0xSL1Fi?=
 =?utf-8?B?aXFCRktOMlJmSSsvc0QzMVp4b0xnRE1WTmNzbVhaR3M5djRKKzF2amtQRXFn?=
 =?utf-8?B?Wm1mcWtFcVhOaGoyQVg3ZzdOc05sMWIvSHppSTFiTUtzdGFDeUxLZzBLanc1?=
 =?utf-8?Q?ljSQFJ43GTBA5Wn4eTZERSI2RCcBe6yCW1A+8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejFDTy9LZVN2bWZkM200MFVZV3NZdGVFMjU0dEltT0R6QTVNVko5KzZIblRk?=
 =?utf-8?B?Zm1ua2xFOUdPM21ZUDgvR1FLc0RyaW9SYkI1UTdRcVZVbWpvYkE5SUJTSzdq?=
 =?utf-8?B?VXE0ZHJRcjNHWldmcTdJZ1RUQzI1V0xCeFhKbG5Nd2xYTG1hMjBVYVl6R3E5?=
 =?utf-8?B?b3BMVU94QjBoR200dzZQbXdZT0pSb3E4S2hnQmtBVjZmQzBpQ0wzQ25xYkFi?=
 =?utf-8?B?dWZOTHhLUjlsd1p0aWJZMjBaZUN2SXhlYW0rcUdhMkttbVl2RGZlMm40OWVP?=
 =?utf-8?B?dHQ3UXRuTWZJbno0MGRDVy9kdTR1VEtvb3JmYmhNckVuQ1BFdXlyQzB6TGlG?=
 =?utf-8?B?T1BFWDA3MDR2WitPOEt4RlhBeXBhREx4NGdEYW1LNlhJTnpwM3BXSzM3YlBE?=
 =?utf-8?B?elltYWZ1akZWaEpTVzZIVmM3Z0xaVXNET3FnZmhYZy9mbHVaSU9UN2NTeit1?=
 =?utf-8?B?Y3hlZ3VpYkFCaU02THR1SlNxR3UyUEJOdGhOUUZ1Z0xhNnA4cGlWclVQd2NO?=
 =?utf-8?B?SElIQjdjcVNmTXhnUXdDQ0FmRFp2WDhoMERsVnB4VE5DL0tqcC9ydmV0eE5H?=
 =?utf-8?B?ZElnUFVNcWRicWZTbWw0R1g0YkxaQ3VlUklHYWpxTzlKTUxTMWxaWGhHYXBV?=
 =?utf-8?B?dUdKbjR6aEthb0Nzb1QzQjJjRTgzUVhqcm0vNzBhMW8vVHpWKzlOQnpNNVpM?=
 =?utf-8?B?UjMvWVFlQTRKUVlMSGQ3aG5VeURMdGI3RHkyRFFPVW8xd2lBMUdHYS81OXQ4?=
 =?utf-8?B?aXltaTYvcE81dTVmT0VzbXVXa1RCTlUydUtFNlErN2ZxVlBkQjFPQUlRSWNC?=
 =?utf-8?B?OGNSV3ZRbzgyYUFoV0xIVjJGak1aVmtGaC8reDhnczBld01UdEdNSXRPc2c1?=
 =?utf-8?B?eDI3bmFWaVRMZUJBL2Q4UHJIR1NjRlhYUWNOb09EZGE0MXlENzVFK1dPTi9O?=
 =?utf-8?B?U1BnK3paLzJOQU1PNUdPaXc4cU5FNFFPS2RZazlsSUZseTVBbmtXM1ptbzA1?=
 =?utf-8?B?VGg1bFE0Sm8reHZlWTJmK21oQmNzYkc4dkZEYS9GU2JlVWJHSU5jc0lIaSt6?=
 =?utf-8?B?V0h5Sk01VG5RTVliSGpHVktuRlhHU3VaUEFDNlB1N2NBUnVZc3M5QVRWQ0Fq?=
 =?utf-8?B?R2VCaTBEYnFKYTJsdzZwUFNOUFRuU05idVptK1RrQjJYRUdJN2t4Y1hHOVRx?=
 =?utf-8?B?ZmZZYXVGWXh2cHlzR1pnUzlQTXJZdUNSVktxdVBDMSsxNXdIVkpRbnpPYmZ2?=
 =?utf-8?B?NzhpVHAvVE00di8wbUdhV1pNNTcyZGY5dGMza1lPTDR2WnBsMVNGa2FDS0Rw?=
 =?utf-8?B?V0g1NEJ3UnZjNlg2WWExQnpNYVNmREFscGNsaEVIMFJGMHo5SEdaZlNYTDl6?=
 =?utf-8?B?Sk9hcmZkWEdKNkh2MzdVZkVDWm8vY3VIeUx2b0ppcTF1ODREMkpJd1dTWm1K?=
 =?utf-8?B?b1lDam45Si9GMmtIYWV3cHF3WW4wanlUWWNtVTdXQlVxYlhXa3JtV0ZTUGgz?=
 =?utf-8?B?bEJqK05rclkxVjJFVFVkSHk2QjhZZGhpOER1aUs2ZWY4Q0gzSllUWmZnRzMz?=
 =?utf-8?B?N1ZnMkV4RE41RVpGOG11ZjNiZXh6cEZDczFTZFZ5d3FROUtHNnd0VWlaaWxR?=
 =?utf-8?B?K1IwVFFhbmdKZnY1SmROZk1EVGpaSDJvNmd6Ny8rWUo0RlNzZ1ByWFBuVGpw?=
 =?utf-8?B?cXhJSGw2QjBBR3BEN2RrWXhvcHNMS1pzbzczKzF2VHJyN09teTJ3endPVnNy?=
 =?utf-8?B?cXNjSGZ1QVFrTWxpUDRTOGQ2a1p4ZTNQOTQxMERKa3ZkOWJieWVLZ0JkbHNk?=
 =?utf-8?B?WWphNlR5eXVudHFnOVErUklqSTNJcDFjQU1nNGMyV3JVS0VYSHRURmxyRnFT?=
 =?utf-8?B?V2g2QTlsek15Um1Fbm50L0IzM1g0amNkREZMcTRJTzJ3c2kxNzVEK3NnbE5l?=
 =?utf-8?B?OER6VEpQQm1FaTdDenNkNFR3L1I3THNweGxSUk9vMlBwYndEUElkR1RLUjlr?=
 =?utf-8?B?djJHcFRDQUloZktkN3hva0dodkdVK3lZR21kdEpGUFc3Y2VIMnlqMGZIWjdM?=
 =?utf-8?B?WDNCVzgrUmhNbjcwODdCZmh4WWtGK2gvYll1V3JyNU5WdkEvQ1V3UjdUL25n?=
 =?utf-8?Q?urPE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 029be7ac-f6b3-435c-fc1a-08dcf7c21e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 02:33:48.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jaTk9Zu38EJuTL/fN+9DklvfQK37v48qpeUbAcYX3xlR+qynHA4vxr0ujIWbZI7mo8jPtrjnZ1y9RuNLbti9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10942

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3N1YSBNYXllciA8am9zdWFA
c29saWQtcnVuLmNvbT4NCj4gU2VudDogMjAyNOW5tDEw5pyIMjjml6UgMTg6NDYNCj4gVG86IEJv
dWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
PjsNCj4gQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBVbGYgSGFuc3Nv
bg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBlbmd1dHJv
bml4IEtlcm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFt
IDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IENjOiB5YXphbi5zaGhhZHkgPHlhemFuLnNoaGFkeUBz
b2xpZC1ydW4uY29tPjsgUmFiZWVoIEtob3VyeQ0KPiA8cmFiZWVoQHNvbGlkLXJ1bi5jb20+OyBp
bXhAbGlzdHMubGludXguZGV2OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0KPiBkbC1TMzIg
PFMzMkBueHAuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzog
aG9zdDogc2RoY2ktZXNkaGMtaW14OiBpbXBsZW1lbnQgZW1tYyBoYXJkd2FyZQ0KPiByZXNldA0K
PiANCj4gQW0gMjguMTAuMjQgdW0gMDQ6MTUgc2NocmllYiBCb3VnaCBDaGVuOg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gPj4gU2VudDogMjAyNOW5tDEw5pyIMjjml6UgMTA6MTANCj4gPj4gVG86IEpvc3Vh
IE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPjsgQWRyaWFuIEh1bnRlcg0KPiA+PiA8YWRyaWFu
Lmh1bnRlckBpbnRlbC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBVbGYN
Cj4gPj4gSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz47DQo+ID4+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5k
ZT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+ID4+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+
OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+ID4+IENjOiB5YXphbi5zaGhh
ZHkgPHlhemFuLnNoaGFkeUBzb2xpZC1ydW4uY29tPjsgUmFiZWVoIEtob3VyeQ0KPiA+PiA8cmFi
ZWVoQHNvbGlkLXJ1bi5jb20+OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiA+PiBsaW51eC1tbWNA
dmdlci5rZXJuZWwub3JnOw0KPiA+PiBkbC1TMzIgPFMzMkBueHAuY29tPjsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+ID4+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIG1tYzogaG9zdDogc2RoY2ktZXNkaGMtaW14
OiBpbXBsZW1lbnQgZW1tYw0KPiA+PiBoYXJkd2FyZSByZXNldA0KPiA+Pg0KPiA+Pj4gU3ViamVj
dDogW1BBVENIXSBtbWM6IGhvc3Q6IHNkaGNpLWVzZGhjLWlteDogaW1wbGVtZW50IGVtbWMgaGFy
ZHdhcmUNCj4gPj4+IHJlc2V0DQo+ID4+Pg0KPiA+Pj4gTlhQIEVTREhDIHN1cHBvcnRzIGNvbnRy
b2wgb2YgbmF0aXZlIGVtbWMgcmVzZXQgc2lnbmFsIHdoZW4gcGlubXV4DQo+ID4+PiBpcyBzZXQg
YWNjb3JkaW5nbHksIHVzaW5nIHVTREhDeF9TWVNfQ1RSTCByZWdpc3RlciBJUFBfUlNUX04gYml0
Lg0KPiA+Pj4gRG9jdW1lbnRhdGlvbiBpcyBhdmFpbGFibGUgaW4gTlhQIGkuTVg2USBSZWZlcmVu
Y2UgTWFudWFsLg0KPiA+PiBCdXQgdGhpcyByZWxpZXMgb24gdGhlIFBBRCBiZWVuIGNvbmZpZ3Vy
ZWQgYXMgUkVTRVQsIHNob3VsZCB0aGlzIGZsb3cNCj4gPj4gYmVpbmcgZGVmYXVsdCBlbmFibGVk
IHdoZXRoZXIgdGhlIFBBRCBpcyBjb25maWd1cmVkIGFzIFJFU0VUIG9yIG5vdD8NCj4gPiBObywg
ZnJvbSBteSB1bmRlcnN0YW5kaW5nLCBldmVuIHRoZSBQQUQgaXMgY29uZmlndXJlZCBhcyBSRVNF
VCwgc3RpbGwgbmVlZCBTVw0KPiB0byBjb25maWcgSVBQX1JTVF9OIHRvIGNvbnRyb2wgdGhlIG91
dHB1dCBvZiB0aGlzIHBhZC4NCj4gPiBKb3N1YSwgeW91IGNhbiBkb3VibGUgY29uZmlybSB0aGlz
IG9uIHlvdXIgYm9hcmQuDQo+IENvcnJlY3QsIG9ubHkgd2hlbiBhIHBhZCBpcyBjb25maWd1cmVk
IGZvciBlbW1jIHJlc2V0IGZ1bmN0aW9uIGRvZXMgdGhlIHJlc2V0DQo+IHNpZ25hbCBhZmZlY3Qg
YW55IGJvYXJkIGNpcmN1aXQuDQo+IA0KPiBXZSB0ZXN0ZWQgdGhpcyB3aGVuIHdlIGhhZCB3cm9u
ZyBwaW5tdXggYW5kIHJlc2V0IGRpZCBub3QgdG9nZ2xlLg0KPiANCj4gPiBCeSB0aGUgd2F5LCBJ
IGNoZWNrIHRoZSBjb2RlLCB3aGVuIHlvdSBkbyB0aGUgdGVzdCB0byBzdXBwb3J0IHRoaXMgcmVz
ZXQNCj4gb3BlcmF0aW9uIG9uIGVNTUMsIGRpZCB5b3UgYWRkICAiY2FwLW1tYy1ody1yZXNldCIg
aW4gZHRzPw0KPiANCj4gQ29ycmVjdDoNCj4gDQo+ID4gRnJvbSBjdXJyZW50IGNvZGUgbG9naWMs
IHRoZSBjYWxsYmFjayB5b3UgYWRkIGhlcmUgc2VlbXMgb25seSBjYW4gYmUgY2FsbGVkIGJ5DQo+
IGVNTUMgZGV2aWNlLCBzbyB3aWxsIGJlIHNhZmUgZm9yIHNkIGFuZCBzZGlvIGRldmljZS4gQW5k
IGlmIHlvdXIgYW5zd2VyIGZvciBteQ0KPiBxdWVzdGlvbiBpcyAieWVzIiwgdGhlbiB5b3VyIGNo
YW5nZSB3aWxsIGFsc28gYmUgc2FmZSBmb3IgZU1NQyBkZXZpY2Ugd2hpY2ggZG8NCj4gbm90IHVz
ZSB0aGlzIHJlc2V0IGZ1bmN0aW9uIGJlZm9yZS4NCj4gSSBiZWxpZXZlIHNvLiBPbmx5IHdoZW4g
ZHRzIGRlY2xhcmVzIHRoZSBjYXBhYmlsaXR5IHdpbGwgc2RoY2lfaHdfcmVzZXQNCj4gDQo+IGdl
dCBjYWxsZWQsIGFuZCB0aGVuIGl0IHdpbGwgY2FsbCBlc2RoYy1pbXggZHJpdmVyIGh3X3Jlc2V0
Lg0KPiANCj4gU2VlIGFsc28gZHJpdmVycy9tbWMvY29yZS5jOiBfbW1jX2h3X3Jlc2V0DQo+IA0K
PiA+DQo+ID4NCj4gPj4+IEltcGxlbWVudCB0aGUgaHdfcmVzZXQgZnVuY3Rpb24gaW4gc2RoY2lf
b3BzIGFzc2VydGluZyByZXNldCBmb3IgYXQNCj4gPj4+IGxlYXN0IDEwdXMgYW5kIHdhaXRpbmcg
YW4gZXh0cmEgMzAwdXMgYWZ0ZXIgZGVhc3NlcnRpb24uDQo+ID4+PiBUaGVzZSBwYXJ0aWN1bGFy
IGRlbGF5cyB3ZXJlIGluc3BpcmVkIGJ5IHN1bnhpLW1tYyBod19yZXNldCBmdW5jdGlvbi4NCj4g
Pj4+DQo+ID4+PiBUZXN0ZWQgb24gU29saWRSdW4gaS5NWDhEWEwgU29NIHdpdGggYSBzY29wZSwg
YW5kIGNvbmZpcm1lZCB0aGF0DQo+ID4+PiBlTU1DIGlzIHN0aWxsIGFjY2Vzc2libGUgYWZ0ZXIg
Ym9vdC4gZU1NQyBleHRjc2QgaGFzDQo+ID4+PiBSU1RfTl9GVU5DVElPTj0weDAxLCBpLmUuDQo+
ID4+PiByZXNldCBpbnB1dCBlbmFibGVkLCBMaW51eCB2NS4xNS4NCj4gPj4+DQo+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gPj4+IC0tLQ0K
PiA+Pj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAxMiArKysrKysrKysr
KysNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4+PiBi
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPj4+IGluZGV4DQo+ID4+PiA4
ZjBiYzZkY2EyYjA0MDJmZDJhMDY5NTkwM2NmMjYxYTViNGUxOWRjLi5lYmNmYTQyN2NjYTZjYzI3
OTENCj4gPj4+IGExNzAxYTM1MTVlZjY1MTU3NzlhYTQgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4+PiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4+PiBAQCAtMzMsNiArMzMsOCBAQA0KPiA+Pj4gICNk
ZWZpbmUgRVNESENfU1lTX0NUUkxfRFRPQ1ZfTUFTSwkweDBmDQo+ID4+PiAgI2RlZmluZQlFU0RI
Q19DVFJMX0QzQ0QJCQkweDA4DQo+ID4+PiAgI2RlZmluZSBFU0RIQ19CVVJTVF9MRU5fRU5fSU5D
UgkJKDEgPDwgMjcpDQo+ID4+PiArI2RlZmluZSBFU0RIQ19TWVNfQ1RSTAkJCTB4MmMNCj4gPj4+
ICsjZGVmaW5lIEVTREhDX1NZU19DVFJMX0lQUF9SU1RfTglCSVQoMjMpDQo+ID4+PiAgLyogVkVO
RE9SIFNQRUMgcmVnaXN0ZXIgKi8NCj4gPj4+ICAjZGVmaW5lIEVTREhDX1ZFTkRPUl9TUEVDCQkw
eGMwDQo+ID4+PiAgI2RlZmluZSAgRVNESENfVkVORE9SX1NQRUNfU0RJT19RVUlSSwkoMSA8PCAx
KQ0KPiA+Pj4gQEAgLTE0MDIsNiArMTQwNCwxNSBAQCBzdGF0aWMgdTMyIGVzZGhjX2NxaGNpX2ly
cShzdHJ1Y3Qgc2RoY2lfaG9zdA0KPiA+Pj4gKmhvc3QsIHUzMiBpbnRtYXNrKQ0KPiA+Pj4gIAly
ZXR1cm4gMDsNCj4gPj4+ICB9DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyB2b2lkIGVzZGhjX2h3X3Jl
c2V0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KSB7DQo+ID4+PiArCWVzZGhjX2NscnNldF9sZSho
b3N0LCBFU0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04sIDAsDQo+ID4+PiBFU0RIQ19TWVNfQ1RSTCk7
DQo+ID4+PiArCXVkZWxheSgxMCk7DQo+ID4+PiArCWVzZGhjX2NscnNldF9sZShob3N0LCBFU0RI
Q19TWVNfQ1RSTF9JUFBfUlNUX04sDQo+ID4+PiArCQkJRVNESENfU1lTX0NUUkxfSVBQX1JTVF9O
LA0KPiA+Pj4gRVNESENfU1lTX0NUUkwpOw0KPiA+Pj4gKwl1ZGVsYXkoMzAwKTsNCj4gPj4gUGxl
YXNlIGFkZCBhIGNvbW1lbnQgb24gd2h5IDEwdXMgb3IgMzAwdXM/IFRoaXMgaXMgYm9hcmQgcmVs
YXRlZCBvcg0KPiA+PiBzb2MgcmVsYXRlZCBvciBjYXJkIHJlbGF0ZWQ/DQo+ID4gQWdyZWUsIHBs
ZWFzZSBhZGQgY29tbWVudCBhbmQgZXhwbGFpbi4NCj4gDQo+IFRoZXkgd2VyZSBjb3BpZWQgZnJv
bSBkcml2ZXJzL21tYy9ob3N0L3N1bnhpLW1tYy5jLg0KPiANCj4gSSB3YXMgaG9waW5nIHNvbWVi
b2R5IGtub3dzIG9yIHJlY29nbmlzZXMgdGhlc2UgbWFnaWMgbnVtYmVycy4NCj4gVGhleSBhcmUg
aW50ZW5kZWQgdG8gYmUgZ2VuZXJpYyBhY3Jvc3MgYWxsIGVNTUMgKG5vdCBTb0MpLg0KDQpJIGNo
ZWNrIHRoZSBlTU1DIHNwZWMsIHJlZmVyIHRvIEpFREVDIFN0YW5kYXJkIE5vLiA4NC1CNTEsICA2
LjE1LjEwIEgvVyBSZXNldCBPcGVyYXRpb24sIG9uIHBhZ2UgMTU5DQpUaGUgbWluIHRpbWUgZm9y
IHJlc2V0IHNpZ25hbCBrZWVwIGxvdyBpcyAxdXMsIGFuZCB0aGVuIHRoZSBtaW4gdGltZSBmb3Ig
cmVzZXQga2VlcCBoaWdoIGlzIDIwMHVzLiBTbyB5b3VyIGNvbmZpZyBzaG91bGQgYmUgb2theSwg
YnV0IHBsZWFzZSBhZGQgY29tbWVuZCBmb3IgZWFjaCBkZWxheS4NCg0KSGVyZSBpcyB0aGUgZXhh
bXBsZToNCi8qIHRoZSBlTU1DIHNwZWMgcmVxdWlyZSBtaXggMXVzLCBoZXJlIGRlbGF5IDEwdXMg
Ki8NCnVkZWxheSgxMCk7DQouLi4NCi8qIHRoZSBlTU1DIHNwZWMgcmVxdWlyZSBtaXggMjAwdXMs
IGhlcmUgZGVsYXkgMzAwdXMgKi8NCnVkZWxheSgzMDApDQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8g
Q2hlbg0KDQo+IA0KPiANCj4gc2luY2VyZWx5DQo+IEpvc3VhIE1heWVyDQo+IA0KPiA+DQo+ID4g
UmVnYXJkcw0KPiA+IEhhaWJvIENoZW4NCj4gPj4gVGhhbmtzLA0KPiA+PiBQZW5nLg0KPiA+Pg0K
PiA+Pj4gK30NCj4gPj4+ICsNCj4gPj4+ICBzdGF0aWMgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9l
c2RoY19vcHMgPSB7DQo+ID4+PiAgCS5yZWFkX2wgPSBlc2RoY19yZWFkbF9sZSwNCj4gPj4+ICAJ
LnJlYWRfdyA9IGVzZGhjX3JlYWR3X2xlLA0KPiA+Pj4gQEAgLTE0MjAsNiArMTQzMSw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX2VzZGhjX29wcyA9IHsNCj4gPj4+ICAJLnJlc2V0
ID0gZXNkaGNfcmVzZXQsDQo+ID4+PiAgCS5pcnEgPSBlc2RoY19jcWhjaV9pcnEsDQo+ID4+PiAg
CS5kdW1wX3ZlbmRvcl9yZWdzID0gZXNkaGNfZHVtcF9kZWJ1Z19yZWdzLA0KPiA+Pj4gKwkuaHdf
cmVzZXQgPSBlc2RoY19od19yZXNldCwNCj4gPj4+ICB9Ow0KPiA+Pj4NCj4gPj4+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IHNkaGNpX3BsdGZtX2RhdGEgc2RoY2lfZXNkaGNfaW14X3BkYXRhID0gew0K
PiA+Pj4NCj4gPj4+IC0tLQ0KPiA+Pj4gYmFzZS1jb21taXQ6IDk4NTJkODVlYzlkNDkyZWJlZjU2
ZGM1ZjIyOTQxNmM5MjU3NThlZGMNCj4gPj4+IGNoYW5nZS1pZDogMjAyNDEwMjctaW14LWVtbWMt
cmVzZXQtNzEyN2QzMTExNzRjDQo+ID4+Pg0KPiA+Pj4gQmVzdCByZWdhcmRzLA0KPiA+Pj4gLS0N
Cj4gPj4+IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPiA+Pj4NCg==
