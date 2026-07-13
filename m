Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E433A9FF;
	Mon, 13 Jul 2026 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917408; cv=fail; b=kgV4CLQtJljDg2SJ1PA2BBj58OFB3wubhI0slgqClD17+OhaJt2Ykx7R/44VvR5fX1S7s4VH2pcLjbPXtcMBbQamjd0dxVm/Hrhy3AV0rWNmaY46FqjbfEqO4sMnSYk9johAXa9zNuKEYu+8ktmeptQsXxV2qfSnXUEOo8IFr7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917408; c=relaxed/simple;
	bh=SOCMc9RC4ueSnII0T0YI8y390+r8NEMwN1srfEN9bpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgrabvSuk7SfHgagvYxRHKQFYYDwh3OYeoPH+7FguSljE9GAYqhnZOUwaAiWa7PNIiuF7S7L0UuHf7/Wfm9fYWLp4Fe9kY6hqFuxCesZsK5nB99xtKqyySh028TQOhM0ZteQzgXvGGGru7EWH+FgB1ZPQhv1/b6LaEyWwK8CfD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JdCXwEPA; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JdCXwEPA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foyojiBCgCyd03cd6tbJsaXfG6T6btp4QmHIZO0GJ8ZI4uEn3MwGdVc2oR6hFhuHThrAFLcUzGBSpK3vFCqiC83AR1mgpdgrn0ju85stMpcxLPSWnEzWWjouvfcHUo5h3Fs5BqF/yEAGUD9uz0wohAxrLS0zVgL+WDYSwx+Lbjg+xs2L5ghAdZXrapjME/HFMTcSP4RwwNs1lZ2iuWm8SkdWvV+5KvGMECU4TGCH+51LkS8i8XkrepGN84vfiPvzVcFcZcSlJlX8YVA7+jUFmnVu9xVkmjJXWLCyyxeiV3JBEShkxmoln+zxZsbM0hGsBBHnVAWrshg7aMaSOHSmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRGwQU7IScsHwwXN5wix8xDQEc+yVemnrH0ZO7mMhLI=;
 b=aBl8oX3Ly6ZlIruAQusFIcxMEckOiORxws9ekH+4IsSiiy3pmWZDGLSx8EU95G3x9ScxveVpXf2vV1/uHQ6gflAhv89sLbw0JnR9tjHepDxgWD4mkgVTODBCcQp+sHebfALbkagATlh5S8sackzLorIP5/gWGGW84UyNMqH7G/DDs3GjL49pw8w+DFRcYdjdJ26qgpUebk4K4W4KgbAQFx9+OfoM4D1PjHJiQttOB8N8aS4+Pj5z5SLHZ2h1kknG2apkPevSCf015TKnqHt0a05WzvgS1lVI1qRiJ7IQTmtmxDSReJRphM3jm8PjZs6DJ+xTpGmcvsyFPgMJNzIJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRGwQU7IScsHwwXN5wix8xDQEc+yVemnrH0ZO7mMhLI=;
 b=JdCXwEPAjw1kmUAIHpV/pWPg0npxJu1h2gIpMdzTCe2GexLfNfoqqXWpY7AuuxdgTwWfQfvvas552Een4/Lb6TNNjEzDon7nw6MzRrjMAon8u/vK/B9dwwuErmq+jWRYcP9knedgWmcoZj2L9cCU9nSK/Zv2bH47Mgs3I3Fu2URhHqADnPA47NhQh+yPBu8y0F01Wa9I51UfOrIiTT4sFcbGhqWWt/x7h9XaLHmZppNBG0zp37JLS6yM2ISV4lj2ywSR10RhxsR3XLNUn1lEW+vQWvMHTLKTYNy+QGJMMCl3zlCcvp/fWWjSGrg9ga8fdpaMUrITouP9unMYvRoTXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 04:36:40 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 04:36:40 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate() to allow default state restore
