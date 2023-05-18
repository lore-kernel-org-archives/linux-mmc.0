Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55329C7EE22
	for <linux-mmc@archiver.kernel.org>; Thu, 18 May 2023 08:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjERIR7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 May 2023 04:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjERIR6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 May 2023 04:17:58 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60948A8
        for <linux-mmc@vger.kernel.org>; Thu, 18 May 2023 01:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3EQMESeF/DD50M1bzLpnT5PToVO0ciHTSuKNLkiIY2Tr7WOGuma56dYD9DMpcOZ7jmZR9pLq7gaaZLCRhCZ4tdGTDcoCj7Mac4ouz/WCN71SjzIyFrOf6Jp0EpxY3oQ8rGRhsBI3ga34xNaiyB3B2TXHjkH5iwcfZYs5AJ2b9eXGiM6mFnBJB3WKUMm+2G+gjsSqGnnBH2zjYe+U7BV1Q+0SuCKtZ3jCIwuS7Z6eHqKw0YDrL6wKlv2/XvtmyZmMowWipKCmKz1n6GREDRRb7gxAWExFqxsUMlq95whMQ0KtJpfrEQhPUyaXgAvTOFAnYdILaiaoY+pgVfgXtMeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBDjXeTFbKemiDC3iHjafJ3zXB1c2JX5cJClIPjkxaI=;
 b=KdXgY43y8vz2h51ZDUE9E+XSgW2TcF+iDFtD3cnfvzHaFUUwgoHBZQoBswcj4ztGo1ZENdEwpUhR3yPz0/cg+c/IyS2y70JzKuEprr7tfYOvPFZo+GxMkLsaPd0hEQ8NlzNPkPW/EPPyEUFpKl0sPEkKX2Bx4KnZUi/eCyJgNRPjWz605USr3O6R3w3j3OekrFjEm2ss9/XAu4UU7zmCi5kWDoodyN1GiHcmszJdqW98lXLScU6GhW9VBunP5TG5xfsyGCpTuLDzHVmTRkeb+p9H2vDllyHiGRaalYf2/74nfKvDQiOmSAOp6hzFl22kfbrmc7wApB1Vg4v2i+vK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBDjXeTFbKemiDC3iHjafJ3zXB1c2JX5cJClIPjkxaI=;
 b=CKhq1EqBnwTOpPSJJYXpPy8dinaWrh3U9yOerlRwo4ZDNncyKMe8b8ePaieUkPf2HvEVto2Vy7Xqdl3FH/JEgTaPcsEjZlGjoLTlw+3A12g4vxNxUOXWL4xgbELg97tOcGGGbiVwpW3pDobIauW6UrTfV2dpQTIS17hGNoiI9pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7573.eurprd04.prod.outlook.com (2603:10a6:20b:29e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Thu, 18 May 2023 08:17:55 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::60f8:95d:fce9:16cc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::60f8:95d:fce9:16cc%6]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 08:17:55 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: use pm_runtime_force_suspend() to optimize remove callback
