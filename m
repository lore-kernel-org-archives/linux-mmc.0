Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4A25B66E;
	Wed,  9 Apr 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185302; cv=fail; b=Cq7B8xtA8wzOi6rAwZFkRcC3wqnk+oO0B7Dv1blTCRXt23vo9xU2blfUMVIy/xr2xlT5o2wUvyRGaOoHxNMwIL5YYVYmZ+5D7cOKxk29KC3z5bKJpW76PWGhs4Y+AfBjGAix2Q7tMHorgskpp62W2Njy/eIPZ3fp3tD+tDZAYaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185302; c=relaxed/simple;
	bh=AzI8sP89lOJyn29k9Cfl9kOJrRIGwzxy1UPsMh2XUNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1UIPA5MqVx6I0iK22A0+TPCq2XNpG2F8lF7e5A+C/T7ThKAY6x8LlAghboeflPRv7MrMklHCM4yI85UEx5RvNu5JDcZEPJ36XHnc4ftnIF1ZR9he2wEzgf0IM13XTs+XMlM/tuFizEF88PqxcxIP1WVbm6yzC+Sn/KwGWl2guA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BspbQV2v; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BspbQV2v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFksXRHrHT9Lu3WDukF/aiA4kzR8qOXpRDbsrZ0SNn6yAX19dZiGbC2JWyPGIOMRGDS4qXGdVzKRG0rgpcTNne6WmsZdeD+mu8ydnyzBmseQ14zlzyo9v5E3raFLEqNTDUuM8AIBaYGxj1nLK66vV1tm58tSRRwk7fkT+OJFo3Uj1jH11r6aP8Rcdz2owKW2pUCEvWtHLC0AXVifOntxF8bKsx/06QgNj1m0FxV3Xfv9VNRQuT5Qvy6XwJeyJ5lMsDRyDB0XD+KhRiLbHAwx/iSGYgIn6AAfPkNBrKUGlz+k3v6LvlLJKO4K9GrHvf7al/Ly0buR9iuHvRdXSB0Usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoXx9kc3EltsitFWaQOSi3FJBHv+/d+FmYG6pkF5+aE=;
 b=jVo7ykQduasb7ErlbuHPuGe267yGD1OYcq3U8XJcF1yaZvK4F43xwxmXYRH+/vNQjyZ6HMpW1ptCX2SnRaKAuDVrV4rCCiGGyBlCT5ys/EA7/VLRKbw94eHJ/ms8yqhTwIdtQZX9/tMmH2TiZMURzSVaVkPWTOTtzt2SAvR8kp8GMaS0AKH5xdD51WmZBHRLJGmbq6EHNBAUg8nUWDyKXoPQVcVXIVS6pqZKDG6XpcyObXnEfYrWAYge6M7CJk9Fod/neJIxCQcoVslGaen8/eciCcDWn5ng8+wU2/nKenD1jm4A83K5jOUat5kRZrwPwyBNxJdHNQfje0oBiJbbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoXx9kc3EltsitFWaQOSi3FJBHv+/d+FmYG6pkF5+aE=;
 b=BspbQV2vwW01ENP66+BKEiDLq5VUym+Z1LbOgVT3+xk4kf8xdaSgu0+JgBlb3iA6EzPiY4+mCON0VnsPxXleyt4Cs9F1m20FPlovoehVeeoW7WMqFkMUunGbTi/8bHOiz8Hs97Ce0j3tD1YgMFyGeY/5W/sZVeDYMvGapUpBYvlgsqSapbWRnGcVMKX2c11FvNE7YdIAcZ6x2I2Tfn5m38hs612rwkp4ZPFY1Wv/1lrZcxOKKYe62U0qdqOKLXFBOkkwR+egYel7PDTeVKeCSWO3p/L7cTwH7a6vllb982ufZzY4X+A3+mW00bZh74nK96qXROOHt9BVJiekCZP1IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM9PR04MB8196.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 07:54:57 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:54:57 +0000
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
Subject: [PATCH 3/6] mmc: sdhci-esdhc-imx: widen auto-tuning window for standard tuning
Date: Wed,  9 Apr 2025 15:55:47 +0800
Message-Id: <20250409075550.3413032-4-ziniu.wang_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 62d79abf-71ee-4b81-aabc-08dd773bd272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PvBXb50+dO+iLjewEyZPAR7iH1rt0YdbadN3QHlpaPLjRpyZaSkaWtPxka+?=
 =?us-ascii?Q?CAb8JeRqe+XCbrJHBld2C/5S+tMrAoNxDDGMdo05UeFTUxtaYF2YTdTzGKfp?=
 =?us-ascii?Q?pE3pG3Dh/B945bO28wKlZ2cA2QjG/+SbrBumlsXc+n5kndCfvmezKcFzBk2h?=
 =?us-ascii?Q?QQy1nn72VZ8TSi1YINQ0LzW/3eaE9wC9qBJSmdNhHhaGiEK9T2+p9btjw3WV?=
 =?us-ascii?Q?pZo3Voryx4vw1nK+5l6T1z6tXicdKmMw1oMn3301SXcImDCzRxlEc8rTM4S7?=
 =?us-ascii?Q?sVL9kntWuhwlCBASC+HvqFHg0GY8BM5ZbrAUMRnx6qWtyaEtHgzHDtRPDSk5?=
 =?us-ascii?Q?UbxyJ3czYPLGqpr4El0sQpcqhb5/kfdUxmvP8ksHhyydFuhcML1KyC7wa6Dk?=
 =?us-ascii?Q?Q/AA30q4UGkzBmmliBD39obwa0D5QsMf3fj+oQySAJ3IAzvH0JVgDzMIDN/1?=
 =?us-ascii?Q?u7gSlVzsvENRW2OtjkvBpsUUpXq7zDOsRoa7unokQ4VS/EQFbsMWseI2yfiu?=
 =?us-ascii?Q?5pal1dkdReFWb5NnGuL2EtSMgfmFtNr3cGAuu4K1NO8AweeJp5VH2mGrxpfZ?=
 =?us-ascii?Q?ye8MRxkIsVRCbjrkAJJxxA0G/5ofaDDBXyBGWdPP00fEyBFxzfwYt6KzX+P/?=
 =?us-ascii?Q?tBtxD1sa65DvKl5E8ZlYBXPHEXKHhw7clmcv2WG2TDpLv3VtWAcE5lYowHFa?=
 =?us-ascii?Q?qebqDdQX4yvcbBSGePxr6WjoKWpgpLqMNYGA8+Rgb88pV2FCJ5S6sQjCdoVe?=
 =?us-ascii?Q?XWhi4dFyXKCfsaVDD5XWcce/75zSi/988IrYa0Zj/2dS5sjQ8jdNj0muW7eK?=
 =?us-ascii?Q?IUCPYNThDD92yVqL/YceOk6l54OW0/H+hUen3jT4LcTY1900I78No49pqVQn?=
 =?us-ascii?Q?p1YUpkFEXW7H/xZfeVBUeCrgaG02BmBSnlDnsvERHYmT5m+T4+s4LoNohiFl?=
 =?us-ascii?Q?B1wD+ihnMllm9ys4S67xLXCSN9GELauPKd3O5ID4i9YPSRSEP6lFm9/bgHGR?=
 =?us-ascii?Q?aivGKc6I5arHRcs2WyaAHVuQNoIQ36sh2KBkedZZbk7CZAbb3xrvlBP7di27?=
 =?us-ascii?Q?9BSCwaepG5/5uzFoUUcv+yk1UQrk89OtNDC9xLHBxBG7tA6NgJkNjo++o+x7?=
 =?us-ascii?Q?pjIy/PDzGmT/HsZwKOVx9jHlIjGX0RmMVLvCwuO47GwgtC1S6Ohl2FEUoCp5?=
 =?us-ascii?Q?YFYJn3iJxeuOuM4awIRlKB/ROfPxCefItBmq63aS8gL/TNnmvc2WlmY5k6F9?=
 =?us-ascii?Q?FLOeBOogqHrvFbTF/E0/qQLm8Ze61wrdkC37CNKTSiQVBnhMN/w27B8SU3IV?=
 =?us-ascii?Q?yN/b5wuLiansPCuxwW1KMDm/yYpOCaOSMCe2wUco0sl+vWi1y1E/LAjKqlcT?=
 =?us-ascii?Q?dJa+lPt/OR3fghr3mEXS8e93agUDECTRLXfFhrAws6c3g6VztAKZCXAEAMe8?=
 =?us-ascii?Q?2dPTWz49Hx4AUqDj2fl1h23tWQtduIl7m8ghsPQb5k0V5JSgEovR2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vlqzN+TdgRe9dws++ZGSYi8XkPPjTPteneHg9vrc3CtdPC2P8TC2qkf5rZ5q?=
 =?us-ascii?Q?e+PTdN0Nnv3vCEq03UZxdd89QMujZDoy0Ws1PCySEbD/myFSU3/p9vcAu1ag?=
 =?us-ascii?Q?cZqcvgyoumufW0PKR/Mac46TNP8gMbc1GM+PYU2pWKVOPmSFOy/5X0HXL94r?=
 =?us-ascii?Q?b4Qanl2268nuBWmr4JSZkzoh0IOslS5XpjdITqq9wzcJk0DCUqLqVUaHiGfM?=
 =?us-ascii?Q?YFRZnqj4TGONhODXvVTWCeL4N+HdtBVwXT1BM5WswaApM7Hjo733yXZCZg0Q?=
 =?us-ascii?Q?koPrBbwHdenP2h8D84xaX9N5Km612fPST+vi2/OKkDN9BLFr6A39Xcu3tQBQ?=
 =?us-ascii?Q?YKOhyNvQ6m3qJQkzrK9ldsIzompviQBJd+vBXg0TxJNIaqL0XxDAffgxZsGF?=
 =?us-ascii?Q?5JP57B63UV7gmKDvZha7zSEpm70xX3UmRWb3E9VsIFenJAQlJ+rXiCq8j/Hu?=
 =?us-ascii?Q?8sYy3tE9PHCVJVPrW5ELNJ6iBz8somRVkB4wTSpTaZ5eQ4OEqRtwDPgYmAGa?=
 =?us-ascii?Q?nNvV1Q0IBrtoec7l/sTxeueoWffOX/L5VMKUDdh5QYDBarC3Ok68LqHaVRME?=
 =?us-ascii?Q?jPvSzFGCz8bqpH3Lhj01ooCmfrUMROv+3REm5F22NZOo6ReQRAtJszfUDsUP?=
 =?us-ascii?Q?IsCXdg/OJKihLg9F1bGFRUVyOxmxzOKceptOuODOjsotZRzMF7JifhDy0hHb?=
 =?us-ascii?Q?vd+b2bUwgwmT3Jl6pjrppznLeNsAjJGpU890gg7DtvcKu0JEAz6xYXgBBRxZ?=
 =?us-ascii?Q?s1I5JzDHOv9ELY+6jRL0WZnPfiul/xJuVfW9kqS63KPOu+TeGNt6LJdWN9tA?=
 =?us-ascii?Q?w7V/ps3VLFZa8KQNMRUd7aedLQiZL9GvDS+A1o3LHVlEIc7ly9RsdUMikucJ?=
 =?us-ascii?Q?Mf9BmP/sV1EubjQdNRAwXFyA3IRNxr2SfKQytsn4WxKv76ySRe6rSrjLivIN?=
 =?us-ascii?Q?5H3kCI6B3EtOtfaPtu0mthgc15J0yA58kHM6SZMti+0O22Vq11EEecdMhG4z?=
 =?us-ascii?Q?WEYKv4kABFGa8dgTpPeZbPAHhXWW+/JzSLQ+ZM4Q0zWQPgwmQdy2yD2tnU7W?=
 =?us-ascii?Q?WInb85Tf5Ip32iWnbSs7NMp7VaMaYuWNfFy7EmYdz3ra9EDnYQUuq6yo4I+W?=
 =?us-ascii?Q?l+O57EhuPmjNeeqj6oYqShKx4stJ3iOWy/bb+utVBp+yVF+JdlEsi3u1Ymcx?=
 =?us-ascii?Q?0QJVPLiXTqzcACnPoLZHq/fzApuyMdjUv16qS5ExAeyOJrJccK4BAm+b2kqL?=
 =?us-ascii?Q?9F/NkdiWGT0+os3kDOh12PJ+1CHSyCH0nHuNUTyyE9zt/cgp4lkSXJQSazJQ?=
 =?us-ascii?Q?whWuXOeTvCsV++Nk+T7Arcg7z/MCLxkNweT4WG4cGJJHdvJDAFTZOXLtgp9/?=
 =?us-ascii?Q?hwRUhl2rr+NklCjzoacDIgg073nyXcHiQW1ZWC0Ug0oTGD0k0/JOIzAsizDs?=
 =?us-ascii?Q?PaBUX3FQ6PAId7VDmYjM0KZBwPUl2ocgch2xf/JSaLKuwWomFRZ/5eBJVsdO?=
 =?us-ascii?Q?Di9V1ZSg6VMH4b1Wyizs80f+pbcpFh7QGvGs+k/AYwt/SFn+iW63Mji2lKWX?=
 =?us-ascii?Q?o39aWjQh38rtsOG2yWmpE9xEzP9Y3mmXwC0CzKwq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d79abf-71ee-4b81-aabc-08dd773bd272
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:54:57.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7todKG7Pwukawpy+O1pXzk8m6wyii/hlyw6+EKyB3tM+QM9fDOk3uso2OEz3EFQpWfcCu35UjRO2ZCypianh9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8196

