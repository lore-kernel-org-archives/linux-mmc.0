Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F5EC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 26 May 2022 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbiEZLpV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 May 2022 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347207AbiEZLoj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2022 07:44:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0510D02A3
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2022 04:44:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j6so1463938pfe.13
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2022 04:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFDZFO8zcq3mdOYMY85R5XhCqGoT7ekIVqfcal4vq9k=;
        b=DdLAOSyeCe3VdSlghPOPR26L4TtMKKCTQ5eKXAKK+10kIhUkQ83tMrA/1RpbabSazS
         kV6nbvicZrBGsl5IcdntaWX0fV6MCSW1wdiQJTxyHiodRUYUZ11tf5PZA2ahicLgxrUo
         6ZacmpFJ5OF6b5gRWNANLmf6dpaESFfPH99GDIPXtJ3SwlNJutaOa3SCUTYIXpdBo+Vd
         I8V9aMtIybOdUujY41iWsXh0sgD7XOPwT6wyHWCJDn/ZIfp5B3sfGTv08/HbdRdVSuce
         kSLvoxCYkqh6y9ZDmfwO4qM+DWWM36B5cyqGUtzByYX9EUBXqpGlCNxEkh2MUme2AAB9
         K6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFDZFO8zcq3mdOYMY85R5XhCqGoT7ekIVqfcal4vq9k=;
        b=j9LMA5gxAY6eTvkvf++iCppB+Gi9f6+/b+LM8U1YYPY2dsnY8NB5P8Uwz2nj9Bnzxi
         hoT9cRdedftDV8voysLGp6ogyYUy+H1qXJvZAxIeAOObVZYGVtopBCr1tEiXkokjBw8S
         jt74ssFU2eI86AsNl15nIPEh7rUToccyiws+Ry9LTFD0gdER0H/Z3SQStL8RC8KjidTM
         8Awo5MpkNZBP4+ZqB1mGJ9kyvrih9hU/Fh539wuKUbB4DOLGeO51eUprkW5trk5gRjMC
         BkTWIdsNR4NAxcacOwYLis0uEjSSuX+HrTLOEZfCZogwXFdVbxRWt9zmAZb2FS1r6g3M
         KghA==
X-Gm-Message-State: AOAM530PAJU2IZ1tODNCi0EoFppqV+hH6BZuAjQ2l//baXmWF09HCwl9
        NuPAHGvS+eVI5/f9fDBOjuBXl+bHjGSMwA==
X-Google-Smtp-Source: ABdhPJymmr3E7XzXOfh11AxGgFOnPpiUnAkMyJxfXNlpjU0Cl3k3slf4lmK7hGJQYeI+J0tXrl2TGQ==
X-Received: by 2002:a63:8bc1:0:b0:3f9:f00b:f877 with SMTP id j184-20020a638bc1000000b003f9f00bf877mr21914328pge.378.1653565465428;
        Thu, 26 May 2022 04:44:25 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id f13-20020aa782cd000000b0051887e34143sm1269772pfn.129.2022.05.26.04.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/31] mmc: sdhci-msm: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:18 +0530
Message-Id: <80314068d96eb53e0d9838736415b96015803844.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 50c71e0ba5e4..994f3f0231f7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2496,6 +2496,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	const struct sdhci_msm_offset *msm_offset;
 	const struct sdhci_msm_variant_info *var_info;
 	struct device_node *node = pdev->dev.of_node;
+	struct dev_pm_opp_config opp_config = {
+		.clk_name = "core",
+	};
 
 	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
@@ -2564,7 +2567,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto bus_clk_disable;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	ret = devm_pm_opp_set_config(&pdev->dev, &opp_config);
 	if (ret)
 		goto bus_clk_disable;
 
-- 
2.31.1.272.g89b43f80a514

