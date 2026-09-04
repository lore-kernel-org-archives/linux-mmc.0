Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010045.outbound.protection.outlook.com [52.101.229.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E23905F5;
	Fri,  4 Sep 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534910; cv=fail; b=gXmzteyuXeixvYwYZJWbhwfpSei1FX+YXS/z5bVC4Oh7yjOY298h8uw1npdJSmSO/T/Lgj4CQkujwfRg4VdTwdHjA9WFH5JmrFEoBEFIDC+ustRI3n7otbkzAokXRbXtBzaqBFpYs/LYfvjldaTTuQQKVlFwM5dnSVbLKPJHqDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534910; c=relaxed/simple;
	bh=P2D6yj5YDJA7DamODZpZ1XT30/dItEBxZSKpcXgTiO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1vELciUhOaasyHSKuF6GYTUGczdu+CzpJjjGQfqA5ppgHGMeAsTR87qEuOSCN6e5rUuuNARaS61jaVBDrb754jBckSH5F3h1FIB+f1lOAt+TedOrTPsfduQqLfmMJGqZnI91yagHwVuDiLj2FXSL2jMvuBOmWL3CPIEMA/paPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ap/9LU7m; arc=fail smtp.client-ip=52.101.229.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ap/9LU7m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcEPRoS9LZ5QU4qo0VP0M1dzjpiYkbsmigpzdRXKFiP2UTJJxFgPajRvnrmJzSd29uWwaRbsXreGx2mPKMwlIsQ82+i/NvVf5OuEjN1lgDgLKOMSUZ0mtWt9a9u9C2UkDaCDnjZW4/DZ8mN1gzHfreObHZe1KaFKLP8TrYftIrCSjUMf66xzmsIRz4r2oC+weiH3cIgZDMkdrKPshvhedG2cJW/i2U+STynDbTaiEPnGpulH1fp3gdEQvvEMvEjGDw4Vh/Z0LdmDiw0an8+peerAJDDKFBozea5ohvxjqws+blJ7PgdQHmZba+qfvjwEJFEEDvHDaC64C+/VqnsoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quOz0dLyxPUJVdemGoYNf5DefWnwkGnZ6FCxVp9fEzo=;
 b=IHeqNuM7z+RzA9J0LbfyP6bLB6cFkBGYb1h3SfK686TbdcbNJd0k2xx1C4mOl49gSCNFWrAxbaSGwmGczNjBBuxXarZVtqDHbhxJuqV3S7ocBcxHNRjf1trYfk3Z3Ty2K+nGuEkK6RudHzE0d9NYu6fUce1ZgMAchooxNLcaASKZRSU8iYAXkSfvdsA83sdl2EcyobSgeuHP8clvWZmPa6sWUeeDdAdZ9gjOGFxW9m+x3tpW21bpI9b5IufBASjHH4Kcu1ZtnSFu6+oJcnnq4ovBNU9/JfXBHNQbhyQrZTkfRU/gswc80JH4UZjxz1gndNgEynIRt1STZ+jHpyL5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quOz0dLyxPUJVdemGoYNf5DefWnwkGnZ6FCxVp9fEzo=;
 b=ap/9LU7mLBwIy+hEe7bufULfD7PmTL1mNZM6it+fbD+JasQVWgJDg8p0/t0MSHhfOYU3kVdpBjSXj5wJrZ87Owh+HVYDeGU5KDjVIcdzFH7icd7/mO4qydrhGPiahYsB8/703M9Ajmi/czWzjGGeyjs6WeqY/U2ezyXyNEhwGZA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB8015.jpnprd01.prod.outlook.com (2603:1096:400:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:15:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 15:15:04 +0000
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
Thread-Index: AQHdMMe9/TEErDJ1NE2Te++xaon3+La8rTEAgAHxL9A=
Date: Fri, 4 Sep 2026 15:15:04 +0000
Message-ID:
 <TY3PR01MB113469D4CD9BCCB14336BD15386B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-8-biju.das.jz@bp.renesas.com>
 <apk_FKZDZ-zlov69@shikoro>
In-Reply-To: <apk_FKZDZ-zlov69@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB8015:EE_
x-ms-office365-filtering-correlation-id: 06bbd0e7-5313-49dd-28b4-08df0a974c6b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|11063799006|4143699003|10067099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 +kQhFFWdT4ktUM3Jq3Oma36S+ip95TSm8CepIzrFpkBIrFRJc60B0YE5B1RsgNB6357CDBoass9WmMzMTiQFCCyEPt9DHPvy+XGZOBejN6q4EbLsIQKkdeggsI+bam1eqZ8m4WaxPstXtpXXB3O2wtKXsPz/O7W2Hq7ROUXpvMbZyQ7YBE3gIavNbSwAFgcSnMz0JNL72ay3bAxRPaQ6p9KhP0KlZshRZCxF7h4NjKUa80WxYfp6B7OoWQJ+meiUDptLAbihysJiw/sQhaln0h5KE9vGBGOvNMs0XpP0RMHUEEdHfv8m4skde/4neuIWG6uEW5mRptjgfmOSP/xFrR4MNO45nVqtHUsFBxhyz3FvVF1ES/7/lOvOrxzsyk0uS24qvKplHVxl83ZM/UAulMRGNGiA5vBsV0Vp3ysNnQuwOWRq8wqBhL4upYWFyEDhI+TSvsF1ewtl6tx/O6u1yTxyHWgrqLCMXSyLq+b66J78h0+2houxg7w/xVRhwWtW7VgjdgPRSfL+ZZzeB51HPyt8GOThWsjaz229MY07RMdEb2bh5tjwiIbvknfxPPScRZSgBjWm1nupziGuyuQ3y4tumwBNlC7h2YFwR8RWhNbzRixnc85BVJZno4kiY0hnEi+mEynVmKx20DjOabPlMC156BgtugAa/e2CpS447IVCf6jOJx+qsxpKo5+YyT/X8g+xJpBlTHv4AEcktqSg6w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w8YvN+4oO1AaiT/yv9mnzS5O0Q/eoHC/iyKlhJI4Ar3pqMoWr+/3CzqqonL3?=
 =?us-ascii?Q?96+33CflpuY+pR9yDrZuOREwaQ2aPAxGwkG+I0xnAWcWQY7cTztwUJMp5Ltw?=
 =?us-ascii?Q?EnA4WHamIFwiwvo9nMPYmWcsARE4i/XHqV3OsSt5msBM3dBfM8YIoePjpBN4?=
 =?us-ascii?Q?znPM8xrpTaU/xfM/SdxZctSMRy9Rxf4q+YZqDeEp0SGwyiR1oeiW3UVYUEMY?=
 =?us-ascii?Q?d+bl12s9nV6Z6TPmOcC1bMouWOwCufR7vogAV/Bw1JXfcpembEX768YMkfJr?=
 =?us-ascii?Q?iJ/JPTAlo1AM5xnr5IyNXVhG4w0CB6mewfo54Ealw6OFzZBq6AoobTdNGbPr?=
 =?us-ascii?Q?qxm6Ek4cQm+V6YEssxZ8fFeT1D3rK3YSTVou024T+XNzzBobMCbQodcJPEe0?=
 =?us-ascii?Q?WNGpW64aK0F35bGyP5qTfq0cRi3FBRepM760Fr4hR3vG11H2HURJPKL0xBfk?=
 =?us-ascii?Q?LSgLJ3IyJ2d8hzXaxxAMNC40r4PApTK6tpLNJzoA+UByWGk1aeaBAzDvtcRR?=
 =?us-ascii?Q?yPTwAkp/v5ZebFYljVLTGyUEKJrvfpCzYRN2MHgODfYVAAggNaMclRuVyn7T?=
 =?us-ascii?Q?dRRvQRK72Joh5chiuA7MTZ4EKzUS1CQsnjN8tb/KFZHvYDBLtxrkx+7zSudU?=
 =?us-ascii?Q?3QBJgVS33u+k1JS9ecx763jQokM6aVWs5HBVLgxh1TGOJcPIZICb67YjvQWl?=
 =?us-ascii?Q?i6Q7U34V+yWBO66kiAwoyWELqAeflB/Dkv2j3ueUKI5hF/uxwQOqjRctgjLK?=
 =?us-ascii?Q?yCI6G56EL0gKXsnRtiQ+MYXNmxbl9+RZOnhYw2FwpRRDl+RZTHz5ZYh+ZPVi?=
 =?us-ascii?Q?xCEm0pK+Q1zUrh50LixqUWnIPsU8y8f05SXr5WtZghLgzbGA+RhAFRH7muvT?=
 =?us-ascii?Q?nA23xHHkd3y6aFS58ThNCcsbMV2UroE3fzJOu8vzeY4UHgn/myavchTxCNNV?=
 =?us-ascii?Q?wi+rlwfb3oslvPr2lfqmsPGR3KI9py5zowfsGLiN4fGo/jLOqMt1URONcL5r?=
 =?us-ascii?Q?wRD6V+j9/dW+G1H24ebOISrm3SF0LYCbxJWoeD202nBz612tqc2QyQydQbpZ?=
 =?us-ascii?Q?2SJdLhzcqLMnxXyvi2PIXxRoDRKOvBIzW6uiD//w+Z/InRH/BmWvt9+jYR5t?=
 =?us-ascii?Q?EhBfYgasCPcIqb8BU0ngrvjEdPPwi2QyUztKJzoTvkJMy+Rzs2XwJNlm0LTU?=
 =?us-ascii?Q?zxcD4ga27E52WG5QzeQxG62YZ0uup1gNJ3d0Ua4iv1GuyqOYpxWqBbxNW35K?=
 =?us-ascii?Q?zODYtvQTIWmisg3ujfzYCAzSbGL2orX7d9ZIaVScBozIYgzT5BRnzEgbb2vt?=
 =?us-ascii?Q?9jONJYH8QybFIs7H2+yio8D2uqwARI/j0d9GxM30cQ0od9NQwVHm0H409l/D?=
 =?us-ascii?Q?EegmcfoX9t77ebz1tHs2dtdsq3cVOZXce8jR1jCFIn0cyT5pFvLcCni4lcbB?=
 =?us-ascii?Q?CitJPPLQ2jpVjojeiSe5PmQJyQ/l/cyWe5PxS5unxNSdqwLVtLxEpX859evx?=
 =?us-ascii?Q?wn/Sj9GIIuQ/bCO3TjaVUqmml3fH8ADnHWOpeEw7zbh2Ofg7W5/C2YsrLq26?=
 =?us-ascii?Q?8ifzVGgemqxKgfBkSbjOO1lL4Zje5uCxQQWGp+cTLCy2xDazTPRTXiUaNYJH?=
 =?us-ascii?Q?oTH0cq+sP9xLiKqXQtTBNO23eG7WGUa+gsMCP3+XYgNyzrswWrMd69n42BdP?=
 =?us-ascii?Q?MGL9S7+4PRCAMSIv+ugLJ/HPF6gvfKa6qBa9jkegWtYx8IPRWcHhwC3tyVWE?=
 =?us-ascii?Q?xIXi9yofDQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bbd0e7-5313-49dd-28b4-08df0a974c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 15:15:04.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BZhE4/4/bEy3nOLBNdUu3wtLXZQW2o8aVskWDIwhyOjmmkoYzCphKl8uQYCOs88HwgxNlmNEN4HRQe9j+kXAFxkqlkgVyb8G+ZMIWl93M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8015

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 03 September 2026 10:34
> Subject: Re: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay suppor=
t for RZ/G2L
>=20
>=20
> This might be over-engineering a bit, but let's discuss:

Ok

>=20
> > +static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host
> > +*host)
>=20
> How about adding a 'bool force_clear' parameter here...

Ok.

>=20
> > +{
> > +	struct renesas_sdhi *priv =3D host_to_priv(host);
> > +
> > +	if (!(host->pdata->flags & TMIO_MMC_TUNING_DELAY))
> > +		return;
> > +
> > +	if (host->mmc->ios.signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330)
>=20
> add '|| force_clear' here ...

Ok.

>=20
> > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
> > +	else
> > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1); }
>=20
> ...
>=20
> > +	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num =3D=
=3D 8)
> > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0);
>=20
> and simplify this to
>=20
> 	/* add comment why on tap_num =3D=3D 8 */
> 	if (priv->tap_num =3D=3D 8)
> 		renesas_sdhi_set_hw_adjustment_delay(host, true);

Ok.

>=20
> ?
>=20
> The other call to renesas_sdhi_set_hw_adjustment_delay needs the bool par=
ameter 'false' then, of course.
>=20
> What do you think? Rest looks good.

I agree, it simplifies the code.

Cheers,
Biju

