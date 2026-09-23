Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47629406270;
	Wed, 23 Sep 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189191; cv=fail; b=tz9uA4+MrCXxd5THu9aebFnFUxzO51iPLoHsVhTpfaLiPDfgmogvHxbpC/vpo56/M5LjbNZV/ZhuXTUM6EDe0VE50fO8Aa4y/ER/B3ratDwTsHkOrOVWDtdauO5uHeAWy6sNBDAEVb1fRC2vC6UBjkABOM1M7W1KOaQ8DGuyuTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189191; c=relaxed/simple;
	bh=5let2TouwagW4o1GYaT5zB8Ep93Dif1t3VugbMylhC4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FyIOV0t6jqIZziMKa7ClIl0ZtKW3vr+FWBValh/ewVgz162mEerb+hi9TKo3xgTU9VntN+ho+zlTeyE4wSEagyoM+pDRsnCOibMZaBEcg8i4HiF7n9DC1sATCj/mq1eKizwH1zfGf+DQFFHUic8fmIn13JIEIN5y4UIRw7JU7AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QuJcM8O2; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QuJcM8O2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5QLTYMkrINzL2jPpT6z3TVAyjyuxzq7JwOPxDhsePi+/m9G1i65rP4Ss0PEsaxkz0+F8hesok8xSE7XM6py85w8G67fyS6PL/KvTxoa4cXhCLeUnN9ySpTUYfp8qgIAX+oPHzEUtfSXu4lAZ+QP87nhXzrhEueKkdTq1Q0gA57PWQ+uftN7H4HNT4AxqU80KAlHfqjqO3KbvzL5Vfb8ZVg9cwTbKLpxyyKGc/Kln7N/Z/0KR+T7gwGrze4PKLEdP123xkhcBSIAzWwEOb558i5QfXv1nyq7z/amQN7wyxPJuH9ag0ma7hcvf5oHRM3GJY67jNJYjRbYdMHUpPvADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GePXOC2+BzHN+1CFHLmgpszZ9UF1hs6RpFEZ5EmuTAM=;
 b=vXwLdjs37csipHtUiGuoxugObs037vwbKT6tXhoHWTsg1eZtxUkvpcKW2msnrfjDoFwKF5j7EtaOivb+TIWoqipJ66LWIi/YFEg+2j/aVhNPmnwzqkhgbuYPe98D0uO/SIykhO7/T2pMpbI2AU2cfl6do8YWIL4YqyWqih9BQoQu0xjighTJI7koWFTtJnW8aYoflfh7mPtW88kAUsuIvJ9d9yNXGrM1yBrhATFKDyMiisGC5HgsZm5wCZxwO+tS0S5kc0zgcfp6lHe2AQtD2xqyU7seOz6t+HP7UNalpzOVvetqihAx28uRIgxUMNjcBifqApaLrig8BpzqP5h+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GePXOC2+BzHN+1CFHLmgpszZ9UF1hs6RpFEZ5EmuTAM=;
 b=QuJcM8O2XG6gSx+YoFe6Wz8WDDuKES8JwMEQIkoEf6wrxcHj6ZPGcy6rXsNxI9JJnPsFH+2HW+RSdZ9b7rFjX1BaKNviowPjZNWT7LJvR1xeZm9igIfJCtVLW6+XXBhIAAiOutj1j2LzmFoNno51i4Y1TOVX/EI9go4dBAFJksmOrjYpEK7pxjgeoPxl8oHmLJ8ygjCGRnsEtIWd1CdmjSB+RCYOJuPoZ/j2FcZ9H38TwS9lBm/h4jv7WEwN3O60kSb9F7y8njRTnI8D17C8n6VX1bAOFwATIXxdk7mhPxR2GddiH+21Dr8QZ7x0/nqo4/eaySzcJQ3QuuR2K45gZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by BR0PR04MB823501.eurprd04.prod.outlook.com (2603:10a6:2c8:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:46:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 18:46:20 +0000
From: Frank.Li@oss.nxp.com
To: Ulf Hansson <ulfh@kernel.org>,
	Aubin Constans <aubin.constans@microchip.com>,
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
	Arnd Bergmann <arnd@arndb.de>,
	Johan Hovold <johan@kernel.org>,
	Ge Gordon <gordon.ge@bst.ai>,
	Vinod Koul <vkoul@kernel.org>,
	Albert Yang <yangzh0906@thundersoft.com>,
	Jared Kangas <jkangas@redhat.com>,
	Brian Masney <bmasney@redhat.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Rosen Penev <rosenp@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Khalid Aziz <khalid@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-mips@vger.kernel.org (open list:INGENIC JZ47xx SoCs),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT...),
	linux-omap@vger.kernel.org (open list:OMAP MMC SUPPORT),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-renesas-soc@vger.kernel.org (open list:TMIO/SDHI MMC DRIVER),
	linux-arm-kernel@axis.com (open list:ARM/ARTPEC MACHINE SUPPORT)
