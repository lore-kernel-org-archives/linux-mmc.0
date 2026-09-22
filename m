Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011067.outbound.protection.outlook.com [52.101.125.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600453D9D4;
	Tue, 22 Sep 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080607; cv=fail; b=jy4vNxsbyDP+7LdzIwP8vbWWOGPcs3brRQ8cdXQ0dcqS2iDmcnG5UClLHY+SLL0xg8u0A4e2I/1tdQU0Gw/Y4bYVz8ZCSIeN395+IziMIrNGZxRjofB+xiNauSGtQAtC0XoGikR2+S/mCoqKYHpJOOECY0YSBUExlZwY2Cb/PBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080607; c=relaxed/simple;
	bh=MU3kkMa3DLlCcYRpNia/DY2KIWGPfRiDAC0DwpNt1x4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lzEcPXJF5ACQnOhoJYNDnh2rMKxsLgmfgeGcnlvRCNwFfMAkdKAaakJJbsqha0RlpUVAToUlBJCovoUwsMU+MH48DjtHrsiHh/7ShrJE0xTxHYcbdyMnolzZ1380Y9W3GyOH2QzsKIITA/Fk0Tepgx4b0ehz5l/xWVEF4xWvdfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=nUKtHgTb; arc=fail smtp.client-ip=52.101.125.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="nUKtHgTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF36eb+HLFpxUVCzFO7oavXpNM1BDQbByyJEbCGl8b8ZY89LiuPMacCPRx+eFqB3uxig9/NDxZrHDz3jNvGV0x8ZvgwFU4X73XoS+QM5SD0fs4+nfCesz36Ubky4jg392YM0XUChsrEdneeSgssW1ZVIByr7LYfZCNRcjmxWUbBEVkR0QBLj2ssGQQxhk908XejN7IHRdSFfLJ84dAuNGGx+rSUBJ4sbLMj/nMzzy8hzbJPuvobLTtCVA3B3yup8f8P7uqtL95+X2VSWxPaexhAyL59STB5O+fFd7gJlX/aV4oHA+3eUh4liazYKJlNkJ+maMKTWr5gtxu9ylPfUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqBBw2SHwL/ZNB8KYddJRUVFjLL6/bvO2Gow4sWyzRc=;
 b=vfOVMlclX1P2oZKa6ZknFd9oRfkKDxkvL+mKOriHpKKn14+afZS7+qflfxhLYG63bYYGD3zewVQY8iQbA8G93I7gapet9Cy3Xgp8pl7ULemwdeG7AgkJHH33ar+fp7EL30WzI3y2b4+Cb3CdJIs9k/ZGBj5SreLXjqJFnT2lBqApuHnHkmHm2iMv5OJzSyAQDPtimA9PnyaDEt+R1WLVPYr2RtpyLqdeGTIaWZsJr/6Eiz8hE1eGXyKgifHL+ZtBG1W+8aUSIRLKPiDsHI0y5SUFOHqN9TtAV1PGDdtGJb42uStfI/oEJnaVvn5kpMVlcx4sqhV0ABM6aVOhKd6Z3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqBBw2SHwL/ZNB8KYddJRUVFjLL6/bvO2Gow4sWyzRc=;
 b=nUKtHgTbtLgOFeiSFgNbC2JBWdJTdF8ApB5jG09E9XLcPbQcFli6LimfGcVMfeNRJLRip2UIyFLnQpIf7M3YSkksPc0n8Upxui4uAQoGPT+NBXcij+OQwkgMmfnoumbCFUZGHJk+IOLTjia8RG377OJS+6+7kJ34r90kEkOiTjQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB10418.jpnprd01.prod.outlook.com (2603:1096:400:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 12:36:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 12:36:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Thread-Topic: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Thread-Index: AQHdMMe+SeXRDHnYx0S0S9Te31Iesba8r9cAgAYcQRCAF/AuUA==
Date: Tue, 22 Sep 2026 12:36:40 +0000
Message-ID:
 <TY3PR01MB11346C754F28A2CA2D10152BD86832@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
 <aplBTMnnF1V71BDL@shikoro>
 <TY3PR01MB1134610EEF7D300BA8890357A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB1134610EEF7D300BA8890357A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB10418:EE_
x-ms-office365-filtering-correlation-id: 68a6e088-22d7-4dc0-c4ef-08df18a62723
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|10067099003|56012099006|4143699003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info:
 fch0XHV45kD+iH/mNs2nNmXg81Dp6vsTWIGoRvfExqYQ9JReZyoUK7AQ0aQQM1LZw7Zjw+BkIlv/Qe/jliAoKFX14svLMEFgACcd2FEmP0yKHh2h60BsFhkvSdKLkfXeNsu7PHTRe+uIyfNoxCPv2UUqrqZaDYVp5JSMg3ADi/oTmJ9J2eB57OrJ7p0xuFqggL6ZTvHYjKtySBcsPpnzPoQBAAQhEWWlbvTzUWNAIBbE/Wq5muSY7ljlZ8opGdldew3aW/gNrzFtiN0CZolL+z+LNK0f6Ijlb0l7tZfUdxSIzNbSpVohHrnwIO94eWpgO+OeW8fkeztEc2xSfVilkHzmZWuBtHzGCwbOqlTBtUwVJAOz2S+dqvYO69FMlkbj+LEzDr+zqvCXT76YEWJcefLm4HPxoM3JHGUgGYhAFiH5nbRxUNAlpblyE6MGE/6mI0bVB2EPFqPgqCUL6tWEvhRGh1ZtntJSMXSioXs/zdoAuweVRkkhxqlxEoXMgaz9iF0+nvJqSnQUO8tJ1QGQVaMsmwodSzmezmN54KwMHsl/27XTk8esDMm3Ug8swzkiPnlzNjoWlKR5d7Qy3bC1WE5Ms+axlg1vulJYUz0i2rBdX3K+h0wLSKXAkOSpYCHQAkd1MFHjaXv6ftWe/kaSs4gSzjrwUzi7ycXLFUQenGHnUMdICuKdiQaKJxygKm7PR/ZarQkRSdClcAXfDuabxZRyprxQCYUjvAvuXgny0u0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cXmBP3QpNW72i4nPI5Cm1lrBd0LpiQ7ETtDw4TCr2j6MHUDMBmUnB97yoZ61?=
 =?us-ascii?Q?V4/lw65Bn1n1K2ketSbULQbAG1bc/3qj4e1VSPX7o9p8DSk7NNpFTZt7jmYs?=
 =?us-ascii?Q?3btlN3gPQxGU9XvizpwcS7Kf0ibDsDwg2ilVv61D5v0s8OvzdVTEE5JV3zis?=
 =?us-ascii?Q?MU8DzR5wEnJnKXkk4VfjgmvI8gFC81wnH55gf7RwRJGejbsvJ94Kqj8mYfCx?=
 =?us-ascii?Q?78jj/o7+BeQjXtBhi2tmXZuh7lOM6tMNr573NEvcAy26Ia88GTMQcjqBH/MC?=
 =?us-ascii?Q?9KIpq/bawVll3+78bbYsnrTmZtB2tivKfijeYJ4C9xC3mkMEceu7dceAZoot?=
 =?us-ascii?Q?3uQQqBh97Cr3gY6FghBBQdlrmrvfDUfLP03bw4BxxASjTiUhrqaWB7SlhWDg?=
 =?us-ascii?Q?X+jka+Sxy4G8lN/PAIIelNhP3lIhjBdA3vdH7JclPaB1nPjrtWRd0BDKSjfF?=
 =?us-ascii?Q?RXoVQUJy5DraaNoLBu5NkKtuKbnlJ4GSiqJw+tDN99J0MHkNhwALgW1p8EQW?=
 =?us-ascii?Q?ImOHo3pdJ/MsOnOmKm736aspzxt9G2/ynx4gmaq3RlFXe+db0cUPofyenZSE?=
 =?us-ascii?Q?XTtrkdh8kcLh8GyLZAYYPH9VRGoEb7slg8Iwm+BEbWI2T5wsdRWDeVKKCqeW?=
 =?us-ascii?Q?NFW6x8wH2yMaUGYVfKSD6vYdzylGV5hDfdry/PpiBczFxTmkxGbUlltuZfRt?=
 =?us-ascii?Q?/sxPrD8TrwIymr6viGvi/boHvi7w9YTIDqJLUKBE6M46hKyG59rq3DZzJQc/?=
 =?us-ascii?Q?BzUNaS83giN8EqEWSXaZOdKpzt68dAQ9o/0u+CUS3LWOdYZVQVlZstF76zop?=
 =?us-ascii?Q?q44hQcpW+xlx2YgdC7EiKh+kzjjFga24s8dj7jhVcEgs91utTBHGpTQWeKeN?=
 =?us-ascii?Q?iB0IGKP5pn6pO6VRq8A8DLrFG3cYS4gKSv2mrczcQT+6yv9DZTZgWXcUDzjN?=
 =?us-ascii?Q?GVHcfjbxpgh9LcJwduBa0OUA21Pz326GUPi8WhNP755AvyZPKvyk4xVyHArh?=
 =?us-ascii?Q?bufHxcLzfN8qtU65CkerDGowiO5Y9a+NoIVIPLZsUPlx9nFPqFmZYrCe6UXH?=
 =?us-ascii?Q?3cqPtWfBikVqTdrui4bUvDkTlm8wgWyEQq+nC1VD7BbL3eBtZourVTGPSv4c?=
 =?us-ascii?Q?RCya99iAEDIYA/2yvqdYqwJZ71/9EUL4VcfPyJD+EQUC9UIvKUB/fmKYhuE7?=
 =?us-ascii?Q?ebWN4Lnh16udXL8Nl04whJ7KnT425qzwcFyvhJWf17FmOtJ2lznUcUd7q5zb?=
 =?us-ascii?Q?FP8hdh4/Wo+XWr6hWwPY+QPN/5GyIbn1EBkdGBXid2MV6d/ObClbLYwN/s5w?=
 =?us-ascii?Q?+ybrhuZQKpiEfnDuU//7D8uGY1vmGpyFrqP5g5WAiM31ceHb3QkcF6oXW4Jd?=
 =?us-ascii?Q?jVa1U0zR1M1LSCXabRhYJsoj4BW7YhYGBS/lPH3yeLbY3iZGnLARrpZx2Fhi?=
 =?us-ascii?Q?JenL8mohg/wtzRxUHrudJ7XwK5B+daroG/Y/elUWihbpBV3HWcaf9LLX+s/J?=
 =?us-ascii?Q?NVFIZ+IahjwJ+4OJ3EKNxkPvKHH598DIgMS+wNj8K60LvV5AV4r/olWhTr5T?=
 =?us-ascii?Q?+sNQJFyO054jTqpM+pFafSE5UB2UA3MaCdwaJLQRCBw/rxii2loBH7D2J+CT?=
 =?us-ascii?Q?QSWz1RddKpjwpKwFd3tai2tYZ9k+pdyLRW7lUpn3APm2klzQgkXzm1vSLJZo?=
 =?us-ascii?Q?5VgaPzWTUm3H+v2Uk9DAB4of2we/i585Diz4zPOEfpiJu42V4TrfoLdjzkdq?=
 =?us-ascii?Q?MeV960mRGg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a6e088-22d7-4dc0-c4ef-08df18a62723
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 12:36:40.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWZiI6wAOS6NXRP6jVfQ8QoTuWY01Sc0QgVrYGQfmKx75nLRYySQoUil4CoDxLmAwzogsQp3nVeC4NTTuA5syAceXlvo4yIdS+w7O4xQd7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10418

Hi Wolfram,

> -----Original Message-----
> From: Biju Das
> Sent: 07 September 2026 08:20
> Subject: RE: [PATCH v24 08/15] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_D=
IVIDER flag
>=20
> Hi Wolfram,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Sent: 03 September 2026 10:44
> > Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add
> > TMIO_MMC_INTERNAL_DIVIDER flag
> >
> >
> > > +static bool renesas_sdhi_is_internal_divider_enabled(struct
> > > +tmio_mmc_host *host) {
> > > +	bool enable =3D false;
> > > +
> > > +	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> > > +		enable =3D true;
> > > +
> > > +	return enable;
> > > +}
> > > +
> > > +static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *=
host,
> > > +					      struct clk *clk)
> > > +{
> > > +	unsigned int freq =3D clk_get_rate(clk);
> > > +
> > > +	if (renesas_sdhi_is_internal_divider_enabled(host))
> > > +		freq /=3D 2;
> > > +
> > > +	return freq;
> > > +}
> >
> > ???
> >
> > static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *hos=
t,
> > 					      struct clk *clk)
> > {
> > 	unsigned int freq =3D clk_get_rate(clk);
> >
> > 	return host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER ? freq / 2 :
> > freq; }
> >
> > Was this AI generated?
>=20
> I kept 2 function as renesas_sdhi_is_internal_divider_enabled() is reused=
 in
