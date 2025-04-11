Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C02111;
	Fri, 11 Apr 2025 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369382; cv=fail; b=pnB/926ggYOGvGUkYdWW9iQ26GD6wAc02/tzBPBXOWF9AkVB/z8IC0lnj6vUcviLmIhwT7OfqwMmSll56G/9PBEsouAwTR6o5ItIMB6QdpzjYpMiCGGgf3XNmQyMonKI3w1mjphVEoqPHg3x96trB3Mqil9dobjgJGlP/uD5r0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369382; c=relaxed/simple;
	bh=zgVS1eS3I6nJ7k95DYWOVY2jIcYtYOl2kIUmd3njbIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Om/j0e8QiXZYsHV/NcD+WEKubarkESBMBnBe9AsNkmtEqyPhD+r+SAtCjgGLTnKFJUhyAXwX85e/ELZct0EoYTSzYwjxokPDBBNONv7TWqiP7U4W8akgQwEispAeVxKthcgXvw5rpc3WUXDMfsA6tCAfWhPzNqDRDGxt4Mtjsyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pp2eq2Ne; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pp2eq2Ne"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5gAAO4owUdtAHKXRU8tkPvgD3qlZX4XCoDtLtAYpmfdNUpO2D5kJ7Xyf9UkrcwHLb1dXtUUthqvXnWQlg74VWluFIex5kWrkXp1DR3OZI1F9oWDRB1bHE6kNm3Ay7Txc5uHntUPPkySqgBV8DjJBNGNW8R/4H+4E8hxYeIvsXYkyvNLVkR0uCaWIf7hpMr8aT09UJwURMR0A3FzPSwD02m3VQfaEXhuNr6RqCu5oeulPzJiXfvYc4nR5//FBiDrQ1uu3EBpMshbGiZgZTdSH+yf7mtjXgN7NTW59caW6/TL4XLOBJckInrqBK9jzGD/+0D024GhRTOdkJQuusMIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBGOPA0rSgsOkUxC0jabv7gIHO1nS92cUrArFFC77vc=;
 b=NTviZOouuevOZj1tGe1+0dQez6fR7V3i+T7loJoE0J9kmsV00+3i2lRa3gOGbWVnueNntkI5fwvGrsUPeI0EZZzupS/Je5VHcu4ORgU6HItq/dcxiWWmS1xwjwgWb/qT7DB/hxAhVPDKHrhVPcuY6jtqxPAfmqPblEtg4Nrt7Sa80gAF+Q5P1pqz1iIJJEWq8o7Fcc5ia82jl69CiJcajAJzlm7xv9/mb0Cb1PtzMJsW/MzPsqV+wdCip6V9LGYOowaNGdpBG9nlKSKPHOne0gZY1G7IPk5k9xbrmoKZOdfHhkrtVLMDjoyST/fFK8zuRcztYLmeS5KOG9RWs+EMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBGOPA0rSgsOkUxC0jabv7gIHO1nS92cUrArFFC77vc=;
 b=Pp2eq2NeWWs/JU+3T1nGHhKzbpgnzeHJruo1zqLkAZ+9RbPHshClzMdCkXeLBxYrm5SrxbAwnd/FlDNy3ziyaQjhP+8rFZuE4sLs2oqJTQsCFSidLslgHaiViTn+rUz5XOOqfY0zmauGyxdR7ObFNRIetmttzN8i5vWdSSHlgPf38uDf62MQDjuKfSbGyfJSAkGx6iAoPYlYsxHb/yHslId/BQDwzSG9636DprEK4pQ3/MKS9XbuJmFchN5PilXvukDDXLACaiSNpn8CUZdhxFkDobYohUEX4MT+egebTx7zXChIILlIT1OU88PMjsim1Ud65DFOo9J1EgVglmXHPg==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AS8PR04MB8705.eurprd04.prod.outlook.com (2603:10a6:20b:428::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 11:02:52 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 11:02:52 +0000
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
Thread-Index: AQHbqsAQEeWYoKBe402OH8kq6kt3qrOeTE4w
Date: Fri, 11 Apr 2025 11:02:52 +0000
Message-ID:
 <DU2PR04MB8567B7E1DF735B19F54A987FEDB62@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250411085932.1902662-1-arnd@kernel.org>
In-Reply-To: <20250411085932.1902662-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|AS8PR04MB8705:EE_
x-ms-office365-filtering-correlation-id: 98d6c957-855c-4ce4-272e-08dd78e867a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nFsPSbuK8W8uAraQhSUWwCYs1oqXFHoJde47S6WqlZR/vtMUKGRIrqtxsP04?=
 =?us-ascii?Q?z4hTHiEOGLMaA6BRJodUYHyd0UpTWTMvdEqSSEJwionVu6i9Ad30hf65/Gdg?=
 =?us-ascii?Q?jaezMV7Zwb52AgbVzf349txj4UWWUAK4E/7e+H7ujc5cJ6AgjABYvghH3BJw?=
 =?us-ascii?Q?PZGEYyAWgi2Q3GhKJywTPLPuvlabdGpK0wu1+sNAoLDBcoN47Y0d3MJmq96w?=
 =?us-ascii?Q?UBHKGbNaPFkVa5YBHG+4c6JzjCDiP9xD3pBOl4lvdPx9v05/erqD2GwgyMJ6?=
 =?us-ascii?Q?RveZpw4GFJYGhnEKoiVU6hlCQY5C4Fltp148bNm5pJUJqf/Hr7b0vGbdZjGf?=
 =?us-ascii?Q?Wg6qHsrx8pF0L+Hl6dfuXCEPhFB8OiuiFc5m539C54CPIjlFj7gPC3VmV8wP?=
 =?us-ascii?Q?/pHb4ej6eS7j+JqA5Y29SqZMXENdtSEIKco6Yv6m93qiL33Q4uOztn5Co0xZ?=
 =?us-ascii?Q?BDPSCFmTnKzgC3yH+t4HC9qSLB7UoeKGCdEBx4WQlXaUyD4PPznzfO6ndONk?=
 =?us-ascii?Q?zI21Xl4cHMZK/hrJhrmoY881ldb6ruqJuX+xMoA1sLwMpT4dEhmz9eskhsyn?=
 =?us-ascii?Q?ungumtCXHkHO0+0FIBl0dmKkuL8+Vm+Oi82RV6Gw/O2QDNNwtIp6Gvg+rf3N?=
 =?us-ascii?Q?GbO4ne3vk5WRu/39HJMT7cWWBWCuOf4RfteoeUKeOWuFkekx8Mgz0CyOp3JV?=
 =?us-ascii?Q?yELP6Wa5FcHwNUIDpPdfaPlxlB+eAPuJ4wxTBfR1GtAxkwE9OOvR8YT8MdOh?=
 =?us-ascii?Q?LTC9K+qG3yYgA5KtWN2Z4hr6QRzmkzrBo8lJXiJWTCVitqyx1VVkOrNEBaqZ?=
 =?us-ascii?Q?wJ9Kv4tG6ReQoHiUnIaXuPGbbvsLDp4G4jVvZq1pi0RDcFda8e8rJSUk+JJ2?=
 =?us-ascii?Q?HKeZcRFsNnzJPfjst2Aqh6WTNOaVqmAhUXwwjn7srdBKPDydcIJD5yRHgv5w?=
 =?us-ascii?Q?bKJqRZ1zIsaw1iNA4i9OYQoXIGaMDnnz1X45H3b9rVzQoEcwCUf+ZV8tsLMK?=
 =?us-ascii?Q?Hbqh6z/QZCCeD9/a08PWeeIfzvb/bjfW3tDxRsN998HIvmUXLej/NJb+O1zc?=
 =?us-ascii?Q?ouqlMDAehP138E8TWmORsu+ydv2LczgD41dyNQu8UK3159kdmPGZZtifzUFB?=
 =?us-ascii?Q?SGf2cC5BvfNE3TuG6PLUcejxN5BXgj0oLBlIF1fvkQURphqfcGvcX978MvWH?=
 =?us-ascii?Q?SD1oPedxE4hcxGEQcfvKQaPb9edAqvoxyH0gJ4v4P/P1t3+Q2cfDCOdLYTT0?=
 =?us-ascii?Q?QdphcUnwhpir1FMuc6CsRNvhzyVdCedzfSAJ2X98NbcqLrSB8KJ3Dn1J0Crn?=
 =?us-ascii?Q?K0MM50033Ag4Uk3gU/016xXBbP/DVkhMceIZTsYX48F1kQNteHJqb4C3xhvM?=
 =?us-ascii?Q?QTJ59/gQ/6HJQoaqbhoLPnyovaiSPbM0L4jqGQ9psOy0BDGQuzuGd6MZShWb?=
 =?us-ascii?Q?fTwBzjajC3cPZndeRQ2pO7oPZjKcMbxXmSm7dvO5s7hog84D6JSytg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qNpUwJnvC0Xr7cPUVfU60PH6syOb0f24a+aBUGawQ0uX2mTFPHybVCQz11fW?=
 =?us-ascii?Q?CzRhVtPJzKtVpfRjRdIw3QFYqXp4XKAm+WKwTZpFnbElR8J9KYxf5pfp9/C0?=
 =?us-ascii?Q?QWFr4v0jbksTLQZhq+8ZGdNJKbh+Jm5vGqrl4MHvtDgZHuMepaM35Jkmxy6/?=
 =?us-ascii?Q?JBf9BMyBbd6Lc0QbIY9QJGVIg7DtuKzavEtLgIAT0rHPm6SLon5Fog5mJ6dj?=
 =?us-ascii?Q?l4GgbQakSK56Mmdf5PJNcZr1kRJPtcDSTOb9LBRvncwL7CamNmElNG06NocT?=
 =?us-ascii?Q?jOik8+8HfzRvgBgr3Zd2tayZ3CRuKNq5vLgC0sPqNJFR3rQgdpvWIIw9OhXI?=
 =?us-ascii?Q?03QXH4iGL4CQRx8ZXkzbb1r5HnGKPzJ4W1Kvum6uLe7ZS9cVBFGJQSJskeGv?=
 =?us-ascii?Q?lKgeQghxls6b6COfvxiUEoZr4z48iHMCWV2qm0i/XZnUFwBoVzuNp8nFua5w?=
 =?us-ascii?Q?hYdrDnlqZ+4TyQRTM7aciLQBNJtAQR7H5b2EXg0VrfiL+DEtY6eaCLNhCXxE?=
 =?us-ascii?Q?wEEq5IiDvRUEXmieu9MW0uYzIdSRmDWdupDJD+11pgatQnQYkAsmpTB+AWyF?=
 =?us-ascii?Q?AFEP3MUfyOXkpNSlHEIK/41irDdSiUahg2HsE9cSP204ZJNlLxt7TPiMCQNE?=
 =?us-ascii?Q?zgfXA2CaXFblACxdGljK4a5pZFYt46VZxj3CUdNoMCo8rE6UtKDRaq233rV7?=
 =?us-ascii?Q?FR81jCQh8WFjryzoF5ED9WRJtaJU967y+e2P8Cbc+f/3+ufCqdSRFEKA8tI5?=
 =?us-ascii?Q?aJOOkxDCHjmF0uqiCJCLHdL5DMRMlMuN4+FXsQSkafotCUzA5gn/OjGu4x1j?=
 =?us-ascii?Q?wsT6gzJZHj45kpmvdxMJt7M4JImOOXc1r/cMd01/SQDaxjXegtPQaQDApbZz?=
 =?us-ascii?Q?WYVhspWVfA7LBRzsPJnKbHECqfwY2MlfpgRN+Cm6Qn1ixi53AAstBOAnFbM0?=
 =?us-ascii?Q?SnYtnh0AbcSUi/JUyFs0e2U/AMzqhbnFtcw4rgeNTINz6POJN8PUfLTP9wso?=
 =?us-ascii?Q?8mp2So+EL0wlOJEwpmbw0adlHiNs/5atwsaw/Va39xmnaFa65ydqZTNM7JS9?=
 =?us-ascii?Q?EENTs+5BG3fKpU+kGTLwBqXh8DCR1acBBlPVtqltmODj7WeHLbpgo1wAYp6R?=
 =?us-ascii?Q?ptXRbZg02ZmyZTOuZQTRw21C9ppwne62a+qQW7BpnXQH/9Ta/1Cu1eukIDNZ?=
 =?us-ascii?Q?EViepyfaMWoFPX92N6XZ+Gvw56YfowkxzA9/1dDrD/bZTMpbxwzECgpKs6Bi?=
 =?us-ascii?Q?QC4Yp5OEYzQuQ9jTD+95KLTsKT5FY51kko7Y3An+Ul2JGVG/npqfQ5+Xy/1c?=
 =?us-ascii?Q?NPc7jnrWqBNXVG44f5BgLVXxwfw0UFTBWXX1Mn5424DslSdslDWEpxriIV5E?=
 =?us-ascii?Q?UAusr9gwl9iIJJXkXXEl+ltYlmwII/GytMFaHOsy6g0f2OOIZqte1l08aKX/?=
 =?us-ascii?Q?VyROG88Fe3NhMjnvPC80froK+1VRDT57rkf0XZDkOzQxh/eWiwQwxGgmK5Ab?=
 =?us-ascii?Q?wH218SQT436Rg6ZwCi/1vJ0egl51kQWDQYEOWL5bnqEVAHAvhnsMMEoFR383?=
 =?us-ascii?Q?Q3IBFzwFQ15svWjv4ZBrd7qpLMy1v7DtjaB5CS5p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d6c957-855c-4ce4-272e-08dd78e867a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 11:02:52.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BE9UJ/SP8y1PQDF17vQwvity71h0jq1Q5DHPhQsGeOuff55arbFeMf7Hv/t4FO7iWQYR6WXeunBWPBjh6Slhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8705

Tested-by: Luke Wang <ziniu.wang_1@nxp.com>

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