Date: Mon, 13 Jul 2026 12:38:59 +0800
Message-Id: <20260713043904.4144172-4-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: 28885b25-448f-4d17-f987-08dee098556c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bR2GE/FNp6ASejYxczRP1Ku11ebsn/UYLWj6DimiCNPh29v2L0RIRnmtWY8xN5JDJD/XG9PikYQyKFe+z3ZkMDGZyROjAM9zK38j01YjDIRMZrhVy6WzBkzpPz2S5Aw5YZ78v3QLgCd36uj03fD4iBjFXuZ2r72+0OEkTPWgOJlOpIhUsKz3Y+HkstC6NQ9siqXg9o7M7zUK2z45DLL2qE+wGKUwTYrl7eSg3YEWBnjXbbWQbZttepHiomDyXsSl+GhSR/pHxK997qUMgLxtSRMWfCdiISf2Nqxxk/KqSAqZf9cfqmdRAOmgfDzFs3ksLAXZkn1MCnW222OLnaJVBtT9pb7Qu2ZBLnHKJ0kLmIbjoTSE2VDtsSLtWTCb3JWTyW0w7ITCUoXjM3UZ/qvl2iLFzOhLJ28AiXIKJvvPe4xpHcWlGaXgxaiMyaYa6+tpKlY+Yq/xHg/b91MmTgnLBIQ40bs6u8+pg5iqeXAU/pPlKCdmwPs9GIToVVe7+dXqNAo7GIL8Mbb3xp3elinq8CR/WAoAz6bZQus92rQb25mSTNG2LxwRRY2AAwjunHsCUnQuCROy6MdBGPDUpK09rcF9TSMLeFHJhRoAVbIxYf1rDbeuIZzSIrCqFGBiPkwBvNu1EagvBn/pPjIX3S0fBNgxkJAray/6Wnig3jxJv6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WJLRR/fK4IGIuXXE8w0jKyXDIrHCSrjC1tjPXmXVVTfn0ofZhA+z+Btao5QN?=
 =?us-ascii?Q?k694BkQ4HblU1Lljq64yVxUxyvfeEfCidH8EsiaZ4LwLOZbeRqS+RxZd47oj?=
 =?us-ascii?Q?uK9a65ZQ+VRZllrnod037mmHQImtixtZ2mnDrEyYOmomXP6F7aD2SGbmBYvx?=
 =?us-ascii?Q?paMLga/pzRYUbCGy4o4Bgj4ABqat81XfYYquE3qD4mj2hcIP5sn15kHkszkH?=
 =?us-ascii?Q?1nKxFCyz01Hs5lVX6sVQNABsI3j5X4n1cjuKZbHJNJdNNabOTdB2PNLOgCC1?=
 =?us-ascii?Q?koiHhpd7fPM38w5XfPls+IhAQ33LF1ZWv1Jmst8gPPuc0HKARTqy90KD5QxA?=
 =?us-ascii?Q?k1czY2Mh7z3UXHMpdVbRdBL1gjw02SyQm09ltnRsvrgmA+2Rx2bmlAABGRvt?=
 =?us-ascii?Q?DLPN5JqavqxRKFmENXHEWbc/yySQBzVacBkpFyOjxn4Dvs4F87fPOfEvufr8?=
 =?us-ascii?Q?zvssI20/ye2H/GJU52WXJjpZF5dXLvmKf/KnzHsrr7hs+jZPqU2qZpKwieXP?=
 =?us-ascii?Q?Szmy3z6yRGDCZ7fU0ozNSss3lIpaUBOGpmp52Hf9wVbh2ipoQml6Zf26921l?=
 =?us-ascii?Q?EjZpmb1RzYF5nxTWhMAhJSWkM6iBciCQCotiy+G49ZXOfG4Uv29bmFbkY7vq?=
 =?us-ascii?Q?sdFAO3IRqT5VIXBZ3n+msS3t5weKubK0SRP5+HsUoJN5tFDJPqHbGg+gfdNK?=
 =?us-ascii?Q?0Mli0E+ZJ5b8L+OQSq4CbTjk2Qx6e03Or6pYSSDgCO0QK9dwvdcSsv7BZchq?=
 =?us-ascii?Q?WPEGnJFHPXjNeD/k+wa3N6dbKPdgQKaTmfIgVCKj+I1Mfd4wA9RBjskRgupZ?=
 =?us-ascii?Q?DNHhCgt8R+3t9UN0cJZOX953mb4ag0gSZLn9E8RbxaRCndcOxQBEzZMsnjBZ?=
 =?us-ascii?Q?QOPxl4TjMoBzZIiqAuRLiET7YMIXCVhKT7G4oWU+PUoNWQD5gSUs3V0gVjNK?=
 =?us-ascii?Q?uusNU5pQ4+jdirY4qamDAZfyfBHjooMZhjnlzlduCeeWLxBjkjBcrwo4t9HZ?=
 =?us-ascii?Q?+AjfCZUXc8tj7+F4RK544gRhBLOmPvzexAWcuExFakLQDtZD5p4QzUVer9O8?=
 =?us-ascii?Q?nPOy1xXiuP63x7BSIb6U1ljzCCObUjnzYl3mUeW7US0fZs/hh5X/SUohiP7x?=
 =?us-ascii?Q?rkEDCSLRMlCFpORJrtKw2MtFAkERiYeL1Mtf74iVomXc4atNgV9ZZ3giN3t/?=
 =?us-ascii?Q?SpUjSX6wYFzFYlUfj6HoR+Z2Lla17iTNvf8HBnxGouXHWGoBORFrmCmhYpEM?=
 =?us-ascii?Q?4M+SsuFvPSFAxDtOcUrFGQWmU87o+blanmR+Wxlk6AVwY2g2WsKGK5psDuRG?=
 =?us-ascii?Q?gof0UZaGb47iZNqYzNEfktczyChFKctZu+tzro64Hz+HGBvXciZHApImVxWX?=
 =?us-ascii?Q?b0CdFbdkvyVjFTA9b4G00Mkx9kwU5Mfr4v3KJB/FNXe73ysx/1Bx3A5WoY9l?=
 =?us-ascii?Q?BK/wCx7kx0qDBKimEw9ywl4HZ2TRbY2HOeHTm1czmRL4WjDjxHIxRQGKcW+C?=
 =?us-ascii?Q?GengryL6jRMelN6U92RMaNDavPcelmces2OTkRpvW8oesgclI//4troKrYMz?=
 =?us-ascii?Q?TIieZQ703JQFbnQImkWMErzkuQQX09/NXTgMgGW2ja4DtgRNMxqBTGblmYq8?=
 =?us-ascii?Q?HEqaPGz1nN2hDWVvVKAecchyHR4NUVqUSoDiVosDb1gUIU1FxR8wXLBqxisu?=
 =?us-ascii?Q?sB8qd5gmIfKabqRXA7uSbPKb5oAxvlfnHcYXdejyBudE+l/nxVNec/yK1BWY?=
 =?us-ascii?Q?S781xLsZYI0gCdIgMUmPrBAxvP9P5pRKmjB4SFqGDj3fecu8oztonvVt0hE/?=
