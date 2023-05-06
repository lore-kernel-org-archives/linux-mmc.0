Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BAEC77B75
	for <linux-mmc@archiver.kernel.org>; Sat,  6 May 2023 07:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEFHih (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 May 2023 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjEFHig (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 May 2023 03:38:36 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D311160E;
        Sat,  6 May 2023 00:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh6oRZWm6/yW/VaXwrd1kGFq4NtBx+JoEufBYlTJS41ku6caEXvUgrw5Oi3Ia5oGd3l47uWyAmS7vGxwemBlFoE7htLyJwbuB+5zUx29c4biJKU+uYP+pXHj4Jd+N7+JH0mSTYzLR1keTGDe8taBMI2l9yuHX3S7M8Fceas4dH8q0t7Wp1t362cgVYkOMtQif+lfBm8Su/zwQOKy8EjT6jhRuTkCraAw2ZtdWZ7ZGnUzb8QUpYpRUjkFqHkSbH5fDINuF67uJsFZ3EA9wWHdYDSgSUsM7YkTZjlsmCC1MW8J3qrxaBFPixQMJPwiwCZ5bBsb9boyAguWqFvBkz/oyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k1mx8fDIGWP0iLTt0GLKxlUYwIIkQ4nAg6dUaaZEX4=;
 b=Vd9AvgQ4G3qDZqnIi4zl3bb9+QG/VQdHae7pByM91faI8ukNsLB0K7cL6GZX0hc1+SPNYfOEK6r9eUAY9AyQG8Q0Vyzefqp9kTXqJ8m4lpcnE5CYVArsG1mY6QtBx8qwXQgwlQVrVEhTvOCvlBPTxI1751KRuPubZfDavzkkHjreXOwNRl/eBqiybI+JJrzOB2+3M/3OJEoM+DE31GJEDrlqA+SQh77hJZTgv2PTpzcMooM8LsN0TWhhjip9bVcCYC1071Z6IaxPN1CCE7lM6TiijW/mTs5O3zUccaI4v7qTNi6awaWosGtxx2XSHBpjQO0y9s7quvvJTW3VyVyf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k1mx8fDIGWP0iLTt0GLKxlUYwIIkQ4nAg6dUaaZEX4=;
 b=rL/exIQATAWDcQd8jQk3wDxiWSqthUfkeyXpk+wTSdAzDcr4YOQy73qvI4AG11rakk5af4A3k0eWWsU7lgYNnroDhCjD73uQe0cwgtId3sgx76mf2B3ODmR4PJgZaNqaIL17UTHhWnxRidrW+W0s1tadoXp5TIS0pTXcqqxoBMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 07:38:32 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346%4]) with mapi id 15.20.6363.028; Sat, 6 May 2023
 07:38:32 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: remove redundant write protect code
