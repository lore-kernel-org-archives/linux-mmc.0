Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BC363C5F;
	Wed, 11 Mar 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222516; cv=fail; b=jlEqKJZB74JcIqiMGWLwTAjJyrPxPgrPSXmloqMPEpKgVh2Y5hOyYYmVGMO1yMJxQW5QUIdl/naDAnfJ9NvTaUSVFoCoTEQfE/GYrQhJz2sIKYsnXLP2IFIMcW+g+30k1RvULAlwA0eC7HZ1VmSVGWRHLixV3d8Vo+PqnKBXIQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222516; c=relaxed/simple;
	bh=s0hceegOMZiCfrFlDHM5XasR/hfqWKVIkq43Y9NjRtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oHJX78UKdzJUqP/AyYSfAAg0isn6qjQ0NuBrRFkbIcE+B3rdQoFDBn2PByMAP3khfiNehgj7IgQ1iGN64aRtZ839UdtM7NdkINE3SAf+Yht+PJk9IigEY45qq6B2ujP9ueUukcDzMealYDIoH+pCXpagICo8iHaJnVuppeL8swQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C1IPIMEj; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C1IPIMEj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOJTPrFCMkSiA2uZ2lKck5l3iu2rQOW4ObOhCW2082QDBGyTq/xs8hbu0XTrQsUUzwL1XKlDPju1Lbk1ZVEjnbIgyaJYyskTsO3x/6FGePFZ/7oOYmC/lXDQFyeMIZAHGFzwN7hl4NgKdc/MLYEggukbbOUNJ1UCCBzcUIVOGOOfp0rc+D7GJSbn+u6TrxaeYF2ApyIhIiLEGwp6J2pkaIkd/XO624T5LiEyN7eluoDsHZS4qmkrHWaa8S/WHb9SVF+s531bglNoHojr7056+qaoln47zh/w/pXq2O/O8o+VKgTGobYy9IczsM+Pie4d2B5Yq19rDaBBG+RcHl8FXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPcjHrG2YBluLYU+em88g4KAVnlJVQC7KwDoiz6v/qk=;
 b=gQOl8Z7KWxxXMm0OWu8jaNpKqZ67oCjr7CTEgohzVJlcgGp36X33I62PhAkehENSTC/YnwX3S5+Vv5JFlc0tk+Zkne2QFrx7d/yyzEWJ0S9ZmAWmZ++sM+t0TnE41HAiSahzZI7EC+x8QwLgMJzBrmDbFiafy2k9OBmJU4gY3vXubsavQ3NNZWxA3EhHwxsbFfNo7yQ1kNERTlSZtJsVepa64FrQlrGLS9+KmDP+m7g7QJSbQyCBag70uZ21IkLd9F7bUqpcZsCTGM4grqZ9bjjnise8FJrp8junugf9HLw1ClxKup9KlziciMeH/kDyVuIoPDwHo8JZSL8O9CKegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPcjHrG2YBluLYU+em88g4KAVnlJVQC7KwDoiz6v/qk=;
 b=C1IPIMEjzuM/WoC48KRG1tEFgAIrCfUD+MiTak65UPDlg8UfSmKEDO7MBJAUKDoqrNVcHFPEz6jD6oRIypktrv58nHMgUqS3qOOHcWnZKxZUcUj3l1aOb0qwFOyABupCDHb3EzNPKc8946vzqfakGFCTXs0VWioxB+dsxPGJYrFhe2gAyC5r/TiV3kSmCTczmy6PaME4WtVl9eWZqmGwzCiiFzWDyXARoV3dL5VDCicxKNCf2sfBfcMtaL+iq6ZxAF0XWyuTLuihC7Yo4h86u0A+bR8fieYg3IZazH/KA4RkT4jXgvWQEfniYLXQ13UBPb/Inc3rf9GYRuYimh5UWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by GV1PR04MB10607.eurprd04.prod.outlook.com (2603:10a6:150:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:48:29 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9678.023; Wed, 11 Mar 2026
 09:48:29 +0000
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
Subject: [PATCH v3 3/4] mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
Date: Wed, 11 Mar 2026 17:50:08 +0800
Message-Id: <20260311095009.1254556-4-ziniu.wang_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ced6bf67-810d-44d8-54ca-08de7f535942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s2ZPBaU4uBDdayS8D416Oe5gppqGAQR8f4O517OaHzeOSxtqPfugn4gnlP5S/ATnq+GOY3BH0o2EAPk2PfMeJBvzBZnNNYXA6sMVWrPNmUkIBwDUqkhUfKnYQPVHJlWqzBDEsSNwEavpYOPjos2hUL1LMbBRNRt6wtijz5GO1NEM60NxLgAeAeLi2C4Lp1rse2Rntd4RgZhnYknxmvOmnHMT8wd2Lrgj52kcfJo6Hu4cbUmy06FYfbxfWBYrRpTYIPwvGNwTKeIEfPfDUZA/ECGL2inEBVIA1myv5XbZtHjJUTE9X1BgryVstQEvQp8JUTqTBUQ26wlEQbBJMzINeItHybCGXVYHYsoXc+rGVcQuUfWsRBMwuHW6EOzNPSAJJuoK/8kGXz/RfOe4EkfwzqzxEmiC4AwyQdf+MtaqDNCAm0xu2iKS757B/NMVk+8oZCAwElWyBHm7R48M63y+/105elCL5toDuTqIZQDhlqeA0Uj2acCPBznDsREt7IzNJ3abzgCiEf/iLugK/u6V4H53csclzuuBgmxJTLJEUpLUNWkoNAPcMspBWdzNmIX563HyGgQaIB0Us4Zi43tk2GXbx6DPjoXsjHuV2Mi4DEnJjWBU1FUkEJHfUzzHZX3ySZUNqjcZpiwAePARdQn09K2267aovmVjPw1P18IQXaNjKlnaOfZ31bS6/9nxeJOSMUZYnDKEV8oKLOrV+ojCG24nQFFtWSRcPcga5N+t+11byIIFRiB8W1X0shoaovvldNLDplTUmnC0MWM9XpoR2IMv6hfTpqciKp90uedkDKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvALW5FFYgQUANe/XnkmVtqyLQU23mxesui3sPwqoxJ5uruU1Ct5Xtk17iyn?=
 =?us-ascii?Q?i6SJnFcVYzBOCxskVXW7DIAhQbvIzL+9kSF9CI4Gqcvnqj323yRzRfvXzt+U?=
 =?us-ascii?Q?Egs7CllzX9iNlVfFYivcJmXdLbgeQxX58HN47dSQUukULERHC2e1XGuthkGs?=
 =?us-ascii?Q?SxYEfO2S6qDzW+kFsx66Bh/NtRmkgAme1+8qNCApDzqIH1W45BEoywdRIpH4?=
 =?us-ascii?Q?cNqpuIHsMSAj6+UPFM9IsEM8yZAB2uX2vJSRa9YicY6kC/i3blRYcoUR86ng?=
 =?us-ascii?Q?W40cQ87HpZ9iTUmzvLCLyb4XdYY7esoqVuyts6HEqFO8ukCePUgXjvNc3X4H?=
 =?us-ascii?Q?vWTjElhOIkU5ddQn4vMft941rmCsnHLNCOW1llKbsTEuvKbqmXWKkZ1ix34G?=
 =?us-ascii?Q?HDI+gRh4Q82oYYAq+GNIZWyb9zkfjYmc3MJHrUyb38T7AqaEi/4rGtDXKVhV?=
 =?us-ascii?Q?wj8SunA4sJOxzuMWD/o0g4yj+gFirTmJFVQK1GhUgTDB8tmU1qY+K4roNomT?=
 =?us-ascii?Q?xOsXkFBtAVSH7CVlXJ/AXY2C2vqhQA0zZxXux9vmyfPgZuALIBRsL4aHyLhh?=
 =?us-ascii?Q?O1WSPbLrdZKIosxBEr2YuwEImhukKbQFcNvabqvpt1MDjsB9OYYddzKHHE2z?=
 =?us-ascii?Q?wIB1Jy4VfdPRFd91fG4bJh9IQ0S8huhKDM40iAwJrT4eeei6bUvlxAW21zQW?=
 =?us-ascii?Q?6z8ttC90MCD1x4Vf5Q9xh8n3sydrdWi4pEaAjG9ZjzIJDRpmxdrG/0yenkI9?=
 =?us-ascii?Q?0Gr8xOHdvlHcTfjl6l+H8uGJzMAzT2hOS6GWPuqsYUQuLJTjTjf07bpXGCGS?=
 =?us-ascii?Q?khhUkQkxdLD8S5DCeQxlcueu9f+yTl0RPPfsOue+ZMjL5DQcPExKmriZCXrG?=
 =?us-ascii?Q?dqohev9H5criDVkkijjKqpuX0HuDLMSRz9/kAqQrpvQehZTdngRpO//JcmPx?=
 =?us-ascii?Q?75Q0XQZFM4r4/fdsjJpYpTojEQJMRXiqHmLEu5KfI4dDLGCtBfPaLDLc2Hdw?=
 =?us-ascii?Q?VBfR06FJDDdd2uuEo9kJv4sqeUmTnFoR4a0YEO21nxvfoVdsLnHfdGacCzgX?=
 =?us-ascii?Q?AfX10MauIF3jyNwRiqJ1JnoH7yEnWNoJEKfUZ2tykk3HAn85UchKZuGYzPgJ?=
 =?us-ascii?Q?DkQRZKsC9BlsIif96qs+oSRF6J/ltlrJ89aBanT4EtukJa0Oymo4ETw2+qVE?=
 =?us-ascii?Q?HFIrydE5mBC9L/fVIp9HsUh4CDc4HJgHBepoFJPjIRT5zQrQJC2zE7N4f//Q?=
 =?us-ascii?Q?cRjLBDbPj9TKGXiCcQWNdd/oAP+IoK3VAKpBbZPG+KeD88FS6oJuZJDaAArT?=
 =?us-ascii?Q?VwGUf20aq9NwWBgX/RflPnl/uhem1cBu3sROToVuCQaxp/qmPigJvTEM/ZGK?=
 =?us-ascii?Q?jd1M9BSGA/hBkJaw3dTiY3oYwBa/r4LINGA4zbeD7XG+FToMsh/U+xYRa8R0?=
 =?us-ascii?Q?t/OKLngTPVs9PiaqzvTFY8SFoqXZ8eoiUfHFeCpmIvG8UkmcfqRCptYuvLO4?=
 =?us-ascii?Q?Xw2IpeYwzNLbMzHlAuRm+Mc0hmnGZTWblTX5jzl+xx2gd+5AosP5qP22rPdE?=
 =?us-ascii?Q?F0oqBH+g5oD7An/0e6MtECKQEadR6ljx+NfaLELQUZCMoB/tdnpx2Gq5uQSM?=
 =?us-ascii?Q?6ma7LtXosCqLKtSXMVJU2MiGF/gk1N2WnUfUZoY80QGbTGCZMsj5VZblicG6?=
 =?us-ascii?Q?E6Z75gxG6f3eKrzqlHPOtj6IWgthTX0VD274UIFhvDnlbvi+Kb8efPec6wRQ?=
 =?us-ascii?Q?RHSYO087oA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced6bf67-810d-44d8-54ca-08de7f535942
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:48:29.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOMvcr9Kw0G0uivquMwjkRnMcKnoKM1ujg/x9z0nA+ws68fd9Y2YigAxHWO/aoUzBkNefZci4zea5P/nu0PyBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10607

From: Luke Wang <ziniu.wang_1@nxp.com>

mmc_validate_host_caps() already validates that HS400/HS400ES requires
8-bit bus width. Remove the duplicate validation.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b607d4ffc562..d49069986efc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1833,10 +1833,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	sdhci_get_property(pdev);
 
-	/* HS400/HS400ES require 8 bit bus */
-	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
-		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
-
 	if (mmc_gpio_get_cd(host->mmc) >= 0)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
-- 
2.34.1

