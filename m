Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793640099;
	b=VEORZpxaOE7IG6SCZy5tLKxDxtdtI3/hZHXf0A97gTJ7gv416oyAj/g4FUGQFOoUXVfF
	 sejths7n4mqkDmCBQM7RvWQK9KiPa7+XSbePFAgWCw3R3uPBx6JV2dbiD7hrlTVjaugP1
	 qAjLoTO6ghk1UNMcJ0mUs7o/U+05f3AJn/zDWXrgxy1MvDHKRPZZht9PnaYkzJeZncdM7
	 fj16/+0st36ztCgdrajrF/iXf562zDrPAOb2UwR1ig5mEyzlr+wuAOgruDGwviY8kxfy5
	 q0yoTXgsIg8HakEZ6Osjs0NZ1HuODdz1js9yqlGPPfOv7uqfGNztLq9/2GkNoKjKu4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640099;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bPO5rapN4v6Y8cI5tKdEKxZsiCrSBEDoAFlejyIoEbw=;
	b=UtICoI2ttHObQGZnVhl1XnAMLy7cUywN43GOKFnIo6NfscVcSBV2HE5igzlq6iMmVo6/
	 VGdMU/EfaNdNyQuNLztd84uXmkiVX1EZS2QUdWvfRxLbEZOJ/JOz5Jnq6/lCOp0CHqsz9
	 5CLHfyWYa3ZlRfOHq3q9qXhWCG8x4ED86V1cGZxjrIKwm+6uIG/ii+6VNunhiatG1oFEm
	 bPf6H2zJwvG/n4ajtaj73EhLuQXx738ZO7Raz7KDDfjv8CpnInplfH+6o6TnPRowFy9wN
	 WxW5DEc/VUIHJ4z5T1CoZTQ7dqF/l0U80tl5UNJSnqiUSv3tpkfBhne+Z5Rhea+Azmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FOj+RuJv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.69
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E8606B1D0;
	Mon,  2 Nov 2026 17:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D0E8606B1D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FOj+RuJv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koMkJXBvJvTPCgOtUAxFt8ak6UhB8T6MnWx1LYnzdWqon6jXdUNBxvJ/O/ezgplBjONWVS1nfu+z/qzczewV0wbebGjs4ybhzwFYX23WTV9xJXmgwAT8qzfT1oHqKPWji4ghHep3pKrm9cWTDpSINs71XbfbCvBljDblmOqI8Zpx3E17h4VpauHOpdI8CGuBhT+LQoutxCbDMsJ7Lm9zgBTt+erraVw8YZc5j5+YOl+KV4R59vuJwhO1rin7isO4QFZvVsiLO1a196+PElVuET/3pnyBQxeU7mihwC660bSx+ySaCaN370Jc8ieRp6EQeJ8R8Upta7Ixw50aL5aJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPO5rapN4v6Y8cI5tKdEKxZsiCrSBEDoAFlejyIoEbw=;
 b=WwipYQhzTOaQ2ZEncO5eCgreW2D68PhRQnfu5vlarhn0VLKbUmtnUnf5A4GiRqS03N0/P9mp/m61zB+n4t8faGLOUndhuv3fdTE0SqFZuvJFelcfmLi9ha5B7XqvGq/E6S4/Hy9PkcAz4ocTYl2yHX314E+1YEcTAYczld2VzARlVu8OJqCMMkpWxXJ3knTmkpblUdj2JkjyNORQFw6Ae+/fKT2ETlpFKy4kkvJpzjMUfQJtDTDRhorNg1b/dr4P6M/W1rt6hA6xgCN1/FXmJpH17IWdt3vXkfYeXmf/Be9svaeKYtxuXyJFrlkNArOBFNnxa0BWuoPHyFpgTUQqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPO5rapN4v6Y8cI5tKdEKxZsiCrSBEDoAFlejyIoEbw=;
 b=FOj+RuJvWiuxQZyz+oz6KUlLGD5yDvDNIMvkF5hfH0degvo/1ZT/8GZfjg0KspzdkOxKm5f3pE3hwtfZb2B9mfDLi+EttXVjW8p+OF6u75Y+OMfQ9CaLcAhWXM1ShZUCAYyfPvmHIyuxhm+/NK2kJ8YYCADEgZCSeElnDB5ye1t6B1648xDx1NYRLuKB4QgBxCNV8A+XqC/UThbeO6zYtqGOg0XEZ2RSQ3PVDxsDA+xdBowg1Wl+Bmvsj0He60X18JoJ2vXDfJhIT3yy050gGXuptXIzw3+eKkDHk9AOY9mnJtMKFyZ7dpCHsJU/JkihbUVyYoYz5PNRjAORvGZHkQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA3PR04MB11204.eurprd04.prod.outlook.com (2603:10a6:102:4aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:21:33 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:21:33 +0000
From: Frank.Li@oss.nxp.com
To: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	John Garry <john.garry@linux.dev>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rosen Penev <rosenp@gmail.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Pan Chuang <panchuang@vivo.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT...),
	linux-omap@vger.kernel.org (open list:OMAP MMC SUPPORT),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-renesas-soc@vger.kernel.org (open list:TMIO/SDHI MMC DRIVER),
	linux-arm-kernel@axis.com (open list:ARM/ARTPEC MACHINE SUPPORT)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] mmc: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 12:21:03 -0500
