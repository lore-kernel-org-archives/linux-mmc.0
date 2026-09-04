Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010055.outbound.protection.outlook.com [52.101.228.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24984908D2;
	Fri,  4 Sep 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526015; cv=fail; b=LJYwlJYUf8AWomUPeZ/MydaoxtSdeWz7Wl/IcLcbk61gmC8D0S10xNnOLfN1+vhak+wSbTzOm0yfQdBVmGwl3g0QZuAT/BSEjc0VUnT/tdspe5NjlN5Swd1OUgrW7JjkJKPsS+RegwfE0plp/X85NuFt2fZqxl+VGslNuPgyQDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526015; c=relaxed/simple;
	bh=vuyti3sAS9pgWfMQUkjUfymY7Wnq28dtZBBalu+dfHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpdKWH0Z4j4y/FcuPqaYkTB5yE4oJtA/B92uwKMnD6xriNm9iD/7hNn54EvOgCRElbUpEw6tNbmxqrp2rm0Vm8KLvbSOvucQoBu9l0bp0r0kqEl69isPOnJXNvgPVnixqdLPSnWJ2c5PxkF+LM8nyAvBkljDQ+uaW6w7WbNzuks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=KFRfMxXu; arc=fail smtp.client-ip=52.101.228.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KFRfMxXu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nimzsfsetej4EpM+HtBDM0UQ4KI/d/ig0/kJTvZR713GiBoJKWQ3Gc3X1CTW+gJhFiV9ilmOnWnMKJyjbo4uIwBEfcSWo+JPSrtg7ljQZJjdhQt5RrAE6sC0igc87jW7LDrTJFpMSPJdmGioZ9oXBTOP8uPEQlQp0ADI70P1KU304RBJEMqgZNol2KUwdF8O9FrBZqMBVPPf1SZ0p6K5iLp3zS6C3xHWOMIFidA1xfcYav/MHcUQ+QHUn2XGUpEV6v86GFmrVx/vAYRtI0/qEzVclmBd0HViZAUZ0s0Zs9dhSxEEvZtvDq6A6UUWeaXdbJVKc6M5iuOj/nhuww0ydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/UZqRYDei9pwENx0x1YfP3vDm43oJH2nvdLMgzZEXA=;
 b=cHNTL8H1GOe9cUMOW/BwGthW+aALr3h5e9ms+qMkFGikYbTo3NN8h9yF51iKpssleZzZlAcHH+A8wNTt/vUnGqsWyoSvhRVH6jhqtAcVFeP8A2aCwIkcwQ6nhdnk/innkNych8YZwuJdvD+GRltORFaQk2kD5MW0fPLPkXU8R9C70bAaeaPMPrwjcmuqoqRDhwGE2DQ3XQUHW0DgVpkRPDQ+NFdkPWeIadX1nAtA0iScadMD9GeliDBoOfYj/LuV51YCqbteLq2FcThmEHd/EzThfyYxur6mPfR/M71ac68r3JCr46VegmYoXtjGliuFbUOOxrlZadhK/o7FoE0SVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/UZqRYDei9pwENx0x1YfP3vDm43oJH2nvdLMgzZEXA=;
 b=KFRfMxXukM8nLswrqB4cEb6FNI+bWLgTNtwZ1oeZsTtMR2vQZh0fdKk1Svg2Qx5f33dZxQfht/cAL08dBc8TyUieDJ3QTtAYH/TnfHWuzGDC+AU+vYo+ht+SZtz0qXhSblY9Aq44akUUWolEIo/UAqyXbmf1HFisym7x8E1THQY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB12011.jpnprd01.prod.outlook.com (2603:1096:604:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:46:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 12:46:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 04/15] mmc: renesas_sdhi: Add max_divider field to
 support SoC-specific clock ranges
Thread-Topic: [PATCH v24 04/15] mmc: renesas_sdhi: Add max_divider field to
 support SoC-specific clock ranges
Thread-Index: AQHdMMe7RxxJrlR3AEiECnq/qqkha7a7NF8AgAM8VaA=
Date: Fri, 4 Sep 2026 12:46:47 +0000
Message-ID:
 <TY3PR01MB11346696A5DF407A8E25150F186B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-5-biju.das.jz@bp.renesas.com>
 <apgC-m7SrDNU9YmQ@shikoro>
In-Reply-To: <apgC-m7SrDNU9YmQ@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB12011:EE_
x-ms-office365-filtering-correlation-id: 374da713-c4ea-4a32-ac29-08df0a829537
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|22082099003|18002099003|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 1fOqU3UEVu21UgBDg1vLkNmGBs+9n+lXY6b1pYUJu3IerVAcz+kQ9vQRMoYA8UDhp6poSNu3YwAyeADKXTEmoXkEeQ3i/zeSQZ/wIdee4ZEz6UhYMgqYE8XUs9pH/g26xnk7bo0onvrDiRB4+h4+ZUCDtIMMTTZd1i+3gwPsJXktzm3jvA7DUe0Cz8POPaecoX9/TaCr4wjA2YsnG9GszrXnPBrthbbTeUTMovzBl7klvdKfmNd6cZOxUG4AaKk0QifY/Qvsfe/YwcMp919X64Q1jx3rBqVBYP5cSgNa2WLUHOS2zn3bWtTzVU1wgahrciBwQIaE/M9B+YSFWh8Xd6rS3XhOIEk4Yak6lwuf47UaYAEcr3x5+e6QXxjDYyl0Y8jP355eXYLJr0IdpNzvkGOxW8XPe8SxlQH0IrP92BQnKt77pZ9WT41Mr1+WL2Ma6EfWfYSK1cgYed9SoSSdolyWIxAiz9j0rcuzJSSdxARCN0q0e2YbEUhGahNP68YpZ/kyYevYgkTXJ5iMq8jW9qqV/zc0+xgd6YsX4ZAKotHPOUM97G4Gk+iuh319ygfsvomQ7Ds5NBC2qaTvIJXr6CNvyiZFpJ0lgwMVfWmTbX5dXQQWAVRpNswF5gVv9+3wCjs821cytLI10QyVydbEfx1hfw+YrvRkfag7qLuevMVhAv3tIl4Ie5rxjXEkzWmF1CWttAfNu8c+ikemQbckSm0CuNNDKmFlQuYUgpPYzCM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PIlKvdBsbpaeVCHc6cPQnwWEr04mMgwSN9SWspnbIyzXhOjs0IzAxZgoogM8?=
 =?us-ascii?Q?KyOmmJ0GvsAICzKDBfwlJxrGiqbS8jLLI6HAY3cNzuav41U5e+X7wJGwifZX?=
 =?us-ascii?Q?5FeSE3VfoGBo2EiatbbrSQGAbFU/CElPAtL5pPC6AyRBuaO8YenK877/5Or1?=
 =?us-ascii?Q?9uq4jB2WvySH6p8J/H6OyCNZvhL9J35IrNCkxcJE1lE/1t3qDMTtIgxdHuHw?=
 =?us-ascii?Q?pHE5ZRty1cYWt3YU/UVb6nQRFvKQxvxr4dqxsAJ8avNebWXi1494alf4hbiO?=
 =?us-ascii?Q?hKEuYWJ2Gc7TNnBT4n5maXjzZpMeZjTE8v6OBY5lhYCepikBbSfJurWCp81Y?=
 =?us-ascii?Q?VC9A0wbMcLM1ZbNDhizVKvudlarQ++vGlYOjA7uiv4l5wdHdvOX7iryCjdcO?=
 =?us-ascii?Q?ULNv7nRvUPOHRVfY6ctnyAE5Js8XxnHh/hjO+lpYzuVcXTruFqyGKVKdZtc9?=
 =?us-ascii?Q?NRmAiWnIGz5uJkBgl3RPmY3egBLBKrm5sjeoQlUhbzF3v1pdUv7CyIiHybg4?=
 =?us-ascii?Q?teyeydyyYjWwTfMrcP+B7+uuijvOOUGAwNm75I/Wv1JbDXuISZd5AStdJsnR?=
 =?us-ascii?Q?r9byIspWFFkXKSzsdmbWS2/9AO8LkrOjPOfrLXPrJLJvpmlzPCCV+DeN+7Iq?=
 =?us-ascii?Q?T2NQaoLn2vUTuk4s8y6vlYGPEY6uMQ3NBHf3ndPDxryyXCkg+yPS+RvO4Yun?=
 =?us-ascii?Q?APhs891SkD4q8VSVI0214Vn+ONSTrSeIVUiPpZnygC+JujJE4u1/WZ9z38WP?=
 =?us-ascii?Q?1zM9zJ/FGzYicN1RmpUcTVzChkrT9iHfBbG7C+c7FWNtvXiLsthHSsVbS2gl?=
 =?us-ascii?Q?7p48Di9wBwFBiNmQ4lt3FxlrPaBvWkoj7/2TInUUo1FnDyV60/K+0iFoDjg1?=
 =?us-ascii?Q?CWJS3nFDncnUWbwPVu5a1M+ntbAOwXnNMu906RkHVKuznZNyHsLr6HKxQToB?=
 =?us-ascii?Q?yjoV54YUByv8h2QwKjqsPD9N2f3bqtyQ94DVRZE530UDngSjr0istPQqAMS5?=
 =?us-ascii?Q?NnnKsTf1IxzOYx7TX+laBLHTH4/luVJC+BpmMySfDlaZ8lryUUa4CGJk8fB8?=
 =?us-ascii?Q?e1xCt8Kde7HsAR/9ImwFgoVcDIKf3+fwEyQxEmtf4uvqqjACTYaznxzL/SFu?=
 =?us-ascii?Q?lgXZjSE9rYwTAcbYD33y5MtI0BENKJ/QlGq9g/Z2BTcbepMd6EmA/Q+ym3bG?=
 =?us-ascii?Q?82Wj1JHkLq8j1yl9VNTiDnc7EDC5HZpdjyKnfyOYn95mXNq6TFHTF2L0PE2w?=
 =?us-ascii?Q?rZOkWPCB/HxzGwYjM4iBGccp9oKu6LfsnULaALEt2H3nmZbxrduNnHH4SAwl?=
 =?us-ascii?Q?so/jti+tyai880U5zxFhFQkzUHgV8wVgFlimmD4eA08KZyU5hxZ8nuMvSzWt?=
 =?us-ascii?Q?MYW1P9uWHaT6hs5/rBj5f09Oha8M1EpYLTlLGEl7Q59HLghDq4m1/yjvcFZJ?=
 =?us-ascii?Q?H/4PBabGK8sSptR90N18mglBqr7R0F/I3dfBg+m7e5bl7ue6LFWt+xofJPPf?=
 =?us-ascii?Q?fi/sbz0VdFW2Xaaz7S0yeibxLmPgJxqNXzDHunh71w+YqD+jac8kLhMqINGw?=
 =?us-ascii?Q?cJlosvO7L6Lbo3ri0BtbDpCsk3/2h9ZaCVqi/h7XOi46ZFon4URkfsST4cjm?=
 =?us-ascii?Q?SNTptYvjO7dISq2psz17rU3gMwKKpKquP7EP5cd6XeLlkQvCx6ihMTCH12Op?=
 =?us-ascii?Q?p7U4GolqdJJqKzjB2N7xd1FqJ4gtVdPByRcLWIMRM0Yl+hQjHHSBifLUrWGa?=
 =?us-ascii?Q?RIV2YR5AGA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374da713-c4ea-4a32-ac29-08df0a829537
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 12:46:47.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ERla/rd38fn4CYwYb1v9pIkKNGgNLQuURg/GxQjdK14f4s5H/iXRqSiBDkrVZSBTt19ePtzqgnVsfC5LmM/YE1svqGc12rv7GNfFZVz4w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12011

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 02 September 2026 12:06
> Subject: Re: [PATCH v24 04/15] mmc: renesas_sdhi: Add max_divider field t=
o support SoC-specific clock
> ranges
>=20
>=20
> > v22->v23:
> >  * Changed the data type of max_divider from unsigned int to signed int=
.
>=20
> You changed this because of a Sashiko report. While the report was correc=
t, I think the solution of
> simply using 'int' is suboptimal...

Yes that is correct, based on Sashiko report I changed the data type.

>=20
> > -	mmc->f_min =3D max(clk_round_rate(priv->clk, 1) / 512, 1L);
> > +	mmc->f_min =3D max(clk_round_rate(priv->clk, 1) /
> > +host->pdata->max_divider, 1L);
>=20
> ... because the existing code is just too subtle / fragile and hard to un=
derstand. I think we should move
> clk_round_rate() out of max() and handle it seperatly before. What do you=
 think?

You mean use, max(clk_get_rate(priv->clk) / 512, 1);

clk_get_rate() returns unsigned long compared to clk_round_rate() which ret=
urn long??

>=20
> >  	 * greater than, new_clock.  As we can divide by 1 << i for
> > -	 * any i in [0, 9] we want the input clock to be as close as
> > +	 * any i in [0, {9,11}] we want the input clock to be as close as
>=20
> Maybe instead of "{9,11}" use "ilog2(max_divider)" or something? This mat=
ches the code and is more
> future-proof if the divider gets extended again.
OK.

>=20
> > diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > index c6db0418de15..2bf354331b2d 100644
> > --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > @@ -102,6 +102,7 @@ static const struct renesas_sdhi_of_data of_data_rz=
a2 =3D {
> >  	.max_blk_count	=3D UINT_MAX / TMIO_MAX_BLK_SIZE,
> >  	.max_segs	=3D 1,
> >  	.clk_mask	=3D SDHI_CLK_MASK_DEFAULT,
> > +	.max_divider	=3D SDHI_MAX_DIVIDER_DEFAULT,
>=20
> Same comment as for clk_mask, I would not initialize to the default value=
.

Agreed will remove.

>=20
> > @@ -62,5 +62,6 @@ struct tmio_mmc_data {
> >  	unsigned int			max_blk_count;
> >  	unsigned short			max_segs;
> >  	u64				clk_mask;
> > +	int				max_divider;
>=20
> I hope that moving clk_round_rate() out of max() will allow 'unsigned int=
' here again.

By using clk_get_rate() I can still use unsigned int here.

Or

if you prefer to remove max() then the option is to use clk_round_rate(),
assign the value to 1 if It is 0 or negative.

Please let me know how to proceed.

Cheers,
Biju