Date:   Sat,  6 May 2023 15:40:35 +0800
Message-Id: <20230506074037.522961-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230506074037.522961-1-haibo.chen@nxp.com>
References: <20230506074037.522961-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a97bda-71ba-4f57-ce25-08db4e04e426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVU+7fWGgzJIHIYayYfxAAPkTPYxeZkhVk8OJ4kuyK++Rtzy4wPFob2NYDRbvuXuKqEhXWyPqFER48e5qO7dZg39gMAJsfJblCLsTLju8f0xThwDBCRJJmpSuggHKzdCER3WIHjtqhHErA4WWTXqbpOZGFCRI/0e5MoY7oKR0UVZ6pmr8iHWgOuQJSUClBONhKewC8ghB531EVMGxear3dCJWjRa5o7vBsM69MMPonGT4+qsc6qioL6aYrRVfM5To5zzHFL6BqVj8MLy4CF2Rb10xT7ttpyNwp/cDTLpHVn0dCl6OlDCQfC53l7jrFNZE66Ige5S747LgDOS5wiCBzHr/c8OEM1uOLT/9elxF1EFlGQG7oxeit8w02FkH8l74jWxLR99h+o/MgubbZUC9u3ukhqporfpWlFuQzfk4zGeJcR5RlXozibDpnObTTH5u+zNRRPXLInpVmS8TlgCZpamYq8ZlSRAs8BmKNIx6LZMux00gKMylAZ1HEzWeftMlqu+t49WiKxniWYq7zMw5c7HfEGCei+DMVhVd11YPvVop7Qi93cP7Yt969ezwBXgasq8/aKtBgjIdvnKfagILXhHZ/zuq2+LmEJjsPvgSz5hHfPeiWIn/DnGOLEWGWZJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(26005)(41300700001)(2906002)(186003)(83380400001)(478600001)(2616005)(316002)(6512007)(6506007)(1076003)(9686003)(8936002)(8676002)(7416002)(86362001)(4326008)(5660300002)(38350700002)(36756003)(38100700002)(6486002)(66476007)(66556008)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0Yhtw+v1HVXZOR0uDOZE+/rdMo91teqovTN8y+8TtD8RbVNbxuEuAwYsPtM?=
 =?us-ascii?Q?3Ku2Neiw+GJNl4XrrKBjmC1/KdwMPOabA8Vzxt3D01dvbNP2M+sdWC71AU0C?=
 =?us-ascii?Q?pxGZ4LERtlnEQDu0IHBe1x+acxj99uVfkfe7v07wpmJNukt6CnBzbV9g6Mdi?=
 =?us-ascii?Q?zfbqkP9Q36tBW5HVqzHTQdkfTj4rkCEAI/Pf6VDeJZXoElrKjHiBxXUTyodB?=
 =?us-ascii?Q?LsZYUPDOuLKROyq7TcxNkLsJwJp0YgTW34jUMCbKZ2Toi0lO8c08tCosaGSO?=
 =?us-ascii?Q?Xv+NCW+zY26euffUaYaQjC7dmB92eB78EF5skxRhDwcr7WNjcCS8dpjFrFuW?=
 =?us-ascii?Q?Hlb6aNtVOQj76wR8op3bqtRN1NJHWXaX5jd+GNdDnuqDdHGBJGU0762Nbl8L?=
 =?us-ascii?Q?KGm5/xlHzlyOR56mWzK5HtEQKOOWet26wObzTbDORPI0fa/fhYlAeR5LFCjB?=
 =?us-ascii?Q?/FcCUK8AKYQnsHNvW/8crRfq34J0gM+xTLTsN51POykJzCWfHn5hrNNjC4PM?=
 =?us-ascii?Q?ImKEkfRSOAPXjHGBuz2gAy+V1pbmjmOgOIEWQihnYAuClpCk4xQ6U9YNgA57?=
 =?us-ascii?Q?EtXC29Mrh7zYo1xMOMGYbXxsesQscnqcrIU8alsl44H6HxB0NeFxridYcuqg?=
 =?us-ascii?Q?eoIOfbdMtGxJbL1pkIJsDsdeytlJA69q3yeHViI5sHb95gB86KYxmJV+SE2G?=
 =?us-ascii?Q?CXN3BPe18BGlHuENpd/X5JOCIo8SN7p9MBNzYgd0Ng/55Jga9CjbRMgUuV9t?=
 =?us-ascii?Q?/87zhApLjM9yevFyHj3ffesncPAhQlQ0dcjA7sdsxWMJfETB+lbyDRFA8HAd?=
 =?us-ascii?Q?ZiaEDd0B6AYhN110WtHqu7lhp5iUvVFmc8Ztoo99SSs5Weqlk1gcnKCEUQXz?=
 =?us-ascii?Q?LhZVM4TKzUQzyGI2zU+skpR2Q4/+828Ef7nhtSqoCKCYVI3IB/R7IJoHzCg3?=
 =?us-ascii?Q?mVegfXkNlpylXvHpH1i5jk3c2U0GXLO+UARiLCP7s/LH6dWJB6p965wPJ0Go?=
 =?us-ascii?Q?9x6IT2saqoegaApr//OxhMNVCPcw2YBAVEfX8XqlMlxDByMFax3FHg7VN5EG?=
 =?us-ascii?Q?uurruF7t2VGjMmMF4l2kj4RIt3NKU20lHOszqMVF6dj8curxY5RPf5OUG0Y6?=
 =?us-ascii?Q?RtvIToiL8MLfOfltCa80W3F8xRsJiIiS+3ogXplFCHon94tKuUKdNlbqcjle?=
 =?us-ascii?Q?fzJs+Ijety2B4MS+BkPB9IwXgCgnb6el4FcBK0P9EvqwXzjO5ipeJcQWd2Gh?=
 =?us-ascii?Q?rHxfldjAycxh+pqWshCewCC04Rfk0U0fALghh7ng8okaHEWy1GayODWNdn6u?=
 =?us-ascii?Q?/00nGVkH2TmeWnWL9ieGP8MiJi1TnZR+oYA3OnEiL0f2j3bBgkhWqfmUfuIj?=
 =?us-ascii?Q?jAriLpObSfskknS0vxs+TcJyS8vkIVGJEEw5fBazPprEtD0BaOlLmJqGml1D?=
 =?us-ascii?Q?8qP5Hq3CNpDzGVOG5qihFof1NE83TPfUGyqyBVqpRTPwV6vS4xyPlM0EeFSL?=
 =?us-ascii?Q?FIYmSv5GOYrwZk9hC939LPmsy7NyK3zycSXQzvuMf1wG7MxTag5hVm9dn6vm?=
 =?us-ascii?Q?omdSIAWRTXsBw4e1sdBbQj9pHBRcKM5XjhVaG50e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a97bda-71ba-4f57-ce25-08db4e04e426
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 07:38:32.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSKWxQznmz+3xZNl7GefAA14GYd/WcXKzct/XCiutizHNP2Ia9efx1I+Hx3U2mleudX1GCwcXZ5HmOISfomYVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The logic of the esdhc_pltfm_get_ro() is just the same with common
code sdhci_check_ro(). So remove this redundant code, depends on
mmc_of_parse() and sdhci_check_ro() to cover the write protect
logic.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 47 +-----------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c7db742f729c..54531aab70f0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -201,22 +201,8 @@
 /* ERR004536 is not applicable for the IP  */
 #define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
 
