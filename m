Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893649E5C1;
	Mon, 21 Sep 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001881; cv=fail; b=bkRfvrQxmdxQXR5tXebdWv/9thM42xKP9KQqHA0Zh3AbIuJq3ipHpCLvN+VQ2ZnRxKvIvhXRKYtL4LrE3otydgez8SxaREsTVg9vXaQ1/+1ubUg2e44aEOceBSCw3sTjp8lPKRAXYOHyTGK4sPAtK/FZeRkWC6Fv0rLzmS7TOrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001881; c=relaxed/simple;
	bh=dxEyUOvG61s+nfnldcbviFx+dB9B0HB1l4WD561OTV4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YNpeBNfZbZzyYV0e6Yo54DNHj0QRQDrID+qdJSa3KH8ChynJISpb2tHUQ0Uw0m5dZbqXlxvz+J9j1Gsm2gEKNiJBLm58ww0muT51gaf33CNOSk1z7AKEM/API2nHevmz1/HWWvFMFxIv0i4hoyCMHxsS86MxhohJK73+18OVEtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cjNjU7h4; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cjNjU7h4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUODv4Xv9jSE9g97LKTB48qzA0TLxDN5TebMr7e6cmxtad0PFJm2ThFl6x8HYUVINhFFiWa6aDwNzqS0eNorVLXQLqHoBwycYwkqGmo5Wn2+yqFWsn0GdOqq/xbs+8zSNo/CEikKA1o4DWyuKBBq/581ZPp3hQBJ35SdrhWjdCkckMef3rEQZPpnQu834KE/f+49mofxsqb4a3c2mqyLHKMMi/7m5ZLgWFauBHCvMxBQKgx99qjRawr4zq4KVABdlofxXkDmGP0GAzguQsaMyv7w/oRmnW9Gx6ptydR7iyPWXtKUBdkkTBhC6W8o63weS0NwNOEi5UHpOclalGthvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPIWiMWCW4RHRf6IArBspqvi3ZgLtXPlPOqxtHlyAkU=;
 b=GGWJWl4+XEiQYn/FyboimKx+UZFvo+GT916Np/5wr07MhsmoXo6GxFqFAsjq9vF7/OIFfXFY4rdXCg2c60rmXreOrJUJPCPb2VQHFVG+uCmKPpz3ZuSaMSXp+WF0lAFb+6G8DLf9cFWUFs4cPzerGuDobFGszebz+m0ax6QxMPldZdvHPH4TPTve7iUsdfiDK1k6YSm+y2IrzLSeEDCLK6RgqHZWpRUkgzT4J7j8y/2x1kUU3bTrlnDzK27tiRrQbTpRYoi+OQ4E0yiog62+6IquYg6Reqn0t3nL03Ds6OUj3eETBVw7/ylv2EH3Oc3vbRMOvNbCJkSsdEZtDIixaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPIWiMWCW4RHRf6IArBspqvi3ZgLtXPlPOqxtHlyAkU=;
 b=cjNjU7h4ZuxnOKctBGJRmLNfsN+zvfbecEYAdmUcBgQY7GJvUzgbeOF1oNjParr0NFeWAfoZA/hYn+lF2mfvNuzNUmhG0kqoYKSme3sC1OrYthdoHyyCMmxJEaAdW5csaVR9a3hDHImAd6BW/zkMnMMxFLVQbxauaxZSpOymNlIPpsB21ecOFuJqEalxUrDpxV0WZs83jhUjeldTzvXQkXvY74Jays4yPs0PvTOpm9tNIXUlKJZpQAzXqIcUjkHLhzut6XpyzEoxAHlJ1CsnrdvMOEWBKCXqbrISgaZxBxzBoM8WGRKLGeOrriMAoWhduefS8tPrLNszyLq6Kg0E8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10531.eurprd04.prod.outlook.com (2603:10a6:10:55a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:44:35 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:44:34 +0000
From: Frank.Li@oss.nxp.com
To: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paul Cercueil <paul@crapouillou.net>,
	Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Linus Walleij <linusw@kernel.org>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rosen Penev <rosenp@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Khalid Aziz <khalid@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:INGENIC JZ47xx SoCs),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT...),
	linux-omap@vger.kernel.org (open list:OMAP MMC SUPPORT),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-renesas-soc@vger.kernel.org (open list:TMIO/SDHI MMC DRIVER),
	linux-arm-kernel@axis.com (open list:ARM/ARTPEC MACHINE SUPPORT)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] mmc: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Mon, 21 Sep 2026 10:44:03 -0400
