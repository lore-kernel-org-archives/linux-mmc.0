Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010013.outbound.protection.outlook.com [52.101.128.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9C15687D;
	Tue, 27 Aug 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744135; cv=fail; b=dE7rnIjrzEb8xdQ35JIBzY8Gjr1VS4MO5CQMQl93GNBWxdknB7CVujYAUiJgwebGgzldNgFuUcOe19E63dTG51ODJFm95ze9dw7rtxRKMc1oth4+NPYZTUo0G7eVRfpRQ2ouXRWMznDza+SKdTA/xe90mn9Ny3YnYCboNp2Gvn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744135; c=relaxed/simple;
	bh=OkQxT9mPY3rNO9CDFPe1k6aR99ktH+v6Vctu/6S16aI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0X8pCFAH9ILjrfM3P91UBVIJK/iuvuxTw6l6DGu0vZlpGmLIRyMJ7vQFFp8qg9+VQXVgsT6wj0Q6j2RhsgmwSJotaQt13NdGTayWglDAv3zK9oJQl8bo8YSLjt6UN0XX0ups4uSAlflfnwzzgeHBA/AVXcWKiJ2BcbfHOuSMpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XBBxW4At; arc=fail smtp.client-ip=52.101.128.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XBBxW4At"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Md+XJxA/2JgnI89xASuVXB+nud5SUsfYXfHu4UEQVIo1YmS0ghU98F2gX6zUXv2s7dr7KKUTfTr4fWWksd2L6NKuiFCf4rb5zAjtJPW52wrbiKBVVNRVCgCuAD4X3vA5uD+Gdorgbx1ulxLZxMxkfFs73tHz1HMn9DEV0BwUWI71Xbo5oY0+M6u8OPJSaKx/YfkCUF4ZhRFVBFgsITGN1CaBiZjhL6CMGLQMvxFqOB5Af2oqJfuw/HC4Bac2zqyjQ6/ENTfRTSvrJvKWbZPbEBus4ISyA/NO2i0GDfr8/e+2+JBtHkRFEa74E8b4XxNyGLulTvIwEIaedc1jnPKygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbQUafBp9d0BR4mWRArTDewOj3yjWNb8GALNlegDChA=;
 b=kn2zKflT/nrVOAanmStwEDIqXUr2wS5Pe6gJWNMdscYTXi5JDedhrg/xA7VGWkyKDmtkvPafUSXw9+9BS4jDTN/uTJyzyPzvSalpUGce+LJQGaYrAP+htH3SLct6xdTjp6GJlmMbUU6KnKhfLwCLdxnmxrhk2XjgZkMJzPa3pom1gJC2zqCu8Cnr98f+K3Wm6IZUNC4UXsSaqUdQewnHijSSlbO+4IDj4kbIwh/nU1SZNUKmPv72X36dYAePM8Ovzuwclk//+V//QkF3vx1wkaGQ/x5qa03o99/iXCbJgoP4OhRUwzCV2PKMhjn70Vohgo76KMM68c6djBtbni12hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbQUafBp9d0BR4mWRArTDewOj3yjWNb8GALNlegDChA=;
 b=XBBxW4At0hbHFGqXvB7rrcBVwlZx9Q9TAXpUYqopxIo2dUpwnZNUYjJT7uEwoVK13GxHq9M/Kis1+42XWeVzTlVh7CkQGWmn25aoKI4hJUSDr+IJ7WbKTFM7tmaR/exE2cNbgDNd3W6ihjgwEFO3ZSO/Lm83Ml2n8AjTpduTguixEDJPCeU+5gV3iDrqHdSp9nkYzR3erNOG+CxhRMR29tbIzV0nZeuV0LM4J9r+6VFpfcfaXFJ1BxyT6FrMGhcjPyFfirm/4JYbp6O6/Wafazm15xhL8ar4dzcuIMVCSUn3fPEFYzBTxK0KUYOzi94FEYHtlG72oV6USmi6VkK2mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by SI6PR06MB7102.apcprd06.prod.outlook.com (2603:1096:4:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:35:30 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:35:30 +0000
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
Subject: [PATCH 5/9] mmc: mxcmmc: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:43 -0600
Message-Id: <20240827074857.2671808-6-xirui.zhang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fdadd016-92f6-4e72-0535-08dcc66ad3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8VdGiYYltQBwo5uQVlaYYQ/ssIoW+3c3qOBAnA8jw2oWFy6eUTReAf3Ea2bi?=
 =?us-ascii?Q?BTwwks5hxzsc6CHw/Glo/xZ0LvL1uhloDnTqTlfBJYthERHYXEWAwgepdIgB?=
 =?us-ascii?Q?QWbZNESjprObque5xVXd9Wl7C/L4A76EnHJ0bzz3SfivyjN5HgJntbPruy0r?=
 =?us-ascii?Q?XwH+TwGnFXmynJg8zaj8yE20FURlSaJVQ9BWYFsOcFqlKMFEyKDfhKadN/Ai?=
 =?us-ascii?Q?8zcEHpAfryRGx3KrvjpRzV8kCDldKtW1Qloq7bz0o+E4TRsW2LLfU4YtnoYo?=
 =?us-ascii?Q?nUaUKsyQ1qsURbeahEQ268G+2Y/H2Azr2RbrUWfRRBYxO2EDnRnQom5mUQvW?=
 =?us-ascii?Q?zBC0qFF5I5W9OBz/DcmfPjDMBwJCYpXC9FptnytuLx1AAnaXVc9c9JDfB609?=
 =?us-ascii?Q?Yez3nffzS4yZBf4YlWPzxQOly7LxM4oykKk4R4q3po+hTqtjsi8XLQyBRV+8?=
 =?us-ascii?Q?zuZt1xXIHMC6BEzCNCLyYZUuNzYnA+onLlKZFltd8xdMkTlpi5ipd6xEXPSs?=
 =?us-ascii?Q?JiLkAjSUohPxoU/uVDBI5P3JNK11o4cJ0dCpNAJli0rOMqkH6PBD4Bz4/sfZ?=
 =?us-ascii?Q?0Kp5ITq6zfQ15tIrfKsqLATYfWGeiLMB0XhLP3Vw9rhwFuYcG/5PCBLYeHxX?=
 =?us-ascii?Q?1e/6JK1wMpE0gUJbdvCvxxtqL6N51JLmSlHvOC3T4LRAZOaPhUCBOawhAkaF?=
 =?us-ascii?Q?1Ezx5FVR6aM2iTorcVOIN1bth4GDSHt10O5P7N+PPqsu9xNq7SRjqH6UxWTK?=
 =?us-ascii?Q?yyRsJ6Yfx2LOAY7KT5s9iHvZgn/F2Dg7B6KE1iAjmwxaWsbAKxytFbnLxYnv?=
 =?us-ascii?Q?RISzUhE7thEGMVljHOhq9NTHP9fdezI+h+0nnjY1w72wQgIcNtfXWBOjWJMm?=
 =?us-ascii?Q?pvflUGW5+YVIy52wE4ONk0c7MzUZI6rtyjMcyjQdS8Py9qkI2rrtSwruOIb1?=
 =?us-ascii?Q?ORtKedl3SUNYlO03myt+GHr6/CZ4UlNLT2wUSauvnZEHj8UcrVxj/OggHT0N?=
 =?us-ascii?Q?up4bhQUN8YrPl4LYEoPKcJYLr7hz/qpX0HDAAafNDeofK6lBAb8SmSbb8M5S?=
 =?us-ascii?Q?L1/CQ++T0Nv2QIpghQKnESejDdntWTtnlTD15dRaNMoCVAUTNGT80ay09HqT?=
 =?us-ascii?Q?MSq+/4eW1QIFLyW8kwlBd3EGC20n3qsezPqaJ8YH+eKJJ811YEQBQaDTsFff?=
 =?us-ascii?Q?ZghgVsVndKNnjmphJNaqRxAttFUKRxoOxjzu5tqVbUnWc+IUcNyvw/5zL5nj?=
 =?us-ascii?Q?bhw89nsyDSIhxWcAIbvGdGYDjhfhtOdT2ZmX5bgBctyc6U3U8EuMhwGREvNY?=
 =?us-ascii?Q?k6azSf6vAWBhbSmmIPNmbRHJ46PWBTbT89WozFgieOLM5LaM0GvQlvi5sABg?=
 =?us-ascii?Q?JW8oZm2e9vzDe14VFkHG8VrwgYOOtVuH9tAJcc6rDgLnB/d3sOj/0VtQ2Pfq?=
 =?us-ascii?Q?Fkc0PqBvQ7erD+2BT9G8R/jluMKSTpv6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HeaUkb1NVxwFBHTwrcS+72XkFLDJCCd51Uazy4meuoieL1OwFGtzdvguHdlz?=
 =?us-ascii?Q?wU6rxfE0om9TSoCyj1QVcsCjBsC2NkZ7rkLc8uLfyJxLqnU7sAQxF3JAfOOJ?=
 =?us-ascii?Q?CjBEUB/CS/4RhtC1fRc3KRIcEDm0xQajgS284Iu2kKFO2ds3tgyM+u3wRONt?=
 =?us-ascii?Q?NLI5n4PtM1ozlPYGUd6eWB9nrnFxl5E5HsqNmJ8t52oJXhmh6qjSDZVQtBij?=
 =?us-ascii?Q?51jGaCoOMrGZizlvdm+7oiHbY++szjAss5TM4jTIVeKg5aectXoaPJdWk7Dq?=
 =?us-ascii?Q?n7hfh5wHMc9WElL/dUIyjmCvKU9q3RUf8ao2GeDbFmb/R2/Eaq80FkRIVRoJ?=
 =?us-ascii?Q?Wa9o3RlfJ+tPxpxb9S1VhRoBoOmJgfc+pbXqN08Xvbav90JzF1Vs/mcwTIxE?=
 =?us-ascii?Q?wgdJkQm8Zbcko9rpX8K26dS2vo5VhWWzfWIeUBIdYhAm59AnNmaSyD292TPL?=
 =?us-ascii?Q?EVkqsOaZl0DAT2DURgaeyAq4jovmioI3iMdg0GB74VeEOTfs9IcuNMwARXkr?=
 =?us-ascii?Q?vfaUftKn/k/C2iVUSMPtDfs6UKymC0+kbAUFWx3zTZPzI4rLZyJ1BqdnONwO?=
 =?us-ascii?Q?OuPg2anZlaSP6v12ye75q6mKXalCtSmENgRrUdGLiX5bujRboUAc0GuIN2KT?=
 =?us-ascii?Q?ow8W7MA3eJdFcmrArRJglmXlBjD0NT1IbmanJIoBBP8zc83g2qaiF6L5f8ur?=
 =?us-ascii?Q?2zam7izIPMFaVd0/L4UVexopKWDYG0ydLOAw2T411+OXs5we2R62jykgLl2S?=
 =?us-ascii?Q?Q/tu+Aw07+AKaAgRDIdttPRAAjUx2S0zsUFL2W0Pb191np77YDj4ziyfzmfu?=
 =?us-ascii?Q?mVT4e0NzQcqQ0DVvO+slMH1FXxWVQn3VmcnX5Et0+2odz93QGXHqh99a3Qdr?=
 =?us-ascii?Q?AAOAxS18+toebY185uPaTZE6HB8aT6+87jwSGsPjxD5uaXJtu696SfCO+nEa?=
 =?us-ascii?Q?wofx4FEYEzfqp8Aykl4hsFe80QRJHBKkstl+1cDHN0NqqYG2B6qNOl8O//11?=
 =?us-ascii?Q?5Ql61l17LNYKJBDBwhwnkvA/YYnmGvNGroqD7zGjuZdSyjn9fKsHFUI8ZX8b?=
 =?us-ascii?Q?GCwKFWCNIzbgj0P62cdCDDwHblTw1l6f9PLzbCuRo6tUlE1ocZHGAofH5b4S?=
 =?us-ascii?Q?MKfF/WAvjXjJLFHfJF9onSmXBPxNGNOrGDBhu0B37bAX0qWs8NOF4my1NBE5?=
 =?us-ascii?Q?Y+PggDBOPEbZ2qxmCZc0V53KMybEMoIJrVD9WARprBvHxbIbWprScetMdrtX?=
 =?us-ascii?Q?Ugei4w66FGDH3h4fEXgQCouSFCxlS1ArOww1z5KBbomaz3Gjy2rEuE0zVV7E?=
 =?us-ascii?Q?lRm1aE5gKfy6BUFXexw4BVCD/wIqSiO+FoRR8xAHmQJVTFfokF7XqEjFxxwj?=
 =?us-ascii?Q?Q3FUE1KWS5NFvjfrgqwinsk1Mdf11B2ey6W0vAtFpWoSFlIQrXaSeyzj0yyK?=
 =?us-ascii?Q?at8vInIyGpvuFhYjjqSaZ5A1QmxUwZSsk3dPjCA6Z5h9x6HDEmnjm50q9bOU?=
 =?us-ascii?Q?ESrXeMd8BLTtQNfcisx6cVoQU5HcFE5AaNF4dOLi77W+ABNvNXt7sZn6jBg0?=
 =?us-ascii?Q?waAVQPaVYS915wpmewvXOjgGhJqUNhNvsZ0i7S29?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdadd016-92f6-4e72-0535-08dcc66ad3d1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:35:30.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svEVySu+fnOLINEkf2yiOsZl+zVdctDFb/wmV/KkkFLppL70TBVKYp+X2BRpnuyLMvIUTCRwxllQmZ94mqJBsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7102

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/mxcmmc.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 1edf65291354..171e1f6a5611 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1069,26 +1069,18 @@ static int mxcmci_probe(struct platform_device *pdev)
 	else
 		host->default_irq_mask = 0;
 
-	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	host->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
 	if (IS_ERR(host->clk_ipg)) {
 		ret = PTR_ERR(host->clk_ipg);
 		goto out_free;
 	}
 
-	host->clk_per = devm_clk_get(&pdev->dev, "per");
+	host->clk_per = devm_clk_get_enabled(&pdev->dev, "per");
 	if (IS_ERR(host->clk_per)) {
 		ret = PTR_ERR(host->clk_per);
 		goto out_free;
 	}
 
-	ret = clk_prepare_enable(host->clk_per);
-	if (ret)
-		goto out_free;
-
-	ret = clk_prepare_enable(host->clk_ipg);
-	if (ret)
-		goto out_clk_per_put;
-
 	mxcmci_softreset(host);
 
 	host->rev_no = mxcmci_readw(host, MMC_REG_REV_NO);
@@ -1096,7 +1088,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		dev_err(mmc_dev(host->mmc), "wrong rev.no. 0x%08x. aborting.\n",
 			host->rev_no);
-		goto out_clk_put;
+		goto out_free;
 	}
 
 	mmc->f_min = clk_get_rate(host->clk_per) >> 16;
@@ -1112,7 +1104,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 		if (IS_ERR(host->dma)) {
 			if (PTR_ERR(host->dma) == -EPROBE_DEFER) {
 				ret = -EPROBE_DEFER;
-				goto out_clk_put;
+				goto out_free;
 			}
 
 			/* Ignore errors to fall back to PIO mode */
@@ -1163,12 +1155,6 @@ static int mxcmci_probe(struct platform_device *pdev)
 out_free_dma:
 	if (host->dma)
 		dma_release_channel(host->dma);
-
-out_clk_put:
-	clk_disable_unprepare(host->clk_ipg);
-out_clk_per_put:
-	clk_disable_unprepare(host->clk_per);
-
 out_free:
 	mmc_free_host(mmc);
 
@@ -1188,9 +1174,6 @@ static void mxcmci_remove(struct platform_device *pdev)
 	if (host->dma)
 		dma_release_channel(host->dma);
 
-	clk_disable_unprepare(host->clk_per);
-	clk_disable_unprepare(host->clk_ipg);
-
 	mmc_free_host(mmc);
 }
 
-- 
2.25.1

