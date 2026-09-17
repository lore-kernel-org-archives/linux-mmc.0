Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168D4F3EAC;
	Thu, 17 Sep 2026 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677773; cv=fail; b=R5sWMVmaPEOrS/CnAexoGt0199DyuLZG/QthPwx1lmVa+if22iVgdsIQNwM/z8Ta5UEzD4tmIfmaxQ4dvAuC423YWqqOdCQwHS7aGk9dyyDZHtjWP8ih+26JE+bDqp6dAu6P2lsfTo14kbWCrGwShieWddHp5NOc6rS6rui62Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677773; c=relaxed/simple;
	bh=lOULUTfzxVlXnnRc/qDaVFNV9iPKI042EWe6SdQ/+bk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FseWq4dGdFfzyILGgxdA2lCv1KjVG+pA4E/78/IVFUoovSbV8rnURaIiGup5DP1Z2bxupELRyHIuBd2hSbPGev5qNjByCBF2M+cWZbIBNgmy5S+i0NgPlyE5v7jL8OWyMjhqFpy5dtf8E0IXuwRXqNiw2r+OwesE91wCHlp8Xek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w+bGqAV5; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w+bGqAV5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOzzMQy5MmXIggJk6yI3ae03zDEZkw1I3XLo5Bvx063ozHBQUDW1tUONgBep3Rh68z0W91lfbaFQvcYYTSjtzC8shlRAv8PwIbOgr6QgYLcpXLT4b9Yhy0XwjcncG3o75VkhXXoYzqa31niDQFXBt0PlIqZo61WeG9KH56VumSavUVNtCMupuf1BBLwMZNKx8tYKPEuNJVGszkb+r58OgGBfRyuuUFLvgZhVY15HuEputahE4UvcgaqDoXcdflOGtrcHli3XynhQHfXbBJcT5cjgvBhIV3TzK5A89JqjasevA7VyC1/9ejKxxZJOSdbo228MUVTnsZ5c7zHRqOjx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8joHETlr/Oqf2dHoCAttN9gzT5V/GtkVD/aLhuvciYE=;
 b=BXkXTIWLt2ndud5hXN4A2mldMKrF8aZaDHpxkw4PuDMbz0VzPAUP0sfy9uGYJv6Qu1bmVWa1nEk82xdosaoy/ry4lNW6i7mmjLfEGRaxOhnItDeSXD1DdNoTzxMJzxN4/EgzNovoyPeGVZxVam+Af6s+zorFPKZOZXAcjo7O1I8G7yqAB0JX302I8AHP83iyTDjiv/yVXgpQrl6Us3NTt1isOpvN0n+Bv0K2vfF4b3DyqMYMHjxxU5bVf8+puDB93TJSvU+fhTmsxV411Q9LlylWO1Y1VB4jbeZpYcYvbMnWKGjxMNtK5DXXX/gE0zV3k+Ly45t49SBWN15Wpt1DHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8joHETlr/Oqf2dHoCAttN9gzT5V/GtkVD/aLhuvciYE=;
 b=w+bGqAV5zMATM+hx/YmyA96S1gvffY011EL0JK0SbV2fqTqLLiO6qKaoH3jnwCxIryARwqY6K1aazL2inbwEPq5zVUTP/wC3VBVtSNfn7mM9YrVen2uoo8iWEePH3b+EuIh5baUQU+PeFALv57Y+NWVLTsARRI9VAdZcucgeWLhlrXPaTZ0SvwK07R/BMBU+G/gC6OHgSYTCJOEFVZg70ihrZhanikfMjJGmkygrDkiT0Ta9Jo1q/NNqY0XMqo75WyQXHVMuzxAsr1QaPx/beq0GtZLUhvoCWWmt3XRO5Zn8HjpEplZxqFXRBZjfHQxY5CcemkZ7qzrigsKenCf5/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by DB9PR04MB11511.eurprd04.prod.outlook.com (2603:10a6:10:5df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 20:42:47 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 20:42:47 +0000
From: Frank.Li@oss.nxp.com
To: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paul Cercueil <paul@crapouillou.net>,
	Russell King <linux@armlinux.org.uk>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Linus Walleij <linusw@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Rosen Penev <rosenp@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Khalid Aziz <khalid@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:INGENIC JZ47xx SoCs),
	linux-omap@vger.kernel.org (open list:OMAP HS MMC SUPPORT),
	linux-renesas-soc@vger.kernel.org (open list:TMIO/SDHI MMC DRIVER),
	linux-arm-kernel@axis.com (open list:ARM/ARTPEC MACHINE SUPPORT)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] mmc: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Thu, 17 Sep 2026 16:42:23 -0400
