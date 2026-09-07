Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979340BCD1;
	Mon,  7 Sep 2026 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765588; cv=fail; b=fbQ9IO8fFvODAJ9WKl41MukGP+eu+rKYtjfNTHXFxiHm8P3N/iWQrj9iHbQLs8rGcVPVrvFDfYLYOtHAVUaRBMtX/IcAVakfoMtvDIm0VSsFbwvskHogA1FdflA4kW/lyejcqEaJgbC51YSX1ReAO26Vs06fVG5kssO+zeE30BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765588; c=relaxed/simple;
	bh=rL6TF5VEejilD7/OkVKCTvWUgUmOxoHkEh0vNv2qht4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XgTB1rR8rblLiBdub7Kk+O7WPqqLQtu2N3NMWUFsDa5yTeoPdqAkfVF/12fonU5nRzvi5Mjx25nzCI7yl3xBSPMShhyce5Y4vcY6YXu8A819ajMIVnnSJRbx5yZ2l2sCIjL+OAS9svAvVpNzciP6s3phLByaU9xQMFWMcNX0I0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=G6s5vSc9; arc=fail smtp.client-ip=52.101.125.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="G6s5vSc9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtWlei4rgdtACICtQb5SL0BvyHK0edgSVMJGOCEj3+XYeTf3VopZNdhcBhjO+PXJ5LDCRIXl2CyZm6uWpinv00x2xy/niuKu2VoZ/K+PU+8kfM5UPOG7BC61PrfnNqZiAT50uKcdU5lVFLduhPXqBTfmfvVVjFWWdeIspT7nSdkW86idfXyt9zQsI4E8a6swuYej4y2f/kB/NGV4S/jXZFdYdLpX0H2yiQ3AbLH/3SrJ7Dz64JzP6A5ZKknHE4ClYVS+cXHHMn5LnWgYXNvfHRUxLvvwZDc07IFR0z//GRA4JQ/Mmaj863KiJeIBA92y9l35ecynfSjSTg5bqIzLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLDce5wvEXRVGYaDIZaSKnVaczEwxM2I2YiKzQa5GBQ=;
 b=QTPsomOGwHxdVvfF7x7IZUR1vxt9m6OBpvIaan5NhEFPyVo6aMitT7aQWiEJDFQimOgHHW5k5S2MtIFpdw78jv5QJyTSiLBGErxjVOcskhsi4AE5QTRJvg3qz6+RaUfBFPT4d0gMpvhpUijiof3rLJIudl3Vns+hEvTbZ3kr8XXYOW0SnpO5mISTnL6Alw4KeLP3d0zi5Ggmf/KEmZw4jexE3jsA2hAVCzUUnyRSG1FHfZ+AnqFo4iGRKGsfa6oe/XAFkpVdmUCf//QD4Nzl4ap4p/Xl0/z/4mJFtmjO2ob6T6h9ebNen6CHpWpUcLfFyR1rFNRylWOrkb/hU2/0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLDce5wvEXRVGYaDIZaSKnVaczEwxM2I2YiKzQa5GBQ=;
 b=G6s5vSc9xQP/tFF3DIJhx6hGJGCKFnR7SHWnOmmlYKfK44W3wJhfwoIoyb8lJgrP/4FnW9ERbH/uje2dggHRsn5w4jmHklNls3PnIq9dFMnzjhbzii8mLRgWXHpzJVmtpOUpC8nUh7vdTDzO+f++HoZ8IgFGc6j0eXnZVumZT2w=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11898.jpnprd01.prod.outlook.com (2603:1096:400:3e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 07:19:43 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 07:19:43 +0000
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
Thread-Index: AQHdMMe+SeXRDHnYx0S0S9Te31Iesba8r9cAgAYcQRA=
Date: Mon, 7 Sep 2026 07:19:43 +0000
Message-ID:
 <TY3PR01MB1134610EEF7D300BA8890357A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
 <aplBTMnnF1V71BDL@shikoro>
In-Reply-To: <aplBTMnnF1V71BDL@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11898:EE_
x-ms-office365-filtering-correlation-id: a6fbdd72-5230-4899-b7d3-08df0cb0639a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 mtZwgnnkgIM5v/4r4GX3YxPph4fbQEl/mib7POv8sG50vMoD5+iqNh2dVSFWaJHs005JQlekycwKf3mF6LV6k4RcnDFXLBwFwwlsmGS9UWhFuN1fTHAGdbqrNpyyt8rPpG6tDSJrSVHV438Lvn3fQbuJ0O0ibPTttxRxhCSx3Zk0NUFwamn1XEYGUCNyBpRi2zk9NjZt69nzmAMld5aI11c02qKTbnfyt7moAQ4MQ81oRClGMv1C9t9HHk87hshOLLymLBg6O6eUJZtX5/txH1d7kaRL24PD6flGwqY91b89UJzJWA8mpuzMI21VaL+RqS8JowLkAlH4MQ5XCRwp4ycD0p/G//afZGgbuRJakFTHzzh6pXWz7EJ/LYQVjaAHArpo9UNvEfIuRP4JCWI1I8NKLrUOQuPRYAdTaFt9zBSooD+u31fIIH239GtslkD7lDtQzlos6z7xVPI8AXRYaN6FYgNtwnaxuDkUewfNhRB3++WXP0ffcp1MHB86cOakYxO0UNo6eYD+RDujy9zO3h+v5EWcDaGMM+UTX/XQRNbxOIm7W25q69IxPdqEy1hm8oNWrMSykQIRKNKZ5Tj1GQFEecqLL63hR8lZ6P0fvTdKGJGiWwKYFixLp7/rCFQo4EU/g6vrqWzs0qHZ0dp3NpQZW1an3puVfyXDMRxtVHcCMkSeurpJcQPLHwmkiDeqkd5zY0Sa/IVTaAsLQaxmhikEaZEoFJ0lMa5eqlI9SDg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PKZmXIYt/7HleQTAlXV/6AcZRZFJUC2dSHFehdvgfjGjJzqQ/0K0ijIhfqRU?=
 =?us-ascii?Q?dx0FWY6BTSzEMbTwIQLcHCMD6tdIVB/X/ok6D3WQ9pTjZCvGmu4GfmHXBVO5?=
 =?us-ascii?Q?exJJBFHP0LFfkW23XCjP3cbJCiPYllgEQoee1XiOHsDePwpBlX4obkETyBVb?=
 =?us-ascii?Q?Ar0PEl3JAWMzGz4J61smTwTgYgdnF1SVJ5UF3zUoknYuKxP3EWY5Wjo8QtTN?=
 =?us-ascii?Q?toVvx/uP2kwOBVvzptjb1v9YTlBYqKMIbc2BY6ADkCaOZ9urVCcOGNizpPVd?=
 =?us-ascii?Q?SjYZh0LzNL/rsdTfNRCVN2tHnHDgjI2eQZgy8ohyU1UmvF5Jp63a5u3GhKvC?=
 =?us-ascii?Q?TzOcK7by/r9JnXq74Btw3NFNOGc12tp20W9XQZAqiVUb+3q5nyEDuDmCt/47?=
 =?us-ascii?Q?B7GDRrdW4SQ5UdidGTIpIse3PaDv3bYFaeOrENmRhaw0Xq8NAz3FGOYdanc6?=
 =?us-ascii?Q?PSZYXCgCX8u3YYB76syzPhFwkLp86IfZNEGj4vFz6lQVuCeweaH9FLnW6XQ6?=
 =?us-ascii?Q?NAAV1OD4ng3iFZOGIhb8JW0WT2MXy/POEXa9S8O3gkCNS34EEo314v6gtkLz?=
 =?us-ascii?Q?OQB4NxkHKKX5vEoGrUXq9nthocUixVFjGUxCVm/c32CMnpPZWBGigD7EEyTl?=
 =?us-ascii?Q?giH4JR7ONXiDsbjAu7GBrY2gGfH3JRpXkLY/V3VXv64iNsU++naRJt7fk7jJ?=
 =?us-ascii?Q?tBT4IqPvsXQctLpy9YWw4tfwCG4W+7/F9GkrBo/n8sQwazQHOWD1mqiGd7j2?=
 =?us-ascii?Q?SpiQKzb6qM+OLk4Ndejg3qmK1eKK/2w5ye0RxwMhbxvoUbkfXeSLDhXEmxaS?=
 =?us-ascii?Q?C1bnJYhT5me9rDpOM/Ifczv7XryznP1l1HXx9mRnaXFM8w9xhbOk5rWQJOy6?=
 =?us-ascii?Q?WDqPi4QCSOHOALoTuZiUVDNc6z2+8Z/dYIgzJ4U0lw2+cHHWJ8ktZlMHYu01?=
 =?us-ascii?Q?IqtogGpaWoeNvazU80dtqFDa+Xk87tlVCA1jTvfaLqGwaNav8FGtTyjn+Ak7?=
 =?us-ascii?Q?FB16aY1EmfXWk8tHh5RcWtpCm1MyhGsk+6ERT4JBMBbEio24brK+b03FXfUs?=
 =?us-ascii?Q?H2xqVRFdcvN9v/EDvtDSseubLMrXLsWhhwtwBcRVNA0Sj3/sgPNphP1Xe3QN?=
 =?us-ascii?Q?3DoheH8fg2Bj1zvvVj+xWtlwI2NwmFQHAEBF60NSRBIpnpFTXB1Y8ECEOvaP?=
 =?us-ascii?Q?BLGb2XH2EG5eXLppN4CUm7VqqxWmZ0PbGGuX3lSnUK3EZcDgWgqfkAGIon8C?=
 =?us-ascii?Q?gobhLbXRGBHpJTR4ZENF75xCmt3QViztv5UmYaxYEDs7+lQoFr+P7IEPdLJI?=
 =?us-ascii?Q?yiwMjfXApQ+MSwtvGO4t+8lkClXe1r8HleEIBNcxdS39tQkOO5woWIwqsGOU?=
 =?us-ascii?Q?kYnMt18wfSzudYVR0So3wT5RPdDtC/d8d0DHAMq3CX87mLr0d/nao4+c7FlD?=
 =?us-ascii?Q?a0ZepzvTCcd9lVZ60C1vfXdj0wUcx9AqW5NZ/PVSLx4lXXYCgr/Bd03ciJVk?=
 =?us-ascii?Q?jCr4ZF8Ok/5o4nQBPvAqH5Bugxpzzh/+YWX63LBuOtjYlpvVMbpJXoebql4c?=
 =?us-ascii?Q?JR4iWGCdTQJkWiIctPNmQrd4J7gzNyhOG5nLk/Juuxv4SPigxoYF+ijQ8Zg9?=
 =?us-ascii?Q?uQbGUfhsA4IS38NcDwhOkR1WK6d4mJUBC250JPhyB1A2gN9V60A/BinWQb/q?=
 =?us-ascii?Q?KG/YnVGJWBDrPzrnkRyYx/WXRDO2bV7p80JPQSpYW1mbEGZ762h7Jls3ukue?=
 =?us-ascii?Q?1CBpwbdybw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fbdd72-5230-4899-b7d3-08df0cb0639a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 07:19:43.4417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIFmRwbcWR8itOsSTCP5zQ6c5XWUHFTfPt2h8WWmoNpPBNwcQ1gtFO+WxZ6ojUR0bHsjmztL2ruoz8PiJUHLJMz8wd7Gfrrl+rgdFHObLhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11898

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 03 September 2026 10:44
> Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_D=
IVIDER flag
>=20
>=20
> > +static bool renesas_sdhi_is_internal_divider_enabled(struct
> > +tmio_mmc_host *host) {
> > +	bool enable =3D false;
> > +
> > +	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> > +		enable =3D true;
> > +
> > +	return enable;
> > +}
> > +
> > +static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *ho=
st,
> > +					      struct clk *clk)
> > +{
> > +	unsigned int freq =3D clk_get_rate(clk);
> > +
> > +	if (renesas_sdhi_is_internal_divider_enabled(host))
> > +		freq /=3D 2;
> > +
> > +	return freq;
> > +}
>=20
> ???
>=20
> static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *host,
> 					      struct clk *clk)
> {
> 	unsigned int freq =3D clk_get_rate(clk);
>=20
> 	return host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER ? freq / 2 : freq;=
 }
