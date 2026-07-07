Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29FA3F7A98;
	Tue,  7 Jul 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422043; cv=fail; b=SWSqQKLN3NY25ENhXji05uWHr1Y2dumKL0jdtvd2HYrpJ7qRZCtff2uVNsQaX0jSAsc6rHSNU4b06F9fi7gtn838I518w4b0gCHrMqqWfyGJ6bUDK5y09nm0QnZ90Me8QAs1U/rZeFRin/KQqf27QuHPJgAOnzBsF7MHVHYnvjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422043; c=relaxed/simple;
	bh=n8dg7iScXE0nop9sGa1bPXemYQQMt78x9tLURAL8YHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVJUeDUW8HciYpkFW1tiPivMsh1kh7KJw7ZkhZZ7Y4Rjl+pdNsxX7JtcofvBL7kwEhSHMYzA6M19tY9pFukz1tnFrDCq86s0zdEhYN5nC+K3c4U+IrMia71Ed7V3+WCkXTgr8Du5uyAfBZo2qR5b28i5v5FCVc08ExRpIZ0UHaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JvKF9eND; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JvKF9eND"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg4jTOtdpC1RXqhRPUX/xa5NPVdsEtJWq5SMZEfMxvOJt9x45O9TR96A7ee0qUTSxsbBqyHqrabf/alOjVTq6sT2cbfv2UgunLDTeN6YvHsre1mJLX+Fx5aohUwKWHa90hBbOwcTu1jDtItsscaLuZBCIqjntyDK/pyb1kIRbc+QPRt6jX9xyAlL2sxmM+AYMLvWkuGpxN6byrNxCFlnUFr1b3/ZBPkSRZI4s0BsOV2H+NAdcqjIWe+Uh6c8w39VmLB9jRjsWnvziMQVhl92izEGa4qU+Ls8t1Gie15e0zigmgVDCX7v1hsfP7Agwu/XxLPra/EDKVZLaf4INxoH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCiiO8k1/us29kYr3F7j4VbqT1L8c0kU7QYs2sFDJQk=;
 b=HyT444EM8PdBg/DhQAxyJUC0VpOUQaZ16Vynfngs/3af40fwQxhmjV6hUwezl4aFAa5oL2KHdsLELnUZBXCyKH1CVXqsIK0+D2fDZXP4gC8HGWb43rvarzNPyJBqwDTswpk92m/17CKGQrjGxyraprn2cudtM9dzcL1yvCaE52FLQOWoyfmrZRhOZxJgJWtOnmmgmhny1wz1KFvf86WKK0I4u+6IKKhXFW13AsKgNjId/WkDWroJJpoC89KwZI1RakXnBtpYlsnV+o2fLJP4pLtX4sxUwH4zwhSXC+rp0YAt7AnYmChw1VL2WvyqgvpVxPzcE5EPJ5PZY1i+x4UMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCiiO8k1/us29kYr3F7j4VbqT1L8c0kU7QYs2sFDJQk=;
 b=JvKF9eND6g7zRHiYVPiOlb0K8NOEVicp1fpbaXuI1vD89Mcj+CZZ1zJIamXa0wIh7sfky48+FLOTULP/+UDppVTa6aXccEM5SxuxoJEkws8V0xCYx2Aq95aYSaFWqHB5Q/8Si7tO1U/aePwf43j5k8gr78digcNRrYT8kPc0SmIy/l43stcokp3nnaAprXpmZC2cUOtwzuYjdztgw+qCYmfxATSdjzVf8AphM8wcVB7FCdaZ0FDFUmtjt5I50re3MhH9QM+zHjszgNcUsfoLpLLA/yAAOcztoH2E4FFMJ6p2x/Ce8SAgWjlKM4ofVL4kKZ0ixOBCK2eIDlvemQPhfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by PA1PR04MB10673.eurprd04.prod.outlook.com (2603:10a6:102:480::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:00:36 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:00:36 +0000
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
Subject: [PATCH v5 3/8] mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate() to allow default state restore
Date: Tue,  7 Jul 2026 19:02:58 +0800
Message-Id: <20260707110303.3779799-4-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
References: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|PA1PR04MB10673:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b7a686-7f19-490e-106b-08dedc16f90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Rl9izXmb+OTFSZOyPttvXoIK2aSgj6NNOflB2Fj/T4pbIkI34ozAugteVZ4RKfzsKr8GB1AAEjMzqQBRZvCoOL1sJAG4cn5WN7wHl1pMPbX0dAA4YUkQ8IknIpnadMFTjTHDsDSHYaihJBv8Q1vMNtU83QYF0OVH4IeVOPZ1DMeWeMFCCEwN8MlibDVnPgZtYtv/LugmBiLouDc7qN/Nh3Pri11w30IzoE0gAuiVApIfxpI06NGnZvmppFsws9Jjr6y5Dzam5LuFnZ3LLKkLCxfBnApBaXZ/JrwiRhbQAYRQTypP4cAzBCgGLqSjxZx4hQL1fs9tgISTy1hiiJSCj0IX91k6vXkDsNI0OM5KILMFhynV7ev+W07Whkl0FWtMa92wTawZL2rgEExacvVS8qpAdCF7JHMDVCnLB0QjL8TVsg+iW+i0iEdfMi9bln7EwUpJTkd1ymX58r28y+h1EHRUS9j3TTDYkTUngdiHZXa06XwN/yaC9BUtZ1qYPL0yrY6lDR3058BvbZcfzc56LxwIPs+8mdUeLYI2uwmuFTk/9iHlO13Mp53uMM0Qwtk6Q8ULvXFfqQHTRYs+NfEq1rBOpRZawlS715V4x/lFw1AOY9G6ydkpuE3lyePtHTurKXeVZujWzTYEy/2VaNU+kgPLN7U+tSMxO9a5pA793zo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mhvcaj7CEOHrg6xGmwg97dnQshiYkbg9HGKIkfgnR00nlPz0KqEKHCMTJ3ow?=
 =?us-ascii?Q?bvpl7fGfWymhgUEs0FA/myzqmt3FurXKFTypIJ8lfpHLdo9ypqKvjLzY6rxD?=
 =?us-ascii?Q?Y0D0P3VteqRc9a9SXK2kkhi4b6QtJOlgepzSlEarBrprAbe9OvLcmcNpSvQg?=
 =?us-ascii?Q?/vSUcY2WNBOYuPuZreilVRajl0wcOugaMZeGXLK/0JbS8sn1uKKlJt8V2IOW?=
 =?us-ascii?Q?z4GM8LJAPPr+QAzD0opOFsmtbXhi2/ClxbcQeWixNGEiYWCH5NOGrv642ANU?=
 =?us-ascii?Q?/C2YaNdSKsbgb6sUHzZA0buAIk+ZTnkLYrOZBdvniN2Yto0UzG41novz0shj?=
 =?us-ascii?Q?4q40Cw/g6xJr4Q5GO0gZU2AoWrXxrdfIoMxTO36MADtZCFsynZS8svEsBXnB?=
 =?us-ascii?Q?Fd0FJ5w9Y0Z98EnUtsMeVW0UqhBUB8TN67q9YzLujd320Ly1eaqd7QjKNfSv?=
 =?us-ascii?Q?pRm6MnzBPnag9g4z3LwsFCclkDSf1rPcoDIhy+cBJlnw97sT9N7q6SXKhPb5?=
 =?us-ascii?Q?Xzz7Zlwc49Y5LcUXBqfrFjx0KwFIRwtA0xweYMbkauCYBOGgqgvoEIYFivJO?=
 =?us-ascii?Q?G5p2nONFnGysW9tTghsbJhnc0XSmb01lZo/dGIVLpLZCzMWOaYyfyU+y5iAd?=
 =?us-ascii?Q?La99PpaRTrogZ5Y9nT839ALHl8yCdpDCkL4CxagUzEX2qbsGpigG85KCP152?=
 =?us-ascii?Q?YhZAUzGrPGz+V4J8NO+Kq21uGim3kKb1XPPsJ+3ALZUHJ0UofMSC7X+p3nqe?=
 =?us-ascii?Q?rIB2G9yxghtyzBQlMqxLisgal54DAvH7+dwh3g/pn7lGxXKFPNDTb0ucci62?=
 =?us-ascii?Q?5reHrARSc8rZ+vlSs2Q5O7TnG+dGIOIeW5ZsDmn9eyO1UQm3SUYETdKNZZ8t?=
 =?us-ascii?Q?PvtRb67qhjdgi7ILS9CHn0aqPUwqOb9Rz01/m24lgItgYyoKuzI4yRoDD8RJ?=
 =?us-ascii?Q?DLPEuv99fuBRgagf4NdnPxUnq29w1Vx7Suvdi8paKPK6uadbQ5UPWmnhrIkf?=
 =?us-ascii?Q?ni/Vlr7dc4qq7Wodn9HM03DnXkpn+t3ymMdtCblPODCHgJx45gD0RwrxWtbA?=
 =?us-ascii?Q?0kwqnAkHnEX3w2zk9cGIjmvdmukmItPBHW06QpGdIBJB/cNOgtq7Pk8Hg7+m?=
 =?us-ascii?Q?luE+zY5s+yXtjN08IuRCBRgYhG1SnKfKgC5S55Kbix2YivxYL7yfphh2P2AX?=
 =?us-ascii?Q?clRSNCyTm3RZyTe3CO8NSMcezZy2ERy/hi3xTXkYb6KehimxYyvBDDvbxro5?=
 =?us-ascii?Q?gSTMvKYWJd5cQydZMzXQutobIRi8UCtlu5fISFE1x6hJCPcdBfDv/ZXVrqpd?=
 =?us-ascii?Q?0YmOgL3F+tYHG3YrzEFG2Yiu1E9qYcgONspmzhvJ2xez/zQdmYvbmPzmqF0K?=
 =?us-ascii?Q?9O1QO9q4xqraish4T7OgOf6rA0l9MH8e94ShGvbgBc41jd3UAAJpeVfXI6Ku?=
 =?us-ascii?Q?c9TwLV880nTq5b7u//VFhJO3wIBmRJw/gOoJbThxQyfpYYAZIRyV7WWvkPNr?=
 =?us-ascii?Q?ZnapJ1WXtMfuFMJC3upI6GkxPiAfHOatQkyQI5aM3/8qNfc2CzBYITqc4/on?=
 =?us-ascii?Q?rtAQACJHRLIVjs0TvtTqSJkuDVZsCTgoe91HXVSq03G2AUf/DO5/suf1u3GY?=
 =?us-ascii?Q?Q5LOC0sTuLzu7sofyw7g1G0oJyXJvnkCWCes+Vvpj/lN4d7j8J1K5qxa0dGX?=
 =?us-ascii?Q?rfpJD1tfGYuCEgYNk3rt3NGp4vOaM+VQSE5vN6iEVNVKx7kTQFvjNbFVJrqG?=
 =?us-ascii?Q?znpHjqjXgQBmpKk4eS57x+cPExw2jeGJG3BykaA4YZrrWcGL8wQAoHQFYm+Q?=
X-MS-Exchange-AntiSpam-MessageData-1: dyjkrtZWgVsUDg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b7a686-7f19-490e-106b-08dedc16f90c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:00:35.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkWI+n3IojSTYQiIiPdaoQnmfG83HO6al9c31NG/mFofOCN5n6isMhuiJZ9+Ym8AMcFD3q8bRJgu0j3yupGqa7ZiCCdNb7ztC77h96OBr1J7nM1pniEMgKk8rBYt+3hQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10673

From: Luke Wang <ziniu.wang_1@nxp.com>

esdhc_change_pinstate() checks for pins_100mhz and pins_200mhz at the
top of the function and returns -EINVAL if either is not defined. This
prevents the default case from ever being reached, which means devices
with a sleep pinctrl state but without high-speed pin states (100mhz/
200mhz) can never restore their default pin configuration.

Move the IS_ERR checks for pins_100mhz and pins_200mhz into their
respective switch cases.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7230d70e02ae..ead4685d621a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1326,19 +1326,21 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 
 	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
 
-	if (IS_ERR(imx_data->pinctrl) ||
-		IS_ERR(imx_data->pins_100mhz) ||
-		IS_ERR(imx_data->pins_200mhz))
+	if (IS_ERR(imx_data->pinctrl))
 		return -EINVAL;
 
 	switch (uhs) {
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_DDR50:
+		if (IS_ERR(imx_data->pins_100mhz))
+			return -EINVAL;
 		pinctrl = imx_data->pins_100mhz;
 		break;
 	case MMC_TIMING_UHS_SDR104:
 	case MMC_TIMING_MMC_HS200:
 	case MMC_TIMING_MMC_HS400:
+		if (IS_ERR(imx_data->pins_200mhz))
+			return -EINVAL;
 		pinctrl = imx_data->pins_200mhz;
 		break;
 	default:
-- 
2.34.1

