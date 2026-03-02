Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBA38758F;
	Mon,  2 Mar 2026 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438362; cv=fail; b=KiRu35kdUJHitnDUzQmccP0w+rzXIhi51hznKHn5b9xtqSuUoTXxfhs3EOFYyR7DsSmiTpJu1Si0HTbF6Gxzsp5kMoOPVOG9+wtvrZ0KcZWSweithttF30R5j4sRvpzY4CRdOzcMFSzg/H33HnEAc9TSt6R4GPpiu6gYt+RRUIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438362; c=relaxed/simple;
	bh=2SdNYsT+3kR1z8Bn1w/LMQtjEX5oL7mUeImmKrZPRgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwJoLvmL4By5rH0u+plhirG3WXmf2nu2qa3cFITZuPoZpMFpkX2iQtO7fxd/mYYPFRpLqnr1naIValfTeN0BjpactjgXqHdMpGkgjhwKU9dZ+V4pkZLprL3EQOxcPqbU6xAOBhcSzxOngFfCIdWdCSS0KUEj0cIOILRvLOhh8HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L893L+1u; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L893L+1u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gmrn7y0L71iYLKfk9XWxyfH519XpZPDlPXFVlUmj+HJGZcWdopI0Zvhz6UrD3Nf4LcthEY5WxDrHLbNebQ0fmoZ4Ar/yD2IGtBqtgnletuNXUgT9vA4wmbx/t1hqj98vblJjqDTpF9gABvmPrL0QCyMnLmll9SDo9SN8/2r6WtuGaCQWAoE6v59WRd9/N6OVOXXy7kY4Egp703eI4eL9N4bnaYwEbTI1j7ZK3XDbFCbNwKimH/8fmv7XfQi27bkIDYfx/31Av/4ATuci1OGqAGWIRLDEE614E0wR4HGh8l7wcE+evzrzkH6NvQ46yHmBLOY+Jf3Q2eXXthdMg846Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NrlQvct2ndnwKRcuq3H4HU0dM0xCIj31JyaBvUT4AM=;
 b=t+0l56/x9hcrAA2uqLcrmBgfejwSw8A1vPmtjwue5WDBItV9v3p3HuKsdqa5clwRdFHq7quCyrz6DYeEc/8clQRhIeGg+ErgXEme1DnNBCds0FzcBYwWiKdoJUaK/M4nRYI5XU+CDUcBQnvKPErRQC+jmNmbD0UdpXLOd7u5yQhEW5kUdEWo2JtK6jLPcKqKaWDSbVsq+ZSxxsyVzaofZ2T10KKmcKzjcrlfjccg0+kr8F3TZjls+oMo503QbR7o75JZvhhxdjKsWAMJs3iYL74OUxtU//zQKhH1b7pY6HS8/K/YEp/MEgz59howD+sKlWHmXshPHA9eeGzMDkncIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NrlQvct2ndnwKRcuq3H4HU0dM0xCIj31JyaBvUT4AM=;
 b=L893L+1ukAbM+zMnlRWDUFQfiJK1lGN1hmXk9dqtKJqeAXXy2iYpfLLjc8ZZ4fCWvL8045PVKom+2mP1OARtyiyPATc8u3vRQ+x8EbCiY6f3lRva0pb1Agwo4vU3sx1Ik59TJjsQ7jaKRawm9hr2/iN9LflwgSpJFtU+JoFD4GvVrrjBcOQqY8vyqJVjnVUULsxiuvptFwDHTaQ1zi4WjaReHEHsYFy4Jb8RaRWube65mKVlAVJqL+uNLJsrCJu71fPUNOEh10WW91TW+AK0X9nB7PBjl/POROQsk2KfXtetBQ8PRFtK30MCzuBa8nH2BzqYeKcB0YH+NTDqVgdJeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA1PR04MB11010.eurprd04.prod.outlook.com (2603:10a6:102:490::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 07:59:13 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:59:13 +0000
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
Subject: [PATCH 1/4] mmc: core: fix timing selection for 1-bit bus width
Date: Mon,  2 Mar 2026 16:00:54 +0800
Message-Id: <20260302080057.974102-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
References: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::10) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA1PR04MB11010:EE_
X-MS-Office365-Filtering-Correlation-Id: e06d4bb2-54fb-48e3-7662-08de783197e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	6ZhC1O3+ZS0EgewZPB34EcjLoKtSqtPuGDS2cFoouNx8JMoctubcqYys+gEgf9t0ccn/7KW41VxgxPzWVXdATOaLam2bstLgaRIQzLvhs3Q4G80E32r4HPHx1b1SCq/yslUJENaD5b+MhdfeYt4Eu2WWB12kmX3lXbXFTjru7wQPbOQ1IOhglShYvA49xQSIwNM8GsHvGRJAu6aEr/51/Edn910qs+iO3nPpXBpI3wt1C/OCW6cirK9rSqkS3QqUA23I1xShgmqEZTseGQNnVKZgQlorQOcqWwqkgQK9SDKwIdEXrA/JtUSDv7zavtf2rO0Pak0k5sJ9GmlSCY8okE1MV7L67yfiSK+7DmzSBkAMXywjN8iL5cTWT7l7aO+j2u+ExRubUT0+FXnyMZTaGaOi9FD0AINcQ3Pmb3Duj8cE6F+V7X9ME3C7eCTPGdoPsqXAJQDJGVX/swlyds2Hxum9ZvVlR12bAeshRgIAFrc/CkwkkEek48DWBVyPqwOo+BAxcrtLxpa9mS0vTlgqkdMoapf1e9UGv2f7SFEfhb+PPW/3uLTq7kWcvfgku5IvB2qTRhM5UyZjFLVTvveLqQvCzdRcz8L1+mlJlEaq6SXHSCaW2Eg8aZY1ZEfM2zJwyiTwXyZvRaebk6o8ljOV57Mr7DaoqVgP0EWXTdgDFORNDlCIHy2zwJkHgsP4fu2xZDQmvV8yplvqjmz/HgPcNZXg79G0A/vdzv0RLIfYUAvy2aEXTWYygAEnsdEvVK53VNvv2MCHmNYLj26Pg598CL9VoFF754FCJYNjXF6KlXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NkviCjorr96NAwUBNtnrt3Ne0E/KAuKDpazJN61mx6vwaW3a98sJ3oezVk1v?=
 =?us-ascii?Q?UyTpto4591f4BFlixKrlbvjToA48qj2jnv7qoZ42s/iso1gcujZXaPYFOjNt?=
 =?us-ascii?Q?Fij+rXnRGVfAllX8vY7U7RFjCeLeGEaDs5VYbjAFtnKQgySsNfSKO3PbTHsD?=
 =?us-ascii?Q?2bwrHkBpiogcTd47x2b4kkHLQh75V+sUqdvCaB2CpgC+3eX6V/J4RCu9SyEq?=
 =?us-ascii?Q?g5DKWnLQrr/IVL+V0d8rDQ+OJOPofGEoQmQOx7JtnN4qNY+IbK/1y5G8sESq?=
 =?us-ascii?Q?jYGIyCv6l0STfdj0dp+KaztWyw1ch7xdpIpgSfgpTC9quR/I0YemE5NRgaDI?=
 =?us-ascii?Q?E9qkxYawMathZSqLYfu4NqHhkCtYs3nLz+FlfpxmRLwRFAyEZrcPoAA7mgqB?=
 =?us-ascii?Q?cZuGq6mYkUu2Z16XL9xejtFBXgjb6qJS66gyA09BtyVtfXt/ybH/HRola9DP?=
 =?us-ascii?Q?ODbalTUr1jh3JX7Aha2MTkq1Mycc8LzsFkv53S/wfvMWBsuafF/1x1FmLzsr?=
 =?us-ascii?Q?k6PIv6b9hAz0bRJDPQ9cO3sV2FN72y+1pGxZZoAgOpdnlBR5i1Yvfu8ZxGKA?=
 =?us-ascii?Q?CvxCG9uXzU1pR74MGHZobQfefLXrJeOi/rPoglwZ48ONZuMzzLocPaNTvqCq?=
 =?us-ascii?Q?BT67imQ1rjFt0WFadVm1SWiR+kstsDevYBwBsRl1XG3G9vVdFnJ3HvdQ5VXw?=
 =?us-ascii?Q?nBX4Nrmpos6BSH1jZGss+HjReohl3nXyLhfUnr7TdCl3AuzYGl29wTk7j3sD?=
 =?us-ascii?Q?mQ9lxAQAriqHPr/3JpEWBLLjuYMGqKeetwh5TNZTHcFOnNGvKMRwUsk6eAoW?=
 =?us-ascii?Q?BxvxDBBarrjx9C6+Gn3dWRUJcbX3ABeUONkWjrF7sOYCD/IRfIaajx5LwU/P?=
 =?us-ascii?Q?x2rA/d+WpjOiml5ROfeQg3txWzsMW2WZqcnW/7F7X/qZPrRyUFJtpwNd4BVN?=
 =?us-ascii?Q?SEnpDjdPwa8tbXYML15V2wgzj7DN1pBKBDQDEP9XIb2hF5zJduQaGoiPtUYP?=
 =?us-ascii?Q?0IsI2Av/jQiJICQrL1lVk2D4TjXQOoUmHl7hCZxDRaSvqBGdmyf01+7awKmQ?=
 =?us-ascii?Q?Oxbs4OHvF2GVfhOQCndFVcIlFu8NfqYLf8Lon8vL7D+o9XrZboIZ5ANj5HrX?=
 =?us-ascii?Q?XdFre+YhvNLC1oKqa9G9TelG0UcfJrJmnGWa0QYwyEYRi7bBPMuiNBypy6bY?=
 =?us-ascii?Q?ROjuTEba5dMcxCMhbCzmVJpM/6nPN1xsVLxzo6wqahZIM8wZUd26lNDR21kW?=
 =?us-ascii?Q?I91YqN15FWXltC8croUi2mFW3t/9Dm/ZGe+XAa6ySZX5euKELrANYN+jS+Zz?=
 =?us-ascii?Q?a4FRg8gZzewtja8CUPVx+AMZ6P738yYYeGFoMbkFUirPNJVk1mGziofSJRWO?=
 =?us-ascii?Q?dw2ilnCPVtOSN33iaeiAFt6mdJPCFbCMlrAvPIGkyDtumx13gigWzdiFsJyx?=
 =?us-ascii?Q?BsdX1sIwK3hobkf3f4uAxmHCNgx4wHZRQ4kQJzlDedxiYwpkfcAfgXmQlitY?=
 =?us-ascii?Q?p75V+W3T2vQDJgjHbk3W+ikp2fpv9UGqPbs3pm19N71NeI2ZKtVn17h0AZRi?=
 =?us-ascii?Q?UgfeEP0iVGBsBbkO64CQwnaNr9nHP9kAvrIuoPKzOHXmX2mqHZhPM6QWOd0p?=
 =?us-ascii?Q?UHw7YLHVs5EizTiggpPkAv1uDbFqy/mfauEhtuNkel0lw9GdhFyGdSqpml0/?=
 =?us-ascii?Q?vx6Y2FnveddLRfolJr77FOeMjejiGXz5BaqUoJTcV20qKNtufc+yZBZZ/pxU?=
 =?us-ascii?Q?0EkyA9EA8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d4bb2-54fb-48e3-7662-08de783197e7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:59:13.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vLeAI6yzyqiazf/vTD+xHF2m0FgCw3phRPZGdwxab15kjaVW+j3RmqmJseowTyXqUwbt8p2guNrkePXfazbpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11010

