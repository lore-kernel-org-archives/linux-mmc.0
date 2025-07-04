Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F12FCE38
	for <linux-mmc@vger.kernel.org>; Fri,  4 Jul 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624808; cv=fail; b=YNcr+tA6aWYe9dDcdhgREvlUGn16WquFX3s7nZqHCg21R6NPzENsVIbEd0Y3OYBqDHMX+rl/q8j7fSWOWtc2oGAgctIBjozuZOBGe+NEqTyw9hUaoAum/SdViPeGpGZe2p8RGDdZI06rER7FvLk1WEuiFbPurOyRGAuiPxl7624=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624808; c=relaxed/simple;
	bh=9P8Ln/W7a5e0gPUxwzkoUjfGyiYdkx4O5jk0RVqmu/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=REK0MEivvYkCDJxvEbiiVrTXoA1HO7GHrzgz8deXBG0i+4d2Cuoxj4jpZq/fqY3AH278QVFg1mLuA1WLjQzdORFQDvpIDHeG6Jg5ge+1j4mQ+vETRhW0b6Tua/4wOaTICMvjguCglznYTFCi2MCEcbp2Pe2UXqof565fUuvzxXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K/noYO/I; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/noYO/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZx8OOaEgFFLoZTPBNDwduuGO8s7AeTvInFVerEheSmfXNn3leZpbggUFq82bkghkiewtiqII/jBd8abijLB+XrJSgBPIk4Mh8ZKE0B3g6hCOXh5jEwdWRZTLxHA5o1/iD2yZydgSMHYB2PaVDlPsO5ZYv9LVMVeYgQ/ZMLkccG7qnVG+rwE0jOPgk6+asluWU7ys0u1dogrtyWPpVQGmVoQpJWxO7hyDzKNxCIEr63Bkta8I0evf4WIXhvtd3l8/TT5L7/DvyrHDVTqgJcb5mpsdzLm9/HaE4VxdMzocjmSy5+tbPU4egiDbhRaNdK5mtYgAh7h7W/Pb2iLUPfFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2dwTDhUMO3rrFscBA7UDat7vfMP/RVfueGnP6pBuZw=;
 b=icNATrJXkAeEuM0BmB9QlZmB/Oes7krIizpAFxUA9dY5ssYsn33GNCy5ZlkQooe4j8mD3FxMtQiTAXe84cSDEcAdRPVsIziAHvOozQJ7jxGiII/LFa8+ks/kUi9/vnu+cioPYEj2D9+lg7OCIt9S9ZNSt436dzIUDaXcwkX6QE0FWoDFtdWC/gBKhZYcmgUWigLLUHpZRZoGPtVcVsWt90nkfKvt2fdVagThMKlwmDAfh4xEKsmTUSBI8X+mLNipbcwi+kplcG///AwdIauNeqjta15f/0+74y78MT9ZOU9P7vrBopDkJMe5Oq2I/tlPs3AGQs9I5q060hQ4YfLygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2dwTDhUMO3rrFscBA7UDat7vfMP/RVfueGnP6pBuZw=;
 b=K/noYO/I4DLwmLPoozV13Fa9taz4AcjZ6GlKkF56C1nIwaA1pQuVNsB/W6DlVIDtnj8OI0ytEUDcrZRBRKFG/74eJO88Uv+w/fMgdNIzXNrf3Y1/qAJwLOphkYL+7Rwe/3Q/1G1Cysj6miIsXIAPg8eb/+nV1feK9mZONAGT5RwogfDweV/Q55LI9c9MLBrU+UvMfxCBZiGasrW280yWQ9DucbYbAwlH80/1FZlFMjjh+Vbs9dZ3YWinEwMlj2BuUUXDzdd/6CltxR4GaWc2iK6nWCOc0bz/ClLdNzAHbrbLv88rfoSflhD2WOZXmXRsyAmw76wvSm8d+zhmNbF77A==
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB7987.eurprd04.prod.outlook.com (2603:10a6:20b:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 10:26:43 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 10:26:43 +0000
From: Rex Chen <rex.chen_1@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"avri.altman@wdc.com" <avri.altman@wdc.com>, "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "wsa+renesas@sang-engineering.com"
	<wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 2/2] mmc: mmc_spi: multiple block read remove read crc ack