Message-ID: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013306.namprd07.prod.outlook.com
 (2603:10b6:518:1::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA3PR04MB11204:EE_
X-MS-Office365-Filtering-Correlation-Id: 4648b49e-7710-429c-4b6e-08df3905be21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|19092799006|18002099003|56012099006|261102123227099003|10067099003|261009223027099003|921020|261022105027099003|261021123027099003|261021121427099003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	ilb/HuJu4myw2uUYDDEhG24ksGmWXHV8RewKTjtgR/RHyg38tkl20udGIvc97o0YkNydYNpoMYf4UVifa3tdfqtEcUlsrdaqT1sYd0mm52CSFamB344FN1J0lFjBo/yTMWwlh9QtNgILyokrEhBvbbus9Om/ibqnxbmtB5suXErQHnKU4wI3H2LnSAUD3x1f5C2Qh5HY3FEv9TM1btURqGD8928y+YTonUoAqzY7e/4pPQzp9NL2gjW6/3KSKR6esDgqeXNGRBu3YfaPp79as+8v+KHj5H7xQy4RZrjvApz4f245UbuX/YFsqWhrMciP7KcXOnCAEi6PYic1aSS5UESXuoH48YQaI6sOM4KRLP2RaDEZL8qWY2udg53ETPqv/qXFCK0JReHWX7HmlfEzKNdgCD0V8MXCpwCMfXXebB3OpL5ntLWNSzOeu950RaxMGuHH0fNTSZwDu5/3iOEwv+LJK/V2iZjTFHeKAn7KkNebtVraDFaZLEbjOm9fNwG4CtaANpVpgQH93hl0HBjub03uvzQ6QSlk8c/DMTBmQRdA9v78pIKzSBYOAswEUgdfomE8oTEgk3Am+wUpbdoRgs9/KjiUvnXeyaScJJs0+ZyzyLbRInywMpjglRoI05aCOlUCwFeXreXfevmRtsUVWGb7+BkvOapKOPrVoOeRLFpViB/zxa2Sg8n16mE+fXKtNANv1y6r2fwyOfXpXReHIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(56012099006)(261102123227099003)(10067099003)(261009223027099003)(921020)(261022105027099003)(261021123027099003)(261021121427099003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a3vIbI9ddhZAuIbhf+OxiUTLDr3CHEpE7kqCzYQBiRFEGm2tYVJj78mBwyZC?=
 =?us-ascii?Q?NAL/AZyXvuWVa7PX46Xxk9W7FT/y9IcRGdom6euiortyqQiiP8VKx7itbIxr?=
 =?us-ascii?Q?ijab6qwIDA/gxiUxxlcIelJLWHfrLnn4Ggan9ycXYCBK2Su2er7Bgrkza7mX?=
 =?us-ascii?Q?qmJaSoZGSC/Yvs97+IavPmwz8C/gJfJ0T4hfFDUVQUbhf+DxVQCW8cdJayVW?=
 =?us-ascii?Q?rN0RzYs1nPgpAoUxMU7xi3XQgAlldlcE/aEzlywGCuYsSoKV38WZ8HCBPXSo?=
 =?us-ascii?Q?+28YLpdnDj6d/k9TwcIvJCFKvBeqS03wipzU29+B6FbQ/pC2k8xbj1YQUj0f?=
 =?us-ascii?Q?L8A2d3q5ZkFNrEAECBTymYNBHgIzn45rVQdhbcgaqgMu708GqO1Q6vXWpGPJ?=
 =?us-ascii?Q?acRRSBs7xY6KyHFYFGaaIBrEVBfW6lXxjO7/xBELFkb7mcGi/pCakuNBEH2y?=
 =?us-ascii?Q?mraFGLEhUSErnV9MGC3e5Ucxtvsq/KP7JzeiDOsccrnbBd9Jk62Mn7bjcfkb?=
 =?us-ascii?Q?RZhHAw/HHcz4o6krxdTCAEHYJlBPc3MNztLR9QoUfbLUEYUZ9C8h5NaBXnS3?=
 =?us-ascii?Q?nXqKIQ/jF4J0dbgCPlrQlC1jln1g/edHWQW061zKsgUmONgMK7BvFIuMjCBe?=
 =?us-ascii?Q?/TzZGrH8p+BOcpE6B0092NnsP+JZQZDD+NUU6Thg7acTqsuY4TwZMI3JNFLh?=
 =?us-ascii?Q?Oh1gKaNqLPydVUbrX5mpMy5K4wlhyi3b1rQOx4XhGNsygr06OV9mBnA2KJgN?=
 =?us-ascii?Q?4bbln9d1PBqTmojBdZfMLH/r93Mt3E7x7tY7QowAYB7xFwayZlcDCo4cGvmp?=
 =?us-ascii?Q?zTAJLFmES2XGMNxIPwv6WVHpaFo6dQN6eiBmI1H9tDZ6Rlbj7m5j+DzCwvjr?=
 =?us-ascii?Q?/lQFpBo5fKl05/8FGfHEbRNlS+XfVecKC5lJ8LKnMJLeh3FcG4fXQe7JfiM/?=
 =?us-ascii?Q?geQnC+Zy9HkdSJWz2HB2jtHBFy6s7nlTFYsJ6tukNe0u1rdlwaCj+Z+8bqvS?=
 =?us-ascii?Q?0XkP0za3Karfc6zgtBwotb2u+COxsB6x3BA9Q6bFOeHufNycUYMDo0bUJdti?=
 =?us-ascii?Q?xDTI5pG+5TYOKcbsadiOkamvUzyqII4hbPP0lNCYW/ncd92oazvhmDKMjUAV?=
 =?us-ascii?Q?gltKimmn0EB1TIYrZbcK/Q79NOiBsRuuO5o2NRvHjBWXpx6vaVAUqUW+QrH4?=
 =?us-ascii?Q?T18gEkpgi9FMjLi4laD9NPFmhfKyDXGmZ3hoo5yWBAibco0TehVU+cChR9Zl?=
 =?us-ascii?Q?dG6bfaz6ZsLOw/XP0KEnuiHzU82u4SRLKwjXjQ8ZbyQLDsFCPUN/pz3CEBl7?=
 =?us-ascii?Q?87RL5pvEJmB3od6lfkIUrXFgQpHyNSeCi0/GF34VQK6tlZpRAxuZ2v78Zt7v?=
 =?us-ascii?Q?FetMsblsRH6YsBeEsy/8hGZ0GeHQ614XVNSMqgmjTKltSEtcvMC7aHFeAUzS?=
 =?us-ascii?Q?PhZV+/T6a2QG7RkK26F315CyqgK0gfcnr5whBqkOH8byDavoOnxOlAr7FJ/P?=
 =?us-ascii?Q?iqcB/hNmyzxl+xoQADJp+S0IHiDWAaTtyzwYG9rRyfkZs/d8+kqmzVPPeMeb?=
 =?us-ascii?Q?1z2xWZKRVP/tifu5BjSXkefFcENmQAzB+VDMTI4lXTKVJH9gtdeags4HFQxy?=
 =?us-ascii?Q?vu2TSvn/AYol6bCvjhpvkn3I10dRLQ4bMxvsS59JOSvG8sZa3KrV5QUemeR+?=
 =?us-ascii?Q?0/slONkTa5LcG+w8X4tA+X0qedDW+ER/z5cEF2sbmJtXs3xHsgDelb396ry8?=
 =?us-ascii?Q?52PbyahGy2lHx2LVxXgNUb04uXoaIU8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4648b49e-7710-429c-4b6e-08df3905be21
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:21:33.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+FwQH8bNAwLPY1+2DX25NUlNmPUEwU5c+mDfoIooGlPigTKzIT6TyiqTd7ocWUkUaT3GIkGMsm75+MIngoB/552ROUtLmkEstwMyl+b4lkZ5J3qKZr1EtYu4yYO9oss
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11204

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper across MMC host drivers.

No functional change intended. Prepare make to struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/mmc/host/atmel-mci.c             | 3 +--
 drivers/mmc/host/bcm2835.c               | 3 +--
 drivers/mmc/host/dw_mmc.c                | 3 +--
 drivers/mmc/host/moxart-mmc.c            | 3 +--
 drivers/mmc/host/mxcmmc.c                | 3 +--
 drivers/mmc/host/mxs-mmc.c               | 3 +--
 drivers/mmc/host/omap.c                  | 3 +--
 drivers/mmc/host/omap_hsmmc.c            | 3 +--
 drivers/mmc/host/owl-mmc.c               | 3 +--
 drivers/mmc/host/pxamci.c                | 3 +--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 6 ++----
 drivers/mmc/host/sdhci.c                 | 3 +--
 drivers/mmc/host/sh_mmcif.c              | 6 ++----
 drivers/mmc/host/uniphier-sd.c           | 3 +--
 drivers/mmc/host/usdhi6rol0.c            | 3 +--
 15 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 98933be5f1744..de4ef7a675892 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1172,8 +1172,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 		goto unmap_exit;
 
 	host->dma.data_desc = desc;
-	desc->callback = atmci_dma_complete;
-	desc->callback_param = host;
+	dmaengine_desc_set_callback(desc, atmci_dma_complete, NULL, host);
 
 	return iflags;
 unmap_exit:
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index efd1903c3ccd4..9a2c995577d46 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -506,8 +506,7 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 		return;
 	}
 
-	desc->callback = bcm2835_dma_complete;
-	desc->callback_param = host;
+	dmaengine_desc_set_callback(desc, bcm2835_dma_complete, NULL, host);
 	host->dma_desc = desc;
 	host->dma_chan = dma_chan;
 	host->dma_dir = dir_data;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0b25d287a94..15c65aeea8030 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -884,8 +884,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
 	}
 
 	/* Set dw_mci_dmac_complete_dma as callback */
