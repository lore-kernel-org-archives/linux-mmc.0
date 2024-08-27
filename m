Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010052.outbound.protection.outlook.com [52.101.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4518755F;
	Tue, 27 Aug 2024 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744122; cv=fail; b=vFTaSG+c/h/t3nDuMZ/TP/10GR6zzWk9kniqM9dTpa9c1rhmIdNosNGUwXr2e4ImMRFykUOkKoYbJoubAqJvcltR+Mk+8uWijbQbhwt2YfRREb3Eo+zybAgzrehw4+5HtGTkv+dlmUbQSarV1DYQYxcEfHGCQmz4JGNnXkJbVXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744122; c=relaxed/simple;
	bh=4aWiscUrIrWILSSnO5ZL1kGC+2Uz1l3vZ+xgNrpCItM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4a7EKNZhcn+g0F1NAYWUgEI1kYiT0C53gvf7afDwfpdZrM+KLTDYhdzsZokboJtyyTWI86nwijMEXM+W94HtwWpI+4ZYILW01+drU5szpOYDfkaIAic2/8YSIIT8BWBWe7vqPqeCw2Z52oOtxAbxxSGStlZbQx5P9weWJbW2Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HvrPG689; arc=fail smtp.client-ip=52.101.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HvrPG689"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CihXSkWmts9cehcPH/sVEoPST/kOJVHr/fX3mZTNbGB4hh2553JAvbXaGvleZb2znr3Xfv9PVS3ua4ySBN6i+5xy7IexANeUwKOU13wQ8/lcJ3CC1vEWmmo+dySlPKLSDAp1GVC1dqLMSfIKD1T7iMCGWavLU3LYRImxeXWtLYrGKPF3o6jfHRoUS2IhkCP+llTpL4ySmRR5Ol1fvnaumG/D5T5j8iag/csff7CT0HVvEbzM0WOojITXFd1KidnWtxwb3FTtKPW9/jPWo29ZHFoXljdP5JgCJec9TowKT7lzTsU2J85jxlvTS86h5eSsS7Rh26qQGeCykTe9DNk+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SamfFhQLcWvE6N8Vh8cN3F2Yd/zM7mr1jM6WvVxLkb8=;
 b=KP8Huea9tpio3EqIbachlkhsHFwuZMSM2dDqdulMFVOZYAcpt9zsuhIao0Dyk9YhdBUFP4Z//Yk0tFLYUFI1/xv6w2c8wH7ABJxo6vzSNg3c22Rkz7xC7i/bIOJB7xU8F/SyvlQ7d43ROjOD6toKfkviBDt0w4kmsOPr98vNQBOpeCepxM3lNymAF2XnEbsg70iUutbMA5N4ytnNsdV0I0q7CmtmOEaYxhYsGcpnW5/KfchMy5nwLZbHrzktJhfWlHwyCANgoha/2fiSfPtVO3cMnhT4uMO0LCF/c9mSyD0OTSVdTYj6ezdSf9/CbMIo9azTaf7paTBU+TKqrbNZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SamfFhQLcWvE6N8Vh8cN3F2Yd/zM7mr1jM6WvVxLkb8=;
 b=HvrPG689ItUDkcqCM62trJba6G8/3s5c0NV3O4lJX7f485XEZttOTLWvYoE61mv31BAxHTgDKPw48nuGdjOCmxFRefD39m6bfPMiQ/ecTih9eLdxbTkOfVr8cGYLQBqcX8xyK6MfkPV84fGInKxMr+bPYSrFmzG0T0ndCCctJbTfVPI7ug+qUZJ5NPGT1Tqljv/ryYMe2Y7wFAkM/Kxo2Oz22CDOQ3d0olSzKLooN455NxaocU9XHBPq+E4eSR7+TdQydhh/NtCjfbkapJJOgGlOsO5La2iPm3xptDD0STvRLm2fRJXKO0bBDnUw+rT1GvkwjToiIG+WyTbmzwsuyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by SI6PR06MB7102.apcprd06.prod.outlook.com (2603:1096:4:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:35:17 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:35:17 +0000
From: zhangxirui <xirui.zhang@vivo.com>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Michal Simek <michal.simek@amd.com>,
	zhangxirui <xirui.zhang@vivo.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/9] mmc: mvsdio: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:42 -0600
Message-Id: <20240827074857.2671808-5-xirui.zhang@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827074857.2671808-1-xirui.zhang@vivo.com>
References: <20240827074857.2671808-1-xirui.zhang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To TYZPR06MB5178.apcprd06.prod.outlook.com
 (2603:1096:400:1f7::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|SI6PR06MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 62222865-c523-4fbf-5355-08dcc66acc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZeNEhFFG9rUGbn+ikcOvuMdedmOv+2RK1sGLZyMq4GpLDQ9jG2iGQqhdcEP?=
 =?us-ascii?Q?2XAj00OODAGBxI1rO4ZRAX9GCet05wB0l0oLnTyThf91rFYD8bk0+Lw3ofJV?=
 =?us-ascii?Q?7Pk19EFk2Z+URsAfAopbMofgFnVmIbQSwYFPH5JdgMmt3vLGVU37lFPmTlcw?=
 =?us-ascii?Q?dxO7ltkYSUExSgngQOmgO0gGw7wqaHfdKqTLOiUaVHSOBonXjbIv2yHUltU7?=
 =?us-ascii?Q?yCPy+7tajX6UBRmqeltPVu5/NT0MEOEWdhisZJyyNi0J9MqSdK9Jb/+j4+0M?=
 =?us-ascii?Q?fGATQTRrKYBbDxANVJgekMd/Lw6Re8FG2kITI5FnmJS6ewzgYsPk2aPlcOf1?=
 =?us-ascii?Q?Zn0+kbFZ50YVClJ4UfjfCowPAkZQpobts93NjmUgUZWkL1ePehv1fdC4LAIo?=
 =?us-ascii?Q?0Aqu34g1b3us5ispYDJGnBI9caID022OoE7mrN1BPwVN0ASguGRa8Kk0JvqP?=
 =?us-ascii?Q?G6IBK2QnDemP7OAtTeNqn8mgMu0WTXm5Ld+fatrxLFOXdD+4N3KTg0ASVHDA?=
 =?us-ascii?Q?Rxyksjzx8vAwahwMpoToVsSUdP8Khi+VfAYQqYxq9/myPNQ3Cu0KhHqCat++?=
 =?us-ascii?Q?zCmQ07twZkO4CDdMxdqve89VtwSfkqabaT88C9SUrHxKTnvpJTGKUEgRGjIY?=
 =?us-ascii?Q?F6W2WFPO4Gm8tH8RC6ow7IfuT7g09tYXFI1HolrzyokIQftnsyBBIGCy6aM3?=
 =?us-ascii?Q?34XmaI7kRJvvQ+jG9Ykg0IVOTnNWGh/dTOBXlDC5QcZH+FmAFPX+kKKO5znb?=
 =?us-ascii?Q?XOlsxFRQHlcjGvlL6aCd0HxO9tBJzyLBrxh0FllmrroLqBndN5sZlzGGVXjo?=
 =?us-ascii?Q?s7ib+QhMLtZFNUB1Y24wCO1F20gq5++jYwuH2dkheRvYE1A6nF7P7RFPh2pp?=
 =?us-ascii?Q?PvL0q4W+NWQdSF/0p/LX5UIU2zwPAZfdoH1HjK6KOplRhMQxpv8a2nHO38nz?=
 =?us-ascii?Q?gyFzXTrp+DxkthCQ4H2EtSBGOFZ+htOHz7X72mSIOqKdaKOXMkexk273jivt?=
 =?us-ascii?Q?HH5/vPY3tYrhiB90deCa6uA3JbqzCtPEtuNONye1r93nTD0PAMimPmid0L1P?=
 =?us-ascii?Q?6F6/Mp2zZrRSLUDWfOfr6R+8Nt8gmrPZYD1tUEz9mXOHsLp70tOSMmAqh6jz?=
 =?us-ascii?Q?EjusSidcnWvyu2GYQ7o6z4ldtJJVKGY2tQ753u/CRBD+e5YLaKZ9Dw3q6XNL?=
 =?us-ascii?Q?qw4OmXVG292X2yfl20KDRLFIWnqwjH7EhpDl1AtVvxf4phIZ0fbEddELkRFj?=
 =?us-ascii?Q?H6JD8EEnSTdQO1+08hAuEXNypmqkwDtUVxoHjnI2HES/gRkEO947BpZ+gOUa?=
 =?us-ascii?Q?crRdsIuzJCNw6eoUHAO7SEOVBf4r8sJODcIkPq/fzYoLT93HCetDY1USbOAT?=
 =?us-ascii?Q?YcdeSgyzhtvucsDwZ43iFZAV9tuWW0E8nqJRPZUrLh3JW9TFgdZqXguV18rL?=
 =?us-ascii?Q?cieeMEAKGELRSLjiD5SyYueygtd1QEPd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWiZR+DjjladCwK6KfaWpBX2UuOI3CGQHKsYqFHdF19IJEPhCtj924Bu96Ir?=
 =?us-ascii?Q?x0uEuZxvZVQCp08u1E6dB5kkSwNmCSZf/8CLm7QPTVXcF/6fVPGdCWV69tCw?=
 =?us-ascii?Q?zyHBvRgzCg+1InVC0Wvpswg2Y+eYk1yesAKDtdJZgcAobxoBkQ3DC/wE6NQq?=
 =?us-ascii?Q?SPpfcXDI1OgZIeTRCEZIHuxVeuvvgs+0BGG80ANpcVETj4hNm3hyPYCQE7UA?=
 =?us-ascii?Q?AE4mdz/EAO39a7ige54pdKH1TDRb6/mCgo0aAfp8lr0e8IFjuXKHYZ+hZxgi?=
 =?us-ascii?Q?HzAb0go8zYWB80n//QMzj6Xq485tdo+1/Q+3CyFOCcxGUZ8Ht+dV3nJbMbru?=
 =?us-ascii?Q?I8nt6LXFGO9iX84hDsfnW+USjd4Uvu4HcAB/3jlx3kNcNTucj1QrownSDpr/?=
 =?us-ascii?Q?0oLDwE6NJmXDRowst/kZpkvr/fL+SPkJnoWp5PP+9umDTS2l2J2dCvmV3/4U?=
 =?us-ascii?Q?REBDstmh8ojOrPjqDmpGIwKY+DlfuxCWT8hmqpeP+xdQ7CAXF5jS/hh1Mwbu?=
 =?us-ascii?Q?hGpSIZaZlnptVR5Kwm12NDjcu2Zp2II++7zIp/+lWFxh1a0ADJ92QDJKclSC?=
 =?us-ascii?Q?yeiJdTm7ZrF/sOlS4vx4/J+fK7OlXQ8ntAWXzh/L7s1ysseDJ/MBqnF/s/UK?=
 =?us-ascii?Q?5GWEYD8z7v7uTWFGCjrGCsQwkUydhXfjUuxJ0OdZbe4nX/XRAGU/xpNCCYbM?=
 =?us-ascii?Q?iizqQwF4c5qKdx3X4Zj8pX+94U3NVkRGxqW7d038oOpeEnQgZFN+t23ENEDX?=
 =?us-ascii?Q?OgjP0TCNIvC8ihvpxncZ9vn1sAFDV6dVpuVXg99lTkO/hCOtQXvui45Z0H7P?=
 =?us-ascii?Q?N6WacsDzVK9djaf4k0PbMqEI/d5xCS6Yb/lT45AIY1JjyffpK6tZjomxBmaL?=
 =?us-ascii?Q?C8TU3iCRUZZ3MHw06JNb4G8BOKdkJPb0c3tnHuHHNrxf15kdEm6osgMjqVzH?=
 =?us-ascii?Q?T8/XWGdvukUsD+nq77eKVwM6awDkmwdFbk7pvC4gaQ9sJkG77YUmQKme5bhO?=
 =?us-ascii?Q?RqRYM2+Bo15xPXUhj+mt97Q44PknaUDh7F+zDUgHatd1os9VMhtlPN8CDr0p?=
 =?us-ascii?Q?OEFKrf88GtSO6RSZZRHJdFZ/d5xHEtgPo/uVqx8Epz8oS5dcDrOIby9L67RO?=
 =?us-ascii?Q?Op5Ki5LqX/EQbH1o48sCSUSByskYcClZdk6D9ZzOVtSM538kxHh2GrxOTrmD?=
 =?us-ascii?Q?nV3Ydsi7+RT9X7p5Nh3am9lERVj5pxqO/LT1LE4H6DNBs260qcdRjj0T+7S6?=
 =?us-ascii?Q?LJFsPOV83M3OWdwSupNfUhzMYvW1Vhfen3wW8r2hM/QJ9pNJcchrGSX8Q9vS?=
 =?us-ascii?Q?IbpRQKvxcFsmt+eG3jk9mZn2igADMAbuFz7N/YPie/OmqDUUWauWoyDCSjvJ?=
 =?us-ascii?Q?Yp0Lr64gtu15Lg3G/N4WAsVNPRAaiVwTMnW8gbMtCwyJqf3g3YUhbtszS0XB?=
 =?us-ascii?Q?Cv3WAXLikqxOcURycWkt/bOCedy6dGNtSvgS9CaAewWvHZbKlOsArSVptF9B?=
 =?us-ascii?Q?cI0ksZyb9m1dd31BLaDIISmvvznCZKGtiKSgwi17Gdf1ravNVxHzp8FLH506?=
 =?us-ascii?Q?h8JCC5wFbcJVAZFhPSUPH9kn0R4qb8RoqETWDaXB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62222865-c523-4fbf-5355-08dcc66acc0a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:35:17.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KAOH0YZ5JDUEfoRsslnP/EdOrC8Y7XX60tUCHop/M36gyzMkmWYMlxjBn6g00FyNjo3zFCPEjPJMOLwh7xzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7102

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/mvsdio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index af7f21888e27..c102eff30b40 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -48,7 +48,6 @@ struct mvsd_host {
 	struct timer_list timer;
 	struct mmc_host *mmc;
 	struct device *dev;
-	struct clk *clk;
 };
 
 #define mvsd_write(offs, val)	writel(val, iobase + (offs))
@@ -731,6 +730,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	struct mmc_host *mmc = NULL;
 	struct mvsd_host *host = NULL;
 	const struct mbus_dram_target_info *dram;
+	struct clk *clk;
 	int ret, irq;
 
 	if (!np) {
@@ -758,13 +758,12 @@ static int mvsd_probe(struct platform_device *pdev)
 	 * clock associated to the SDIO interface (it can simply be a
 	 * fixed rate clock).
 	 */
-	host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(host->clk)) {
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "no clock associated\n");
 		ret = -EINVAL;
 		goto out;
 	}
-	clk_prepare_enable(host->clk);
 
 	mmc->ops = &mvsd_ops;
 
@@ -780,7 +779,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 
-	host->base_clock = clk_get_rate(host->clk) / 2;
+	host->base_clock = clk_get_rate(clk) / 2;
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
 		goto out;
@@ -823,8 +822,6 @@ static int mvsd_probe(struct platform_device *pdev)
 
 out:
 	if (mmc) {
-		if (!IS_ERR(host->clk))
-			clk_disable_unprepare(host->clk);
 		mmc_free_host(mmc);
 	}
 
@@ -841,8 +838,6 @@ static void mvsd_remove(struct platform_device *pdev)
 	del_timer_sync(&host->timer);
 	mvsd_power_down(host);
 
-	if (!IS_ERR(host->clk))
-		clk_disable_unprepare(host->clk);
 	mmc_free_host(mmc);
 }
 
-- 
2.25.1