Thread-Topic: [PATCH 2/2] mmc: mmc_spi: multiple block read remove read crc
 ack
Thread-Index: AQHb7M4jlRSfYTQY4EGjWTfHaITYew==
Date: Fri, 4 Jul 2025 10:26:43 +0000
Message-ID:
 <DB9PR04MB9626F66BB0CC3539219D3B82FC42A@DB9PR04MB9626.eurprd04.prod.outlook.com>
References: <20250627025032.1192873-1-rex.chen_1@nxp.com>
 <20250627025032.1192873-3-rex.chen_1@nxp.com>
 <CAPDyKFrm+KE_XuzuVkLeykmwmRkbNaY8aerLgs45uSWex2SLfQ@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrm+KE_XuzuVkLeykmwmRkbNaY8aerLgs45uSWex2SLfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9626:EE_|AM8PR04MB7987:EE_
x-ms-office365-filtering-correlation-id: 0850c0a9-c24a-4aec-0cf4-08ddbae545ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v23p1A7/KPXe5uqwqfzuFOARd6GWrAzvoDOeKf+YUjr/yX/hmWZWbFxAZVgW?=
 =?us-ascii?Q?VY0g3IfvXRODpQi1i7er2ofFgyhRmENRIh9VdmeVSfFR7QQUMSzpvkvf1L5s?=
 =?us-ascii?Q?cadeMaPEUyU3nGQiLIuCc78h5gx9BpzOYaS1UX11HZk06gtq303mpS0yzRp9?=
 =?us-ascii?Q?1nevcupAxqDRkCoW+DsVC3p2GaU9unC0/9vTWjcmGRyZ2+PTQ4P4JhrUuGNi?=
 =?us-ascii?Q?oBO7zdc1RN36jrCtRRs4XQ5KB+hoSBWTmUZO/yzHdQbwZHumw76IpfcrAsSW?=
 =?us-ascii?Q?nsC762O/Ce7bk6aqhMKDhBhi+LaRbrzAYnYayx+XhQqwzxC1r2bned+3Ido6?=
 =?us-ascii?Q?jNkHCpzhbAu6NvX0ENetiiogZs4ulwpJBTAjvFMdZd0+lEcrCyGOVyT4oC7j?=
 =?us-ascii?Q?RwKWEPzaLzO5XWGmsC75ZJcaMHX55GWr67kCgjCUKbkTuIsf+7qG/jRZHTWZ?=
 =?us-ascii?Q?vFaExmeq9Qt53FpH5weUb8JLX1nTjGBSLecwI9byRlyIe4tbg/k3wPt+s+Rp?=
 =?us-ascii?Q?eGoLCavSWv9Gg0igYDE/jspJjCDZeifDs26cbIHI9LA0xWeyCmvZTYraqwlL?=
 =?us-ascii?Q?MJbeaYGdUgB/dVI7qT7eqUKMn8HvG/hiRWQg+QYKnzxct61/ebTZFMb+zsB+?=
 =?us-ascii?Q?vZFtmirv9cRgQeAHOGXqp5GWwr6dMX0VeFgxR+YzV8me32pWvSftUtI0YADX?=
 =?us-ascii?Q?WITB5t2UTSpWF8OjYagvlQECUS6nEyhprBLq+EIuUmdBEjKYnbv9I7y+J9Kw?=
 =?us-ascii?Q?nQn5hbw/iL4LViv6fa86WhPQoslZJ1BqqH4W18cBjcLIvqwFkTV54N0/dap8?=
 =?us-ascii?Q?sMg/mmnTCESkFToyLO4IL7o/iWXZJCasBeflY0F19OPvxiOJoBX04rfnptU+?=
 =?us-ascii?Q?tWfTXAQw8e6BIobwOCtjSTXY02kNt65Mh9Ft2UpGXdpHhwAZWcXGNYOfc15y?=
 =?us-ascii?Q?5kBA0RaW5zAZ5nQZYVfd5+oiJyDZSUgbg/lhmKzc+pj0udiWmwP6YoFC9/eQ?=
 =?us-ascii?Q?e6kkv01A+Vx9X8lmSZVEQVecKhkwxnb71mnPV2CTd+OgsKgXyazY40P6HRpK?=
 =?us-ascii?Q?R49eQoXbo2+TiXt5zjUWKDc8EoC787ImfbhKQpn+XeBLs7AJ6JqkS11AgFKs?=
 =?us-ascii?Q?GUil3X77K7editjlCwj4v7Ow1uYczxTgK/5YhrZgJXvt2kDES3J3Xp1KRK6i?=
 =?us-ascii?Q?gio9yTsADPh8ClxPW878ihC141IJbS6K7G6e8IckL6HpEcXrhI9mQsBpsfk9?=
 =?us-ascii?Q?693n4WOlUgYpfdFINB1jzjVVSGAukTYp+JX0svzQBvSkppLAUWNYTaJzNa79?=
 =?us-ascii?Q?gnrDY7Hl4mHnRHjHJ9VrbO7KRkuTwwTTvSA0FUZLh9QfhaV7buM2NsiL/u3g?=
 =?us-ascii?Q?CdYX/zJxA+1eW8y5GoTzkcsqjUJhuVzPva5YbjyFazlyhDna6HwRJ1B15Nbi?=
 =?us-ascii?Q?+ayev71rsRLXZNwUukHIHB+690Str7ScwT5UEsEAEEHn6yS/cG1iyA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n6+7GO581Qd/Ikx4NYql4AHX7LblExSHDSxvH9QIL1k1KB+OD4flhh6Kpz65?=
 =?us-ascii?Q?zmNxZjEvZyHypC8M4YbaD7cg04uRVBmGhpHAlk/VTA/SNqJk/bj7YqGlYtIP?=
 =?us-ascii?Q?ctv9NRihA1cn4zWP4u6h8rjZ+uDwBPjrii59KhpA7k9PlaqNxxp1Sn6nWFK7?=
 =?us-ascii?Q?huqjhgfk0onxqiuCXVl48pDMtJBSaG+eN+pCNeSYsEo4lFuWjgQvHm+m8Wrq?=
 =?us-ascii?Q?ieiiwJ3Q2qEWwWC3ZN9CJO+H+NhGTYyM9keAwCMByZnxC3ZuD4IsWvdKI9g3?=
 =?us-ascii?Q?1lemiikwwX3TnqNP0zn4HkRWlmr/bQGWUgIb8EK/d2OmdRlgo+G87ogtE9H9?=
 =?us-ascii?Q?9+efrichxDumxmTZnmovu6cSLYzcde6k+v8lVRFtjlxkym6ULUBpH7aJP9bT?=
 =?us-ascii?Q?2snmaL3TuqrCH7E8FJjolaKXprL+QGRCJiaWgwk1J2Z5Mwt5r9d0WpGAz+iJ?=
 =?us-ascii?Q?WVoKEPSBgVU6gGZfU5V++ItEe8aAbW52qe2XhSQkBp7/ZCWQ2mooGMUQvbKa?=
 =?us-ascii?Q?kCnmHkvlJrwIwqZ1cQ7LQqW0puTbY0IrC2XJXPRFeCwMs/wIIakpGQlGtgNX?=
 =?us-ascii?Q?yUXMoyk3qnYEnU8cyqR6UYlx9ivz61/v/BNUQw7b5RHloJU27wHKtwO69IFx?=
 =?us-ascii?Q?YKqzzxfVueCdGah+qcAM77LYwXD+oZgfBNLRbw9cEmLPSYjGsMntKgDStrCc?=
 =?us-ascii?Q?LGe4qXSVi3X0zMhUE0tkAVvmb61NU5hilbWqiEA/iXo7KAKTZPwioOtn3438?=
 =?us-ascii?Q?NsabD7QX0gDRugkQzxC4yMDGjUsPhgOkKyoOrCvViwdsiTG1pM8LDqMdxk2d?=
 =?us-ascii?Q?Rl/k/PSPgFy3UBSD9NwtkHqMAhjc+UjYC9Huv79gvvaQGBQfilJy1l+HL42g?=
 =?us-ascii?Q?id4+6MBSltcf/7f6yiuUG9rWY8+uVrO7RmpCOOHwv3BV9cTXENTIUN5oNCDv?=
 =?us-ascii?Q?uRmozE0aWreqbcEYy5WyNG5NfzN6jCCdFNZDGYOIGfJXf6Ahxkn3fR0as7mq?=
 =?us-ascii?Q?XFVdd6sStriHmWycooqTdYQFCEf6eHVsedPYgk0k1aNWARs4yjWtSGbr74Zx?=
 =?us-ascii?Q?3kZd4N85Cf//E7NhJ/Y8eGKibC6FK90K3chFSPQzb5UMgVgCxl3DFFYBn9wa?=
 =?us-ascii?Q?s2mXhryjL6KlIQ1XCiwGCSoXIqwVwqimXjD8SR++GGI4Pr+2yLpMYqq/LI7S?=
 =?us-ascii?Q?mO99qmUFhk2rQUTmNAZdjpaNHA7Y/M6LJikQrGTQHjeesu2gZRGmntTcmJGC?=
 =?us-ascii?Q?9mIEtaBNMXXs2zm6m7ikiKhf0DjUPZFSkNPTXb9+JB/ZRYDSUAW6dH9ntjJL?=
 =?us-ascii?Q?mHnPi6t0AwOcmOk4vsVsAzaBTK0dKKM1DkYAynQJXTuy6dXvC+c3kuJ7dNHd?=
 =?us-ascii?Q?jPxOO+4JBK+15UNoTZcSA1V29j6yLkPeLhPlC4Vd9glU74SETepI+ulpz+P2?=
 =?us-ascii?Q?BFjHgFqhtOegJdALFlPXU8fD+0+ck8Fv7tjku5xOYL93r66CeYEWq8uBhog4?=
 =?us-ascii?Q?I4e6aK4vQFhGDd66vmVK1Or26k/CRlwIN0R31+jc6ivUnsNGA/DiR3STBLok?=
 =?us-ascii?Q?LsLovZMvP87IiMIm2gY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0850c0a9-c24a-4aec-0cf4-08ddbae545ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 10:26:43.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TpkUvq5fO75Qo43CkF1knud9iCAOZ+bK4OtxaJ23IU3g6kfOS5ByCgI0MFPcTwwEAsd67Wf0g1xadQ7WRWi/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7987