Message-ID: <20260917204240.1284796-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0061.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::12) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|DB9PR04MB11511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f028c45-8c9e-4e19-5510-08df14fc3b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|7416014|366016|11063799006|56012099006|3023799007|10067099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	+DhAMF6YozFW5Xz+3jMqiiuL0g+EqHvJD52D+YO+EeaxOv9QIJwJl3omwfWZZNmgu0LpanpPcR2G6tcsmknIvrSog7P/MPgX/Mdgir4D7UNYNc9Ix7epVm+lbL8aQE9i+KsXD6xZsiglJW8RrBQT+T+iV2/WpgPAu/mbWMr2a2yqwUDzxJaEY4Hd4kslhmOwerATEuQDJ9Z3T43fq8As43IdWfJGJU1mlSuUr9e2g+bvyAWnFeNuLAeQvOjN+IGQVpR7+RST8IAs/emkkbLpq69bSTau3MykZ8MwkvdcAqsYrIuxZ25tCDBTFndavlv5BjeS0P7gMm3z9dhZNgglL31+re2aWlTot3o8tgdkJM1jxxupANMxWJCQSgZFd6736BDfjCmwnP6m5TIPqgQPDWdkPimpAjnVuEgC4u1V5wO572MDybkIb0N3royLTzGdZ8JsxppVpzl17pBcBHGbYv0UiRjc7kuFsvj58SpF/PhviWhCJHsBGHuD0KJO6raIFyTfzIJCukniacdPTxBalW+FrQR5gE+BLYCAWsMa6gJuELOgp2dJBsHVv/l52YZWXQ1vj/tdkmAEXTcT7uiHRYp3PzTv/NGra02/J/l73eZjURboVE3vit4JO8/OGn5+QMeKhlSgFAWzR+asdq3p1zca1po98ZSOVzC8Fe4NCyrSXjfy8IXTjlaLY2kqQllvn9919Kd1841qUUkdVnwcQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(7416014)(366016)(11063799006)(56012099006)(3023799007)(10067099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M7vbtDymwTCLT8WJD+SKkOiU507QPgGRW5bQsykyl5r+GyvTuGboOmnkGxa1?=
 =?us-ascii?Q?+Sgrej6m30Rdm/qhW7rkUL0RqqeSq2Y9zPJk8WvxraamJEYuSn+U7QFKpNTG?=
 =?us-ascii?Q?9yn8VRom4/29A7KOsICagD3VJUCe+xukG2g1p2V/nNGsKG3ibugv6liku4WI?=
 =?us-ascii?Q?bIxP2CexG17TcE4UmBm/tya3b/UCb46n6kwJ1A0qmo44p9RXg4MHcJspPNt3?=
 =?us-ascii?Q?uQIQ+R/cY2SG8hViOwGVtsttxpQB7qwSFPpZGlvJXe2TMQXOrH1r/hIKlyp6?=
 =?us-ascii?Q?y6EQVtqAi5KdXrg4gCFlWj7I6OTX7DpSZmhegI9Z47VKLGESMGgdB/usovSb?=
 =?us-ascii?Q?laVerOapEUvhEFYPzcK3FhRGoSPCggcAeHfggYs2ddoED0zfGKvC3zr2WCDG?=
 =?us-ascii?Q?WUpE84hd36CWi1aaTp0LSECqE4CzTbKSAfuQe8khUxfoSGp4aHLwTqJdr2ct?=
 =?us-ascii?Q?Vu+VXC19BuBTQeUK5rjz652GGEai2FiAS8c4YTLtWH8goUWII75FBGKv9jlW?=
 =?us-ascii?Q?VEbvpyvcm0s02qdGMAze8CEiuDP1nv8BuHoXJtdwsBEuWljvFYqbqzRjBu8F?=
 =?us-ascii?Q?ge4mSGPTFjC42GRN6i1sYJZ1rjJCW6oTeAjoAFfaMcpuS7NVLuIh55H+Jd6b?=
 =?us-ascii?Q?yhojMuvlehjSiBep7wtlw7S3d4MEernKPNipNHWouuK0ka5cLnlyqUM0x+cH?=
 =?us-ascii?Q?2kjKUHw9hzzWR/UHuunHxr1zR0RuNDVFdgLB4i+e4a7SEv0JV3SSpDfVupuN?=
 =?us-ascii?Q?w7kT8sO4tbBzZ5+nc0d1IDN7BB4PaDCJkK7Re/6OWKU9DFiRr8SqU/sWqknc?=
 =?us-ascii?Q?HA6JQLSHBaI4IPWrFCmI8zA4xpxNH8qbicjOT16l58286NLua/NUxxHXgBle?=
 =?us-ascii?Q?teSfQeTvr8MNTbibJ0Ma8GZ8ssA6WqGt4DtPqAlQnu+G3DU7janoPhYZYl3t?=
 =?us-ascii?Q?F+fcGnzBiyqcz0urqTc0kbDYkKgo1Qw5AbwBdsISp7MDJ1+sdTeBcE0+Dcgu?=
 =?us-ascii?Q?1A7qPbfJfH25FB1IRzeXQjEFreDZwnPmXqL+JCXm74zaS8MVJl3xjqs3eT0Z?=
 =?us-ascii?Q?o6mYqLJhvXS2a93JBPCckKX2l3JBFy9tqWBwlVrYso05O/ont1s+RD3w+AGy?=
 =?us-ascii?Q?pyBz9JezJftvSdJbQ/JOO5dCU6/C0Q225eusv4N4a3cYNdE9QmISuCuqMWiA?=
 =?us-ascii?Q?GfDFDIIEBnns4U7d1RZSu3cpIAmeAf064FUwu8+TrBYuiQOaWvZoY3JtI9oL?=
 =?us-ascii?Q?o70akAQLhmys/lSIuf9JjySCRDwHjRNSZcWOGhnx5i4charZ72jbtgfIOgLf?=
 =?us-ascii?Q?JF5auyiKRr149RxvvqUg7rMEOQelPOvt7as0X3QaQlaPtXjAVjQBfpYO0sk5?=
 =?us-ascii?Q?sHLQMkXVg4ihyF0ywCJx7D8NCCpBG87kwN/5R33hviFbju0Sxc3Y+n/6LlSK?=
 =?us-ascii?Q?LTIYAzA143/H+qwDrDbLwjD5vcWLX6a88hG3u2vIPOvy/a6M60qcDraCHkjM?=
 =?us-ascii?Q?x9dNVBGU76SQ4uAu2m7cFwNooVG0Cgyj8uzEGA5MDXBQrMlMfQKSDfU14CdR?=
 =?us-ascii?Q?prZA7bpHBeegRn/HeK+cMb3ETWZyUyboRS51BWGWEgGwu7N9eeJVQBaoYAa0?=
 =?us-ascii?Q?L7A1xFfdNgHLh8Pw68gk+agQw4ZT/nEj9n3T6Cwy4mwSSC0aBFO7AGZZPooi?=
 =?us-ascii?Q?s6/V6dog+/MAeoGIpSDQgYOKbvtmGbPYiR0vr9smYxaXXi1Yd8z16QkuFu24?=
 =?us-ascii?Q?GtQaCZIEggNRpIETUwmIEJTnwLqIfaHAl30xjMo2OL+pNqwN1e7k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f028c45-8c9e-4e19-5510-08df14fc3b54
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:42:47.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co3qgeCl/qFALPq4dZxmPNiaaNjBvYJhT3YAPu9Y3+6xq3W7xbhUFtJdZFPoVFa3b66kBMQRT+eR056MWnt+jkVUIn/bH89agr3JuJAZhn5br2HAV/EnplbUYOP3RuoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11511

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
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Cc: imx@lists.linux.dev
Cc: vkoul@kernel.org
---
 drivers/mmc/host/atmel-mci.c             |  8 +++++---
 drivers/mmc/host/jz4740_mmc.c            |  8 ++++----
 drivers/mmc/host/mmci.c                  |  6 +++---
 drivers/mmc/host/moxart-mmc.c            | 10 ++++++----
 drivers/mmc/host/omap_hsmmc.c            | 12 ++++++------
 drivers/mmc/host/pxamci.c                |  4 ++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  8 ++++----
 drivers/mmc/host/sh_mmcif.c              |  8 ++++----
 drivers/mmc/host/usdhi6rol0.c            |  6 +++---
 9 files changed, 37 insertions(+), 33 deletions(-)

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
index 416bdb184ed4c..5d81c96ca4f37 100644
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

