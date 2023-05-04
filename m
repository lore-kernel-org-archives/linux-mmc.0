Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D255CC77B7C
	for <linux-mmc@archiver.kernel.org>; Thu,  4 May 2023 11:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEDLQh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 May 2023 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEDLQg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 May 2023 07:16:36 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2059.outbound.protection.outlook.com [40.107.14.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188E2D51
        for <linux-mmc@vger.kernel.org>; Thu,  4 May 2023 04:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVPaHzKanfA/x6Tkwigjr3wm0GSgszMHYYqxXqeD0kfZZP6jzCi/HGgfVKjHt/auNxwu6C7EyXwkS5ehirtQPliiiaJl8Mj7WXV7saX51MqJNf82nvQVeHEXO/fshoMWWr5zQuHmzW9fIeuSGJvHgP/FusTootui/jlZQX9hEc85XgpBjCL+Pd629wMu0PsEMpUwrOyfUqyP66vekpNZZVYF6qWsTZ3YcK0npzFXQhJQatpUQGK8WlcQic6XF5JkI+MWEPTnBrU7l5OQREdZ5UEENJm3iVwvGM7IIRujkQpCH4veBUHo2eswiPXCHFtNdDnWnn1UKnaf9mK6ugAdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6v3wlsDaSWG+hBUbMuD+wwUdKNbWvJb5VGB4YLFOJI=;
 b=MhOxXAmFhQK08Sdhk5aekZABSom/IdKw7YJpt44uWmJNKw6JL0VzF9BaPHaUQIFzKyns2uE0lboxuEHflaYG7iXLrMin7y+xcHCYOOD49XlJiFB3jUbFED9MasVCZs5a7G8rejgJSgCdzNuI1tQnBQEGcPZ7vSR4d9XzsZ7nfpJqULy42aCixI/hkpERfEQWaG3ygVuExbN4s/Vzw4TT7J4KuwUFPEdAXxCKOJL/sCY5p9t+jSvn0CHyVY8hl8VnJK//9kgE0HfI1ww1qdRlbXMGAGh9h7viXe2EgZ3e6w+j2E67JZMHMCrX8rgDMVrgXtkkJtKSgtkf++Mwiz/dzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6v3wlsDaSWG+hBUbMuD+wwUdKNbWvJb5VGB4YLFOJI=;
 b=VvUtlt0Ed0p62aabhlCyOXNIzLkI5arzxcFawVHxYoea9t1lzo0G5jlBU9I0zFXfms3CHSKN+DYbYQWKEdYdMI6QrimuAqbGCprQxTVS2zh66uO7bVjbChodWlaImLkLy/0MMbcsZ6EKBGf0yRl8c9/fRnG1nWML5mKf9c2afBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.21; Thu, 4 May 2023 11:16:29 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 11:16:29 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        s.hauer@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH] mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works