Message-ID: <20260921144426.1083196-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0090.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10531:EE_
X-MS-Office365-Filtering-Correlation-Id: 349ab2ac-0ed9-45a5-5612-08df17eeda31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|23010399003|366016|921020|3023799007|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	EpGFNjQfTJc8QwhBAOwI4IHSmxf8iAacb3hg4UUu2/Xf1pt7RZi1DuDkaNchKLartragfC8lIpWnINSA6rnpHdvGcFaMgO5MgTePqbfm3Z0G1PWGkTBEixbCj1eHlcC/KWuSTIUnIj11Vqkxch0b6G6eyOF7WaCxKMyhy0e8KX+PTgtZgfi3x8ZnLs86J/MqSyUsdJ+1Ee6Pjoo3NperI48AIC06Upzg6PE4x+ByChPEJAYaKIA/IddmR5WXLEcfQxZgMtqqjHHN2LZt8hmWb2R4VrMv3xvsNIkEmhJjyeIgV9u65Q3Y3t7TTUrBLUQTWi4hUyiGk15P2w5bUkp4LEFrZAQWU/1LyFxM4t3DBbG5I5jUuIn3DD/bbqxQA417n91dpxwCqBGg31/dPezrz5Eh3mcUs+nUC0JVCVDVMZtS/l/5A9HnrTif/mfIXrUjm8u2E0xsIRfYDJQds9XnKt6RgwVdcxUJcuSF9mjus0IG65ry649nQC5r8xlr9bSi3ZdXnzUmZ30GtplIqb6dcyVDYEgrgJM09IQQ7Hw1hVDI6sFzNeBJ8hB/4Ejj7qV+opldfdwqS+g5SGCoUdpXoHuEDvKzlAIhcsDHPT+lnHZhIkQggf93awdkv+92fM6efOGExJEOmEym1pujimocYJGXoq1OJKWvsdbKyW3V4CvloRXETWEPhEiRRJYxfLdWo5mGBlUON+nPY80ls+48TA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(23010399003)(366016)(921020)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NCaRh3/zjeNsfT5dQ0en2tkkrfXs4F+pbO6cflqH9UlvyScsEL8njzY6ZMf+?=
 =?us-ascii?Q?T32hUuDDAEK2+JeojrOoZ9pXqVejSaERcxWxGhn2Sam/ViV+nsl+RicO93LU?=
 =?us-ascii?Q?+WuIIRs7fUzZBm8zmBuzfv/Xejidnu/IZvVUXzbXP30zlz/z4P9k0a2n5m6i?=
 =?us-ascii?Q?DX6SAJYXcf1dJNAD9OIwNoJ4pKP2FOQlN8MtuABc8r230IihijLFa0wN4818?=
 =?us-ascii?Q?Vv70jgPd92aB+Mg8CfpjHVhjStUiCTeyQ1Yi/ZKgvPGklCcVODZhA4yYuz8z?=
 =?us-ascii?Q?MnDBy465Sjy+p8G1IZueA4wjZdxhYFm5mZFBl92g/43urELBhDVA+T3jD4HJ?=
 =?us-ascii?Q?+HfEx5yIW91sobcdQkjoIE/CjKhW7hCIRTkZiGQVS3xxo39fGMKa2HYMX1uW?=
 =?us-ascii?Q?u0Nz7RvpoETbBV3u/XYAVI5myDq5zQI0N+YsD+VAaweGNZtvWiJdvgSJR++g?=
 =?us-ascii?Q?QEvkCom8zVBvokdEomZo5Ia2Xju5+eA+AY6IJdL30++m4tPK45Gh1ImkR9An?=
 =?us-ascii?Q?8DTchf/AOl7uNZF3U69hdbHzxRujVDA28VLKeZ5CFpdVGCTM++9RDsyo3kiV?=
 =?us-ascii?Q?EunlGXUpEUyRKDGcfO2EiMUG55BQxl29zsmpbeavuib3v+rzyQHXluxFciqU?=
 =?us-ascii?Q?L3cfqwAu+6IT/esR2gkH2EuF/EpVWlOcx5nzrXW0l80guAH2WZ4RQO3VSzhm?=
 =?us-ascii?Q?ss9352CJtTSwzdz/8woxEvOD2nB3+2fCfnEmTjk3rNfVnugeWAva3P0k80sW?=
 =?us-ascii?Q?xgIjyAKDJsFlm8TARtioV5O4XIHnp+iN9A9uSpWzXTHlY3ph81E7QzBy9bf7?=
 =?us-ascii?Q?KKEZQGxPXvqGVxrd5mojK32uxt00+w5RM4yn5zMR1N7MAHcMH9Kd4JSC+jo1?=
 =?us-ascii?Q?qCbk5mEVbP6tu5Ck0QkmR3UQ8JwTRDOrxq3Lh940nZdxePsYny1p0S3Un0pF?=
 =?us-ascii?Q?06UK9dX8BMTwhYv1sPFQ/V9qp4GSFRdzcluNzFLNgeh4tq7YWGJUL0ozywq3?=
 =?us-ascii?Q?jfH2yLjGCQ3DoYTRtr/PsPn+mgz75qGxYtBl4YgKZUbeGelMQci1R8ss5U21?=
 =?us-ascii?Q?LmtC/UxMDKvWjyb760IluRwmMl8jWG4AWVR4fGCXIPif80hk22UEEnIiXfyt?=
 =?us-ascii?Q?CiwVS44Yz9sAtUBk7xsh5rNWztsNdAHCs6iyBUg4tI/GDXjRRbdxuQKvChmL?=
 =?us-ascii?Q?tsX4zdWZAGQ7P/oDIg9wa47m8XBTTH6IfANPYWInJ4/Fik5ZlwWfvqm8PeYn?=
 =?us-ascii?Q?JH5MrumIj6mTM+5rScpwozNOcsWWQZHVCvHvhUC7KJA+mRInDhHf+8s1+Vj5?=
 =?us-ascii?Q?Vn1KZLkTaJaAIfWq47P+z6AgSnV61gjjfn41HR+ChmmCz8IN371FzCaB2i8F?=
 =?us-ascii?Q?i0e/GfX6LAdjUXsIEAaiN9K63FVFtfnsI/zJ4Hi4eguAtrQYMV8rCNIf92ho?=
 =?us-ascii?Q?w4lzPNZ70zlUZwu9NgdsVME3S0q8/X/9tss7SjY6NBlEf1VmwHkwBwLY8/lr?=
 =?us-ascii?Q?eJCiDft/bPmNC/+LGsvHnL0iucRGQo9vofTesEjZ36D5MywzjB1DoicSRYIb?=
 =?us-ascii?Q?gkZKmcU31rNekfI0MKZPCyrznHAFxmsh/2+JAXwgOgEy0LmKr/dEKQ01VEQs?=
 =?us-ascii?Q?KSrf4bKb+hhofD7bHsjqIJSevbMlsZWrT0d7s6oUZ4UEMG/QuK6ond9OpSFR?=
 =?us-ascii?Q?K4MC2UXg+ejGDYUX3O7aR2G3tPZTYXjdWRvPS9Q8TT6wIDKf+zNDRCAs0ASP?=
 =?us-ascii?Q?zMy+tKqN9brCJ1OS+8tDXnHhE1ma79uPt65xvyEiWvlnIqzYIVzo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349ab2ac-0ed9-45a5-5612-08df17eeda31
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:44:34.5384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmMP12nxd5AbHRjUNE40j+HilR7n+xnE0V8gnkgBSOmQ/JJJ2u+XSfEGK6zGb2TAMRPKde0MiO3xJ7caqF5X0A1plISZ8hnuU10D9oOGBx0hOy9+XL58zeCiGicdeujO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10531

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() for consumer API

