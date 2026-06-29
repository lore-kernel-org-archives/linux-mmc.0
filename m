Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFB403AFE;
	Mon, 29 Jun 2026 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724673; cv=fail; b=laioTaqp6y7UZgKdGBqjdPRxkeR6t/UVTuv7YSoVl2UPdzbyVRKAWIdDSYJ5o7gQDQhhktW0dLOEq7LfRQ/z5SDCm80ZP8MyqqJs+MXu+P2crdgZdiWXc62SLhXZU6jESiWQslUjCN3CWjO1FoIIyqMAcLLISN28leTHRF2+9aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724673; c=relaxed/simple;
	bh=9JhnwEZC9H3ccgsmqcRQmwMO9cJXYop65UqeLh/f2qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKWVxYP9nAdcnf42xmzsZfYUOg9DKrELbm/uwJBsCsmOArZj2YugK8mbGFugs3aMDP0UoFHkJDZ08dakqDCkv6LyEohKMtSEsF/KVcaE9SbwAGOe6T97QtZS2e/tAHDbZyyQXimqW9A8Vhmka/I40oHFFMwlg06HKgXjJBZFIcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sH8VjJpt; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sH8VjJpt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HevbOjndK798gGsWGerPth9ZThn8ydL4iPhaTTTTUY2OLOAbPUdjci+u3LrKURklgXqa1ptkGIk09L1i8asZfhCfhaKur8OZfJ7wSgQWjGTHPJRN4vULwOjSdyD3uO5D94XwobfErer1QAcQd9YaHv4EYoRUBVutNgwZdmE4dPHWx7wbV2h7qNmCCKodEO4fKpEU7hGcwk1i+D9QjcdOs8Zm6/5VuYR7MZd1Ua421C/WcbaoauikSIaMBbZMKle/bJb0LBew4jrIJdeze2AnNU7sD69u+nC7g16oiUyr0LWaoRgXFQqlzHLavEJiOT5GVXA//sDvuS8puA3ED8QSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux4kyKhbb+/j4z0gF7nCQIt9DNfsyPoKC2HTRfbaT0w=;
 b=dv6t+bchskZmVo+dtTXD4N38MjP/WQxQwNNf/0vct32EUVk0bAdMcbWGc+Vl2HmCtsfdmDbYkvfVZkuClhBwVE06tKkrJVO0cPxRGDJGS0LUl2lI2blme6RatYkUd7g4oRLjgLXx/IsHNgwbsrifQTG+VooIJeRD1I1YpGg63xNEeQCTR5sUhM8CH4TZZbRVPW3P/uLVTrGesKB7ECyYhjdjcTcu4bfBqesjV8wOspirW4rXQK18MXxc0X3kx+Rpe2pyNM6ufjXONuuvEo7ANdH6FYhWxEEOaiLX58akppiEOLrpCoolNO4SwAJ7PGLtARbQ0kHR3kQ4O2SaQ0Ynzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux4kyKhbb+/j4z0gF7nCQIt9DNfsyPoKC2HTRfbaT0w=;
 b=sH8VjJptdYyxQKaP/ZPZxlRZuwm+6XPpq9CNbjMbc88KeQVP76299yquDxJ1R4HUBMHPK0wc1iS3UEKbXwc/v+iQKrDRQvgSs9RqyffjZhMvY5oDwTZVtXwK6Uug8oIxN/igyDq1/K36ZH3VxFK++4u60+h7OAPsqHnViFSw0aYRIIhWecEQcht0qLT/Ti2t/mARMPNgUyqrXpSiO3g5JUJPb0EbvN/uIw7MaZNX+1aNJH8gjhtAbEfQcI1fufGp8+rD5S4roB0gMHPgrAxvpMSrWwypB5b6s+qRIFkQ3F64X/GPSmzxruZln7WUd2J/Eh8i/976RvnYd7CEYFq7EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI0PR04MB12663.eurprd04.prod.outlook.com (2603:10a6:800:342::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:17:48 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:17:48 +0000
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
Subject: [PATCH v3 4/7] mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled interrupt
Date: Mon, 29 Jun 2026 17:19:51 +0800
Message-Id: <20260629091954.3227151-5-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI0PR04MB12663:EE_
X-MS-Office365-Filtering-Correlation-Id: d023c670-3e1c-476b-6470-08ded5bf4966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hd+e/xSP0eQcItODHVHkfoppMdIpB0L5AAmqENkTNtvfetHi63Ot58v/2mSwBiHNUzGRVO9vGHZiwf8totp2scTUIamjnVdu/HnaSHba+1JiMYHz9peCT2TYJul5i5RA0ky1XqxNXLiaDSqADOwyztimH1byQdBDmR7mOQMG4Af5mVs5s2aU69fM4igyS5vPrDezTeq3L6YXWJ+POapzTSEtutlK0fEwRb3jAt5fSW+PEgJjUYq4ytAO6a8lFmmCBhrv6TATeI94uUQYI94nKlX2r7iJGxIOIu28ul3U760HWWJwFwKAglT3D3pBo7dxC8LGjoaOig3w2OsfdoJ35Civsd6Gx1lVJRhOVz3pI26bNADpNgl/gvhMxK+CbgH3tPulBr5QV7yGxecsZ2XyJtZMTeFdBCaWLR1TMvedO67s93OUNV4a8N+Yo0p1ZTknHBefT2y8GC5r/C6oCQR+GWUtgj0NLR1uzuB+aSgoukFedtSldwfGSZ7uwj3bpWNtF6OZCS2z32mo2mm4kwbVyb40LOMub2Lpk14T751nW6jCNjoAxHASJpZ2Ck6Z/HFRd88FRrXhi0dn3FE5V33OHk2fElu6NK32YijbqEe0jd7JYXmshSTmZWB1h+aPLMjU+j6fppRYTpXzRyEFseYrgZiXtsY7L38Dr/SRVySr4sI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mokK0EC3ODVSXSo43r4LjkrC/uJ/gmLY5WkNGUR9EkposXIGHohgLedOcjO1?=
 =?us-ascii?Q?rGqZueP1/WiUNZqWXCc+3WiCw3q1pfimXSsebXVt2q896hwjB/UoNpIJS+a1?=
 =?us-ascii?Q?CMeIBf1h2xEC0jBGMi+tDex1wJJEsSUUL1yKlw86+GhlwlOMqsm87VYIvsYi?=
 =?us-ascii?Q?Fe7en+kUUpOm49M3TZO5UOEkURZLbcAe8QJCgeVpkuXdtUza5PnjJNpclJiG?=
 =?us-ascii?Q?BrHqQrO84oJYBcLHcZaErOLY6exDO99wR7b1EBbS/uj/w6y6TY28COFqylN7?=
 =?us-ascii?Q?sny4+3KrJ08gCC9sigAE5W4FXt2jCKEKHjmwaSTxFHYPLG10cftvgAEaXSj/?=
 =?us-ascii?Q?4Lwap5a5Klxu+1jJfbp0M+a5ObMWRSp4PkVx1txVp7wbG8m5HvVDJU7V9ABq?=
 =?us-ascii?Q?wB02fArR+LuiP6VwrsnavXnJZMQeKr40pCmyPljC6prW9CnTJ+pPEnv7DVR9?=
 =?us-ascii?Q?crrPnKUC2M4bE1l5hOiwNkLTw2CjvNWUkWK812UeyzxurdzNs4YxjgG7wqRo?=
 =?us-ascii?Q?/AIjQLRYZVUr/TFgDKyizoz1+Xs55J8Hmtdv7uIoWuCcwqr7se9ptFfTlC0W?=
 =?us-ascii?Q?QNl22QTtJVLCC2stx+NN/jNj3zKfQxpBHkV7SnznH//KZ0bE6NzNUAY5A3d9?=
 =?us-ascii?Q?+se+cMy3ZglZyT9rse8rPOTV1lQBfS1XQyjGQI6WYA15YjFSDW7P28X4hteb?=
 =?us-ascii?Q?P1iHILf7KEZ+m6GLYHbqkXaV1NREkvIbLmxuC3qTZpPdKNJEpmycQ2CfzlgE?=
 =?us-ascii?Q?NwSial4AgU2e4UKS5q5ujuwLQDbgjWN/kCz121YawaaSB36Fjf0A/VcGoSnG?=
 =?us-ascii?Q?lZ6/oiZRpaKHkrrggbTmpUtCHwbwbPij0QvvM/quDNTa1yOWQQuB5xH8/N/Z?=
 =?us-ascii?Q?aAXLd7JejcivlMqUg9cA9SJDjcURtokfgbVk8/igPzfbHRIPwhY+Pv6sMLHs?=
 =?us-ascii?Q?qIJgZLLLkeneTpJe5nam0z6d8qx6YajYkJ6RzAgQUlBpPososftek2ZXlF+5?=
 =?us-ascii?Q?q068CARUDQwNTvV/bnzqB/J8JCA5e1ZPROHQbUtsLZa+gZRl00VC8jjK4G/m?=
 =?us-ascii?Q?WZ8eYdN94wbiIeWEbyhhhT21ltruVhYtWAf2PgaX+ChqpA6F7Uw9TcmgvlZd?=
 =?us-ascii?Q?Ldscb0XlHanN4kUa6LuSErERNTaIsV1BL/YVH4qnSH0YwJ1BIPeEhanskusR?=
 =?us-ascii?Q?r+0wpZMb6n9Kg6UiPxaMaLWbKlYzDzCZ1GKlQ1OxgBemW80WNS3ZgUo+/TE/?=
 =?us-ascii?Q?zHVjQeYjxNRsZs1IrMniavIjjmxaMMEYsLn1lDE3BGGdHXaeP39CLzMk4LDF?=
 =?us-ascii?Q?zT4AWfRkezcxdB2qemQFqINUUg20X6qD7ziB/Vio9kVRdusQvzGe4CJm0RCS?=
 =?us-ascii?Q?59/HjgUTtk9HVp1JOddfoannDtWY3xL2+HdSpD8MVgwRZIp59wnb7JF5hAPd?=
 =?us-ascii?Q?As7XaFQz336sE8YKwtibJ8GncKIqvAIr+eEIYeBOrFHlfxYxC9okJUCPTm+w?=
 =?us-ascii?Q?gCYlBAm/qtNG1NOR2IYsiSCpB/5mbdPDDD2LUDbqa38vNNMBLYfZeg2xGkpF?=
 =?us-ascii?Q?s2BPqOaW3X3TvR3AUwzYypMOea/TjIDENGF/Fek5HMY3t6yBSK9edcO/nnvw?=
 =?us-ascii?Q?d7p57RRgR0oi6QaNteqRTpJEtgKufNMB1KG4mExRyz4dQvf1So3xvhosPaQn?=
 =?us-ascii?Q?OugrU1RkITx665Fgerh92f6jQ9pfLQHuBCyiM685TUC8xmtgIwQ6GIRcXwur?=
 =?us-ascii?Q?wMjhV7K/QcoQj4BHSZ2lTYE5roAeRor6SiNmios11abb5LpgVoN/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d023c670-3e1c-476b-6470-08ded5bf4966
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:17:48.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKR/AXu5fN2ynxkdeV7vM4Egl3sOkz/LOmCvY5yy9iXdC0QTqoK4P+6edfrSSmsUmF7pZRElGwIOblEwy+rgKizG1j5MiMZg+QMPCodLHNscqvS/pLfnZPIA9CW25ENb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12663

From: Luke Wang <ziniu.wang_1@nxp.com>

When using WIFI out-of-band wakeup, an "irq xxx: nobody cared" warning
occurs. This happens because the usdhc interrupt is not disabled during
system suspend when device_may_wakeup() returns false.

The sequence of events leading to this issue:
1. System enters suspend without disabling usdhc interrupt
(because device_may_wakeup() returns false for usdhc device)
2. WIFI out-of-band wakeup triggers system resume via GPIO interrupt
3. WIFI sends a Card interrupt before usdhc has fully resumed
4. usdhc is still in runtime suspend state and cannot handle the
interrupt properly
5. The unhandled interrupt triggers "nobody cared" warning

Fix this by unconditionally disabling the usdhc interrupt during suspend
and re-enabling it during resume, regardless of the wakeup capability.
This ensures no interrupts are processed during the suspend/resume
transition.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7fcaecdd4ec6..c4a22e42628e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2076,9 +2076,10 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_save(host);
 
+	/* The irqs of imx are not shared. It is safe to disable */
+	disable_irq(host->irq);
+
 	if (device_may_wakeup(dev)) {
-		/* The irqs of imx are not shared. It is safe to disable */
-		disable_irq(host->irq);
 		ret = sdhci_enable_irq_wakeups(host);
 		if (!ret)
 			dev_warn(dev, "Failed to enable irq wakeup\n");
@@ -2129,10 +2130,10 @@ static int sdhci_esdhc_resume(struct device *dev)
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
-	if (host->irq_wake_enabled) {
+	if (host->irq_wake_enabled)
 		sdhci_disable_irq_wakeups(host);
-		enable_irq(host->irq);
-	}
+
+	enable_irq(host->irq);
 
 	/*
 	 * restore the saved tuning delay value for the device which keep
-- 
2.34.1

