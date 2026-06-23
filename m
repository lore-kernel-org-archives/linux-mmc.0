Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEE5464D;
	Tue, 23 Jun 2026 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200018; cv=fail; b=T2N7jsO72fyZtosyKqsUS6E71H8dvdfDYm6JS58fOYR/1UpRO654151TXQHKrvpwATuelYRYJSynLOMWOjQXzsraygeBppnswdN/jNSgFIXnQByvn4/s/+Sl+4h5N2UOtPlnfhbGE+XO4PGVmrKyONgHZ30LmOcwwwfvlvsdsiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200018; c=relaxed/simple;
	bh=byuxGeRgXMxAEWbHKywha/397D4QSOMp7sCkdLz6HD0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RCxmkHG0JYdBuqPL9A/yBbRJJHcnoo41UDcNJHtxs/90lJB1PjpIsftMEoZqbaBtalwZ22LJRxMExA23N9OTOu5V5W2StkkqfYhjan84QHnux6dG+Nj+U6ikKfm2AtpQ4CCEiZaNvzSbyO1xOFLJgFETJNPaEclGfaMzXL66ziA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bfROix0b; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bfROix0b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APprQJMQ4MD2CsgULfGWI+Bv3dATlLip6XkEuoFBS6EF1ReiP1Wdx8jAHPuy7ZTZkQoQOOQ397AlXoqJIhHi/sqRPeJveGpWiE0h31+LBLkB2MZMPnmTRq4ftfxUKXzhLkmfYnYMIjGQxvVkdSC9+NkrieQJHBp4To06m7TSYqh3puCeJU0im2STwTjsfkoM5jiKdAY+h9Jr9g5HGT+bprJ/IsfAFzWAPAST/Q2tG67BC+cYM2NVsRscG/FamVuY9NbICpFUrce7cBfAGqr1FxFf7cSZsxY+V0yOd5LVGI0tebP9iXtbwFWJ9M3JjrqzCUbaEg42f1Uc4Y8y29+2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR/VoFyHozuy5UDE0zuUguElHTrHRsxV+lSSlnMtD94=;
 b=htwP3KwSG1O6WnQdujkbXSmEwLKtpCgHTVpmNzosWPRShB3ogcaOl7zlsjoIiAf3bawVCp6cWheQ3325l5sz5Lp5XwPkTivMKUhnEaKmFFTrdRC1CgGO9wATlvcumCOoETBBlS9vO3rKzMVbtTYzOGfo8mQ8OgWLR0u3am8oVTOje+dL4K9d0/D+5Tk3ntTAEVu70uY69YvYujS0UQA68qFIW5Uju9dU61ehyCcrZYOQ05KMeBil16L8AcB+/G7/XMx1J8N/4Whe5ClrJem9toOFOLy9+H90igBMs8RI3OV6VOQw3fif5c1bF4pBNC+KKmjOjg4urBr6z+636KN9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR/VoFyHozuy5UDE0zuUguElHTrHRsxV+lSSlnMtD94=;
 b=bfROix0bIKSsYPyqo7N48ym5c41AK8S7XkM1mhuGuY8vwGvfrVVHYKzwtbviMAzhmZGrtb31ZHvD1vxl5BxhR99Isfn+XS6lWRGja/LWxP5lgOlLxamK0Db+sFJhYQ8iQrDzmfyypuRYNnyT5f9KWdJJ+dC22wowIMakIMGDo0CEkZEJbshRmt37oDVHP8jNYbDP/VANOYsu9cDl402jr1S4+voKmbcss+soXe9z/Z/LMVguordBRw5UEwBiSrZFoUDcfP0EOHnDkFr7HGK8qau0U7z/PKXKHMKyYh504VQhUfagmjP9hKTFt6YofOWg8SmXaFAAVYZpc1eqRFUd3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by GV1PR04MB10822.eurprd04.prod.outlook.com (2603:10a6:150:205::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 07:33:32 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:33:32 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
Date: Tue, 23 Jun 2026 15:35:11 +0800
Message-Id: <20260623073515.2658205-1-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::13) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|GV1PR04MB10822:EE_
X-MS-Office365-Filtering-Correlation-Id: a453bcdf-e031-4212-1101-08ded0f9ba20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|19092799006|18002099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	8RAV3OvXuFaCW1+qIpuxQSxRM0CetLu4vQlKkHBVMYnH6T4Y2HI9P/cohRBojxdc+dJhofFgAAnk+PXCdF4e8GTRK6ayuXxU7qSH8DPj2b2f4cIJHU5E0KNL7+w/NzHYaIsxTrLIjoKq0d3I/JlX4nqz+jPtf5i/jVmJocjkcIB0EYssPmA0LNtkmiuefErX0NI2BBZr9Wi9Z/RpOADXkE+QRUYEkJg4rppNLmhnddsq869mTkXJN4mPlzmeHSI3EnXJ/aKTEaspqBx7pql46OPoR7IsV00sPiSEtWHD9o2Sg/IFJheAmJ23w9fiC9Sa7qFphBD72lXE9N/7dcBY0KzAs/i0lM1Fl89s3iOmKqYyMnAz91iVEdAaqDbD8u3hd9lho4rnXCyHSJl7YYUmEPzKWAZ03eu8V2wiAUXPzO9NXhBI7+GCwiAy1Zv7u6YJFFYY3fAYrdgNUT1k3GtLz+fLQkpA5PTjvXj9HidEFQ7XinzLHRXOP8mZT1rQ0J0WHWsbOBdxCxuA7M0/Wn1QBZS//WO5D78RRzuT1bTNTVo/rgCzx7IciONgyu69MfB8sDTz8wpFILDZ5+nXVditD9BImQr8Ca/S4LiSwzI048oyfk8MxRWR9QtdEh1mhSl18k45neuJpeloutuB2BePjEKXgAVlljtpHOUVHQIK314=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(18002099003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?264DDgfbOW0bvWS7RtqCq1Az18ar8R1wiA8wcRTLQvHdGEeDtL4FTpSYhkeg?=
 =?us-ascii?Q?s85Y/C7qxdpk3Gv8w0nDe09TSBzk6EqEWtaPi67QUMGWogyLxVr+rO4a+1IG?=
 =?us-ascii?Q?tRXnyXJBBh9FoXIutSWF0iqmQ9D9OhH6UH29hnTQ/PhzRlHgOekw4DNdI5xD?=
 =?us-ascii?Q?c6F+DSgXbyUgXf0vlApVbkiPDAv/xfnhoIJgmP3/v/Id9JYevKujy9BE/JjF?=
 =?us-ascii?Q?HnF4hXtLJfVOPdLFO9t2gO/sMTaLVm223OQcjxyk8TTpfGjW7GCP0zqq7wa+?=
 =?us-ascii?Q?xAwAO9TFV3zp5uGXeODwAvTEtXaeqzLOwgw3v+7xEvWz1CicyChBn3ORBnhk?=
 =?us-ascii?Q?vYy8fQVkobu9xTqgHFye7O+RSWK3FiP4x9S00l+TeP9/S/iaAJ9zSf2DtjC5?=
 =?us-ascii?Q?2XXUPu6UsiD2S4de0tIBromrioPeQa/fBSRMY0CI3K4qi5i9P0832DRsctdf?=
 =?us-ascii?Q?r+2NOJRirAJLR26dM7/6Tjb7v4/AiD1nMt4RZGQkw2BRiIYn3GuD+kKO7NAe?=
 =?us-ascii?Q?WfctYtIK8gV81pBgdCWMPgkwixIAGgQaunOHEzPIyxIbIOBH8F3cOP5p18kI?=
 =?us-ascii?Q?+i4CM5Yf3R60TBt7sknIwlkmi7HQdVNmVsLf8cmgQnwql4DIacgpIlQC2ujz?=
 =?us-ascii?Q?nr1KxAYsz26BVL0uRSXD+p+zCM1rnEES91lf9VYpT1wAX0GNuQdp8h7D4zjg?=
 =?us-ascii?Q?tc67oiEMM9qkAEvtxxhRunT0JbhfuNhufLkOSQWWeqqamZp/9ekDj4QQxMTI?=
 =?us-ascii?Q?4IPUtUUwCCO5pkO3ZJeA638gFPcOfJcelkcs3lt5KYvFcZShCnyJR8KzX9Xb?=
 =?us-ascii?Q?6LIvee1DMOiO0RMomGauw2kzx4u7Pm4AqpTvFSX6sxXqQCncNLav5qwqtIWr?=
 =?us-ascii?Q?CT75E8ZvIkgIbCFLqGyRon//wfqXDKH4VohxI9eZqMnJ9JXHhExk+2QMXucj?=
 =?us-ascii?Q?gTThvDro9j1bRxh/uXA1EtAopEBkkBkz16WbF6MvOOPIDbVZwyielt0Cfm4n?=
 =?us-ascii?Q?rJAS0YLd24F9/cqy21hVdcBNjqHb4iyQQCqWcssrkgI+5hb9QSYY02S+NMGd?=
 =?us-ascii?Q?7u0Xvy31emzr+dalPBfkHzbTTPVRgIehNtVzPhh1pcutVy95ZPzLpCHSjGVq?=
 =?us-ascii?Q?Qh59NAgR4Tfp/yjl4jJhFKnVev7+pDQKGmipa7derN7t0xXJm7AJSVk4iYPw?=
 =?us-ascii?Q?InAEbeO/9Xz00DjoCSN991i9Y294bnSQfu92e89kHxrgTM2xcI//pjBmpExn?=
 =?us-ascii?Q?Ec+bh5sVVj4Andj+2xThif8A3n9c1DIhqfI1oLNMZgLZhwTVX+iddXkR26R4?=
 =?us-ascii?Q?kjd+pjM6lLtFwyhKyfAJmWUzXRiFGS4HijUewLK9LUW1DcrhOoC/HSHeEjJZ?=
 =?us-ascii?Q?c7giAxyboNGs3BTg65lUS/wKbDrT+WzxuP1tPyDzPsj4YCMV5F34Nt1QKo5q?=
 =?us-ascii?Q?5lkchk04vZGRuOz4PsWCIxZ5wYq8nrjn64HXDz21iJ4LJRQ9/tD9cXX6U1Yc?=
 =?us-ascii?Q?/3eLdabdUHYjqcjGDlo6q4FfheiSiPhcBE9TBAiudjyiy8j/kr3vfRHSXl0g?=
 =?us-ascii?Q?mKBRnf0TgAl0tLFMDJi7wnrwXzoJn0giQXCKvB3f1HBfefXw1PasAt7Dolh6?=
 =?us-ascii?Q?MTZe/WowmKGsnTgJUsa4/8Mxm2xRP9S/o8aYihRUAxVAuCfEliI3V5sEPOhf?=
 =?us-ascii?Q?TnA41dTUK2tUAEV8QHBY8M8JKK3UiEuSh9GPAEeFb3rps/M6mMgudqmovmk4?=
 =?us-ascii?Q?SvRHI28qdb3nhNJ7Vq7+XlvykwqmFAdgmmNspOt/3xGCuLChVSFh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a453bcdf-e031-4212-1101-08ded0f9ba20
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:33:32.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPSAXqBUl6iLvLOgqPvIagPFneIXyBW5h+unPQKqioD+LDJznSAMveVM4VwMmIcQlFl46Q2aYgVCb6FNBcG8KiYAIDeMuvQAQbsEHWPzQGTNbOG3A3l4yh+K+3RQrEuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10822

From: Luke Wang <ziniu.wang_1@nxp.com>

This series fixes several issues with SDIO devices that keep power
during system suspend on i.MX platforms.

Patch 1 removes unnecessary mmc_card_wake_sdio_irq() check from tuning
save/restore paths.

Patch 2 restores DLL override configuration for DDR modes on resume,
which is lost when sdhci_esdhc_imx_hwinit() clears ESDHC_DLL_CTRL.

Patch 3 restores pinctrl before pm_runtime_force_resume() to ensure
proper pin configuration before DDR_EN is set, avoiding CRC errors.

Patch 4 unconditionally disables usdhc interrupt during suspend to
prevent "irq xxx: nobody cared" warnings during resume.

Luke Wang (4):
  mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check
    for tuning save/restore
  mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
  mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on
    resume
  mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled
    interrupt

 drivers/mmc/host/sdhci-esdhc-imx.c | 57 ++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 18 deletions(-)

-- 
2.34.1

