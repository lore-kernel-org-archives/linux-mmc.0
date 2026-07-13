Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC677374E67;
	Mon, 13 Jul 2026 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917446; cv=fail; b=iSvPvuDc9I8edHONp/A/1cc1MftsUwxxcqBlz7sE9p7cEOm47b7uTXzW8Ubq0EJWi+5DGTyHj3aIFplTfuQzbOwLDmfdcZs4ZoTt9cI2+DP1D85ok3Cii3RLJjO+JswzuH8dYYTmFR/YF+VR/5A/5gVQuo8RhzEdur5Rxsa9bfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917446; c=relaxed/simple;
	bh=cteAhfX8eWw8tGwq/93u47FrcG6qckzXNG8qZrzBjT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hm6f6O6p+recAdPnxjW42I4U3StTaXFIf2Y1VB45XUKPQB+o/nPUU3chGQc2bvFBsdmRu7wKyZZATpmykpmJAO2PaAH76SJisqB+xU5KCg+bQK+JmeFH8vXXVEXrztPdd/XgobZlhhyNnxR4nSB21A7ZRWPpsKBLUacPy6/7uBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jEv2c3JP; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jEv2c3JP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZdeN+tsogkAFv7wSMqiE8hXOTOW0gFyIh/w2z1630T4NDq3sRiGddSeTd7M+rfQRc01W6LHaxc2D2/IehWm8DnZ7tBkT+X3AajJHe5QZZjqIeHXzzcfyebPJ6tEHgJMkSoBCCMPaCC2TdJOLa8himeIiIjYW2FVFAdNVCOzZfjrFbYVf3TgRXIKMtJURW87WPf6S+aE9MD0RPIx36AjbS7la5Ottz2LVDit+KBHTZs7yDZKxMLK+Jzos/Yx0DeXfxDLm+B5s3q7lLd5n7vtYTkptMQ1pgJYcgmRj1XJRRy4wbHcsGF7I72C/oT9HOUWizmQyq03ObAUuhcv6mgPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clQF4CfcKwYBKaXlPSmL9IuZrksTMWYqhWz9N0EgstY=;
 b=tvVJmrGQDo+xNynIH4mOSEhdt3ZWAl7H1+RhtnexijhdVFljXCdubcbvRAMqGmvIRxwoP4dm1qXthbkQJopV1Xq+gZtQyBmEmR2y1B0u2Gnjq00VX3l7bn3vwBuKJUy/DhUjU9uLpaZpcCD39CJ49SYoxAKuqK8ELQY+Mle5FI2YX0Qo7+3X+izR3VNTioCmkytBiFRIuHBPuClDwzVEqNM6E8Ex1IMYtFXid6v6fk/NQiEpm2r0xiwlBrKlQb4BAyxw0gp/zQ0bRQ3yzeoZdw+VH5ukXlef1mZ2lhN7oAVf3M1MeGSdM17CyE1Kpp0Nywi8x7zZLJjCx6E2n0rD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clQF4CfcKwYBKaXlPSmL9IuZrksTMWYqhWz9N0EgstY=;
 b=jEv2c3JPOufrctbehUuriAyVXvzxL0DpxK7RhviqfsqisZ3bzkMOYPUcQVFnn95Rubn4wRYbc3t6He6HJtaV8FDCOf50AKM4RhF7JYl0NkWRhpxgaUUyO4IkUJkw32yGDrbf88vYtOpU1mBdh5xbLAVghsDSuctya6iWtbX5QbZ6jxR8KkOPflSx/Fn3N9qG98NSNxHPRJPbzuFbX0Dlwl0wWYYrFQ69hBbn4NAugpHWQmcjGZWbLgCK2klPwv3XWQ+Ho2mkKyJErgrnAYiWWhdI4vSBNGBYIbApXHO3J4kXCMZRMI0hvE0o2OwLV2OpVu0ae8UGuo2FE/8olnMmsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 04:37:00 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 04:37:00 +0000
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
Subject: [PATCH v6 6/8] mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
Date: Mon, 13 Jul 2026 12:39:02 +0800
Message-Id: <20260713043904.4144172-7-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0295.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::11) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: e76586b3-8c5b-4ea2-abc8-08dee098614a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|5023799004|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	unBYXygkAUkuxTCWJc7+/vu1H9dPLOtyOCQIKKtJdsZzBGwB1n6hUBxTeDeAuvCMIoZNb6ZPJbGLUWo9+j2lTK3+NziKL3knIUnxvlJWi8fAMERHDxSSpzx+4nRlbHmzfEoiVrSIxc7MZL+nE+qiVUlGApxROsu//DIQFyiMQGwKoYQsGLTYd4aQP/kKw77i0WDTlxgfJTRPX7ZQ0uG+kON6ocyDnxq+5YP2v8hdfl1m0t6kPz18kT0MXdrFbTIjsCZAjOLKZ4bSZ3GdBy9x4Ciywd1C7eu79fYEaieiyCo2rC3t3SQJxSGR+g2mC4jwPyCFNTCeI3bf06QSxK1mFU0ALCvd0zM35ggpI1NuxuiaCdhXOQOJ5RPdwZF6eGuVFrXtvHV2mXVY+wJuoK1gt5sC8elijPhfNJ+3T64r83L1mUKyBA5+jWspHDhMuoSN59NDYOfkqWsxidaBrc6WuvxrxpHvvhkM6a0sM/RQICwtDRTIXVV1S8A12kgCGhVMMV0pwNw/P8VnvuCMnKZqDYbSJ9S/B7H7Hyucafxl715ZZwnchBhO8bBD19I85wZ+J5xFyI5ry1t6lGcCjWL0uQpBmoFUIgjNxSMdTwUR8rdH9LqHUl32KBQNmgdvYkwMRWwHehGtfQbYPno/qM9VYr7uc8ssn/bKNQLittZmc2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(5023799004)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dkbK9LjH65MFYEKyRTKBOYehb5kFhfBZ8PNSymcrhrv0L95Z92h/xw01VU+y?=
 =?us-ascii?Q?V1cKkrBAl8hrFYc8PMtQ7KszBT+hvFEhJBPu4uMljTtwbQJJhbvVbTQF3vXq?=
 =?us-ascii?Q?qDUaeaSVTQdJvwtm3PQPvIlkdmCNGk4SOT0LOC77fmuvae9+a5y7fvGgo76L?=
 =?us-ascii?Q?wi9Sy8tmSmzI6wDnKNidvJPJ7mAnpHSP6nFXKEGRXzUn/5/ovJywQ6Od0jXn?=
 =?us-ascii?Q?pnANYFEgDDxIhD9jzemXSf6uq+0r5vxn/sB1ADhS1b/qMooAyJvTsk5qAxXE?=
 =?us-ascii?Q?UzyvJaWU7P2ERDnDaJMWB9BJFkRpp9KoFcODoZToirUtXD7NgDdh7SmTOOLo?=
 =?us-ascii?Q?Sa34K5Ae8VwU7L9q3V07T8E3f7ZzRx2LdycDbJUCN1v/IfA3/1mImObCNuN8?=
 =?us-ascii?Q?ex9vLtAecgQI/ljvRslW8RvtcxbjarakBOJVdxe5lXLSVJ7JzU6ttPg1SLKN?=
 =?us-ascii?Q?ILRWBhhq6GvDgEdHu9OefoZhxAo74lLrvaKPjVbATkkrOeSWCrWajH53bDdU?=
 =?us-ascii?Q?iEZUg8XUvDJMf57n+uARQ3b3Sk7XSHL2hBgJYzbRS5qSdWwSDWSA7vAO1DDq?=
 =?us-ascii?Q?nu5H2oXi/WLGzAiEDc3NzZlFkC0xnmptziabFDr+cRjgEpRb1YfltVC+N/4d?=
 =?us-ascii?Q?jIzVMxjo7za4hn912DDGMks8FiVXK0N/1c8IWj+hMTibF6FILPGr9j4SeG1s?=
 =?us-ascii?Q?sIl9z69d4ILGLLyJIXjVhbNxaR2DXO6QM/MNQ8JCt0Sc0yjeIO7X/DOxf4x/?=
 =?us-ascii?Q?AtziNNLD3V1Nt3UMpGpPzgmh/fYuqsFkSPE2Pba3QCajCjskBoECzzXvOUkE?=
 =?us-ascii?Q?76w3dpHGYSHIBzusMt1JVsAhVjiqQhlqWqDQRXcN9XEp6ASBWvP3EneBYmyq?=
 =?us-ascii?Q?4AS5QxVFULtdPQziIqYpgkHcyiaFlmz0hX3J3ck+E34AfHbtzYTo4iP8aCK2?=
 =?us-ascii?Q?kJkEBB0mYZizXBLGK6ksABLJN4yOH+iB457Sk7IEEY5ZjIzVqHEzuzyIJXIU?=
 =?us-ascii?Q?GyOvNKaOZuU5fCqcH1DcRGhsjAM5LLhLWcxJ1q1HCInReZp3FDJuBev9D+Sc?=
 =?us-ascii?Q?YlJQIJf1K4GSUwfSHzDkxSGHQFtlPzIoh/C9GFSAe0vsyL4SAYYXoWcltcEG?=
 =?us-ascii?Q?uKq6I2azXaJrJTd+BqcfIyS5jgN93xjhLP2EFd9UmCxs6R4uLPbaHAdKTS4J?=
 =?us-ascii?Q?ZmWcgBSuQ1E09owP+qIodss+o3g+/0JH4WE+sLlZRAgLKypOTy+LM5ev1P5m?=
 =?us-ascii?Q?JBH3uau9OAVHHFwueXXHpRVjMQ6PFKUO2tC6bETQAhBDkeosBNmz3PiHkLsL?=
 =?us-ascii?Q?TbXUCU4j9B5KfACxdfMfT6csfddyJ2QTyVP+ZI/KdsQ4jXDQIwnxlZ7xdSyf?=
 =?us-ascii?Q?gTUk5WZQbPAa/mnw+lEeh8X9ULdW+m0AE3MSukF0rvesRaZ3zK+w5bn8K6Qz?=
 =?us-ascii?Q?YAgTa36nw/R9HZNkKxk4kMhHKHmpMQlHC6HcihHoIWNmxoCWMVUsWAeQf1ql?=
 =?us-ascii?Q?tPo7Kk27kBf191EQEsOfSeK15bQkQK0AQX+XNnCS4y4XcM5bWOzv0BVh8myo?=
 =?us-ascii?Q?w1W3nayzj3NUp8tAbQ955+KdoKxCVhfk+ynXU2jBIPXSNsGzEO15ECbo7cjM?=
 =?us-ascii?Q?y3T6M9CSs4TnSBwMK2J2sYSZA9wWmSgUtuVzWjNinWn+INsKpi4TRJ1Tuybp?=
 =?us-ascii?Q?eb6HpnxGpRzvoqxidTlJQl7tJXnSjlxL4j6a+DCxt+2cLcysDujAKS+eTV3z?=
 =?us-ascii?Q?yvNxrx6v0VJnl8JSNRI6C3TpmEf83P+GoDTTEchi/AQx0S+61rdeZlc3X+21?=
X-MS-Exchange-AntiSpam-MessageData-1: ezdR7tc9ZUxbkw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76586b3-8c5b-4ea2-abc8-08dee098614a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:37:00.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3KeaV3Wx3LZUNjvPOLFS/WRPKDEMKcn7tdcbZ8tinUdlMLqeKGtybTSgQomyAlLCeul67K2Neyj3O0Ke9IAszY5qPhr7wh6FqrXOtIkdGcePZ7+pnFGd+pXxOMpxypl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

From: Luke Wang <ziniu.wang_1@nxp.com>

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() to
simplify error handling. pm_runtime_resume_and_get() automatically
drops the usage counter on failure, avoiding the need for a separate
pm_runtime_put_noidle() call. If it fails, the device is unclocked and
accessing hardware registers would cause a kernel panic, so return the
error immediately.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d980dea9cad1..7818f351a58a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2061,7 +2061,9 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	 * 2, make sure the pm_runtime_force_resume() in sdhci_esdhc_resume() really
 	 *    invoke its ->runtime_resume callback (needs_force_resume = 1).
 	 */
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
 	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
 		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
-- 
2.34.1