chan->device->dev is not always the device used for DMA mapping.
Some DMA engines support per-channel IOMMU mappings, so different
channels may use different DMA devices.  dmaengine_get_dma_device()
returns the correct device for each channel.

This also prepares for making the DMA engine provider data structures
private. DMA consumers should not access DMA engine internals directly.

mxs-mmc.c wrong use mmc host device when do DMA map. Fix it by use
dmaengine_get_dma_device().

Assisted-by: LLM
Reviewed-by: Linus Walleij <linusw@kernel.org>
eviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v3
- add Linus Walleij and Vinod Koul's review by tags
- Add missed omap and mxs-mmc.c (sashakio reported)

Change in v2
- find more place, which use device->dev for dma mapping. This time should
clean all.
- Reviewed-by: Linus Walleij <linusw@kernel.org>

Cc: imx@lists.linux.dev
Cc: vkoul@kernel.org
---
 drivers/mmc/host/atmel-mci.c             |  8 +++++---
 drivers/mmc/host/jz4740_mmc.c            |  8 ++++----
 drivers/mmc/host/mmci.c                  | 14 +++++++-------
 drivers/mmc/host/moxart-mmc.c            | 10 ++++++----
 drivers/mmc/host/mxcmmc.c                | 12 +++++-------
 drivers/mmc/host/mxs-mmc.c               |  6 +++---
 drivers/mmc/host/omap.c                  |  4 ++--
 drivers/mmc/host/omap_hsmmc.c            | 12 ++++++------
 drivers/mmc/host/owl-mmc.c               |  4 ++--
 drivers/mmc/host/pxamci.c                |  4 ++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  8 ++++----
 drivers/mmc/host/sh_mmcif.c              |  8 ++++----
 drivers/mmc/host/usdhi6rol0.c            |  6 +++---
 13 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 8f4df250a77a0..fb756e8858db3 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -961,7 +961,7 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
 	struct mmc_data                 *data = host->data;
 
 	if (data)
