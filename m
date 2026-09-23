Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E3E568FBF;
	Wed, 23 Sep 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192040; cv=fail; b=RuUSBrQ22Xsbvy8kPdaGk1CMdSsYLw6zKm7cOKPheFQgUG0B+5H68t7sRALR7DFh0T68fDyzAnFubYMzuAQZdNh5jfOOkRCkWUB9Lm/ZVHG9vf+EY+MEHc0GR5dkWkxx601dL1KYzxTWeGRVYQ6yQc0WXAQkOZZj9muKQsZjO1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192040; c=relaxed/simple;
	bh=Ormtm78Kw+756QexGGOOgH7rZoaoKwtoVxiFw3zVVWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LGtxbWGldi920PFmdThGIUgrEb7o0gTqr/4w1venmUV/ql2z1yOVnNq2Xu4nfVsmmiw84T155hMQNep6hWWLz301wxuuNOeC/pnmgvRZgjl2gdTRCbKUS5oOevDzRUsuTMYnMcBSwEQvWw+JUZ03qlkAK/N26NI4IeM83u7SXWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bvRr32TC; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bvRr32TC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIS6oHhuNZmx+KmTbdvlLISb/t/lR/5J01do5tvHzX454jnmALQHxfFMAFo1Ubko933FC771jSacCLBOgVxiiI7YDtBxP8i9xatLvnIFSggZsl7476q0bm9tEmmMn0W3R1KICRqEfEZ9z9ybUEIZZZc52+8zd73/1nZBk1TXFiEkCPPeogXIyr26DZZhO4rI42jbklTfg/luCeF3/hAs76N15koKf33Qfs6h16t3DOa2Y787mCZGdzWFmiDzcIHkYmIaWguZpGE0YlLJRhwbxun16yfvzN8AMxrOaxzYCVKxfDeRcauZ+tRbHJ1Rx1wbCZqX7eVTeOrbvuuKAxlPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDhv6aRliQ0pafsIrb/zHPxVZ3R3h9+VZjur4th/QpM=;
 b=kFuPkKDX07sNMocFxmvWD07LEg5CWrIdVM8iNaSkll08GkpNQGfkfaexMgP6MfDE7DoGXPIEQxNAUgZQGfdQ/dHGFr4i61rL90OK4S9TH8MktiVfqtG0A246rs07i3dGl1vt4CRj119RM3f/LjxnYZAXmctvTz/FMi/5rm6N8RzqrEBBzRBVYw9NPAu1UxAIF8wTbD07z97jRCCGEVJHkIJ4eS+yPdJck6TNwv7sl6jGRG3uy1yfXW4apAAsJlezeFdOcwXrE7bXdRqPazMIzmCsUPL/3K1xDY5ruZLvS0emTYbs4V/HU0EDUm0aeqqKFVOPNIuRHhCVN34BgI4JcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDhv6aRliQ0pafsIrb/zHPxVZ3R3h9+VZjur4th/QpM=;
 b=bvRr32TCmtIYcO5Z/2nqPghOCGsXLZO3aFOKKneN924rRm2DVVL0iGAuA7HaXjuey9VNFzGoWITcPI65cBmnGi+UjOSaYRhAxQZkYCo/rBlu6ZVh3G+lDwX67SCRnrWL7Wr9job/QiGMaDT5u34oVBj9dWNDiora1mmImVIdspRRdyHrT8yadTrVM/UsR+ZWgeq83wZr6zrL/OhhEihcU5r/0ak0ydvFTKOwZxzQRe7Eml1wdUNW5Ly4/6C1nni+5HDgubEh/5oWfVsl1hWRXjAVDB6aADzBI6dVB0i1Cdru1tOjmP7d/sTqAH86ryn846w7oIeWYPng12yBVwSwMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUZPR04MB9747.eurprd04.prod.outlook.com (2603:10a6:10:4b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:33:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 19:33:54 +0000
Date: Wed, 23 Sep 2026 14:33:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paul Cercueil <paul@crapouillou.net>,
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Johan Hovold <johan@kernel.org>, "gordon.ge" <gordon.ge@bst.ai>,
	Vinod Koul <vkoul@kernel.org>,
	"yangzh0906@thundersoft.com" <yangzh0906@thundersoft.com>,
	Jared Kangas <jkangas@redhat.com>,
	Brian Masney <bmasney@redhat.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Linus Walleij <linusw@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Rosen Penev <rosenp@gmail.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>, Khalid Aziz <khalid@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Matthew Wilcox <willy@infradead.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Subject: Re: [PATCH v4 1/1] mmc: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <arQpj-pn15NRgSh8@SMW015318>
References: <20260923184612.3583132-1-Frank.Li@oss.nxp.com>
 <eebb66fa-12e2-4553-8edf-d131b84a8aba@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eebb66fa-12e2-4553-8edf-d131b84a8aba@app.fastmail.com>
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUZPR04MB9747:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7622d9-87dd-4400-a976-08df19a99aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BYkLc6qSAPfsGa4Bniwrtsd0bYa3sPJaXn9H8OMndsavrwCZ84+D5HX268kOMa862ILeyHhtw/8gwKjTOhlk37Xnh+FIMb7SN8J/c+Z90SG9vRfHciqARmc2wD2H7FmdpxF6eTc6NwgrZWpffsrd2hYERstwdrVHG3IPeEE0YJ9uNF9uzEbRtmt4fvnq3EmyFzcGpiTCZms5tM6fuzKuKrumR/3mfNl2BRYvB8X1l7osNfRiSbdx215aIQIleV4Gg1YoFA/BakAM37mcR9rdoGuD3W9oFEpfU/Am7r1rIthdi4lkQB0g1cCulAeoxQ28KwKMLk0Vxgd7dFuAzZYgkFlHQMrgFZc2gdmqxqKX9IqfX5+UhmiR3tzm/dpbrxFIfv3AK+qZMd2Hh50nQetCXbnVqrtsNF0ygxfKCLgEfUkZCen+VHNNBNwYPnEBxD8c6GNwwWe37zV7gSxJZY8Rvnv55yhxUw5RXkfP4LLSfjMrrrp4qXFfCS6mQrJY9W0pSkGCEiG/3E3VF+SWTzMcTyPQGERijTczXNfsiRf3f9axEnjwep6ft11VUskDG1kFLKWe/kwNh/K6xBKtG0ts9ccQcITaMGcACJJaV7ofZ4bBTnnZH3e4LgGCKy573ZcPqGMAEcKgw9PhsvpX0k3KE41afs3IhJiq+U1HALF156A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTJmKqR0ePByJY8Azd0wK/yHCp3B4LudDB5u0w8XtNPCN2swF8cWqmsth07/?=
 =?us-ascii?Q?18rLXiaPhOeJnx3wwaKNtlchgvdtTLJv3+A3usttW/G3u7zarfodrcvUDSHl?=
 =?us-ascii?Q?qtp8c0aQemGdg+P6Xzw3uiuLfaH7XkiEpxKSpVE+yyjt4R6d/fNwvaPiFDQ/?=
 =?us-ascii?Q?kgbMWYLpvpC7cJDIuJXq7hCDxEYUA0Bdq1Lf9VAVZ04JNl0Ld7Hw0R7aMP52?=
 =?us-ascii?Q?0fl3AN8KomOW1pyd6I9+8Fjbs4Av8hVvb6609mjNLu4IznZcWmM5/tcyCDSU?=
 =?us-ascii?Q?uoA/a6Q0VnMiSKl3VyxBUcMZGlcocZMD5B13J/EwbxXgmPtInIQVdJ1frknF?=
 =?us-ascii?Q?Ehb9yjn4QukKpeFALO0tCBu2T2qYv5G+7Qy/+GmgZvy5Ey0UTTozswxNJxnN?=
 =?us-ascii?Q?jIn4SdqUXDCBNPxdkMFSQLkw0z++t1w+o4pCLmdoBr2+eDX8/r0X4XROULWK?=
 =?us-ascii?Q?IVIAVkyfJWali3kcecXFxdHAqDtsOKoc/PG+cs5H47Cxj4bb9ApKbMwmpm5t?=
 =?us-ascii?Q?pyxrdprrBsdmfEIZc6h2VU+iRHYj6MKtPBWFVbiVoKYWQ0ao6E9JMOHDI+LE?=
 =?us-ascii?Q?IGM7Mpqbyl7prwEJjlEkQKTfI21s8bsnhfqEh5RJ254C9AaM1Hcir1DFAxwq?=
 =?us-ascii?Q?XEUkp9I8T5ATrlW5oA5KHWQM1USFFW4w/AMXhlxdo04FJIVd+6WRTnm+W1X8?=
 =?us-ascii?Q?ZE3H42aVHP2m/mxfLnF6y5O+xEZigrjlpupPN2y48C6n1yfQ6Qf18nz4pt21?=
 =?us-ascii?Q?IKQEfhwGKKfrgBtC1v5H9fnfF8SZE8tpknEyPCRfC+76mxxoIHnOztmmQjtc?=
 =?us-ascii?Q?lj8Ftpkd0GXavbUtM7FDDGS88jNnevbvHN7w4MI7oBrTdUQepGZYI7lvzLMu?=
 =?us-ascii?Q?TB+ggHbPQNOrFE+RrKwGffEriO/R6iSafJ3rc78eoCUw+uwcHPQupU+u1U2z?=
 =?us-ascii?Q?lu4xlfLmOrZvrIYEoXAaXAvO9cri9lbYU+5knvpMm3AIqepUXPr/nKKmxBzF?=
 =?us-ascii?Q?kBIdLy4Hm5KFcL3dxrX/EmRNE9w53pHhRM9KSVIR1INw1/oe+qOoDFQWX+Ax?=
 =?us-ascii?Q?dy3jVWyyXoVOUpRlNQD2iURP5T4hFI/ugfFR5yzqeI98j3XkLkF6tyHTiqKa?=
 =?us-ascii?Q?Nqg9o33mfJoRoF1rt3ZBSXakXS/F8XaVAUAn4SqeHQ8Zmc3rPLDQBPXwwOLi?=
 =?us-ascii?Q?oLveoPg8IeM0CRvziPsO6yVgITp6HkB/TXpCeRqE4Aj1MSCevA6d2xl0U9du?=
 =?us-ascii?Q?7oTuCe/9jZVqgp9v069utkpozzZpB52yUmhIAwgnvVs42L+nO0mVrMl0N2ve?=
 =?us-ascii?Q?rbV9NZ+5L2qUJgRGYi+eLg6qM9AQQ8HaXQI7fZSYrF+By0/HFzU5/mAhXGDJ?=
 =?us-ascii?Q?VHvzZAA4TvXQExoEKy5G0qXXvN0H34A0QxHrGrM2MELKwP/1NCkwD8R64CVA?=
 =?us-ascii?Q?HDtcxc980EuND7rXwYs52dqgZAY/bzx2US22V76fSEHWWHhtjiEOuuQs3sgK?=
 =?us-ascii?Q?4AczXsas2KkdXMj+2CYKKWJ56gUVjR0Q77ylgLQasG2Ohu93neAsxBwzQt1g?=
 =?us-ascii?Q?c2VHwh7Iw97r9zpP8ssExF3SMOiQ05XLA+oJYGH2yndfKrm+Ca4lYH7p6WHJ?=
 =?us-ascii?Q?P2mEDtSrpdsM2gE8/K2Ef/ua/Vfu/fKuDVDQNJXXYVSMiAd18XidIjStzPD+?=
 =?us-ascii?Q?6UoADQq28+HqJ2C1r9m71WHpBIn2erxMCTMKloiVpGg+8ycJy+Q7McF5Tyzm?=
 =?us-ascii?Q?9iZI2MVacd0xrBgr7GFwK2pfb/gUjIbGvUxn31yU976voSuN79vZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7622d9-87dd-4400-a976-08df19a99aa8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:33:54.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA99nDc9kLPwQaOTy7xuSdhPAqO6NaBvKw0A8ECL05ImeAU8YePzCYEXGA/LnEnw2zbx6qBQqB3vpWNitrLiX9BpL9fP9jR8+0uXFMJ4u3uSo9Ao0wez8Qp7+BNEwMS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9747

On Wed, Sep 23, 2026 at 08:57:04PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 23, 2026, at 20:45, Frank.Li@oss.nxp.com wrote:
> > @@ -214,7 +214,7 @@ config MMC_SDHCI_OF_AT91
> >  config MMC_SDHCI_OF_ESDHC
> >  	tristate "SDHCI OF support for the Freescale eSDHC controller"
> >  	depends on MMC_SDHCI_PLTFM
> > -	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE || COMPILE_TEST
> > +	depends on PPC || ARCHMXC || ARCH_LAYERSCAPE || COMPILE_TEST
> >  	select MMC_SDHCI_IO_ACCESSORS
> >  	select FSL_GUTS
>
> This looks like an accidental bug that should be removed from the patch.

It is accidently including my local change to build test. I found it when
post it.

>
> > @@ -961,7 +961,7 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
> >  	struct mmc_data                 *data = host->data;
> >
> >  	if (data)
> > -		dma_unmap_sg(host->dma.chan->device->dev,
> > +		dma_unmap_sg(dmaengine_get_dma_device(host->dma.chan),
> >  				data->sg, data->sg_len,
> >  				mmc_get_dma_dir(data));
>
> Since you have the exact construct in a lot of drivers, would
> it make sense to take this one step further and introduce
> a new set of helpers in drivers/dma/dmaengine.h, such as
>
> unsigned int dmaengine_map_sg(struct dma_chan *chan, struct scatterlist *sg, ...);

If add this, suppose should be set of map_*, like dmaengine_map_single(),

Vinod:
	Is it add new APIs like thats?

Frank

>
>       Arnd