>=20
> Was this AI generated?

I kept 2 function as renesas_sdhi_is_internal_divider_enabled() is reused i=
n
renesas_sdhi_set_clock()while adding support for HS400 mode.

Currently, we decided to focus only for basic RZ/G3L support. So I can merg=
e it into
Single function as you suggested.

>=20
> > @@ -184,10 +205,14 @@ static unsigned int
> > renesas_sdhi_clk_update(struct tmio_mmc_host *host,
> >
> >  	clk_set_rate(ref_clk, best_freq);
> >
> > -	if (priv->clkh)
> > +	if (priv->clkh) {
> > +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> > +			clkh_shift =3D 1;
>=20
> No, this needs to be handled a bit above where clkh_shift is initially se=
t up, so we have it all in one
> block.

There is a difference here.

SDx_Clock (HS clk) Figure 4.4-8 Block Diagram of the Deformed Clock System =
(7)
IMCLK =3D SDx_Clock/2

SD_Clock  Figure 6.2-2 Functional Diagram of Clock Divider for SD_CLK

Currently framework request a clk to set, we set HS clk first, followed by
SD_CLK.

On RZ/G3L, SD_CLK value is based on internal divider.

For HS400 mode, SD_CLK =3D SDx_Clock(HS clk)/2

For Non-HS400 mode, SD_CLK =3D SDx_Clock(HS clk)/4

I don't find an easy way to move this logic to the above.

Please share your thoughts on this.

Cheers,
Biju
