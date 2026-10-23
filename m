Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770539;
	b=d4eWd5v4B0NBxUxLs3u7akMDVws/Le6EGAJALcGcsvu2gF1YtZsfRWKKj072QfUfwxJY
	 DvButUB2Dlo9GyweiIivQuyrsN2a/4wsobZMBtzhskcc8FhOOJ2v4CuiSjuuAqReH/FVt
	 NqsiqZVkpoWemWy3/c4YvSbcINAXNj4usiJ04KPLzNu7IqbW8nZ/RmO5F9zBSSGwBSRZu
	 jHgua7AK+TiwDI6NHY2zZZ3u7IH/yTlhHnB3TAJt2QtnnwuEsrqpcCeRCCdQe0t/V0gci
	 Eo8zdTIW+rvHDp54gzgqcDkPY6XyiAcr1SQnLvU8IVNbyvstlMcdqv+c4ZDbmMDNntw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770539;
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
	bh=HDJpdm1Bo7Rd1C36XiG83NQtriAWNmV2tX5LeqD3bRQ=;
	b=TW7nlf4L6HYESSyiMeKewMTQX+orUthl8+8bEQDMRiTsPa4xr55J00H4koal5Icznt+k
	 LLz+/aBtLjHS/AYkIhIi3UQ7d2ZyU6DG4abQZGch/9aspm9Vdz7I+rlzpTjmkjff718PN
	 8hkgRVQJNnRlRebE+/smE8o+QeCUcdvv9O9jH9Mq21yu49IW1FjI+RetLNt+1GRWdZerN
	 CZS7eAYMya38ieyI0cS3V8oDy23fWlHNhYJN3+lp0DexZgWnxFLpaaW71cePe+IoELV04
	 7KzJGSDg7UL/T1FPdfhusyoFYy3CRoZ0seSGjw+avLfJiRyx/floRUTg3ggphtwR+7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=GGzUFP7r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.43
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011043.outbound.protection.outlook.com [40.107.74.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F82606A31A;
	Fri, 23 Oct 2026 15:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=GGzUFP7r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhWb8/EqAnvC6T3jmilAbTnWDYi5GXv5nxDi64mfLGQLKFPvvvE4wyug9vtoZmV1dihWiWNinao+s4qgBasMezulWgtALsym88Icmbco5YPFcDE8zX9bat6bCKHvrBa5yV/v1hTDwnMru9kkVB+Hb/hrC5OHgxWoCH15j245XqWJVaWk1j43XkIWqVGAnkCXkEbKV/mi1R5U5PftPrD0F9kKe1nUWcvgXY5taWirQAI4TJb5ObIDfoPA4sxYDzavCwKEQVoD5WtYIsaY7jPgZg6buXao2P/vVlUtcemewe4kWLQOX93+ds86bQDlUbqyrQl+U0FCfiljnAfitBXiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDJpdm1Bo7Rd1C36XiG83NQtriAWNmV2tX5LeqD3bRQ=;
 b=rwKt0uw3Vtq6L3keed/vOk/oxYjcgVwd0jlSAwlmTyrChLKoI+kglgOy9c046jAsm4evXa0onfzAc72jzXtb5EqBDcOLjK4wT7TuObToT/mp+qEYi+ROrE41Eol21Cj+V22kFMcUIgdNGW2hsTCnF/TnVn/1RYmWzkaVjS0jg289IeYiaFMMtIfjtbJ3A0mPtfDe3Tp25wnl9CIvDF4T6Xx2FwW5zVSMnBJXQTF/LSswLuyx0JUBuUEj6aoZ3f87cYa2/FznoI75F7aZ6tuCzcWgqkivBeom5HWX+JcQmKgbSTXK7UIJGJO/SKWyzClQnmXGyr43kbn4zczc5VMAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDJpdm1Bo7Rd1C36XiG83NQtriAWNmV2tX5LeqD3bRQ=;
 b=GGzUFP7r9MfyhHdIEVdng6fPltvORTxlDyf/LHxZcs3Nu2D3+IfWeL0JtSwdgN729XS0r628HeRiqxiSYiUCL9I5hhhr8QRsp0BVmiT8Bo9J5RMkscnLI3hQhMbvbsjWbX6GXOtn9KrC17GMim39iReVQp67lLRBhxK7QrSgJok=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13342.jpnprd01.prod.outlook.com (2603:1096:405:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 15:48:55 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Fri, 23 Oct 2026
 15:48:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>
CC: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 11/15] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Thread-Topic: [PATCH v24 11/15] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Thread-Index: AQHdMMfBiC8we42goU2GQ1SEBj5j7ba81lqAgAY7w/CAF6myUIAvEe6AgAHcaOA=
Date: Fri, 23 Oct 2026 15:48:55 +0000
Message-ID:
 <TY3PR01MB1134664CF97EC057E8B2A952D86642@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-12-biju.das.jz@bp.renesas.com>
 <aplhlynkb_LUiVhS@shikoro>
 <TY3PR01MB11346596836AD38371FC3568A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346D30496CABEA390A2385986832@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <atnyAfePwJ_9kenH@shikoro>
In-Reply-To: <atnyAfePwJ_9kenH@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13342:EE_
x-ms-office365-filtering-correlation-id: 3f902e3b-fc15-4a19-b6b3-08df311d252c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|38070700021|56012099006|11063799006|4143699003|261022115727099003|10067099003|261021123027099003|261009223027099003;
x-microsoft-antispam-message-info:
 O1ZnteDO6YiOOAyRx0EOr/rrrT9fLJEBu05sD7e7DlpyuM9i8g+MgQe9i+7WMVU0QWAZCW7LfuAhb7vJA7W+ttf+dI///yPH8AhPZN0gsa2PeCl3gIdXmtaZ/Z4qlAiLUASuxPCU7VGBCeWdNJNhWkYtKLkEqNqDyuYWZseDF3DoEzVjeq7YHSbZjqIDIFA7w7DN2pxj4ZF7Rpd33zG9DTiAA30LHMxGYe7WLjWXdVl4O4wM4RsGDrGrk2H7OPfRo0JEJ54oiGZV1VlfqcnbPuGt4K08JLwDMyBcaFxcV7+mzwD6m7kBg4Z0hRlRFp20oPmITCGUBs6l1E3A5fPrMu5sLtlPcKmqRau21YY46l0LHz2xrAXGHCa0VuVJIVRf/AS5r8yg8Nvo6t29X1ze68XW7TuTKQTzI7bIC5+EUKrfU9F3RTcAreyCggxr3xL29iNOCSV23fDDNJTHIgE7dN+Azxh/Q8mJMhKTYVFlviURNLL7RXXCsUk81dMmNO6Y94OKKfzxRYN03kESeQFzfW5i9WY5ytqE8ZdGzmRtVMVzRYbBMKqMp5qaQQsOtXWWhosjtYdVlNfRXbcs8pcIa8mhyXQgDkGTAksTgNkxypnIMErISeQoTE+AOQX1Wbs8daoSI7RD3SKPbregECg9NtlmvtZw/ZhMpns+1SI9AJlyKGueGnqUhyr9aMyKNVWzWwgGA00HXskS2VscjoBx1pAZYlSx+4pexFxn9YhaHW8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(4143699003)(261022115727099003)(10067099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1lyN5CPaPmToJgqATYwtr7TPlKwAynO2X6A4NZ6K5zMCTfyrVSmM/WEWPfTl?=
 =?us-ascii?Q?k4m7th+RhQiiXJxpCnIjieR6JVweHldH+dLoNtCE5FVh3TPK/4rrklJvqLNz?=
 =?us-ascii?Q?cFBGzcIdvAmdVRqshOxidNIHC0wgnwRgN1b8yddeE/wffkk5nBgqxpDjxFv5?=
 =?us-ascii?Q?JJmKdoBviiSOZHs5jF/CmjuvXTRYoUY1pzj+QEo7GPOkp86lr7LcfadHmIg6?=
 =?us-ascii?Q?RydPvO46rwTmuf+ja+j/Lxy4uywn4DaXDpD0wsg6iJe+JF88AGNxzrwpQ5gI?=
 =?us-ascii?Q?3Gf3o8/y0JXG97RyT7CRK6Au1GnU9dVUQdJsKhNYpPicEytJAgvXLTBKov1p?=
 =?us-ascii?Q?/G8fDh6+6h+bpnxeGRaKhxsm0M5FMD4PVAMupWJWR0SU2BUwi3+KErNAXdpN?=
 =?us-ascii?Q?vl8Jr8JGzqmJNRyfyMPlC21Qik+lfuHWaHyZmmYHbcYqsHcoWOO7lT0hk1wu?=
 =?us-ascii?Q?MsrOlrL6RUqr2JBaLGTkvpflP9RuRLZbEQqA1bB11AHdDK5PL4qUAN6E/wjZ?=
 =?us-ascii?Q?qBUrJA/dj9lVT3h0h+oqxY3WFmNObWB0Uah37VwwI6G49bSlUIaz3WiHJElY?=
 =?us-ascii?Q?YiTbqA92q+ryKazsWK8JvIro9oTSbqyZz/c8rfnHXoeoracecujqcdlvTeN5?=
 =?us-ascii?Q?G+cUp2o/VMx9mhxpthpByLN/3rZPVE/hRoiWMgUfYZmoWENbq5P/LTHULw5r?=
 =?us-ascii?Q?IeatFfoKEYUIyWyPbIGSGQ9DA9+k9hIAxNKEBW+Wu3OrAcH2kyxF+yeKk8Cz?=
 =?us-ascii?Q?Hhp6CpDmC2MgSeUB+KKhaf7+Cr42HDsUpki9fiHK6xTjwzY2BtHzBKUusLde?=
 =?us-ascii?Q?BMPgaarq1WE2HSn+OLuCAuZ/1oTJXJHp8DZmHR9iUp5btv3wtwqX3ty6NhuU?=
 =?us-ascii?Q?bwp+WpBQZhwMEa1ty6jOdzJH5rP2esQ7W3mbd24LpPQgCfDb2SacBbmaXeF4?=
 =?us-ascii?Q?VY58jnuL3Jyfxxp7f7FetUfZ5F8Act/3q2w/GIOzubdiweph2seyg5yMGytk?=
 =?us-ascii?Q?d/OCdwk2TkxMhCDFDcAuhXbpPMlF0Rbl0hs9gOOK5PWcQ0vnWbSOaDCUzLv9?=
 =?us-ascii?Q?Tar7rq+IZ6X/4fQa4go9ouq+z9HFiwpD6AHhZFn/tHuxdTgWFQoqiDkx23Ou?=
 =?us-ascii?Q?g2NZsK06YbGKoqxiduoXPr6DgQuf3JTQ6TsWf817afmnnmXMDfKj8N41j2TR?=
 =?us-ascii?Q?2c7a+/7Q1LsfKX/PWeRGcvvldundAZHoBMkRAopsdut5fuEVfzg+JtVL95Nf?=
 =?us-ascii?Q?qy2qa18iNG1vUVOwdDtshlt/Tt0zZEAU7R6Usjv1Qr+HaLOHlgvVmGA4HAnh?=
 =?us-ascii?Q?+X3+T9NAuw2IwHlm756tBLuLmcXdoCGlLOr4pZEsfUDK6pR6F00tN0JuwMTk?=
 =?us-ascii?Q?Q3hI0+jJ5ya/gXbsncNaUyk4ZOeKrnZKJOi5gUTMmLe7X7w/YXS81eBIMZ6W?=
 =?us-ascii?Q?onQnqWnDMt/Ub1N9oPc76+ULN82xOqKMNiTcANuQLicemvoTbXtrB4wAprCh?=
 =?us-ascii?Q?e9J/qPiyZUXol62mnNrLKk21C/llhYL73oKtmJbHBFT8mtpauCsBi0/nCPOe?=
 =?us-ascii?Q?WnrZfkQxl/C8HLGRVXhaAWu6tyzwm5f1nwn0N+vFIAp7tilIKnlhnealCdq1?=
 =?us-ascii?Q?ig5XhEmB47XJTre3GhOZ0Rrlb9YvzWtE/6gRc/nVs3NNspJSYuFRRn7SARBu?=
 =?us-ascii?Q?ic+NemirKrax9+YChvdpdlJkqLZGgyQJFM7D3GoIeK4RR9nae94k53oVY26I?=
 =?us-ascii?Q?Mt7mNJ2CBQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f902e3b-fc15-4a19-b6b3-08df311d252c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 15:48:55.7021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fdWzNhiytDmIpSzt0j7bHf0/vh6Q4grMSSlZIdAzlj23ajE2oUYbKFakbl4sFx7yLV0kJaHEE7p+UYMKNlR+b5tPIs+hQ9KtjZpcdZSwBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13342

Hi Wolfram,

> -----Original Message-----
> From: wsa+renesas <wsa+renesas@sang-engineering.com>
> Sent: 22 October 2026 12:23
> Subject: Re: [PATCH v24 11/15] mmc: renesas_sdhi: Add RZ/G3L SDHI support
>=20
>=20
> > > So initially bit 8+9 will have a value. This will be moved to bit 16
> > > + 17 first Then we clear the bits 8 + 9. Bit8(SCLKEN) and
> > > Bit9(SDCLKOFFEN)
>=20
> Okay, I get it now. Thanks for the explanation.
>=20
> > > > Does RZG3L have a dedicated naming? I'd guess *_HWADJ1. I wonder
> > > > if it makes sense to have a dedicated define for it. I tend to thin=
k so.
> > >
> > > There is no *_HWADJ1 mentioned in HW manual.
> > > Hardware manual mention this register as "SDm_SCC_HWADJ2"
>=20
> OK.
>=20
> > >
> > > >
> > > > > +		if (hwadj2)
> > > > > +			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0x3FFF);
> > > > > +	} else {
> > > > >  		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
> > > > > +		if (hwadj2)
> > > > > +			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0xFF);
> > > >
> > > > Magic values?
> > >
> > > HW manual mentions the following,
> > >
> > > HWADJ2[15:0] 1FFh Hardware Adjustment.
> > > For 1.8V operation, specify 00FFh.
> > > For 3.3V operation, specify 3FFFh.
> > >
> > > Is the below macros ok for representing magic values??
> > >
> > > SD_SCC_HWADJ2_1_8V 0xFF
> > > SD_SCC_HWADJ2_3_3V 0x3FFF
>=20
> If you replace the 'SD_'-prefix with 'RZG3L_SDHI_', then yes :)

Agreed.

>=20
> > > > I wonder how likely it is that a SDHI variant has either only this
> > > > or only TUNING_DELAY. Do you know of one? What would you think
> > > > about merging the two? You know the RZ SDHI
> > > much better...
> > >
> > > HWADJ2 present only on RZ/G3L,
> > > whereas TUNING_DELAY present on both RZ/G2L and RZ/G3L.
>=20
> Ok, no merging then. Was worth asking.
>=20
> One more thing I noticed. I think you can drop 'sdhi_quirks_rzg3l' in fav=
or of 'sdhi_quirks_fixed_addr',
> or?

Good catch. Will drop 'sdhi_quirks_rzg3l'.

Cheers,
Biju
