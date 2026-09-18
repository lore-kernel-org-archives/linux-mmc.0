Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31283D649A;
	Fri, 18 Sep 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745641; cv=fail; b=WzYoz1hzB4F9lmnfhb4JWsw3gC2+tqzRptvSZdtSg6mWsu83n4MoO5YvpX8ztpxsM6+oYdcmF7XfzyAoQIKU4fbO8QK1CBbYAt0EkTDR9Bow/9LgIF33dz5lBL3b49CKqXh/91kn4B167y9Z5E0hciUHCIucRQSaOhb4P4XSYKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745641; c=relaxed/simple;
	bh=1HWKTrE+7X9ua2FWfCHl5lpSbpbtPRGqqQzp0PTxiVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X7Ha2VH6pY3n5Tms7eD7CcXEsxvxUn2BgrKYbn1aMO7rx0R7Z0asr+jIQcVs3QVGvUYrsJwC508m+F3czgUfvNdG4HuBPCVLTl/+xWVxYlH6xyGVpiLfDMsvZ02v2QsKbeh5P2O9G+nRoo/BD95CQA9tvHHs+PsttIMp07lUEo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OH0DipIe; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OH0DipIe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN5VjFnE1O5QP+l5JW5U9H1JYZgksV1h4cetMHiEWbZoypOJ537FBaVN75e9hEaDH+UF/dBtV6lM84C4WxeM3zsmxAW8AxJyh/kigpkfmakPgk+11trSgTDKd58VkfDgsgMGbYPh5iz8XnkjrjOMZVyknEJ6j8pvPQXgsUbGjm4bk+s1gHnYonCpSBgOZPe3iUJWurekPiWC+tUbxxRxJi8HUnO26g0eNH+DpmDJi1HPSva3OpFkkSVbJolxNnkkRewaB3wDnQr9rRimhDM/135UhqpvAJeSn8VXFuvIrLGWzMssaRh+8wjlHhSGMkcCi0aC4U1De7zR8pDTu45Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFKNW++O0mGWY5h3VZ2QnoIWfFnRmrKczF3JOBSIwoI=;
 b=HJdG5N7zAm5Dd+lsgr7roxkEHUAI0q8tKQo8RTVsYsNbh2LriOYXhCGKRChgtbvQjFkyz6OeN6M9ICkCqQEqE2iFUJ7BQGabgkmNK3OcXxpeMZxnk8H31huK7krxsrAtxR1nxjWdf/jrVXWCfVaaoBMnih5pkvWGKBMbOjIcjjN+dJhx+mT0nRGTIWHLkE21fd7Ky70m2MR8IanWcgJYdpM/vassOVXCdIhaOAx73wZldwR/NFBdeHCMnLbgvz1+JQuS75Sy/16SB49sqaj4P7swP1agTkETUZ+hiO/rF56GCYfRiPBJeL+KD5yeOjbLAT/sX59BNbChyOPPLIPeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFKNW++O0mGWY5h3VZ2QnoIWfFnRmrKczF3JOBSIwoI=;
 b=OH0DipIe3Ta+ePalukF9449+NTCdgBbSU7ttTpNB2Xk9IYBk1YppjNcsSVpL4ONtgwfSKEazIssR7glCqzmKDP1KhpEPxgEO6RPHpVMxMRfKAFlWmWHs006+HVXD09N/9AdSY4w4T5imBx8okkUwXkwkgr0XkWlj4cAXibtlxQG2OV9UwQtkc3yQfa4Go36wTRDryJ3VSKL1izkcVEFdGNv9I9IvlcPKhotmF8z+ZWzmF6Ajucmz5yx/kYWKLQvNeO5rFX9GESp9LP42kjblcC/zQv65lNW0bb1SNVVGWJ3iGlt7HHbRa/KU5Zv1saPMhjWg6d/zsjHaSDFSs5pzuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBAPR04MB7336.eurprd04.prod.outlook.com (2603:10a6:10:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:33:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:33:54 +0000
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
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Linus Walleij <linusw@kernel.org>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Rosen Penev <rosenp@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:INGENIC JZ47xx SoCs),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT...),
	linux-omap@vger.kernel.org (open list:OMAP HS MMC SUPPORT),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-renesas-soc@vger.kernel.org (open list:TMIO/SDHI MMC DRIVER),
	linux-arm-kernel@axis.com (open list:ARM/ARTPEC MACHINE SUPPORT)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH v2 1/1] mmc: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Fri, 18 Sep 2026 11:23:31 -0400
