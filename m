Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EFE22B8A9;
	Wed, 21 May 2025 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796029; cv=fail; b=UEznUCgyoJ6SwTMvK/AN43yY1/dlHaVHRQVXDgoYzfbTHIzkmPc+WOjROZ/Mu4zbGEAYad1Y4xNkjS60vDCPv8iF/9W+v1BjbDmPP8avwI9Rca+q0/r3e3ttAFmw++8eT590hx0EkPNfVr556XgLFz8NumCfGFkgnMHu2uYjQkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796029; c=relaxed/simple;
	bh=gdEVblh5A2OG4N80ZMjIfR6Q3ZqyKVHXnb0QzbPDB64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vn1seKoihmO0YRGTuowx9q7hsuzpcw8NYV/cypsz/tBVefM6BcAnmqHu6xqptNHwY76ciCNsQeVkpWuuOCyT8guj/VLe/E3Mmng0hfcP7nIZVrSmkfMordDE3Z7LElLIZ3teuWH4Q9hRzMKgQN3gfSJ63d5VkJV8/mZL+5aUn2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WEYNbl+v; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WEYNbl+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHIklTfbb/W9WMjOSJnRxjlbO5VsEBBhdiBSgGgOHxlo9mETcZl70jK7AeX9ZQfpSxxfP/VEFJZPWYQ9VwZvWM2uM/GT9ajKaS2Dyx7E2nYuewOE2yUFL9QCUnUlLvzSfIQ4wyTVa20vOz/tX5CSTryXK5DSXjUPJ296yixU+7xsbNZiIJ0Wrp6Uc0kCIRM2qyEfaXZFhJzJ/FzHCgwukOlbeOEy82jXr3V6xOzMxHG0AY5BGSlcFWHhOVyP3FfSpdDEc1Y7GpahhMZUuRCS3DDxAH48HoFsf6t1Woy5iTxiCvtZGdpQz2RYb5NSaAaPaar5JzUft/281JnQYseE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w00azB6vIToNdt6ul27sHOpJVob0ENOmRwAgx9vroRo=;
 b=YB4FFhRYBrtRt9H9EovduNbQAKgDL3nYZkepHXw1oVe3nvLH7S2dAf55iGKNOM0pH+ZNq19kQlTgh4v/WesEm0ZPSiAKWLFRAl4e9sv2ErxRnefwfbtDvEbrmNePH3rTLdV03EKkXri3QrBIqCcXeF8Pl3qs8ixq9PTkav0wimwpo7HV2rxTZmVOYgWaSO3ttaisnn8Ibxi/hrWzXeFBL/fRubCKFIDUdOTOahSZKHEYezvJhjS9xGmNYfdAX83olorfLMvE4mXQSuwgmLyvaVt1MWPGpyRlq471v9HcR+ukuw7a/SmjdPfQYV85GwA+wU8jxLR7R+JhHkKAjg0n3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w00azB6vIToNdt6ul27sHOpJVob0ENOmRwAgx9vroRo=;
 b=WEYNbl+vUj49j0h+v8ldrnG/ucbZop4a0xFGOn2iwJj/0TSm+lchYiRukkC7OJ0iP8R4mXsi99hDRqbExacsGRfZX02bpzW8G0IAqJV8DXKicP7cDSe92w3QBVxl+VN5E1bQeA/BMJuLgKzJ3HmjprPxPVFatgJqGbXEeWoWDJkQ/1wrM9AmykOqgJ14to/CAuYyUHqPUxQWJ1gVm9tvVm4hfOppgis0lvmU4eP7JSuL1yQ0eNUKFl9ITc4SrqQsERukwcP/RxewwvnvxF4OlIDDjj2ZIDoDI9wav3KpIdlswnX7/9ei8JaL75wV/A9P90D8dWFUcF0mUAiWnops7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19)
 by VI2PR04MB10883.eurprd04.prod.outlook.com (2603:10a6:800:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 02:53:46 +0000
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce]) by PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce%2]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 02:53:45 +0000
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
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: optimize clock loopback selection with dummy pad support
Date: Wed, 21 May 2025 10:55:02 +0800
Message-Id: <20250521025502.112030-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
References: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b5ca8239-31a1-4dde-5c0c-08dd9812b431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+Bs3twDqsuy9WRJhKVwi0wGojUGuUKQuL/XK4f7r7VP/Y1Dzzi5Sacf1Adn?=
 =?us-ascii?Q?MED0eEaTZhH8nBeSs4Nnu5cSFeH4vRalKuI4ElZBO5b5HB1ytkBhgJqTsBkR?=
 =?us-ascii?Q?YRQsrs0HtB26ubBAg9hF1UKEhVrOzWM/BD7farVN1qEWFcn65/n+3bHQSvsE?=
 =?us-ascii?Q?qa8PKG+bqfUdah2Rv32M7CSPaZnJB3WIH2/k5r4jZk54mJvBQFEXOt+tZ6Hj?=
 =?us-ascii?Q?2D9oV8ho2goZ7VvXAEbb/prFxcIorErEy6Gt5N/J6uZUOncElV9QoknFjXpp?=
 =?us-ascii?Q?z5bOXlIqs1+LAhowbwftL+ifSaa0Y9QTYYaGvHu9dGAVcO0TQ8OS2atCwMyU?=
 =?us-ascii?Q?54kGaWRTbxiZaWMYbq+72VR7MfO6y6qa4nm2FGaa5+LI9TVPh3N8wNYuWR3D?=
 =?us-ascii?Q?EHsmwTv0im7VuJcJDhR6ZooT+EYOfWcYdUQYW8yAl6tZZ7Rgt49W+OW7zrah?=
 =?us-ascii?Q?qkAk7nZWxiZwrvgEfwMb2W82gIrHUbmlodzTAdGqUx7NWzbs96JfsPUCKx30?=
 =?us-ascii?Q?yjbfwd3MmwXRF6OiLd/CmoPZYTwa4h3kUtJB0BRMrhFFsnakcC2pE/6nrNjh?=
 =?us-ascii?Q?bdcd9YPjyVeTAvOTvCP2Wrime1eqjbdgwh1SyXOW5XLyGFIYA26xvQ5UCc2w?=
 =?us-ascii?Q?A4cVfs35cVsTUn0CUZrHrsW2W89uEewAZpkos2JNSIxpxBzrst1huNWGQ9VN?=
 =?us-ascii?Q?LkTmAuDUKvd2o5K6SBqtd33QS1ONGPjjzeeGQNnaLjYajoqKvwttaEMbEtNJ?=
 =?us-ascii?Q?vGS58CHsLBu7VH5WgQf6RA2UzRxsehgliurOSY+cxy3zfe7E9kibTxKrI0Yu?=
 =?us-ascii?Q?OK8vtUr10IDRbR9bVW9z57ZgApI32QU2g3R9wllwlL0SDrjf1sAsK6zMDu4w?=
 =?us-ascii?Q?9Q/cpHIc9eSRDkL+4rmHin+DE0VJudVRc0yp8IdH0Iw1WC4m6sLAu0O2/ZQe?=
 =?us-ascii?Q?015QBijyYuCVYMTzcTJpvUB1sI/+9R6hCWF0Cdh946aJcKUjcIK5+o2bZ1pV?=
 =?us-ascii?Q?a5kQ4EjtLkkhh7X3drQyMMvynb8wcDntoKEMnEva5HFxwHx0EmXj0+ZTy0Fe?=
 =?us-ascii?Q?KAmnb8dldvUinCcpvDzKRKLSxsED5sxkzFuWDsJUE9Smo5Ll9vO7ueJzqeCB?=
 =?us-ascii?Q?JOMbM67QXoS8o7sbYAFw+9Qoel6pq/nfNbhczHPOmTlu1duobBfai7rbQl1f?=
 =?us-ascii?Q?XYoSBC674HOVvnxgyH1ydMZ6JYKhhkqCqObX72fu7atvHRMpQHfhl9uHW8ra?=
 =?us-ascii?Q?IUE8x0ZRleas0WdP15Qlq05yIINXcbGJTq2VQLbVvwrboqcrgCSo9oMB/7ot?=
 =?us-ascii?Q?Dxq/eaSUcmqVdGuy+r2J9AIDA5WSMPUEPGXDv2z2zQXrTez5e/h8fVUqVTNQ?=
 =?us-ascii?Q?Lq44Yw7EM/neAe0d4A5jMw9aTw+d+70+loO49cpjbgvcpGUiZAVEqDgyqobh?=
 =?us-ascii?Q?uu0NoI02nEdG6cWmAaF50ZhRZNRIsCjFajPnoJMnvQBXAbEzSbF6Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8574.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?re+vN75p+Fr1lODhHfxBFPQEW0tQreCKpS3PmBtJYeblAFN0WiEfvq/Kd52v?=
 =?us-ascii?Q?dbbQt+150hbHE/RqfhKkK0HBNPStXakmZVFiYu2ajIGKzYCNRg1Q22iKorYY?=
 =?us-ascii?Q?9Jg4rgi0dRq0QB64A7qO8NsAUKvWWYsNASzyju3/8oiYYEroFuLc495JMVFe?=
 =?us-ascii?Q?l1qH+TiYoLUK4xRrexvOcjJjIsV1ERWCmcsqP8cIBeGS5sWW3wb7Xcaf8OGI?=
 =?us-ascii?Q?HkW9HN1KCaDWQhcXqdzEW6M3rhbdbCBPtnrQZsoI2gE1SWXTSue2DS3Y+E4N?=
 =?us-ascii?Q?1+ji1EUtGlL8qIJHHkYTvLVGfJipRFWheebFOi1qVvqW/WmgnpQQ89szGCNo?=
 =?us-ascii?Q?8JvCfQ3245DB+/NS+fhak68W7+jiol9VuuQUBYRUW/xxeT/ojZMwfSOLBUc8?=
 =?us-ascii?Q?2h7OR7xU7IgrfR+nYLf1EnxHPkttNT5YLSHBa+38zN1T8BXZjuwTNusLh6UP?=
 =?us-ascii?Q?BmNciwTkSihQHtGiViFhK4ybohgkFIcU8LapNTJQM0MAsx85qljwHUhOhRHk?=
 =?us-ascii?Q?qAbWjDGFOdAYsUDtbKvt8R2ZX8DyFkaxneqn+v4xPx9Kkqmmaa3z/QDgnTsd?=
 =?us-ascii?Q?E/ccmmPLlazVUCcaxXjS2TvBZU7ygASXwZUI6TPCYwLjnGGFIj7iRHRKYdyf?=
 =?us-ascii?Q?UZZ+3R0NfqpwPHWvZs2hOzkWEmnh3Rau9Pw01LiGzb7SbsHPKCrvT7NBRkIQ?=
 =?us-ascii?Q?A6ZQAbLwXAZSURiHfPW2RT6vbrNomPPYatxnqzRSqK0IsjaEOtgwSYbzOwj2?=
 =?us-ascii?Q?0U3Bd+k2DeUeTF3GLvmOqbIrMQmDDie03oFrI39NS4kwhCCN9XqcxCEhMcoK?=
 =?us-ascii?Q?KpZh33Pij7Ce8yRoHTyYIzS2RzLY59C5U735OMRfqBDPoSDax/ysEBZHg+H6?=
 =?us-ascii?Q?SaM4ESNENMFY+DbNvt9pRgLIhncq2RuUqnMy5GvLGMBNu5+ERKt/l0fYgiDP?=
 =?us-ascii?Q?hvVIVWraxwJZ6bqiPLcOnsWH+wwy68Jje3PBbXf3V1Q+UnrYILcRhxn81Rye?=
 =?us-ascii?Q?64G3KhKBv2MioCu6wwCWP4CJPieZyKU6Qk6Ps7mvlPMs9+XK8PQwM0dGxlE4?=
 =?us-ascii?Q?JHHzOjSrSBKeZDOL36k89JkAJdB3QKKNtCcd4mysLY9vvh7sTYtEvGEn02Zr?=
 =?us-ascii?Q?WmkPIz0xs8JsU9UJyKypNywx3s8q4gk5itYZmvkXJRLQmYth1+UMjO+0qdda?=
 =?us-ascii?Q?YG6N+UWeoF902iQLLvPTvgoOy1AhQYm8JIft9JQ1+6eeSS6K0jNtSK/cUd/f?=
 =?us-ascii?Q?TuMTeC/14ULkMIe7loBQEryS6HYOTOEK1J7xZIyscKRiv0IwnKAkmhXKSG6/?=
 =?us-ascii?Q?Y9RHbgQuzIiyf4xkkHNtNRNuthHCvaal6QlzVzGhJdmK8+wGV49qGG/4Xjkc?=
 =?us-ascii?Q?7rwmNPklzrKDqPToyLu/9BAIwOh8Syi8CaqZY1ydoulkd72B4esZU5vvWMBe?=
 =?us-ascii?Q?WDh5bBBPInaNRusttfuqOLs4B8B8f6fKTsuUc5QRCK7hqCZayQllZqg3Zl4N?=
 =?us-ascii?Q?+Wto0xc0GJyJmV2DHn775JiyucNmN3Kq7oEQDj9B5fUPB9a35s4r49SVnmpH?=
 =?us-ascii?Q?RghVoq/uDgEjNtI1+UL7Osw7LOQ5SCbCMNit6PqH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ca8239-31a1-4dde-5c0c-08dd9812b431
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8574.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 02:53:45.8474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4r+1zoAhoxpNAWMoiQ8KR4Gt+xsvGHNksz+Tc+xBe7KevLppsIX/GUNVzXB8nq1BtdOwcN7rTR0WPIBq6ktzOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10883

