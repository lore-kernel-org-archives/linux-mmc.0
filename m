Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7934041F;
	Mon, 13 Jul 2026 04:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917466; cv=fail; b=glSkvW0p6gajJuqZAvSvCHs8gaK9jUm9EhKT7PHj4cbl3LHpKhdUHQMV51bwjFC/7nhulDmtwU+7eA2Cl7+7WTlDhuRFd9zv3qU0QvV0/jCjR0wgzHIgOAvuV+gEVDE7n9UxrzMH/QrflARWtIJcgcObvXe7vWKu0MsCvFoZ/rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917466; c=relaxed/simple;
	bh=zcozPL7FAOhMwldMhWUxN8H+G7GKGHBH5fge8ZNr7Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3fHGBqchnihCjilq72XDP6ZJb6MCueOFotd5osWuUfXH0g15gBKV9ZTRAjnvwgKSb8N5k9bswVIo1zGCsNMZPpPVKvr3kA/Ik1PhZGvZvtlgAIqd2zlbTmpgzNHlUPnqUxV2UvZN+U6FUiYGPUmsXH8Olni/4WeFX2zd9l45sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Yih2dM6G; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Yih2dM6G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQHHb2FTJZ96Av17Gyp5JgHB8hYCnpEz5pdh/0ppbgMBsvCQMjHpBNMfycJ5lVShcOSVCehOfzEeWEfEDbyAgEG76sWgytCrxFBUGr3EVacrIT/zWdPsvos7gUCyPsvlKS8IW9ukvaUmpyVeqw/4korGj+Ptqvs4s3S9hiAR4LvAdIOBled+cmL5l2xg+/jg1CuggNeMKJWUyLi/RusEtDEtSy94EP9sDez5pwabsipR5M3uw5ERyf//bHPyoBdY+ufToOEnIHaGt8hAMe+J9g1/tJKjMfc6V0E299WQK+9wYTaVFgrzmbydTFBhQwUym57mknVb/c+EGFF4v9rglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOBkZtYEEYC6xsmQhTbQrTqOYQSf+n5e+gTYpxGGGPs=;
 b=Kq3kcEGPMMzAkMNgZQx52DaTG24rvhGBKmV05J67CeHVBzRG986GSOgvteUamLf1sNa3j9iYMLbbbHduM/3mwoUx1EUcGEmWm/bKuq5EHzQgMGCl9GOiJzpgEK/aIY48173jL2/STI3nOU2h7iPXyX2ezQauAggI7dslbfhU2OfYU1zZ0ZsVY1W+5DIjiea2dfj9ids5SQRXRnVZojfdoTAZMkGb7gJ75xbbuFFO6yCRkUmLRvDBm4Y5jYJb/7olxi6Gxf1XxfCsWq+JWAl+g4P6gXbC9kKXKCYX1gB8O7DvR6Plxxs7q6iVGiMteBjsAIp9HDNgbM3yPKRD+LkNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOBkZtYEEYC6xsmQhTbQrTqOYQSf+n5e+gTYpxGGGPs=;
 b=Yih2dM6Gd7hYhOFw9jxTbY+ql8/cswRX0AnkOzb7gp02KEwufEftAJWNybPd90ZFv0xfEz3FFvfZkaRWBM1Na4C1qYbJb/FQBTXeuEf0vs81aLBVsWSB2ajOTgKLpDo7Bc7t7uak/i1Mymszlsxc3b7VB+smobwmIj9LskR+IXvB/StuIV7b/jNUwrduJSFL58Ai9SePYsGgPlcA8APByFaH44v4OslAgkPdMfW3ZxxSXq4HpcAyrT8kOhm41dTgsNhJET7Zd5C+eFzZS9PW3MHR7zcCciJpeIQaWoFeS1WbOZ4CPg5yBMiScudLZ3f7dPp2cTS+ce7Xfd/wz0JSmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 04:37:13 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 04:37:13 +0000
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
Subject: [PATCH v6 8/8] mmc: sdhci-esdhc-imx: fix resume error handling
Date: Mon, 13 Jul 2026 12:39:04 +0800
Message-Id: <20260713043904.4144172-9-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0224.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::16) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: 715ddee8-2dec-4389-255e-08dee0986935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HmOAN6Gc8V6A2tiH8EUnAHUm3nx8xk7kodQThPzzY1LMfTeI0faSpu1X7rLctQd7GteJpZtBpq6q54/xS9IQ9E0PoYLgg1xcy75xN/6aSWF6CIxUIjGHYqh8y9b0S/a3RakzV+jAExnJGWMPkGeqcxbMTyf4XCUk9rxfSCzvEL5vpAxNl3etVumXz4bDLDqU7/e/BWL0VujjRdcb9YbKPvAtEC5UYjJW7rtxPEZw5UXXU1nV1jVXazp+t5OJ0LobM/1ruFqjT3S9wzoXcPt4nJufT5G5cKEOhhCKpgYq6djO2rhyhL0NmGBAVvMASKyvRSpqIylYclLModIYAdanTrknA9sdCSc3T9elCwkAMdRLYDjzUxZ/4gHIhcDxFx9ZmeWXJg7W1Cpll6sAY+WocH6YBzZKxxiT1M35pCXNmVy7cdwXbnKSS9A62AP0GGuvF4PkDqhyXSjIMFBQOF57NbHsSkSThPqBdgn3FGS7QyyYTIc63F5St7s3x6R3vXsfF0KIkUz1HdoBGxR0YIEj7zYrczUZXsR6+HsLw2smPcPjO+/pCAkv9/hvSgP91AktyLFnIcOyJq/LRVnogljg3eYOmlEtIyD38GNGSRotghC070kpLgHv2YR+syAM2EO0BxZG/1R0RtvSBbxWwDLUOKTaGaWLEfK4vxPPxxS4Agw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NMbs4kqIyA3lZprm5EYy3Aw55tM6RDxBPOIFnj8qi0ZB5e1iukC5U2W8o8+?=
 =?us-ascii?Q?au+saSXGq8wHL9pT9G3mh9AC0dhReJKySKd/p7vR7Oyrt3ZVKJf+fdLS5GQa?=
 =?us-ascii?Q?rI+QMVdUC6G3EttOlMRZtu0A/gsKcFBYV2xR0ZFXoCCSe0aMt4EsBl2SJs4C?=
 =?us-ascii?Q?dlYq95Gno9VQ+AGvmvgatxnPXubhD4x371vcrqs9t4KaBP4m49eU69bQUbI8?=
 =?us-ascii?Q?UOrwgFFwe0fG+9Bcaj7wqB+jmuo4mNYtWZMxe+7vFJ313YKjV+HH0rUy48e3?=
 =?us-ascii?Q?t2y0vl3LTv2XisKVY5JYs8iQbjdcY7rvcBSsnn4UEkiQVqXmEYLl4n97qDFD?=
 =?us-ascii?Q?6rRbwOBLUbA67d6qzwHDZ114ZJiRW6qo9i8PNaJ8Lu3Ult4gseuy6l0BDWih?=
 =?us-ascii?Q?80RGehzG0c1mRqgSs82FMPdLORtC6IVx9n1tsVwIojRIJyqshHKj1Ms/uF1C?=
 =?us-ascii?Q?k4J+JkC9sVlquYiDyBPWAhrE0zxTU4D3snNxXgJB9lTYa4QSom2+9YlxAYbn?=
 =?us-ascii?Q?FeHHK0plGMa3Jj2y1xo/85tCRlqTd85GjQgxj+ugtMsP9GkcOF6gkY9eU+1G?=
 =?us-ascii?Q?kkKUgWhfbpcC5fNaMPNDE7ZEGyFcO1n/f1P8xb1FMZJDK7nnUx2SsjDSwggO?=
 =?us-ascii?Q?rbOCWA++6rigctG5znJDyVQDWoVzKZt6/fFWsQU1COCqoppDVaL04yjiILuz?=
 =?us-ascii?Q?sN5pJid2YBxRJCzKIN5j/k/lME2itsU7KILQPpQYXBIS5BxgMA/vvcR2vbBH?=
 =?us-ascii?Q?O4HMxIiVHNkkkS0DKyG4qZmFmKQituv3SjL56d4kPtbrRsWAxnSy2Up6SxSL?=
 =?us-ascii?Q?5Bkx9Uh5vc092FrBq2kiNuWnopcRMXiGS+1nFmAlmzCC9ai3dklwDPEOxsEJ?=
 =?us-ascii?Q?KTOrR4xY2UnMrQ2ngZSJD+hRdid4jqvMrhD4gk0pdTUh6xbt5k5C5jA5+sbz?=
 =?us-ascii?Q?Sn/XySj0xBHLx2wV70D5vYduTHwH+uPZ7GgX3iLDANSjZmqRV/J6rO/FhNBj?=
 =?us-ascii?Q?6BAeOw9vGcYwb5I6jv4nDRObchfRIcvn9QYFw5QA37DJod6KL4oVNBuO3BGg?=
 =?us-ascii?Q?kvP/7SbbEtfLOs/NcBICirGytw6k7IyWKh6ok9PHTBLBNflNJJgwbq9LDKVH?=
 =?us-ascii?Q?kOCCXJr3AUgPLkhGdJsSEPqPkixODaHqMQYkiddD3SH3S/AbTzj+Oz+djSmk?=
 =?us-ascii?Q?mMj8ifYlcRdfuusdDXdQtrRGMrUhSn5QEuog4m+0herriaLP3b+tRzeoA01S?=
 =?us-ascii?Q?PxeXioq8Gyl4vz/vbA4uHxLRjQK6ta/Rwc9ZZ318sozNuTov/nYEcA2emeyl?=
 =?us-ascii?Q?VlJXFXr5LWyPj9PtnCpxsxkl2NZ1f1sVTe81/flyZ3hRJSbPa2YkLnsQP6WU?=
 =?us-ascii?Q?rjBvHK0nEHNpKeoN2rLh1lxKY31nBtYLr+wAE25iDluvxcpDt5NweqpEMEUL?=
 =?us-ascii?Q?GTA5JDTumkL9i8W1m3+fKbwfbdYso05Kwe2bnUeE6y+8K3/r5vehcxoCBiAq?=
 =?us-ascii?Q?n3UaXtvLik5FT+QkVxkSzEJEMxWNfVu2lx5KcvypnXOqAaP7SBjdCio5pE5k?=
 =?us-ascii?Q?7+MP+u/VZThK6Tmyfw+FPQdhzirOejruuPdmlTU4Nlz+R3XcsrXo9p31U6iG?=
 =?us-ascii?Q?2OvWAeI4I85sYCau8NuYIDhpRgULEXJYn2byt2VfYWQvjMi69YtaoRjIJEyR?=
 =?us-ascii?Q?ivCF1X1YfWMt2LqzDRM3vHNa2c9e8+zmZjmgz3EILUm14DVLrgXRUkTxmNUo?=
 =?us-ascii?Q?h2kneZsb1UBnK1ixOSDjPsfS09Cpamgo+5NPp6rQN1LxaV9ATyBvmJhqRLZe?=