Cc: imx@lists.linux.dev
Subject: [PATCH v4 1/1] mmc: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Wed, 23 Sep 2026 14:45:47 -0400
Message-ID: <20260923184612.3583132-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:930:4f::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|BR0PR04MB823501:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e87c2d9-7f9f-48e2-3afc-08df19a2f575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|23010399003|366016|921020|56012099006|5023799004|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NAKV903EpkujwydS902W87Gn+AFhei5dsMDq18QP4kJyQoxG3GabkbiDJTi7IwK2ZQoAhauu5oCK5ExoZY0wsErHZquxSyDRYarCnG7VQiLvFPnmOThqbgvXbyWLrykWQ6nJHqStgl8lp/ChD8mwupTYWbrQU8PlXTaHe9JvNggXThhMJPTI5Op+6m+VA+tiSoYjL3XLFa9UToyMFgg9Nl5kvfJFW2owKrIWGz0fO95K8H6geornmx9ZW8nlmhuCwtX5hJWOoN3+egPw0gEIa4xnKW09NAEYeH+egLLpjzDEEViD5CqVa0aJWlS9F5CRnY1udyF2aBSfhRn4aKgraqwavw8XtUgakGXGSr+45/YUpiQFTPWHvafSJW+l3c4qyTQVRXEIy7EvlxHL3m8OdKJb3Hi9aAB7VucIqtqgSxFa3xFSZXUr0eaD8RtbksS+DWanSjw/mQq5O+bM05GfARfxz70xx+kSgSRK0OF38L+cHRZF+wMv7RXYxHDA97JJRXICrkpudOKbJRjTlPTrUVXVkYfWva3p4s3G2ShvWxW2k5cwLoiYaNXvM9OVC5q31F1UBq4ZkaWRgRExJguPJP3C+fdUjuixbIAysOcEsj0EyO7WMSyLoZqO6mH1zHARBCfipJY9WiAgAvL80/lDBF6cXP+HsHH3CMgdtdjNaVYKUX3LoQgyBbK6YWtsyhYdCb6S4ol+KwVJW1KqK7i3tg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(23010399003)(366016)(921020)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RvLBHy9hpzEjspfqK3c1R5aWEvIUmReFrn8gWq+lhu5icmBoRxOl64hJTanc?=
 =?us-ascii?Q?WoAn1JBtyI651MdkloFCwufrtl42fn+CdbUcIRLsyzBcW8k5jyBlMcKbEa0Q?=
 =?us-ascii?Q?XqW65+gHRKrx8tAXde+mdRoO4HDQsIem8753wm20jgwPw9cfUFaNmzM2Y9H+?=
 =?us-ascii?Q?PkrSu6HDlLDg2C+cTraJ1VBtRlwxZluhmGfX2lgGPioSi0gkcm0qvK9S0xgS?=
 =?us-ascii?Q?U1ZIgOUqGhv6c3IvvUbqUSwRxwiRizu/lea9qt/C6lWBI2xACcqQWZkdPWG9?=
 =?us-ascii?Q?rCJ6Lk5F06ZZ4R8KIvuIb0RqBBQbDZo4wbcCUJ/ml0+jYi1pbsc99P6Q/UoL?=
 =?us-ascii?Q?oyd2VVaBK8qlwbfa+AE0I17gncRTX3UmTY+MRZILuP6tkt8F8TOVyVQcx13s?=
 =?us-ascii?Q?uLNZHz3+8+nsiVoq939xSdIA7Efn08eY9UThz/Pyj3alhV3PqM/FLd1DNMY3?=
 =?us-ascii?Q?rr+XXHQPnpGBjODCyNeJjc71NYyruETWv/CaUHeufpSnfcTBrsPqB2nNvg2U?=
 =?us-ascii?Q?fgEaq4ReO6C9V7USX+TejdWFk+M8ulV5kpTi9pybw9JK8bi19KE5L2ohwH+A?=
 =?us-ascii?Q?MDtkGC6IUGKTeb4yKQz/dN71mPeJvwu73cXN0uFXA06r58cAjfphhr7NJEj6?=
 =?us-ascii?Q?XR6DjRZjXozXq1Z9e58qCBBygcr0C6NgCC3XYuEiAsJ8mgi7w7rgNg3yS1GG?=
 =?us-ascii?Q?ns0JGqg9nB+eZI0HdhjX8DN8xq8ZVAvIgKWwWnbl4yHOyFlp8cCe5WQ1kLzk?=
 =?us-ascii?Q?GF3azui28hLRPUdZzC3QK8QzMFvBV8XMPUjxvRCXt2g9HNKJa16dBd7MKBr9?=
 =?us-ascii?Q?UuPk918bOsK4PMVA8Ip6zkYbICfofrWBD6C9cOKTSKm7cCntlwNuB05vgKfz?=
 =?us-ascii?Q?vhqXjXsC5TtpJ+dEDv2OC4b/OtVXAXJR93m7syqSjOlSaquBSBOPspJAG8e1?=
 =?us-ascii?Q?U+FEnsbsSuMICiWX+iOTQUt4jfmBWL8o06uqiA4N/7BzoUBtLLOVnyKsOqrP?=
 =?us-ascii?Q?Ph0MPNDCPRaTMcUIiG5MOtCakJ+FBc9WlQBjSSbRblEG5Ih7NSYXT/JdMVyj?=
 =?us-ascii?Q?wxs0qwU1fY4IDV3CG2kB/vDCNHjf/AbgtKMnLLAL0l8zzs5WLYGE80s3CGe9?=
 =?us-ascii?Q?ksn7IS/35VmdfeT9WnvtghKbQes79LyEpdRXiQ4ZDsHubZFI91RiqxxGkQjK?=
 =?us-ascii?Q?ZnASy0fEniL42jFF0DF/So9aQciDJVvSsc0S9SbHWHW1LceOSnuh98PqK4rx?=
 =?us-ascii?Q?MuIijFuzGhlkFBeDzgqiTnmMyLrUJmQpnZBDbpFWoEs3FsTRaWbNXe8X7oD/?=
 =?us-ascii?Q?FBg2T6B1qTVURxmNObEELalpdepts3U6RDQrBlCFtGma2gNMOx1De7Q0iB2z?=
 =?us-ascii?Q?PAWqMP8u38Ra2k7ApBxSsxv3ZquxKk+TS27aA9beLRjnBaLLEEFb3T/fhgvJ?=
 =?us-ascii?Q?l4Ikju+4MK18bwQQHw3RXkJGlsmxOWfnhsj+Ix3/LVN76Bxcirf2VuCeiuhw?=
 =?us-ascii?Q?WElPlGfOgwfjhrDvb9DkYo8Kzui6dKJ2O3k18giK0/Eq7JEGFIAHGWFKuOzd?=
 =?us-ascii?Q?1pkIYy2IiztpehQfwiKDWR+Hnqjvh+NeGCDDiT8nbD6sZ8mFSaMgRTmyL0PW?=
 =?us-ascii?Q?LETmKb54OST1gMX907uyn/DDEwtHxS3ZSco2aqQywn4w4iqtSSFh/nbqIc/6?=
 =?us-ascii?Q?t5WU8aMKkBUiNRBWx9GCc/q6NoeQP4n+zsuTem00cESWCxCI/km+AF2OBMAw?=
 =?us-ascii?Q?jMF3nHLa5SMk0r2zL3PlSJzFGDcfe/+9CgvS6yda44ispcNCWN31?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e87c2d9-7f9f-48e2-3afc-08df19a2f575
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:46:20.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nv769MChtKGBMICfTaTIUCOhNh7MOBlUEOduE1LfOZ5hZYTfvJ8wKkEX8KJdttkEEl8Q1D8GCYjFtcEvPM2Bet8ZwnuRLrELAqI3El/BQGthD07Ko1EoJ0CIMSW6w8Uc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB823501

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
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- Fix miss "R" at Reviewed-by tags.
- Fix error path unmap dev at mxs-mmc.c (sashakio reported)
- move dmaengine_get_dma_device(host->dma) after mxcmci_use_dma() to avoid
defer host->dma if use pio mode (sashakio reported)

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
 drivers/mmc/host/Kconfig                 |  2 +-
 drivers/mmc/host/atmel-mci.c             |  8 +++++---
 drivers/mmc/host/jz4740_mmc.c            |  8 ++++----
 drivers/mmc/host/mmci.c                  | 14 +++++++-------
 drivers/mmc/host/moxart-mmc.c            | 10 ++++++----
 drivers/mmc/host/mxcmmc.c                | 14 +++++++-------
 drivers/mmc/host/mxs-mmc.c               |  9 +++++----
 drivers/mmc/host/omap.c                  |  4 ++--
 drivers/mmc/host/omap_hsmmc.c            | 12 ++++++------
 drivers/mmc/host/owl-mmc.c               |  4 ++--
 drivers/mmc/host/pxamci.c                |  4 ++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  8 ++++----
 drivers/mmc/host/sh_mmcif.c              |  8 ++++----
 drivers/mmc/host/usdhi6rol0.c            |  6 +++---
 14 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 79bfc425e7c7c..a8d0e7be0fec2 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -214,7 +214,7 @@ config MMC_SDHCI_OF_AT91
 config MMC_SDHCI_OF_ESDHC
 	tristate "SDHCI OF support for the Freescale eSDHC controller"
 	depends on MMC_SDHCI_PLTFM