> renesas_sdhi_set_clock()while adding support for HS400 mode.
>=20
> Currently, we decided to focus only for basic RZ/G3L support. So I can me=
rge it into Single function as
> you suggested.
>=20
> >
> > > @@ -184,10 +205,14 @@ static unsigned int
> > > renesas_sdhi_clk_update(struct tmio_mmc_host *host,
> > >
> > >  	clk_set_rate(ref_clk, best_freq);
> > >
> > > -	if (priv->clkh)
> > > +	if (priv->clkh) {
> > > +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> > > +			clkh_shift =3D 1;
> >
> > No, this needs to be handled a bit above where clkh_shift is initially
> > set up, so we have it all in one block.
>=20
> There is a difference here.
>=20
> SDx_Clock (HS clk) Figure 4.4-8 Block Diagram of the Deformed Clock Syste=
m (7) IMCLK =3D SDx_Clock/2
>=20
> SD_Clock  Figure 6.2-2 Functional Diagram of Clock Divider for SD_CLK
>=20
> Currently framework request a clk to set, we set HS clk first, followed b=
y SD_CLK.
>=20
> On RZ/G3L, SD_CLK value is based on internal divider.
>=20
> For HS400 mode, SD_CLK =3D SDx_Clock(HS clk)/2
>=20
> For Non-HS400 mode, SD_CLK =3D SDx_Clock(HS clk)/4
>=20
> I don't find an easy way to move this logic to the above.
>=20
> Please share your thoughts on this.

Gentle ping.

Cheers,
Biju
