Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA085270;
	Tue, 15 Apr 2025 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686910; cv=fail; b=kvkfpoF/FORW2djIj4hh1Fu/4mXC+nUK2KeGnQI0UsUqvRRvXQ9e65dxdf1i4yp4Np/3oMNTX8AkblS3g83CPmN6eE5MZnkTxxEFc72unBZPEb1k1J9cEFzCH/G+7zr5h7BtsOGrheBreRRUS3Eex2cRYcR9r5zCiD6FHZ/9QLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686910; c=relaxed/simple;
	bh=Hrsk+MkxNk94AK25NWPQUDSV3pl5ySdVSzF7dasVC0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FqnMRj9OYrM+YmsWmpGK8XLnpSNG1DJS/da5Rs9iymf47kleGpEI+n9iBJKXJZ5GIn3PxaLcHBXcxnIVV8/eRN1jV8DAzmc4i2uLu5+o3/GKGLOm8YCaHivzAPe2dOtB7tKmd0zEM+h9eI8NhlyEPi3GzcLADf5qYeQtzUd7ElA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oXXjQw4O; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oXXjQw4O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA60SRmGXjOnKAEQLOpLGx+OlWcnlxgopmyFrIY9V+idMNg5iJzm2RXax9GQ+BHMKiR/byBWfON/M90SlX6oxERKdYN58wBsknNU37lolrFJjUTh8m18elziNO4grCl4vkXdSQU3KbeL8I0TlipIVaLCApzrM+AuPmCIDU/2kYzNoAvTQxEGWf7zmHPp6M2adLhPAxawtQFXDX1QN90PXJ//kOZg78E+4OaIhX3Gd6JxU2PItEbounyPE+fjtNMOoWJVLRQq4PBX8tfnrDj+EkbxfaoUHa1xmYMrLUwukag5H/+WUtcfpHOJVcouO3EZ1HdAZ/8F2HbAVXpP41cqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzyG1JGf8tfQk4QKtEB+0KqtlKR1gGiH5FklZYY6hC8=;
 b=iGtfeMZV6IbnxtwNcIQz4HH2LDOKfHS8MvL3osbMF0sQLD6dfiki9ZGvVaY8plACUD7BOzIw+A/QfcSUSJtlbcUNMWAKOb3e3npYd7qARi2OKwMloroKfjpw3A4CeoqNcXBSecP5/JzmJX0cyhRViPlQT97QJurDQ4zUh/MaqMaEiYrZEq1zmSYM6fYPFVWROMXtfoOdJmp9/zAESru0EoXLQjaZcM7baNvMMsbLSnc2fnx9cAZsJ1NO+bGt7vrzx5wA34h+SIMN9YMQBH5Tu5admqOFv66/uc8CnlmLFzQRFtM7WBBT4/rdLSmoCKnAgTYoYekJ3DJkKhWIx+DsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzyG1JGf8tfQk4QKtEB+0KqtlKR1gGiH5FklZYY6hC8=;
 b=oXXjQw4Od2YOWF3vrswpoTadR+ppKMLdJbEVx4GKdDIiZyii1vJIqg+v+9svqXclPpD6h1+HYXZYV7kr6MfxP9aXLmLCidcYnp6WCvDeudh/uyUK3ApLbRhFPcaSNq2bRfIoVYHJpFJdu83tKGr7W/W+5CJU+0PlByYMO5xJ7rSruD2txHNeetMMdngCSGK/0tvvoWrzzpLGCekqpWJA3z5rTV2/hgZkQ5mll6JqumNWT3q8kHJIgQ2v8Tg61kXE7VaCg2YqxgYj6qBKX+4+Lu2x96axb/1C3ZXMtOQpw64hNI6naL0JYlYD+OLTiYrBdhi3+BscBL3YLHDzWJ7SHg==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Tue, 15 Apr
 2025 03:15:02 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 03:15:02 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Bough Chen <haibo.chen@nxp.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
CC: Arnd Bergmann <arnd@arndb.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Josua Mayer
	<josua@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
Thread-Topic: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
Thread-Index: AQHbqsAQEeWYoKBe402OH8kq6kt3qrOkEfDA
Date: Tue, 15 Apr 2025 03:15:02 +0000
Message-ID:
 <DU2PR04MB856729305860ED5C3C545771EDB22@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250411085932.1902662-1-arnd@kernel.org>
