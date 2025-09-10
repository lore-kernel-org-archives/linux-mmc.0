Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6ABE49
	for <linux-mmc@vger.kernel.org>; Wed, 10 Sep 2025 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482980; cv=fail; b=l4OodkZXSGu7klp5Dt0Ht0OgVKOzGS8wQ6Ksx3KeyD/RsXl2Q/kh3Gl23rFsLCeNoHKCOkESjE8+fbYDpfizIP7XHR4mKy+AOnGAdQ9OcH7TV9+WY4zGt8/gHN74WgWLFI5lNJeekRWYRSxrr0wWO9dAxWRszfB5VhShwWx9uhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482980; c=relaxed/simple;
	bh=v7WAEt0KIincs1YaGGReQK7vto/trVhkaHXr6Te0FhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ri2MA/ysebseQAUQabibtW0RSTxHhlla31Ye/M3U1XHgBq9EfUhTdbFXRIhqJ16eyXSLPiyRWooYvRUwxP4jQDZJcVw/MsZAmbNPOFEMZDJlrrBQ6rk5oY4C5il9OOaxezeCS3hEsIBFr3yGMnyvxGuCnLe2vJSiBxF0nRglue0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=AN/PbABq; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="AN/PbABq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1757482978; x=1789018978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v7WAEt0KIincs1YaGGReQK7vto/trVhkaHXr6Te0FhQ=;
  b=AN/PbABqMnWQO9XYc68Dmq4eXNNKrZV5wuFfSWfXGrcs871qM1+kELMy
   NCqJptDThIW9c309TC+vEB1zM866viIP8uvGRZaGVXCGPHIc6dAH+3KZu
   30Pu7NseRFsGdIq8xzMj+Nfjh0WT/+eFhAn13E9YZf66au8dL/Y37BNpL
   P6i3d5XKu5FOjRXRyvBHm6QjHhZlad0FfZkwCsg+MhuqZ8oYA/L4/I0bK
   PZXDTUqF0gvUYTcgXMgd+p+plfIYQdTCSjjj2koLjSsjFP3ZmTzDX30R6
   kiDuK1d5lS6h18QadFoxGrtoBVY/VfcxSKHv4Z+eonV1VD3nBsXYIcAhq
   Q==;
X-CSE-ConnectionGUID: HkIomUhcTaKzVH+PSlpviA==
X-CSE-MsgGUID: 7hr55XCaRTWkNMGmEbzOZQ==
Received: from mail-mw2nam10on2095.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.95])
  by ob1.hc6817-7.iphmx.com with ESMTP; 09 Sep 2025 22:42:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYRdpz1GadjyQcpiZg2ZkweUJvg8tT47NZr/gLVdkrKerwrZPvpXyEFMDDHlg4JMKzADEM7xZ2WyDciBmCvfGoG7kypu5GHvGJQ/d+q7GXjSedwMB/zHhV8HGvdMjsFNTmSqo/Kuazu7ZGicLK7/fjzDkBjUtWUgTBRGVFcyC8PhSGHRe1TtEapQOSWJ47cv39ggx2dwNRWxYJIju7cMoCU4vsTM3CSNgBtchkMOjIHzLwN+ey3fTU4PN62M5OYDB/M9r/j0XPGwUM+ciI95HxkwWQvPEItAl3rcm4QXRkcFiGP5Hn3nctE7rxJqcpNVmp5valjSLK1C3H/w+j7W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfDkBsBb8ybR2Uc8HctNOkDTuloPDgLEBqvs6YazwEs=;
 b=Xp5bcALfAi43+vwL5AsgmI/SkgGcGf5CrNRlQYEMCt1DVkITUeQUi11TtCBgzT8jR0WUUy03FQuAO+SedsKuvkMewfUot9FurzcERf57J3K7eOUSLkenYK08nqtZO5v/qIEsPZkRx8TckR+AC4HuKwhFQ9zmWHNK/AwFPQEZtoqVdTT2I67QHFVgV/3YfJJ+4UCozDbpTn/XEGbD31rxIpuGxZ6P1DjzdjJuehDLT28NBNswi3GmNon6xLqQC21swXFUUH2wMJw7b3/bw7QMxvhGrnJdSg5rdGAt1JHfmMOIkOG0w/gHsB4sL4vFhQTtSKOC5WqLpm0t2sG/ZQfvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by LV3PR16MB5857.namprd16.prod.outlook.com (2603:10b6:408:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:42:50 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 05:42:50 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "jens.wiklander@linaro.org"
	<jens.wiklander@linaro.org>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v1 1/2] mmc: core: Fix variable shadowing in
 mmc_route_rpmb_frames()
