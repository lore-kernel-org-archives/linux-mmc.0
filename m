Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CB4436E;
	Mon, 14 Oct 2024 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885630; cv=fail; b=d3p0Nns5pE5nTv2i4HpVjedQg3ChJ8J/IG/3XJAHfOvux46veczWdtdK69ApF5LGfE0KMyAizURaLK6A4ad0N8Qw5+nahdVaCfiUqW1omcUpVK5aBOXhZPjWcJ+WJb3/4k897JEKDUYuA/M7K6hlcTCUwV3oG4t9YRR6H9JRhzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885630; c=relaxed/simple;
	bh=VctrwewjrnQLlCwkA1mYmO7LlFe7PvqdF2Fj4NGRECo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gCGtrL7hxjPbVMIhnkK6LWSChNkbYfd+NB8Im1sf17cB3w/s2tqvjPsVGF7/mIsLDjELaFOGC1KsCNatD8ig4FqSo0DP3Rhk85DfLNd6Y2qhE3VXQveZzU4Gg+BhGYUk4E6PeOroOE/rUwG+LO1bd0GNGE4ECl4KIsUzUK592M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eLUHQVX2; arc=fail smtp.client-ip=40.107.103.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eLUHQVX2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRoeHlSQKCWSAYSYyiiHakMIjZYEcmaRIlslZ/eQW9eJ4Bo4AlL8tv7aj7g4dssiZ7ez91tV09ApHO2mWwTZzleKiPZrI28RGgBGCGPlDYUPDENaYl0NhWCTqmmc9dJyftAzjmydu12S5bM80jm0XKJ7358vW65ccPD93c8KbTWVKoEC+om0DbUhVbtDOB2iwA6O51UUQ7fDEz/sVkkuUL1HiV9Og6pAAdYTeC/3MV6g+FHacUcZGjeJOilxl4rk7rg2ifYrrD/HtU2FkIgGCulLflBo8jKNdjyBtNuFsh+RttEn6OrdRFaJnfsSYwKh+vmoB0EAKKtu+MRFTWCaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhSyX/86D69iHtm66ptwj02t9PwbmySl+omGWDopJbA=;
 b=N2X6Qys2+DKqq8S8B1sQMTxfpThVMuLOVypkHJda47pWsEfCsCTBh1Er8Wt0r72WvGHKggdL7yOUF/Du+AaFFewO4X/DaMQQp37B/sxFK8k+8IJ7Xl1Xzn+xi6j3PquVGy5XWlNBh2jkxIGQk4HKjvNgUid3lWSuZuvp3Q7/YwGOzHwyJYH3UVyv2z+RY8YZy1rPOSxe6Im6ZaL3sCz7FE438fP5IculJjueWSTrSauAfMOHmVr8ZbkDoG+eso4AGHoHlTL2ioMdSOFR354V+gSdolYeFQtsZeQZXwmMm78j4G+ZYHzxGVyxwH6/quykEt45NGPlrCO7QUrdu3umeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhSyX/86D69iHtm66ptwj02t9PwbmySl+omGWDopJbA=;
 b=eLUHQVX2nkSgF+bmVxNLm7/k73B9FOxm8bNQvmCKYHIlicw+37qZeHrMc7oayIYd5hr0sQPFLXQAWbjm/29eh0rPyJf2k6QM9dEijcqg0HrPnjJ3bF8D71/a5+UVScjgEMU3xxqx7w6tlYC1rd/fYBmN8j6/s4GATEMejOrvbFXdf8bPWOqONx1Or76SvluD4Kgjt3U9H5RaWHygsPDY87tAQVwYhedpqSaQ5KLUlXPoSGtmE7Zp0he1s2DKL9p1IC/zJJ5xA/LtnjnYM0+h6Ohc/chLkZDEqc+2yY5Z4trxNk7Dt2tdq3I39gyT/zKekToB7p66/8Pgze8sr2SikA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 06:00:25 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:00:24 +0000
From: haibo.chen@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev,
	haibo.chen@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] refactor the system PM logic for sdhci-esdhc-imx
