Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792765670;
	b=PyxkSnshYaqyCTgCBNup/VlXi7Asn2AKJL/qYfqGEstCMcqOlncjwvqx8VoPe5gBUFY0
	 /R4xRqf/DiRudmOPE96k/2UN7mPnQrQcGc1DKyFKWMSSqz/hirnz/JWRmo4hjgKnObGmh
	 dgrtr8mcHt31j/jn5IQXivmGOjo3Ii0kTJUnrL4JX4JRd/nouW8Uv1CmctXfoBeQAdui6
	 g2E4n2xBIeE6lhd/p4Q0wiwUBOEfP/is2adiFgObIBqUHEf7kDIxSK34H7QK1ut/yZPHX
	 sCw+Vb4XChug2Viq1NBwc30OfRsf64POD0Gm44fnILXVeAijVhhWCjgxzMqNxn1sYzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765670;
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
	bh=hJe7wcUqSiG7WYGXZ5Qh84OV4HLvA+nyEk5JKgXiqsY=;
	b=T6ucayWZAJicgrWZWwZnynTxSnNm0X4kzX3uJxLPqCfT4e/QfpUdu8XCevukzboEogi6
	 nXXh0qkLzzndvnRul0gBRlX7hyTUCmJyNOl+nP/9WerqTjN5E45HIEqCsEemqepSRfVyi
	 QoSTHk5GC+9nnvmo59EBC7J1G6aILa5eGT3FgdD6nvOtKb76Cf0k5hzi7JakwgNH1J4xz
	 7/bJY7pE+BWuXJxPi2ElceDfyXKB6gvhJKuTjfKD8lbc+SoKeM/CqNlt4sPdxdZRJOQDO
	 /fN9s/xCdVo2VxzEJitnQtDXmB6znKnxq9KD7G/q7OpCbKQzNrSet5iumkXCmtsLF4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=hN1fnMZZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.19
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011019.outbound.protection.outlook.com [52.101.125.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8374606A31A;
	Fri, 23 Oct 2026 14:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8374606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=hN1fnMZZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7T4HIdyiffspM/QvJJ9uCM2bIeDFT6zIknMUOobHkbPJAuDbyG2+Lybp7b3soAuapYWNQZH+imhdqwo9gLBXLNJK5GrmXC3k6zri8jrfqKvBPv8FzN5IxPx6jPGqpoAG7Na9vWRYykDkhiz2QP0rPmF/Los80IsnFmUpI7WnCOktLFsykaR91Inc5NqxX6EfQEzhEOgPRXiSMP/33Oajp8G4d+1nG8lXLeBz1HiHIZMnyp24xEGEw6YXcYYJqyPPDyAgDEmbdxHIHW0hOz9KvrTqGgJHbC/1wb2YSbWJ/dVq6dFe/putz7Y2H+tCQz2GitC8YITELqymgFREWGvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJe7wcUqSiG7WYGXZ5Qh84OV4HLvA+nyEk5JKgXiqsY=;
 b=VIdiXPqNrBTwIVPzbnUve309Dk6gdwEgvXHt0ZkfLfl5u7lM+O37UjU2y5zH08g9GK2xnVoIN+Jgq4V9Aa+9APV14+5q2X/tmhLeQf6OJAK+VppOMh7Rf/FOmx/4EqKqh70LD5ZOirE4mR1D7HAOgQB5XF/yBJhu64SmL5qOzsaw60Tvx2PrxcD8h8x6aLKH6JzbK/1K8LzH5ErYh6xXVbgY+oVvsarWYMq6+0aD6HmL2WxM6gUH76GFMFWPB4HXasG2PiHiaQfHwq06BHoNAzbUJkyddiVPnkjSyu9qT0/IAY+pcVuFRHQ6lzR2kUKr1EcwoypzE02SHvz8SnR8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJe7wcUqSiG7WYGXZ5Qh84OV4HLvA+nyEk5JKgXiqsY=;
 b=hN1fnMZZi5DpdP4NfffRwhrwe/12sddSY6ktNImcHdbrgel/xnbpW4PnPYhBC/QicUwDvBtvHZGGRxei4E+xdu7s1CyfwPQUq0DQR7paM/he9TqHl7lO/Q2il8YmydWvlhinfZc/0rdgUojLNLr9q9T+SA1Iol+4t149BKKIj5U=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7774.jpnprd01.prod.outlook.com (2603:1096:400:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 14:27:45 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Fri, 23 Oct 2026
 14:27:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>
CC: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for
 CTL_SD_CARD_CLK_CTL register writes
Thread-Topic: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for
 CTL_SD_CARD_CLK_CTL register writes
Thread-Index: AQHdMMfAfNE6w/AmCUKaMfvf8hhQWra8vZYAgAYkctCARtTPgIAB3NOQ
Date: Fri, 23 Oct 2026 14:27:45 +0000
Message-ID:
 <TY3PR01MB11346A975781273C53C98D8F986642@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-11-biju.das.jz@bp.renesas.com>
 <aplM1LLFJ4eo4YJ3@shikoro>
 <TY3PR01MB11346DCB87BE26D185FE8017B86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <atney9qgx_P1jh66@shikoro>
In-Reply-To: <atney9qgx_P1jh66@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7774:EE_
x-ms-office365-filtering-correlation-id: 38903723-643d-4a4d-4079-08df3111ce65
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|56012099006|11063799006|261022105027099003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info:
 tyTArR4ucgOws8nB8Fiu9WI0EHS05XNq0QaNTgVkC2uwQafFwi/M/1EOmSCgM5GflI+OcWNZjZSjgGpOZTcmvC0k8lewQt/oMVvY8rNdD/SgZxOybiBiuMi6Fx37+uuk2ZzBBBVhliaaaXw56LV/4ScYwP2QUHrmN8BL8LtPbPbRz4+HMqAwzNa7SL5hTjRukIbqHcA7ypocBfV7YMzX2aso/E8ob2Z3hKtIdO+xuuvFhEdPeprzT44ngx4oPqwlI2uJ/9kA2uAeKB5EM+wZlFKkD2MpsqyIdedm/H+Y7TvV1h+QX6MYyN0f2BmZHe+gajusO5+IbYRMoXE4YtNdCoPNkMRYu3Ye0g0uAeMwpMsY88K1NTEZSBOyYpzSUmS2hpT2PXysJXHuXXXB/kq7X4QpZreLrULFTGB4BMSWdfBZswefE6jpJQjd1g/EHTd4crgrTbZGZ2OEvO2hhweq33Ws8KwBj2IXr/Zl8tY2QXUFx5SBGbrUZb8Q8IbDKrUER2hmt7St6bD1Tq1ZPWEOInwAJUwey2dTi7s/RztJ5jVHOKC61VMeqeCKmxIwuRMWarXQOo13MSSa4F/0cx16gtxP1q9NjOs7cCjfFjNYHYnk4TaAeR44vc8SiWMoyrTTtjseJdidn1NZSnL6t0zuSNF8C6Ij4i9JXlcgNx/avavQN9Y6jQypOtfV6A9ChmyX5NZ/YZ2W5Q4xQICLEMLYkFvL7n3dENAUgDSKp1+052Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(261022105027099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yleM+QkedSqV3xOWWHhfJV/WAZJ1IAlmoBGsUFqkGp/feL+uTmbk3wbid3Io?=
 =?us-ascii?Q?4K/Ewp7iESol7wAJ2GRnRg9UK7V60vTcKAhAl1ZmPG3n1QD0qUj3JU2jycHp?=
 =?us-ascii?Q?py0vZNiGPxzpMV72JTFhvj3Hz+KleEJi9CWHt2sLu26vafREtJ6rCNRcCqjJ?=
 =?us-ascii?Q?R2V30TOiTYsToXOyXyBUUbsPJeX50jBReZBCG4Urq4YGFs3mF6SIe9vOzXdy?=
 =?us-ascii?Q?Y9xSGOy3A4IBFpFSYIurkbV2n2SaeEFVUokLidMQEEt8HAErTS/R+5A51fHC?=
 =?us-ascii?Q?C1a1kdSAWBOp8gA6L55v2BBzHQJU0en/6x8FgrAPfBwA4WuRLMIAje0fUDsb?=
 =?us-ascii?Q?d+/5Gcszdx9GuNPh5uv543YlSrMi+y1Qq2SKq9fxStPBnNQAMizve30ZZ46g?=
 =?us-ascii?Q?fCUuaFf0lR5z/sM0NI5CbPhpdivy/Ggfnkwsl4+p3qsc0v0j2cHyw80ojQ/1?=
 =?us-ascii?Q?j9BjEcFz8dbbfnKHKwV2ABF2E3dnq3yyIWI6hUAFnV8xG/l2FCMbTD66ID6h?=
 =?us-ascii?Q?97YfQXvsYmexINI+M8KbeyWIR/YbR1b70iPJRZI5QXRd/q0NQCa4jI3DDlja?=
 =?us-ascii?Q?QDe5AvVzARbz2+xUA3l67Uu4Qwau/Jcs1Mm/tpCPQyrVaNmWzgM/IMYONTAK?=
 =?us-ascii?Q?tOkC2DDhYjnkIKvY96C9huntaoej9Kb4lPZyzwdzgM4z108bQ7I1wSWFCsCy?=
 =?us-ascii?Q?L4aYxttNeO03cRw7hBeGucfDRLQb0WIKW3IQrejrYBs0e7ceMl/tc4Gb44hJ?=
 =?us-ascii?Q?KsxTwqvwH+4/W/w/5+2bQ5DszdDrzoy2pLjxkxdS40rFMzAfeOuIOWeNRgVG?=
 =?us-ascii?Q?HURFlxtKHEpD+MpxoU0Sg1hkEo8z+R0Zco9mt5RkYIuusB65MoX1UHNaEPVt?=
 =?us-ascii?Q?0Uu8NaNUs2OoGX+fMj5Om4CgL2qwutTvSR7WZlxZw3iABrtAj9oztyBgPGqG?=
 =?us-ascii?Q?DySj1bfwI3CGTYlgLr0tEWWv6iucUPZTTojq0ET3vXBk7MpUg9kRORoB4WOv?=
 =?us-ascii?Q?5hpp7eRCCVBTZuC8ZmhSEFZEN4NqTnKz55Wv4n0ttC6fOtxJBI3gzkY+cEUR?=
 =?us-ascii?Q?GhaxcYVXa1eyFP6FoXkC28q4222Ue9e1rBnKhWdh9eUJiB3om+vEyEU8D7ca?=
 =?us-ascii?Q?9NY8xKpZ/0Ufpr7jj4CCIP/m7oejY2ZzDrZYKEIyocSPz+HuYusXG/m1rpqt?=
 =?us-ascii?Q?GE/UyInELvzgL1Yjv+o3P9mgyDKHFuj0t26qridD08MP3NTX+cXadsK5PoNF?=
 =?us-ascii?Q?Y+4XCbpjw80CS3BOr8p8dThSfV9GNuyBbKMvqckBKwpR9XFA6IZlUcjDUANo?=
 =?us-ascii?Q?Udkuacx/nnTqhJEgrZfJQhrqNKsuXXx6FuabUU/nBzFIMfK2aZHvDzliIEs2?=
 =?us-ascii?Q?U3+8ZbiKOVXNxqk1QNEI75Ft/Y6CHeGJbecbTniPduN08O3JRjmTPHbPafu8?=
 =?us-ascii?Q?MpnpqPvHcx7n/YzdFFbgdOJtIwJBBNNpdQpopgOxxgQFeSD3GzP7zzVmUz6A?=
 =?us-ascii?Q?bH/r7qkexrX5GQF2gIHz5clNQ0oi5H0HdZim+8N8eG7dH+RmRAWTS7wq1O3j?=
 =?us-ascii?Q?9QZtCV0FgKotqDOgQzCux/Wsl9L27CTLYEW1Un2cjjxEcE/z9h+I3lJs4vwu?=
 =?us-ascii?Q?fQiyF+W8JgOwdjI6i6RZ2rXTc/QYIM5Jy0NhApvx/VCkdT1P7ykgzmea4dG4?=
 =?us-ascii?Q?L/MBwSveiv15dOFKRs1PJ66Vj4Y0ge1OEv5lp9yB+XItPWkvuQoNkDMucML4?=
 =?us-ascii?Q?hNy5ozzQUw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38903723-643d-4a4d-4079-08df3111ce65
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 14:27:45.6477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXTvxRB584qAPP16RVdjsYhBn4BFWBwA2LQoeJk0aErVtFU/dEagM80vE8eak/i6AU/PN5U0OD3FfdRtOE/bytOFryxpQxfbkjVnnA2+rCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7774

Hi Wolfram,

> -----Original Message-----
> From: wsa+renesas <wsa+renesas@sang-engineering.com>
> Sent: 22 October 2026 11:01
> Subject: Re: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for CT=
L_SD_CARD_CLK_CTL register
> writes
>=20
>=20
> > For safer side I will add, considering this code is used by other
> > vendors they may call sd_ctrl_write32() in future with no TMIO_MMC_HAS_=
IDLE_WAIT flag.
> > Currently all Renesas SoCs have this flag set.
> >
> > if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT)) {
> >                 _host->write16_hook =3D NULL;
> >                 _host->write32_hook =3D NULL; }
>=20
> Yes, please. The consistency that comes with it is also helpful.

Agreed.

Cheers,
Biju