On Fri, 27 Jun 2025 at 04:50, Rex Chen <rex.chen_1@nxp.com> wrote:
>
> Multiple block read doesn't need to read crc ack, so remove it.

Why? Please elaborate.
-----From Rex Chen:
The origin implementation without my change, function mmc_spi_setup_data_me=
ssage builds data transfer sequence, transfer one block data sequence conta=
ins token, payload, crc, and 29 bytes scratch->status to wait crc ack from =
sdio device side for block write, also 1 byte for block read, I don't know =
why need this 1 byte transfer, and block read transfer failed if I add this=
 1 byte sequence.=20
I didn't find related description in specification about this 1 byte transf=
er, maybe I miss it, if so, could you pls let me know the details?
Thanks.

Kind regards
Uffe

>
> Signed-off-by: Rex Chen <rex.chen_1@nxp.com>
> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c=20
> index 47443fb5eb33..f42d5f9c48c1 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -563,7 +563,7 @@ mmc_spi_setup_data_message(struct mmc_spi_host *host,=
 bool multiple, bool write)
>          * the next token (next data block, or STOP_TRAN).  We can try to
>          * minimize I/O ops by using a single read to collect end-of-busy=
.
>          */
> -       if (multiple || write) {
> +       if (write) {
>                 t =3D &host->early_status;
>                 memset(t, 0, sizeof(*t));
>                 t->len =3D write ? sizeof(scratch->status) : 1;
> --
> 2.25.1
>