-	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on PPC || ARCHMXC || ARCH_LAYERSCAPE || COMPILE_TEST
 	select MMC_SDHCI_IO_ACCESSORS
 	select FSL_GUTS
 	help
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
index 097498a3f8ff4..91502cde0b6cc 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -290,6 +290,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	unsigned int datasize = nob * blksz;
 	struct scatterlist *sg;
 	enum dma_transfer_direction slave_dirn;
+	struct device *dma_dev;
 	int i, nents;
 
 	host->data = data;
@@ -302,6 +303,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	if (!mxcmci_use_dma(host))
 		return 0;
 
+	dma_dev = dmaengine_get_dma_device(host->dma);
+
 	for_each_sg(data->sg, sg, data->sg_len, i) {
 		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
 			host->do_dma = 0;
@@ -319,8 +322,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 		mxcmci_swap_buffers(data);
 	}
 
-	nents = dma_map_sg(host->dma->device->dev, data->sg,
-				     data->sg_len,  host->dma_dir);
+	nents = dma_map_sg(dma_dev, data->sg, data->sg_len,  host->dma_dir);
 	if (nents != data->sg_len)
 		return -EINVAL;
 
@@ -329,8 +331,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!host->desc) {
-		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
-				host->dma_dir);
+		dma_unmap_sg(dma_dev, data->sg, data->sg_len, host->dma_dir);
 		host->do_dma = 0;
 		return 0; /* Fall back to PIO */
 	}
