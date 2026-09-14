Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010033.outbound.protection.outlook.com [52.101.228.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921142C4F8;
	Mon, 14 Sep 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382281; cv=fail; b=QzbDhB24J8gSC22TP9bzPOltetuawx/7CXOsurAttdkK6YeZTGIw3axuYzocadZZg3DgYZA2SkItCW1GxVZBCIxudu+Q8jvBVesuVBTStKkimD7cexMeX/aoLTYZyAC/ST4Md0+lGkoig1XJv3wAwOrK/rslPusW7cuNxCEzqQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382281; c=relaxed/simple;
	bh=AkR4LYEN3U5UxxjI3ZT0pSliq/9MT8Qpk5MFFiEMWGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DV9dRcs0fG1LIAL+RA0DPVdcYtBaaTKMcZuzwXnpxjjeC8Y8Uwe2Aa62Ef4vEAK+1j//rZbQ8yGJXRwk5RtXTLMhXgBAe92v7tDoSqHyN7icpPdyLc3+hT8bQONKkdmJOYCJ0JRaFrf9RuBylyB3JmkRIoZ1med4YcjatwdjL7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Bns6nJa/; arc=fail smtp.client-ip=52.101.228.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Bns6nJa/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSBKYoyUysZ2tGjK9GQwZlCYPetKtdU+8Xd5Pa4L4TcgvjH0ilez4EkvYkxCxAtGob6gBqvCvYuqVT7Ab8yEHq5/wlHH8CNbCxFA9hDE1FjSzCQFmu9ZxtS1zRZ1J0PAxDGfZCwpPWQirf4gwM/c8/s4OTgzzxXXrOA8X7AS/T3LwzSGJs0f3cMliA54gLUHRjeO9Ls4eH9xAv0+t2Km7PA22Im+jQooVrnqxwGrXE50WJ2Y3B/T1W9TJ7jjf/HqmKbIrCENh9lrvFTF5pce4qHgSxv5fupQ4duyN8zIvMG5qUw2czdn/8DtOzuOgJ2wdt3z3BahpyZh8XYguz38Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pocjzCrCcsP/7bkunm1R1zaiSYAh2+MirLkWFl8qm7Q=;
 b=K0TOJhactahzf+ri14UA4Hw9nvRU5mE9xHdrIjMDItGJzuU24wXYBiUHKYW7VsstcLbBsXnKGPlFLxQUNLfdTE3eyUm4r3AH0D+8+8oNT8JOD0gbJVJNWkqiQ+d15SQKCv3yJZLR6c+DGs/UPJskcbZnJ93pdjcN+T1T4iOE1bKn7CR3Bgphd1jjwGmnUsCJcgMEq09xXt3iljeHENH69FswClxp9eXfrCMFvCyiiMSiLjQ83utLFgQ8l4W5yeAdXI5xTmuh304gXFzHFez7cfrfdO2kYdl/Np3rFSJJ7FWss6cQrA3mOyAjUdUUGFt8V5qOin90O3rC5I7CJiVoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pocjzCrCcsP/7bkunm1R1zaiSYAh2+MirLkWFl8qm7Q=;
 b=Bns6nJa/Jm86yKMSxeAsufFAU6w/Jf+Jjf6ICptNSXgSPqkpKbTC14c47vKk/eNr+HvGN775ZuMD9gQzuQTPqrsXpwvBQDQuPpK3p6Thl0K4DvP+/uMib6atIyvaxXLyzszdu4EosNJu4e/R/cbSv7iiUBDFK/h/+TH/8mbYpS8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB14306.jpnprd01.prod.outlook.com (2603:1096:604:361::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:37:52 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:37:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>
CC: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 04/15] mmc: renesas_sdhi: Add max_divider field to
 support SoC-specific clock ranges
Thread-Topic: [PATCH v24 04/15] mmc: renesas_sdhi: Add max_divider field to
 support SoC-specific clock ranges
Thread-Index: AQHdMMe7RxxJrlR3AEiECnq/qqkha7a7NF8AgAM8VaCACgxIAIAFiypg
Date: Mon, 14 Sep 2026 10:37:50 +0000
Message-ID:
 <TY3PR01MB11346199A020E8F9345B8418186BB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-5-biju.das.jz@bp.renesas.com>
 <apgC-m7SrDNU9YmQ@shikoro>
 <TY3PR01MB11346696A5DF407A8E25150F186B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aqMnnjs_9tzfuPem@shikoro>
In-Reply-To: <aqMnnjs_9tzfuPem@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB14306:EE_
x-ms-office365-filtering-correlation-id: b66d391c-bdad-42d6-3d17-08df124c3a8e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 QHqlaP2Zrk1xgxJyRQbrTa+UbYrwI9a6MBkSFRCqNssKvJwLDhDualkjwVthxdV6RXOe3z18al2c2PPZzEC1b00Qo454BvPQpJNZTYk7OZv7EvHsiO7vUcNC5JiKDmjq56hZ8ySyXOnMVQZzehU5bfx4d5OHrgYDQxrQp/+e54+JQd1fYjh0aCZMiB9Sono5B5PYvcklGk/zqOi8BP8Evh4uUGbZ9OMSvTTMWy39+SqbT5d+f0zrSa5SDwifUEd5sx/MM4O75c9kai056ZwRK3giOAf+5NNQNaXnwBiWGpQU4REc8k+IslQkLCOYGRnk/Q0htulTRLJJdRr58SynURmBINoljI2L71igK3LqMURwGBk0S591KtdCdkPH6iGa2REemWiQ8G+akdJR2/hhxImpbJopDE8dadCyHdA+gEJETteWdThC2xQha9wEl4WAfTD0wbXd5zwQJXmGxMuKstf0N24PhetYTFneONjUWgQUhgw3W4RIyZbYFPpBlsB9z8IrgNlefpvGdA8d1l2S8TzJw9kJICyq60ZHfFJpTksEKxoEjnJMZxUKu/ojqfeQsIGSeKyEKkWDKafsJZKyycv4aNq22j1kjFWWh3WjWrFRYOeP50ZTJFjIvrtte3YBx/NHYdW46BgE0GbMvZIKrWFpgD6XENlzS8kK/2gOzoI84qcLICCj5Hl+xZO3IIb+yeGCS9MlLZLvstsAmON84F8wWe1t/drLyiwB8cUY30I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Dlj9d6BMHhUbdbY3Txlmi8FZZGtTlNMxqgB140yYmFRJd5jEpXVkNkxiK3qY?=
 =?us-ascii?Q?cNj4B/GBXqdiJFX1lp/D4EJxjurRDhgo1uHpOkqO+ifWzfBCCMwyduknleyq?=
 =?us-ascii?Q?4ezqdSJqeraL1KAfVDF2eAIPAGvxJsmOXEhP/4U2g2wX5D0JkvHQG8iU2ADt?=
 =?us-ascii?Q?rqkeuvGDMypxZaHkEMfUqLFWvMAhaKjdI6VPB2YNn2SiBLzzI1VB2Yghh9ic?=
 =?us-ascii?Q?Wu1/nCLRv1uHBYUipFDHIgz7FovRDbrXfNueZNknehk3NK93fUBSZadu4KVD?=
 =?us-ascii?Q?+bAFTvaqlCtEBtCKPeBU2uNYk+wnsS9gzVffCXs6Una8cJMzzN4xDORXqwn9?=
 =?us-ascii?Q?C9+0d1OnV8+EB8t0zVsb5z+QRQNxdaA0kaACSBZDwKg4I62CwmJr0OwKIaJA?=
 =?us-ascii?Q?oaZ8w6rmhAoInBUMChRxfu3sA+u10wEUEyRccdvsJWSeCgp+OlA0Y5cgiu0y?=
 =?us-ascii?Q?hjX405AhYSjytbXxym6D1MBVNb99pjP8cCtePU6uHqlNuh/DmDMfISN+5qhe?=
 =?us-ascii?Q?szUBAtgjaOFMSmok3IRTJdtvgu7HcSnom3fVAsYTcktQYicL+JCePtJXHOrd?=
 =?us-ascii?Q?xUNxuI/xskije1M5hWEm+vE2O8Z9EpNeOCztfOfql5bxC2JVPTIDihEcGmBr?=
 =?us-ascii?Q?nSss0bk8pxWH3dr25MlUoj9jTix2JXRMd/rnWNbFsqFYL/7Imu6w2U1X6lQ0?=
 =?us-ascii?Q?Wy5paMQcRdLstnYm80UcpBrtxCPCmE8j0v2KGomUPFH6i0KsBEwtZWfETlb2?=
 =?us-ascii?Q?JhUsfCQAJ8a+atr3VLX41cc+38brV4xLDQiB5UdkECaSz9DPLZ3V/SsfYfF5?=
 =?us-ascii?Q?Z/SPbJMCZtPx3GmCfcJi858pbtspCWjA7tgkAs3QK/upDmS9vIrxnQeK5fUX?=
 =?us-ascii?Q?oCbybKw1pNsyqrJyzucMQZ6BTBqmMXw6fV9sHNinwl1rdwOvVgmywfnN3BEI?=
 =?us-ascii?Q?aKfUzTcHbwT94n/HxYLdRER7FaBsqVg0YPbjalhMeveAvjacAsiZNbGBYQVJ?=
 =?us-ascii?Q?72PJHclxwVQNg5ZBs533cco0nlMqAWRNWlR6GDjrJ9fqw3+AMcL+3UGbSjS6?=
 =?us-ascii?Q?eKwV9ILo85kYGk8jWrL8RvZkqcrqZ3BZnlQr3WU1RuO0AwUga55W6H9EMw/w?=
 =?us-ascii?Q?jdIU+wLms9aAWVEqO8D4x1Z3W7QiGdKOxM4vkvlWXZFf79tfoVHtsJwNRCjw?=
 =?us-ascii?Q?xu1tSj9oMq860YX1UQaooXMrH9fDoPTxCZEuvGuFwDi/lM8OtZmYbnIVPqrB?=
 =?us-ascii?Q?LmvQ1a0IoesNUpkqUZi93xgmB7jN3nXnq22JkaAIUk67D2085391sdAY9rWR?=
 =?us-ascii?Q?unhb+VC54Lal4gNaxAjDycVcJTdA62Wva4G8q5Q28OK/X5q4nxQJY/5c8Jox?=
 =?us-ascii?Q?7uKwAIEEzeWRbaEv45kMXU9Qqtu5QLNQdn0K01FkH5teNnpYDT+gR6Zygb7v?=
 =?us-ascii?Q?aNIcx6IlYdyolzOtMAy/yftKCVGwxkUoGpz12DAklLtSbzv7S3v32w8afPTI?=
 =?us-ascii?Q?1OoNkNs9nHZDD+dbWf9USr2Y2WFSSetFABf/z1DBcNEERTAnCTVEYenfd0yw?=
 =?us-ascii?Q?xsYHdnOBEjqb4ZS9p4VOmSwW7CpgE0urvNntJTcCH0lCtD66knH/wTjdAV9i?=
 =?us-ascii?Q?1fj0FpPgscuAeEKSgl+HCghoW+Lik5GlpJbbHC0xn9fNM6HDqRXPFriucwb3?=
 =?us-ascii?Q?aialhHs70yBLdWWAsL7ZLxS8hHsqy5FEhAVRNF0ad5wuc7El9EIPM7+hVPOx?=
 =?us-ascii?Q?TU4R77HxAQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b66d391c-bdad-42d6-3d17-08df124c3a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 10:37:50.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L89hNp8sDJpUpz8qV2a2CenPvBPdoe/f2pJOib/rcG862lpTvGYSAvkhAA3cQ5wHDFamG2CsLv2Bs2frwAmoaKC+pd0FmVURYNVBMJ4yXAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14306

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: wsa+renesas <wsa+renesas@sang-engineering.com>
> Sent: 10 September 2026 22:57
> Subject: Re: [PATCH v24 04/15] mmc: renesas_sdhi: Add max_divider field t=
o support SoC-specific clock
> ranges
>=20
>=20
> > > > -	mmc->f_min =3D max(clk_round_rate(priv->clk, 1) / 512, 1L);
> > > > +	mmc->f_min =3D max(clk_round_rate(priv->clk, 1) /
> > > > +host->pdata->max_divider, 1L);
> > >
> > > ... because the existing code is just too subtle / fragile and hard t=
o understand. I think we should
> move
> > > clk_round_rate() out of max() and handle it seperatly before. What do=
 you think?
> >
> > You mean use, max(clk_get_rate(priv->clk) / 512, 1);
> >
> > clk_get_rate() returns unsigned long compared to clk_round_rate() which=
 return long??
>=20
> I mean
>=20
> 	rate =3D clk_round_rate(priv->clk, 1);
> 	if (rate < 0)
> 		...
> 	mmc->f_min =3D max(rate / host->pdata->max_divider, 1L);
>=20
> Makes sense?

Yes, it make sense.

Cheers,
Biju
