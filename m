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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8014C433E0
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 22:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874A164E68
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 22:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhCNWiX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCNWiQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Mar 2021 18:38:16 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5EC061574
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 15:38:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id cx5so6922361qvb.10
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lVuNRu2umrsYreEgAnUJKb+JUoP1gtQHomdlG7pOVKo=;
        b=vd7Z/jZp/NBr7BXKBukqcG9D2tX41dYJfinhFZC3bNy3u0qn9dNFBs1mD4Xme83BVw
         LL62VydoKaD/QdzatE/SLptqJlUuJP80BFPkQsn7zaG132JE2od2eLcGRYWJOG4g/inW
         FIku/HrMpAhfmtxlv7t9ni5DSODG8YmDZkhH4mL6xZfFIc2tzEvyHIkURF1mEu0M3N2n
         a8uls2hF+5yAnKEdSyepwvhRqoDj14/6z5GM0aWoNEq260qT2SYCFlbr9b1vXh4yDgIb
         fNLD0X9nKtGP7ugew3b4dG/xphKIwbtvvyZUtA8A7ujEKCrpK8eaq3BX1Xgi6GKo37sC
         gfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lVuNRu2umrsYreEgAnUJKb+JUoP1gtQHomdlG7pOVKo=;
        b=Mtz9ll5Ep94viGmIBxNueXdRo67AJqLFn7yFnsKYnIPamYtlSrGJTf3uewy7JFS3yg
         XY8oBmhQpXnwcsGJZCVKzRF9WRhWWpdhdqCSZcEIZ2IsModaK0DxqZOXgva2JI6mygGU
         pvOoq6+17Du6jV5lIyw8drE/uj4DOYzF3zNTEZbk0IPH9i52ZeQqdwcGPz+mCaeq1e8Y
         7bvZ57nLUQCpi+72oimW4udk0oo13phUo8tcs2LZCozcgMP0SOgmAl9xMI61yMckRwX4
         lJ/mlk1tr7l9pSfFqpG3pEsGwu+9zRpTEVUuWsDJAJGxw8FKthGRsOQxycz55qn4DMSJ
         7rFA==
X-Gm-Message-State: AOAM531rT7a2WFbTTie//EsPbzJv5M1nCcMDeO2u1EKih9gkUt5onKB/
        ZaoaJd2HtgK4PwGPlqOTfkM=
X-Google-Smtp-Source: ABdhPJyNW6Xn5ok6DsA3lGnJxk50RTP7cAbNCTDs4Nqal8gQ5CfY07Xabk5IPMUNitSXxMHKeIgQpA==
X-Received: by 2002:a0c:bd82:: with SMTP id n2mr8138222qvg.62.1615761495554;
        Sun, 14 Mar 2021 15:38:15 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919:d9cd:fba7:d537:4be3])
        by smtp.gmail.com with ESMTPSA id x17sm4210542qtw.91.2021.03.14.15.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:38:15 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: Use device_get_match_data()
Date:   Sun, 14 Mar 2021 19:38:02 -0300
Message-Id: <20210314223802.148413-2-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210314223802.148413-1-festevam@gmail.com>
References: <20210314223802.148413-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The retrieval of driver data can be a bit simplified by using
device_get_match_data(), so switch to it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2a1fb1cd4433..d309cc620fdc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1507,8 +1507,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(imx_esdhc_dt_ids, &pdev->dev);
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct cqhci_host *cq_host;
@@ -1524,7 +1522,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	imx_data = sdhci_pltfm_priv(pltfm_host);
 
-	imx_data->socdata = of_id->data;
+	imx_data->socdata = device_get_match_data(&pdev->dev);
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
-- 
2.25.1