@@ -439,7 +440,7 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
 	int data_error;
 
 	if (mxcmci_use_dma(host)) {
-		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
+		dma_unmap_sg(dmaengine_get_dma_device(host->dma), data->sg, data->sg_len,
 				host->dma_dir);
 		mxcmci_swap_buffers(data);
 	}
@@ -1125,8 +1126,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 		}
 	}
 	if (host->dma)
-		mmc->max_seg_size = dma_get_max_seg_size(
-				host->dma->device->dev);
+		mmc->max_seg_size = dma_get_max_seg_size(dmaengine_get_dma_device(host->dma));
 	else
 		dev_info(mmc_dev(host->mmc), "dma not available. Using PIO\n");
 
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 7c7c52d9e8e72..c42e7734caf1e 100644
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
@@ -214,6 +214,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
 	struct mxs_mmc_host *host, unsigned long flags)
 {
 	struct mxs_ssp *ssp = &host->ssp;
+	struct device *dma_dev = dmaengine_get_dma_device(ssp->dmach);
 	struct dma_async_tx_descriptor *desc;
 	struct mmc_data *data = host->data;
 	struct scatterlist * sgl;
@@ -221,7 +222,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
 
 	if (data) {
 		/* data */
-		dma_map_sg(mmc_dev(host->mmc), data->sg,
+		dma_map_sg(dma_dev, data->sg,
 			   data->sg_len, ssp->dma_dir);
 		sgl = data->sg;
 		sg_len = data->sg_len;
@@ -238,7 +239,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
 		desc->callback_param = host;
 	} else {
 		if (data)
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+			dma_unmap_sg(dma_dev, data->sg,
 				     data->sg_len, ssp->dma_dir);
 	}
 
@@ -640,7 +641,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
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