Message-ID: <20260918152349.2101305-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF00003856.namprd17.prod.outlook.com
 (2603:10b6:518:1::78) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBAPR04MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8c50e6-ad16-4f5f-119e-08df159a3e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|23010399003|921020|3023799007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	oHxMCBMUVrr2GiPBxqLFSb7+QVAdwHaGekgDxxo8j862WuauBi4pfHADd2FYbUVQ2npIDO8vmxX9rDfv+2P22vX0BNFFJPiWpNuBZ4bd7dhXK0AlP4OSYg1uYkewxrRfHwbKip3sE/nMlBayZEWHk+EwOXj368esPJu5RxCXA3eC6QbUxSBd4vaKuI7RYi5Q1WNpm1zVKF9rIE+z2+49CyAluiV4ft2yx2QZZ/zJGZYlZ77t87VpxvBvYUQZXFMFY3bH2MaY9mfINyGR8MUN2jSWjm3Ou36sdS+eJ6K4yUfnW5Ul2Nz8ubNqiYCTPylUVXL8Ej0DxgMhZs7p93XG3wPhtDUVOLCRlj8Qa+HVxLum9U6iUDrz1aOBTm2b8E5FLnnhQBQeM+sHZnhn3ZHnE1ioo+9lW7Jbh6TiPuMRNib/kdCJOXvAOXa4D3rWDfnhGreXRqrzbn8L+KHJhqS7F6YUVwCZtg/IPjGHP6QvQC5VSFffow/dPGq2M7HnVPeDj6/Hyk3fXU6wdiuiCCOWayk+HWgFJCRG17QXQBLEAeJ0Ds1P/Fb3Z/+NmeaLz8/sbdoq2+l40vr857uhkw5YQfLUz68IKRTPyO6DsLwcNx4iSsVyBt+UBdiP81NbcO5Xdr5jvTNc0YyA4AJZWI6l3oEx3/Cgtf12Qi0JbNv97036hnxNotskaCoV9/rqf8gsB0BchADGviKxIrznXG35Sg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(23010399003)(921020)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WXR5Ya9OverUlxeShNpncj3l5qL2qAa8qJnS31sdujzl1Dya5S99gcFK4quv?=
 =?us-ascii?Q?wTFZ5q5CHn6GKGxnkp1nybLMSQcQjsH1+aTXoXP5BdfS7NwiF7qhFxd6uC/l?=
 =?us-ascii?Q?9sb5mNCLmEFGvVVt1Ll3iuiQLOYty5T6ZJXcJGSxEVH/02DZwhya545UJ539?=
 =?us-ascii?Q?uM/uyFTrsDrqO5ofN+LZf4z2Si29LUR2ZO2uC9DFLjCMc+SGsj+Lchn5v4dz?=
 =?us-ascii?Q?bHm8aBEZJcCkWzFO/7jXSyA9KgO+Uq1eXETp98rpEzSgpL8LcPxp8wm3g5Zv?=
 =?us-ascii?Q?f3szsSiSMFXMHIVKTpvQOmdnD2dGPoDJeHEeGUOqW1jMJ0W2wrf98rurKUVR?=
 =?us-ascii?Q?zH6umlB/CawRctM28S2CFZ5nAXUQqQF4janipAhGRmuapeZ3MbamcvIhZUb5?=
 =?us-ascii?Q?K1JnDxgBRgBEJDW0wCDgjwop9n+h4iWknVhWi6/o4OdUKht46JjyG/WTClPI?=
 =?us-ascii?Q?fmlXmCtEAzhkf9xKqO0tVDpWbihKtxyy1FLvbbJ3SvJ7zhM2uQNNyqafbJ8j?=
 =?us-ascii?Q?9/dSWJBv71NvldqS2cyMqS26Qi/CWnqVfnQ5/4Ow68MmwVkQ3yqiu5qeGsS7?=
 =?us-ascii?Q?byXswABB+AA7oEOtEo42dMl2bQ2MVpjycxdBAo8kHD/fDyAyXxMi0+SHQjpG?=
 =?us-ascii?Q?VMBZ39OGUIocmI4qo8P06BWuVy9Onrk8/jTH2Gd5bk+sbCeAj0sy+m3mEsMp?=
 =?us-ascii?Q?L6mmUKiXJPQSeR4DTVHsBg2cVyqcIQD85Fjq2Yi+K5oKJhEiW8p4i0O2J2fG?=
 =?us-ascii?Q?uHQr5ofARaZrk3xAaOgXLnZ1CcW0BHVmYXgKVvJmpB6Wq1dwE45L+VEc4wsK?=
 =?us-ascii?Q?1ytZdodXGrMbSISGtx5F0v4juUiQH/v2tOPJk/ASMlyQHUUFrV8uDUXJt4sZ?=
 =?us-ascii?Q?eduUuuxpcRyyrXUpL/wRZTLeGHF+i4gkdGUOaz80Vn3MTWIqopMovB/jV+9O?=
 =?us-ascii?Q?vdkiwSIctZ6p8FKEBJWPj4/L/ixvk8DZ80ysVqA0JkwUqs8l9YmC6pEfttF6?=
 =?us-ascii?Q?D1R7s4FyG96IAtnQBcq4pbNi5ncoCz3R/gp8lgUNmef7YVuVxw7E3cv1czFo?=
 =?us-ascii?Q?g5wDwTvLe89u8UqNVY9sqJ40dHhXIJd2CoGHq1kYVUFEeLYMbeGMcty3lqTP?=
 =?us-ascii?Q?mylupzbZlLmbYB/KPO5HVn45/8BNc9aPF6mwl6VO0vricGM8LCZvD2H8wDzd?=
 =?us-ascii?Q?of2wpEB+I470oBvvjrQdNqXXnrghF4Wtb8JjhnugZK99YH+mJyFU0INQpWgc?=
 =?us-ascii?Q?iLZ/gCEvLoVq6DSL92P1hpf/3u7az4w8zEohtUJ//mzXaIMKtwyJ4QBcFEtB?=
 =?us-ascii?Q?pvA/T2Sq6xuUmxEU8pcnxlY5j/H4bmABqUsTeRdIsS/tgVHwZ29L+Xai/XOm?=
 =?us-ascii?Q?L/6qwLfpoRgb/z3t3mazeonGD+DbL/HUwWqGFFqGGNYngBWRi3KPwXVcMgGw?=
 =?us-ascii?Q?rJHpNZopVtD6tVCib/FSwUL3uni0Cc5f9wDTj/tFbixwMJwQ0QZ/S61vuApt?=
 =?us-ascii?Q?5v5ipXNUfZdZLe5Sn71GQooxkbZocd9NV69rW0tV6R47F9w5f238vEZkciMQ?=
 =?us-ascii?Q?sPpTOMAResC624QT3g+rx45M3bQeezJ/q1iofKRyZzenut4D5LFruabejCu7?=
 =?us-ascii?Q?9eaGo0+Bat+ny+3Cd3/oCAF5hYmnxzG/U2pv/eOLc7nRL0av9cclCNaeStZI?=
 =?us-ascii?Q?21EZw5sgl2CvhqtXQV6ozOyb4BEAu+5TDXW+5cCP5lPQ8YTME/di01iJbI0w?=
 =?us-ascii?Q?ZGGZ7RXFbEP3r+f8e3AJQBxYplRIpsvmgKNJ5FG4oNdSWd8mBAw0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8c50e6-ad16-4f5f-119e-08df159a3e8b
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:33:54.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iE0cewy6CVC1lM6o8FAp/QNWgR+Opp1bs/Tfc/7KIxm/vlCQfCLiV07Mna6tli8fZao5TsaE34eiklja2BIpTPRmo1dUWL6adWc5iMnzmbadewUneUo1NW6NJABTN4Nj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7336

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() for consumer API

chan->device->dev is not always the device used for DMA mapping.
Some DMA engines support per-channel IOMMU mappings, so different
channels may use different DMA devices.  dmaengine_get_dma_device()
returns the correct device for each channel.

This also prepares for making the DMA engine provider data structures
private. DMA consumers should not access DMA engine internals directly.

Assisted-by: LLM
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
 drivers/mmc/host/omap_hsmmc.c            | 12 ++++++------
 drivers/mmc/host/owl-mmc.c               |  4 ++--
 drivers/mmc/host/pxamci.c                |  4 ++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  8 ++++----
 drivers/mmc/host/sh_mmcif.c              |  8 ++++----
 drivers/mmc/host/usdhi6rol0.c            |  6 +++---
 11 files changed, 48 insertions(+), 46 deletions(-)

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