-		dma_unmap_sg(host->dma.chan->device->dev,
+		dma_unmap_sg(dmaengine_get_dma_device(host->dma.chan),
 				data->sg, data->sg_len,
 				mmc_get_dma_dir(data));
 }
@@ -1116,6 +1116,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	unsigned int			sglen;
 	u32				maxburst;
 	u32 iflags;
+	struct device *dma_dev;
 
 	data->error = -EINPROGRESS;
 
@@ -1145,6 +1146,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 		return -ENODEV;
 
 	chan = host->dma.chan;
+	dma_dev = dmaengine_get_dma_device(chan);
 	host->data_chan = chan;
 
 	if (data->flags & MMC_DATA_READ) {
@@ -1161,7 +1163,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 		atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(maxburst) |
 			ATMCI_DMAEN);
 
-	sglen = dma_map_sg(chan->device->dev, data->sg,
+	sglen = dma_map_sg(dma_dev, data->sg,
 			data->sg_len, mmc_get_dma_dir(data));
 
 	dmaengine_slave_config(chan, &host->dma_conf);
@@ -1177,7 +1179,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 	return iflags;
 unmap_exit:
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
+	dma_unmap_sg(dma_dev, data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));
 	return -ENOMEM;
 }
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 6a3c26b7c82d8..3343c8aa1bffe 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -256,7 +256,7 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 	 * the parameters of the DMA engine device.
 	 */
 	if (host->dma_tx) {
-		struct device *dev = host->dma_tx->device->dev;
+		struct device *dev = dmaengine_get_dma_device(host->dma_tx);
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
@@ -264,7 +264,7 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 	}
 
 	if (host->dma_rx) {
-		struct device *dev = host->dma_rx->device->dev;
+		struct device *dev = dmaengine_get_dma_device(host->dma_rx);
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
@@ -289,7 +289,7 @@ static void jz4740_mmc_dma_unmap(struct jz4740_mmc_host *host,
 	struct dma_chan *chan = jz4740_mmc_get_dma_chan(host, data);
 	enum dma_data_direction dir = mmc_get_dma_dir(data);
 
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	dma_unmap_sg(dmaengine_get_dma_device(chan), data->sg, data->sg_len, dir);
 	data->host_cookie = COOKIE_UNMAPPED;
 }
 
@@ -307,7 +307,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 	if (data->host_cookie == COOKIE_PREMAPPED)
 		return data->sg_count;
 
-	sg_count = dma_map_sg(chan->device->dev,
+	sg_count = dma_map_sg(dmaengine_get_dma_device(chan),
 			data->sg,
 			data->sg_len,
 			dir);
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 416bdb184ed4c..2d72f56d354f1 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -893,14 +893,14 @@ int mmci_dmae_setup(struct mmci_host *host)
 	 * the parameters of the DMA engine device.
 	 */
 	if (dmae->tx_channel) {
-		struct device *dev = dmae->tx_channel->device->dev;
+		struct device *dev = dmaengine_get_dma_device(dmae->tx_channel);
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 	if (dmae->rx_channel) {
-		struct device *dev = dmae->rx_channel->device->dev;
+		struct device *dev = dmaengine_get_dma_device(dmae->rx_channel);
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
@@ -940,7 +940,7 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 	else
 		chan = dmae->tx_channel;
 
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
+	dma_unmap_sg(dmaengine_get_dma_device(chan), data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));
 }
 
@@ -1023,7 +1023,7 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 		.device_fc = variant->dma_flow_controller,
 	};
 	struct dma_chan *chan;
-	struct dma_device *device;
+	struct device *dma_dev;
 	struct dma_async_tx_descriptor *desc;
 	int nr_sg;
 	unsigned long flags = DMA_CTRL_ACK;
@@ -1056,8 +1056,8 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 	if (host->variant->dma_power_of_2 && !is_power_of_2(data->blksz))
 		return -EINVAL;
 
-	device = chan->device;
-	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
+	dma_dev = dmaengine_get_dma_device(chan);
+	nr_sg = dma_map_sg(dma_dev, data->sg, data->sg_len,
 			   mmc_get_dma_dir(data));
 	if (nr_sg == 0)
 		return -EINVAL;
@@ -1077,7 +1077,7 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 	return 0;
 
  unmap_exit:
-	dma_unmap_sg(device->dev, data->sg, data->sg_len,
+	dma_unmap_sg(dma_dev, data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));
 	return -ENOMEM;
 }
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 28aed13549a64..6c0974c494207 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -262,6 +262,7 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 	u32 len, dir_slave;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
+	struct device *dma_dev;
 	long timeout;
 
 	if (host->data_len == data->bytes_xfered)