X-MS-Exchange-AntiSpam-MessageData-1: dj1osbVodmkfew==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28885b25-448f-4d17-f987-08dee098556c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:36:40.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N03q6iYZtMfXScSJs6X9FvU3wX9arYlqzGoqgBUuwKyQ4wJYy3cElQGImLfFGn0vP1cvddkWx/uRYgpt2P6GxSCOzTWXFDJOvMJjY0Af8T/cpxBQP6JsOT/CJ4vAFan6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

From: Luke Wang <ziniu.wang_1@nxp.com>

esdhc_change_pinstate() checks for pins_100mhz and pins_200mhz at the
top of the function and returns -EINVAL if either is not defined. This
prevents the default case from ever being reached, which means devices
with a sleep pinctrl state but without high-speed pin states (100mhz/
200mhz) can never restore their default pin configuration.

Move the IS_ERR checks for pins_100mhz and pins_200mhz into their
respective switch cases.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7230d70e02ae..ead4685d621a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1326,19 +1326,21 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 
 	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
 
-	if (IS_ERR(imx_data->pinctrl) ||
-		IS_ERR(imx_data->pins_100mhz) ||
-		IS_ERR(imx_data->pins_200mhz))
+	if (IS_ERR(imx_data->pinctrl))
 		return -EINVAL;
 
 	switch (uhs) {
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_DDR50:
+		if (IS_ERR(imx_data->pins_100mhz))
+			return -EINVAL;
 		pinctrl = imx_data->pins_100mhz;
 		break;
 	case MMC_TIMING_UHS_SDR104:
 	case MMC_TIMING_MMC_HS200:
 	case MMC_TIMING_MMC_HS400:
+		if (IS_ERR(imx_data->pins_200mhz))
+			return -EINVAL;
 		pinctrl = imx_data->pins_200mhz;
 		break;
 	default:
-- 
2.34.1

