Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32543C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 06:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D0F2075F
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 06:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="hBLWYZmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgEOG0z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726184AbgEOG0y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 02:26:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3330DC061A0C;
        Thu, 14 May 2020 23:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK/o9GevPpGMZNxhN8IaFmC+HflotJcgqwYf34FaLUE/vL1+NBE7GSWb40ZAQhUyDpZxeKiQLPxWIh9Bezz+CD7IDiE3JNVuXWOaWooV5AL3wwebs/olHEIqDaCoJijOSSspLF9NpFP1Nmrp9lztZzeICZvNqBqYflBzfbFzbdEBrXzmRCfNy6+x7mFGw6Lb03rjmAX/zsMZVbdQAG+OXGV4aXxIi9C7iMBZ8Fd11LcAR3/znrllTGJUYWXHRnlbkUN5CPXuQ78V5gl01GPbQEere3mlD5SGg3OSW7QBcyFGKQZbL74X2qKvDDLZH38ol2nH++gyMlPi1jKZf0cI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1Z2YWD4Sr8HL91H5loOg1Yst8BRluAOxKYTFXDqaUI=;
 b=l/b7YTbfrB4aklb1pY3cn4m/6bDMG9CXmO9BL1EOsWrQCEtqrmuyHPPaLdqzj/2Kr/8DRkzE24AW50Vj/HOryKjeWdGWKTZZixD1tz1+hGfUqlkfFF2w9JJU5oGWjCGhAGv7pfU4UH3e4uavnz0dnxm86jVB6iXeHzJapCl19S83Qyn6ewQBqGthTvgxxCZWDccCPEi2sPg0Si6Yh4rasQZ+KEKVh2fv/7S6NMATamNzTpUdjU2aSDuPBJ7LRapzCgM/q54rYOFn079m7kW415i4tdCEsBjK0RsVQhjzcu+te2isuFMx7WYpcHavUPkz9y8Y3OlcRQQI1hrLyymwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1Z2YWD4Sr8HL91H5loOg1Yst8BRluAOxKYTFXDqaUI=;
 b=hBLWYZmSlDZZQF2ODdorHcOTTyntJ39Ow5YM8sGMUgNX6qNav5jsShTyX2uBUT6arOVjZ7sS42sTnof5dvkRtwOfbMbbIITn9OaHmRqoqySk2aX2vRnCsDRenkO9nsh3wac+cbxjMwZdJX7gsDX1egg36/IJUGtPYVYFe8ZS1go=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB4405.namprd03.prod.outlook.com (2603:10b6:a03:c6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Fri, 15 May
 2020 06:19:40 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 06:19:40 +0000
Date:   Fri, 15 May 2020 14:19:26 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: add suspend/resume support
Message-ID: <20200515141926.52e088fe@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:404:28::16) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0028.jpnprd01.prod.outlook.com (2603:1096:404:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Fri, 15 May 2020 06:19:38 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38a226a6-cd8f-4db1-de4c-08d7f897f319
X-MS-TrafficTypeDiagnostic: BYAPR03MB4405:
X-Microsoft-Antispam-PRVS: <BYAPR03MB440574B7D5183AF4124C8F8CEDBD0@BYAPR03MB4405.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:136;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NABEeEMHiS+KHjfp0TMqfw/EkeQIJvqpYYkSEH6EhdaGwJtAs3vIDqXS8K7rB2XdcpQ3ADtUW9LHdSYbfZQDe1fUzeOfzOGAoUWHzUWct3ICqLjA5d7847KaoAYZAWfzE2Xi18XVHsFdtgYlD3nddy+ki8uG/mvJRsW8MEFdStMbIAL4nLUyLygBPll55KjsCoHirvwT1S+Y2kBAUdDEGv1VNXlz/U4hkpw2Gbp2/XU0dNaTuCPkCrfCBTzbEY5f7GUZSjrBxoVpowGORX7LLjIkW9wyU94OcD7RE4Wn4RGQKrPJr3OfRww7+KDtAAzLAH+53Krj2WsR5yp1bOX9oHPrx5Jpmc1VhoYxbylPNk3IjcEd60drgPhs6xwVqxFSCGQdrEHxmY5SUrA+Ab4xH1BbXKZ0/mWm2XbjHDLrS+C2WIfdOrpVj7tMBVhUN8D0jNEzhG5beCnNW1jMFdmCS6embS7a5j0IMvuJEdXlts6HA/9UL4Tq0HHeBom4vx76
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(7696005)(52116002)(8936002)(9686003)(26005)(6666004)(6506007)(4326008)(2906002)(15650500001)(316002)(186003)(86362001)(66946007)(66476007)(478600001)(55016002)(956004)(1076003)(110136005)(66556008)(5660300002)(8676002)(16526019)(133343001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cRU31pdcAtGFs9n0m8eE2bk+vRwr/ET7SqJD1iDwLIlViP/lUthcEs5zcOrwsrcB6/EIqama+8+O6q18r5zQuYiVyDPALtlOmTpY/J+7fDnDmPX8td8wIHA9IwuQwXpY81YY6gEzDlibL3fldFtkMMgVYSWr0AOArHzKMNyhEvyFQ2lR6Rzl+/LgIzFjXo9z1g4L9ZuBl6Zraj1DohSjSSEgii2OCcuhTeNQUpMHoEXWZw7eSY5IW114JZse2PLYSoTyjfRJSI3JIbiTp0Gwnt0WCg8v92ljIGBIsyiKbwH53dyFRt/vvHsfaxu9/aZjAl1H1JBLNVKyazcs2BapH+pbLOQybCCRemTGtYsIpsCozqrV7gKyPLyIXEnCg2XsPw0999Q8bhOxdZ+AqpYGow4rJH7hCqWOBjJVtrHQZGHLv6I45NmL5s+BN0PQ+78FqsNNv33OLu27s/0J/ZMb6p0TQkISTv1wgqA2e0A+i9JwCL3HAAm70g2qahVnw76U
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a226a6-cd8f-4db1-de4c-08d7f897f319
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 06:19:40.1141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poRgapekn3eJKkB6pgiVWrYE36/KElrL3iBd48yZ0uKsQS1R8FKlyqxVv0JnLaQDxmxR7UHUHLnDcTExAQcQBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4405
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add dwcmshc specific system-level suspend and resume support.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 43 +++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a9ed0e006e06..64ac0dbee95c 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -163,6 +163,48 @@ static int dwcmshc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int dwcmshc_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pltfm_host->clk);
+	if (!IS_ERR(priv->bus_clk))
+		clk_disable_unprepare(priv->bus_clk);
+
+	return ret;
+}
+
+static int dwcmshc_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		return ret;
+
+	if (!IS_ERR(priv->bus_clk)) {
+		ret = clk_prepare_enable(priv->bus_clk);
+		if (ret)
+			return ret;
+	}
+
+	return sdhci_resume_host(host);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
+
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 	{ .compatible = "snps,dwcmshc-sdhci" },
 	{}
@@ -173,6 +215,7 @@ static struct platform_driver sdhci_dwcmshc_driver = {
 	.driver	= {
 		.name	= "sdhci-dwcmshc",
 		.of_match_table = sdhci_dwcmshc_dt_ids,
+		.pm = &dwcmshc_pmops,
 	},
 	.probe	= dwcmshc_probe,
 	.remove	= dwcmshc_remove,
-- 
2.26.2