@@ -275,7 +276,8 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 		dir_slave = DMA_DEV_TO_MEM;
 	}
 
-	len = dma_map_sg(dma_chan->device->dev, data->sg,
+	dma_dev = dmaengine_get_dma_device(dma_chan);
+	len = dma_map_sg(dma_dev, data->sg,
 			 data->sg_len, mmc_get_dma_dir(data));
 
 	if (len > 0) {
@@ -306,7 +308,7 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 	data->bytes_xfered = host->data_len;
 
 unmap:
-	dma_unmap_sg(dma_chan->device->dev,
+	dma_unmap_sg(dma_dev,
 		     data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));
 }
@@ -642,8 +644,8 @@ static int moxart_probe(struct platform_device *pdev)
 		dmaengine_slave_config(host->dma_chan_rx, &cfg);
 
 		mmc->max_seg_size = min3(mmc->max_req_size,
-			dma_get_max_seg_size(host->dma_chan_rx->device->dev),
-			dma_get_max_seg_size(host->dma_chan_tx->device->dev));
+			dma_get_max_seg_size(dmaengine_get_dma_device(host->dma_chan_rx)),
+			dma_get_max_seg_size(dmaengine_get_dma_device(host->dma_chan_tx)));
 	}
 
 	if (readl(host->base + REG_BUS_WIDTH) & BUS_WIDTH_4_SUPPORT)
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 097498a3f8ff4..c20cff770395e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -290,6 +290,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	unsigned int datasize = nob * blksz;
 	struct scatterlist *sg;
 	enum dma_transfer_direction slave_dirn;