X-MS-Exchange-AntiSpam-MessageData-1: 9uxA9SP4u9FHug==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715ddee8-2dec-4389-255e-08dee0986935
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:37:13.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz+WyM0YhEnHZKR9wyTSR4jSxZW42XHADDtdOH/Qb0n8Ki7xTFOewLhSDKAiEXItVBqbch+PzK/jMjt0CiNv80S+2m0p6lMo7qTf5QhXA+tAyf6+xkf28mLzMCGBGHYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

From: Luke Wang <ziniu.wang_1@nxp.com>

Check pm_runtime_force_resume() return value in resume. If it fails
(clock enable failure), return immediately since accessing hardware
registers on an unclocked device would cause a kernel panic.

The early return intentionally skips enable_irq() and
sdhci_disable_irq_wakeups() because the IRQ handler reads
SDHCI_INT_STATUS, which would also fault without clocks. The PM runtime
usage counter leak only affects this already-broken device instance and
is an acceptable tradeoff to preserve system stability.

Remove the return value check for mmc_gpio_set_cd_wake(host->mmc, false)
since disable_irq_wake() called internally always returns 0.

Also return 0 explicitly on the success path instead of propagating
stale return values.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6cb84690fde4..f4bfb14423e4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2126,12 +2126,12 @@ static int sdhci_esdhc_resume(struct device *dev)
 			dev_warn(dev, "Failed to restore pinctrl state\n");
 	}
 
-	pm_runtime_force_resume(dev);
-
-	ret = mmc_gpio_set_cd_wake(host->mmc, false);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
+	mmc_gpio_set_cd_wake(host->mmc, false);
+
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
@@ -2158,7 +2158,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	pm_runtime_put_autosuspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
-- 
2.34.1

