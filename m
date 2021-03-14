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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D2C433DB
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 23:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8A064E57
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 23:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCNXJB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Mar 2021 19:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCNXIg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Mar 2021 19:08:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B0C061574
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 16:08:36 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f12so7963840qtq.4
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A2vG4TjxoDOHEO33WGWdmTznypWEIAkehf/qFUWHQu4=;
        b=HxL8xn9HevHRWFeEiKhFKWoSbkgNN5617HjItPwNnIW+dnYGczV/OLMAYgfEetu2YV
         7kV9M9GZpTFlybfTID11syqMAi8XcPPJTCKkLaemA9ljulryEOs3/vSs0kmdv/nKFlRF
         ICDI4BjFy8apqNkb9CLA+y5AbC7ss0q/zPwEJTsSRmmnuexqQCQ7qYzhhWWeHpWduL8H
         7kWEphXNicMRwP0pN30LRENHRV0bvpt6t1ytGGDcpsEd+RJkyvlmlmtE3AYySoRjp36L
         Fycego2cM6QusCBoqZjCTcffhvRTF8RopCtEVHmOAKAfh5XRdJ7R+ULmn+OwtuVKVaF/
         wFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2vG4TjxoDOHEO33WGWdmTznypWEIAkehf/qFUWHQu4=;
        b=bx7TY12dPCCRoIpFzjkJSHpjgcIbHlBbsZKtaryMzXqyd5Ejb+zh8pMz8Kry5XPLsL
         OZtTEsGI7BgWZM1L/myvmdjtxlE6+OXp8tmGzXCAaLaj/azfZUXE+0/CsAuWGojTl/NR
         nNMvvOJBV2RYB59ict5KSusTw2z3xjHtUkpKiphzXB+GGMsyJvNTYwECCxj2eWP17aCU
         96nDdtjDTmYotRVnt7ZFxps5161wC/ugPseJWYUQzsmhbgNzELLM+hBQQeJtZ5INKwoF
         Aas8Z7dSt82ylgE0OmXFAusgyODBNXQaOccVGecZOrM3bxxa6G8OGGhYnzC1kf8bM4SP
         8k4w==
X-Gm-Message-State: AOAM531fvd9MykQmj0yHeGgqb7v2H/YV9zg45daxoBxIjNhARFABBYn3
        sFeKfjWeK3Fstz3Fujox0IbMKQl1X4asow==
X-Google-Smtp-Source: ABdhPJz6+HZh1Gwlv4s0+aXGBG9YUX/4XIqhLxDjtg+2SeW/QOxsE6daoUNP8cqiNgfQG7AeUNnTVA==
X-Received: by 2002:ac8:6e85:: with SMTP id c5mr20144666qtv.299.1615763315352;
        Sun, 14 Mar 2021 16:08:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919:d9cd:fba7:d537:4be3])
        by smtp.gmail.com with ESMTPSA id q187sm10980811qkb.36.2021.03.14.16.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 16:08:34 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: Use device_get_match_data()
Date:   Sun, 14 Mar 2021 20:08:24 -0300
Message-Id: <20210314230824.148969-2-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210314230824.148969-1-festevam@gmail.com>
References: <20210314230824.148969-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The retrieval of driver data can be a bit simplified by using
device_get_match_data(), so switch to it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- None

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

