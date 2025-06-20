Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022091.outbound.protection.outlook.com [40.107.75.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFD235051;
	Fri, 20 Jun 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407592; cv=fail; b=kchIMZykc6cvy5aovgU9/qFsQhJET3z3klTiH6DHUg0+BNtiBNOzLSaKj6A/04GwN7r+RdxQum1D+r87+Vu7VGUWT6lO+wfp/+AtQaNGIApuUc8ffq4yVRRqPbboTYkVradCl+82TP5jArsleU3Co4n1TGDyDW1N0I+hocqvaro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407592; c=relaxed/simple;
	bh=RfknfB1HjpVxtQnip9970Y9L+qGRuAwZoXmXF/A0+sI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YTtN/kiuwrLucmubCE7Nq+P/eYvh0u56cAklnQdVfUUxkK9wzniWzKRZp805NvF20Rbl6b4EQ7lHImTIImAQtTYOZf/vr7nFa6er040YWsmCyD4iZZkoUsXpQmFGJP+dkniy5X6ur+EhGR0LvJPT5M+/96PngUYwLEJuKtiLG6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=cEC4GUjH; arc=fail smtp.client-ip=40.107.75.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="cEC4GUjH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cf6fizOHfa8eWkHLo2sUJVxPBNCXqwkFd6xSpqZaU/GTnQRKOsem9CJp8ETjhlbWzYhFft72zKpOw/QhEMhuK86Bz/kk6DP6/ME3Td7qNkQ/Ds+1ENtVX6iHaGG7lmEoaLX9G7EG0ILzfh6DPrLE25O39DP5u/VogOjhp/A/hhK4NGPbaPxTOyeB4/hAwKOIcdbVfa7qXqzRnkPfvwG0oo3kwq7g+1ziDRgatFr12nYFu9yHrvMac41krjaujfm3MjZJhn/7OjZJofHUZ3O/KoFnUAA704Z7LIjmFDrAaD5mgHLq/lNZh3poR0Mf14c1XpZTckbHrOWk414TfCIvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfknfB1HjpVxtQnip9970Y9L+qGRuAwZoXmXF/A0+sI=;
 b=HxufB7ajaIYyCrVLTxWoWzGGZsyggPKRej/wxBmKsFWmjCXWukfvWYnpkog3ZH/WnSvsovWzTs2lszAyzpNuorEoblmNCJAICgyMc12MlTREqMzFxUvyID6VkHfF7tI8uNjBTOvVTaGHdb/rn0pNr218Onu70zQC89Ld6Yelch4QNc6uM36NLMhXUBCGpKoLDaQzRlV6t56JnD1NOzeTvJ6gNxoumbAEj8Wx9SBzD3SUdALxps6YYEmjVs7ARTwRTztlB1Z+gbV7iNqr/HWe4yHm0K0TApeBb5/bp/9dVaUZHt/v+8k7Z23U56E1T3zyb8AxWfBFJVh9a7o7KB6V+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfknfB1HjpVxtQnip9970Y9L+qGRuAwZoXmXF/A0+sI=;
 b=cEC4GUjHUf9dcrzgdXMSRNJiDU/XPHA03+6L6HAA9H+1LD97YIYi6HJdOaEtHJOWx4qhRYpy+W3BuN/AzsMRU3SDUXJPcMyEMa3McjX+UA3fVToCrLcOiTPhONaN5FoC6woNCbpHzkxbUh8nxGTCs40NvgHyxK8sNfBtJBAtHyiOD4YI5cOyZCh52rghE5Pj+osSrjDMuMtvu1EfHHl6K1C7gAl+wnK6JEJBEEDSXopRQfkZckmV4OtxpGTnlrXJsEaTtA0fTsc1/7A4wgix4/KuKM6//k0a161auQhh9JOFiGEtNbFqIb3xiHF9++O5abtE8pvQc3z51mtP5qOJDw==
Received: from SEYPR06MB7072.apcprd06.prod.outlook.com (2603:1096:101:1db::9)
 by SE2PPFDAB6F0437.apcprd06.prod.outlook.com (2603:1096:108:1::7ef) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 20 Jun
 2025 08:19:27 +0000
Received: from SEYPR06MB7072.apcprd06.prod.outlook.com
 ([fe80::427f:4d26:e479:7659]) by SEYPR06MB7072.apcprd06.prod.outlook.com
 ([fe80::427f:4d26:e479:7659%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 08:19:27 +0000
From: Cool Lee <cool_lee@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/8] mmc: sdhci-of-aspeed: Add output timing phase tuning
Thread-Topic: [PATCH 6/8] mmc: sdhci-of-aspeed: Add output timing phase tuning
Thread-Index: AQHb3/v0jr6XuJF9oEayJUI4Q+sIfbQLoanQ
Date: Fri, 20 Jun 2025 08:19:27 +0000
Message-ID:
 <SEYPR06MB707217BDAD59EC2479384847957CA@SEYPR06MB7072.apcprd06.prod.outlook.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-7-cool_lee@aspeedtech.com>
 <eaba29c18db8883f88e5e105f905a735a0087a3d.camel@codeconstruct.com.au>
In-Reply-To:
 <eaba29c18db8883f88e5e105f905a735a0087a3d.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB7072:EE_|SE2PPFDAB6F0437:EE_
x-ms-office365-filtering-correlation-id: 75d93544-7995-4d1b-71c0-08ddafd32c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Sbu2Q8BhMoMZtBrlBKJmAadjevXO4ys7mA46yOy4d6y4sB5qavcV2fAEHJt4?=
 =?us-ascii?Q?AdNqACZdnI0MGRLnAnRit5YlhJWbb7J29keg5+Hq+8W/l3eWXIVKVBfUsn1s?=
 =?us-ascii?Q?8N8ejDLsESK9HUC0gHA1KHcC7WiV7tBlfGwyFuzEC57ZMfUKs/shAxv+m9Cr?=
 =?us-ascii?Q?gf/3s4KNeuZOnc1uIIOgARd1/tQF5t0P5dja+4Qy21Z7FPiImew3UHB+nDQQ?=
 =?us-ascii?Q?nXp3tjK8wGKQ/9YTd7zDI8ROLddWBwGbTJAJFHMfHKPIDVal8lee3AfRkybJ?=
 =?us-ascii?Q?OLX8U5CzkiY+zhxK8EQvC2XX7Xn1iTDoTjqZ/ZEEUgoE9j9omrHCjYx+h22h?=
 =?us-ascii?Q?NOjLuLszB85NoTm+X/L7IXVU1eWvKeV6AlscoaqvqAh5QNzbQ0P9tBDKpkAN?=
 =?us-ascii?Q?IKWNnXTfgzu3Bt8ASqvOH1LfLJoFf/W3scbYpTSc0yTUkqsrX/NVXwXeuLdi?=
 =?us-ascii?Q?4pJmh2HaZz3k7kVz7WwCyfv2Yim56QH3/2M42Qge1sov+GvibjOjhcbg1ioh?=
 =?us-ascii?Q?cP2OpTdojG4VIrba27h8SJxmJODLbW2Q6N0UX4tQVZ5CsPAEuGPRjKWtw8qM?=
 =?us-ascii?Q?65tllPKUHI2KUZxV5b+SNpwQP9IbmVdrFAt8VDYCw2+dzqPkTS0Rmv2wFxQ7?=
 =?us-ascii?Q?vnIhJBN9eaQrObQeglw9xMM7CutH7PYhU8eqzf/IVsQqed7X+cmtrtkkqI7S?=
 =?us-ascii?Q?tP4/DC6vTIyTUJGH6lgk+Xg3+Z8STqPya0hfFLqg6McNfx01IsUcWPxXFAIn?=
 =?us-ascii?Q?kaMDyT89Cea+fI4T6jw5g1xTkHrHwsLcRQXv6hQTBhCR0utTX87d36+7jZmN?=
 =?us-ascii?Q?qGB3G5jWYG6kkxha44qgH7jvdZc+zP3G1SYG7iim9X7DkLMrBFSZ2KBPXoSv?=
 =?us-ascii?Q?zHlKbaxjy6TO+ubKrx0L3DLBhvk41XV10egU2vI7fWLg9L5iAoMey/XwmffL?=
 =?us-ascii?Q?cE2ZkbbfSIZd4i2vp3efCsnLyfhlvHZYyD2DKTVJv6n7V2MD64cmFPqiDgjJ?=
 =?us-ascii?Q?zEB0PwKIpd4Hx7jNaxvkocsIw5S7ZQcw/SNPHHf+pyMmUAep0Mg1HLtouILn?=
 =?us-ascii?Q?66Tlrnx0tCucYRgOyNjNnO9i0sVG5/4sGeJ5zZWMZiIIDLoDW4z3Y67VAUB3?=
 =?us-ascii?Q?Ncup39N4wwkThW9caSOvUam9PTPAnlqDuo20QQGjTogBTpFFMGHH+8ADLUO7?=
 =?us-ascii?Q?DNg7vjmPMKmFS8rUSFdG5h/Il7JYbD36NzVcqlzzVV26TNhwdH3HUmZHDjeK?=
 =?us-ascii?Q?6UqhNj5RPqrTADvfBmmWP9btj3sw49EfZan76VHh2D1CQQZQkcMuf57urGhx?=
 =?us-ascii?Q?XSi8gWnivfKiGjHbzOLJdA22P8HvWbyd/6auRq1VNS7hLPFaq7D6/1LPYS1K?=
 =?us-ascii?Q?CLKr78TBtltc008sUfKhc1EINjswmZVYwp4UlBzMZpbG6eWT/xcJfe4kBTyu?=
 =?us-ascii?Q?5y63kvk38pl38nN8jFrMRV7vlEc4V0gGk63oR6JatzyRlSTPf3Be9xsost6L?=
 =?us-ascii?Q?va0GtfaYQA98+Q8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB7072.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2VMZ6mZXTTz1ESqbYP9+tKQ23w2T2X4Os/ZLDi9eNEFWbr2/PDZBdsUoQDRG?=
 =?us-ascii?Q?NciAx0kWjbhAL6BtiSGsdqTUNrKzRb7hTn2vDhIZcrG+AaDJ1yCbId7Ghqt1?=
 =?us-ascii?Q?umPOfJPPJ75S+bhuf6R5+3ALfl4dwV0gA0eOKM0/Hq4fPiFJwH8YHVZWOQh/?=
 =?us-ascii?Q?GEAY9OCN+UZ+wDSBHtlpl88ir0rqSwJ/207oR2wVoa6tY17/P+u9EoC0i1t2?=
 =?us-ascii?Q?4n8uvNCAmXN6HNYkuUU5Kro6XeAsSYWEuTl91NssaBMh0vgQvgQ09B6dF8oI?=
 =?us-ascii?Q?BuSnWO3MiFajQkdzSnVnu+sTMkfF0490bRdpjt57MQKLGg6PX1hOXFldiUny?=
 =?us-ascii?Q?JNJa1D6jHeSzQWtJCIjUvudZ9sxbJunOdgoYC5sfG/MDbNRNNLjtMDtkY3+O?=
 =?us-ascii?Q?MVS2s6eYjLEIpXzvgU44s4WFIEXOCUJw8FgolSiirEfDChimITNc5xquhXEU?=
 =?us-ascii?Q?w36OpGX+ZAv1OilD+Ce4PotTholg9hkO1+sfCoSqbRzeaVk+YeOUvmxdmw/q?=
 =?us-ascii?Q?j0t/qX8NZJDCHA/EoALWC4tvRxIkjrOzksrjElWn5kTbQXSXo77PsSF7AWFm?=
 =?us-ascii?Q?9WiG1duTnmib69MUDlNaIhpIXeQZiYMgKYRA/GNxU2RTSchIentBP4PiBFxs?=
 =?us-ascii?Q?RW7Y1qxN66YatDd1gFML9aH9IcqAJ0Y4cSK3S0IrHvNdTgmwxzyN6cJyECtf?=
 =?us-ascii?Q?RkoR2xQf8YVwTJiP9xzyLBGS6fbF2WtyBUJiYIEDawybmYf+GjDDgoRhMkob?=
 =?us-ascii?Q?Gwxf/F3wPp7jsY4mHDjQzigkHh6uq4Hj1Ld0lZ36YC/idBwxfjXbymVQ1HUi?=
 =?us-ascii?Q?0z6Pnn+PNgydpsVYCDfZLbb/5i9fr9O5nt7dtdZiBfx/w4VJurn6eHH/x2O2?=
 =?us-ascii?Q?H2OuTVPJInA78cnnWG0v2vIsLK/QHHQvhQ7MRRuOoiIad8vGj8VCGT506jaX?=
 =?us-ascii?Q?f8JdkGVVYmvH1MkWg5c0qqvfLkHgDE7GGwH8BKy2QHg+tbrbIO/DXKzCeg2/?=
 =?us-ascii?Q?lSd3WxuHERJh2ONpZ1aDsZGPYieJrwGBJ2YiGrhVZSpBD3nnI5XxXlFBjfsf?=
 =?us-ascii?Q?Ko5zDu2seVoIzTUWaKj5Z+M+TJ9cWGrSjF34YVFwM5lcE7qksRRdlvm9xLa7?=
 =?us-ascii?Q?dNZ7AVGTo0ReyBx1gTyEa0TSwnv3MsKTdH10zg/PgY60uyqRwLWAeFyY232+?=
 =?us-ascii?Q?ren/fEpTOGNzxRGqYN7CC6iMSpRg+sjoYIiuPu8yJiqF7IGb9aNX9/yRX74x?=
 =?us-ascii?Q?3+sBHHaqxNLqf8vu8nSyG8rbUNrXw9U6gWwQFPAXAA7ZToNk5+bt1Mfvh/Uz?=
 =?us-ascii?Q?XUTWaTP1hTXC8PlC2y+m8+b0F9dcebMc0Qlyf4BPxlcLERFCXsoEBfi/Tt5h?=
 =?us-ascii?Q?mQPqrGcwThNIDXZh/ZyrYKdb3ELwY33iCsoOYudjwHcigqK8pljG/dq6qU3G?=
 =?us-ascii?Q?9FSDLWsp5aMC/Rp1aNY/bDyHKiUTbmbnZ3BfUr97gzt/4988LV+/rqJg+e/s?=
 =?us-ascii?Q?sy1tkhr/6ycbPmkNXkY5K5j/i4dkof857J4SgJbuBHSnrmo8HxNHrWg2Rr29?=
 =?us-ascii?Q?GaTF/7CSnW9mYPm9926Rk6ww6Fh/7OeN3apGEwp1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB7072.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d93544-7995-4d1b-71c0-08ddafd32c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 08:19:27.6158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xo032keHU57lffq4WXS7Mn3DJ4zMO7d72nXnSN70zLDGS4iPhsS6/fAUWJFcQosQLY5aSEgH/kxSAq1d6WVSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFDAB6F0437

> > Enhance auto tuning with input and output calibration.
> >
>=20
> Might be best to squash this into the patch with input phase tuning?
> Why split it?
Ok, I will do that. Just like to make the commit smaller.

>=20
> Andrew

