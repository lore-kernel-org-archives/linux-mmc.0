Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC98403E80;
	Mon, 29 Jun 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724677; cv=fail; b=Uyu3hQ8bnItkuz4cZuqE/OU8diXVvx/lHTliMYsQapdBLABm+ht/zXNm+bEjnCEfFM34WY1v5ODBoAHzIFN3KMQ7S8uIv559UHl+kfgdDAV1LcdNE6RXGW3oVANQsID998hEcw7BJoSI+JWVccTg6sRnx6iNchCv3HZekrNcE38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724677; c=relaxed/simple;
	bh=pSiCWl9DQh9gNCcIA+/vBDRNErYJAAaOOipF2yregdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=URevLZgesfHL4vaf6S2DQIAqgo+jLxEV7MycgBljp+R+L7PV4jinc2RcOZYfKrRxi/n9XmE5tJWEvNcEGw8wev3m1Yz9BMZKBRW+UsT/qmT7n/CgQu9Nj2lmVXzmWlSQiBOgML7UA5HH3cWGX1y5k6wKorkC3ssIGBvM0acwyag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g5CDTcWB; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g5CDTcWB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twj9yXwzAp0x0Ad+tx3d4i11XvXBtb44bC4PV0uOe4Rnf+az6fL4p8j/w5j14EDCUT8Od4a37Ubbkc66OXQBQMXR8DXWecSFMCWmMFLvM0Cr6/20sDYwP4Rnve46mqLcR2JELD7r4PgM+xKKV19iQ4vo/7lF4xAcrenrSsqg+VJK18RL3l2pYYkZKKuTykdv9+/J9DC7DVsjiuuXDcyfiw5AxryXnJ+YLIXoEC6HFL6kA/RsoxWp9e6+phwhNcGHC9WMqx+td8eaqEcRGWBuPJ3u00MiWFKo3pdOLUblJxRcw76vuio8ong1GY5W7HkSCiuegqXzh9wIM+ABKCgCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZwg2EekPGkXepulF5AR8udXApMFGqT7lHHqF/Ejb7A=;
 b=ss3RsQx8Bi1kktK4VoyzVmy1Djn/1nhPQiUMj0IM//H3ZNxSe1HSe+SsRCK7NuOIt7KUzAVjNEldEyJ1rihNopjsN+WnG0WztZ8+DszmaybgVpGPok8sX3upIvuM2WkiGKKdVVrwIsx5uib272xNrXeya9SGEqj5hAkcefXISf9YGKsQYfB1i+alu0DeQlHpVCwAspp7NnH+vJYzVKCsVciekT6i1p88YBecgaW0xCLUVfnYxY4HV/XOC2XIcS02410OFTknTwzVc6F9rWyTQVXdmH/gx4GvH+Gp/rnhzaYnrm2KEyRMgi10hTgcL38vrxJObSZhrf/zrgqkcV/www==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZwg2EekPGkXepulF5AR8udXApMFGqT7lHHqF/Ejb7A=;
 b=g5CDTcWBgQjns9GiAgRKdmU/E6ssSDP1cDH/mAhuOzKD3mtEJIsolR4Cz3syu759r8cKSenu7W5v77akdonipeMBhros1x5UcKtE5OkN/bZtJU/YSRWTyo5PwECbzzvSqMdgWfSfyWM6pPVYyTiqABMCtWoDzp7/l6G2M/SCXehwcmvS3/MzWpkiMAo2HpH6/3SJO5vCdKWCOv6kvDg8r2g+E6NyAZNHjJLBo7UgBr7QGIWYqrYLl8jlh4ZUayX1lC+eDZN2ASjNe4iVnoG4wYhcpar865OIjpVZ8aMDjLEWJgmVi/9fpU9Zgi/v51FkXwtsVJyg3KsRmIEAw+Zhng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI0PR04MB12663.eurprd04.prod.outlook.com (2603:10a6:800:342::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:17:53 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:17:53 +0000
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
Subject: [PATCH v3 5/7] mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
Date: Mon, 29 Jun 2026 17:19:52 +0800
Message-Id: <20260629091954.3227151-6-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI0PR04MB12663:EE_
X-MS-Office365-Filtering-Correlation-Id: d81ef450-8467-45e4-8afe-08ded5bf4c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Eb0wcHnx34q4r4zjzAGCBBUmo36WuoenwsuylQ98inPOY3VdNcl9BMswc5x4025gjozKCWnfP/yT2ueryO5MXUuPZ3zJ6yqEJG7HNjp/ajstsTWDP2QcBE+rV5wfKWFCu/FXNwLCyrHp1CbajgRmxW1BIEfIuRw1jur6zaCd7Qb1n6TRf04A8+flavTapgpzYDiBTQVuWlVGbsl+jE8tCwBCDs5oPvKKxJYguS7h0J38b2njXeFnLXtao+L149u4hCbe5XNkwGY1fm1EJ3uvsgKuCNDwx/8K11B+I9zzjMWk1kMwT6G5eMYU22gIVJZIbTKarO6gxefNZySYz+Oq3gcf8PSY1h6IWBitxRfsiY3PqsjEMSL7zsU0wF9JFoRkwa3qTd82eQpFfT7WreYMM7voOthI2ZBqshOZU+HT6sMNypx1lnBdkXf7w5jKK13a9pol+eV+FV3bx7txQ3Ikon5jMHD0zB/m8m9UvoGNas0zXqS/IOhw/Xc46MEf06rfYNr8p6zx7+6z290OT3t+5+wsMAq6Sd6DNheEq4f3VTcPHGBSezXLLQGg7qNb4HK2I1nfqA7EK/mvLb23/QRX95yZ+Xmtn6wNX2raQEA/2knBdiYBC09iArsEhWsXIMaJPf3wwh9sOlNlnnJa9uQr6r3WwVYkT/Ev8rkTxDi/tKM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bp6Wn+LVJj5TdUQX+u2cAXIwpSfZDH3bqU9B5fAYfkPrUvAafN/b1O2d+reW?=
 =?us-ascii?Q?gZJ79JQyJnKmgwujR0CDqObox9Fdx2vq9H4ZYptv21fcpJbLYP1wzIbcSwcy?=
 =?us-ascii?Q?AVqqFP7o0uulPWCVjTZiVP1L/SLAZmm0JbaJzruF+Hgel8pqTtY3hOUQ8AgS?=
 =?us-ascii?Q?Q5rfaXKU5zTSzLhkqef37R6rb2M3iY91YGMvpARgvbT00MvXVzfIezMPelbF?=
 =?us-ascii?Q?kdAT6E3PO9wewxY/uLSg3QPdsOize1wqurSrskDwufGfC3yWNmcdJ7IGg+8h?=
 =?us-ascii?Q?BdcnBjMDNmUh/911+9CSXNc4dizk1CQw5CHvr4yG87yTlGLKu8CjN8Xqjyyk?=
 =?us-ascii?Q?nNoNsVng88i4nNsE33TbP7vPZBTsw3OHZr8RwSKeaEf3noT3g3ndctVrR5fs?=
 =?us-ascii?Q?R1BKwkN2v0INtmr1mcZvliQ6InQCtt0edW98J9OttehMZa1b3hVLaeMLwvQF?=
 =?us-ascii?Q?aHPUgsw5x3H/dK6BM1q8GpHqFBNPSUTq8aGDuijz3m/KPesNbSxC6M+zv1mE?=
 =?us-ascii?Q?f+vV8vjCn82t9RF1EMPhCccCWsINtOq72qpHQhiiuz6LQkFnVbSz0MyuGAE9?=
 =?us-ascii?Q?QPTDO92auiOwHzXXrRTlKHem1VeufpHJfWQ2X5Va81FzWi9B17ouyQdbDRor?=
 =?us-ascii?Q?BzcJAKirHEy28C8M7CqoHSgL0USyyzPB/RfV396Wh3OkSw67YeuuhR50BCjs?=
 =?us-ascii?Q?Wy60dkfPdkQdnyu853nnRZ2cV9HoOB4cXX5VBlrwllCX+WU/B4xBeXeorHNr?=
 =?us-ascii?Q?nwZ3fPS6mBI9mPtfaVy8MpQ2kfWwfEToyyCMsrkMyo+kuS2V8QoUFGyfBHxT?=
 =?us-ascii?Q?X8VPAK34Hvfb611XIaf4A4fBeQ/sBKE7Eqbb04Txy3USrbLPGQSpLyIHX1Gd?=
 =?us-ascii?Q?DLD7Z3tYjsHIKKnGWK/rDQjg0XE1vAZd/d4+NWqefQhXd0H2fO1Pc3eLSXms?=
 =?us-ascii?Q?10uKo7J+e8UtRY9uSOsZKhmbVZl33mh3/pyN67C34Os4D8tvkdp0K1TQ2NgR?=
 =?us-ascii?Q?FxBWnWHuwDrs5H5rQ9ARJJuMbP7Pe9rYmeKBp2NBxl3ROOBzx9+1VpNk7IQq?=
 =?us-ascii?Q?NBkOqbPS9jtiBbEQuZeT/jMoYOYvGchbhxxwvcr/eIQE3vS2ujCR/jpuULqt?=
 =?us-ascii?Q?ScweEDPyUlXT1amMD+9EPzHDfokxXdVmuOEr7B5jLiusxwxu9r9raqs+Gy86?=
 =?us-ascii?Q?WjpPm8M+yOhthuNq0N0jkm5Mrt+Ceq3K3lLINxD6Lv+KWoHqmzPacYTG+pLl?=
 =?us-ascii?Q?aElGsdsTkMyFk7qj6OA9Xqzpg55OeHX62shAfBRID3zWUuwxCq9+QdNIwOfD?=
 =?us-ascii?Q?0eUbFEAC91iekZ6LEynpkdI5vGaW5EASNbuLN0i9Svl+vHJMK7INn8EXzNlX?=
 =?us-ascii?Q?qCpFh7i86GLtt9+HKOJU09/W4S5wafCYKvhBbUkGimH8h+9kYmMMBmgbkq98?=
 =?us-ascii?Q?ftqAAGrOYIXSao0bMHh6NPy6vrZOlnbyZkatAcC+2PlXkC/WJzEqclnN9Z+u?=
 =?us-ascii?Q?GLrRfrRGeFDVYdRwNdNM+2b6B1pa0DU+16JQVwBwlaPHcE74mQqzJcOi7EQK?=
 =?us-ascii?Q?7uzb6UjIIJuPKgRBdchc9mmLCdyFUVCotvLjOZafGzxFmTxlHDEMXKtVUuo9?=
 =?us-ascii?Q?pzAi+RGu/IZ9muXGcdFFv0rvuXNljLn+NjeKW5raBWIE3yP+xV+5mh/JIylL?=
 =?us-ascii?Q?mWBLxHVGBhWVeA+DH2Qhbice57rny6sN4CBUxmDmspTMpCyuO0jrHaMhC80E?=
 =?us-ascii?Q?Zaji24eaQuJoKoh6B80d00zMR9AqE8Lz8HzVXWvCpz9BGnIxDI+J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81ef450-8467-45e4-8afe-08ded5bf4c9b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:17:53.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJuyyiwQb2ISrpSNUhlb8iQR7V3gdfP5el50qkGky6qNRQctIJfosAS0qYLBbpwqE16dOrM/Y0d/23J+cofGI/2gf9fPVjzXiFZau4kBBImcrmZaoutl7fow0PSTqwK1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12663

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
index c4a22e42628e..97ee3f933bda 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2060,7 +2060,9 @@ static int sdhci_esdhc_suspend(struct device *dev)
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

