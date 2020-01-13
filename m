Return-Path: <SRS0=rMqt=3C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2AC33CA9
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7D524655
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvNq4fxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMVH4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:07:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38033 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAMVH4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2020 16:07:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so5298817pgm.5;
        Mon, 13 Jan 2020 13:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c4EwOwGyRZn732m62F/bmkLNPBHupsvQnM8EZTJTEOU=;
        b=TvNq4fxIGcMuRSTocpaToEWweIJ2INFcSGkfkTb2PGFYP4PexLnpNWn0jgZYGYkBrv
         VcgNEUh9ux0x752QjnvpckLrBNTTBhvRbXKtk3vwZq8JrI/K3L+8JDPweSfGXHyj/NDp
         SvdW6n05jJp7R3pUNZSHm0PkJ2hw1hb2HhRkTO/XwdTOK6H3f1xhiznskz7KsLuroa/l
         9xL/gQ8ciwMwcwuf7vlBvbai/qoolqJVhLzDwQXYFaAQUJloAe5eBq1QOfzWp/0ZmigB
         FnOcocIKY7rYAWBeSySjqqTjLIRtFhGBdyrIyskrV6zXFmRPVx0TZeQbIzuOaZttRLWi
         WKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c4EwOwGyRZn732m62F/bmkLNPBHupsvQnM8EZTJTEOU=;
        b=pIjvVw/BQQtIPS+rCdIFUvnWsUwm8G+rYCX/FNSWxUBMEGpktTM1STI+CgfhLYBKmR
         1mG2y3/jr6VDeOfuX8di0KjhnBeypO7iCvB/ypgOjIp7v1+yZ27p8Qw0nNP22y3a6s6x
         PYlpGA+wgq13qfEkzhllQBGymkI0C89pJwBigO4huK5Tl/Nt1C0vteX+JLSFg3HHP6wi
         XM6yoR05r6wuEcAYGSQ23VDlZhcV+0dr5h4CwCeKkks+qwvwNV3lv+1XC+u12DG6rZ2a
         /FnHIBkY0qzCQuQtrWjYb73kwTqor6/EwTztsNX+LlQCnfnduaObp3C8NB+QtvIsD8Uz
         2FBQ==
X-Gm-Message-State: APjAAAV7eTCKku5Z2arcRamOkL3L9C/hp0DAslj1hvecO5nDKQW8rSqR
        tHRWxIWDRtpN60sakRKcUEJo422yILBKiA==
X-Google-Smtp-Source: APXvYqx1R7S8pIV0K8TV9qoZ4dBSE0XGBn6qp4kgOM11WVqKY4FU4nvS/xhY19oqkjyQfl1iY2QsUg==
X-Received: by 2002:a63:a43:: with SMTP id z3mr22981828pgk.232.1578949674958;
        Mon, 13 Jan 2020 13:07:54 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s1sm14195827pgv.87.2020.01.13.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:07:54 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 3/6] mmc: sdhci-brcmstb: Fix driver to defer on clk_get defer
Date:   Mon, 13 Jan 2020 16:07:03 -0500
Message-Id: <20200113210706.11972-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
References: <20200113210706.11972-1-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The new SCMI clock protocol driver does not get probed that early in
boot. Brcmstb drivers typically have the following code when getting
a clock:

        priv->clk = devm_clk_get(&pdev->dev, NULL);
        if (IS_ERR(priv->clk)) {
                dev_err(&pdev->dev, "Clock not found in Device Tree\n");
                priv->clk = NULL;
        }

This commit changes the driver to do what is below.

        priv->clk = devm_clk_get(&pdev->dev, NULL);
        if (IS_ERR(priv->clk)) {
                if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
                        return -EPROBE_DEFER;
                dev_err(&pdev->dev, "Clock not found in Device Tree\n");
                priv->clk = NULL;
        }

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index daa89ca232a2..218176b79b6a 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -91,6 +91,8 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
+		if (PTR_ERR(clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_err(&pdev->dev, "Clock not found in Device Tree\n");
 		clk = NULL;
 	}
-- 
2.17.1

