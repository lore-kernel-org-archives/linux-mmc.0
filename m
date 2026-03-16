Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9F24E4AF;
	Mon, 16 Mar 2026 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647795; cv=fail; b=QCW13vSjL0uTAh67wvtHqZr5ozXyPUbxMYcOyPqs/cQlbPjCso2DjvVODp3Rjdpz8AA9tR1kyWoaa7zG5ZZ8sCv1dJc0udYtd+weo9cj/WFrdyDxHNm8pysYCh7ozo24TxlYB6I7CZhoQ2HznTpLSUMnNZJQKgumxtEDPl+npuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647795; c=relaxed/simple;
	bh=UOpIFe6+YXb/cVQazBZt5pNoEfzlJOzUttruQ032lU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkvyRyWP23pQUFIEay7z96yA1EfNXB9nDhhXnQWfmKRnqs97DcisVp1Rpas+qRgt9HPbL4BWRskHafYJq3v6REb0Pz2LozfV1PACZCblGEpUgNfxWYJExwkYlqBOfA6Lqojh8B4Yj6po5Xczq+9Pc8+Sq0wH70D4vkT0QGLOvA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eRQIFRr/; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eRQIFRr/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aizVwUVhxD9UrRUD5QYNfHvLjz+nruLBndx+z0qBN8dsbg1CqPcgOxfpmEdJjAm9GglRud+CyytnncBWyEi4aTe2PLu034/vzBeYjbbrq0N17Plp3AU8XRP1w7XUhiXPLBbOBmYImLcNVTXSxl6qwXCXEyFXJqFogOt819y7u+/SEGc6KpfvaMkEjDJaQZitlnXQLrsqcmPXPzdguZ8xVmSvnY0T7dm5tfFE3oAd8Do0tF0hO8etTHcp/aQatKbaguMpCFYDCF0vFoLJ/cm/nzffrOL/1mZqLhLT7UA8yXvBwB6fP1trJTcbX5vkhSR2bFnY2lgklSlRTQI4J/Exog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0bkT88DjppMrE30zyFcCsEnFpqqz76xgOVYWSSbKGE=;
 b=kUfhs5HvwPdfYsN9SIf1XUYfGKpLRzbHu4v+oHhchs/sYxi0xkSaUMD7WDcHeUYDY+Z0ERhTrNgAmf4gYOwblSFsnjdg7UPJnpVjBzHpVZP9+5S5mTkeVyTxnPEQ988BGAZ+TZqt0udSGHy+G37CuLd9Sv7RHWf8rHROpwV/TKH3zT4DF27uth7F6WAWi96y31ZjHcSEPrqgJ60qambW344eXRzbWztzrpwZmeId5tLEwW1/pzMy8qZi/sz6+fQ6C0lK3YZ2e5as95boCD1T0NNEhWpLlLiGkrqPsvzC3Pjpvyl3606DthBV0JHAaqgb1z4P91hOHPFwZ6PuXte0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0bkT88DjppMrE30zyFcCsEnFpqqz76xgOVYWSSbKGE=;
 b=eRQIFRr/COa9OrctNyErLahsudMXierjzyGY78WP4m+r+GPxisfCJ4PPn9Gp8ojMe6pJkia7okaY5cFjP2TVyS2C3O4V6S3N56F3O86v+szLRgnwT8xI4uqrfP2rido1F3XhC7jydKr0xuJsiFKTCRtZRAsg9XypmsmtX+vgREbjWzncHgm0H/lZ2o80cBslOB2Rz5txhldZqK1O34ZR5P+2fr026LBa/3PtTnOOIOFV8OAXo2KpTNxAwN54tyydz9TeGC7VQflUlXtnXbhMpC1Ivdf1YUUMdRsNLXYCZL9bSpeVxhB5F1wUc+SWl6RsYVGxVHSIuSpO7DAFIezR8g==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA1PR04MB11057.eurprd04.prod.outlook.com (2603:10a6:102:48f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 07:56:10 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 07:56:18 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: =?iso-8859-1?Q?Adri=E1n_Garc=EDa_Casado?=
	<adriangarciacasado42@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
CC: Bough Chen <haibo.chen@nxp.com>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH v3 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
 and add Kingston CID
Thread-Topic: [PATCH v3 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
 and add Kingston CID
Thread-Index: AQHctRpeKbd8erclTUmQth0AJ+XwQw==
Date: Mon, 16 Mar 2026 07:56:17 +0000
Message-ID:
 <DU2PR04MB85673702B65C5701559E84E4ED40A@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20260315202238.15758-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260315202238.15758-1-adriangarciacasado42@gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|PA1PR04MB11057:EE_
x-ms-office365-filtering-correlation-id: 1ecc2445-f59c-43c1-2581-08de833181a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info:
 EGIEa+uvLCfmss+i6cPFl9yXq1sYLpBuBM0ew+P/5AFA3SZn9gH7OLlFDKOKqb65RP1t09d13Cv5EiNKZc5g7CHAPYwCi+EDnZaq4vJ65ZDS5nw1Na2XPGXFzJkjXJsF8TGddHe9jQYsP7iWxo17Oppr2UTPup1WE1WfE4zrMcHt6i1Bw/TxGV/ecKkV7sVOYOrceYkLjDuDWf+rwr9/pR+MdjFLxsDzv4C0pZCFDtl9x4tPPuxGATzg8mBBvyKJ92rVVug0qtpDm4jiJpO7idCMq0ekiMKThgoVJZm9LaAP95ZuGsLRkV75z1nATo+YYo2UKRsfG2+Y6Qvu0vOPmtWDkAvqCR+Ad6ANL+QUhnEAbFnHTKuVmJjHF8aYxEctYH+ZnqSqdnR1tHtYXSSHlYQ7WE6evNQRfjm3OPB+zwHkq1kZqcfe0nJN+cxuvreadGHJUU9Dc9aWvocdIlR60oGDNsM18lB+ESa/q4ktjlPTUr8/Jeuy/+EfB77SZpypWUXpudQdMq9hMMl/AEyeym3L60pv/lNOGWNmzyHoW0F1e2nJlnub3s+fuzhRggvST95PVqdMQl+eWJV6b4VmRwaLdCMBMdoKTSgjckn7GaFEKdovSxGcp5o4ZZgs3JDbO97VpbKyxOm1dsOga913+4gpnuHzIXzuZDr8RPcI1pDToK3GXIrs266Pc8IJ/jVha3zgaLKbM3ckIVd8/oaGqnHTGByTLfiYEOkVyHnbz6kB8YY2VGcr6mhqvCX0JaCmyDwvu7fzZAklK30zKEQboPjo60eZSSRE/nWkJn9dNn0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ubi7LUMLy4xswPTnYQSmnrSRHQG8d6uC+elieIDcA9ufeuJciEB5y7mi9t?=
 =?iso-8859-1?Q?LBY10oq/V1bTxSqsptn6kUX83eFhDtIPG7F0Vau7JPsbEUrbwx2OlQFdWr?=
 =?iso-8859-1?Q?29oFOhB/JOYgQIcwWshyo7OuZAziV44PcT2Xk70AnUBw7X7jl9cl+dLzss?=
 =?iso-8859-1?Q?PWQ3WFknR2WKtC+0AgpGZ753GXWd/keeIMLePMvGwZq/bvD0kH+k/4RBMw?=
 =?iso-8859-1?Q?bweIZhRDGDHKStKDBB0XtuX2nE09GWEMOY274b7kEVlP29RgoPgBRYrlr7?=
 =?iso-8859-1?Q?69fazcsopL470yvcgQkXMaxmvate8FQmj9J8ZjoGKniMSZDMvKbHZJCdnW?=
 =?iso-8859-1?Q?McvHW1UWO38NFdPRTp97UvPW5VTD6pWadqKeJgvvtxCAw5+X9hrx2Z3fUB?=
 =?iso-8859-1?Q?wMnxRtLiff9iw+pjc7RbsK3CxjQnm5kPlxtbuhsGPir2ONoFZDqH/RbLSK?=
 =?iso-8859-1?Q?u6UL1rvmp+5KYmKuN28Cdrv5+OpN4EhFrFc+qS34x/gSGz7oC3PgLNMttJ?=
 =?iso-8859-1?Q?CCCCsaYjUZl/iDkuGDd5ur4SMVR+0uuFydMdRnNmtuOw+NwZ4lQJ7CFG/O?=
 =?iso-8859-1?Q?+o1dN6f3vsXcBXDXKplinVZbTiuXxRTcUO6MQ3MQJ/GXg+I0s9VLpS4+vi?=
 =?iso-8859-1?Q?IUCuJ9nkY8Uy2LJD9ieg7agWm6imD6YL00GG1gs3en89aG7qkHeiUBUcrm?=
 =?iso-8859-1?Q?EFP0uIKA1KarErnLI9M+sjtsCRPmlgS1ftJiHT3PQeFbUDFF11jlolXnNL?=
 =?iso-8859-1?Q?HVFn11JDtz6mZUkim4ckj1cAUDV1v2VhRcaSf2gTq33hidpA1uYXjzJqQH?=
 =?iso-8859-1?Q?TSMvTZkRF8odnN8hG526hOiJSJui6Wj8H7rAPhNDtmJc1V/tAVem/xYlex?=
 =?iso-8859-1?Q?6Gi7T1UtwJgamoFt692p08KlCD/zIEnQhdoUsSCjVj/e/JciSTCNoEE8Xo?=
 =?iso-8859-1?Q?2rDjniymPfQhLSETD3+NZ0Ly/5A0pB9TOTpEXDEO0GP1EOoEjQwD2UcKwg?=
 =?iso-8859-1?Q?yqY0eRL5rGzGDLjGfMFdS2NKPmQxXMefuMg83jd3rztanKBC7BjoDt5n0x?=
 =?iso-8859-1?Q?CFd5vlR8dVWwp1wiRE9MHdwBNORgw69bdbd31/Ump6uu+SlW7Q5k6d+DXq?=
 =?iso-8859-1?Q?1AJ/H/CKUVBCKDIj7dYyRnm9hndeI2ibAM+OIeonp6o6j8za32NWJo9lZZ?=
 =?iso-8859-1?Q?yj1BybtbAeguRv2XmcBwjYymJfyzrnmevf8vqf8c8e+0KRtjCG/bNyTOfv?=
 =?iso-8859-1?Q?dxo7Kjzj5ITVk/+GNwUNGdpMI1i+ICWAoI077iPfFkFyqWV3SMbXrOCdXT?=
 =?iso-8859-1?Q?HXrg2GNctFTEUbjc1jr1+USrndxP6Pk3og3UnXQh99rt6k+yxYDgXxJWcf?=
 =?iso-8859-1?Q?sPg9ggux8gD6p8UuddvdazPdMg+gBE1pE0BuxDF4jUy5284VorLpgrxEWj?=
 =?iso-8859-1?Q?+02BUN7/7itWiwCxq25cqCIzfZs3pxOSayxjf2kcowPFS6SnfErXhKyLyd?=
 =?iso-8859-1?Q?5eKk1HSJbApU6QE5xFbI+JqyGqKRH8xwqtn6t5Suj0YI90vRIBFOTc0ZEr?=
 =?iso-8859-1?Q?HEJPQ1DKVNuFLsEpYmuD6BwMNJUUtGO/1FkQFxyaQ1M6CkDyJGJF7aYA7Y?=
 =?iso-8859-1?Q?mwpkUK6OSRHfIzV822NlOUCSZvEfxk+6waIrWZV9QR2DKWsBotXjenQDwk?=
 =?iso-8859-1?Q?0PT2m4noGR3YsQNe1rYszqbONuUQ/0LEs+RW67tHpsVMds4DAjTnWp7S3W?=
 =?iso-8859-1?Q?HrjF7T0WOjrKmEYRwCInjGn+oajCNZHFU6YecgqHWLQ6j1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecc2445-f59c-43c1-2581-08de833181a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:56:18.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OItu70cV66qAavgP2hYnSR+RCnMdEIIdO3KrnSCopRXN3jmFFVhmn+/QGX5ySZLUoxw4xsjmY2A6cM7eeF793g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11057



> -----Original Message-----
> From: Adri=E1n Garc=EDa Casado <adriangarciacasado42@gmail.com>
> Sent: Monday, March 16, 2026 4:23 AM
> To: Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter
> <adrian.hunter@intel.com>
> Cc: Bough Chen <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>;
> Sascha Hauer <s.hauer@pengutronix.de>; linux-mmc@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>;
> Adri=E1n Garc=EDa Casado <adriangarciacasado42@gmail.com>
> Subject: [EXT] [PATCH v3 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35
> data and add Kingston CID
>=20
> [You don't often get email from adriangarciacasado42@gmail.com. Learn
> why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared
> struct since they share the same flags. This reduces redundancy. Also
> add the CID_MANFID_KINGSTON definition to quirks.h for centralized
> management.
>=20
> Signed-off-by: Adri=E1n Garc=EDa Casado <adriangarciacasado42@gmail.com>
> ---
>  drivers/mmc/core/quirks.h          |  4 ++++
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++--------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c..d736bb4be 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -15,6 +15,10 @@
>=20
>  #include "card.h"
>=20
> +#ifndef CID_MANFID_KINGSTON
> +#define CID_MANFID_KINGSTON    0x70
> +#endif
> +
>  static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] =3D {
>         /*
>          * Kingston Canvas Go! Plus microSD cards never finish SD cache f=
lush.
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index a7a5df673..9cfa26722 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -256,11 +256,7 @@ struct esdhc_soc_data {
>         u32 quirks;
>  };
>=20
> -static const struct esdhc_soc_data esdhc_imx25_data =3D {
> -       .flags =3D ESDHC_FLAG_ERR004536,
> -};
> -
> -static const struct esdhc_soc_data esdhc_imx35_data =3D {
> +static const struct esdhc_soc_data esdhc_imx25_35_data =3D {
>         .flags =3D ESDHC_FLAG_ERR004536,
>  };
>=20
> @@ -391,8 +387,8 @@ struct pltfm_imx_data {
>  };
>=20
>  static const struct of_device_id imx_esdhc_dt_ids[] =3D {
> -       { .compatible =3D "fsl,imx25-esdhc", .data =3D &esdhc_imx25_data,=
 },
> -       { .compatible =3D "fsl,imx35-esdhc", .data =3D &esdhc_imx35_data,=
 },
> +       { .compatible =3D "fsl,imx25-esdhc", .data =3D &esdhc_imx25_35_da=
ta, },
> +       { .compatible =3D "fsl,imx35-esdhc", .data =3D &esdhc_imx25_35_da=
ta, },
>         { .compatible =3D "fsl,imx51-esdhc", .data =3D &esdhc_imx51_data,=
 },
>         { .compatible =3D "fsl,imx53-esdhc", .data =3D &esdhc_imx53_data,=
 },
>         { .compatible =3D "fsl,imx6sx-usdhc", .data =3D &usdhc_imx6sx_dat=
a, },
> @@ -414,7 +410,7 @@ MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
>=20
>  static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
>  {
> -       return data->socdata =3D=3D &esdhc_imx25_data;
> +       return data->socdata =3D=3D &esdhc_imx25_35_data;
>  }

I think is_imx25_esdhc() is used to distinguish imx25 which Protocol Contro=
l Register bits 8&9 are reserved.
While imx35 has bits 8&9.=20

if (!is_imx25_esdhc(imx_data)) {
	/* DMA mode bits are shifted */
	new_val |=3D (val & SDHCI_CTRL_DMA_MASK) << 5;
}

Regards,
Luke

>=20
>  static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
> --
> 2.47.3
>=20

