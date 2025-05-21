Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF781E0B86;
	Wed, 21 May 2025 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796027; cv=fail; b=d7Pg0IjLOtmh3uhmRBxEIz6BdGgass0/tq7Op9+xo2duoHlUSB+Fg6oG40xKxMObYgYgAUYeVmherz7NpTJebFPsOeQoukJi7bG6wUyztHmSz9zPL+2q/WZ7hFiNIKmvBsqYos9AFqa25GWgLfFrT7EUuluaIkw6ZGamHOJAtb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796027; c=relaxed/simple;
	bh=ctYtzOSli99WZqtx16zpRfGilrt/mDrr5CZidY5debU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a2EQdVCi88ORrtM9wuQ7lwXE/bUpNizyuPBYJl7B24+P/k335zLfyhAZ+4JHhzZKg/goFRlM5qfPXpQ+j48qMDzbgWtNGVg+M70nyyWnnlpOHWWdRbzr7stotBtFhf5sPUX1Uk1iC3/qSqWUIkL3fNSI/v3ShkdvRLIc93GgU2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PiHt6Hds; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PiHt6Hds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaNlsN2bWiG0bMK0iSetan+wDJ9X3N+ywHkVrTD++aNZk5WCER+9+X+yhcQIvVm2UI7JKYtFw2l79ketpuE4ldoor4DqH1V8JgCVzSvsbK4r0OSqPrqd7V4vgtGf369YFjj08rzZ5wjHKtYS6Wc5MujB7yM4NGK2W8zr1otBaA5C542pvlM4pofNLvYdd8AuJa9b3cJ8NizpoLoI1xOS/sSVW9yqbWEtmttMDtbIGkmZiVSwsSe6fe9lM8TobEnoqjcwmySh12XBjJ9Zoc6pTMbsdYjJsmPVRt7krISRTwq45G30VYwTQvV5fyjJW7EnxNB59rgoVyBdzH00I1KX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF/FDvnIAOysioml/L5esQX85zDXRL3xIoUSe+AzOsg=;
 b=qoD+lPUZeCr7/2QRqFpNVstAZ8xl5Q6XcAOFJeY0HhuusAqDBUpt+GSTFj4dDPDFlZr+2V2L3YaeT7crsF7rjwoCn4fYcg8cLHVebAeknwZLCxByWUyss5cbfeqjsib7oODo5mXVvkPLpcYQdZSLkccUUe6aA57ldA9LJpmlUwRAgr19JiM75g6N4LIRystv4ZzXaLusexqdY9egZuW/RSv99eT4LGyW3ok9fcrXHIyd1LcHHruW8wxm5RH0AmPSg959GB1rEsdy+2WKVFVyKM2SHO9Ffmwi2/hNV/y94Y0wigeFlu21ScG1OT191ZG0Y/f/xa+vhdmfuUltBz2l+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF/FDvnIAOysioml/L5esQX85zDXRL3xIoUSe+AzOsg=;
 b=PiHt6Hds83kUSLACfulXholwSDL89XpdVhZhCROndqiNi3n9wjUYfG36bEPIY9ArqgMT9GjYwD9CqNNeTOn7Q1ySSKOHbD8nMNzOGZofiwZlPAwxhn1gxwqD3f7w7JJOqSyBWj0/pHLGOcoONPnIsfzixBuQMX48SwEXydyab85SyGnrs8eF7RRKnoQYqZSeL2pwcHhwcH95ljkYwyRi1VgKt8l/xrsSK3PF2GD2zgM8zqex05XFZ5e7m1krn3uj5EvX4WVThdmaUP0JnqPVPSdOBOhl+ennmpC1prT9Ag6f/4G/fwzJbWK2ByI87uJAWJjJfzCTcLgdLL5pkkbYRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19)
 by VI2PR04MB10883.eurprd04.prod.outlook.com (2603:10a6:800:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 02:53:42 +0000
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce]) by PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce%2]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 02:53:42 +0000
From: ziniu.wang_1@nxp.com
To: haibo.chen@nxp.com,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: refactor clock loopback selection logic
Date: Wed, 21 May 2025 10:55:01 +0800
Message-Id: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PAXPR04MB8574.eurprd04.prod.outlook.com
 (2603:10a6:102:215::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8574:EE_|VI2PR04MB10883:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa3d3e1-e17a-4d06-3ca9-08dd9812b1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFZN86fXZ69uaom6dCxsMt4Q//1DxAZJEm9KO8lK33cuCgu/gfOxQ/BruYg0?=
 =?us-ascii?Q?M49Btiqxnpb8UFXmlNS9qeks3gBmQH8w1BBx/QZEFBNwa86QM1GHL2qp4+QO?=
 =?us-ascii?Q?27uJGkI+2pnnFlqjLNBukabIf/n0w1nxSexan5wUcuLX35SRIGyXZBfFfdoy?=
 =?us-ascii?Q?iWTOx1RspDe1ENVvkSH9shLUPxcIRK6+OOZ/4X/W7Qd0Ur7LcvczQLSD+Y2u?=
 =?us-ascii?Q?+vIykGBNwXEXBoEH9FN98kk3nkoq9JI/JasGLNUYVCLKbeApJ2Xrt6uLpimu?=
 =?us-ascii?Q?h8JE4VkczSj427H+ueM8Xit3Jo6ScLgsllJY5H8N7ogY9eush2VwxFSdT8D8?=
 =?us-ascii?Q?X4+KRRmn1+VCUG44CW1nuEPd/8/ieRr2IonXvt4try6WieJA/3eieUxzgotZ?=
 =?us-ascii?Q?s8m3HzAFO8rKdPR/exG4+EydZucejesTQr7d9BeIH3B+o75SlFGYW8GstSe4?=
 =?us-ascii?Q?Odk8JYC1hlc5fFUHUd/GF+oc27KpaP+1SeV7MGyuCDS/+NLU3yo1UGGeyakS?=
 =?us-ascii?Q?VHMPayKo+k/mdUDFgQZDGPJ4HIGMBGu68q2CUjBrc2OIvmeh65AD/PiyTYlG?=
 =?us-ascii?Q?NtY2+TZNufI+igvljTQCHnvPBSWWEqlU5Nh18nS53mGr5C4vYPEWB7enct6H?=
 =?us-ascii?Q?5VplSYXJWpeq8GxGlDLD9rblhtmn3pmaFvNeMfkr7Sp1lZ8V06GmNFEBwCjq?=
 =?us-ascii?Q?8aRFXtapG0SsAOk5ljf5mWDD5fVh2B1YPrAPfHwRGO/AQAnSptyJyOB/91il?=
 =?us-ascii?Q?Lq+xdkBOIqH+21/t4ohhxgKR6DHuY28Enz+v7SfnzjCfcIzjj5nvcbGoLo+/?=
 =?us-ascii?Q?UDDDd/nlSauVUKAJxgLssGF2I0KHGF3CVP3YReoaEOxt5F4tuqUvY9L5+sSI?=
 =?us-ascii?Q?h/uJXz75nIXrBvC10eNGKLg9IYjLc3mMdSJYDioB3qZJ6NVkcEWVKayMSbmL?=
 =?us-ascii?Q?Y2w2BqzwL+M+SuduhqnGHZgHaH1q6iS3KBl9BzwgevvrGwceUSgHc9Ux+jaa?=
 =?us-ascii?Q?DfQvWr0moT5Z/VAYiDK53hRJ5uu/6k4C0Rp5ibGaIj7d3ejPuyZidmT+DsFO?=
 =?us-ascii?Q?zYCql6/IlEblS+U7gBs5xBYZeF/8nzM2GexU1crmrwns45E3vfEYrtvrNsn2?=
 =?us-ascii?Q?BVdvkw+/MVVHDg0Wk42OWcwZ5QiqpLmTeaKaUqdAWedP+Pw0swuo/WGqaaH2?=
 =?us-ascii?Q?T4Zlou5LpZfI21d1utpW8bwargn3zj5bS/sDavrmsZOLnr9OXqkvoiM4xyzk?=
 =?us-ascii?Q?iP+RHg4EMXAG2+w+7uLTpTl2cWmV6NX7ShlALAKqWIPUr1zlnooa2JWREPsx?=
 =?us-ascii?Q?Jcwd+6ThFWUyDSm/rcP5+GnT/1zM+W88qR6AEzL5zhzsa2VzKgKMH5zLXzbg?=
 =?us-ascii?Q?uyoafVpoNDhXxCTKkzmdKfWaztMDnAYdydiojbHv94IvvEJWk0jQEWvhK+dh?=
 =?us-ascii?Q?azDo+EB4682RAOWtCS6IkQw030Kg+EuPG+7Dv+mzHrUIiMyiDy6L+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8574.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OgTdzh6SMSMtVY6m78zuURP+Zo+cJNgeE77Pc0b28FfV5sVmes+9AMylo7ZP?=
 =?us-ascii?Q?GBD4WaoCjt/ZIDhOaNdoDJBKIwJm0QZwgbfJaglrA9TA+X9CqJRSiBS+zCGq?=
 =?us-ascii?Q?Qj5c8QFSUPYVCA2kvQxNBIbp4BlqiNH/uL+C0sGqaCKKPtpqLgmA4rIe0JGu?=
 =?us-ascii?Q?vsV7Gp9gslSGiNz3R3shHyqxho1mHM1eo0Q/IP2w/16ZmLzcxjeDrrdTi5t0?=
 =?us-ascii?Q?v4av+1pxywgTOI+YwWV/zMnB/e4N33ekHJZ6vGysr1EQN7yeVayF73FjtJAB?=
 =?us-ascii?Q?351f0JZLe3EHhuciFDesxa0bak6cTlBFtUU4qrtLXWGbO6g7BNqiS80rH9iM?=
 =?us-ascii?Q?vx7eI5vBWPGnXMV37lRjOHm0Mul8VyxMyQ4CGbAof/WeYP9Q2J7SzB/jUB3R?=
 =?us-ascii?Q?Ytq14Ag9U3udbfe1nvHCTKzZW5vvhDL4vy/XJKsdCdfa5hi1rAIq6LBw376s?=
 =?us-ascii?Q?mvvnlqQjjkCkU+/iya7fo548t7UiiphZ6j/ACaNjTbW/mYCoh5pbvdtTvT4h?=
 =?us-ascii?Q?FbsGbSO1pl/XzkJA+jtUCegFj0Vh4GkS5eIzRDWlO2TmXWsKIz7TmKulHpeN?=
 =?us-ascii?Q?QVC4i2/YZQ2JY1+yWWUYuSqA7Tu1yQvxuPGdM8nbsRAZ+0Dqkv+RGGjMlwgq?=
 =?us-ascii?Q?ANS+2sm4o50qD2/xDkWN7GhZTEmJ3B9LPM7uuKk+ansObxGPDG324/BTEak0?=
 =?us-ascii?Q?+XbdRiTy5QTaQIMbxj1BuS+594NWqXv8p0j9NdlLSW2aeR5sRwU62TCSWSOA?=
 =?us-ascii?Q?ahPBrr4Zt6lYENyqFe1j5WADCKPhrx5cDtuErssvrLkzJVUd5CfwLxsUtcHm?=
 =?us-ascii?Q?Evnr1w5f/pOMbi4wmjNT20B9E8j4Zmxk950lify1ev++MKmF4KiEw3bNlBYy?=
 =?us-ascii?Q?Iy3mb9wgI1NVD1ei7hEOTlii/mjE8th+QWxRMiL4Uc0YdFVura/fba78u9El?=
 =?us-ascii?Q?Civ/SrIZmadi4anN/+HOBtNeGZTkKBF+/NObaRwmnEjMBhWMRvGyXDBuS3Ka?=
 =?us-ascii?Q?aOy0jDrNap1X6+9XN+kGGT9TvKydKkzIA0sVTF0rOO+4hUE8qgCFX+XCOPMX?=
 =?us-ascii?Q?KDfdXOhHPHEFi4vP7Z6dKMrKpRV1a/wAo6jbsSKU8G00OXc8E9J6Opab+lbf?=
 =?us-ascii?Q?FCnBz7h8ZirP1R6R0JjUJ/Dq7/Aui4NPwukQbPN3OVPQAPlo0tDmIgmalvJj?=
 =?us-ascii?Q?4BxGyy6h9UE7sparZSHMoSdJliGadXMaXNYc03d5Sj12si/CnUxPkHnDPYmk?=
 =?us-ascii?Q?Sl8S6VAcUc9cX7u8rGCWTz7fvZ9DIM7TQY6ATZwdhRq4zCVuY4Qfgl3BDdvI?=
 =?us-ascii?Q?ge4kVNJvTmLwrDe1kmKFJ/Lq/wV07BmOPOQ/5dl5Rbx2dSgi3rCpmS3+axUk?=
 =?us-ascii?Q?kjUp9/CatEJlB3FZirR3ROHvH4f8IME9awGYp2OUt71KOvwlGeWvZ32zU+cv?=
 =?us-ascii?Q?9kFnt91K/t+TCnZHJPcvNcVQ9uKc4p8SJql5ik7PI+e1XTZXRJvHa356DkCf?=
 =?us-ascii?Q?eTrZZDIL4QvprBAy3iYVehdy1FnmjzvHPhd+A1yCZwwnLTzzhlAEpkrvRaAs?=
 =?us-ascii?Q?2V8gfS6EcGCAkzZ5mL/r0pPdDcohZUFfyrLo5aZ3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa3d3e1-e17a-4d06-3ca9-08dd9812b1f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8574.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 02:53:42.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI3lDfYZb6/z1jy2P3PK5p5nDE6WH6DlVAvirPW+2s+pQU42ZsgKFUKXSRH00wUVWJE47poKEbDTztxLONa1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10883

From: Luke Wang <ziniu.wang_1@nxp.com>

i.MX reference manual specifies that internal clock loopback should be
used for SDR104/HS200/HS400 modes. Move ESDHC_MIX_CTRL_FBCLK_SEL
configuration into the timing selection function to:

1. Explicitly set internal loopback path for SDR104/HS200/HS400 modes
2. Avoid redundant bit manipulation across multiple functions

Preserve ESDHC_MIX_CTRL_FBCLK_SEL during system resume for SDIO devices
with MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ flag, as the controller
might lose register state during suspend while skipping card
re-initialization.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7611682f10c3..c448a53530a5 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -728,23 +728,17 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
 		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
-			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			if (val & SDHCI_CTRL_TUNED_CLK) {
+			if (val & SDHCI_CTRL_TUNED_CLK)
 				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
-			} else {
+			else
 				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
-			}
 
-			if (val & SDHCI_CTRL_EXEC_TUNING) {
+			if (val & SDHCI_CTRL_EXEC_TUNING)
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
-				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
-			} else {
+			else
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
-			}
 
 			writel(v, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
-			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		}
 		return;
 	case SDHCI_TRANSFER_MODE:
@@ -1082,7 +1076,6 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 		ctrl &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
 			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
 			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
@@ -1177,8 +1170,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 		"warning! RESET_ALL never complete before sending tuning command\n");
 
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
-	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
-			ESDHC_MIX_CTRL_FBCLK_SEL;
+	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 	writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK, val),
 	       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
@@ -1432,6 +1424,15 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		break;
 	}
 
+	if (timing == MMC_TIMING_UHS_SDR104 ||
+	    timing == MMC_TIMING_MMC_HS200 ||
+	    timing == MMC_TIMING_MMC_HS400)
+		m |= ESDHC_MIX_CTRL_FBCLK_SEL;
+	else
+		m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
+
+	writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+
 	esdhc_change_pinstate(host, timing);
 }
 
-- 
2.34.1