In-Reply-To: <20250411085932.1902662-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|GV1PR04MB9101:EE_
x-ms-office365-filtering-correlation-id: 6aac0855-aa65-4c3a-4b38-08dd7bcbb638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q2BNeMUlgiSf8bDiz3Cbmi3ZEAd8ex5clNDsl4/TMRz3O9VN6k6yRNvllcKr?=
 =?us-ascii?Q?5OsRgddUr0368RVwGcdVhLGrm6+fr6Ue7bQSgo1dO1M6yijigDikb7wqcQ3O?=
 =?us-ascii?Q?U7ldRJFtulu4Q1dlgMAQa0oUYdU57WTVRIj3HxAkph99MbMvd2lnGY/IkXlu?=
 =?us-ascii?Q?CxqF6CENUIYDV0PSne4hbKvIcwx2ZJ7n5YPyBMoL/uKYSXohblHoxzUWt1p4?=
 =?us-ascii?Q?YBkOUkMxuITp+0IEW+hlXkPcJLED71+j7YY0LvPH372QT+nGvJU/C3syColi?=
 =?us-ascii?Q?EsskkqG3dnz4H5gB0uX98DV1522MU/C88eowAqfSvcB7lvxkmCqwOgXI8Xky?=
 =?us-ascii?Q?8pnPSvDsMc6A0GeGnntFr9Dr84IQjjgs25nbofwynmL++b/3wo8I3ZDwoq8D?=
 =?us-ascii?Q?7vEPzC/pEhC0Bb6h0kqNNYzJu1Us+xheg1HeSTZIhdkCHFYPuWHiQr4a0b3p?=
 =?us-ascii?Q?iopn0QBrllRZtmDlQU7+cDnTNBzDrjXxMRcWDFY8dJBVwmha5WmG1ilvNyZn?=
 =?us-ascii?Q?KNsfBe3hwR3nkpzUvzsA352Hdln99Y2ECfrSfhM789QKWjx8NxA1E9L4lSGR?=
 =?us-ascii?Q?8gARBGvB/LAcDCWQQxbO0fs8pikchKiQlM6GXOMok9UoarbS5Azfq0zJMgPH?=
 =?us-ascii?Q?1idvChCmY77gtb4pTEw+e5vrS3Gc4RyWnxWYbmJDO3jQ/hfutvzo0mkXUFm9?=
 =?us-ascii?Q?2Qrxzuwe2RAjREyZF2vAR0sEysHFgunwrPWzOJJwJNj7RZA4xR6urY74vqfk?=
 =?us-ascii?Q?1KtJ2wB/KWnduMDcSxTVhpFu8s4RwLS3T91nMjlIUkveYqMrZpqaH25rEsNO?=
 =?us-ascii?Q?Bvw82cPzbzVBEyawRd1Ea2PzEMGQL68zidQsPRhmWZctqdwjMcWKAofMBTyt?=
 =?us-ascii?Q?neBskyYPakwIlKGQbW/J97UGN24GSwdKOiWKW64aeROjP7+jE6B7O8DavOpE?=
 =?us-ascii?Q?cAkO3l57EqgnSXAdrme8QznqjWQGxIcucWdeUFM40ICwCeByCqL17Qop1bwG?=
 =?us-ascii?Q?0GY0ekBSn3ueoDeA4TGu+U9ir+Z+FoNMl8sKu7EPE9iGqrVZucHYszpZV9Iw?=
 =?us-ascii?Q?BlAUZSl/Q7ZoUNvBJJJ6NrFzGuAp26VPQWOAgKy5AeezEm9zkHBz2aPb/my8?=
 =?us-ascii?Q?A8kYOSGELudOm6sOoIv9sIFNDrkg7LzIA+fqFnqJwW9bKkTTNMcF4HIKI0sC?=
 =?us-ascii?Q?ZakYRpuuokU9XzMQQkgyVAsk9Q1efvwRRwLH6hS4+7lvKaEEAdtgCqGF3GUP?=
 =?us-ascii?Q?ws4/7XvnRoyuLPqGxuXR7HEiHpL7aYNFDt6PAMBiqPyJQj06tMKKkmx/I0u0?=
 =?us-ascii?Q?spvwg9fqJEPaUmNLoQGeea3EXpixXG+Yjt9Oh3RhXKIKYK26isbj5aMkpZ3S?=
 =?us-ascii?Q?GRrVonEJmReIIIb3RXous83X9qYj0p6K/nc0k5nzc3sFT4hEIEpMO/OkOeJt?=
 =?us-ascii?Q?WAma1u/A7R+AwPEzm+1eveek55PpHI8fy1fJtfPjXz95I0jNcFj71A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E6N0+UvsGE9Uzurb1pG2O7BYmzG15pUX//y4fbT9nZWHbl4B4lk7xKQGfaBQ?=
 =?us-ascii?Q?cPcwzA9DB9DAleZVUYz3FrYI/kZYrKMqoiF9yMnQs91EenKyLrhXyq424KhU?=
 =?us-ascii?Q?hyxDF/gBJaGKpsrwuSE7IDSLgpJ2REjuA0PinXF+4hApEBdUTKaYD6Ga1xN+?=
 =?us-ascii?Q?u3QLRMaD0zxnf39APnGvf8tlMSCdFYvwDh5XE8m3uta9Jnwx/lbEMzR/oeaZ?=
 =?us-ascii?Q?qNyvBzT0lxf6mlccrkw4fP3us+kvtrHZ06xnF+pZ2EzRWTS2mhOAHVfRnEYg?=
 =?us-ascii?Q?1iXJe4AFA3MuLFeOUF0G250d04K9niwmq0jZUX1/QC+zf75vVaprhJAFdi+J?=
 =?us-ascii?Q?VKKlVmLpARrrnlvufyg6U4EitzZLMCHK/evJ5q8Y+ZfSeOSZtuqDnc+508R1?=
 =?us-ascii?Q?OAekNvKEGyiGC4U+2yxINL6NPjetqqhFD1CBl1Pl7wJd5d7lJ4g6bLJMkr/U?=
 =?us-ascii?Q?1R28HSGwrw7xy0a7nCDMwclKEBKpCYnt/kE13WnkE/jXhhjKfwg26kWsxmn8?=
 =?us-ascii?Q?eRasv6RseXqL2j4o3M9V3UXtCy2yK/2fvroJvlLWx12nsp+7EN07G2ViJU2t?=
 =?us-ascii?Q?kuY9IhwMe8Wqy5FCEY9KJFqhZiUKvkZaqBNgV/wqvLLYwsogUj7SeqKsVX+V?=
 =?us-ascii?Q?yaYqJ1PWmrwXlxRVqq/AkEhVU4s11Iw/HyN1dJ5z9+hoO9DpzAFEm5NGZeVW?=
 =?us-ascii?Q?LQRtGbRrrM3vLjZ2B3XBtsMy/fc1oGE7lEkzd5Rx0EgcbzoWdqLe8EovgHVv?=
 =?us-ascii?Q?qoqs0i9p3caO6kufTwIrKUxGiIHkMdBC71eNGzJ0rXgqZjSPX5fsgEQ/TqTM?=
 =?us-ascii?Q?Yw5ag7SWTm68mSLb8g4KwpRYNiWiRPUgL+jaU7PDAgpTeoe1OE0zYIB7Kkt8?=
 =?us-ascii?Q?n/1M9zb6D1DMaCOg66HoyxYRDi0n8Hs92hF1aG4iC9kUtz/9AJHJwuwgeOTX?=
 =?us-ascii?Q?W/nFkk9Zncet95svBk/Xf0JwEF5Q+oIWteAI5U2Ta6xL5LCeGsbUUQbxOJrh?=
 =?us-ascii?Q?RvW8tBr4ciYdWXaOmULnRTA9nWWiVwGme49CywWMI0v3Mcu2x4eoDpXk4w+6?=
 =?us-ascii?Q?1RCokjK1C4kz7it7NrqRoP3qyTgwCOwex8CknFNnCOJ2Il1A6ku4zhSMvs/x?=
 =?us-ascii?Q?7ejLEfQNgAtgS/M2r8THyr9GhAbHMjew+De/SP2klJOQ6KkONnB/iYmSwOVj?=
 =?us-ascii?Q?JQCKX30PF8obn9eWow9h1dc0ghRMUXc55knLW4OVPdBPfxs3AORtGZieCNLd?=
 =?us-ascii?Q?AJ+jv48JNSSvj8+8bQk0Uy+qRPkMkW4/IWWFew1BrsEFSZ/s3hbiV7e61tS/?=
 =?us-ascii?Q?IZ3qo4cHZah7UgWld7OcGy94+Giss8Mf7JIwgg2I3iLNzbMLeZ+0RAIMAyUn?=
 =?us-ascii?Q?YuWuXvM+/E9DWsNSH9u8K7ru1xbcuwpDvyRaGIJmkXF/PydR1h1suV07PcT7?=
 =?us-ascii?Q?NXqwYg8tmF5FCBoVkwXkGdThCHLh67wM7jHjVUPHFJ1mZHsH+hXZ+AXvdjd0?=
 =?us-ascii?Q?Wkw7MXSzWTH7Q/TN46xG+9f9fw+pZgJNh0ObK52B9qYj3ycGv7lWsp8hDJZ7?=
 =?us-ascii?Q?AoM0obmBw+RK5tAGEWxAi8n7mLasSUvFcWpdQ1dB?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aac0855-aa65-4c3a-4b38-08dd7bcbb638
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 03:15:02.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUE33dTT9gzepWmfstGIwAZEJ+hPRYQ0adzvNt6A1q8zmtLxs6lRFj/LfhSqhz3P3mH36ugxAL1k+C4mHK0K2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

