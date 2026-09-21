Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D8C4BD34F;
	Mon, 21 Sep 2026 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006911; cv=fail; b=NBypjse5XdsL4drqgDjnabnl6RfkRhhhelVnv/IhoELAh7OqNC/80U9tka71DU6Jin955UlaEO9Rgy8InMEYOyB7Z3xVcOlFFbaH9Q8+N/v+nt5+xwM3qrt5uamCVh9HMGpAzXbLe30hXIsvivxnWFRVuTeuR7Oj/VRgSHqHrr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006911; c=relaxed/simple;
	bh=eeu5SElqmUMD6kBDALfXEwO/2IZJ13X0VeDHcgsVAts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jYCHi7wjeXGCohJ2F9t6yjQlBo/Bdzt4qYaA+DbNnnFwnGCxtSEoMbClQI4DuaEbRaZIYSlr9NFcCUzNhFv7h6qo/pT8zfhiOS2f3JlIa9OWUZ5DMJbeNYsoN33vVGk2bcwEfOIE9x7duV64W2CMQ43WsqWnfz8f+1lvO7Tf/28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I9S5BAxk; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I9S5BAxk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcwUXd5eghpl3OcBmQjtf59A4wzIaFOZThmRlJLTksXqP2CXvs3Qi1OJimUlLXezW3VOtLdURqys7fdyvTZ91VdIYuGqOVhKp2BYkPMgdJg6yh25zOULSl8boyL46Hds3YjmMffBagWDM0rQCxTObPlcvRQIWw34Ww/zgLw0vv3ZwFUlQi4eMgm/iUCBSEf+ZKxVT+vFtdrJAIK69zoRhbMql8Xy+3E1HYMarfWvPwnb/NqqXwNbJRHaXTSBE50orUrKukbQ9MLOmeidIifLpJ0YyFZRz3AJ01zxoouEAqxMULe9QxyW0lJYhAgXW9OXNgMa0bG5cHqOnTYUSmxIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeu5SElqmUMD6kBDALfXEwO/2IZJ13X0VeDHcgsVAts=;
 b=dp6lgFbXVH2zWNLtB4baREK5WEJCNCf8O8C90izuMFa59OiY/baJUWQgAf6sX2NShwDQIOidrxXRobsCzG4w2NiyKV975FcG9IgeIfr5atpHW11SvL/Mr8GYK+P9xdVJyeg/yN+6Tnj6B6NqRLcPRYqzgIeCbjn2cub0wxaXV9J6wP2Cqekt3cjCzrAcru3AEIY0e4FeBZFjIfbcprTB9DidbbdEHEgxq/X9mtGeLza9MTVL+y2yinqaakgYE3Fi4cY0YLV/26zPEzZXCf30SByVIwOJ1dkO7DbjhQt7IxOuDahYTe1PMxKh2T5UGp7viIKdRuo15Q9xkp1EndXeQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeu5SElqmUMD6kBDALfXEwO/2IZJ13X0VeDHcgsVAts=;
 b=I9S5BAxklhCqwSKuMJdi6x3zn5tGIfjHt3c6x9PsALoPeZMe3Q2ZOqmbWTBR9nZ+KKulNMhtDWOhW4R6ghOcUsdfeNFU2Svrq5CR9R3h+CjlwgDuZpBrMemdx8MPVDwiB4aY7yO+lmfkGWKvCk1ZFRqdx/UhNyOWexRAt975UansZirMrJkqzb8TMEhr7/gI7bM2oigPNh7d3s4Xzduepzc8u1mNboaVp8Ohjtq4ut7iOYwsCkgI+jGttiSS/EwLTaUZksfhCrFvCG8sdqg9xnQLdcXhPqpUCaJpjY3MMluw5s7bba/cMPEo4cB4bHUWsqen9LWGRTVgqmjhqsKypQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUYPR04MB12668.eurprd04.prod.outlook.com (2603:10a6:10:660::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:08:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:08:27 +0000
Date: Mon, 21 Sep 2026 11:08:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
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
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Linus Walleij <linusw@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Vinod Koul <vkoul@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rosen Penev <rosenp@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>, Khalid Aziz <khalid@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	"open list:OMAP MMC SUPPORT" <linux-omap@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	"open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Subject: Re: [PATCH v3 1/1] mmc: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <arFWbWgzyigSLAEO@SMW015318>
References: <20260921144426.1083196-1-Frank.Li@oss.nxp.com>
 <arFG6UHs3VRifkBq@shikoro>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arFG6UHs3VRifkBq@shikoro>
X-ClientProxiedBy: CY5PR19CA0070.namprd19.prod.outlook.com
 (2603:10b6:930:69::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUYPR04MB12668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9480c4db-0051-46f8-1a03-08df17fa91f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iph9a54kZb9L02c5d2bBHr07Kxg6W8ftoQctrnniEiZaEZZopw4Yjb5oSHWb5JaM0auNZj+5qLvP5M2EChZqSe1WCOe9nEAutV+EVxmekOZO2Iwbgr4eU0kfjoPy+BSklojh+qtFyNZ4n6uiKj+wporcvi71oGe1OekAFKApnjJoEoBuC1o211jJvDLgYxFarUvn70HiyncwpDbfNo+WmgrFQX9dIncUvPiCoSC/s8zIFXD7f2oylk7PWPSaZhf7AK2VCRfyBEO4ABxTYe7SqEYu4eIVOYkp85tIsqv0RHtWAYXnIOdN5LiGA6zNfJQGxvjkm6eOz+GUEsuDNRsM1JzwyyqAqyJn3OkK8kEydodJU4FLh9X3LmCUIMXEfxm7dZc0b0z+6dPSqd22P37VegDd8aukR+MswJQWe29hSZX0/FytmN6qLkecRazgev1dqkBU7NOtwYwo7MMAb6oxKOQ1/NlJXPLEoolECW+F9bZMN/gqxRz4MbOqoLyJUESIvF6MIESQNFq9C743qqylK7jb2xliDG2UFNRB8FQLHONjqAL4oxuZqVLT/hVIfMOrgzWOGL4ouRNUv8RvtOzrNx2GGMSGL4VLwwbEgonHZTxhgoY0QWQCOA5qy8JCPKcZvowsMDf130QsF68efYA1ww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OO66PwKA2AeFc68YhvXiHKQL82jnBoPht8pwwz0VA6jjb/jPS1SnxZrf/4JS?=
 =?us-ascii?Q?sbHtcBu1d2OgEy1Q8cEXUdgj2bhNQedS3Xbh6y6IMe8sUO7EYNqVepIoRyp1?=
 =?us-ascii?Q?0fZ5JzFOZpvvFHa2xmwHK2COLOuJiffpvmP0mcuHh5Gg16fj3fcL1LKQTRt2?=
 =?us-ascii?Q?KBomaoDTNAlUoJPFozUUMQZEZiSSwXN3kKyj/Ts1pc1WaVdSREP1hTBBGGHp?=
 =?us-ascii?Q?/wrNDk+4Z+esvObni1pNL5zewDAgrkvMF2TdGyGPP0EzPIfQTgj2VG5flfui?=
 =?us-ascii?Q?YuLvF+IJah+fxa/qwbJ7RXeNzU4wz3pnLIX6RUkZhNuVPA1+CApNEVLUdnDi?=
 =?us-ascii?Q?/UANJX+5HEbIfcz1z7iAXwmRPFjl5xLKjlJ/DzcRcMjaqcKgPycr49gXr5a4?=
 =?us-ascii?Q?2cUqRJ2ZB2tvUUihqsuSX8aCuiRAN3k4ENRKXwqHjVCx/ay8U0s4/jrUOppM?=
 =?us-ascii?Q?CdRRP5yu+gLfvJdkKJ4uNk0FvnECuA/vJlKZDjlb+nY0iC2YdeMiW+6A0Szl?=
 =?us-ascii?Q?OsXnjCefLYRxSTxeJBkrFVeUQBCuqzm7MB9XJ8GvHQm3JPY3Wz6JwX96p/5/?=
 =?us-ascii?Q?eOaIHNCT4sGy3XnufJ5vSFffTGk0bdNIUIcLOL7B95iopM3MH+CGFPR2zmtx?=
 =?us-ascii?Q?CcG1G5NQxlMWJkam0fg7K1sK1+fhPMpfsQKAMQkAPzaIQdHPtyqtLTuwzwim?=
 =?us-ascii?Q?NFCrhVVuECJcmxLQwY0M12qSIsS6RzrN738MC76vVU6eDjEXxNyW1wKFLlHN?=
 =?us-ascii?Q?3X+Ea9k5l+lzWZHmLrstHhnUn24gytrxwS1/fDu9cdz8FoJgBEqlqDyEcRDT?=
 =?us-ascii?Q?73RqecegxP2lb7nMPFOOapDOJ4Njyxg6RUnwYCp0MQbC7JLwiq+Je9umBCLY?=
 =?us-ascii?Q?LnCVSpGsvKaZ67lxSqZrjNzufqVhy+8gTrcQpu3FmaiFyl9Cfh79TrKQM2kY?=
 =?us-ascii?Q?1tOMKLCa2gwDDCJYOIZ/G6HHBas6szJgqrxkXQA9q8vJHNJgKKa+uqjmFZ62?=
 =?us-ascii?Q?ttu7t5EJqfNKV8hmiTRZrmKEFK74rcfUSn30nNybcjMyJ8qmkeiNtKqPOWp3?=
 =?us-ascii?Q?Z0ohScZkXaD9s4Zk/0Vq+ajObqrH3pIyjCJBa1qkVlusC026EBi1AZ4YuNIp?=
 =?us-ascii?Q?4XHqZvLfSJ+ZLj2KUTt/RH4YkGuEVdnquPCPnQFm5NO9BvXUfc2siiM7KmJP?=
 =?us-ascii?Q?GTn8PXDw2Grbuobj8btwGXwRdwPdCKFcCBgQ3resj1YwWtIgkUXQjEnsy8fO?=
 =?us-ascii?Q?aPsIjJUUiKWEQD9UqOyjndAIfzmuby9n6nCHfLDpsSWks3pBYAoiJYWM1xQc?=
 =?us-ascii?Q?z55kK/Ak+nbtpVqBMRT3Vlp1y162jRvPsb4GObMLyR1q3qIq6ljlpX0CrCt0?=
 =?us-ascii?Q?ysvnhC3yqLQ8VQuq2msnhmTRhVH4+ohLec5BWSMWiuORwjFEgswf3VNBgdwx?=
 =?us-ascii?Q?z4JCMf/vfJmqJjTWXf1qhVAqgT14LCxvfkiGXHzVHzoq+nBp36Q+INNIU/ba?=
 =?us-ascii?Q?Eq+5GnP75j+fHebtmlSrFJtIdOwE/NDoyOrkHiXL9Az5SVm0cUCCuURu6D6O?=
 =?us-ascii?Q?16epfiC2pzxQ7Meyiq8b0j98u/MdBgPEO+FAMTOa6oTkUQPE7uUFn4PexS+Z?=
 =?us-ascii?Q?SfiY15VmvDIa5IDldTYVyExU4WEbtpNZZb4bXadd7ORqkTux3mbJQna6Zmf/?=
 =?us-ascii?Q?ZWJwUBuY8n2eYCRKCVXuSxHs4XtP86yqY0xYmlsUbVgpp/53BezlkNTsC/aD?=
 =?us-ascii?Q?GoKwbg0CJJCKndV5X1vG+V4sDyuxJFjpHvEWbOfizwhx3maxVaXh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9480c4db-0051-46f8-1a03-08df17fa91f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:08:26.9581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFChKBo5HzPC8CRCNheL05TlR2RcrCLVLtIR1j+h/eU7pg3qTvhqj5DOYIsjaTskijZhGevXiR1yID4AClaWEGdd3/CoVuzE5Vkkv9cSZbY3YeXoXncZ6mvrVRjqzWN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12668

On Mon, Sep 21, 2026 at 05:02:01PM +0200, Wolfram Sang wrote:
>
> > eviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Missing 'R' at the beginning. checkpatch would have reported this,
> please put it in your loop.

Sorry, I missed run checkpatch before send.

Frank

>