Thread-Topic: [PATCH v1 1/2] mmc: core: Fix variable shadowing in
 mmc_route_rpmb_frames()
Thread-Index: AQHcIc8OUDXZCm/6iE22Rfl8D8A69LSL533Q
Date: Wed, 10 Sep 2025 05:42:50 +0000
Message-ID:
 <PH7PR16MB6196EBBBDAAF16EB09095E8EE50EA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250909211316.1857198-1-beanhuo@iokpp.de>
 <20250909211316.1857198-2-beanhuo@iokpp.de>
In-Reply-To: <20250909211316.1857198-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|LV3PR16MB5857:EE_
x-ms-office365-filtering-correlation-id: a49640f2-909e-413d-df67-08ddf02ce126
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/MN6VyzqitOpDuzPjg7orZpvQg/XhwaD1ozmsPYpuldo2brcxqVMcaK7Ya2j?=
 =?us-ascii?Q?H5IHnkcRrVxI0GNv0Q3lQ+uFBXrcRCLsslY7Ph01zg1bl694tVYq+i/25dwH?=
 =?us-ascii?Q?qnmXxRKah5A6EsPGr3Uw37W11grlm7U0zFwyy5mBDWSUujwb9jKke04NUpKy?=
 =?us-ascii?Q?ztw/y+cnhlv/1boASbiSCHoWCZQfP+yyH+hflA4BGK4O3w5z4zIocRhw1bhK?=
 =?us-ascii?Q?A6cNAqyw/uJpzEDZ2vDiQojmg0NwEtV8xFAHQYylfX4grfLAgAcqqzKpOQuJ?=
 =?us-ascii?Q?8U5GzC4nSS4u7MZ2IIvCisCJIDtlOOD5fShMEhB6c04PnFlSmXm/uyLrY4rs?=
 =?us-ascii?Q?DNtKunpPeOUCTzgYqDXk69pWF0Dim4fuMFQitI6Ygm2KAn1z7L84/hWMr6oI?=
 =?us-ascii?Q?0J6lwlWnLQ7PY6uW65opKG+2j/1X2gz0eE5qWBiX805TopDrBHz9GmabrzCc?=
 =?us-ascii?Q?8GFrCgzz5pPrCbWYMa6WlqcnAsXgPhHoroMlCfFMUNSfl7u7ynU+CAvN0f+C?=
 =?us-ascii?Q?KY/+ovj+Q9C2SuzK/IS47CN/s5j0tsEyhoMbtu32T469Ic4nuGur9lAMcbl+?=
 =?us-ascii?Q?p9jcTK/GbdYYqVwhSjJCWcdYedGGdn7WI6+tx+p5GweRW4WjZ1SqHQLDmZ1u?=
 =?us-ascii?Q?m9eOsRJUPOaG2C1cyCebm4LYaNl2L4sgFDiMJ4deVxJnwfF1zgLVsXKruPx3?=
 =?us-ascii?Q?U+DM6Q3VbLleZer90iM0f6ZoTiBwY0GXqmgrR9fKkpNiYtYIA5dOndsyhuzt?=
 =?us-ascii?Q?NQknVRr19/iHVGXI9FqBuV2P/wjFzqr+VSHuIdVUY9dNEmvhteqOuWrBy2rh?=
 =?us-ascii?Q?QogPxgToLYdGrg9+caBWJ1R/hdbtK8h/FP4ZiMAJZdixoYM+eSHxN+FArOFn?=
 =?us-ascii?Q?mQVBkrtMrSkws2LneaPfqIVGYPlReVD0n2ykVaZX3B5EVN7M7m+PWqeyJh/6?=
 =?us-ascii?Q?8UEiL/eTfQVxHauaQlIb/POaA++YRavHcBSSXlMtgMqQ8/menhNC8G2+Mriz?=
 =?us-ascii?Q?F7toIMoKqq1JbDH/MXqKOCch6C8Xi1YK3bFVHMj4KC3AwBZcSKrMbaWv6pDl?=
 =?us-ascii?Q?th1wTHK/5q+ZD72iKzoLERCU4V3j1rXiGF7bHvZ356TCJuCFCmuYtz7NlE3h?=
 =?us-ascii?Q?d7TsGUKgzeqzBf75loufH1FokGLTo/YyFyGYgar+244IxRkyHx34H+aM949s?=
 =?us-ascii?Q?e7OaMev9x1ene7OBu4drfxyCpB8ySyGVGvNuUiuQ3EgtNBm8q/bcDG2G+BWF?=
 =?us-ascii?Q?IKN9loyFgv2fxeMrXg4syzwI70WS9gKjIHT6yZY8R5JEPhaPEfHfUyd7MwXE?=
 =?us-ascii?Q?KdC0HeGieXAYuGC0g7GczLFdfV9QmaYMFo2B+kAYaJ+feqKrgg6wGvmCVdXo?=
 =?us-ascii?Q?DyLHHh0UvEQdMP67I2LQ7E4kABmxrFp2jfbel5GSTkKSWahvHSG+jUAU3lQ4?=
 =?us-ascii?Q?RzMXT2iqNLE4MiqzflJWwRZ5beAtSRQpa+nCsIZvy/4bRWq0gnTXl/q1IrLh?=
 =?us-ascii?Q?AOnNUq1LA9cILng=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9Qvb6OpMKMPrZahl1eegCwAWXLOrLhYc4bcSe6aUEn/nuOXIA2jjxpuI2FMf?=
 =?us-ascii?Q?bt4D5GDXNxb0MpXZ6D7ZZQQzSHtqEvrD/MI4O6IYDwVD2yXSyWNs/Gtn7ukb?=
 =?us-ascii?Q?90kXuO8JrmiCak2ClN2XMoG+u8SlnBMeoJaAdCC9DlSJ3PjlblTxcjPYJrFt?=
 =?us-ascii?Q?UNjWSk88UFh3BCJBvLFj9lJDz9RiN+8Kcjhp1bDsZK6GbsGcIMQV0MBMAUX2?=
 =?us-ascii?Q?gOKCWKv6QXZfSoHPiSxKk4XuI6sAh9OgpWm0ktyPNT6gpaHtUQynUpVDkv+W?=
 =?us-ascii?Q?SJ1totTLNuTdFGLm6IZxqhswZ9lgDm9MxWDIBt5g8KmiCFJstMaDKBtZujsr?=
 =?us-ascii?Q?IsEDL1FDfdCKXL7xGqVGMCDqUYGm0E6D3771trKHvfg9BveRCFmsY8Mq/0zN?=
 =?us-ascii?Q?HbzPm8zUfdzHOnga9pAJ0zpxSUg55z0lqPhza3y87bAmUMZEeznI0VkTkcJl?=
 =?us-ascii?Q?ftmfevg9Z50Z0toBYV4BeCyf8pRKOrtWSfhnhICTI2UR0ivgYYzmJC12FT1p?=
 =?us-ascii?Q?5JhtIiTyG3NZy6UqePnbhdpmXS6MAHz5s2LaNMQ//P0k57OYxdvY/09TcRQ7?=
 =?us-ascii?Q?88v5zZ+6y5GdUG96uKrydTFcjKnb23DKTi45WnyYXcXO7bHW19HzGp5fHShH?=
 =?us-ascii?Q?lVvM5kKahV/aP4L8kGkTFrvqQ6X6eKXvXJNaUK1+CqXScHU/9/l1UmvcjyT5?=
 =?us-ascii?Q?TVcaEvrrVmWYOgZKDBAFnx4xq3Y88vN2NNChxPJvSxhAyAFPUYL/4JclPXSu?=
 =?us-ascii?Q?iV/XMZ7z0u2QvJy/VVcz1j3QA6HWN3EtV/uzClKul2P3NQCzZW4lRlKzUKat?=
 =?us-ascii?Q?F2q/RzHD6uYc18o4RMrrhqi1a7sM0ruf2p7x776XweBM0ZphWBayYmXVlSmf?=
 =?us-ascii?Q?ORykrdZjmG8xWoOo4uzBdvCI9bRZkVuQFDjKXggOvvJXN9f+ZkFSvfraldT0?=
 =?us-ascii?Q?ctHINRIv4fNb+vit0R/tVhZ2wkpsIOhMfir030UYJfXrmwYkyOU5HlUamruM?=
 =?us-ascii?Q?98bWYvHoUNQxBQdG2D9ShNQlGfCSwuc5EzxD7khW1pqA/oRqCAF5gevT7KC5?=
 =?us-ascii?Q?2IymrIRrg9OjIQJUEqIW1EIVBPNP0P8D0YffMV4VjDMX02uWQr+2/reMcXsY?=
 =?us-ascii?Q?ibbc5cbXRihnn4IKaJ+VgGyQz2fpPLl4+VQMRFwAOctZeYarqWEwquo1sjrR?=
 =?us-ascii?Q?YgLWtemYiUw0bc8aGqLa66t0WOSfY6oloApKZwF+R9hIZNxozYKDebnSi/Fw?=
 =?us-ascii?Q?WXlKi6p0ux3D8LL8Nqb7X3W4elz4lnLvb/J2XxqSwJSHJiX4bWt7drzpwpyK?=
 =?us-ascii?Q?/bh5H+XOAMXTRrMmGm37bxhez1gv7sohkgvBheeza3LJcI5IWSvJclzME/sY?=
 =?us-ascii?Q?r5p8V9wjlzQKiHsNx0KTNwpXG6hAE1Ym5KeIfcqAqUVoJNRg2D8r2DH7f1ky?=
 =?us-ascii?Q?jF/4/QLoGg5rqf+BoKxtGf5802XcbOhHETqa/4mMluxQxWzeDYLog2YgHQzD?=
 =?us-ascii?Q?+hWooP6aBaD46EAPNyUEVtV2q64DjY1DzzHbJBLEs7eBj0Svy7VXgIpR2qHF?=
 =?us-ascii?Q?KEX/xtVW7Rc14lFyPMFoBwY9Q/sMsIiVGL1V/HLO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VvULjt5bUwOlDsJGGvqAPhXUndbaGdHeJMSlSDzFAdn/JedqSqlDWA7TV2a1iPhqdUwhYq9sqybBj7H+N+g1LkFPGSx3lTNpaU66dQmnIM24A/5tgoJ9AkHxfux5Ol2yjh83LoJexdvO/1Ck8Wqi6T5DEN3Cx+iY/x09FPYnV164MRxnPsrx5HahABF0dF+ibtHbH2dTsiLYSnTd6DFS9QztW9BJPr/ZwRccYq3hYaNvF/MDOAJE1NBRvWrD+33eizJ2xMXy1TD9y71OKhMZFVdTHKJavxexn4kSRWzcnA+SRQkxtd0Ojv5mP2uitvCCwEEC5BRisV+pwbJ8VHUmVEcttN73nt/nxOJKdnXo2CU+wfkuhFwwVi8YqqnxKqUYRRNoQbvLg7NuZGh5DXnt6H7y1nOWtEPoS4Wc4157gIsLQZsEZseopz22iS7t0gTa7cX+LyYAjh+thDg4NPLR4OsAQIvPb++V58/dxeQkTYu+UpetGB1ejDayq7XJCcdYgkfo2IUuF9cAZyEgmD8Kh5bJv853J1dzelxJA2MqZQDZcKqkj+2bpF5/SD8SbMtMZ9ADBaftJi+s5BUJPphNxnu0o6xvYy/YlvsG7eE39brG+I2md3d9IOUEuKC9UaWkfe23Bc3SRrswfoVGof0vew==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49640f2-909e-413d-df67-08ddf02ce126
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 05:42:50.2936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fl/B3q3tFReNP0K8sGd220/cAPfyRweJz4N0pHy03G2Io10j4ia8fQSn7l1IVuB9oDoCMhfkWxb+XnGm1IHiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR16MB5857

