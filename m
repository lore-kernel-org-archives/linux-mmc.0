Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BE42589D;
	Wed, 23 Sep 2026 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199629; cv=fail; b=c6QQyXEtxpHVixJfo1p8SBXMeThHrjXAjRFaplRJ/V6dHDuEma5HAhrp4tFYlJb9uSFr33u5MYhIpezS6LgNh9BBYGRBXbnl/vgUpCO8AM10lsuqNpzYnn5Kb88AGuXEd+OQYh36myPxCzXpA+QVeNLoVaA8LrwCes5tO5dltsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199629; c=relaxed/simple;
	bh=Ea5JhPVCpkMq6cRIKQq7GIwWVZ7+mtQDHfzvIXuqesw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EfE454Sqxj0Nf9tMu0YThtX7nj4YFO9TLrpLteov84fr+cWdPhVZXClghRSTfqONxK1mW8aGK5iEu+m1Huui+/hE+DnVkA1NeKXRqCbOPx1PjgnhvDwmOLjb5/9wYx3U2sZXEwRY5ls8MWUvv2MSmQCkwnMvD1P7aML3jfKD19c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jT4oSDdk; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jT4oSDdk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT9fUnHsgTMAvb7F6DTBWNZZza6mNwI/dblfiZb1GlCvDXXB/S2TXC02nPp3xlgcP+q3oJ4nYiZgfimylJU/y8CWk+c8U2A1oOaYYDKXFw3dFd8Nu8KcZRrms3wZRHM5mTB1XMDLs9Ye02yX/At3ELf7OtUs8lRbUN91Fqw6U1u4HgO/cGOKJ2Y8kRavGIqj3k3RP385LsFyeOiH1u2RIkuHN1X23EOq2u1jzXahkjNkaQeZE8DBZG/Gj+3EFSHuzJIJDOhx1ar03AosePwDibonxVDngKgiDh06zsFNKk+bsRWJAB6DhzyHZ0RO1KXJ27tdRUoM2hE6XH+PCTdzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69P3Di2j8RG757Nvl7CF5tM7SZuLhKhrL/SaSYqR0C8=;
 b=jsN3MWf5MYoCBKDcfL1mv2g80oz1SSSDRy0bUaY7Vk6B3ftX9i+z+2f5Nm0C7CzbEuqg0JcQ+JelZdfnQtkzwDjB9KU+jwJ+Nf7/e7jLtjPD75WmpQHdvGW3pz/4mz7owaIuI9ANyj53KrVrvAAWnxyyahLomsaUc1ZW6NxxnFQFRnYyxqMD5a5XfJwEf0PmnRa98HgptSZA+VFX6MJXTnuYmUQSdtWuNV3fSzjBwnn0d47LCfnIJVGeIhb20EcEQKuErqv+vEPYGmDQFJZATXP4wt0ZGxz/Qh8+/RC8LjC6VsgkLTogSMe/mTU4Qo0iQfw8Ek088ZwzCITDKhDlyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69P3Di2j8RG757Nvl7CF5tM7SZuLhKhrL/SaSYqR0C8=;
 b=jT4oSDdkZco4z6JUjpIlrMrsYYb/AjfhvqA5JzIcJdJXVTQiBpwnImYA5PRyiWQMGgm4/gKhOow36LC+GXJbnRQvlSmiHwrAO0C0eCyCGHRocxMe4UkMTRR402Rdk9tRQIpMjlk6zoJ8x4KyU9okwFDjpnpwpXNDwagycQHYKNt+rcPAURqtLg61D1wXKzhb33EyLBdyj4skiYfPKNBNg/7M4meNt+xhYqM3QV5MfIa9ONEQYZmhx+CsKbkxWfxjlIeoZyGg5aV8ybT3uz9VdCk3nA5/jMQR8pS0/lKS9jSyJt02D15z/VMT7RRyMuPfUuTq5YUSNqBj3Yt4CRu4aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8442.eurprd04.prod.outlook.com (2603:10a6:102:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 21:40:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 21:40:22 +0000
Date: Wed, 23 Sep 2026 17:40:08 -0400
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
Message-ID: <arRHOJXxexYgKbPQ@lizhi-Precision-Tower-5810>
References: <20260923184612.3583132-1-Frank.Li@oss.nxp.com>
 <eebb66fa-12e2-4553-8edf-d131b84a8aba@app.fastmail.com>
 <arQpj-pn15NRgSh8@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arQpj-pn15NRgSh8@SMW015318>
X-ClientProxiedBy: PH7PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:510:339::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcfa6ec-8523-4c05-48de-08df19bb455e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|23010399003|366016|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bJZNlVFeKq/rFlBOGY1znBg++6jHi+eGKGX0nIjUngDNYLf3Q0sUjflxtBg+X6ym5i9tBgSy0Lvk2kft0DmJnJyXnoLI4yZR2j50Tefe4oNMGHcT/KhjkqvQe6QMgkkiYgKEgHAYjDNosQmC90Aa/5aom0BIMQ8qocicNLQReZg+RqekZbfLPV8smQBFmDbPqWp6AecbB7IfKAbeaZIaTLMFndxq8dFgxUGbFGZhf8CHLR+K13tJRO4m1mGLNY+izplTo/r+2vbLp0WQb9Faiemv6f6ArBz1hEgbkdUqUzAtFkWwi/bGEsjx6XJtdoyRNaFxnRqkH4K0K77WDIWkxVg8QnpQCoWDNWJQhbXwOWS1DsuKCcvBFQb/WTBql9pCz8P6BTMEE0wn+MOz41XhGLvcVEX5tzfhyjZmACQUW+Xdz8tVFANCJcFiYn2d38aagvNFZuBCsmL73dG7qRCxt7EUinaXBsHZrj521tmd2V3FDI8R+atcLVh0RAaUfUqeas4uZ2Q43VTsdfrn5mUsjk38YqtCyOAM5eNJT6HnX5W3z/Z/Zo+ln8E8u5GkpcGLSTr5HknZMipgeG0EtkXVYxFw1osfg+bj+knvq3YiuoVqMiIjJhBy45m8xe9pmCXQcJpsdBDa29zDKdqCBoO6RDKQowdaLzxwdWvzkz1C4Y8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8aqUlKT5eC+Fax7o0JfVi6X2iH0Lsa+ptTT0CvYUA5x71zOb2Dr58K0WbcBV?=
 =?us-ascii?Q?svcTIEPjVjZo3PgQrzkUrtQnFqCZyFTeBKP37teqNSYXquUf5rUGFolB0SZj?=
 =?us-ascii?Q?A9QKcH79cYHJn5SfnswECsXywlA2S/aPzZcRqyGrHV7LxEXh1bPhBiGmjmr+?=
 =?us-ascii?Q?qywn5ZivwlsJv4YcMDCsXz8TDyHuGU/DrwBzg20PHebrvfODc1bH6AUrxN5p?=
 =?us-ascii?Q?1PltPKRZpATNlOcCLjcNRezI4QDFYAlf0VL1X/xfTAKdIK5hJAaTUpiIU1fO?=
 =?us-ascii?Q?xO1PeWq2qwLb15VFjeR4Ou8BvFFPC5Wj1bgx6k4FEhkCENMh/uGqCu+k3cOb?=
 =?us-ascii?Q?iLIaG1GYk3nTjGcD9F0w+48W/rIwID8fI0MUuiqMVru7sJOADmz58TXHi+4x?=
 =?us-ascii?Q?p/Dh2NHWSPbM/6lK93Wjr8ewEnaa/JMd235SjCJ8s2+MvZ40znNds6NB6cAy?=
 =?us-ascii?Q?ZwPgoyTykbCIXp1p2GIbZ9vJxlcmMc9B+/xO29/ylTEoHHvtckDRk54pTLnt?=
 =?us-ascii?Q?9AEfZrHGtu4Eme/nO44YWs/BowPCyYi+kmLnGpVoOny66PI5KQKHQS0qfZFB?=
 =?us-ascii?Q?pNNIPhfjdk/DxkErMRz0zgxkpXZiTSyqZz53KLAAaxdRf4OwxqybWkq2LZa4?=
 =?us-ascii?Q?55k9n67mJpqHIlMRDT+hivPZIrYBSP0TJwAiYEWwPVzAkiepFuAb+HS3m0J/?=
 =?us-ascii?Q?tcNoNX7igzG7CQd53ejEkGXsuGgTKdeTtwLR/jdlG/na8Diag3T/PwTFuZU4?=
 =?us-ascii?Q?RUlWAfjGB3ABKRFDazUYgERuNoa6MhtF+iuYPchMrQECYL7dm0Ldc29zdlRJ?=
 =?us-ascii?Q?7pnxw7rF95gMtqJLF5akRX/NtUlkK8pNAeruvnD5dovTP6309+3WE6nl2YiG?=
 =?us-ascii?Q?prK1dQLUNtqSoS5TtNGP+6f3kEulcRUTol50BBqrvNln6lesaynbwep2R6KA?=
 =?us-ascii?Q?eJyQQ5nYenjw58O7k7DiSQDcXOpuFjzuKgIs88DvY4bsL0o2lyy9jqzFNPY1?=
 =?us-ascii?Q?qpyYGttC95LmUjLj2k6B8oJqrZ1of/Jn/8Tg958Ynd6hfZ3m2yCWUPxaU0N9?=
 =?us-ascii?Q?/KRGD7rvbTXlYb/j0+L9pZxw6yFZULxnSV8/3zTngE4cBGKG87QqCm42+lOh?=
 =?us-ascii?Q?OJ9o+MqVWfJhGEH1Cdhj2RlgmbMb0CbkjxDGAAXDZ/0RtHD1ZJR+FYTg7dve?=
 =?us-ascii?Q?GD9CsTS8gyF59Z7vS2soEvhy3eCx+7/R8301Z9jdZR18biS+H944KBTCj187?=
 =?us-ascii?Q?KozFU3j+NslhVqZQQmFPLwZgXZMuB8iejWsvKII/m8Lpj1BnbEiMv5t1z/4e?=
 =?us-ascii?Q?JhX1e3ZeUIJfTt9YgfHnKrbDWDCECtxXmFrSEDHv3tcBNJEh8VUerWLMH7J+?=
 =?us-ascii?Q?VYzXwP6fKBdfB4ftY1WHzzLO7wrlbyENkiUQ8YCbtk06KsYl5vXpsF0fb/Qv?=
 =?us-ascii?Q?it/yL6UIsxD8VZ86TE6IN7tSlxqdbp0odhMqB6oBcoUU9cb191neTPTh+lLT?=
 =?us-ascii?Q?gyZ4xzqbFUAa+YPih/WmC7+89qxkhtuiC8dfqPx1KRdRh2pHGb0bqbnYhVXA?=
 =?us-ascii?Q?7XLYqXURoSzQsTZClU/ljvwWb1oYe7OC7H4OFcTX8/ZXYWrGJ3tHhnFABHjC?=
 =?us-ascii?Q?cURK8XDO7JYBNI+oB0WiLICw4ciFq4ZWbpOGCelM1Jd2Dn7FbDTU7RFv6jS6?=
 =?us-ascii?Q?dXJb42cdLQqoDpUnudhER/bd0U6JQ4kBi4IpiRvrWJfemBK90TGotWe8Kutx?=
 =?us-ascii?Q?ONHzzhhTNxRAlTsSahZbhvRuoBx4qkYf9AM7GkI+Cely8A9wnvGs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcfa6ec-8523-4c05-48de-08df19bb455e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:40:22.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bpwo8LlnFEbawrFMnO8yV3GE6ow54N5S8ivOv/cGM4sYeaqOMzFIoOhZ9NpJjgkaASUIur8HYMo6tnPLDGjoUtno3Y+v6rpOpjlnBAkPWPlv/VGenhMlKuWSnr1qPRPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8442

On Wed, Sep 23, 2026 at 02:33:35PM -0500, Frank Li wrote:
> On Wed, Sep 23, 2026 at 08:57:04PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 23, 2026, at 20:45, Frank.Li@oss.nxp.com wrote:
> > > @@ -214,7 +214,7 @@ config MMC_SDHCI_OF_AT91
> > >  config MMC_SDHCI_OF_ESDHC
> > >  	tristate "SDHCI OF support for the Freescale eSDHC controller"
> > >  	depends on MMC_SDHCI_PLTFM
> > > -	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE || COMPILE_TEST
> > > +	depends on PPC || ARCHMXC || ARCH_LAYERSCAPE || COMPILE_TEST
> > >  	select MMC_SDHCI_IO_ACCESSORS
> > >  	select FSL_GUTS
> >
> > This looks like an accidental bug that should be removed from the patch.
>
> It is accidently including my local change to build test. I found it when
> post it.
>
> >
> > > @@ -961,7 +961,7 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
> > >  	struct mmc_data                 *data = host->data;
> > >
> > >  	if (data)
> > > -		dma_unmap_sg(host->dma.chan->device->dev,
> > > +		dma_unmap_sg(dmaengine_get_dma_device(host->dma.chan),
> > >  				data->sg, data->sg_len,
> > >  				mmc_get_dma_dir(data));
> >
> > Since you have the exact construct in a lot of drivers, would
> > it make sense to take this one step further and introduce
> > a new set of helpers in drivers/dma/dmaengine.h, such as
> >
> > unsigned int dmaengine_map_sg(struct dma_chan *chan, struct scatterlist *sg, ...);
>
> If add this, suppose should be set of map_*, like dmaengine_map_single(),
>
> Vinod:
> 	Is it add new APIs like thats?

Maybe we can enhence dmaengine_prep_slave_sg(),

Most patten like

	sglen = dma_map_sg(chan->device->dev, data->sg,
			data->sg_len, mmc_get_dma_dir(data));

	dmaengine_slave_config(chan, &host->dma_conf);
	desc = dmaengine_prep_slave_sg(chan,
			data->sg, sglen, slave_dirn,
			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);

let dmaengine_prep_slave_sg() include dma_map_sg(), which also reduce
error handle when return desc is NULL.

after call complete, auto ummap_sg(). We may add DMA_PREP_MAP flags to
keep back compatiblity.

after enhancement
	consumer just need call

	dmaengine_prep_slave_sg(chan, data->sg, data->sg_len, slave_dirn,
			        DMA_PREP_INTERRUPT | DMA_CTRL_ACK |
				DMA_PREP_MAP)

Frank
>
> Frank
>
> >
> >       Arnd
