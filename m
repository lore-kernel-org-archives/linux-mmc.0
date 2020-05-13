Return-Path: <SRS0=M0Y2=63=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9339CCA90AF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C68C206D6
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 10:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Earu827L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgEMJrY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 May 2020 05:47:24 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:63410
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732838AbgEMJrW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 13 May 2020 05:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+LmGRdZOlWFl+oTIkE0edEeJrAS6yFOuMR+ZYsA+qPWH9at6GAiI2pS9tB6vkNKY/0iedUIhvBW+11xmhMtaAvWYzER70c9b3y2SL9VztTT0kJ48HtEQQP7El0kyZUX5DSGdpVL8Yf1LSbeZkx9U0VFklDKDDHcKePg+ytF0a3GmeQckDFG18MeQxcZggSHOgBlYl9NTfw6BGcwYuIqQN4JdPHPiY3L5yA4KhEQaoSvZgZdNoUW4eX67YAWlejy2rqzxengxnsNrMeti0a8XlnlzvOs5mrq6+Sk55LXaiJ1zuylwK0LG58uRG4V6OeIJJ3TkRmfW/usyR48tzPGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2qJ3gmIeDXse/6D+15+kFY18wxftv82JxJZT/2E+JQ=;
 b=ex9eizHh1RsEvUwQvPs87mK8DIDupfzVQySQG5M/URmsNqvcXRuwoABYrYCm+rutX6h/jT5JCeFexFg35K8QzNB4gCWfwwIEfqcKr6J3PulxAYXxzFZ8JSZ7uaU28/VV1hr2k37NkjDXk0A4oLmcQA+ZRiwsyrMPrLTzh+aaEMAsQEfFQqsQxKYGbFDTZb0CjUZO0SOoDA//O41twMjQJd8wxvwVmAxbD8xUQff3N0kyjsaxMI4+VpBZbCe58XrSiwYY7AYUnYyhSPAlUmEE/adt0Kk1qnBdaKSfxmdj4zY41vFAPoenKGhiUuJh4PuzfRWtVlmIN8MvmZypRViiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2qJ3gmIeDXse/6D+15+kFY18wxftv82JxJZT/2E+JQ=;
 b=Earu827Lf0q3MLaQ0oq4+6yHdo6XNqhfJyyaVfAWIMWv30GoQhMuzAbSifEMemLvtRGz51jQPdeRanLgRE5SD7rDGNOasDgcUpgeUSafGQdCtwPjVpAZT8/MzNld5D+nfFSQ8OFSwXRT8+l4D3wp6HPfv69+QeMpbFEjQCLu/V4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3703.namprd03.prod.outlook.com (2603:10b6:a02:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 09:47:19 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d8fb:de22:43b7:fcb7]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d8fb:de22:43b7:fcb7%7]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 09:47:19 +0000
Date:   Wed, 13 May 2020 17:47:06 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "mmc: sdhci-xenon: add runtime pm support and
 reimplement standby"