From: Luke Wang <ziniu.wang_1@nxp.com>

When 1-bit bus width is used with HS200/HS400 capabilities set,
mmc_select_hs200() returns 0 without actually switching. This
causes mmc_select_timing() to skip mmc_select_hs(), leaving eMMC
in legacy mode (26MHz) instead of High Speed SDR (52MHz).

Per JEDEC eMMC spec section 5.3.2, 1-bit width supports High Speed
SDR. Drop incompatible HS200/HS400/UHS/DDR caps early so timing
selection falls through to mmc_select_hs() correctly.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/core/host.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 88c95dbfd9cf..18b9c3174e1f 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -617,17 +617,26 @@ EXPORT_SYMBOL(devm_mmc_alloc_host);
 static int mmc_validate_host_caps(struct mmc_host *host)
 {
 	struct device *dev = host->parent;
-	u32 caps = host->caps, caps2 = host->caps2;
 
-	if (caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
+	if (host->caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
 		dev_warn(dev, "missing ->enable_sdio_irq() ops\n");
 		return -EINVAL;
 	}
 
-	if (caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
-	    !(caps & MMC_CAP_8_BIT_DATA) && !(caps2 & MMC_CAP2_NO_MMC)) {
+	/* UHS/DDR/HS200/HS400 modes require at least 4-bit bus */
+	if (!(host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) &&
+	    ((host->caps & (MMC_CAP_UHS | MMC_CAP_DDR)) ||
+	     (host->caps2 & (MMC_CAP2_HS200 | MMC_CAP2_HS400_ES | MMC_CAP2_HS400)))) {
+		dev_warn(dev, "drop UHS/DDR/HS200/HS400 support since 1-bit bus only\n");
+		host->caps &= ~(MMC_CAP_UHS | MMC_CAP_DDR);
+		host->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400_ES | MMC_CAP2_HS400);
+	}
+
+	if (host->caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
+	    !(host->caps & MMC_CAP_8_BIT_DATA) &&
+	    !(host->caps2 & MMC_CAP2_NO_MMC)) {
 		dev_warn(dev, "drop HS400 support since no 8-bit bus\n");
-		host->caps2 = caps2 & ~MMC_CAP2_HS400_ES & ~MMC_CAP2_HS400;
+		host->caps2 &= ~(MMC_CAP2_HS400_ES | MMC_CAP2_HS400);
 	}
 
 	return 0;
-- 
2.34.1