From: Haibo Chen <haibo.chen@nxp.com>

Expand the auto-tuning window width from 2 to 3 for standard tuning to
account for sampling point shifts caused by temperature change. This change
is based on hardware recommendation, providing 50% more margin for the
auto-tuning logic to locate valid sampling points.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8528aa6adf02..d91b65439544 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -108,6 +108,7 @@
 
 #define ESDHC_TUNING_CTRL		0xcc
 #define ESDHC_STD_TUNING_EN		(1 << 24)
+#define ESDHC_TUNING_WINDOW_MASK	GENMASK(22, 20)
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
 #define ESDHC_TUNING_START_TAP_DEFAULT	0x1
 #define ESDHC_TUNING_START_TAP_MASK	0x7f
@@ -209,6 +210,8 @@
 /* The IP does not have GPIO CD wake capabilities */
 #define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
 
+#define ESDHC_AUTO_TUNING_WINDOW	3
+
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
 	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
@@ -1560,6 +1563,16 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 					<< ESDHC_TUNING_STEP_SHIFT;
 			}
 
+			/*
+			 * Config the tuning window to the hardware suggested value 3.
+			 * This tuning window is used for auto tuning logic. The default
+			 * tuning window is 2, here change to 3 make the window a bit
+			 * wider, give auto tuning enough space to handle the sample
+			 * point shift cause by temperature change.
+			 */
+			 tmp &= ~ESDHC_TUNING_WINDOW_MASK;
+			 tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
+
 			/* Disable the CMD CRC check for tuning, if not, need to
 			 * add some delay after every tuning command, because
 			 * hardware standard tuning logic will directly go to next
-- 
2.34.1