Date: Mon, 14 Oct 2024 14:01:26 +0800
Message-Id: <20241014060130.1162629-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e405b4-8836-482b-4875-08dcec157ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aqKWApC5eMNFDn/bu9E9Ud80DsEQY8Cjcmtv3Q+7g2624dYCMHD/L5py4rpe?=
 =?us-ascii?Q?GvWXPtIGHw2bDwTc7MV3+7aHHYb/7ym6FP0mmTBuZcj86n3z9FHDthXVJZ+r?=
 =?us-ascii?Q?8lJFwBznyyssSYNrU12WQ2UUU6h9gFVxDuwXFYPb1fvFGDFvvngD81eWtGr4?=
 =?us-ascii?Q?Xx10nCO4bF9eVhSsV2n0iJJGKb9Jj0rLF3h6q3ltk/zSOOPyzxDyE/OlNtFl?=
 =?us-ascii?Q?iJJNTqoJz2864y4QyVpGznRPtKWWS/i5+PsKBu09KHX78rIEGILTYePVHRr7?=
 =?us-ascii?Q?Zcx5btp0OtzNzRQlJDVnW6jW/vbsyyGPmpQ63PjucsP+POn9wy70hYfYMWpB?=
 =?us-ascii?Q?yI9/DQvNIpxDlW3hSMSFSqK4On69o8auGQmcSBLgLGF3mATg0ukl7aJ0pzZQ?=
 =?us-ascii?Q?T8nduvxtnQb/YKlE76aHb9sgTXdnFiVOSdqAMvJAnqPCC+r7YXHuCUmq2gQO?=
 =?us-ascii?Q?h5NoimxpzwZaiNSNZsQuyeMQ6LqgFXrsj9kwgx1Tlr80zfCkqj0add1MPVlf?=
 =?us-ascii?Q?O3xRuhLr7JQgH5/IiRI1oUipVVyRTcVSJNv2DNx3D+2nLRYzQDJyw49ta5jM?=
 =?us-ascii?Q?b5hHRe8Sb1y3WutApWYaFtCJkBPiRmvH1LhffzZ80K0rHz4Q6vVmulmOPPnw?=
 =?us-ascii?Q?B4tUpd6enOMfN5HumsBmN9jyWCjzFeODIG93niyQHUokpGK1iWwIhg8fS8Xr?=
 =?us-ascii?Q?xzRENo6E1NkvL0xF6H/4/jeguse7+/BBkDH3zhhuQAy/4lGvOyc1t2a4G89v?=
 =?us-ascii?Q?FG7DTob1586cAJq/ImB6Tis2YmXOkLK4A+UYhZYbzkzvCBBqt6idwqohQnwI?=
 =?us-ascii?Q?fap1g56wkLAAHdCzv36AzTvwf01DFM2QcvzjbAOsmp4zf1KwQFXAW96//P4e?=
 =?us-ascii?Q?1bsX7AkRXxLqGrizblZVJSXA3whLRpRyei8s+GQFjF0Lu33mQkl5NUoXAzpN?=
 =?us-ascii?Q?zRTZvB2OK2nKLNYf4vwSUbqeWg7g/OVs2VNirUpFFzfMXyKTb2FAJ0X9M4N2?=
 =?us-ascii?Q?nFJMgyMepOyPYAyShgc8pjf6nSMJRHKQ6vHtOhiy6H2ftd2DK1rcE/u5ntiR?=
 =?us-ascii?Q?pY1K2gpp6ADcmO3SitP/sMaZyn6EulsJgMJqeZu9jk1nPobsI1zdHo4dQFFD?=
 =?us-ascii?Q?D6VnMpNcIMw0UFUA6D9x/yjm4iiFTNIhNuD2UZSKb5tb0O5rnbak1dbhnilN?=
 =?us-ascii?Q?iSyWDwsKzIXsN+PKW6DJC+259HjcX1EREJeKJeSpOAslTA028WCBihW9oe+k?=
 =?us-ascii?Q?iANkveBBrkWPxq7q7phcwj/HgjBiS4Y7li1KYa8M8z26sQaQkMAkn/YeILdl?=
 =?us-ascii?Q?CcLbae19IDQhWq/jKmZCUiHdJyT5iq5bavMnT0LvEYKmkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?++5RbpAz1AtWnSOl18zy7dIF6x5HTPhMK6CrQK7G2SaR2e7x5JvWT0wXBDUf?=
 =?us-ascii?Q?na1DMGMuDUodcMzQW46KD02Krmpd0873f7ModfA9kAbimFyVZRb9fggUDxgh?=
 =?us-ascii?Q?quD+2kI50ZviL54vHO6cdyPQXF0tavb60OpzaaG9j9mh8+dZKdI8gwpklSCm?=
 =?us-ascii?Q?qRaqzQSDhyZdm66BLe09Z+oSAwLfjf6lR8D9WDUedQs5At8kY1PgYjE++dvU?=
 =?us-ascii?Q?q74B+dLKHQUGy87FWkkcGiuR8e4YjXf8nzhHEOl5/4ibj5j5pjF/jSRuQG/U?=
 =?us-ascii?Q?6J+0y++o+NaxXSamA269eXW5uh5P2zEr9vU5aNfRdCzGFPsGs1iv9WWciHx9?=
 =?us-ascii?Q?1mr5wOSQKp8fpieALqs3eq/C3Fd+zRaoiNG7pWJvE43QY1QPTZH+jAv/6ofT?=
 =?us-ascii?Q?MUMM6J4BuMWAofl7qNsn4INuoqnCUGe8GG3fC6ICTSQx01oo1AeWy2CwazIh?=
 =?us-ascii?Q?0F2viqBYmoBhXkRgHtaqiiXFgGdD8fJErJNS38vOgvadylHizpdnJF2GpulV?=
 =?us-ascii?Q?8FKYZieGq5yzX74tfPvmVqZ3MEWVvYp+vdrnaXBv3xbTKFZVdLJEmW994ZYl?=
 =?us-ascii?Q?ZFd58Nyc1TDA5BMqJYW/9FIijXQn0Pyb6FIgvGZNtpEA43d1ACCYEoioHi0m?=
 =?us-ascii?Q?ObrVz/3tBcij7wURsoKQRS8vtseuCyF7eSqE84fC4n5xnJzw/3nOVPkGHUXj?=
 =?us-ascii?Q?y3/TS66b7HrJzqbNofHbXEOHruOj0BAO7NHMWM6bnogI94CUcxJf4n+hQwdV?=
 =?us-ascii?Q?QqU7SgjYoclJZOV+S24fImzU3ljXLwFFzsqxBTTCOs09t1hUVwtsb7FPF1ji?=
 =?us-ascii?Q?c0ae8C31ZygzzsFa+SqGydVW0tn1HTshku2XLN3/xKVuEmbujYutkMeTg2qC?=
 =?us-ascii?Q?lfqMFs9si2VcvhR50+uv+vCqTEhp4C9UIjPpvI7Sk/tZtR3lwNtESGhJgstX?=
 =?us-ascii?Q?HJaQTYoXz2NeN1BmuF+Cfj+YUQQXNxzbOcvlCOqeB/tFczz5Vf7vkml501P3?=
 =?us-ascii?Q?H940jrdhgDauF2p4DF3ZBlwd4+0lXtwJGhFABJXvDR2jWNXsVTvj3v1YT8Fe?=
 =?us-ascii?Q?VHOnRLXENnB43tY9bmKDE/wUD2s9FtMx9iE8M4nPfQgEr4y91i5iR2P3+i5x?=
 =?us-ascii?Q?oHVZx0UoKVMhjKUEw4suoLr4h02WWBOarFe1kMNjDlbZHbbR87sr4ugEnphM?=
 =?us-ascii?Q?0aB9Uxf3KCtD743RBRcGt2bxit0CLU140zQpqspHUVFRbfz4IAKRK/48cKG+?=
 =?us-ascii?Q?Pyrlfn9BO98k5rawbxWxEoR3zjK7Dda+aImg2T57+OPBWRdMxf3OBb1OoFm8?=
 =?us-ascii?Q?nR1OFxvQOMadGRW7bX9PCYM8Raeprj6YmfF8xUPNKAxfhxQJpIh1Wxzm6bqa?=
 =?us-ascii?Q?HdfWrgPh2fzulnN+YOqpyOsE0aEnEADKb6GjaFj5zRi9shs9/mBkECsny4hj?=
 =?us-ascii?Q?s5LSFSIzAObFURbCSCp/Il0HlUwFF+QO+bGms42i1qSuRQ0NfeYQVv1RoXbm?=
 =?us-ascii?Q?/tNje3Yg9FshuekjP5ifHiVdDWqm9SM5RXPUE/7mmXLupacO3BrRqWRHe1Qr?=
 =?us-ascii?Q?DkcF9gbRr7je0sxpJhq8jcm0PQS0Z3Ef6b8VvYsQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e405b4-8836-482b-4875-08dcec157ebb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 06:00:24.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhuKf6EFWRKzgOFlsd17BsnfTKDjnwedePMWTaek4NCS5rP9oZhKIp6q8bjmAw35VydtRV5oD3BZpjTUJhfYuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459

From: Haibo Chen <haibo.chen@nxp.com>

Currently, if SD slot do not insert any SD card, system suspend/resume
will hung, because in system suspend, there is register access, but the
usdhc per clock is gate off since it is in runtime suspend state.

This patch set refactor the system PM logic, try to merge PM callback
sdhci_esdhc_suspend/sdhci_esdhc_resume into runtiem PM callback
sdhci_esdhc_runtime_suspend/sdhci_esdhc_runtime_resume, and use
pm_runtime_force_suspend/resume instead. To support SDIO wakeup,
add this pm_runtime_force_suspend/resume in no irq stage.

Haibo Chen (4):
  mmc: sdhci: export APIs for sdhci irq wakeup
  mmc: host: sdhci-esdhc-imx: refactor the system PM logic
  mmc: host: sdhci-esdhc-imx: save tuning value for the SDIO card as
    wakeup source
  mmc: sdhci-esdhc-imx: do not change to sleep pinctrl state in suspend
    if enable wakeup

 drivers/mmc/host/sdhci-esdhc-imx.c | 145 ++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.c           |   6 +-
 drivers/mmc/host/sdhci.h           |   2 +
 3 files changed, 127 insertions(+), 26 deletions(-)

-- 
2.34.1