-enum wp_types {
-	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
-	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
-	ESDHC_WP_GPIO,		/* external gpio pin for WP */
-};
-
-/*
- * struct esdhc_platform_data - platform data for esdhc on i.MX
- *
- * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
- *
- * @wp_type:	type of write_protect method (see wp_types enum above)
- */
-
+/* struct esdhc_platform_data - platform data for esdhc on i.MX */
 struct esdhc_platform_data {
-	enum wp_types wp_type;
 	int max_bus_width;
 	unsigned int delay_line;
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
@@ -994,25 +980,6 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 
 }
 
-static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
-
-	switch (boarddata->wp_type) {
-	case ESDHC_WP_GPIO:
-		return mmc_gpio_get_ro(host->mmc);
-	case ESDHC_WP_CONTROLLER:
-		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
-			       SDHCI_WRITE_PROTECT);
-	case ESDHC_WP_NONE:
-		break;
-	}
-
-	return -ENOSYS;
-}
-
 static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 {
 	u32 ctrl;
@@ -1380,7 +1347,6 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_max_timeout_count = esdhc_get_max_timeout_count,
-	.get_ro = esdhc_pltfm_get_ro,
 	.set_timeout = esdhc_set_timeout,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
@@ -1588,17 +1554,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 	int ret;
 
-	if (of_property_read_bool(np, "fsl,wp-controller"))
-		boarddata->wp_type = ESDHC_WP_CONTROLLER;
-
-	/*
-	 * If we have this property, then activate WP check.
-	 * Retrieveing and requesting the actual WP GPIO will happen
-	 * in the call to mmc_of_parse().
-	 */
-	if (of_property_read_bool(np, "wp-gpios"))
-		boarddata->wp_type = ESDHC_WP_GPIO;
-
 	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
 	of_property_read_u32(np, "fsl,tuning-start-tap",
 			     &boarddata->tuning_start_tap);
-- 
2.34.1

