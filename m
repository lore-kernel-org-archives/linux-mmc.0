Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793026039;
	b=WeUAEJk8JAzFmKyLJ7XOMrxCPJG2IfBDuKgVIvU924h/0lFkkyD6UJplZ33QDdX9TPp+
	 2zX7DnQkhWr4cFbvUM91t37AbyQp1if6AwhyWiPOmpzVVii8TgGSn5MywUv58m1Sw3pP8
	 9tjbL+H6wllx8GzwoZ3ylYxcr44FWH9IYKnAPvKURjPoIT4qyc31g/SqW9WIhNxVBTbHu
	 3vF9E7gIfPRjGfzWlNXNsIxYWYvHV0/HMERmqJIZ+mKshaY778T1+5pGsiX03UbB5rnKL
	 znV2JiFUtjCSHet+Ye9jTIEe/JZXo/qPWNR6VgmdJHAxC4/pjSrPkYK5BAWmF/BWXQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026039;
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
	bh=vL29af336ly+AU1/xzKVr+CF/eFwzM7MPXfFxPfl198=;
	b=0StCXS/Mnlz31Pxt+opi11K3uhNa22y/ftrw0wPpQED7W7ZfkPiNZb0UGuh3BknNDPKy
	 KNT0axIjBBZ9lne8uY9WpGTjiRd++AxoMrGvWnZ2cPpKPynED5RYjk5/gmw11rLQxzNql
	 4fpmb1bhncDoSVyjGzEU9IVmzkv/DtzsSQPv2FqL84sIJt16RGGaSCOtmYva5tvUBJLaT
	 lVRbZ/XgMBOs840aybCRIujg27iyGtHYFWo/x14xGpcv8jjXc4TrJTbnaIPPAET/Mms0c
	 enRdsPT5myP+LtTRqB59volP2n7ll65RNlv/42MwzgCf32REFKvz8NipC468Q/0TU6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=wiRhtu1M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.11
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011011.outbound.protection.outlook.com [52.101.125.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEBA606A31A;
	Mon, 26 Oct 2026 14:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FEBA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=wiRhtu1M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeiQRqiuxv9ecnQi/B9jdM5iHHgkCQtU+5kxGU4PCatD21vgAulOAx0F1b0+SdilMzmIFB2vn86zJFxG7D05keWx+xMq3BcRNgGf3H/cPwtHr6L8tSxWscRXib7Olo3dqfV9Ertwr1TELkUqdO/bMpXDcp2YOwEhAdWf0R3gZXa2bH8B2lx3NARQgyzTs4RdV292ERb7OwUvfFj+XM4RAG1RNHIZku/oMgJerF0XkTq1p/wkpzc6nFtAUa7qeF9Y1SooZLrIewl/q8tu1373nn2GHHVfdbHy9uLjpIjH3imWUApOgeDxX5gKUspVukNhF15OGrOt1YI4SVHcImvecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL29af336ly+AU1/xzKVr+CF/eFwzM7MPXfFxPfl198=;
 b=yNyJmVuNePEZoqKJEylXDKzg85R1/qwgujY7oNqwsLQM6Eo8fqkq1pq3Rmgx3fUkF7MCVrM7/5UTkSJQIoWnf09MwMePd1+BGIVzai+j8tiKsVhHv/lfyt7dQ0vI5zxMClHSrH3GGaDaaM42LXDcc+XFRIbCuyzBrGsg/6BAGECw6H6Wuo/2WwLl1eYho7gui7tMc4hbrJ7yYcqn6z5y24FtAYp3sh39Ukk53tb7SIXLAPLFCM5zwxPMEPHP7M+3rR3zn0ecXAk55MYUTlDJoWU0UNghUXh1YAh8E1I5dhRTVkz0hFhmkXrVHgmjP7j79Fw9IiaTUrWL2SB2L5h/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL29af336ly+AU1/xzKVr+CF/eFwzM7MPXfFxPfl198=;
 b=wiRhtu1M4Hm9B4pq2E1s0diucjVQI4Ce2Mg4eshwcu/C9XFf3OZAhc5X2fzE408tG0AS3D5QiGjnQIMjxuEdn4I95XIAgF4g1cKgPix+X6szb4pVfUZUf0jrG415hSxEZakUauioMVTiUADUBJIQuyX6CZlBIFkUlb6r6FkxZkk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB13925.jpnprd01.prod.outlook.com (2603:1096:405:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 14:47:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 14:47:14 +0000
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
Thread-Index:
 AQHdMMe+SeXRDHnYx0S0S9Te31Iesba8r9cAgAYcQRCARuJrgIAB1J4wgAAtTwCABJ9cUA==
Date: Mon, 26 Oct 2026 14:47:14 +0000
Message-ID:
 <TY3PR01MB11346FB03C32BA66FAB258F7086612@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
 <aplBTMnnF1V71BDL@shikoro>
 <TY3PR01MB1134610EEF7D300BA8890357A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <atnXz00Hci6R-7Ux@shikoro>
 <TY3PR01MB11346D961A1F5ACA688B78E3886642@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <atuG7A2N4GChkQU1@shikoro>
In-Reply-To: <atuG7A2N4GChkQU1@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB13925:EE_
x-ms-office365-filtering-correlation-id: 333bfebb-8eff-41ee-4ac6-08df3370068d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|11063799006|4143699003|56012099006|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|261026140227099002|261026121527099002;
x-microsoft-antispam-message-info:
 6gHpyRsSYmWQtl/+SQgkXkTq941xUSf7s4O1GEdiKUD4IqNtj60nDXpq2kSgrk/4vRU3OuITPFn1pnQ+Bfkfoh497c86c+lC/ATEl2wrhtktGnRig9mHr/e1mjORhEDEOM4V2v3Cjc4fVLu0AyU5lRZ2v7TykrOSIeXcRDPNfJkkVef20i+mQ/DvrMIG1ADTuo5eqo9MVb2RofH5zFEyu6KDlTMLbML9OmHCl9jehrhlC6GnJRrE9izQnkxwHiv2n0bqZXqbRTHGAAO3Xv3uOc0NhwtHs83C3ICvVH2WvefIdDPNrRSx5gDUwaX2xCXsMRxJrftbmagi4+83PEVU5ImE3WNzBl4MnXZ/P1QavQhPS7y30jG4p7G9ODsE/WmUzA5Ej56Derg7GeOThrW/lzwx7pXmmZZ46cr3T7XA7OTbXKgn88RjKEpdQd+LZTBQ+kcvBCyzgRu5vZOAoaehCZ5jzQMvJ2JPg6icByWrFDgmM70gd8P/5AU2WvqN75xWWG816z7OCZaFz3cMIAOUzBoxm4u13nJB4AANH8aQ5E17kao1rl4dHRV98x06aZHk9vGblDPn/s2de0Z5R+wR9qnfMaHvVBNiQvA7EWDQxV5wOqD14DGozskLpo4wTbQHjVndl75ow9yOtr7RkQ7R0JSARcRnvK80PLiod9orgylPBfpQ20U274Pes76oIS3RDe0Tj8qS652NMh9fCEFd2hu4A++orB1f54GQSTMIbSE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(261026140227099002)(261026121527099002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GNFSFDbfCQkUGeYYiaddyhhJ20dwYHyLlcXR4xz4r77Sqlg24lOPOEQ/z2Fh?=
 =?us-ascii?Q?vlWskL+OTiNIzH7QC28Qe5RpeFiE7CCHXNqAWrM5fKl9LrFy4x1MKEVWR7bz?=
 =?us-ascii?Q?g9jTMnH/D8e+Ced7MCBKKC0vffV/qgbXhWi0UL8sySKbPurvhtC14swQOvGF?=
 =?us-ascii?Q?aTTQS5QqxCzM2XUxGTQdF14VlZkObzTIiwJPBjKKkhxcEldoN4nDASXFtoXe?=
 =?us-ascii?Q?wMi1UDz/Frh+CdumTHo+dJ/zeB9Ti8i/xRkAqhzE307elVzIGd1UwW5MIgnA?=
 =?us-ascii?Q?En6QlpQzAd7KbxtuIagLQphjA58FI5JQDsqEKaBhuWf6X6r9BEW47CU5h3sX?=
 =?us-ascii?Q?0ZadoGi5SAIBbXVJz6/17r5BwxE3bv9satA24ORhGJlrMvkjKj2HlsDVymtg?=
 =?us-ascii?Q?SPmMelQWMx48acIzcVv7cPCrKrc0ujOOC4V8gYONbk+9bDWikPlZHNIOs4tb?=
 =?us-ascii?Q?Yrx8iJRTQAe6k7xk+6G7Sq9Rj0XyRJzwOIeSkUYZ7acRPtNZe3gNGe+YY0VS?=
 =?us-ascii?Q?dWJfxmofo2ykez34tCvzDBQ0HJt/kYwurG2BTgtMaqIf7dqn8ZXmbq+cfPrm?=
 =?us-ascii?Q?v2GNMhX36cdHqLCMaV5fwez3CNRb1ZuvBlktshjKOkRxkLLkNgCc6Utymlnb?=
 =?us-ascii?Q?V3wWPUvNORJxaVwZTaGYztryuzaqNVUgJs/LwoEDBfThiyg+qtf/ss/HKmLP?=
 =?us-ascii?Q?+IQTpDdM3KvSwdHRwGfaafm2pewIj95ubGdGAmS4+7oEHnTW/8juysyHt6mp?=
 =?us-ascii?Q?zm+KTBy3wz5n80LECMYsjXYYk/eye12LiPKeoWnK3nolyMj5YkKpzszlIHj4?=
 =?us-ascii?Q?puYwKUueqe+ThzVhLvRkPMUkgRTLwPR/0Hifu8ooA3nPnxNC60AoHRoh2bUi?=
 =?us-ascii?Q?0kmGMv0Tu2nh4S9DvXhF7MpHfskswp1PFhw9RudPCWyWqDfxhQMpoe+8Qx3J?=
 =?us-ascii?Q?J8/07spwl9Gfa7z3avbnCFPc3r3LP7+CuuiNjTPh+ubM1DDht7i9gFspOnfH?=
 =?us-ascii?Q?K9NNIGR0iGz9ks4Gn/JYkQpDcJW9oRDl84fWZcPUEiQDUq0UuL/6mebb2ur7?=
 =?us-ascii?Q?fpBmrxFD+T4jyc3IqY9dJEV85zZaC1QQXphbsBTzkg8yaA5Zv54gP3PPf7N/?=
 =?us-ascii?Q?XuyAPVbcrUC6PrBsUVNypfypWjQhfjDwv2KitwAOD9uWb71VxLXjl+nGCFBW?=
 =?us-ascii?Q?n11hwY16qX9kv6YFAP9W7zZ0H0rXaqRSxWfPMqJt3MobH9i47Fys+3EBOTnV?=
 =?us-ascii?Q?mKjXJmgmRKoPi/lG38kDfzMYfBNa4qhzBjSkp9isbvQVwAfiW+nUIxj3s/qz?=
 =?us-ascii?Q?1HZuptOz8MUwynzoAG/rK7xAQ85K6sr9Esu15afNYWfHdQsAjLbKU4pHZ1Y3?=
 =?us-ascii?Q?cyhTow3oS24qrMKEy267ffDhqXQzACglqxmLIpokauN7Tg61HuRkOOmephor?=
 =?us-ascii?Q?+Bd8YrcO1W/5gtPZIgrWYR91e0+KlUVYQhT6opqlaERAZ4QM/Zya/lI+pLSH?=
 =?us-ascii?Q?rDuqvq/CZeEqFc2bL09cYYal+Nx7r5Tzaj4I6hagtwAA5AwNFrLqNe6pvyZG?=
 =?us-ascii?Q?GmDPl3ZEKTMoC9wSIc4OWMRkJILI9NlzBQQPYwSB8DU0ihPWNg8E6zjj6K2G?=
 =?us-ascii?Q?yoYZ/cF9XTw7MoSAnfcTJ2TDK8ZRU9zOADEO0JZsJtp85LW2MmeYOIbKS51Q?=
 =?us-ascii?Q?xvHslQJ9wrWtGDzQrddxs6WE+isnfdc/uK7v3Sy4+4x8zYlUq1dG24c7SvBJ?=
 =?us-ascii?Q?mSmrlw/9rw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 333bfebb-8eff-41ee-4ac6-08df3370068d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 14:47:14.8561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4gNpPrzFItO53kByqwDEKXbBnAXY+ejA74RtSMSeVXoylcNnnyzSA1nLRu9Il30ACSsdA5a2AmzLBz/cpfmWn7YTmBCxk2OFMQNfpwNFk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13925

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: wsa+renesas <wsa+renesas@sang-engineering.com>
> Sent: 23 October 2026 17:10
> Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_D=
IVIDER flag
>=20
>=20
> > See patch[1] has relevant changes.
>=20
> OK, fair enough, but I don't understand the HS400 details yet. Let's post=
pone further potential
> refactoring to the time when we talk about
> HS400 support. For the time being, can we change this:
>=20
> > +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> > +			clkh_shift =3D 1;
>=20
> to
>=20
>  +		/* internal /2 divider is always active here */
>  +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
>  +			clkh_shift--;
>=20

> so I will hopefully remember these details then?

OK.

>=20
> With that, I think we have all items discussed for this series, so you sh=
ould have everything you need
> for a v25 then?

Yes. I agree. I will post v25 after testing.

Cheers,
Biju
