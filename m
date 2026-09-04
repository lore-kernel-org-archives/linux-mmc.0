Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011011.outbound.protection.outlook.com [40.107.74.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774541A794;
	Fri,  4 Sep 2026 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504026; cv=fail; b=hz0fy46Di7Ph2rGJaPHXZtRPW7slJMXluJN2gbhM7PaNje9uHsh58iB8JOvXYQ6NC+pv0/4dcswnfgxtNVjrv2MtXQ/8JITs847lD53+VzMCg/RAdq900ra1c6JFsMkwBMuuTQznG7LbzlnY8+koI6a7NMuVkz19vcKC9EtSLKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504026; c=relaxed/simple;
	bh=jGmrxCTx0m1doAEJ00/3lfCZeVSyu2SHDbHvz9YN+yw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R7Eky27VhzaYdXWWik9jlbrAPNace7NrpjW5CjuWuIU5BocGlH0IPttJeaAiDA+low2TvPHFSaC5LnY0IlVrpDw8dnL1/PNBlx8bsqEnv48jz56Ggb45kdastXT8mFQCiYZBKUEGbs8SeSySDxlE8MM0yWXszS5Bse/h08OaBsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=oWZD5V9V; arc=fail smtp.client-ip=40.107.74.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oWZD5V9V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io6bbo2xIiRMQrFWYPppp+Z9caiME6mcmU1BCLl42AEmmpuemZJCI97wWrc+NoRtgXn1MVCYgpxg0oxwJuGIUCia4mbhFfs3wGibFdSapEYtnVGvmmMrxUnz2fs9ubZ81KlvmzFiZ4KWWMtuKh+Qk69Q+zEp+JbutBfjpe08N2LXfUaT/Lvm4Zc7sGS8ETFyltX6+sRIjR2SJRXO93/V7H68vi6VVg4/UArUxKh44A00QhqVXgltTrLrM65lrEONsjQqJCdOtGVbEueuK0v13bxStmtgb0eSMWqGayw7b9vRQkt7Ul6ueyXm0xo2UojzMHtbEA6LcEolabVqlrbybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaTk0FJKQP4IqJLD0fYzRvJQg7FhkMTlH4lO3JxqSMs=;
 b=lO9/bIo5bYIwpJrXvZ8Euk/VGJBO6vdailkIzsMk/XJhdBleXm7rsFC/8c0LEqo+KFDInh5B/iJHsfsF+hVbsPZnlBXMeRSrUscKGQ9k0PRCn+LzKkNWrBv801vbv9DCZdj/IabdC4a/OTy7BYoI2E3A5AyBjEPEeElU7haHR+ajL5rCEqH6A8e89U16bIY6JNteJySocGvcS4lcV4pNy/zMnKxcnrqfNQ27ytKuxe9Se/erIxpXMhZfNRqN5wxohWHx5p6GasU37WTEylyXHKdREyThY5/23eygMywdZ+bAMpcVpbxPTg0EDEArW1Trk/jPUmMUMOnyKToxJoDGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaTk0FJKQP4IqJLD0fYzRvJQg7FhkMTlH4lO3JxqSMs=;
 b=oWZD5V9VvXQ3MhHWqkoKxkIj89o+j2ZfgX3gK4ZDq746JyfHooT3UU3Sl8QZpUMEPxDA7c6yM0be8pxa/E4ivBA2knilO2mXpfpYnJ15XGcrYa5Eif95AfGPUHO7snn00foldrKAtKjSdlIK6GedOkRj9HJA2SfqO6z6G4ujmQc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11969.jpnprd01.prod.outlook.com (2603:1096:400:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 06:40:21 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 06:40:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 02/15] mmc: renesas_sdhi: Clean up whitespace and add
 OF table sentinels
Thread-Topic: [PATCH v24 02/15] mmc: renesas_sdhi: Clean up whitespace and add
 OF table sentinels
Thread-Index: AQHdMMe6pxA97VG+3EGBdNADptF0Tra7L0iAgALdejA=
Date: Fri, 4 Sep 2026 06:40:21 +0000
Message-ID:
 <TY3PR01MB11346EAA3A32476F3164DE51886B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-3-biju.das.jz@bp.renesas.com>
 <apf-tTkYstvbe9YP@shikoro>
In-Reply-To: <apf-tTkYstvbe9YP@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11969:EE_
x-ms-office365-filtering-correlation-id: f6bb4ec4-058f-4b87-0669-08df0a4f647a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|56012099006|10067099003|4143699003|18002099003|11063799006|22082099003;
x-microsoft-antispam-message-info:
 +rq5lzqrVUB+IFDEApNJrCUzT86B3qN1uZePcZZR5vzVQWBSMrO+ScmPQ5OZ+O5MoGb6LOfhz45EbSmcOs7s5HC6MuBY9C4LiFHXzv9blCZFFFzWo14mtEwvbabRbPkuD7NlgoLOsox8wU8P2Dj+/luhU1FbiXUYEWxVUzoPN9jld1aR8THQ1js2YyKWSnHefKq/Nr7A1l69k3Z8lyJW/hgOTEQi/s+bRp4onmLA1vRSeUpww4RR+wFTqbkoXiZVHvHgQAb+U60TCOe2P/BaUSGwve3fB5sDh0xUmWbQeYv2vSX9fDF6a8bvqxwPK0Hi61H12TguuduYMwXs+Inkddy7nHqeT4D/9r8NvyBmir14ibuYvUMEN5I3JuU+7T2v6rC0T9kSqNWqBuDa2owG9v7RFBsZ32lVb3CbXXxjMBIP6uuZfBF543XO2tK392z+6UqNJ0zNFGOiZH6BSqTSZN2+4eklGiuNp93eqJQgbCXZH/R1DOyQv/Sv8hr2sXU5S9LfUmk1TbxADDlR0NnTkAmnnICSmFzO0lLrfm3H3WVmJ8oGYO7gWmpi9joIKUDxvJ5ccetLmmelZtj5IK+Ol0oabEBm/jkOxT/3Saq+YA1IlQ5WyOak4lEwaTcRbTKhkb5raJp1zTxk4/Fo9yKzJKsAVnaN2h1gUO+GaGrjwXWPVPNfZfy9cdYOOY47PnLPHRyGMAsBlTaG3jnV/lVJfxht9lpMrKiG9w4GsSH9XwQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(56012099006)(10067099003)(4143699003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D93xkCCsTyPWqBPWuafxZ1ad+4TLc16BI8TEQHNQARRq04PLUw9rVTgzjm4f?=
 =?us-ascii?Q?YsxgFpZUP84UpzatZF+AJIeZmXph5pANbxnkub+AQKmQ+v8iGwWcxsPxtORN?=
 =?us-ascii?Q?OQjQy2cxYaPqOLivvl7hVMcIZBBlbi4eaoJ73YSDebhEYtYYH8EoEkKJf7LM?=
 =?us-ascii?Q?h2NzHML8U9XFlaDB9WHmE4+fuSgeYcUSOzcAKW6zqTHlnSbR7n1xgz8kmprn?=
 =?us-ascii?Q?EQnRs3UKUqfrHDNsE/9wJYzn/HCWAk5h3+FCU4vq6pztgIFpG0ylR0vG7uWN?=
 =?us-ascii?Q?s4RaQBkCA24zFnoHw9kP1VQws+CWEykN4+Gm/xGFZv9kBsOL8DhUo240yxXb?=
 =?us-ascii?Q?BJnwzn/ulLlKU6SJTdFopulbyhfiE67WdPUkKUcbxZ3RbuKek7Dex62pS5AN?=
 =?us-ascii?Q?dzxhnqefiu1Rt3amNVu515Rh17M1uJ5NObbsQmzaXdOy4BbQ6f/f+jdeKStM?=
 =?us-ascii?Q?Gz14FE4qr2UcZA07IcSsmrvCIZNaE+aC8Evkm+YHvluer6Fji8h13TFEWEPY?=
 =?us-ascii?Q?1V5JLhL+WvvCNKA+oSB2z47Z9fqcTcNII2PzqpHru8g9goVG+/kISOL6HHNl?=
 =?us-ascii?Q?uJ0j3kR06VWhAuhf2yT0DY4XvZnCwKY6vijtM0C7UUvvwvkCkKq6r1zqmRU6?=
 =?us-ascii?Q?Kznxzpa9ia8Nh+5JGhEGHb0yJSOFT81mm4UDrOO6vpHBng/9wo4xz8q3wS0n?=
 =?us-ascii?Q?ftbUdTkardR+RcdbAmeQSFUBfNjTZWlvxkf/CnxGbnf9Yt26XvASwzgSPAUh?=
 =?us-ascii?Q?Vm9rat+GrA13xoIuBT5xjxa8/LmzF0n4s7WkI+KsRVIOAr2wNq1wZHv3pulB?=
 =?us-ascii?Q?81aVUTpG96Kos/l7qgYu0i93BATzA3mt2ORasaC5C6jRNHlPLnf+eKs+x+5Q?=
 =?us-ascii?Q?azRf9WaxvyVlViw5Zcy0e21Pg5DH0hpNFfhonegrjK0zOZlEn65K+64QzLVr?=
 =?us-ascii?Q?shFzsntw17rASc/idX5teTttjdgzhGKQ2XTAWbLaD5HX30P83MwIoIl1TJfJ?=
 =?us-ascii?Q?ATdURcDy3+zqfQiAI+XyWy18d3EW3+uhW++eEhxmC1r1RfH/Y7e4oeNm9UZx?=
 =?us-ascii?Q?E7/mqcxqX5tHW8Bdju71dLsuqo8ZdKriH8LwsBF2KIfBlO3YGGt59lsTzbOh?=
 =?us-ascii?Q?5RwCWLjK8ZUVMGj9g32Y7AuKs8TqlEpOgW18Uh69ctYQCDh65TRNHxIjYs1r?=
 =?us-ascii?Q?bbqvFcRRGE0qvsEemi2A92ErBkaZPKbcCfBOaUWgmKEdbiqu9IzuEHPOvLBJ?=
 =?us-ascii?Q?w65iNE0W51LwUt8TDmYdW+zEkDPvRaMNyEUcikjwSTQ8Ah1NhoT20y8OjLZJ?=
 =?us-ascii?Q?5DwWkFDuOweEDzZA17/AG6rhkkGX+MQJOcRmoxHqfn3h7pTDlEK/7puGoDLm?=
 =?us-ascii?Q?twsABHZVFq9svBLWO1mHviAlUEbJU15kP9te4jlEF6mqYvUbxFVoQ3wtscFk?=
 =?us-ascii?Q?CAowJw+89PcjP5PN4KCf2OtEDX1Px+/dbTAvlPFpqp9NPQsleKTsplGeHzE0?=
 =?us-ascii?Q?Twl/0lOuZ/zXsfBwVJhdluJE8tofvKL9/Uhtelio/omtLMF92RdkViBkj2WP?=
 =?us-ascii?Q?bqB/1Z+hY02bfBkNibaefnUciAc4gwtufEIsvkqj/gyYt2M+8XFe7OJJeDKZ?=
 =?us-ascii?Q?KNCs6lBKgme77A/Z8Csr6LNPZtrvP9ZMA/LBe06HJIiEbxHQ9WVjOguaAalH?=
 =?us-ascii?Q?o6aoY6KtPQ3s+H1It/wcfFbJAJSZ8pTmoeOBh9p+YtSlnqejKtpoHSTMmjAn?=
 =?us-ascii?Q?aWtFSNkE0g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bb4ec4-058f-4b87-0669-08df0a4f647a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 06:40:21.3159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQKGrBl3vedvtpZdDMoaeWFmflO0d4lqugjI87cx+V0M8QgivZk2YhImKnGc6VA92vTvfNUFMV2Nxqcv3nq22ZqNtvUX6BEJvGVjMT3fbLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11969

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 02 September 2026 11:47

> Subject: Re: [PATCH v24 02/15] mmc: renesas_sdhi: Clean up whitespace and=
 add OF table sentinels
>=20
>=20
> >  static const struct renesas_sdhi_of_data of_default_cfg =3D {
> > -	.tmio_flags =3D TMIO_MMC_HAS_IDLE_WAIT,
> > +	.tmio_flags	=3D TMIO_MMC_HAS_IDLE_WAIT,
> >  };
>=20
> This one gets worse, or?

I tried to align with the style (uniform tabs) used in this file for
of_rz_compatible and of_rcar_gen1_compatible.

Please let me know should we use single space separator or
uniform tab for of_default_cfg, of_rz_compatible and
of_rcar_gen1_compatible for uniformity among initializers??

Cheers,
Biju