Date:   Thu, 18 May 2023 16:20:35 +0800
Message-Id: <20230518082035.335112-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518082035.335112-1-haibo.chen@nxp.com>
References: <20230518082035.335112-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AS8PR04MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aaf8e1b-249d-4669-e9d2-08db577861f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAtC66+Vo6oXWrRTRvGuBOUowyAXLVo7bESaKI91d5M29SKWnx3BJZKvzBcfYSB6rgkZdrRmmk1k01KZwe9DQQrFxK+UFnmSCm9EtVjleg/CWm+yayu/k0lNauBzGinq6alcrs50iUbKzjyqcb2rByjGwcdnWJwAT+caoWrxP3s8uKvaINLJCQTmv/BnQBGhDRHPldgKzsyu/0iIOgLxtNgKnRqA+JtVBoCq8acejwdvTknLsIZkILIIDf0/pGJdANIwSggyI7ZJq0rdcEA1mXnocDTLTceTMu7fFu7GF4B2Fo/HgRhBGox2mLZR1YJDXvIR8XTRZpYh+ghn1aKUvryqW2DY19YJxTdv/nFeME4Qavg71MCXEgpmnj/hw5FBQITVwJxVR4epSGfQKciGi+4rwXLRHwKBn6471BS5SWFFA/jHuQwOrz2pECPvfHjz3d0f5qdIwZlSfV64zYPA/SqIeWGYCWm2b4C7QySussl7a07GEKX5MpOlfMEPhWA26sPkc7pKjUMCrzNVnNOVPeP7xtEFBqPmvBCn/p2G34lF9jiOL6jiDnJeRVo2a1PrE1S7GPodfN3a15ZLUNuWXChD3Bm6Vbx8YXWJNCrMZlme2Y1mBt/FXSQDlBg7eleJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(86362001)(83380400001)(41300700001)(36756003)(5660300002)(8676002)(38100700002)(316002)(66476007)(4326008)(38350700002)(66556008)(2906002)(66946007)(186003)(6506007)(1076003)(6512007)(9686003)(26005)(8936002)(2616005)(6486002)(6666004)(478600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D1mTfseDTOYRf9WdVuxJ8Sllo2/DvRVYBE8awRBtpR3ELVQEa48N6+ozi/hn?=
 =?us-ascii?Q?noBRcbYZ9xB7n/zB1Q9cTIJiHK3WKicJ5PiI66o+a7ETAVrtMGZfFmRJ6zFu?=
 =?us-ascii?Q?tdtI6KSffF4F1W/lu+me2O8phMXIiWhwOHI2oempARRFT9UwovXxVL5QA/s7?=
 =?us-ascii?Q?1PrtuEQCyryke/mBBi66RCCir+r7VzM/xEw/H+3DtFXxpkKrfOPbnuGrHhgd?=
 =?us-ascii?Q?RYoDIYyZsyfFo7zr+ifL6NVJY1L4vVZKDI/sfAhEO67AmQkEiN87TSbmSPYS?=
 =?us-ascii?Q?K3ICbhkYxIipGI+Wu2TFEXmMhEWvB3/T+KzBIRuUQWClsYo8ZEU8EpKFUy1P?=
 =?us-ascii?Q?L/JCnfHhbDar6/CRcoRkfrlYNAHYH/kNw1aWaOMzmkq+/tX1zgUGL77aAZEz?=
 =?us-ascii?Q?Yk27Su+7zlk/FGPGTzUQkn6oqB45yQgtvpS8UX25KYxZBBZYB+oV6N2pjG6X?=
 =?us-ascii?Q?TvQqqR8Gd9q48y3mZi+j1LXcSu3ygfEdubKw+OBL2kyMxj3h45sRlV11gcUS?=
 =?us-ascii?Q?Xi7vLTOBl8ijx3zpMDkYeOX9qggjmMkfYmdxnsyX6yYzjCSCQwHOnno2dl+1?=
 =?us-ascii?Q?d3re5MccaqUsp0uEsIikYulBDJgd8+yUQ49reeRSPSKxtEhyluaC7jjLK8pp?=
 =?us-ascii?Q?dHyLLMxb/7FOvNM3KShpNvbtXvrpNRk2mF/0YK3o8MrBGvr34Nkm8VybjG5a?=
 =?us-ascii?Q?p3/iSO+EKAzC4rnw147f/JcvEXXDIoLPlWMQcTiRIfxJo3lm7BGf58KQ2dwk?=
 =?us-ascii?Q?hRk7kVMnVnOzQ40vD58iOMIniGREAhwH4i0cYKnye4C38Pb7KIxOc8JuaLmc?=
 =?us-ascii?Q?kY0pq+c0Ln/JWoUEerNF9gNqMzDwKKUPElKOt014g21RC15cwlDCWUfyJi/+?=
 =?us-ascii?Q?Q87KmZtQAzl/4vZOU8bzUAoOhF9M//+ZbCRZZ6o8nyIGmbxZu1DWrc5tQBBr?=
 =?us-ascii?Q?odIPwG7tovts+s/p8mk/7QBM6SrcwMK/cNC/h5WA1IzEfKjwtXVgHeAYCyjV?=
 =?us-ascii?Q?N76Disfs//fQQy9eAPJGv8pQZo0Yo7CElDGTtE0uOL90M1ZRbwbx2FsCkJ45?=
 =?us-ascii?Q?EGRpuBIE3AzSeFcBdNBHeF/PaQXAMnF0CO72s8Bpt7zpGnm2uJz32gdTtgsU?=
 =?us-ascii?Q?q5uAFHFImn+ZntoTY720j4o1YSkvfKqmONXb4rAEDon3bwO0fQSYLaP3d/nX?=
 =?us-ascii?Q?C7ut52uXwZvQ/6YN/v7buo2bler2gG1aA4l+4Dkq+tTSaaGvtm7ntY7UlDDU?=
 =?us-ascii?Q?mzVyrbzLys3j2OpAE/TAplh3juadQmtq/qVlfKsW+60/PMFGxlzfBPEEyzWs?=
 =?us-ascii?Q?IjrLOf6gvdlYWBft3XOBpisyenWT6KWv6PdrpwLUaXixRYltJXXjvqIXMjPw?=
 =?us-ascii?Q?wKK6egJIIKzK8zFC59a00wBEwrzkuEmyKh7VXfCanKyyjILs59O7jIf0JnV0?=
 =?us-ascii?Q?+ipWUmTQtbexuJ4h6c70KaJnOkBvT4j3xxQdYq/FJcdFswBHVay4/nUtx4Vl?=
 =?us-ascii?Q?xhMC0uIUSs2abQp+/iFcMLCvc+fd/f4jpOygW3g+4QS4JvYoCuCUQCAK5CS9?=
 =?us-ascii?Q?7frR2nrWIVyoFsbUKmYbBqNDYQm7YaZjs6X61C1l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaf8e1b-249d-4669-e9d2-08db577861f3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 08:17:55.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TWiUj2fZppvUwH3EngwoW8cnUnreK0nI3ZnmpvokOktmQKM7MkSlI7nbJOGg2WazxXblwbRKClG+j0F0g9klg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7573
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Currently some code in sdhci_esdhc_imx_remove() duplicate with
sdhci_esdhc_runtime_suspend(), so use pm_runtime_force_suspend()
instead.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 4cf42a028bb9..d7588faf52e0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1805,23 +1805,16 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int dead;
 
 	pm_runtime_get_sync(&pdev->dev);
 	dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
-
 	sdhci_remove_host(host, dead);
-
-	clk_disable_unprepare(imx_data->clk_per);
-	clk_disable_unprepare(imx_data->clk_ipg);
-	clk_disable_unprepare(imx_data->clk_ahb);
-
-	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
-		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
+	device_set_wakeup_capable(&pdev->dev, false);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+	/* Ensure device disabled */
+	pm_runtime_force_suspend(&pdev->dev);
 
 	sdhci_pltfm_free(pdev);
 
-- 
2.34.1

