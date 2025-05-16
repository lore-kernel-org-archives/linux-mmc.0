Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAF2222D5
	for <linux-mmc@vger.kernel.org>; Fri, 16 May 2025 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376628; cv=fail; b=VdOBg9xPr91SBDe0HBOgysGGdCjj9d75pCarPpds6LIcejic2l9YrluTWzvZvTggTW1b9cgSmiPgj7PSADvRi4CR5IcE+hJqFn5X1i0I4B8Wt7Vy75pMDVlGiSQooWOhszJV6MZuo7xU2FV9RcxeeIn52sXcmcwlRtocsFn3w98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376628; c=relaxed/simple;
	bh=rMH0FFVdK55RgzxwRjs1oxXTI8ZUgGr3rd8P6tR8jbU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HUP8IFMvLyX/0vfJnYSG/UNoYExPv0mOfL8l6mTWmn6hZq/F2NlI1jtDnTOzSEgzcukzMfF0SvT4ZGUK1TK2/QFI6/8yoX5bfQFOz6ZCGfM0umqE7LzL+0j5oOocL+431hqHMLNH6bebcTb74kWO6jf47BSLyHQGjeMCcSAQvY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cB3qFtmB; arc=fail smtp.client-ip=40.107.249.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cB3qFtmB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEYBXSmQ7L1/p3tk50GH3oXyoC3ataORcyVxFcwewqK17Xy9MNnKnIeVjkf2Ln1Moc80fUUSmEeF0gnwMSX9lTQCjnOyPORTTmaHwv0LqsZn8aVQA5C3Ev1EC1aPsonnas16waIr6nLdhqBsJSCfi+5odstwLJYduX9RYs8iTYYx/KEMb5WeD3C0+6/39jGcMnR2k6QywaaJCpznHyNnoJaXz2SOnSYcpXeES+TUv/b//yYAXq3KPyY9cTiPrTqzotbXrwDhW113QVaZT0L22yxD9zFR4goko4IuolcyKyAg4/26BIqkqEd92YiGUp1MPbCBchbf8QksfeMuwGCWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRuBH5XvIomJglioziitLxp4I1DVGJe+IGRh5LfIDno=;
 b=XuHHKS/Mqwd0PyD5edVLqzv0ElA9hM4/9KgW0uTKVHYbv9pK5ICXF9dQII8JslNI+nK5fddfpZPNEtTtUCnmeoKzRnxiSzJY6Q77YMeH3IxYQx/Y+8/4cd/6bCVDRRMrQb28gboCJrRfzZxl2zyzmA/2gNqRNhxRBVD2dMDAYVcpV1D5OQWVcyjIBAweUH9Xu2RLshzQmeBHHgvHt59mv1EbtBHosF6i7cvrFcTUnSse9FOtCRtIwziGjrkzjr/ctxcaFUCizO1JveY0PyJ2H8dbUJP8ATCxVq9U9D0pl984cDeWSDHNEH1NNpZNquEFAInSCwNJdq7jkYDeYcTrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRuBH5XvIomJglioziitLxp4I1DVGJe+IGRh5LfIDno=;
 b=cB3qFtmBlCZyNiz/s2l5qQe986MFXUYFf7lTQrmUpn0D51Jm1YgwC6hO34UcqJZuPINYerlvFY2+XfDjoCtslGojPjxBeJF6ArGN200gvOLi8GkKkI0Iy27oS4BbRJoBqwuPvnTMPl8YI4SZQX9xVsI8lz6tGEfS8bjMVCIEQQcQli7xqP5p1yBBgFzNY1pvHwwRnsOiQynlQaxQBfm5ftHDZxaabupuhWZlv9z9Fnej7rlT5zDmI0mWDB1+pHjipLeHxeeIpgViMT83P7s6rO82vy/VkfkX7VzERO0OaqZxf7VZY8wuA4nB2c8ncNFhQBGH0Gw+LGBKgtbxZN8g2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8636.eurprd04.prod.outlook.com (2603:10a6:20b:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 06:23:31 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 06:23:31 +0000
From: haibo.chen@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	s32@nxp.com,
	haibo.chen@nxp.com
Subject: [PATCH] mmc: sdhci-esdhc-imx: fix few build warnings
Date: Fri, 16 May 2025 14:24:23 +0800
Message-Id: <20250516062423.1408380-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM9PR04MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: f18dc9f8-2826-44c3-a05f-08dd94422dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dq7K8KiSY1rtgCJBIFdbEwrjawF4o7yMA7RNqjkEtHlKR4qw9kicQ0GBUSzl?=
 =?us-ascii?Q?EBYWQlslgwM+zrgxklNQPhcuhUUtR4bv5Gdij/pEFIXchZg4ZiV/vYGI0sti?=
 =?us-ascii?Q?UvM3NtcfbWLBkjwWkCe9EoV7whMHBegkqNqpb9hUhGd9bs8oPadlGiQ9KwZo?=
 =?us-ascii?Q?IznYOc6nCgEynZF3cOi0osaCCCnEfRGWxLK2M+aPlxPE8t97J10EPQwI7xto?=
 =?us-ascii?Q?JszZvZknVVyA39NINC1D7cbxrwwCCBAiab/SEhuYyuSWy3yHr2vMRpcg9f+C?=
 =?us-ascii?Q?Cmh+GuksnkFxqwbPrqsJotA7u5EYpRsLGU77u5yvbR2LYAjSlh3soUTV7/Yy?=
 =?us-ascii?Q?0N4k5PjeiGfrM9iZmsCCnwvu99b/w6O1j76A0KUw0LKif7NWMWlzn2IOfFMo?=
 =?us-ascii?Q?SsO7ckrar4jf/CMgAcWoT9Dja8KjFOi/SbtgD3AsND8Ue7qzEDSeP/J9vUMz?=
 =?us-ascii?Q?J8hSqwJI0ZI6HMVJLrfVGd//GDD36Q2k87Ti6jgiAv2Lgu7h2lX0u18IV/LW?=
 =?us-ascii?Q?2RxDulZojSqJ+SOaTtB1Co6lCjU1dwnriXdq45yCLkruokhtfOGGbrT1HPHX?=
 =?us-ascii?Q?mVq8WKsPpFzxPwpOH8oWidWqDjMBQRAWbHpkfPwTdg/x6vh8Fbu4h1LTQn7C?=
 =?us-ascii?Q?Eo9Xd0gh2Y4WO7owNJbRPojL0ccHU8jRXupgiFaWN7+6DCI8dFFbuqAYfjXX?=
 =?us-ascii?Q?6I6T9t+0tTHxmKbdt6QSmd02UaYv+Ei7ap6Ano1wQHBCketvl6hvDbGXW92G?=
 =?us-ascii?Q?aQrCvLz/pna/4+LgHWuHOC47p2vsSsdm6iLm+vI1tRSkHW5l14toWH+nS9Rh?=
 =?us-ascii?Q?YPcVjtQslPHZr4f1a29BT6LBe0yWV0Rlt1x723jBEAs1WHXZGlCfR8c0wXuP?=
 =?us-ascii?Q?NYLxscU+OCnOCSmGWx6Xz6RPp7EfygEwFn6vTIYecatkBw/0Y0q7M5LH5wjm?=
 =?us-ascii?Q?vokI/OgdsWg7wE2yI9svdVYaUur4Pjjj1NJACi1K+5KYmRv91O2nEd4/GAOy?=
 =?us-ascii?Q?EkyCkycyDdQeR9KhdMzyWo5AdOnTmWD/kgeDnxofOHd4+ued58jbomSVCLtK?=
 =?us-ascii?Q?nDQVdLfAf8oZ7mFokJW6eLZN4ynHHfTHMo1+kcRiZ2zv9RJqu1mF9vRM7TGq?=
 =?us-ascii?Q?ekf6EX27p1CInd72szvyK+vRPlyJiLd2kecJPs4yp4EcPugqeft8cQgLMhCh?=
 =?us-ascii?Q?IkLowkR48zU8IvKADt9jHHndmapYzq6N4QC40a7rbyP1GX5T9KFzZrGvhF3O?=
 =?us-ascii?Q?LAZlXUgFr+RPrRIBeLDAllqZQdWum+a8/cCX29SuadCCKRJmL3TCvXHaLSoI?=
 =?us-ascii?Q?FoYUEdVdablDXrzctZZY2eTZNlkVs2N8I0D0lQMtDVZj45hOZMb2Aa5zAX8k?=
 =?us-ascii?Q?Zlvjzkc9X5dYnZooyeHnsKwUgzNHtxj6LhLeMk0DfDstcu9jrFxxSd76/zFH?=
 =?us-ascii?Q?UurZQ0EK1SR+MF4Lpc7UKwynxO1EP9ODy46D7w/C3Swiv7Q9hFFIrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ShVo7xo/xKHL30hogeSpUgLgcnhu9xQtG2gTJZJN+XDkGmFqyBNVp26QbPO?=
 =?us-ascii?Q?ukEPv6FOUmqYBFdhVadEbA27XjDXOO6THC83REnl0LzB0pv8qblFAQDU458i?=
 =?us-ascii?Q?qRCLQ5ofgBbQuHdnBrRC55g8xWFCcf/67klpv4OB3YKl7pSmOI0eKS8CYauQ?=
 =?us-ascii?Q?zJlxAzGaltXBY1erK2HbaJgwdvK3JAA1gGwg6zoica+D7AO6hirvqsGjVJDD?=
 =?us-ascii?Q?shmYiEEgIZSJdH5BlBGyrEh48fzVIk1iwO507WRiPhTeDx+kZB99gq5LUt7N?=
 =?us-ascii?Q?pcxZbIsgEyuhATYqLff+6CQlT8pMsc1Wkkuf7u69YQi2SChi8VIpS/BHgv9x?=
 =?us-ascii?Q?V+PvbvdMfHHqFfQ3xtg59/L5X7b15e3JZ0qasuWTbP0ci1Y66Zxd+qGn4LFR?=
 =?us-ascii?Q?oFp7tBXmXfEqhw1gP5BTFzCZoDtL3B5yV3wdndK5ge2Wuinq9cUwdAaPhbhI?=
 =?us-ascii?Q?oCysBdhDGP+I4NF7IJbl+/w3nktvsMVr7kKkHgDXzANilkEsVUgb8Lmu90i1?=
 =?us-ascii?Q?PCF5Wc9JEGAnZS9sgC3rvJ/pQeKIY5pq92q2+ZOFjgOVUeWCu2bHRSqbEYrG?=
 =?us-ascii?Q?ZAIUU0FBG80fnTc6M5UXLFKzrhOQoZJ/wBVEHAjtn/hCRd8GsHVzHQ2M2vfu?=
 =?us-ascii?Q?zhmxD7Lw1I6w4wbHiJ/T0PAJo52sTOEtSe3I8V86TRGm1qgqyO5RD8NMWXcK?=
 =?us-ascii?Q?fXhX45bkCMvOZLG6aFClQ49fG0tAA7Gztq/pHTSJeiE0vlPtGC5x8QHyKQDL?=
 =?us-ascii?Q?fwAg3rSxpVXyPiahBaIYM+vZdFeoD2QxLVmMpPo6D5TG5RRirvDM8SGh+jKe?=
 =?us-ascii?Q?EIV7b70SqSjkcKSnWADxfeGVxSkXz9tVYIB50p7R/jsjow1NI4AeZjp+n+kc?=
 =?us-ascii?Q?z1LJG6TNu/Z7KW637xO3QiRGIdiXMmzkB22s2FCGeabhGKg5yLGhE+/Wp9E1?=
 =?us-ascii?Q?U9lbg0aHBqSw544lsMd7dkcza2n41kv+IutcfDSEcU88gImi/pNhQhiulZF7?=
 =?us-ascii?Q?PvQ+bOyt3eOP2xL/Hk1gWCjTDQ2eNWHb3yF0zC4vvXTC7+XVj7R0XCVnRrdD?=
 =?us-ascii?Q?wx2HPzH0lKYS7Qt9PSzoCRDAA89l9JNJyut0w3r/PGj/IQhKDVEYm48ITRjE?=
 =?us-ascii?Q?/jbZ76g/Z6PC46TtJMM9oMj/X6EJix4xzEu7anE1UhKZWc/6C1GPH+mCpl8Z?=
 =?us-ascii?Q?ygSlAz+YBfseELTDxRP4rp8Wary8NeKdfFvLvzlVrCDuGdcZjIsD1PErQOPD?=
 =?us-ascii?Q?dxZ4IAXjKb5ULnmsnvvYH8huctZ24HMbE5Rta4XwgrDfv40eA1KTuXAuIglA?=
 =?us-ascii?Q?VuGlwhtl4kqMUyh2CbIupxPOoDKs2cBy8GHBo6yLfAizN2B22Lqs0iExnDzj?=
 =?us-ascii?Q?01vwu/0c8s5EDZTyxTPQUp1tkYyVtNotVoeAFw2Nfa/oZTKMz2kacp7jfyNA?=
 =?us-ascii?Q?Gpl22JgCRxJ5a2Fw9HIA4Ba2i2v2ML4DvWKwLlhYqoGv1D/j/RT7tHgxfb+a?=
 =?us-ascii?Q?VJP/SfxmViXgzvdLBlw65/0Tdev1fn+PcnyXphqjSDIOi4KdUZjv0L3yiNWb?=
 =?us-ascii?Q?2/6tUJVSV3eySZFFdIouA2yWKCU1NzpnrgBq2d79?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18dc9f8-2826-44c3-a05f-08dd94422dd7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 06:23:31.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHwSCnM7Th306IgjKetX1XtY4YBLD9zSM2IZSVVBYt0/5f75pDD/xTnTQp0rH2p2453M0lfXSJhMz9n6rPEXPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8636

From: Haibo Chen <haibo.chen@nxp.com>

drivers/mmc/host/sdhci-esdhc-imx.c:1566 sdhci_esdhc_imx_hwinit() warn: inconsistent indenting
drivers/mmc/host/sdhci-esdhc-imx.c:1251 esdhc_executing_tuning() error: uninitialized symbol 'target_min'.
drivers/mmc/host/sdhci-esdhc-imx.c:1251 esdhc_executing_tuning() error: uninitialized symbol 'target_max'.

Fixes: be953af79cc6 ("mmc: sdhci-esdhc-imx: widen auto-tuning window for standard tuning")
Fixes: 541a95e64d76 ("mmc: sdhci-esdhc-imx: optimize the manual tuing logic to get the best timing")
Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
.kernel.org%2Foe-kbuild-all%2F202505160225.Csr5USfq-lkp%40intel.com%2F
&data=05%7C02%7Chaibo.chen%40nxp.com%7C2653112e34c94691a75108dd93e34a5
6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638829326610115371%7CUn
known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOi
JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=1m0RsAsU
wxLde7RpCDx4nHJiBrb7pfJu3grSFASTpbI%3D&reserved=0
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c0160c69a027..741db169f44d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1216,8 +1216,8 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	int win_length, target_min, target_max, target_win_length;
 	u32 clk_tune_ctrl_status, temp;
 
-	min = ESDHC_TUNE_CTRL_MIN;
-	max = ESDHC_TUNE_CTRL_MIN;
+	min = target_min = ESDHC_TUNE_CTRL_MIN;
+	max = target_max = ESDHC_TUNE_CTRL_MIN;
 	target_win_length = 0;
 	while (max < ESDHC_TUNE_CTRL_MAX) {
 		/* find the mininum delay first which can pass tuning */
@@ -1591,8 +1591,8 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 			 * wider, give auto tuning enough space to handle the sample
 			 * point shift cause by temperature change.
 			 */
-			 tmp &= ~ESDHC_TUNING_WINDOW_MASK;
-			 tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
+			tmp &= ~ESDHC_TUNING_WINDOW_MASK;
+			tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
 
 			/* Disable the CMD CRC check for tuning, if not, need to
 			 * add some delay after every tuning command, because
-- 
2.34.1

