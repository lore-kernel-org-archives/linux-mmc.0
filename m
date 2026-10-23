Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792762518;
	b=h6GHjJpzFTxOcOLY4eU4jw4BI1w5JhhAI9TRxkKOIC3HCrdwhJBaWqraN+/HV9l4Q2+R
	 EZqy5W9KQIXvO6YwXr4iFw6P3Y2n7Jn+cU4F2AsF5JJ7bPbOMoVFBFzcrm/WAKcxu6Win
	 BkBCHL5vV6DgwvomRjlvQ8kGo4thZH4WQ/pRNzb3re2CKnM5XFsIQKXpBtjOTU7vybMgP
	 /10lmC7ZByhXvXNe39aRdL2ch0s/Qv+lYZ9Ir8k13NBvvy3/FZs9CXS0t2JKD1CyFoglT
	 zyNvfKLohpKir2jxDcQbsKE70j1CzTyWjpL1iCt7SCdYavnsWr+KjbpsCBY+WrrvjXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762518;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JcgD1qoYeF/KbMxm+EOnv6U7yG7IehbET585K2IQDLg=;
	b=LHgtYERqaU3YXgozMSF+noClHY7Y8fdTrqRTg2o9kTTyqABAXB91SGRoaAt+P7QRypAw
	 bzkxFHgbcmcux4shjdlQ6tT4gOq72A/DJ8tjo3UgXxykZc1wer8n3aydhca6RdNDjxFfN
	 M9sMO7w/+gmI5mO9bg3Z6xvemlI4AJAuNEFynB4zkMPnY01ilhVoAYjbmS+JT0NU+IMO6
	 InfwEKDhEdkIAXd45ao0F95Nyp9EW2IbHbOlWJ6G0uk8danm9SBKre1onhNXYxRSTL2FU
	 fDngOztyqRjDMA634dbiYPLBwwcecr0+FuAT87zUyj1zHzUOr23eOgDhjg0tGG4vp3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=boiLpFzF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.59
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010059.outbound.protection.outlook.com [52.101.229.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD14606A31F;
	Fri, 23 Oct 2026 13:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FD14606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=boiLpFzF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDbFW4udcaiLrkWx4jLKMIplr0ux5dN3bH4GKZJlPYtiZSZTL570iR9beum3QaflZnfZQERRpG4h4aF4o3YQKKfG3SH6xIrj6pQEcDU28cmlzwdaZhA2k9QZPtu3ZqLJ7/ePgWRfGK0Vbu89sbBA048WBm894+EoIC8Lg3CzPnbAQSeYjZgRauaqAr8sfR6KFx16ttJFt8S1TT6fk/uuQw3wF3jxnG7TMRMqqAlIwtr7qYEr1wWMBBQTEdMqc9Xch/tMjLqPC1iNguBFOD/qevlueKlHbc4cj3RrTyOkt0S39Yoh01f6F0hES7wV6WF0RYsHc/NlzP6+n0lUGRpwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcgD1qoYeF/KbMxm+EOnv6U7yG7IehbET585K2IQDLg=;
 b=F9zizBK5sx8tNXuML2YNwj5OrBIPDeOj4k7nyTZAh0ft4AAty2yckIFM9A+jwAWzGxedzivEmYpeYYsayJBwL5kgsVZ9TmHQLTjHWZ5Wkd05VKhqnZ6w3GfaI88W4FW6Advbn4LNfd9CNvL92EsjP1XGj8OUEMw5LWbPlUUonLptOR1nERFVx8E8/bknLinBqRKk4SGKR6fybKdZflLMsKz/2j4UFVezm3Kz4x3cwC0r+6h6V0bcLvCmQMVauRXez9MT3neFzUxo3HIboh6Ydoo5eURBMWux/tqb0CNbmH1lBYNsxF/C6kZmK2fXjTOUnsa6b57vlnNeORWqvN/e4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcgD1qoYeF/KbMxm+EOnv6U7yG7IehbET585K2IQDLg=;
 b=boiLpFzFCy6BPQtS1k/5dkK/ripdb5MjoP9V3GR4yIzUipRDR1VloJDZvOlVq2Vs2em/7a9HWrYEKjIbR8gre0B28nWQ6ChVRtx1iuuMMA8BIvG2aBwr3KqU/CX0tTAvgQVog1gY0F0xKB2juFqJ8zwfcju39+9SfNwC7Jp6R/w=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12403.jpnprd01.prod.outlook.com (2603:1096:405:fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 13:35:14 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Fri, 23 Oct 2026
 13:35:14 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>
CC: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Thread-Topic: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Thread-Index: AQHdMMe+SeXRDHnYx0S0S9Te31Iesba8r9cAgAYcQRCARuJrgIAB1J4w
Date: Fri, 23 Oct 2026 13:35:14 +0000
Message-ID:
 <TY3PR01MB11346D961A1F5ACA688B78E3886642@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
 <aplBTMnnF1V71BDL@shikoro>
 <TY3PR01MB1134610EEF7D300BA8890357A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <atnXz00Hci6R-7Ux@shikoro>
In-Reply-To: <atnXz00Hci6R-7Ux@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12403:EE_
x-ms-office365-filtering-correlation-id: cfaf6209-c4af-44ab-8178-08df310a7836
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 sKBMYRJNlK4fk9IBsHJ+lArdFxpC6p23yGRL03Bu91f+DUDerS3peBZ6gAs0u2VdObtTrSAu8j9yWTwvF6JJqf/aGP7RH43a7x8NYmUlms0aUzL5wkouuuUUZONei+CS72FJx4EXQJGE9IkyrFN7DNy3pxmippQD3s6LJ8NoPlA4b0wspsBkrBuMkc6b7hHzVQHcFcYJQ23J+MLCl235B1Bmuo7hgPA+mZrAEt58pVDrVlLmxlkdgY4RK/Nh/IrSHyKnKKw2TAbLaenxZMpYzfG0GbKT1xWuPlb9WuMcoVxNZNE8jv9FL8zIrdyhEB+usEm9fxy0vnko4mx0vzfwmy27GoIqBvxhXQOw8kgxRMcPhIjZfPcsT0xuHcPOdGrYvYCoKILbiq8AfVpfZgEqz7lihzdydpchxnVB1HB4/T829RqMM3gk+bgb8qsbiiRU+84NwVVQoSSl2muAL7qMW2wSEgwrCuQMqXGDK22U3E/ACA7fg73cHv9nFAIs2OkEJd8Tku/gFYL+EbxKl6HkLaVMX5Rc+8HtCAr3EYOOPPQoYAKYeAxVHTqh2/wHeyHzrudvRniCQD2mwonwacnyoEIFIn2b5IhUD7q9k2D+Mxcn+dWWTLlsSAUSwwmYsXCVxnwDJgu43ggMnizg/yK5VKrDHH16v87JxwMEUR//Fm/NeGm6PD66IaB2TD3oH0E7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QtfRACd1ukmZIzG5wsvLqG9agTimTdoJ10k1hmSaAe688FXlIBzotsPBaVX9?=
 =?us-ascii?Q?ZpTa/1p8Ezk2WDBjziPK5M+wPC5VpQ2TyShDd0XXTLyO4so6U4kFmpwiuuaD?=
 =?us-ascii?Q?Be+hNqXlmxAuZxK4lblYTOSDEZ/mrSE4GuSR6Q7BYqz5ERlbo9EJPx/zOtNF?=
 =?us-ascii?Q?JRFCUQ1ZNqK/GWbD2PCynZMsiiSGZ9xS+W7opVsSh3OJA/vGe1V2PxJBzxhE?=
 =?us-ascii?Q?qMGCC204wdc810TqHdf72rpKxL54LVdehHWctLd1iQpKaeXXNTZVgPyrZWhO?=
 =?us-ascii?Q?11Y+XusxSryVmtNAPkxVmiqb1NgZCgl0Ktvm4RwucIx5SUOiGDPUeyMYyJ9W?=
 =?us-ascii?Q?sBxqKD1N34gaUkziFmEoqI2sCKXqA2JwsMi0dqd7wI4MYDug3g3DOh/Xj9U3?=
 =?us-ascii?Q?au+9uXUJXJvK6Lh29F63JFx0WJlNs90FIjMuuRg7tEOD58zURDI9Llh5VJDw?=
 =?us-ascii?Q?JndmIdLABvxPvJeXYxhh97xr+d2RVh4qiwNnl2vBBVCl7RfDRLkhOw7W+CGY?=
 =?us-ascii?Q?hsNUBKw8xLka8d1EJZyP+H1U0bFhhc6m7nb1KWDipnfSGyYBQTHc+sXS0/ns?=
 =?us-ascii?Q?mTGrtjjatdXZowirnph/fP4mtybo/rnvwZY5s6bizgo9mLPoWiYqt1oMVPvb?=
 =?us-ascii?Q?pYYUJvt8CAGkCFsoZ7GAAzarBYflbV83Nr0TvbUtqOtbV9WVDwhnpXpOcCN5?=
 =?us-ascii?Q?eegg1guD2VLeT/mTldjuWqb29MMoN3Uww6uWQTDhrqWLvhK0zeFElOggQ2kF?=
 =?us-ascii?Q?exS/xapPEz9DJOaX6PS4iN6/pdCxeu/URH71cF9B0588D8bw+et4o4guY+jk?=
 =?us-ascii?Q?dFHNdqhKHHVQhiTA68HHf6RpMY8WQT8UAANslW3fhM+ufwtesN0si5O3WfcT?=
 =?us-ascii?Q?2djN8ObzkPSv4fQxSy0Nwhfu2Vcp2FfWJT4lbsNsfXDjmgJ1/+AiBJY5icwl?=
 =?us-ascii?Q?HgYGJYCs23yZGOuzeZBvvnrRO+Ag3klhXIkD1RUrUExeTBPwNXxga8/x9aY9?=
 =?us-ascii?Q?ggIKRhfeyByubT/8SACvFnkH3A4zUQ4xamJT/iHA4kAWL8sbK7TxAIOU/jgA?=
 =?us-ascii?Q?wFj2/mQBH4ccX18j8+yKAmHb6GBSyd/12E4gxc//nMPFzag5BPUhaCWhxsGR?=
 =?us-ascii?Q?zpJZh0Vzn99EboV1fWlpHUjN/aY/+lZJYjISDnBDM/Q/cF3zRXLD/PNY6NgR?=
 =?us-ascii?Q?b27Db4ZnwQIpuUN+Egwk8E99u8YOqVEj4xiKm4FEafdbGvlfot7hjPMxFzPu?=
 =?us-ascii?Q?Zq8bdA4ucnnKNjJ3KhKb5eEUbWOfrFz65R5g7Bh4Q5hVMwLrPjXhgS3jATOU?=
 =?us-ascii?Q?WDTa7VT0LvduXEZ/tHpw6fkQDU5QF+TzePKtOScu4/HPKrBwjyDhSGWJRZUK?=
 =?us-ascii?Q?qS2ty+n+mRUm3ldpPQSlOyvqdWMBPV1vItF+ArKhX/i/b4C+IeD5k42DzcXY?=
 =?us-ascii?Q?YCIsdyv5rD175zxSSnCnxavuPalC/PFYHsEMvylWKN9f60GGy2c2yA54J2n3?=
 =?us-ascii?Q?pS7gNwS5JDc+2LRYxsWV6Oc7kKo+s8erLDp8Eyn/tmdiFkI2mPv+cm5o9jhK?=
 =?us-ascii?Q?sm2wB2jUMtnjXnWPGnTr8mASdFW5fp4F+Si9NMD38jId/g5Ww8ApDdHoKtaP?=
 =?us-ascii?Q?zkhhQLJ+zJdVMlH7zR3IT/GBp3rC9AqgjsfsiDU2S4IxJdAlQHrxXrfYVzAg?=
 =?us-ascii?Q?N5UAuE6PVhciDupEo2oaRiCezhT6LJMOMEcWuz22WGyPz1ydDciurv33bDIS?=
 =?us-ascii?Q?YIQ2//FFEQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaf6209-c4af-44ab-8178-08df310a7836
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 13:35:14.5367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hmgv/iEHhTLxfGBIJcRaU/ImBxLa2PFRp38ztXaBaRlKgUzRQJL1DNjjXhhD9Q7bNSycnTNY2cO7TXcYx1Ioxx12Q6bjM6DJ0/cujENu4TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12403

Hi Wolfram,

> -----Original Message-----
> From: wsa+renesas <wsa+renesas@sang-engineering.com>
> Sent: 22 October 2026 10:31
> Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_D=
IVIDER flag
>=20
> Hi Biju,
>=20
> > > static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *h=
ost,
> > > 					      struct clk *clk)
> > > {
> > > 	unsigned int freq =3D clk_get_rate(clk);
> > >
> > > 	return host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER ? freq / 2 :
> > > freq; }
> > >
> > > Was this AI generated?
> >
> > I kept 2 function as renesas_sdhi_is_internal_divider_enabled() is
> > reused in renesas_sdhi_set_clock()while adding support for HS400 mode.
> >
> > Currently, we decided to focus only for basic RZ/G3L support. So I can
> > merge it into Single function as you suggested.
>=20
> Please do. And if the flag is checked later again, I think we can just ch=
eck the flag. We don't need a
> helper for checking each flag, or?

OK.

>=20
> >
> > >
> > > > @@ -184,10 +205,14 @@ static unsigned int
> > > > renesas_sdhi_clk_update(struct tmio_mmc_host *host,
> > > >
> > > >  	clk_set_rate(ref_clk, best_freq);
> > > >
> > > > -	if (priv->clkh)
> > > > +	if (priv->clkh) {
> > > > +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> > > > +			clkh_shift =3D 1;
> > >
> > > No, this needs to be handled a bit above where clkh_shift is
> > > initially set up, so we have it all in one block.
> >
> > There is a difference here.
> >
> > SDx_Clock (HS clk) Figure 4.4-8 Block Diagram of the Deformed Clock
> > System (7) IMCLK =3D SDx_Clock/2
> >
> > SD_Clock  Figure 6.2-2 Functional Diagram of Clock Divider for SD_CLK
> >
> > Currently framework request a clk to set, we set HS clk first,
> > followed by SD_CLK.
> >
> > On RZ/G3L, SD_CLK value is based on internal divider.
> >
> > For HS400 mode, SD_CLK =3D SDx_Clock(HS clk)/2
> >
> > For Non-HS400 mode, SD_CLK =3D SDx_Clock(HS clk)/4
> >
> > I don't find an easy way to move this logic to the above.
>=20
> I get an idea what is the problem here, but I am still confused about one=
 thing. I'll summarize what I
> understood:
>=20
> * as of this patch, HS400 is not supported on G3L
> * so, in renesas_sdhi_clk_update(), 'clk_shift' value is 2 before clock
>   calculation
> * as HS400 is not supported yet, the internal divider is always active
> * so, you need to decrease the 'clk_shift' value from 2 to 1 after clock
>   calculation
>=20
> So far, so good. My expectation is now that when you add HS400 mode, you =
would need some extra code
> keeping 'clk_shift' at 2 because the internal divider is disabled then. B=
ut I don't find such code in
> later patches.
>=20
> What am I missing?

See patch[1] has relevant changes.

<snippet>
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 23332539ac65..5d9d3c7dedf9 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -135,7 +135,8 @@  static bool renesas_sdhi_is_internal_divider_enabled(s=
truct tmio_mmc_host *host)
 {
 	bool enable =3D false;
=20
-	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) &&
+	    host->mmc->ios.timing !=3D MMC_TIMING_MMC_HS400)
 		enable =3D true;

"This will make sure /2 for HS400 and /4 for non-HS400"
=20
 	return enable;
@@ -255,6 +256,14 @@  static void renesas_sdhi_set_clock(struct tmio_mmc_ho=
st *host,
 			clk &=3D ~SDHI_SD_CLK_CTL_DIV1;
 	}
=20
+	/*
+	 * RZ/G3L SoC HS400 mode has only 1 divider value.
+	 * Other divider values are prohibited
+	 */
+	if ((host->pdata->flags & TMIO_MMC_HS400MODE2) &&
+	    !renesas_sdhi_is_internal_divider_enabled(host))
+		clk =3D 0;
+
</snippet>

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2026082017=
1657.62815-15-biju.das.jz@bp.renesas.com/

Cheers,
Biju

