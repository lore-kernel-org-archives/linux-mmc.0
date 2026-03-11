Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36283CCFC9;
	Wed, 11 Mar 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222517; cv=fail; b=Kaq5+t5J/4AW/Pv5pYk6/LI5FWnTjQuRLN1TUrvi6uHLWzNoqCBhpnxoqiunFOiB1YraORAKsRPZ2lnmEjessnmgB9XqLhJ0Wc0W+lqy+91kWOnjrCxvy0gSsDt+8HVSnsaBDAH05rq4WOB8Elm1TmNZnrh6jIfIHV3W0sL2Uaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222517; c=relaxed/simple;
	bh=p5OgdMw/P+xMApsUmH1jdiEDQs7givW//ccQhb/oyHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2yPaEJ3iX2PvDykjUawPWEINNi5QB9oVOsI+6tOGcJ8+jO0ZpdsFof1csDyof3osnfxw6nfaDcoIONq5+0Es6ba2TbWHBCpAMujxOFAxAsvnm1BDMFZo0dGgtcqaQklc9hlNCWihESIrmVRawVPQ87aPLa+ZwXAJguAWzxeZ+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c9cnwqa/; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c9cnwqa/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddGqSHsgKuPPsmFVpunRoGlk1b1GnmG5X43knIouYckDYyhdxs3SrXILfH4xYmp2qogzP82VlMJ8ISRzC20rCdL10XV0zhBbzSMXpWamepH6HQoyEFM1cpyz3ugF9dHYb0on9EnBZUu29k6sllJjWcXG6rF048fi2x4yzesiqBL5t+V6KmPelPvZCrOrdECpLLxhmLdHBjh8fvQhAxPpXANxDSWwW0R6vcALDi8olM3ZM2gQCVeg0fb0fFM9ylataLBrlpf4FG3VWb9VX7HEiFUCqhvzW2yDAtymscNd7RcHHrOyBP86v42dTwIvFSBAE+91Z6I2rF79ajS8Elp2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr9WtvImsbeEy5U/tt6guxwhNQw+t/YnnDdcabm1Sbg=;
 b=jhHwZdDQQbnDhVO/B0vUf/C63jRF5GQpQa5+czA7EHuqniPgiuOkz2Zwgjh6T6+GDjJAh1dme0TKR0Yic2DlpgUYg0Jihc1BpW07Lq8j4eQ2hpm6ViX5Ut0OUgo6svKwYOWc1+RK02pPyGfjhwqdDnEf0NUAf2vuIACI0n62zokLcBatRJaX64N8VBaTO+TNCtNU45c1+gITSoc+BkW4UCA9KXokHO6XNZyiyoeuVuRjNrHmsoC1E90xJZerb8tuGguJRmAgIq9a6DhwvYdVL1VqYsvDzvMo7Mjq7+TXUgMcIevq7MSysndjbjRh2le7qBw2dReQrtzrHPfSXoPMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr9WtvImsbeEy5U/tt6guxwhNQw+t/YnnDdcabm1Sbg=;
 b=c9cnwqa/T759EsZGenD36rjMn+jIg8tPN10ATMs4LGTLsHSkGuaugzJhnPf2a+S9HjZLuDW9H3eTEFOqv4GBg2v10zMm/UM86rm0IayYN8y2cmYjeNwQekwVz8R3wO5jvzg9w8O7P6sNf/NYX84oCcmd+/SprYtkHoi/bIJUBANXaVPXzyYROzVsY3WhaokugaBQ8HtXkWQsNzbdYG2qR11lAn9pJxuyy+mrR5+cix0kBc4PtV59bt7xGoF1NJ3pDmdeJJymLmmar7k3LZpVPP+qkdaR7kLGcW7sFFd1w/VHo4npxV5eX+lp/UXHuPyu+FYHHh+Ulj0ujRz45OVThg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by GV1PR04MB10607.eurprd04.prod.outlook.com (2603:10a6:150:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:48:33 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9678.023; Wed, 11 Mar 2026
 09:48:33 +0000
From: ziniu.wang_1@nxp.com
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
Subject: [PATCH v3 4/4] mmc: sdhci-pltfm: remove duplicate DTS property parsing
Date: Wed, 11 Mar 2026 17:50:09 +0800
Message-Id: <20260311095009.1254556-5-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|GV1PR04MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: 431ca9ec-36bc-4fa6-dfe7-08de7f535be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i/rkmjf69NsqMG4cPU4CTnW5n5/Vs/yFPgm41qz4JiR9roeEAxO5dnJD66HF8Ff+8rb2onz8wD5KaHCV4yyEvx5tCoT7IQ87iSJHhRoV8+3CV+ewlTAlCA/5J1+af9KDZ/c9R6tha8SzYCwWMDGIIcwYuIDVxYG1bLwAiH02REqGWMTys3Z18ANc9nhYQpbGssdZrhCLyt3+lCFCniLl4KjEa7XWvAGw8IFns1W7iEHOKeWUTSskkFdlfF28k3PsCFeN+HGx9Qf4uHPY3hKyG3ijZJRLV2vOs6khGbqOqMCyuV95ZCDDRNJOer5GkxLEtfISBOtzS74EZ96UXvOTX+GaPv+nzzTs12+qtff9G1MgFA8GV938QMb1IZu9HQIzw+TZPPSSYG/WHJn77NACyJxxA/q0tYRIm65a4hJKQuNbAtt81Kw4qZhq0YMPo4mq+nTfVD8v/e+Z9gVkzq54uWNfSafqNYP320thjDHtWO/naZEq+IH1wmgK8XXo5KFTp+A4lh3D2Dt8uoFrsBlwnTbVBZ9GTXcg0rIdlxDrMZRDxIK9GLNxNlJ7T+E0xGcO/PQAYEP5++KyE+fg9bDA8SWXahQkOlnZYJUi9yagnC5XnofJNXkKC1RtcqZsTTN9jgK1tqhVBtM0+J/HjdqkSwrjOPhFlYZc89wylrpDR1LbF/b6MVtg8r3cwVpODu74dKdHoFYjauYKnj8oAGbGFNPrnB2KWsgRSAv2zGCvbV8X/hCqnxrM2gLgnE0Tw0XXFleGhbCHYVXQ3mGgcYdWC6L7g1obIqeJmvxDM2ieEwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R+qBkuFfTfxOZw9acAiIVDHcSq63br3iyYBZRzif3YVCmtM8Xx4hWM5PDzKX?=
 =?us-ascii?Q?qPtSEpctmDeL2dO7h/NYtMmu01O6TBid/WEjCbbTff6VqPhy02Sq5b2kNq5u?=
 =?us-ascii?Q?+djfw3gyQ1iPRk03/3kcQbN4cm2RKqr0ZpCTD94H5bqjAXY8WpAo0C/Sc66o?=
 =?us-ascii?Q?nmV0VOLic++NvttQi+7ZIgORtuGAUKjgbM21FdPbII9dZPNHdorQbWgzxoGv?=
 =?us-ascii?Q?/TZohirNycPVTN0OgP7cTpzI+KquC6M3O9ypORAv+mMH8yGxwGU5DQnMQCFY?=
 =?us-ascii?Q?my7XWv6QXcSCQinnK5zLyTkkserw/LMlykzaiQWNHCZ7nv/bCnO5Ule2FVEc?=
 =?us-ascii?Q?k+6Bu8YMr8USaihyFGeSuZZ36U0wBTcBJ6uCPcpEWBUCdbbNAeENWFiB8uhj?=
 =?us-ascii?Q?trtVny0/B1eH7gI1g317nB6tthJ0dyW+fgDydVnHI8fcT6xDX2sS3vWTRiwv?=
 =?us-ascii?Q?UolDbM4STdWChZmdssJxAyLKHR76VOV/yrSqPcFd5/KWc5K1w2zjhK7+h7a5?=
 =?us-ascii?Q?RK17+dX+9IjQqFDwpkXa/LFMBFxUt784Vfq93h6kjby88jnXe72N3A+ljBV3?=
 =?us-ascii?Q?ImKTfIIt/HlPgoTxlwIPzCr+e2fecXOhl9O8Ja5MUzMvJRgy3LZZXx6117kO?=
 =?us-ascii?Q?jy2p6Dg3ojPZAhUSbicUyBp67bBO3ON8ImAunDx72OMrCPPNK62uK6Gq2M8A?=
 =?us-ascii?Q?hYmhFRCvAAK7631KIz1nUSVvk4lfki3669EYtBQJhJAq2pqRC3Fjtdfv/wRg?=
 =?us-ascii?Q?lVKxwlGZnQ1UX1x5+Mtku3cJgP/5LEp4dtKefc8nD2tla5Aokk+kO9/kEg0S?=
 =?us-ascii?Q?uD8SKMuvvjcD4RW2Z/P1jfC4urO2dQRQp8Wb8PMMeean/F7EMrSsRGu3DKCE?=
 =?us-ascii?Q?q7eiEdr7UGueumhMM+JMfjhsVmn7MOqbrPKKxW2b3W83p27zKksnFWKGWDeT?=
 =?us-ascii?Q?mBR0h18UUuojMPOw64bPWw9THffcj5F8gFpHnl2X6DdWPqvjTbbXm/Ximtqh?=
 =?us-ascii?Q?mbh7sPfDFTm23DBufW3jkuix4kA+G67mjmjNwtmQ0fW6/CuelzoiHZ+zqs3f?=
 =?us-ascii?Q?xXA8gwfFDa3eJY2L91UsyLHww98TCYrEe8nBdyl04qBhGSzW2WGL7C8MboZj?=
 =?us-ascii?Q?SizqYVjK3f/3gRskKKYmhVEyFg5doghOscAzchX7otAJZHiLaXMg8219Lhfr?=
 =?us-ascii?Q?1haJgpyPstLzo4usy2xZAKQD4lrnuowMavmQpI0Ch3dBMqaWnXiyflb0DdQz?=
 =?us-ascii?Q?bqc6ebAKZBz+OT2CQEGwvIRB2pdAtUzakUEK+Plnd3jt5rUHdbdzJ84t/2RG?=
 =?us-ascii?Q?NnUwAwQ7eXNIfbxyiJMabZDoq5QHx3ugIee4lC/LQFhAccAlkYlRxjnD0MAX?=
 =?us-ascii?Q?yH/F0pSgr0wmsbT5nNUgLsqvBeGpVY41Lrjk4rpa2T+rrKJkImLWOz27WiOp?=
 =?us-ascii?Q?f4tsprrHVdX2b61PbbcmAIQMaUJQnnG7c8stUve70tk004Jx4SUGDojxGzdE?=
 =?us-ascii?Q?aNLXhrTyhmlNJdu99ylhqr9ra74tEG3QcEvR5bJwu3RUzJyTaGLYKf5WbC4S?=
 =?us-ascii?Q?yuhCdQ+bBkRpkiCMxXnc96MrU/swDztrUArj2RC3J+jHch8k9xwCkt7e4eu2?=
 =?us-ascii?Q?GMKLZ1X+47VsB0RrcNAigPxnBRt2tzA3bXg76F0WJaO1aJwCtIgcKea4H0MR?=
 =?us-ascii?Q?nGBEit06X5q/ZaCYBs6TMVaNCOV7SLZRHmXi8mRgojFzrLGVcd5bMHNVBX8l?=
 =?us-ascii?Q?dRK+yyv2/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431ca9ec-36bc-4fa6-dfe7-08de7f535be5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:48:33.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP1iE4l3oBvQa3XEuLBwXSzO9Fmyr/r1nSiCFX//GiLYvN9jjOUypleuafTTO3Sz48x6JiWZrxYRXUYT7DOPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10607

From: Luke Wang <ziniu.wang_1@nxp.com>

The "keep-power-in-suspend", "wakeup-source" and "enable-sdio-wakeup"
properties are already parsed in mmc_of_parse(). All sdhci drivers that
call sdhci_get_property() also call mmc_of_parse(). The only exception
is sdhci-of-hlwd, which does not call mmc_of_parse(), but its devicetree
does not use these properties anyway.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index d4fb60c1ef69..933fafe0a0ef 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -95,13 +95,6 @@ void sdhci_get_property(struct platform_device *pdev)
 	sdhci_get_compatibility(pdev);
 
 	device_property_read_u32(dev, "clock-frequency", &pltfm_host->clock);
-
-	if (device_property_present(dev, "keep-power-in-suspend"))
-		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
-
-	if (device_property_read_bool(dev, "wakeup-source") ||
-	    device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
-		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
 EXPORT_SYMBOL_GPL(sdhci_get_property);
 
-- 
2.34.1