Message-ID: <20200513174706.3eeddb2b@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:1::29) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYCPR01CA0041.jpnprd01.prod.outlook.com (2603:1096:405:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 09:47:18 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40412952-eb90-4582-9c77-08d7f722a098
X-MS-TrafficTypeDiagnostic: BYAPR03MB3703:
X-Microsoft-Antispam-PRVS: <BYAPR03MB37036641B96E1A09F889F0C2EDBF0@BYAPR03MB3703.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRIVHu+FG7eWxd8lmlAE93+kqTyaotZyht0hl2t+uZO9p7osLYiDShczpJVidz/iWjnkFW/0O1YbGTpL0XOcoS9UqlOK2CUTqzwGbLoun/aX44jWrCNUlLvKeHBRWWIKN/smkio1BuqeMi+DmCvt3eHzhyZ2awgJz8Tk3XntbqAo4bpZQsZvofxiNetRQ2z7a3EV2gLnT9MFXW1WAVJiyN2ZvIgz5Dc1b48HwJ0PLO6mHcCNnrfyqe1zZ8JvcZbPAvbbI0ogMZ98NXhCeRcXq5Rb1PnK6irMq8YWOo76vijc75z5veb5eAG3GDEp3u0HV54sH1SN/UoUUljFBy06kzuAGcIAxqtrbRVJi2Ap9/6cEeR61dVYFhdJu2Nmf2DqRqUU24jCGcfRWiAIYMq8yoDpLLKTCgZAIdpZSVZ4RnIqr7ltPCTDY713A8dAf/WyBuIEufiHRJik0UGakbBaoV2wARRsIpgpTksZxhQycSuCgXwoB8wk4+iT1cRb/8PfnA69gAHqt+mPvCVM2EYtAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(366004)(39850400004)(33430700001)(7696005)(1076003)(16526019)(26005)(956004)(186003)(6666004)(6506007)(2906002)(9686003)(5660300002)(52116002)(55016002)(478600001)(8676002)(4326008)(66556008)(8936002)(110136005)(316002)(66476007)(66946007)(33440700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VMyrdi0eai0pVJoDJJGnwQORtcxJXWhh8IavLDGQoFnDwzWY/fqVgU2XYU05Gi0PXL0D9qRyE5IYbbpyJn74wXSPiya3oNwJyVmF50JsNNsCqjGIxn0oZinm6DtAl/H0eREErvkGC6CJAs5UY9nEWlT6nrwDODj1torJk9X5cgTNAHYm/a5RoxeW1L8dtUvcLoZ7bfi8JbvwCLxHZQzWrOd+iRORhGK/5z6jIyTjjFCy8Zfh0N44S371traIMx48TpXsLyuQlip5q2wkh028DdUvMIOlsc2CM1KwkhbNDObhWyntjvjchsb2cdZgtuPW+yphNs1sh4ZE9t8be5Ossie1xkINUqCDqgkzUMWprK/lpXxWJgEsT8yKOqytL792eMQlfKBh81uM7LgPGxTC8gmiMO6N3A2Ep1D9KozK0QqTGctQ0iYg2OOVXjwUGdM1BKYT58E+Qm1TvrgLsInH4OqymISy6WEE9DBSpb9k4mlpsM9t98/nKLNr/n2vUJiz
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40412952-eb90-4582-9c77-08d7f722a098
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 09:47:19.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QcPO5XL6OknrXkzILP8UXH/MRpKEV4b58or7gxG4QHQreyUguSLgzjnk4raU/ytMQDR2+TfYjsogpE1Eg4DVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3703
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This reverts commit a027b2c5fed78851e69fab395b02d127a7759fc7.

The HW supports auto clock gating, so it's useless to do runtime pm
in software.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-xenon.c | 87 +++++++---------------------------
 drivers/mmc/host/sdhci-xenon.h |  1 -
 2 files changed, 16 insertions(+), 72 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 4703cd540c7f..85414e13e7ea 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -15,8 +15,6 @@
 #include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/pm.h>
-#include <linux/pm_runtime.h>
 
 #include "sdhci-pltfm.h"
 #include "sdhci-xenon.h"
@@ -539,24 +537,13 @@ static int xenon_probe(struct platform_device *pdev)
 	if (err)
 		goto err_clk_axi;
 
-	pm_runtime_get_noresume(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_suspend_ignore_children(&pdev->dev, 1);
-
 	err = sdhci_add_host(host);
 	if (err)
 		goto remove_sdhc;
 
-	pm_runtime_put_autosuspend(&pdev->dev);
-
 	return 0;
 
 remove_sdhc:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
 	xenon_sdhc_unprepare(host);
 err_clk_axi:
 	clk_disable_unprepare(priv->axi_clk);
@@ -573,10 +560,6 @@ static int xenon_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
-	pm_runtime_get_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
-
 	sdhci_remove_host(host, 0);
 
 	xenon_sdhc_unprepare(host);
@@ -593,78 +576,40 @@ static int xenon_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
-	ret = pm_runtime_force_suspend(dev);
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
 
-	priv->restore_needed = true;
+	clk_disable_unprepare(pltfm_host->clk);
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
-static int xenon_runtime_suspend(struct device *dev)
+static int xenon_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
-	ret = sdhci_runtime_suspend_host(host);
+	ret = clk_prepare_enable(pltfm_host->clk);
 	if (ret)
 		return ret;
 
-	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
-		mmc_retune_needed(host->mmc);
-
-	clk_disable_unprepare(pltfm_host->clk);
 	/*
-	 * Need to update the priv->clock here, or when runtime resume
-	 * back, phy don't aware the clock change and won't adjust phy
-	 * which will cause cmd err
+	 * If SoCs power off the entire Xenon, registers setting will
+	 * be lost.
+	 * Re-configure Xenon specific register to enable current SDHC
 	 */
-	priv->clock = 0;
-	return 0;
-}
-
-static int xenon_runtime_resume(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	int ret;
-
-	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret) {
-		dev_err(dev, "can't enable mainck\n");
+	ret = xenon_sdhc_prepare(host);
+	if (ret)
 		return ret;
-	}
-
-	if (priv->restore_needed) {
-		ret = xenon_sdhc_prepare(host);
-		if (ret)
-			goto out;
-		priv->restore_needed = false;
-	}
 
-	ret = sdhci_runtime_resume_host(host, 0);
-	if (ret)
-		goto out;
-	return 0;
-out:
-	clk_disable_unprepare(pltfm_host->clk);
-	return ret;
+	return sdhci_resume_host(host);
 }
-#endif /* CONFIG_PM */
-
-static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(xenon_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(xenon_runtime_suspend,
-			   xenon_runtime_resume,
-			   NULL)
-};
+#endif
+
+static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
 
 static const struct of_device_id sdhci_xenon_dt_ids[] = {
 	{ .compatible = "marvell,armada-ap806-sdhci",},
@@ -678,7 +623,7 @@ static struct platform_driver sdhci_xenon_driver = {
 	.driver	= {
 		.name	= "xenon-sdhci",
 		.of_match_table = sdhci_xenon_dt_ids,
-		.pm = &sdhci_xenon_dev_pm_ops,
+		.pm = &xenon_pmops,
 	},
 	.probe	= xenon_probe,
 	.remove	= xenon_remove,
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 593b82d7b68a..2b9b96e51261 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -89,7 +89,6 @@ struct xenon_priv {
 	 */
 	void		*phy_params;
 	struct xenon_emmc_phy_regs *emmc_phy_regs;
-	bool restore_needed;
 };
 
 int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
-- 
2.26.2

