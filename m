Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9726C5519F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB7B222EC
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swGeYFPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgKQLiA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQLiA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:38:00 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6159AC0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:38:00 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 199so19965302qkg.9
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UYY2bJWrCgkwZmKE57ljePo4YXcsUm06TLKcQz+CVVQ=;
        b=swGeYFPO5RADskeMbGBpqC7R/seNNnR5kVKa6gLJUnS/bLjhl2hfhyUSJxyFFrerIM
         LJ3l3deTnEetEAWlqmCmBRlOQExcrmoTKdd9Avwiro9oe/13mBqDRufvIyf0F1kAz9Qr
         QbHOm7iRXXaj17T8hWQ1Ddc5i35JOY/JnmH8otwYp9tq9QpBrc5TcUnMIjWta/nVE76c
         wdNtYNk7rcmk8xZxbFeG3KsAYxMhkynHPCFH5t8cQPMSD2r4Z5Hyv2+Nie+esvUz/3Il
         qUhOQ6H6GKa2uJorKooq17Qn4CVMRISchDpUuWJh6d/WQhlCaZESAhHa6NxwNCarTaBc
         DExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UYY2bJWrCgkwZmKE57ljePo4YXcsUm06TLKcQz+CVVQ=;
        b=IWCUk6Jh3GfaZ9w5ynitNXVhcZYVIhc4CYE9hja99uU6SXOxPHWSGAtJsbwVAaINuX
         0YBE3XOn9/Y5VX14vwf9eKJhxbWRnPs694buY5xaDFYWjOl0izuf0ayhq+fVxDMc+Znv
         HAiM20b72lfMQ2r6vPAQHZO6i47ZnyiXhukXhb60zRSmxV1kdE1v+Jbu6PAoHOyBT+qs
         C7n/g0LQulFabRxbQP3CrhMObNE/2ImPI0EoOP03Gyi3MSO4YpAm70smDVTljBRlK3/w
         PlbACFlFZgJFSJ2wpKcTo9DXqaNIfxR+wuasKvBylAljBCfhzFitfg1Kip6ZZ5aewoLg
         7LkA==
X-Gm-Message-State: AOAM531F1lJOqpDtT0QlxnEbX5D6QEmC2OvgF08zz79WH/VNPbw5I+cv
        0l+FIiPmisjuMeDnqP9NASrrsQq2WR5/pg==
X-Google-Smtp-Source: ABdhPJwCoFQMyITBlamIBYnEJqTs4ZQxexFZHRP3Bm2IhOoO9KalfVlAYhEb33gCjY/sP37bl/U7JA==
X-Received: by 2002:a05:620a:211b:: with SMTP id l27mr19787189qkl.352.1605613079560;
        Tue, 17 Nov 2020 03:37:59 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:997:213a:a240:fc07:36c8])
        by smtp.gmail.com with ESMTPSA id a1sm13395695qtw.11.2020.11.17.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 03:37:58 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, shawnguo@kernel.org,
        kernel@pengutronix.de, haibo.chen@nxp.com,
        linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Convert the driver to DT-only
Date:   Tue, 17 Nov 2020 08:37:50 -0300
Message-Id: <20201117113750.25053-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
by removing the unused non-DT support.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 91 +-----------------------------
 1 file changed, 2 insertions(+), 89 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index fce8fa7e6b30..16ed19f47939 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -296,22 +296,6 @@ struct pltfm_imx_data {
 	struct pm_qos_request pm_qos_req;
 };
 
-static const struct platform_device_id imx_esdhc_devtype[] = {
-	{
-		.name = "sdhci-esdhc-imx25",
-		.driver_data = (kernel_ulong_t) &esdhc_imx25_data,
-	}, {
-		.name = "sdhci-esdhc-imx35",
-		.driver_data = (kernel_ulong_t) &esdhc_imx35_data,
-	}, {
-		.name = "sdhci-esdhc-imx51",
-		.driver_data = (kernel_ulong_t) &esdhc_imx51_data,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, imx_esdhc_devtype);
-
 static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
 	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
@@ -1531,72 +1515,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 }
 #endif
 
-static int sdhci_esdhc_imx_probe_nondt(struct platform_device *pdev,
-			 struct sdhci_host *host,
-			 struct pltfm_imx_data *imx_data)
-{
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
-	int err;
-
-	if (!host->mmc->parent->platform_data) {
-		dev_err(mmc_dev(host->mmc), "no board data!\n");
-		return -EINVAL;
-	}
-
-	imx_data->boarddata = *((struct esdhc_platform_data *)
-				host->mmc->parent->platform_data);
-	/* write_protect */
-	if (boarddata->wp_type == ESDHC_WP_GPIO) {
-		host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
-
-		err = mmc_gpiod_request_ro(host->mmc, "wp", 0, 0);
-		if (err) {
-			dev_err(mmc_dev(host->mmc),
-				"failed to request write-protect gpio!\n");
-			return err;
-		}
-	}
-
-	/* card_detect */
-	switch (boarddata->cd_type) {
-	case ESDHC_CD_GPIO:
-		err = mmc_gpiod_request_cd(host->mmc, "cd", 0, false, 0);
-		if (err) {
-			dev_err(mmc_dev(host->mmc),
-				"failed to request card-detect gpio!\n");
-			return err;
-		}
-		fallthrough;
-
-	case ESDHC_CD_CONTROLLER:
-		/* we have a working card_detect back */
-		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-		break;
-
-	case ESDHC_CD_PERMANENT:
-		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
-		break;
-
-	case ESDHC_CD_NONE:
-		break;
-	}
-
-	switch (boarddata->max_bus_width) {
-	case 8:
-		host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
-		break;
-	case 4:
-		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
-		break;
-	case 1:
-	default:
-		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
-		break;
-	}
-
-	return 0;
-}
-
 static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -1616,8 +1534,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	imx_data = sdhci_pltfm_priv(pltfm_host);
 
-	imx_data->socdata = of_id ? of_id->data : (struct esdhc_soc_data *)
-						  pdev->id_entry->driver_data;
+	imx_data->socdata = of_id->data;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
@@ -1713,10 +1630,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto disable_ahb_clk;
 	}
 
-	if (of_id)
-		err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
-	else
-		err = sdhci_esdhc_imx_probe_nondt(pdev, host, imx_data);
+	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
 	if (err)
 		goto disable_ahb_clk;
 
@@ -1929,7 +1843,6 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 		.of_match_table = imx_esdhc_dt_ids,
 		.pm	= &sdhci_esdhc_pmops,
 	},
-	.id_table	= imx_esdhc_devtype,
 	.probe		= sdhci_esdhc_imx_probe,
 	.remove		= sdhci_esdhc_imx_remove,
 };
-- 
2.17.1

