Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A13D953B;
	Fri,  3 Jul 2026 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075212; cv=fail; b=pnkdvidX9KNED2+M2znuAtT+Eg4scHwC68JvizMjQrlOpPgoxNbE+xB3PjeNq8koSDMj/uI5z1DlNmlcabSIWUNLvwBEwU2S0Mt1XqIckowkVs82rObW2ggrEiBJJlo9+HhrPuwYBuozX32+t/a38vsIxzoVtcyJkijpDU8zdvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075212; c=relaxed/simple;
	bh=WGFjESuE+CqWwT1qFUEab6g/Hp36byjFfzpwd5U/s7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AITzfOjS3eRaKcu1kmW0XbkEtrYUe88R6HYkTdJI+GsbPTXTAPt84zA5cNIevkaRNAMq1sMaoPtNRdE/NCBeR0SKbFuFUr9k4c8WpJRZP9Ah0k8pZnP/HH1zWbNOEd81qhQtD7jcDIqSI3haMFvU4yTuPhDEK9vbf0ZMtSfoEjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O6pM4Ciu; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O6pM4Ciu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjwJT+rqsBDAZn/FOFC0gQRCI/DMo6tW4nAXlfbLbGwda9ukvKIe114QFqGQrH9CEmjE9MfYSgIknwgiOMlzxKY4FqowSHsv3KiAdzYNJpaQZNTGsE+llrCMKrQ2deNAshnf3+qZ1kDioGEdYS8Poy3wZsmeVNqg1POR6Z+S2UKFXkG/F/srDOtPeSmEfV0RvA+FeA/UwdlnPOjw2Oo8Ug5u2puwAkWMcjZZ27ARsaJy6Oq6zBho1uyvByEcjo0gbwB8xv1t6hyFU9ahN23dAuqY3x4bOiWZQiW7nxaBJ5hs31BCjeB74wE5sMcBrwyMl31qWNtpxnkkaGCz1jF9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa607C9JGHmsffQag2rTStFpvHI5E2ab9fHvQQwlgcQ=;
 b=RY2dIYbKmattOBMGOFI+Xp7wDvqXRkaokpHcIcyUqX2zFuTc59P1dEsFyrtEJeKgrZoz6+flP//wN+hrunRrYXIP0kZXSumuLeKmeVEMbTKysvLUooYS10T2dfkaPQ1LJSOrkB/Svuq22O7de4yz6q0J0+FLB8PgaV7TskCsP0lOac9D2fZQV5s/D9ndQlX1bamomxDyvq2Isk8RSVlHlQ47jhS3J2VnsPPREdkXO67PbimZZG30IMklglN5arYucmiO+h36GUQmxlp2hUDYPlSLWG70dHg/IBeptmBxfPMe5sjW82DVOIiYPTiez/nrKhBhyi2w0oTqu8VXwHU5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa607C9JGHmsffQag2rTStFpvHI5E2ab9fHvQQwlgcQ=;
 b=O6pM4CiuusafeGIS3v4Zi16s1Mj/CFFzRAW+CHXpgDjWayPpF70CPqXjh9l2zeoPO9bkhhaf8IvzJLWV4ldQX0+jYpU+acsayktjVc4wGYnqq+D/BXDjpIt5wR94DYYu0o8hTZCJ+ANFe2DKrd893skXAf/GFPoSUNXeQyW5SwdsrkLVNb1PbMIgjHSgrnCqhcF77hekde7Bra7FLqeAr1WScaIkUT3ldgu5qNAnUMY8Q1FqQSHreNNvPQnEBxFxr00qMkY6PNgyK6pztZa9GucFvQAjx4ZV7qGtKezFB/2Qera82aNA0o2xoSd8vWRucWulauOd9Rqw11GI3NwP2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:40:07 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 10:40:07 +0000
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
Subject: [PATCH v4 5/7] mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
Date: Fri,  3 Jul 2026 18:42:06 +0800
Message-Id: <20260703104208.3426374-6-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0149.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::19) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|AM9PR04MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: 098c609b-7a2b-4e23-c505-08ded8ef72f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|22082099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	lR9Xqcpo2kI6TB1OIyIB5DJhZDJK4mU7iSwAGSRLpgqw9i3zu0DuO3gSH974mpEKgqkR926B0YgrJIWXptb5V0ld3GNK/s5tbm6olPQnHpigNL05qHHCiVlXaG/5aTQ8iGJL2qskBTlnWh5mUHbf0AHEWbfLxDxu/afV0e9wJHNA1Zgu/RW0Le0SSWD+wPEavOjKZiagslgaHQE+jwDIMHq1MnHyAg7dP2r7bfyWqLdIy7iGkLnmWzkrKZFU9WNOPDsg4crET1Qgf6+EAh9yqo0hme5dkU40+5xOxbCXCTIM6h/hXjrfNC4uKQXR5YMiFkzWEn9+SM26ACbiXAqv2vw/OpGFV1j5L94DG3Y4pCMEtRUr6RIh/fSOnIIHS3TftdwNIvRE7Oew+e5QbD3Mmkn1a7fuHhJ2+dyUAjc7IkeU3EqGw3npQjkRMAsxSedWn0+pwjepYwKkw8OrszNeycudmeHGpyjP1j6N/F/FsLcpuatqGkWVYceo4vZJaoKSBpg5wzqoVxZxHmGUa6yybL5U01LDyeGwrzz0aJNljKIafybG/ER6FwnbskAX2h/SHFzymDxKniLtddwGil/MLqA0h74RCUaAIJ/yT2IeZqDvX6ljDFs9k3KyftyMf/0b99kpF/Lxbcpf9yPkMy7G6A++l9jjDq8v4U4+Cr6OyF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6p6lx42bGHnhe+DxUcAXxnTE7dO4i/Zoo6346TbtXy9VRY6GCqSABW7zz+qo?=
 =?us-ascii?Q?tE+/cZI0Q8elHb1y/GIGV1e4cF6R+54+5nJBmAdNJcRPM2DUchSIAL3mzX1K?=
 =?us-ascii?Q?wryKuLDKjInAmofOoM5ZBQnmpr233tu+Yxtl81rlZnb5Q+rOTqijERLDjIZL?=
 =?us-ascii?Q?uvQtBGkh8RxENYifUwGpDqk5/4ltFmf1aHk9QUVAaUYVP8pH/iNnLixQV898?=
 =?us-ascii?Q?iqemnwX9OPE/VnX0XOIAj8IB/JjWn2gCAOjTOOPg++Nkir3/+i1K9Fvrj+Z3?=
 =?us-ascii?Q?EPHfF5xBaLi4UNUCPwPOECcfiYtI6vpoOULKw7pHbF61rf9RiS3k3dBU6/zK?=
 =?us-ascii?Q?eCmglzu6nf3KHKgzfJ69/f6LELKmqNxupoCtoV0xq3z/+lvKXQ0QkqtxLjYi?=
 =?us-ascii?Q?L3Egz6vKyFUAhcWUiT6OMqIyFmOTeSQjbgEyJNVc4QAWLb7ZEGwZKWSWEMgG?=
 =?us-ascii?Q?gSYzgDIwDYKdki5iAmQfRK+O3VIs2761iOuFsDwrGBq5ml2KNe5ExdwK/vBm?=
 =?us-ascii?Q?YbHtYj6x2dS87120Z8J0NXL+tmPexUCciJlYuqhqaQGZUmMjHTGkFq/CyDxz?=
 =?us-ascii?Q?o/6F7AWcURyI72dkS/ZBb0fP1qs+GRzlJZjmGlMQGHMrmVftCLGhnfu/GSyg?=
 =?us-ascii?Q?ClqhbNFNcOKcVFIRYuJzqSeG4n9ZXHtuNhJOFN2mBxi4ZljyxaFsPvnFbj/z?=
 =?us-ascii?Q?NuaJwCV+xT9ICl+09zM/iE9UTePLHFGQH/KMUwwllIxkJKgEerOrQQt02yvq?=
 =?us-ascii?Q?3CGzJoOG7pH0J+vKAXYhs8JlQ6j2Fyf2yqEA+oBU7TxY/BTLiRdTnhW6v96t?=
 =?us-ascii?Q?UOmdRKHLq+CuLyzFZOrqwI6Q51C4aqCtoKtdTkFborO6yg9YQQvnLhDw62vG?=
 =?us-ascii?Q?NOpfou04/sK2Ys5SScK1aX6YMBxBiCB/VHqVrG3VV9pR6kBPTaaaN5UmVmTo?=
 =?us-ascii?Q?4FvCaI7LO1ay6yEUAYzyfZwnUTgRWotfZpfz0dfTYv8dP/bfm+iLJGpMS+k5?=
 =?us-ascii?Q?Dqm7GyyXyZlgUv2BchdRsRTHjPh0+8q8syrWUYrSdz63gVY0vXoetjTkTUvT?=
 =?us-ascii?Q?KUAIUgEuxs9z1l2/3KddcDu/1f4nrM4hA0J+zC+JXcS0tIa4r4QMcpk9q07p?=
 =?us-ascii?Q?EmtEVq4WBhrY7np7acEJrGiGpXFCETFNUfEh1KhQbAqgnGuwSzDHKtArWVcC?=
 =?us-ascii?Q?hGDjJTPrRlslqmrOVHICHgyf92cxre7bxaFX+XGXgE+oHS/XI0moAz0oan/8?=
 =?us-ascii?Q?qeTZVaerBMzKIrpi1PbPe2IHg67JoUrn1ZLCkRq+Swl0pykkx5VI/Avs2EpW?=
 =?us-ascii?Q?AVlw2vTRJ9u9B6TJFLfoSnPyzwi8W7hyoL6Sjz0tsJvzD0on8uKeGjuGzgVS?=
 =?us-ascii?Q?kafOKkUTym3GO8Ej6D/Zi0tC0cMiGLXNcBOJu/AbC3rt88lwaCQ5thrzsn8X?=
 =?us-ascii?Q?3ZPIwq0OFEFzwUL6fs/F7+vWdabRGiO+h+U20E9Czf7YrOl2vunT8KH7y3xM?=
 =?us-ascii?Q?kEvrm6En+A3pmvBnUW0MQrmZfFI+4UZkRKZVD0a/vM0oNMQeTdVmVpy8Rr3B?=
 =?us-ascii?Q?f55oT+h2V7zXwi8i085dTHxin93c/9W50wO+uPPZmoDTvxou59wgzY8zej7B?=
 =?us-ascii?Q?VDr7G6KvcuY6iEGAvqZ+w2aFlfJmhWnXD/6t+4eiTTvkXY3hNlqKrh2d/bLY?=
 =?us-ascii?Q?/xDeFe+hv9v24HGIfpYDc9hXd1bknKAWA9oqFnK4Q+G1Y5ndiTvqL/LX3Cdo?=
 =?us-ascii?Q?z3hGLizY0UMHO40hEdq95XGmtIwX4j7ppYvqAzQ4S8UncfRui/+2GwsKFS/S?=
X-MS-Exchange-AntiSpam-MessageData-1: Hfb1vTYo9GqZqg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098c609b-7a2b-4e23-c505-08ded8ef72f5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:40:07.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf+htXn+S7ALYha3N9clRn0B1uA00tfNxX7Bw9fFHIpfI1xlevVEvcx0zn1If3J4FMSlmlM1g+zIVOwwM9MCdE8sIhG8fN/R/rkVwFtFccgz/YUeNAoumEHQdnKB13E5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

From: Luke Wang <ziniu.wang_1@nxp.com>

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() to
simplify error handling. pm_runtime_resume_and_get() automatically
drops the usage counter on failure, avoiding the need for a separate
pm_runtime_put_noidle() call. If it fails, the device is unclocked and
accessing hardware registers would cause a kernel panic, so return the
error immediately.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ade99dabdb5f..30aef7bc1fc6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2059,7 +2059,9 @@ static int sdhci_esdhc_suspend(struct device *dev)
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