From: Luke Wang <ziniu.wang_1@nxp.com>

For legacy platforms without dummy pad:
When clock <= 100MHz: Set ESDHC_MIX_CTRL_FBCLK_SEL to 0 (external clock
pad loopback) for better bus clock proximity.
When clock > 100MHz: Set ESDHC_MIX_CTRL_FBCLK_SEL to 1 (internal clock
loopback) to avoid signal reflection noise at high frequency.

For i.MX94/95 with dummy pad support:
Keep ESDHC_MIX_CTRL_FBCLK_SEL at 0 for all speed mode. Hardware
automatically substitutes clock pad loopback with dummy pad loopback
when available, eliminating signal reflections while preserving better
bus clock proximity.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c448a53530a5..5f1c45b2bd5d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -212,6 +212,9 @@
 /* The IP does not have GPIO CD wake capabilities */
 #define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
 
+/* the controller has dummy pad for clock loopback */
+#define ESDHC_FLAG_DUMMY_PAD		BIT(19)
+
 #define ESDHC_AUTO_TUNING_WINDOW	3
 
 enum wp_types {
@@ -348,6 +351,15 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
 	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
+static struct esdhc_soc_data usdhc_imx95_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_DUMMY_PAD,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
@@ -392,6 +404,8 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
 	{ .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
 	{ .compatible = "fsl,imx8mm-usdhc", .data = &usdhc_imx8mm_data, },
+	{ .compatible = "fsl,imx94-usdhc", .data = &usdhc_imx95_data, },
+	{ .compatible = "fsl,imx95-usdhc", .data = &usdhc_imx95_data, },
 	{ .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
 	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
 	{ /* sentinel */ }
@@ -1424,9 +1438,10 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		break;
 	}
 
-	if (timing == MMC_TIMING_UHS_SDR104 ||
-	    timing == MMC_TIMING_MMC_HS200 ||
-	    timing == MMC_TIMING_MMC_HS400)
+	if (!(imx_data->socdata->flags & ESDHC_FLAG_DUMMY_PAD) &&
+	    (timing == MMC_TIMING_UHS_SDR104 ||
+	     timing == MMC_TIMING_MMC_HS200 ||
+	     timing == MMC_TIMING_MMC_HS400))
 		m |= ESDHC_MIX_CTRL_FBCLK_SEL;
 	else
 		m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
@@ -1678,7 +1693,9 @@ static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
 		writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
 
 		reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
-		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL | ESDHC_MIX_CTRL_FBCLK_SEL;
+		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL;
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_DUMMY_PAD))
+			reg |= ESDHC_MIX_CTRL_FBCLK_SEL;
 		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 
 		writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
-- 
2.34.1