Hi Arnd,

This patch has compilation issue because sdhci.c still uses #ifdef CONFIG_P=
M. Do you plan to send a new patch to fix? If not, I can send a patch to fi=
x the compilation warning.

Regards
Luke

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Friday, April 11, 2025 4:59 PM
> To: Bough Chen <haibo.chen@nxp.com>; Adrian Hunter
> <adrian.hunter@intel.com>; Ulf Hansson <ulf.hansson@linaro.org>; Shawn
> Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Luke Wang <ziniu.wang_1@nxp.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Josua
> Mayer <josua@solid-run.com>; imx@lists.linux.dev; linux-
> mmc@vger.kernel.org; dl-S32 <S32@nxp.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Two newly added functions are unused in configurations without
> power management support:
>=20
> drivers/mmc/host/sdhci-esdhc-imx.c:1586:13: error: unused function
> 'sdhc_esdhc_tuning_save' [-Werror,-Wunused-function]
>  1586 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
>       |             ^~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sdhci-esdhc-imx.c:1608:13: error: unused function
> 'sdhc_esdhc_tuning_restore' [-Werror,-Wunused-function]
>  1608 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Remove the #ifdef checks and instead use the better macros that
> silently drop the unused functions when PM is disabled. This also
> requires using pm_ptr() to eliminate both the runtime and pm_sleep
> operations.
>=20
> Fixes: 3d1eea493894 ("mmc: sdhci-esdhc-imx: Save tuning value when card
> stays powered in suspend")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: add pm_ptr()
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index 7e8addaed697..3c2e50d0260d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1942,7 +1942,6 @@ static void sdhci_esdhc_imx_remove(struct
> platform_device *pdev)
>         sdhci_pltfm_free(pdev);
>  }
>=20
> -#ifdef CONFIG_PM_SLEEP
>  static int sdhci_esdhc_suspend(struct device *dev)
>  {
>         struct sdhci_host *host =3D dev_get_drvdata(dev);
> @@ -2021,9 +2020,7 @@ static int sdhci_esdhc_resume(struct device *dev)
>=20
>         return ret;
>  }
> -#endif
>=20
> -#ifdef CONFIG_PM
>  static int sdhci_esdhc_runtime_suspend(struct device *dev)
>  {
>         struct sdhci_host *host =3D dev_get_drvdata(dev);
> @@ -2103,11 +2100,10 @@ static int sdhci_esdhc_runtime_resume(struct
> device *dev)
>                 cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
>         return err;
>  }
> -#endif
>=20
>  static const struct dev_pm_ops sdhci_esdhc_pmops =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend,
> sdhci_esdhc_resume)
> -       SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
> +       SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
> +       RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
>                                 sdhci_esdhc_runtime_resume, NULL)
>  };
>=20
> @@ -2116,7 +2112,7 @@ static struct platform_driver
> sdhci_esdhc_imx_driver =3D {
>                 .name   =3D "sdhci-esdhc-imx",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table =3D imx_esdhc_dt_ids,
> -               .pm     =3D &sdhci_esdhc_pmops,
> +               .pm     =3D pm_ptr(&sdhci_esdhc_pmops),
>         },
>         .probe          =3D sdhci_esdhc_imx_probe,
>         .remove         =3D sdhci_esdhc_imx_remove,
> --
> 2.39.5