+	struct device *dma_dev = dmaengine_get_dma_device(host->dma);
 	int i, nents;
 
 	host->data = data;
@@ -319,8 +320,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 		mxcmci_swap_buffers(data);
 	}
 
-	nents = dma_map_sg(host->dma->device->dev, data->sg,
-				     data->sg_len,  host->dma_dir);
+	nents = dma_map_sg(dma_dev, data->sg, data->sg_len,  host->dma_dir);
 	if (nents != data->sg_len)
 		return -EINVAL;
 
@@ -329,8 +329,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!host->desc) {
-		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
-				host->dma_dir);
+		dma_unmap_sg(dma_dev, data->sg, data->sg_len, host->dma_dir);
 		host->do_dma = 0;
 		return 0; /* Fall back to PIO */
 	}
@@ -439,7 +438,7 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
 	int data_error;
 
 	if (mxcmci_use_dma(host)) {
-		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
+		dma_unmap_sg(dmaengine_get_dma_device(host->dma), data->sg, data->sg_len,
 				host->dma_dir);
 		mxcmci_swap_buffers(data);
 	}
@@ -1125,8 +1124,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 		}
 	}
 	if (host->dma)
-		mmc->max_seg_size = dma_get_max_seg_size(
-				host->dma->device->dev);
+		mmc->max_seg_size = dma_get_max_seg_size(dmaengine_get_dma_device(host->dma));
 	else
 		dev_info(mmc_dev(host->mmc), "dma not available. Using PIO\n");
 
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 7c7c52d9e8e72..6b23bdcdb6ed2 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -143,7 +143,7 @@ static void mxs_mmc_request_done(struct mxs_mmc_host *host)
 		mxs_mmc_start_cmd(host, mrq->cmd);
 		return;
 	} else if (data) {
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+		dma_unmap_sg(dmaengine_get_dma_device(ssp->dmach), data->sg,
 			     data->sg_len, ssp->dma_dir);
 		/*
 		 * If there was an error on any block, we mark all
@@ -221,7 +221,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
 
 	if (data) {
 		/* data */
-		dma_map_sg(mmc_dev(host->mmc), data->sg,
+		dma_map_sg(dmaengine_get_dma_device(ssp->dmach), data->sg,
 			   data->sg_len, ssp->dma_dir);
 		sgl = data->sg;
 		sg_len = data->sg_len;
@@ -640,7 +640,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	mmc->max_blk_size = 1 << 0xf;
 	mmc->max_blk_count = (ssp_is_old(ssp)) ? 0xff : 0xffffff;
 	mmc->max_req_size = (ssp_is_old(ssp)) ? 0xffff : 0xffffffff;
-	mmc->max_seg_size = dma_get_max_seg_size(ssp->dmach->device->dev);
+	mmc->max_seg_size = dma_get_max_seg_size(dmaengine_get_dma_device(ssp->dmach));
 
 	platform_set_drvdata(pdev, mmc);
 
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 527b89a5ed707..37a8408351750 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -431,7 +431,7 @@ mmc_omap_release_dma(struct mmc_omap_host *host, struct mmc_data *data,
 			/* Claim nothing transferred on error... */
 			data->bytes_xfered = 0;
 		}
-		dev = c->device->dev;
+		dev = dmaengine_get_dma_device(c);
 	}
 	dma_unmap_sg(dev, data->sg, host->sg_len, dma_data_dir);
 }
@@ -1037,7 +1037,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 			*bp = burst;
 		}
 
