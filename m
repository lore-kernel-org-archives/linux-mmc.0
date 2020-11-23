Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2406DC388F9
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 20:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC33820721
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 20:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DarpWy4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgKWUcS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgKWUcR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 15:32:17 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0628C0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 12:32:17 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so18381761qkf.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 12:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WfHD3wtkJ9eqDVS5n7NqY8e+zW11O/9dok3QdpYHCDA=;
        b=DarpWy4Auzm7a/4Vhacg6luptaG0lWuaWIDDzK0/tC3gPwoM0bF1i66rrKOKjCMeB2
         gpjS79s4sIOKP/A2mrn207CwEH4ekUV5rpIrv9xEjsgcQf52y2ZpYUM9C0bcRU2A3NZr
         0Xw6pYr8Cw9fT0paY9Z+ZWneaEzNPaXbPMYuTXUwQsNF3mdTnCJM+vfeDWLiEuIN2Ast
         BFhvyeRQMahNtB9Z342DMvdJvOkAl3rrGWfjyJvGDhUCMcIZGLzzMnUMjM99Cd2uEArw
         35PCX+lGs2WnpyYUimvWiv6YC1P3UrJ3z9OzhOab/cfAqgc79Gm65zdPjSgfU18WDbU5
         Irig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WfHD3wtkJ9eqDVS5n7NqY8e+zW11O/9dok3QdpYHCDA=;
        b=exJo+CC8o3m4NHpzBlCte6DycMDQNC3XfhxMex6eRlNxoaMCZh5sVTpMEpEzsO9BUf
         so35zVXMmeeiQwTBNMbrQ8NI2g2xUCMg6JlOH6Ae2hWUFrjoO9kDoCelrxJ675x3JxDR
         wPxngL+kuJ58JJV+Hg/7T1clhtHT8dPMzl6Z8CTUBDJJiUakRBQQUPnVYoTQ5UVc9ns5
         VgM5IUqBIN54fveV7b7l2TYHZoB8fMifWeM1FxcOns/hgLJLKbTqnQOgn13lhAIJ1I3F
         gFg6b/A5tTiL2/4HOiCF6wb5Ek/rF1Shb6oNrzXxxnc9NfvwRRzrWAG+3zzPbGq9pd0K
         pluQ==
X-Gm-Message-State: AOAM531tv7hG2vnSBpgkYj83Xzn4JpvwIrcQIVK/XPzUJ6rAaNRBO8qE
        83xwlBKjsFMMXCnB17gNK8PpPov2iN98Tg==
X-Google-Smtp-Source: ABdhPJzSQ69+JW6fae7em5TFzWBDjA2upT2S+Yq37824jQqakZH06NzOuHunsh+sMg9Q7XuiH9JHBw==
X-Received: by 2002:a37:77c5:: with SMTP id s188mr1402680qkc.266.1606163536936;
        Mon, 23 Nov 2020 12:32:16 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id d48sm11433822qta.26.2020.11.23.12.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 12:32:16 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: mxc: Convert the driver to DT-only
Date:   Mon, 23 Nov 2020 17:30:04 -0300
Message-Id: <20201123203004.18792-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
by removing the unused non-DT support.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mmc/host/mxcmmc.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 12ee07285980..2fe6fcdbb1b3 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -157,32 +157,16 @@ struct mxcmci_host {
 	enum mxcmci_type	devtype;
 };
 
-static const struct platform_device_id mxcmci_devtype[] = {
-	{
-		.name = "imx21-mmc",
-		.driver_data = IMX21_MMC,
-	}, {
-		.name = "imx31-mmc",
-		.driver_data = IMX31_MMC,
-	}, {
-		.name = "mpc512x-sdhc",
-		.driver_data = MPC512X_MMC,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, mxcmci_devtype);
-
 static const struct of_device_id mxcmci_of_match[] = {
 	{
 		.compatible = "fsl,imx21-mmc",
-		.data = &mxcmci_devtype[IMX21_MMC],
+		.data = (void *) IMX21_MMC,
 	}, {
 		.compatible = "fsl,imx31-mmc",
-		.data = &mxcmci_devtype[IMX31_MMC],
+		.data = (void *) IMX31_MMC,
 	}, {
 		.compatible = "fsl,mpc5121-sdhc",
-		.data = &mxcmci_devtype[MPC512X_MMC],
+		.data = (void *) MPC512X_MMC,
 	}, {
 		/* sentinel */
 	}
@@ -1001,13 +985,10 @@ static int mxcmci_probe(struct platform_device *pdev)
 	int ret = 0, irq;
 	bool dat3_card_detect = false;
 	dma_cap_mask_t mask;
-	const struct of_device_id *of_id;
 	struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
 
 	pr_info("i.MX/MPC512x SDHC driver\n");
 
-	of_id = of_match_device(mxcmci_of_match, &pdev->dev);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -1044,12 +1025,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
-	if (of_id) {
-		const struct platform_device_id *id_entry = of_id->data;
-		host->devtype = id_entry->driver_data;
-	} else {
-		host->devtype = pdev->id_entry->driver_data;
-	}
+	host->devtype = (enum mxcmci_type)of_device_get_match_data(&pdev->dev);
 
 	/* adjust max_segs after devtype detection */
 	if (!is_mpc512x_mmc(host))
@@ -1241,7 +1217,6 @@ static SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
 	.remove		= mxcmci_remove,
-	.id_table	= mxcmci_devtype,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.17.1

