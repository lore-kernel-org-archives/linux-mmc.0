Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF340CCA485
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Jul 2022 08:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiGAIWu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiGAIWJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2022 04:22:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F371BEB
        for <linux-mmc@vger.kernel.org>; Fri,  1 Jul 2022 01:21:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so1994096pjz.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Jul 2022 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5O8HtibDyhyKfPcXegSlcVtfe6YcZDhYRydgSEzbr0=;
        b=Q5+hIz3misrwGjtVkcwPGiY6SsSZJoHazFfpDneO8cv0SmpOfUE2TCUYFNf53aNpC5
         ySuFYkkHvYZ0fCE0v1RMv6useoSkB+meDqAIMS3SMe/Ny6XJSG84u28lqRgA4F4YQRPA
         3dLE+Z1hDroFKpraCga3cIab2AgkJKa0KJ3Ug1XI7IMozj+I85CW6jxkwCCStRfGfRHX
         H/VIuDY6xIUTomsG6LMeAIVUyPBnsCbwrbmP07Q4LqbNg8AxLEX6jwj1uskFJ27NqJS7
         0aVDYtNpByYlvKJjBaf5VA5fktLznoOTngiOCBhzcEW9jKE/iS1r+mORXU9u4utkdw39
         YdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5O8HtibDyhyKfPcXegSlcVtfe6YcZDhYRydgSEzbr0=;
        b=Z7EZSEwMHw/F47LBuOskklN+p+mNMY/uDc9GAzDY/Vrfdix5+7PyYO9/eUUjLSljAJ
         n4mJn4YqTPWx6w7+gEGWceD4XGKI6mSqzIKrnV6hBMawfVmyljLS7k9lDq5i0MlDZKy8
         HcytjEwIZ9jenVR2YqxhQrPyIvkj2A5Szc8Lj1dRGSppSAggL1BzBGmTlcBdC8S9DUAJ
         QY4Z9mRG/HUHXHcU9JBJZgStF8j21xvNYgu69qopeVhexs9fZnRiLosDgJH6/2P5XdAB
         tREsXxHNSn+kfrGrsyz+IpeRlmFsISOiXBRE2bkkm7sf/J/b9uF6Z6MrH9fYG1V06i77
         myhQ==
X-Gm-Message-State: AJIora9AfSyiT7xs48wK04PL44OudRMQvfGjazplx99kKQveYA5PxurT
        kU5uUTx3VSSoOU1WNBAj5n8uyQ==
X-Google-Smtp-Source: AGRyM1uE34LiugWoSOiCI/R/CIeUM3AeDcL6MBnSlwEJpw4aDlvU1YVki6qfw7/sbXujeSoA7MkgIg==
X-Received: by 2002:a17:90b:1d0e:b0:1ef:1a2c:c628 with SMTP id on14-20020a17090b1d0e00b001ef1a2cc628mr15422174pjb.52.1656663697862;
        Fri, 01 Jul 2022 01:21:37 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902b40200b00168dadc7354sm14806724plr.78.2022.07.01.01.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:37 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 19/30] mmc: sdhci-msm: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:14 +0530
Message-Id: <9c63b2dd7990e8215105774cf977231a841a5a31.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Ulf, I have kept your Ack as the diff is really small, clk_names is an array
now.

 drivers/mmc/host/sdhci-msm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e395411fb6fd..a018b45c5a9a 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2559,6 +2559,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	const struct sdhci_msm_offset *msm_offset;
 	const struct sdhci_msm_variant_info *var_info;
 	struct device_node *node = pdev->dev.of_node;
+	struct dev_pm_opp_config opp_config = {
+		.clk_names = (const char *[]){ "core" },
+		.clk_count = 1,
+	};
 
 	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
@@ -2631,7 +2635,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto bus_clk_disable;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	ret = devm_pm_opp_set_config(&pdev->dev, &opp_config);
 	if (ret)
 		goto bus_clk_disable;
 
-- 
2.31.1.272.g89b43f80a514

