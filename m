Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2058.outbound.protection.outlook.com [40.107.103.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4B25A627;
	Wed,  9 Apr 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185306; cv=fail; b=ZNTou1O+Ch4QgcoCl3gWnilwc9i8AgrtY40sK7utQhyJCYOFXeORSIoOMnLi7o6biRP+64DhiZVESlYc0xYLdgAzTkaOKTuOVKEInCWHz8eND+RHBKwG8Brnnz7Tt2pc+oxoS9JDE89puQG6xk3HS1ip6BWZFK0k2LPTtEqRUYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185306; c=relaxed/simple;
	bh=/SMEICLu2VT05IR8wlHZC+nXxZEHTIUufQhi6GNqGYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uo8HSajCOerzV3a/rfS411a4hJvpl0VOl+ns4tdcZRy6PEMRjzvXIOoCLGbG8jWz8tBIbNrXzjyIVOmontsNiuiwqcerO3WHTSp9QMtvpMQo+WYWvXAHk92My5JQMvrHtFpYz2V5r4qKo/kTwQCfEXMiQe71F+0NB0xWVZvJp64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U8c6Na/8; arc=fail smtp.client-ip=40.107.103.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U8c6Na/8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBoGFqi4VTkltgQAgFnBmJeM5jkHbWPF4QOqbZnxaBt0i3Q7Znw0+K8vtjnWLJyJIR4s/QjC18TT2S75uIjjo+SkMrgk6nirxs9HN8tCmVSccvhsfdrv6Pm+FuPOYh3q7dPj+BWXRHKi3DI2O5nJOADzuRbhijfXdLb699MzNMVulEknufnXuD5D1XnquuatGzKHTF93RUrTvI09hxET4OKK+s8AyUgtNuA8GYFmgE5vJi5Pz1pfHJsMM4o7Fhyobq4E/hz6nsTfO2EVkKKqC3UhfEF6a+Pp+qnvY+26mLaVhN5h3sxwp8Qw6VRlnSlUL9M18JOrun+VEyH4wS3rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC2Jf6/Ko9DZJiS3g24lc9ZEWl7IV9VGyorYPoiH4fc=;
 b=p4OabQdKD2C+gdLMYhhzP9eGk7qtgLq2V3jLaI+NFxFNtdO/bwpuojJKVymVO3LECbYQFKXRjAhSjLglK3f+SeTPE5TQQzo9O8t7q5YPK/TuCS9t578KW8lav2L2RNXb9/PSVbxR3f8/+BU+i0S7f8wMD796jk+maimTmCwmOAIzz83AnmojVZ15IJA/OSW5dnqswFtsUzmUbjrRtB5jjMZvoSlqflApRIvjEuGJ2EugT9gHKLzWHITwwEA3sEOqdEaiMXFPyM2GZSlRZ9IR2a101s67jGUbEZO6JXJA0yExSj4bhf9bdETD60GgzUfHB1x0/tB4J1vgml5Ahial4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC2Jf6/Ko9DZJiS3g24lc9ZEWl7IV9VGyorYPoiH4fc=;
 b=U8c6Na/8y7jqwBlN9qlm70OLju0slwGFv1soEBcG9Ua0h42ktLKTALFWf7YJ9QrwIUoawlh6yUHxDH/QvJ6QIkIYEy7qLC8AiLhlvzGObLms5tyrUvQCbmz4WGNsQOc6GtMqZePKsLOYZz33MrBXtqkHgB0GiSX8WmgdQpiWrceZXVg7z4NIljvsg1GJ/ZJW2bSn/+RibvwB+QjxNMOX+748+vQqQaI5s6uysAFACPfyHsiVrfYRE8TIHUiV+3hvOEFuEnWS9v1WCz0Aha04fu1sAsBD+byHdHSeLM4XkfbJG7EELWjEYonWMcvwyzNh3EdSDg4QvSOiLjPxrJofSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM9PR04MB8196.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 07:55:01 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:55:01 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mmc: sdhci-esdhc-imx: widen auto-tuning window for manual tuning
Date: Wed,  9 Apr 2025 15:55:48 +0800
Message-Id: <20250409075550.3413032-5-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
References: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM9PR04MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 928410b3-eacc-431e-43f4-08dd773bd4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P3Z66H3ce2FmzAjF3QDroH89vj+P1nGB9kWtJchARjPJHTZQCtHUCikm8fyo?=
 =?us-ascii?Q?0g609diS/Eel30eQ03ZUVBqNatUS0EDAdD3kp4dKeIhMxn2IbiqlmbSW5sXp?=
 =?us-ascii?Q?cWGKPvzkQuHN0c2s695TKJ1YmJAf/wWd7llAF1LtgAhjsL4ygWcFmJgf6BZp?=
 =?us-ascii?Q?nMeClSXDPnAIZTt1HKfCawG0bjl0EFrFS+KPKtP/psBeTIq3Y3A/ihHB4sMf?=
 =?us-ascii?Q?figf95nSqnlXinaE7DWzAaIPEzr5Km5NUC5hybF7RWrcgTltxWtz1Zhk1mfg?=
 =?us-ascii?Q?usG4pe7iGOMLtZEaG3d+q/6udZcHBJzW4KFiSoLO+Zpmpu899v6pIi1Tcfer?=
 =?us-ascii?Q?sQWv9N2RNxGBzz5WcOrIP32gf7lDwRz933xl7pBEB8MxY2IOPWoFn8lOGPpQ?=
 =?us-ascii?Q?R8kuAi91kxTncqikRsxAtA7c0bMLRw4LrxFGo9wPLc1/X9/RU0h0Xz8YTfTl?=
 =?us-ascii?Q?ohY/yh/TG2RPRBB+OVZtSiUtKdLZxzubqtTJ4Dg8hxw9AmTYCaS2JLP7vcaV?=
 =?us-ascii?Q?cj4AiiT2KID5uFuAxUOTzJWlz7LcKk0ksvydI/YWc80TCnHGqKmkxvtBqqw5?=
 =?us-ascii?Q?eCOdoz44I61ZYvXRPBbzLIpAvFxncjeV2nVMgvzPch71NHz52E98QGwTRvPd?=
 =?us-ascii?Q?jcCtXY6Tb1X4RRh+MIJ9DWYgrEOjQYLteLixwtyFb/P0QNrsXF3VMygMg10m?=
 =?us-ascii?Q?UbxG6HxMM8lRstPJlXgKPNsMIOrjI6H9msH/NISoAJUReg2wIlr40hFXu6sB?=
 =?us-ascii?Q?rMWqWk9aMB2i3CzglfWe1Q8aJ4XYXHmC3EmNWWkShwpkghKiGH/J7PKWf5om?=
 =?us-ascii?Q?8hRQv6CjbmIunbmYuA2OUStCwbxi+6CZ6hDq2I33w/5r4H4Anf0zRbpT/lSe?=
 =?us-ascii?Q?QiPG5d2A7sKJsCw8aYV93s9NpgUkWUdWAPPIxlnGq+enEC9GzDHUF3Y7keKT?=
 =?us-ascii?Q?Bkz04O9Z/RGG2ap6veryoZ09x7GOOXTRhQVtjgK2bsmyahn4U2x39r35Alb3?=
 =?us-ascii?Q?sqBt/rzFIMxUhaoFYTOU+2/H9oXZizy7UVprKMw/9wm5us3cRDo5GS63sIHI?=
 =?us-ascii?Q?8xPXce68TxxO8N/a5puuHwOebo98B1UemmMfiQuPH7BgchR1DWzy0iUCr1eD?=
 =?us-ascii?Q?STI8TMsvaWi5fDHsstUoETpI9g5YMGhNRFHC5OpLr69n35taD8a5yfNVdfwK?=
 =?us-ascii?Q?4C4fUb1Ird/Srd5H2T2OsoIAGgnhapG4TOsDB1Utgb4KGhybDQz71fELrkec?=
 =?us-ascii?Q?oBf2BuBItvzP7QEDMzHdLYrm5+NFCSSN2vTaxL+Z9jFLkPq/Bmw5SCm9knxP?=
 =?us-ascii?Q?W+3uzFAFqaU8+FAGu3pEIs7SZlcr/nYkwv6r6lSNEnBsvtT/mkW2TnoaAcFW?=
 =?us-ascii?Q?wzzV+0CyhxWl0MF9iHHHGqotf4IbcxPh8UrgSXSU2N3blgp1UOWtR46+y2r7?=
 =?us-ascii?Q?L9UCHbcoMAhZIOsulk54pLamGiuispBEu/r2uZltrQy6NCESan9VsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5oPndS0BCRlP7xbzFDqXW4t4iSYfg8QxU5O1buCbCQn5WoGbQZFos4I8Wq/K?=
 =?us-ascii?Q?WIGPiyO8AwopO0fCN40A46ZQINduxoqTGp6bIcYhkaOAGuvIZDac6ZC7TW3S?=
 =?us-ascii?Q?Jv0JoDPwCTkW/JI2iYMlloQCZ4BZQx6UPua3veoAUiIakU64iYnOSb7yvvTs?=
 =?us-ascii?Q?r7iFA6yq0OEURkK61bfAewAutqnSH1mEAnoznOHfwBs0tV5OnOgZTmNm/0vw?=
 =?us-ascii?Q?pd0XHxA14nb6zamSLjzQ2VToQTRVl8sYEpmveZL8LKDVx2e3oCATl+hRyIen?=
 =?us-ascii?Q?uzDunbBQ/zzCSf2r+9mpCpvHf7Un1qTvjhpH1gTKmqt7iZnOpQ6UdWmCEpz8?=
 =?us-ascii?Q?NP0qnNgsznBwkss5fuhMT6K2zyc7aPtDa8mgakiNQSwXk5iD6bzzveM457be?=
 =?us-ascii?Q?ZCfZalk0AnnC6vvLPgBU8LzuRAt0OLK0I9Ag+RRokp4BX8T5W9E9mYOMJBXZ?=
 =?us-ascii?Q?/DI2k4gZxWbDm73PkVUXRTV8GA9F+Chk4tjgAQDFsf2qShByHmvcA0zTpJbW?=
 =?us-ascii?Q?lDo5iRAOoxy9RvHtWsILRCkYnkW/UBYbXNoSHLKOwJoIvY9S7NzkGjwpnwz4?=
 =?us-ascii?Q?waQgm/meIjwOJqoOU871pUFEkhGzkuB1QbX78qCU1br+peoKCOJrsw2KKHOp?=
 =?us-ascii?Q?OWHW7LYJlgWHlb+1UAZkopPfkT+b57hiOWabRJmO1dHXN9oA7aHLobBiRmZ/?=
 =?us-ascii?Q?mXAnLz5WpdhA9+TNMqP4C2k6uT30fg4dfr/hxgMWsc36Rq1DbhhkOTImGBf2?=
 =?us-ascii?Q?3NbgmjcV51IHo4a9mUq2uO2WWRoSw2XdCYD4oOjiHr9idqXd+8FV/9dQxKzG?=
 =?us-ascii?Q?z6d1Ls8O8sBZsGELhoXJkm2/9vj8JinuP1u11ycpK5kPWXwfrOn7Vl7PYKfJ?=
 =?us-ascii?Q?tgjOjnxVVmexvAv3TZOimTTkqjgiiDBgqlAaDolcP5vbyTbrXa9EU8jAmqY+?=
 =?us-ascii?Q?Mvk5cGTIgc1Hm7In6+VxBw7Moj4lbtMEainsiBQTbKguamDRlKEvXMm21WDi?=
 =?us-ascii?Q?BdnklBG2jLSFFteKuA8FV1UhBIHJ4c+Ey1E8kP7Hmt9/4j6FJhHMud5zxjDl?=
 =?us-ascii?Q?yXPfvYxzrsaBN+WJoMPef/dav/a/DNHyanAh3aayHMnMYKu+MLfjRaBvqLcx?=
 =?us-ascii?Q?8ZmmZrDN1Y2G5+Q3L68NvWaT/ae9zcZr+T1ZWnbKK94sM2UYfp41RbQU8EXZ?=
 =?us-ascii?Q?j4yzWnZ56q7NZw8CNOjtNq5+W2nms/qGrkg73o44ODq1OQaWUMgnavEFsYn7?=
 =?us-ascii?Q?+iSEm76qU+mfuyAxDSLOOm+lfmyY6wtsFAD6QplIN9/IEN3ceiTX38T2v82F?=
 =?us-ascii?Q?4i7Q761I2af6GrMvC+DjDFuZoRHcWs8/Z89i30U8JEvJUBO+zsgK22iPLo4b?=
 =?us-ascii?Q?UW7QwSoHh1HgzHMMaW+3wtrvZX13OZsnQriLjj5bNjcyWQ9UpmG0VVkOX00K?=
 =?us-ascii?Q?PIduvZ403RzTz9xRQYBdE56D21i/cIGBnWCdHwGP3RdesqZtAiWdL9br77IA?=
 =?us-ascii?Q?JCBTfv1grO6DHYnMdH3oamMrBq7xh1lAKRutVDyT3U6lZ9ijwy77zW1S5v+L?=
 =?us-ascii?Q?CKnkWovKsB22VmeMOCYSvQ0N2mndPnsJoM6A19T2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928410b3-eacc-431e-43f4-08dd773bd4eb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:55:01.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUVUuXIeMupgyZxs1llU32arbwNoJAi0jFYgP51zoPqN1UeXVeNdRpv4YSD2TiQQoc6o4uMeDvzOJWXu7tL+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8196

From: Haibo Chen <haibo.chen@nxp.com>

Expand the auto-tuning window width from 0 to 3 for manual tuning to
account for sampling point shifts caused by temperature change. This change
is based on hardware recommendation, providing enough margin for the
auto-tuning logic to locate valid sampling points.

When config the manual tuning final sample delay, need deduct the auto
tuning window width according to the IP logic.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d91b65439544..46da155fe582 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -85,7 +85,8 @@
 #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
 #define  ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK	GENMASK(30, 24)
 #define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK	GENMASK(14, 8)
-
+#define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_OUT_MASK	GENMASK(7, 4)
+#define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_POST_MASK	GENMASK(3, 0)
 /* strobe dll register */
 #define ESDHC_STROBE_DLL_CTRL		0x70
 #define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
@@ -243,6 +244,7 @@ struct esdhc_platform_data {
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
 	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
 	unsigned int saved_tuning_delay_cell;	/* save the value of tuning delay cell */
+	unsigned int saved_auto_tuning_window;  /* save the auto tuning window width */
 };
 
 struct esdhc_soc_data {
@@ -1206,6 +1208,7 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int min, max, avg, ret;
 	int win_length, target_min, target_max, target_win_length;
+	u32 clk_tune_ctrl_status;
 
 	min = ESDHC_TUNE_CTRL_MIN;
 	max = ESDHC_TUNE_CTRL_MIN;
@@ -1245,6 +1248,23 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	/* use average delay to get the best timing */
 	avg = (target_min + target_max) / 2;
 	esdhc_prepare_tuning(host, avg);
+
+	/*
+	 * adjust the delay according to tuning window, make preparation
+	 * for the auto-tuning logic. According to hardware suggest, need
+	 * to config the auto tuning window width to 3, to make the auto
+	 * tuning logic have enough space to handle the sample point shift
+	 * caused by temperature change.
+	 */
+	clk_tune_ctrl_status = FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
+					  avg - ESDHC_AUTO_TUNING_WINDOW) |
+			       FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_OUT_MASK,
+					  ESDHC_AUTO_TUNING_WINDOW) |
+			       FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_POST_MASK,
+					  ESDHC_AUTO_TUNING_WINDOW);
+
+	writel(clk_tune_ctrl_status, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+
 	ret = mmc_send_tuning(host->mmc, opcode, NULL);
 	esdhc_post_tuning(host);
 
@@ -1659,7 +1679,11 @@ static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
 		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 
 		writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
-				  imx_data->boarddata.saved_tuning_delay_cell),
+				  imx_data->boarddata.saved_tuning_delay_cell) |
+		       FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_OUT_MASK,
+				  ESDHC_AUTO_TUNING_WINDOW) |
+		       FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_POST_MASK,
+				  ESDHC_AUTO_TUNING_WINDOW),
 		       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	}
 }
-- 
2.34.1

