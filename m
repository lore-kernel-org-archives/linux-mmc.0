Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011014.outbound.protection.outlook.com [40.107.74.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E047798F;
	Fri,  4 Sep 2026 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519256; cv=fail; b=g7ZZV+f7RGtW2EVyxxJRJGYMaoS1c3VG8T4Aa5h1wCqsgYZx7qaqJZTLZCxSISjGrbX3clQLqCGZVHiU8kNXkBLnM6FtCHOj1+PYPSc/yFEMlzzWZ5xCSAyoQxUTnd8+ewfkv/NligejlCl+GSNCX7oB0G/NScqtVGkU3Krd/JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519256; c=relaxed/simple;
	bh=TU3zlgZz+Rj69c83SjAZvg4qkXURtalRzUIbvFGpOAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XHK7dgGKobO4blc0OAuHpP6rnngxdpcYgWXyegeibStE0F8i1Bnm9gvL6nWERMyagLW9C8Ne/pVXGKqDQl5hHcJGJVq3C5mzIlNxcsfQI9JCi/aqouX69UFw78uLofGmiqSto2Y+1gyoUW5gxdRkM6bBOhQ5ZbJ0vpMaOGR9IXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ICh7BBRE; arc=fail smtp.client-ip=40.107.74.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ICh7BBRE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8O+zKxD16rNlEfemPs5ih+psjVy7Dk2rszA3xG7CViaAV8QMF5fL/P4u9fVPSh/uc42FKduJlV9jyVI22KRF07PupQCnXGD4ZabErfO1/jzFsgeiMOVZXeo6G6bUzBg9c/JPCjug9XQr+M7l6tV+E1oYF/HOpNdn7td3Q/17vAH9/O0GL2hvzzvuhZkBe/RPK3M+JId9CruyEURQG/WsQPUHjvqPkKxAXAKFsr0W7F8BAZTinBd+97AgmloYb8haFaySl5Rhy3iwizGLHNGcGj/1fjAKJ2EcUL/bRMFlmb9qKIeGdEW1Jr0dGE0Yh1Ff3LZY59cp7hAp9brV6P1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7nHmVWLNHVrqFRtfbBH4gShpRXvvldLUgh4m6XaQDc=;
 b=hgb2OiNk9RHUGBndiE89j28emyx5GYYniv9TdoeLWaghcy4tEO+8PI+Serd/bVY2qXzk/zZ0xF7lWec7Rct6OTjEI7zL2YitKIN4vedcLTPosXcTiKszSEZcNJ+qgQHmLIoJU0aw1jagl9F/4ig2G9Kz5RJuJxEHFvt8JhPu/XDqFQpSsMHCjC4GbWHcBdk65XndrQR4Zzk9dPpgxGSwy/K6KyZMuBsskl2oatZHTJh/LW1ShUMwfTTRstfiPCY4WLt/AlZiSzxGN61fLZFQOY3M006NJqBgdGFfWQ9sUDVSatjYFoMkPThO8eShBZcNBn8a+AVx3UZzpkcccKZRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7nHmVWLNHVrqFRtfbBH4gShpRXvvldLUgh4m6XaQDc=;
 b=ICh7BBREhN/nUFVXgFD4JfK1XKLAsJwTSD/Cp0QM4IQ7qCKP9xl8ob7PeVPniglCHPqU4fLPStgaQeQndNI05sVLAo7qqFFsH9+hrKRe6olVcQ7wVwk0nb4IGuQWOrCCanThdcoLYbCpU4PLJUYN/NKQ8q0zbMlD5ItQotuVSVM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10162.jpnprd01.prod.outlook.com (2603:1096:400:1e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:54:10 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 10:54:10 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to
 support flexible clock divider widths
Thread-Topic: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to
 support flexible clock divider widths
Thread-Index: AQHdMMe7/cj9jKCVakKzhdB3/4BEu7a7MFOAgAMlKIA=
Date: Fri, 4 Sep 2026 10:54:10 +0000
Message-ID:
 <TY3PR01MB11346EF7F70F953EB5DCE90B486B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-4-biju.das.jz@bp.renesas.com>
 <apf_lZA1TgMkItYw@shikoro>
In-Reply-To: <apf_lZA1TgMkItYw@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10162:EE_
x-ms-office365-filtering-correlation-id: 705e5a26-3db3-47fd-bd31-08df0a72d9bc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|22082099003|18002099003|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 7OBc9VwUgQYoix5WkbU3+LkReV0E413tJPF/DCulyVb1nLfn5kRZGG2ZKDh/uKUrGmkPUVBdpmwnnZFiI8mMTkewFGxFiSBvh75EvyBcS6v4JNHrNQz9ZPehiKyz+N5FVVILR4vV0AMs7lx0ONMQusca1R3byJA/dYHfFq3NQ7+NkLOxiUHoenUMMChZThPaMprBBhceJArjprB0O2Lq3/LrVeivelTijllDGu4Wc0M0wJhgOgfru4TCasrlSYj7+BXN6CgiBDgD/AZlyLV7s9lg9hcJ0zCD0/fY+agahiGi5KDjCS7427tS/Lm2a7ih9cPcRePzhd1aiHfAGT8YN9tdBAKbDxwhn1VxlZ/gS5Eif8hOYuv5Hkpy9kHlelxsqiusrmoAQ7LtjTOv8VsW5gnUfhuWJaPqEiaPUGIA7xq/YB9vsm9Msh8Zp9musG0/ExQet4keVmhUEWZuTBZqlC4WUGIzXUtGslfsJC1+SehdhbNd3Xwk9918YeN8SGq6y1zg4qnf7u/Bax0jrTfzQf6DNa4Vd8KWXqFM1T2Ew9LVo+45E36FiBoxgiToH8nPclRiouf/lwj1aTvl/jJgPU9d58f6l5jIQ9A48P+8coC84D/8GTIM+8YseV+bw9F26zMu2JOurBAzlwvoINamoofPwLLCZLW2eeNOChmj/RNqOzM3p0MKco4HimJFWQ8zSPFWdwuETQamL/lfgoFNThUsRumJmTZsp7Xi4SJwL28=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mW4pxCTefjHci3eX0QH+EwkZ4fDZ+kUGpuQOwOiL9RfuponvaeJpgv6IDy3t?=
 =?us-ascii?Q?pkTGVnr+Q3JBBKks9+A7q2szHGd+QVg8o1rcCBuXkBp6wiaTlIj0f51fMcIg?=
 =?us-ascii?Q?PtGDTPjAWYBPCPDYtSflz4/e10RXoQ8fKenaFHmlq3vYzqyLx/S20BJlqreP?=
 =?us-ascii?Q?qtwdKN4fAytz/zUNWM7rrqbh5R1w8lyk9l1fg+yI515gBnhApISmWbuhChvD?=
 =?us-ascii?Q?BVJjlEm/NJ1JKLU4el/o0MNMPicDFjkmrwW92HjXBWEVsCWVmy7qGfMgsWCb?=
 =?us-ascii?Q?S60qZ6AcVGCfYY2ywtANjuhVfdJbBwSUdhCJOJPvFkEd6BcmVniVMAchpKXW?=
 =?us-ascii?Q?LyDt0tiuaW4Mo4jMchx5Tz7ZK/CKKD12vwanP9OV0KOimn0v2/7lwtF0S/Qc?=
 =?us-ascii?Q?2dW5CIi1RFkkTaOAQIS39JxTZnRmX/onxYkbdDdid9nNLVOfJ0fInwv2b1jd?=
 =?us-ascii?Q?4Rcf85IFbxvSR3VYPSs7pYJjJA2S5ix9RRpx0ocW4cnXHg7fCvzrZiQe3UGy?=
 =?us-ascii?Q?n1UT3hNkuLyQ8Da5gwparqGC26x4jJNodIpP4yMhJugJYPhV/hew4ksyqkfP?=
 =?us-ascii?Q?SVAXsV3nmQzOiP980IXRpETzODQUpmo4lXF85eAWfZDpxth9UGYjQ/umtyvk?=
 =?us-ascii?Q?6PM/B4y1cLxTUgyUKdVLLJfcMH9Jw7hCWCXGZpaTqhfwjmg/gXtc4FlcgsAC?=
 =?us-ascii?Q?yi7di8F3bm/kK8gWMQHB214bv/6PVPu/HwsuanGbjWTHc/w/BN4JiP1/L2n/?=
 =?us-ascii?Q?zonczEFHvvHJpfFm8VlkMqlIvPm5wUG4f+WNc+/+hmTVntO/hPk4GSNwr5kM?=
 =?us-ascii?Q?oM8tu9TI+h213PTbUyeJo0RoFhU9BT/CKCLYDTp63GZwUBURTQIUJHcvDtpw?=
 =?us-ascii?Q?5n8ouc+DlHnXURqjCubABALO1J0PkMKddgvnqPEFvXBMRkliA/Q9PZh5DGSI?=
 =?us-ascii?Q?Pkc7G00XTXAuuNpyN7KxygRQ2u+EsE8lu5+EoUAvmX15a7Ha0gOxlXnZw/KW?=
 =?us-ascii?Q?U3rsGUO0o+8subze6C4ecy3d4qdiFbu91LCnh9d6P0QQyjMlKRsGfmk/XVBR?=
 =?us-ascii?Q?X3/TziolRmo4Xuay+Zz9opqvmRe1fBqUueeIJ1viWztPfHiuL/t8Uqup0hE/?=
 =?us-ascii?Q?PLGjPynYeyTPXKarM593bO5pIHGyUGv1F/ai6ZqLwISHv/LLKB4cv8oiGpjs?=
 =?us-ascii?Q?G7I01drLywDuZFxGPRm3wDALuGvL2GN9w/uGUxGfCH7C+sMs9WzH2wuVMQdb?=
 =?us-ascii?Q?44XBBVFcPXi8+8aBDIjdxPNsbVg3YamXQ1VwnkXBBgsdx1L+Vq0RHvlpPj3s?=
 =?us-ascii?Q?xLsJ96NZ9k1t98xDGZGdkWE6kaMgK4tYXWFqPxz3l4V0QwFzeBpsovMLlhbe?=
 =?us-ascii?Q?coOqp68e8H+et84VOqBlGEum0sDVyAcDfB49ANu7SZcjKZzLKm2kLL75toFn?=
 =?us-ascii?Q?DfTgwkOpT4tFANggMw5FVMP1MRn3TC09x4V1hNK3lBhMnXoyayP1bER0vwYp?=
 =?us-ascii?Q?OoDnGHq+fpl8IaBnGtzILrhBoEoA+ufo2vZQT3XwNr0Jxn51hnz2xmVS5mSx?=
 =?us-ascii?Q?UHNqWK4HgIKbiF8ahEtujMB2O6GKev7jzVna6PCnKgHg4dhU34EhPYxG9Lj7?=
 =?us-ascii?Q?BPtbnglLStp/IfotNpqLf98sEUqCJOkql6fEnzkSeTPFiaAG5YIhTXhDQJiI?=
 =?us-ascii?Q?J9ono5jxiXDoao1Xznt+ij7n8hzRHpCnB9lOIiqwkABmoI7NgJFrM/WAt4PH?=
 =?us-ascii?Q?4oAh1bRCrw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 705e5a26-3db3-47fd-bd31-08df0a72d9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 10:54:10.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IuRttXRiXLFExnC6PYF2MJk7gq6PuHC8m/4DYMebMnnX5OZ4LdI2QnQ52pWU8lhwJx506kDTJu6zLVVcmwaTOW0fCoOZ8nfMXKrI+FmfLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10162

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 02 September 2026 11:51
> Subject: Re: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to s=
upport flexible clock divider
> widths
>=20
>=20
> > +#define SDHI_CLK_MASK_DEFAULT		0x80000080
>=20
> ULL suffix maybe?

OK.

>=20
> > @@ -101,6 +101,7 @@ static const struct renesas_sdhi_of_data of_data_rz=
a2 =3D {
> >  	/* DMAC can handle 32bit blk count but only 1 segment */
> >  	.max_blk_count	=3D UINT_MAX / TMIO_MAX_BLK_SIZE,
> >  	.max_segs	=3D 1,
> > +	.clk_mask	=3D SDHI_CLK_MASK_DEFAULT,
>=20
> I'd vote to not initialize clk_mask when it uses the default value. We ha=
ve code handling this case. This
> makes the instances having a non-default value more obvious, I'd say.

Agreed.

Cheers,
Biju

