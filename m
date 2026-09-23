Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F251614C;
	Wed, 23 Sep 2026 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189446; cv=fail; b=HwK2AeizigbV5id2aHFE6RwLuMmxkg6dicYmhbDH0ZM/JQ+rv09LS0oMJ8qZGjx9lm8Ht1szfzFJ8IKTzltmYm4hs+N4ZctjNyF45iy5Tpe4r/kr2ljvwnzHvNlMDlHViyam+rLZ9hCV4LRbIsaAbEvmJTFCHukIJ2yEC3gw/ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189446; c=relaxed/simple;
	bh=dJrMe1Lh2PYxmvqzjIn4XC85q25hIZxaoR9DsW0gjr8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NWoUH7X1JTKcWL+i5lSjo7dYYCF2FoV5xVpd1MaTWs2XGFD0q1RqweAggDW6ZpxC7DmbWSofTUssyChxWTAiyso3QLlSlk3XNEP+6FemoU5VGnhR/5u1rjFaJKb1U5+uaZRZ3kW8hEBaHH/aH68AIx3ptD/NaFiZOc2gU6mxP0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QnQNmsSZ; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QnQNmsSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGPdq7ke+0MQSGcZpIvhqMEQUJF1+iGxEQvo3nJM9QTR9CxQFfoAe8GdlQLgpQr2GjSmlFLrCppdwHuDKRXBkc1nPOkIeXZMEb21XfFuwTeod0VjD2IqvQE3uSphSVATJroGSAGcmT96Y/gxoXFZJac5HS0PSwy3lkobn6k8MngqLIB4YPJ2YZXO4EL36CUUimzSCx/DOTC9x8Zay1bPZwb7r/7jKOQQoA31Jv4zn3dZkshA0E11FJqiXHHHOXProH5/CZCNbkZJtrUVnsgw4XkE+p5M5RoPeLuwBlrJA8AR1HI7f08jjQPbj20PvF3szUwRhiz4Di2DlfBfpnyStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSXBaJC1J6EVZ1QqVNTOfVwobtuz0UgwCZPnXHETa9w=;
 b=rsIY5/et8LqUa2hsKoZKHPxVLCiIWdMO/fMSI352ido8mcGw1uq3UfV9z14WuVMxeywhvufrtRnNakIfCn1W0yqBIc76Yr5DQt+dFV90M3e/nkZY5tkuD5GibiJjQVurWcbYr5N9/lhNE7+GnLzfrOQIXX3BuUNOFI3TaRz/i0X4cdcYf2I2Qfx2ZPzdMJFTkkC+dkWf4JDuNSMZnMeTdynNddbsVKscoBC3kvyn+Kv+JFdxrvvl6lXEbCur81DAhjIqfmcVz1Tb9nQKGyAg+8rMqQ3d6Y5OIMb7HX6UlArAoMNjXcEksEKQz2Nu4ytFK6we6aTkgkJ4OLi33toIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSXBaJC1J6EVZ1QqVNTOfVwobtuz0UgwCZPnXHETa9w=;
 b=QnQNmsSZbv0HIvu1hBUS6rDWhLnKGbLyUbjFNdISWAuzLfv81Oorub5sy4+dmo5ZfhDKkrdu6ebDHIlk1hjhfeejQ8MsaOdekqlK6KypvKEYkMyPGp4hz5PMeku5WvwkW+mTQJ7qLE6OivIyg2od2BCt9z5JMFEP2Lzx3FGV4PVLXie9L2n2PIGR8KVWGkm5R7jGGowrFYuCMgVmzBAg4cJmYmP2OkdknCZQjukkcM4sxCVYxfLld4eNoe6SnIMj9epTcvWhqziOOrXsYvgR9AHF5bpZkF+CnJbprHr0m7/bAKGcjaIVqS528oHEXgctqMV4Kz4ViqeK5ikpNO9oCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by BR0PR04MB823501.eurprd04.prod.outlook.com (2603:10a6:2c8:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:50:20 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 18:50:20 +0000
Date: Wed, 23 Sep 2026 14:50:06 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Ulf Hansson <ulfh@kernel.org>,
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
	Lars Persson <lars.persson@axis.com>, Arnd Bergmann <arnd@arndb.de>,
	Johan Hovold <johan@kernel.org>, Ge Gordon <gordon.ge@bst.ai>,
	Vinod Koul <vkoul@kernel.org>,
	Albert Yang <yangzh0906@thundersoft.com>,
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
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	"open list:OMAP MMC SUPPORT" <linux-omap@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	"open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Subject: Re: [PATCH v4 1/1] mmc: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <arQfXjYbtNhv9__S@lizhi-Precision-Tower-5810>
References: <20260923184612.3583132-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923184612.3583132-1-Frank.Li@oss.nxp.com>
X-ClientProxiedBy: CYZPR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:930:8b::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|BR0PR04MB823501:EE_
X-MS-Office365-Filtering-Correlation-Id: 5574a39a-326a-4375-57ca-08df19a38486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|23010399003|366016|921020|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C8ktyfdTMEpTvH2KzWaN1a28hiuSCh0XsDL9TiZRwkn16alMwbc0QVDS51xdVm2Vq6xcENhsi9AAk1F40z275lHd/vrZcXXIwkMxMUKq9V0wbD7IDE8wcWppLsZB9THa9HmVdrYm2sviL4yNILDd1pLP9FVNwX86DpjFwV32enxxh4CNYahgTCybYETtu33+J2z2NX0eKz1R774d2HwturqB9gOAAvDxcHtnhIv7JVD0YyyCUA8I52gat+yRx99ncYMO4LIthMv4s165Lhl+W/X7b1NlG7YULnwHnEzPwMWGczrTGbpuuoxuMxneDP7YxOn8ae9uuaXktJn7v/CdaoLcq4Fc+IqaIuC1jLKJQmGJDrLMEPuR4JTWZEB+WHgO9XLRLMQh+ezguEFsDw+1xtH+icMCO//81nW17PxqRdcgHn6SFVCapVvp9bq1qyH1kJIxLZ3W1YqDwDCcsPMbG3wtad6SPhJ/HHkOIoT+ZyX6uY9vwu6mCphUgL2/6rJT80GlZl6QoNhuiphlP1CPTTkVvkRIhz+zRRCm+kGO/qvWrtOqqhip9e2VUz7qc7XNmQNHZ5CDf0PuejSdrGOrqh6741vPnvgc3D6yh8yyPBBdHZKfoQh9hDBiWjxKWb4xqkT9wjIYUdg0Gh/+XynLMoLzRS3R2MCwWWrEPkacNjkCNofgM0LcVQ/a8wrQU5IHUjbPPgeEpTuvJGfKA9ZDbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(23010399003)(366016)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jv0fo0D93FZYziqBOVJVdW75ETbDwFXHaK3zYCXkvfkmAlxRD3uVo49TYnpV?=
 =?us-ascii?Q?tYH3BirT3wYk7qIRqPEGxKSaJGO0sWeVrmdvSCXOwgNGURc9LiWXrEdgP1Oz?=
 =?us-ascii?Q?tgr6oZHHo28Q5tsbrItF9aOu2vwexMvo8lWaCpZwBncj1XCfspt0qY7JOklm?=
 =?us-ascii?Q?ZeRnlZPzN5XKaBZ1wEwA3ZFB7gVRNGCnQJGLWsDtwdLy/tTZUvTbrxtRMSLS?=
 =?us-ascii?Q?dwR5JWYpfn2gYbHppLT3lyvEZuOgnF+fRG9WX48EH4F8zBgdgwh7p7YNx0Pe?=
 =?us-ascii?Q?KxUONL8obfstioCqo+NmHqzMk6fjAB9DI/RMuUEHCz38hX1IATq5btoGjKF2?=
 =?us-ascii?Q?LK3xeZRftbhXD+/efNFbGc9VDOOMILyUd/rbar5lWltq63m0VdXFwC787vk8?=
 =?us-ascii?Q?dqMV0JHk6Bjf6S/q8hgj4wpvcXPN5/2Khzh4Umne3H5KxLZtSD4RWSYDm0Z+?=
 =?us-ascii?Q?eRG9BKE1jZ1nBXWPE/S/UVXUNII5pRVOdYxSYq7KUDRhhhitLcfG9gYKDDHj?=
 =?us-ascii?Q?5EMPIShspAWq9jQPELzdj3toXRhUCj0IWXLbxerPysv4QjDT26nlexskrubp?=
 =?us-ascii?Q?sY3L7N1qNEpBuUp362qP0KjDM2JBl842fgH/2Y3pwDkHp7gfshZ0mOSeDrGU?=
 =?us-ascii?Q?/AqoqpZZDo90lq0lUmMDOd9UoDCRpqAxIgRXpEsUSUmWphkHrVNoYDG3gWMc?=
 =?us-ascii?Q?r4WnRR1JLKybrprO+OuPXrfn+zE052qJiS/RJxed7RuO3ckj+e44ynwjzfa8?=
 =?us-ascii?Q?RZwiB5lNuWD8tDsOTP/S0utzLVzfou9Dqi/l31/UdzH4FVPqq00+BQZrT3mb?=
 =?us-ascii?Q?KckFa8l4mMDJdGvlLD4mZZUu4n5qWwAu641PgpESjMojr27MMTdXOShnCodv?=
 =?us-ascii?Q?TWtlhKWlbs5iH/ACTPpzqaKwysUWENXH/J2MyIP9Wkuywe6vA8+3Y17TuATB?=
 =?us-ascii?Q?Xn5DVHHAzUmdBR78ONj1mizEs9PEiMwbgurRPtF9F/6yVgqA0W4lTz1jQbwG?=
 =?us-ascii?Q?4BPY4pD0KFkzEsIyGywWdt+BUdt9SfG7xMA7FQ1j3zAoOlo22psTYzDSr9Vw?=
 =?us-ascii?Q?h55E71kG8QbeA8tKyC9nhzraKmypPhZjrnC5nXP5/vGUNHAsyw/Mr874mAwz?=
 =?us-ascii?Q?xRBqs2+U0XXIMLpcZ3CiS+g4j+OvKZiyt140JJwz1Zl7x5Xgf+gLSEqlXFzP?=
 =?us-ascii?Q?L7axtvaJkwg1aD/YsaoM5o0SlCVhbNM3aguxgKHJXxKNVJHio/MNsALKp8zr?=
 =?us-ascii?Q?EDT59C/HGdcJsGUqwunzjzRdX+Y6Hnul8OkxLsaI66HshPK0p8W8k7EbpmiS?=
 =?us-ascii?Q?kgcqeExhjs/LgFsToFESkCUBV9ACji6Gj1+NCIhz37wXkck23WksmbiScm2Z?=
 =?us-ascii?Q?FOZkSE7ooG+tbtix36m2Ql+I88wkAztb0GeXesUzjubcXG5o0JJrabI6jmIs?=
 =?us-ascii?Q?ewK5+bUGlOf7kStrzkCqZRS9maNHnNTgX5DJ3UmFo6FC96Uv2ojU6LKUq/85?=
 =?us-ascii?Q?1lcp3o22hZ7Ozk0kPXhB0RLy4+PbOXI4/HxvZb2RdDIoNCmdOgkWH9bW21ho?=
 =?us-ascii?Q?OmHTmXBxPq5sMk3i9ukumhBefcFwjkA5F8P6o4GrPuvPUb066A88kJ+S5Nm7?=
 =?us-ascii?Q?nqstjw+j7yjzVINGmyElZMAQ7ibykG3m3I2LBQRgvtI6HS5p84VhFqJiVDe4?=
 =?us-ascii?Q?jhBLE2rjwgThYI/tizgIPCYxhXZRwqFegFGtUvzPyn6t9ho7zIEXpSYkmS3m?=
 =?us-ascii?Q?FQrcqCnbq83MMuRu/FCkAuyQnDq8/fA20AiAvUVNNaR73Yi+UHM2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5574a39a-326a-4375-57ca-08df19a38486
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:50:20.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP0E6KA4vTsKTV6GtSYJCTtzOne2X0pIQiDUi9HGuEvNAqB8Ws6UIwsOiuoI5tyUUVORer6SF/2qiGG2OxdPd18MljdanwY/qAudurza234ufpMWY2Qm1y0NZZXDS4hh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB823501

On Wed, Sep 23, 2026 at 02:45:47PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() for consumer API
>
> chan->device->dev is not always the device used for DMA mapping.
> Some DMA engines support per-channel IOMMU mappings, so different
> channels may use different DMA devices.  dmaengine_get_dma_device()
> returns the correct device for each channel.
>
> This also prepares for making the DMA engine provider data structures
> private. DMA consumers should not access DMA engine internals directly.
>
> mxs-mmc.c wrong use mmc host device when do DMA map. Fix it by use
> dmaengine_get_dma_device().
>
> Assisted-by: LLM
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v4
> - Fix miss "R" at Reviewed-by tags.
> - Fix error path unmap dev at mxs-mmc.c (sashakio reported)
> - move dmaengine_get_dma_device(host->dma) after mxcmci_use_dma() to avoid
> defer host->dma if use pio mode (sashakio reported)
>
> Change in v3
> - add Linus Walleij and Vinod Koul's review by tags
> - Add missed omap and mxs-mmc.c (sashakio reported)
>
> Change in v2
> - find more place, which use device->dev for dma mapping. This time should
> clean all.
> - Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Cc: imx@lists.linux.dev
> Cc: vkoul@kernel.org
> ---
>  drivers/mmc/host/Kconfig                 |  2 +-

Please forget this version, I make misstake to include a debug code, sorry
for annoise.

Frank