-	desc->callback = dw_mci_dmac_complete_dma;
-	desc->callback_param = (void *)host;
+	dmaengine_desc_set_callback(desc, dw_mci_dmac_complete_dma, NULL, (void *)host);
 	dmaengine_submit(desc);
 
 	/* Flush cache before write */
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 28aed13549a64..15689717c76bf 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -289,8 +289,7 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 
 	if (desc) {
 		host->tx_desc = desc;
-		desc->callback = moxart_dma_complete;
-		desc->callback_param = host;
+		dmaengine_desc_set_callback(desc, moxart_dma_complete, NULL, host);
 		dmaengine_submit(desc);
 		dma_async_issue_pending(dma_chan);
 	}
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 097498a3f8ff4..e6271d67b6f6c 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -394,8 +394,7 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 
 	if (mxcmci_use_dma(host)) {
 		if (host->dma_dir == DMA_FROM_DEVICE) {
-			host->desc->callback = mxcmci_dma_callback;
-			host->desc->callback_param = host;
+			dmaengine_desc_set_callback(host->desc, mxcmci_dma_callback, NULL, host);
 		} else {
 			int_cntr |= INT_WRITE_OP_DONE_EN;
 		}
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 7c7c52d9e8e72..6a2b3e6d9a207 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -234,8 +234,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
 	desc = dmaengine_prep_slave_sg(ssp->dmach,
 				sgl, sg_len, ssp->slave_dirn, flags);
 	if (desc) {
-		desc->callback = mxs_mmc_dma_irq_callback;
-		desc->callback_param = host;
+		dmaengine_desc_set_callback(desc, mxs_mmc_dma_irq_callback, NULL, host);
 	} else {
 		if (data)
 			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 527b89a5ed707..4e72e57d11971 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1050,8 +1050,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 
 		OMAP_MMC_WRITE(host, BUF, buf);
 
-		tx->callback = mmc_omap_dma_callback;
-		tx->callback_param = host;
+		dmaengine_desc_set_callback(tx, mmc_omap_dma_callback, NULL, host);
 		dmaengine_submit(tx);
 		host->brs_received = 0;
 		host->dma_done = 0;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index de5a3b70107d8..ba60b81560fbd 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1279,8 +1279,7 @@ static int omap_hsmmc_setup_dma_transfer(struct omap_hsmmc_host *host,
 		return -1;
 	}
 
-	tx->callback = omap_hsmmc_dma_callback;
-	tx->callback_param = host;
+	dmaengine_desc_set_callback(tx, omap_hsmmc_dma_callback, NULL, host);
 
 	/* Does not fail */
 	dmaengine_submit(tx);
diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index d5b8a110267b8..8e0520d338c47 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -329,8 +329,7 @@ static int owl_mmc_prepare_data(struct owl_mmc_host *owl_host,
 
 	owl_host->data = data;
 
-	owl_host->desc->callback = owl_mmc_dma_complete;
-	owl_host->desc->callback_param = (void *)owl_host;
+	dmaengine_desc_set_callback(owl_host->desc, owl_mmc_dma_complete, NULL, (void *)owl_host);
 	data->error = 0;
 
 	return 0;
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index f8427f071c009..06483f7355206 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -212,8 +212,7 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 	}
 
 	if (!(data->flags & MMC_DATA_READ)) {
-		tx->callback = pxamci_dma_irq;
-		tx->callback_param = host;
+		dmaengine_desc_set_callback(tx, pxamci_dma_irq, NULL, host);
 	}
 
 	host->dma_cookie = dmaengine_submit(tx);
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 426308b73b490..e5ef3bae88d59 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -196,8 +196,7 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 
 	if (desc) {
 		reinit_completion(&priv->dma_priv.dma_dataend);
-		desc->callback = renesas_sdhi_sys_dmac_dma_callback;
-		desc->callback_param = host;
+		dmaengine_desc_set_callback(desc, renesas_sdhi_sys_dmac_dma_callback, NULL, host);
 
 		cookie = dmaengine_submit(desc);
 		if (cookie < 0) {
@@ -272,8 +271,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 
 	if (desc) {
 		reinit_completion(&priv->dma_priv.dma_dataend);
-		desc->callback = renesas_sdhi_sys_dmac_dma_callback;
-		desc->callback_param = host;
+		dmaengine_desc_set_callback(desc, renesas_sdhi_sys_dmac_dma_callback, NULL, host);
 
 		cookie = dmaengine_submit(desc);
 		if (cookie < 0) {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index efb4c7742fe21..18aca84834fb6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1298,8 +1298,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
 	if (!desc)
 		return -EINVAL;
 
-	desc->callback = NULL;
-	desc->callback_param = NULL;
+	dmaengine_desc_set_callback(desc, NULL, NULL, NULL);
 
 	cookie = dmaengine_submit(desc);
 	if (dma_submit_error(cookie))
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 8bd9cdedafa4d..9fe49fa8f372f 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -299,8 +299,7 @@ static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
 	}
 
 	if (desc) {
-		desc->callback = sh_mmcif_dma_complete;
-		desc->callback_param = host;
+		dmaengine_desc_set_callback(desc, sh_mmcif_dma_complete, NULL, host);
 		cookie = dmaengine_submit(desc);
 		sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAREN);
 		dma_async_issue_pending(chan);
@@ -349,8 +348,7 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
 	}
 
 	if (desc) {
-		desc->callback = sh_mmcif_dma_complete;
-		desc->callback_param = host;
+		dmaengine_desc_set_callback(desc, sh_mmcif_dma_complete, NULL, host);
 		cookie = dmaengine_submit(desc);
 		sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAWEN);
 		dma_async_issue_pending(chan);
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 1eae2f4b6c1f9..d75ac6abd853c 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -158,8 +158,7 @@ static void uniphier_sd_external_dma_start(struct tmio_mmc_host *host,
 	if (!desc)
 		goto unmap_sg;
 
-	desc->callback_result = uniphier_sd_external_dma_callback;
-	desc->callback_param = host;
+	dmaengine_desc_set_callback(desc, NULL, uniphier_sd_external_dma_callback, host);
 
 	cookie = dmaengine_submit(desc);
 	if (cookie < 0)
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 3bccf800339ba..8b2bb44e2f86a 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -592,8 +592,7 @@ static int usdhi6_dma_setup(struct usdhi6_host *host, struct dma_chan *chan,
 	}
 
 	if (desc) {
-		desc->callback = usdhi6_dma_complete;
-		desc->callback_param = host;
+		dmaengine_desc_set_callback(desc, usdhi6_dma_complete, NULL, host);
 		cookie = dmaengine_submit(desc);
 	}
 
-- 
2.43.0

