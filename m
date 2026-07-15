Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437F3C1F26;
	Wed, 15 Jul 2026 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099805; cv=fail; b=EYytsC0dEKbHC4FbX5cFg/2QgFQMZHOV/eNYi9258B4baommx3yUh8hKX7ags/DULActzK2j2H4c0NIoWgkktQAnemQu8LyluiEBOop5hW0epgIcelmMNUaF4BYRyPielCLYFU1WMxIqfbyvOfKOTIdsW/Fiot+xBKTJVPexBAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099805; c=relaxed/simple;
	bh=pHZhon/gBcAdCVOfE7E7zCX8pvG//L95q8KYgE0bzQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=re++P5tIyEzUQ+z9dup/yHh3aJpD6CW+MckqUoTIWOwHVgCbQXsfp8tFXCLLHMC1ZtaG97JbjAMuQjBFL6zVWvCtdLBdI2Tfw4ItgqJd30obf3/zsL07Dx6whs/buDUdkrAxq10BT3o0Cv7/mEgEN8bP5DGuXPfJ4ssUMBIlIw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e2DBlhyf; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e2DBlhyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWWnL7HWuIrpuhkOlRNzg8eVt1PRXDj17hsXY2JLpviqfGeDzmX+PScAMG9mQP5outwwSlg3gO1EHMd3HyWjENY+43i2QSdOTw+sbHORWA3v8YrJ5w3JGGPCE1w6QRbZhmi1xXgn6D1kOQdYnDnBTZin4WzUNdV0nd6l5S4Q+NnTZlKaQsRqBP4LYC+/J4hWc1PC6zwP0sCJSrvXLqXLJs7oakNtXNysReQY7V7b1DI33+GR/YP3O+rbzCaatXHE5g/96PafSuqRyZeR0dojfm1qj0V7VqXhp4on/JtSWWV4X+WjrObJGXo7YCrLKsNG2gIKI13RgHas9979q95gIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsjR81t0r4bBDs/N69lOOpDUoomObWby1/SpjEobj9I=;
 b=gLSOtj1+JFMKMx+fml44hAl+SLswYoajlS9MSKwWfTOXl6z4uHCcs2kgYUzX7PYSpESJ27LW439V9fyt3VZsNAzJn4wKXAnUTHcXzRAMljyOAh/pyUCOXA20i73JhEtl6AYh8kD95jHI/NtHpvj3turoUa82gi09napaOYLx6/7CvyIDUDwPQfHgW4v+LaZ28mjo1z/pBZZNdbrETbkDSKvzAdV5VFl6bbB5HRL1BOSFSZck07ZsqA9rwjXywS16afy1zu3/BIV/ve5uFpT9XDYoYpQJLAwpbKwXlcXqbFW2M/yPII3aJoggz3S6KAAoVc6eYxoaehh6S9yEI1/tKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsjR81t0r4bBDs/N69lOOpDUoomObWby1/SpjEobj9I=;
 b=e2DBlhyfuhHy1WcuPxP8y9rrHtoxNGZ88ExXqAkrHBADb+jGm0KAf0yDYCKRJ88oCEnm6ZhSOtz48hl6Hs9TemTo10ZVMq3uexM87+UChGnHBS3FJsWfBkv8YB+l5TOIPSb2ByVav/ew8TfHAmoO/15JpcKYVHXHz+ifqlRNeugK1pfivoZ6mpByq5yiChyyOj8L57XI2Oc0pDb914odQWyUTiO5KcOUzi5pAebuGrS/blyeMu6uc8uP1CQM/rI8Zxf36NtFzMH+9Ru4FP16LOoD4XiVwntw08Lk7A87pqh/o9/URARTBisGL9UAOm9rHfto8ZLYi8ZDx8sdokdJ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PA1PR04MB12197.eurprd04.prod.outlook.com (2603:10a6:102:560::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 07:16:32 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb%5]) with mapi id 15.21.0181.016; Wed, 15 Jul 2026
 07:16:32 +0000
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
Subject: [PATCH v7 6/8] mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
Date: Wed, 15 Jul 2026 15:18:16 +0800
Message-Id: <20260715071818.272318-7-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PA1PR04MB12197:EE_
X-MS-Office365-Filtering-Correlation-Id: 893d4a6b-b72d-4612-3f51-08dee240ff1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|18002099003|22082099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	vFlYwoJK4Muh2s25CTJJqMfn0xXQ/JEBhd9xjHD1DBn7hrfl0lPx1/B1ENMcdJe4WSkS6jBfe3lH3dIJk+Dij+imvcrgDrDCFfgim5Yn0yMyTqvMCCYwLNgggTWOCR4zuofThd6382fmooCrwgQ0LceRJwKP7P/E8T9AlCfufLn8Q9yjUMi8yCauRQH52BcXJLXvbatQmAVLH9a7cWPtFMYbRCqEDBEzs+N+Upmx/A92+rKHhilqPtTmtFFMMkjq4l8I84ZRa2Cn+1UblZjoHiW/lhudQOyxgeoeWcdlb1j0lChr6KHI/supDjSlx12DMmnjwFOk52Hd1PtylrHZvbqAQ0QVeiWOVPXUdEB6igJLRrbq5NHsR37PCHQ63NABzLP2BOUFXM7sb2fm9rd2CCPrHBe8n3B0RjD4b8/5mEZiELMfKa444lv1UuXa3rVD0nHN8CV76rNnvrWoLEwOT2EclLJ9LqUiBtO8U5xelq7FpzZS62LdyDk4aNB7UbPZlN+XiXTAVRkcNHmT8gNSGfoU4v7wneG4DFq0EYhv95eGHEKdw3KEvu1kemseJNwFXX7DL0mni6M8u9wg5buWTN+oq9as522fM/QAprmzRW82zgbf9hbWw8OPRICrK3IIiPvlGdUB7wV8wOlyGRO9rQhUeVdygfs+VUfxEZ3h59w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PTlbTeOVuLMbH+Jjvj5CX16tuV22eQl+BBMDsytZZbIGKFJDNzrhHoP+fpJU?=
 =?us-ascii?Q?BHtE9nL4IjNLZFJDm0G8pS5EypDl2Bq6o5+YwKPpYk7tH5JSuvmwy73cVXRp?=
 =?us-ascii?Q?nBITmoWYPyroeolSBrS6YaU8vxporpmAk46P9Mga7T+FH/QfY5ztcghqTS1+?=
 =?us-ascii?Q?MVMlbllSvdM4FXFqEijnlS5QkK5yMGqDvcqhLEG9cOdQ3GyplsABjR45AyDs?=
 =?us-ascii?Q?+zIB5LIocEba+6bM4KWvjKQSvjLhBdC63n5fD90XjT5iUvNfWN7eMEsc65VH?=
 =?us-ascii?Q?a4ON/Usm1Oqo0TBv808jBaWE+iKu7hnoOhkJxUHudpEyBJKQ9CFLKW+/kuZb?=
 =?us-ascii?Q?GqHHfkuOwv4O6K+UAYpoK5CkMijlHzoW85gnTbKP/EGwJFWCEI0pSJhrIWiz?=
 =?us-ascii?Q?bo3u1ZQY2+/Co6IonEdg3QtBeJLzbH+CG+K723NKimSZx8t484ngJkhGM8cn?=
 =?us-ascii?Q?ELesTkWv53Qjocf2t1g9rV2qCbDn0r7F310DBxpd+dpqIzxpFGgUABXHbE+V?=
 =?us-ascii?Q?fdX6wRMs6uy0Qm8c8Dmc2PNyz3ukKvZW5WfVBRqjTwJv7VjtLivi1Q9Rbxyc?=
 =?us-ascii?Q?3HAhFbAm6mDFBo7LSnI2e5bAKk+v39pILgw69E/AADBFyPTaTJEXFb2FhAlw?=
 =?us-ascii?Q?yg78oSHvRRp0P9z2/1WN7HgbBcfFShBaewQxz5yHYSXH0VkC9RSgaX8Gu0Rk?=
 =?us-ascii?Q?G3xBPKn1322+QEMmGSCCZNxDoPr+VVucaiYusEJxKrqTtuw/YlnfQRWyBiMR?=
 =?us-ascii?Q?RfeAb2Nnoglb/g3aIeem0/hgOLdqtwaMQLpvCOkLWrgn6mlsXE1X0jAvbWkR?=
 =?us-ascii?Q?W7LmTU1r1Vhlv5eqP47MJabZvrO1jg2y8QUTwHRv5NG85JIlvTtpjx17T86d?=
 =?us-ascii?Q?l9d+tF8/PK+b2lxSTFSKyX0KoquuUKMfVhuKw00pFsbDUtfP43l5zipaC94E?=
 =?us-ascii?Q?x12OWknMN8+9KSxHo2y6Wvq5i40/EMTiG1Gq634oy+b97aZ7hQz017CCqH9K?=
 =?us-ascii?Q?Yyo3qJgHDy3bZlHit8uMqsl87/ZTbTEg0GruxT1pTIlA3Jif0NjFDKVH3BcA?=
 =?us-ascii?Q?wBksqXMxb2817sNI/wL9SV7LiHQglvEG54KofNaoGXTauxrrKKK+tHnTJToS?=
 =?us-ascii?Q?VTNfwDSVFfmVV2TuXd+/jtzpcDokOrjOoAVk7Zg4OQmtw9/ca8BRlnUab1Cf?=
 =?us-ascii?Q?3rAGRHuXhDWpU79cddhm3um/1GDlPtcZp7VZ29b7Uda/Kk7Vf/cYefgoQtdd?=
 =?us-ascii?Q?RpzhMAPaCw1WP4wqlZwh70+xZAn5FkCB8LvQzvqsDzi/TnjMOJebGoaC531t?=
 =?us-ascii?Q?JV5CGu4eE0y1+TqH3qpVQgiIwTinIV0gseZ/HoLZfCWOyPRRVOiiuzPLcwCN?=
 =?us-ascii?Q?DocqRvQTiMZ19OQxGn/h2LjX678ZP4mcLY/k6zvF3Tht8yaydny63J6rPz2b?=
 =?us-ascii?Q?Egv+1IZCqk4mQlVBVybHeHnEJBK5xdipVxEDudvW+RYPwvbcKHO/poA6ZDmJ?=
 =?us-ascii?Q?bfQtJ9Uk0NYFSSSrxFwCGCpURLkRURb+vZQqkEapHXdn5U5TZ98RVrMfPpue?=
 =?us-ascii?Q?hlTDYBgLK04Iv4pwSBSJWnWvBZ2ZaXet6dacMN3O1LvGYsq6T+Sum/KKR8On?=
 =?us-ascii?Q?Tuy5xwByLPqFlvzywN7meoCxHk3YzOz7L7THL06SpstUedazu6aUrJ5/WTCx?=
 =?us-ascii?Q?OwCgJ8uaCa8Za1ulOjZnNFQYNh4P0opnDNs4ZYz8bj/FPO0Q+LGbWtfpCtBw?=
 =?us-ascii?Q?+2xgesWndLaWeFIJdOACH/Na8y7GSnkEWjO4PewdEbWVMrE+rZ5C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893d4a6b-b72d-4612-3f51-08dee240ff1a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:16:32.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBxX9QV9Y1PgviqwFLsZrjKtLgUgEzw1DBA6HTGkC2tBJnuAnNMjvZDzg6NpUHij0Cf5vVgiiWE+5vgylLFEV/CFiphJzhKSo7aE6A1BMRe/DiHNaCL35NngYPn9VpkR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12197

From: Luke Wang <ziniu.wang_1@nxp.com>

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() to
simplify error handling. pm_runtime_resume_and_get() automatically
drops the usage counter on failure, avoiding the need for a separate
pm_runtime_put_noidle() call. If it fails, the device is unclocked and
accessing hardware registers would cause a kernel panic, so return the
error immediately.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

