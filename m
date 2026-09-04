Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F039936D;
	Fri,  4 Sep 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533233; cv=fail; b=i8gvpnSKNnHb6zud7dWvMURGQeRsu05UQoFhbVT/BMbyzW8OddZGo7tzuGldFOaQPoxFLLv+APw9L4PzqUUh9I2xxwKTcZuCACer8S/LVM5VDV5f36+WSQz/JuOKYwJT+eeQIN8KATUjj5rlF6oWk646m3c4EKfZA2FeeeLfAiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533233; c=relaxed/simple;
	bh=siQpILacM5d3lssEgTJkdJPUcqfS76nD1zaq+gG5XdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ds2fZ8e9vzV11CBA3GS8tlC8TyAzUnrbeZUVtCVWl67saBfaLTRgSoOxvUYv+Fs97sNPJ8bCn4Hm1by3vmQc+AReB2/nH3kRVjVYlEZKm2Ov33Kv1wttT9HnRJ5W2yhw3KrFPPWHDjcTR4g8484RFm1oGn6yACLuuOVqk3rpNT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iXn4vFgs; arc=fail smtp.client-ip=40.107.74.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iXn4vFgs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfKHZTsxxmNDZtzJDtrEhnUj1aFtaqM1ArEGv31j0n6m64/yo7oiI044bji9xy7BDgMnRAkJtabQwnEvTAFrJDAeDM8sIsDBxvtvmIbHA29FHlab3MhSIDBoXGTHzhpxKWi6/rYvlIEj3rkY1BKjyAkzuc674aR9Qcys8drlbYeMuky2zb3ROWsDLNu+/cPXc3xx3pcQEBvIglbVqXc4lZkHqYrd059jEfxgs0fwUXSjxb8HFJx47XZpfETfs3deAycZkRJ8sY6I/u0XRCiv+s9CCoXgsKbtUmyUimvffyoo+72NDnrvvLmlDiBUG/M1iQW+Qz5da0Wy5aN3A/Tylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WanCK+57qcwdmvsue6EltRckUkbTHqCWXddLrZt6Pw=;
 b=p47MJeYTMPqqlFIvHeVyYDNveUOVJFlgtzGNxQr3yKfWZ3rI1DA1pQd5cLOqghe46lZilQtoCDQq7FwHhI24FN43NWIcKybMOWj0f9MRA8NL9EERiUFU05JWJ5y2xPt5vmSm5lNLi17tZAhtSyNA7naHzGUBVKhI1n5Cz7JAiwF7OBkx3qP8ACP5yoIswznsRvYbXabbizLdC6JAYp81JwVX1t5hg2uO8TJTeFMq38nftQbiCpOvu7AvNEWEiv9Y+PiB+pda3XC2uNoCFoLDWhiJ9LvV9q8EpJxq0FkhkSsyV4XHonHiaNccl0A4WszWpCIs7UKqWi6e4yH7n0/gCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WanCK+57qcwdmvsue6EltRckUkbTHqCWXddLrZt6Pw=;
 b=iXn4vFgsB8ay0o7WMP7fw+lvUoL6PUp+NawRLYk3iQBBRCEZO/aD8GXJI2smWjWRkb2FC8JgDpJs3BG2eX15c0O/RYPws7VATa9pxGHSL4QWFKa2GqT1b0rjKDPkVOQ/ow7iqNrItTnlAhKefPxFNkezT73y/DBUYrzepvvhCXo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB13605.jpnprd01.prod.outlook.com (2603:1096:405:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 14:47:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 14:47:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay support for
 RZ/G2L
Thread-Topic: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay support
 for RZ/G2L
Thread-Index: AQHdMMe9/TEErDJ1NE2Te++xaon3+La8rB0AgAHjRRA=
Date: Fri, 4 Sep 2026 14:47:08 +0000
Message-ID:
 <TY3PR01MB113460485B6D3FD62D027C2AA86B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-8-biju.das.jz@bp.renesas.com>
 <apk-J8is9MNm7I2R@shikoro>
In-Reply-To: <apk-J8is9MNm7I2R@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB13605:EE_
x-ms-office365-filtering-correlation-id: 1519bc86-bbc5-474a-799e-08df0a936578
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003;
x-microsoft-antispam-message-info:
 K8zmCrqjA8qrvPmsfgJc1y6Xz83LIocF2j+4jCskLa70896nEqNTOJJMRseHwXcFuEiAf78C4tG/5k+GnePTEFWWbJWyWZWkCJbfYEgJ9pOiHhp5Q1Av3GXDXgKUvJt+fF5p1FKjC+r7YJ5Gt1VcKAx09GpjMPp4Ytbr7Ah2pzBNS0RXFJGj9IjryFFmKnPB8Q5ChX8Vdcjcfko7Ex7GcSVyeFawNVAX/A6PO0nKf8uTbJZaiQ1y+nuHlXAcXlI/BOHo0vCuASUiJyLUFe5/hHBe8UUdOjB5yQfp1eW2fQrQ2zv1mH0woXKjf4oKjJuHyochY02X75QvqEr9Eg4GNiPUyiLwPI6zXv0Rlyp4hPIJNSnZCk455U+ZxRXAs15NzEcJVxk6DRsZHvA/kmEiV6o8NV/o3h09IU0PmEK+gg1oKIB/x7IVDyMKEwnJ6ACLWi6830A6KzRPX+HkusAgZ+1nCMPUuXoughoGP2IfKOZ/tA/f5deQUFozJZgS35KGArEvf5Ntm18AOD+BEWJDYQyLTiSDnAiW8hYvx4oHwaR0Bc0puOOh0g1Udo4rwobO1yRJa2tePf5reMnJDgG1Ym8GpKat6sNHsj8w/AWE1cKCdN2gibhSekUCh1lqP4hy4d9BChutuff0TzlysForB4VIWWHr8cua1u/oUZIt4T9lccwLtLF+kJ7vIAfW3Ck9MljX+q3chZTVXQ268hBs7S+Rj67TuL3z3kQ8p1qG0bs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NEhOVXCSIsLLOakhZ559OhMOJ3U0UxMMG5+/IFdZaYY5dlnQYy/0cN0mVwoS?=
 =?us-ascii?Q?RaJ8ZXAtLFVx5G50Cv70eb1uw7+b5nwvb1nXVVcPTbmzYYX36uK/s+Ag4uNi?=
 =?us-ascii?Q?cMfhTyxOJ0Htf3KNbOIDLry7xoeklDXyaWo26a6ITNQALYkUaLwsp5EUygap?=
 =?us-ascii?Q?TfboTD0gE+4D9m0ZS6TwodzOYZtaaJpf+QbdLOFQZ3XZfKDowjS25aliLZOM?=
 =?us-ascii?Q?gct7R3UPQbttisZcFszqEqM6s6b2aZX0gLv2gnWJMzYRZdtwSY050OOUTWHK?=
 =?us-ascii?Q?yqMgUgCtVZX5m+pWAgEbUOyNWzkuGGC82rwEtyz5nGZOgqaMMLtwjAb2h545?=
 =?us-ascii?Q?IE2edcCfcQRExux4LedxPLUEasOv1m93LN71sG0QCKbBq82VQLzAx35FAOXe?=
 =?us-ascii?Q?Avz2ls/MJrOp+0kMVEeEZA+ZXY1oPUQOTJlG3AE5RtA47c9nyzFayOOu6Zs7?=
 =?us-ascii?Q?1pXn50dXBfgnLLpT8T8e/4mxoUIuEa98M3zurvNXo40rJ3ASLoMCOcrsKfpq?=
 =?us-ascii?Q?aw+DVtG37qhMBU7x4NiTO6XR5ivep/WTuL8mg2hlnnVa9gTb2zkky/TEQtv3?=
 =?us-ascii?Q?PrpR1v8uakQeJwtxaqBG7gQhAy3sGl+o1G66s+4maiGh664H16kvDZziTUJ9?=
 =?us-ascii?Q?GIIdGmge7CH1z77fRoiUrdjqsSdhngHv16reSwRZHgXblt5fM8k4dL1qBaqT?=
 =?us-ascii?Q?nu2KJMzcJyIumRmF9++Q/4gHKi2rKcBEXOJb3Lu368kq6E9nkgAchFqDvUzV?=
 =?us-ascii?Q?s+Dnw7P0vva4Py9piW6a5T1s7WRk4iNBc2/ApBG9g+EsI49Q1Nce5P9FnPYk?=
 =?us-ascii?Q?MC0IOzmzKPrwM77C/RpQi3Fc2Ippij+y0Q5BkeiZg/nDCzLo+QnhbwC98VwW?=
 =?us-ascii?Q?AJeE+s5qM9rPiVXU+/rmGVyWhdNuJfC0DWwXu1oDN7+2OKpCY4+aX6VlB80u?=
 =?us-ascii?Q?zy9Ip5GoKuAF5LI9iDgwdQfKNGJxIXqhlqqkE9qMpWK2hD5eeb9ajgn9/5IP?=
 =?us-ascii?Q?ECuSpQe/Ny7ysgYTV7T01dmwEFJsQ/hSYZlhLPapuQrwAGZbsESSbXH2cxNF?=
 =?us-ascii?Q?myHXkR9nuXj6c1uLoTDfmaZr+3MPO3UabEC/oyzJPqz6ZPdakEpUq9xe111I?=
 =?us-ascii?Q?ct0L7kWDTMffuPynqkmvu4gTDFEUg0YquzkhiJTfALsAaK5/4SziklrQOg8T?=
 =?us-ascii?Q?9UilnOIZY8Q/rNjbqHrlB7pbGRjfbH9vRk8s5k/IN5zHXqz7iIvac8fwbQqd?=
 =?us-ascii?Q?iudbJB3gOTz1LIZ4xKsjigtVi20s5/Nf3ZWcG1tFG0evAB1wqOuoycNPoPqd?=
 =?us-ascii?Q?70PlXYs0H3AzqOMZLk5jKrLZE+l+WKPfIqpe52JVO52XngYZxgLTxRgPS7WX?=
 =?us-ascii?Q?iF5YE7mwKI9Ze3AceL7Y/4gR5E+acjVXucZXjE80i7CVBFozR5PiGgWEEV9l?=
 =?us-ascii?Q?aIEmviO+vxvfvqOQAHwNG8BBSJS4l85DYU7GkHF4tia60++Zxwi2STKRsphf?=
 =?us-ascii?Q?Y9a24JvWCvtqvpWf3zq7wKbsOpvPj6WHaUQRlnOZby1TYbGdApVPdLxvdqGC?=
 =?us-ascii?Q?gKuz9ZqZSHzH+LU8/rhxz6P/raY+uTqrqYzVtURWCBydfTFr80i8z+4YkAgu?=
 =?us-ascii?Q?mDPKZaYuy8+L+7sEbd52/Dh677Dk9Z7S3CkQRSOkZ2DsuyXo7uoYMFa/jC28?=
 =?us-ascii?Q?zFXJdHjxBUutz6rZnCDRvvqzAgvt0mGwFzLJulzDJPoeUcWwPjAUQd3HZSlo?=
 =?us-ascii?Q?85r9CggQgQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1519bc86-bbc5-474a-799e-08df0a936578
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 14:47:08.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUnm6suSVGdW8IunKPST9vBhC3qyydsyWryWr+wHDSbBVqkm7HTvZQBko/hQbm373/HTjvjhimKNrGBRZeMMVZSVeaSJvoZ9lOtBeejMRyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13605

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 03 September 2026 10:30
> Subject: Re: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay suppor=
t for RZ/G2L
>=20
>=20
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] The new function renesas_sdhi_set_hw_adjustment_delay() access=
es SCC registers via
> sd_scc_write32() without checking if priv->scc_ctl is initialized.
> > --
> >
> > --- Patch [7]: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay
> > support for RZ/G2L --- commit 4e31e96fb980d0bb6400d3a60dfcc29dca208dcc
> > Author: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
> >
> > This commit adds hardware adjustment delay support for RZ/G2L SoCs
> > during signal-voltage switch. It introduces the TMIO_MMC_TUNING_DELAY
> > flag and applies a delay by writing to SCC_TMPPORT2 based on the regula=
tor voltage.
> >
> > > diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> > > b/drivers/mmc/host/renesas_sdhi_core.c
> > > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > [ ... ]
> > > @@ -350,6 +316,55 @@ static inline void sd_scc_write32(struct tmio_mm=
c_host *host,
> > >  	writel(val, priv->scc_ctl + (addr << host->bus_shift));  }
> > >
> > > +static void renesas_sdhi_set_hw_adjustment_delay(struct
> > > +tmio_mmc_host *host) {
> > > +	struct renesas_sdhi *priv =3D host_to_priv(host);
> > > +
> > > +	if (!(host->pdata->flags & TMIO_MMC_TUNING_DELAY))
> > > +		return;

This check is available only for RZ/G2L+ SoCs.

> > > +
> > > +	if (host->mmc->ios.signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330)
> > > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
> > > +	else
> > > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
> >
> > [Severity: High]
> > Is it possible for priv->scc_ctl to be NULL here?

This issue can happen only if there is a severe memory corruption in the sy=
stem during boot.

> >
> > If an incorrect device tree binding or a hardware fault causes the
> > controller to report a version older than SDHI_VER_GEN2_SDR104,
> > priv->scc_ctl might not be mapped during probe.

I agree if there is a memory corruption, any check can lead to
Unpredictable result.

> >
> > However, renesas_sdhi_start_signal_voltage_switch() is registered
> > based on TMIO_MMC_MIN_RCAR2 and calls this new function, which writes
> > directly to the SCC register via sd_scc_write32().
> >
> > Could this cause a NULL pointer dereference during card insertion?

This can happen only if there is a memory corruption, in that case the belo=
w check
passes for all the SoCs.

if (!(host->pdata->flags & TMIO_MMC_TUNING_DELAY))
		return;

>=20
> I agree. We should ensure in probe() that either
>=20
> a) TMIO_MMC_TUNING_DELAY has a valid SCC or bail out otherwise
>=20
> or
>=20
> b) clear the TMIO_MMC_TUNING_DELAY flag if there is no SCC present
>=20
> What do you think?

I agree, we can add defensive check in probe().

TBH, I am not convinced with Sashiko report here, but please recheck my com=
ments
and provide feedback

Or

I may be completely wrong, please correct me in that case.


Cheers,
Biju