Date:   Thu,  4 May 2023 19:18:36 +0800
Message-Id: <20230504111836.3599573-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|GV1PR04MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 925da6ae-02de-49a5-9fd8-08db4c910233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JutqM2tspu8LMKu06ROOJrkEX5hYBAqICoLeyYk0Knb74sI4z8EiBa+r0UViJxzH4hd3mXis5V+W6NYFEP0DR3E7JM2SZR0Peio6eIQ/HIGX8OFKiLReUWI/ks/BzOlX+T43Kojhhd68lLuOBf34wmPAS45CyDz7VV6Dx9jMy5N61fPh8xsm93NcoPJVvI2+4/LW8jAqQEjV7igoCmedRBN18Yf6qYwbwIp+RwEgFX2E9jwBL7Q0B/UcY5EYromtN8GDfGX9Qi7UKYRS8s8sFq2NWCPMAi4nqIyzV4lzpYKZnnQF8tcIfANG8Pp6XnuMw0HtCtf+j0+CFr41EHnGragXjO5NB5khVAVNKjRfyDTssRzl2EKgV/5zOkVYTqFxrIJOvFuAHa8i8r2IpFwQU/TyskKyvNzWR2+6HcH1uN49qgzjflk+ZVIebSo3p129PAQLmOmjM+yQyPJ+AK6DyqhdA5l3ARpdRXOzg1lYeDSJJzReEcbpVWv5//7TbB8P9HVVIGobdZZHR0kB0qNKmjcFr54uAk35MED2Hafbn0lJbGKwXhOEnBwY7zawYoPXg1BOFtBn66Jqo/eEnEDLHzIyV1ek4yA0oRvqyICXo2BfUINC/WKJWBaROff3Cqqn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(186003)(83380400001)(2616005)(1076003)(52116002)(6506007)(6486002)(6666004)(478600001)(41300700001)(6512007)(9686003)(26005)(2906002)(36756003)(38100700002)(5660300002)(38350700002)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T1vAdrVG33rFE7PGMKa+b1Xxfk7UCvb4WdQnjW+efC9xc+JpT1LOoQ5osOpg?=
 =?us-ascii?Q?1+Nu5oVUg19Bm0YmoRncTPd/0WdjPNgoJyatZwBGmKfP2EN737H0DM7N97qH?=
 =?us-ascii?Q?Jpzy36n+QVycD3+7ey6LKRCjnTVFSnpBS4Ge+CzWq2ytquAAUR3nAAPlkHQt?=
 =?us-ascii?Q?ObVLIwua+dEKifmWsf7lPaIYGCDlWL8rzQkcjGOkv+Ik57jXy+pmqtaRi9QF?=
 =?us-ascii?Q?2ilgL5M0UPh1ZkGWpbeLV02DdlMr5alvvVQGXsXduEhMFo57OhUKoZA/gmiS?=
 =?us-ascii?Q?qBZKmotgwRUoForrqZbXjN3d25wAcE2Nw2HyMXZav5+J0FHR5EpQKk+FkDFs?=
 =?us-ascii?Q?p9Au67M9q4DlSVAPpGB/y9iSlUYu4Q8Xjf5TMZPKzOW9qw4j4i2roYpqBIYE?=
 =?us-ascii?Q?YSf8hfIlCp3zAhHJWyuMQsWhqKahy8Ctp6HMqudAA+WkkjGKw/eqSaQvB4JK?=
 =?us-ascii?Q?JNBt86sz+uWEK5b0Qwq/MRd+pgXwXhqYpibfdVPRlZ6hyStBBau0pJZ3dwMo?=
 =?us-ascii?Q?ue6Gg6r9KSb++wm/TrvBWiasQO4W3tT2/trSMWvDQJRCuA0nmCE/c3BO0lWS?=
 =?us-ascii?Q?1zBzW3Ko7AVrxiSLYzAQJXERa32fGvIUt2tRE2jrSDreK3FgqjYWR+94CxCp?=
 =?us-ascii?Q?RyubCQuRmPj8atmfJ2wry9Mt9YlxzbZT/o/uM6Tx/L5rOXyqqTTUlCpe8kNi?=
 =?us-ascii?Q?BcGlrBBEBDT8b9wgwOrnaaATLsrMmaUsd6BCugoi0YeI3CdbfSEliyGwrI1P?=
 =?us-ascii?Q?y2MFmBPrQX+PvQinY+L68XnRMMc98dNccE1XjXUY/+28Hb2UyukpJC5TkMIl?=
 =?us-ascii?Q?1ZpKIaC4da9k5uDeW71kJaufSycQoUaguRLi7LCCo7UQnzInDnVksUVvO3Zo?=
 =?us-ascii?Q?Lzx1+TH5W3BZy6Ek83Btm661OCRcQ3YdW+hBcpZoUf/0OH/fE9is/EQWbTWz?=
 =?us-ascii?Q?n9+kShefpHOWHf+LNZHZPdcYwosRKbMh/AExrh8b0WjMg5f2EtDustAP3gIL?=
 =?us-ascii?Q?NuG7EfVm2ESOwNdurQtoliH0H2aUkxebWyvX+XrMC8ZPVULYwRn5tRJtJKD5?=
 =?us-ascii?Q?jIKCzbYK1Hlb0pCjYiz3+IAgxdbY0iDLoV3RLOGN7BIL+eWsE95FssE373z+?=
 =?us-ascii?Q?4Cc5dP/HWmQPlQ8nzNjpjNSs3zq4Ce4I9qDw+KPIldutKXzq2DAyobAB/ZZy?=
 =?us-ascii?Q?3rrOUrBqIiNFYve+9Ek84MHovX8yeQOrjYOKMu90o167f2lwjl0+F4Yhq1xY?=
 =?us-ascii?Q?VT+AM7xEN/kZnxGEymUs9grWx9Bfj43oYCFtd9LfcKeJfBJZqFCxyW9a2EwJ?=
 =?us-ascii?Q?3RyFIlx8CbDXEY7zaQiF6ccxPNu8vtgNNA2OfeUutLt+MdsJxGsheoFMSbwt?=
 =?us-ascii?Q?btpLInIV6QXpgGbp75EX6U196EeZ4wDerjSNglp39KeTZ3Bzd2Vvhq2I45K6?=
 =?us-ascii?Q?GOyhVVi6X7DFh2t8ovk77mql1wWKV0ZprhPLWqoTFgz1x8dqKGUMtocQ+pdn?=
 =?us-ascii?Q?DJLHAbDfPcLnMwlE1ppCfRg+TPAo9uNoUrNYxjRSRoeI7dxWJgu3YIR1099x?=
 =?us-ascii?Q?lokURbytIza3rbCjAdl7BY3Xk1jhk88jKWKUyqG8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925da6ae-02de-49a5-9fd8-08db4c910233
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:16:29.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMmml934lJ2rO4+k8Fp7/CsywZR9pgod2YcAEHubwruXrFrimeP3N3pvQkhlpeLfmW2kqwjSOU43zZS5ye2KRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

After commit 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate
ESDHC_FLAG_HS400* only on 8bit bus"), the property "no-mmc-hs400"
from device tree file do not work any more.
This patch reorder the code, which can avoid the warning message
"drop HS400 support since no 8-bit bus" and also make the property
"no-mmc-hs400" from dts file works.

Fixes: 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d7c0c0b9e26c..eebf94604a7f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1634,6 +1634,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	/* HS400/HS400ES require 8 bit bus */
+	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+
 	if (mmc_gpio_get_cd(host->mmc) >= 0)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
@@ -1724,10 +1728,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc_host_ops.init_card = usdhc_init_card;
 	}
 
-	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
-	if (err)
-		goto disable_ahb_clk;
-
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
@@ -1735,15 +1735,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400)
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 		host->mmc->caps2 |= MMC_CAP2_HS400;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
 		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
 		host->mmc->caps2 |= MMC_CAP2_HS400_ES;
 		host->mmc_host_ops.hs400_enhanced_strobe =
 					esdhc_hs400_enhanced_strobe;
@@ -1765,6 +1763,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto disable_ahb_clk;
 	}
 
+	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
+	if (err)
+		goto disable_ahb_clk;
+
 	sdhci_esdhc_imx_hwinit(host);
 
 	err = sdhci_add_host(host);
-- 
2.34.1