-		host->sg_len = dma_map_sg(c->device->dev, data->sg, sg_len,
+		host->sg_len = dma_map_sg(dmaengine_get_dma_device(c), data->sg, sg_len,
 					  dma_data_dir);
 		if (host->sg_len == 0)
 			goto use_pio;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index de5a3b70107d8..44c326fd2a9b2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -915,7 +915,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 		struct dma_chan *chan = omap_hsmmc_get_dma_chan(host, host->data);
 
 		dmaengine_terminate_all(chan);
-		dma_unmap_sg(chan->device->dev,
+		dma_unmap_sg(dmaengine_get_dma_device(chan),
 			host->data->sg, host->data->sg_len,
 			mmc_get_dma_dir(host->data));
 
@@ -1170,7 +1170,7 @@ static void omap_hsmmc_dma_callback(void *param)
 	data = host->mrq->data;
 	chan = omap_hsmmc_get_dma_chan(host, data);
 	if (!data->host_cookie)
-		dma_unmap_sg(chan->device->dev,
+		dma_unmap_sg(dmaengine_get_dma_device(chan),
 			     data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 
@@ -1204,7 +1204,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 
 	/* Check if next job is already prepared */
 	if (next || data->host_cookie != host->next_data.cookie) {
-		dma_len = dma_map_sg(chan->device->dev, data->sg, data->sg_len,
+		dma_len = dma_map_sg(dmaengine_get_dma_device(chan), data->sg, data->sg_len,
 				     mmc_get_dma_dir(data));
 
 	} else {
@@ -1390,7 +1390,7 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	if (host->use_dma && data->host_cookie) {
 		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, data);
 
-		dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
+		dma_unmap_sg(dmaengine_get_dma_device(c), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 		data->host_cookie = 0;
 	}
@@ -1912,8 +1912,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	 * increase this figure here, we get warnings from the DMA API debug.
 	 */
 	mmc->max_seg_size = min3(mmc->max_req_size,
-			dma_get_max_seg_size(host->rx_chan->device->dev),
-			dma_get_max_seg_size(host->tx_chan->device->dev));
+			dma_get_max_seg_size(dmaengine_get_dma_device(host->rx_chan)),
+			dma_get_max_seg_size(dmaengine_get_dma_device(host->tx_chan)));
 
 	/* Request IRQ for MMC operations */
 	ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index d5b8a110267b8..668cf9704ac29 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -162,7 +162,7 @@ static void owl_mmc_finish_request(struct owl_mmc_host *owl_host)
 	owl_host->mrq = NULL;
 
 	if (data)
-		dma_unmap_sg(owl_host->dma->device->dev, data->sg, data->sg_len,
+		dma_unmap_sg(dmaengine_get_dma_device(owl_host->dma), data->sg, data->sg_len,
 			     owl_host->dma_dir);
 
 	/* Finally finish request */
@@ -313,7 +313,7 @@ static int owl_mmc_prepare_data(struct owl_mmc_host *owl_host,
 		owl_host->dma_cfg.direction = DMA_DEV_TO_MEM;
 	}
 
-	dma_map_sg(owl_host->dma->device->dev, data->sg,
+	dma_map_sg(dmaengine_get_dma_device(owl_host->dma), data->sg,
 		   data->sg_len, owl_host->dma_dir);
 
 	dmaengine_slave_config(owl_host->dma, &owl_host->dma_cfg);
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index f8427f071c009..c3edd98376bcc 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -201,7 +201,7 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 		return;
 	}
 
-	host->dma_len = dma_map_sg(chan->device->dev, data->sg, data->sg_len,
+	host->dma_len = dma_map_sg(dmaengine_get_dma_device(chan), data->sg, data->sg_len,
 				   host->dma_dir);
 
 	tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,
@@ -337,7 +337,7 @@ static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
 		chan = host->dma_chan_rx;
 	else
 		chan = host->dma_chan_tx;
-	dma_unmap_sg(chan->device->dev,
+	dma_unmap_sg(dmaengine_get_dma_device(chan),
 		     data->sg, data->sg_len, host->dma_dir);
 
 	if (stat & STAT_READ_TIME_OUT)
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index c7df4da9e865b..bf2b32cfbec6c 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -134,11 +134,11 @@ static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 		goto out;
 
 	if (host->data->flags & MMC_DATA_READ)
-		dma_unmap_sg(host->chan_rx->device->dev,
+		dma_unmap_sg(dmaengine_get_dma_device(host->chan_rx),
 			     host->sg_ptr, host->sg_len,
 			     DMA_FROM_DEVICE);
 	else
-		dma_unmap_sg(host->chan_tx->device->dev,
+		dma_unmap_sg(dmaengine_get_dma_device(host->chan_tx),
 			     host->sg_ptr, host->sg_len,
 			     DMA_TO_DEVICE);
 
@@ -188,7 +188,7 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 		sg = host->sg_ptr;
 	}
 
-	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_DEVICE);
+	ret = dma_map_sg(dmaengine_get_dma_device(chan), sg, host->sg_len, DMA_FROM_DEVICE);
 	if (ret > 0)
 		desc = dmaengine_prep_slave_sg(chan, sg, ret, DMA_DEV_TO_MEM,
 					       DMA_CTRL_ACK);
@@ -264,7 +264,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 		sg = host->sg_ptr;
 	}
 
-	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
+	ret = dma_map_sg(dmaengine_get_dma_device(chan), sg, host->sg_len, DMA_TO_DEVICE);
 	if (ret > 0)
 		desc = dmaengine_prep_slave_sg(chan, sg, ret, DMA_MEM_TO_DEV,
 					       DMA_CTRL_ACK);
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index a205c222a821d..e8d2bd1491eee 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -289,7 +289,7 @@ static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
 	dma_cookie_t cookie = -EINVAL;
 	int ret;
 
-	ret = dma_map_sg(chan->device->dev, sg, data->sg_len,
+	ret = dma_map_sg(dmaengine_get_dma_device(chan), sg, data->sg_len,
 			 DMA_FROM_DEVICE);
 	if (ret > 0) {
 		host->dma_active = true;
@@ -339,7 +339,7 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
 	dma_cookie_t cookie = -EINVAL;
 	int ret;
 
-	ret = dma_map_sg(chan->device->dev, sg, data->sg_len,
+	ret = dma_map_sg(dmaengine_get_dma_device(chan), sg, data->sg_len,
 			 DMA_TO_DEVICE);
 	if (ret > 0) {
 		host->dma_active = true;
@@ -1173,11 +1173,11 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 							 host->timeout);
 
 	if (data->flags & MMC_DATA_READ)
-		dma_unmap_sg(host->chan_rx->device->dev,
+		dma_unmap_sg(dmaengine_get_dma_device(host->chan_rx),
 			     data->sg, data->sg_len,
 			     DMA_FROM_DEVICE);
 	else
-		dma_unmap_sg(host->chan_tx->device->dev,
+		dma_unmap_sg(dmaengine_get_dma_device(host->chan_tx),
 			     data->sg, data->sg_len,
 			     DMA_TO_DEVICE);
 
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 8d9d4f362999f..74888260e85c5 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -539,10 +539,10 @@ static void usdhi6_dma_stop_unmap(struct usdhi6_host *host)
 	host->dma_active = false;
 
 	if (data->flags & MMC_DATA_READ)
-		dma_unmap_sg(host->chan_rx->device->dev, data->sg,
+		dma_unmap_sg(dmaengine_get_dma_device(host->chan_rx), data->sg,
 			     data->sg_len, DMA_FROM_DEVICE);
 	else
-		dma_unmap_sg(host->chan_tx->device->dev, data->sg,
+		dma_unmap_sg(dmaengine_get_dma_device(host->chan_tx), data->sg,
 			     data->sg_len, DMA_TO_DEVICE);
 }
 
@@ -583,7 +583,7 @@ static int usdhi6_dma_setup(struct usdhi6_host *host, struct dma_chan *chan,
 		return -EINVAL;
 	}
 
-	ret = dma_map_sg(chan->device->dev, sg, data->sg_len, data_dir);
+	ret = dma_map_sg(dmaengine_get_dma_device(chan), sg, data->sg_len, data_dir);
 	if (ret > 0) {
 		host->dma_active = true;
 		desc = dmaengine_prep_slave_sg(chan, sg, ret, dir,
-- 
2.43.0