>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> Rename the inner 'frm' variable to 'resp_frm' in the write path of
> mmc_route_rpmb_frames() to avoid shadowing the outer 'frm' variable.
>=20
> The function declares 'frm' at function scope pointing to the request fra=
me,
> but then redeclares another 'frm' variable inside the write block pointin=
g to
> the response frame. This shadowing makes the code confusing and error-
> prone.
>=20
> Using 'resp_frm' for the response frame makes the distinction clear and
> improves code readability.

Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB sub=
system")
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>


> ---
>  drivers/mmc/core/block.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 9cc47bf94804..dd6cffc0df72 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2936,15 +2936,15 @@ static int mmc_route_rpmb_frames(struct device
> *dev, u8 *req,
>                 return -ENOMEM;
>=20
>         if (write) {
> -               struct rpmb_frame *frm =3D (struct rpmb_frame *)resp;
> +               struct rpmb_frame *resp_frm =3D (struct rpmb_frame *)resp=
;
>=20
>                 /* Send write request frame(s) */
>                 set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
>                           1 | MMC_CMD23_ARG_REL_WR, req, req_len);
>=20
>                 /* Send result request frame */
> -               memset(frm, 0, sizeof(*frm));
> -               frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
> +               memset(resp_frm, 0, sizeof(*resp_frm));
> +               resp_frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
>                 set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
>                           resp_len);
>=20
> --
> 2.34.1
>=20

