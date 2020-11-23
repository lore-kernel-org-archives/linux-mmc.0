Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386AAC2D0E4
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB88E206FA
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 19:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoKbnvxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgKWT0d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgKWT0c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 14:26:32 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE15C0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 11:26:30 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so18113938qkb.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TFu+/6vEUzlmWlhU6jgehUV0ei4xBT2kHFX6p38FCtE=;
        b=AoKbnvxjZZTDcPuymRtVPfeIDSQyMy/W61TwJ/ObA1u+tSbmDCq8ecwPSjY9NLXN4P
         zRtT7W8i6tAiGeDBY3IGckV0MzAiwQOwnA/nWOgIsxqzQHN9G5Xh9Lfuo1NQ1qgAF2H/
         VlwuwIGtnyn3JALsSShkxT6GmskGU9ZF018XLcJXtl4fvBtOxOYMxGKLl5ay91dSrVDN
         NHyV3LWyvBK/uSlhoXjf6zZCChMNj+ZB0GasRYcjS8Ujb/ToBe+CiqX8T6gSPkNAsuMH
         51oJXstuRqPLJnu555o+X4JAmtRKnKzX08/e72Pj3pFDpOwZMvMtNMFv2ZoGhlNOOhZ7
         XAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TFu+/6vEUzlmWlhU6jgehUV0ei4xBT2kHFX6p38FCtE=;
        b=tSfGOGEr9A45usB9DloVEssrw3biDEuQ4OjKbQO2VxRx1OawdLa/CJpC3HIrzAgDWD
         9rbwcKne+2FVO19kmpEGQIdzZBwrYHijXHxwV0yFVkHQvhMhuq3+wR2hdkw2iZQeZ9c6
         JsDxI4SYFdye8aAJzAE5Wa0H20gW3fxFdlJ33TJsGaUu5tu2DZxtkQN+/99H/xsXHkv1
         rf3UBDx9A2WW+he2I4brfhKhx9HWa13FJmjXmd7Bp36UesjJYQLqMeiUgkHYxwq2Y63Y
         9vgn04iya8bc8FO/TeCbDdEIxmjSovaDNIbXudU7DZiR7kUXh1T5y6RSjEgDxaTRcW5V
         L/nA==
X-Gm-Message-State: AOAM530LnY8Qh6EQpSOXlQKAPsA7UFiODroWvSomQj4YcgKN1PiGwNCD
        E+wOl/P0k/2/vkDYMIeezNo=
X-Google-Smtp-Source: ABdhPJzwBUiutOXvvUgP0g7ZNKt/1sg8CqofoNydOy1mi0nhMARze9+z1LksSBLK/qVoDpNRsZt2og==
X-Received: by 2002:a05:620a:1475:: with SMTP id j21mr1029012qkl.87.1606159589910;
        Mon, 23 Nov 2020 11:26:29 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id c6sm10997227qkg.54.2020.11.23.11.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 11:26:29 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     kernel@pengutronix.de, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: mxs: Remove the unused .id_table
Date:   Mon, 23 Nov 2020 16:19:56 -0300
Message-Id: <20201123191956.10542-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The mxs-mmc driver is only used by DT platforms and the .id_table
is unused.

Get rid of it to simplify the code.

While at it, use of_device_get_match_data() to retrieve the driver
data.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mmc/host/mxs-mmc.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 75007f61df97..56bbc6cd9c84 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -545,19 +545,6 @@ static const struct mmc_host_ops mxs_mmc_ops = {
 	.enable_sdio_irq = mxs_mmc_enable_sdio_irq,
 };
 
-static const struct platform_device_id mxs_ssp_ids[] = {
-	{
-		.name = "imx23-mmc",
-		.driver_data = IMX23_SSP,
-	}, {
-		.name = "imx28-mmc",
-		.driver_data = IMX28_SSP,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, mxs_ssp_ids);
-
 static const struct of_device_id mxs_mmc_dt_ids[] = {
 	{ .compatible = "fsl,imx23-mmc", .data = (void *) IMX23_SSP, },
 	{ .compatible = "fsl,imx28-mmc", .data = (void *) IMX28_SSP, },
@@ -567,8 +554,6 @@ MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
 
 static int mxs_mmc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(mxs_mmc_dt_ids, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct mxs_mmc_host *host;
 	struct mmc_host *mmc;
@@ -593,7 +578,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		goto out_mmc_free;
 	}
 
-	ssp->devid = (enum mxs_ssp_id) of_id->data;
+	ssp->devid = (enum mxs_ssp_id)of_device_get_match_data(&pdev->dev);
 
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
@@ -723,7 +708,6 @@ static SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_suspend, mxs_mmc_resume);
 static struct platform_driver mxs_mmc_driver = {
 	.probe		= mxs_mmc_probe,
 	.remove		= mxs_mmc_remove,
-	.id_table	= mxs_ssp_ids,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.17.1

