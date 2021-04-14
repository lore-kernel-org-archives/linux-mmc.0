Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4CC433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0873E613B1
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 15:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350123AbhDNPNS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:13:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41103 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350108AbhDNPNQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 11:13:16 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWhCH-0002J7-3p
        for linux-mmc@vger.kernel.org; Wed, 14 Apr 2021 15:12:53 +0000
Received: by mail-ej1-f70.google.com with SMTP id g1so449454ejt.10
        for <linux-mmc@vger.kernel.org>; Wed, 14 Apr 2021 08:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDuMOWplwoS/Ozw/sH4P7rpo1GEqNZMR1YEeGhTk/BM=;
        b=rT/nFHmq0FNiF7b5wcEqtZBZ6Ak6CvHNkaUaJYKcW6Lvh9WwNKkU41eSK8oxGzNwlM
         qauAhEPfgouL10G2bdyOOMDGRq6tIBH7lNhochW6LOv2If9t/+UvBHbeqPHzDT1yxZOo
         zbe9FOzHJKXbcr6KXxMC87yHtmnVbV/bBT8s6NnwyzJAZEdi80gz9bSxesOsgRuqcxba
         4RoR3UIYaoySjDZxp9cPSiI8JJ9DkIQlGSmTCn9VR5SaIO6MtfX8ntrL7Z6xN217GFjM
         ztbHRAbu/loKhS9uFfEY8Tv0vJZKMeMzbRt1njkj145NfVQPuaZPQO59b2UlJkhwkAG6
         1eIg==
X-Gm-Message-State: AOAM531VgAMb3tzSV+0bX7ACnx0WoupM6b30U1tuhH/g5gN+EGiPMXt4
        rCU1vtnbXtDsQDYctBJMybIodQR3ghVIWC0jim1RrTFxYTlLDs7RU6v6DY9h/Hc4uJLucyPyArB
        ndV6rS6Ljp3nMiraPPr64dTmtdLsCHwdsXc4hXg==
X-Received: by 2002:a17:906:b0f:: with SMTP id u15mr22151183ejg.156.1618413172819;
        Wed, 14 Apr 2021 08:12:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcwRUCAvHwOFEwoZEaELq0FzNrvJVSd2kUe34n6hhiPAf4c412FBslXbQ9BgEDdv2es3V8xQ==
X-Received: by 2002:a17:906:b0f:: with SMTP id u15mr22151171ejg.156.1618413172696;
        Wed, 14 Apr 2021 08:12:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id o9sm6608022ejg.56.2021.04.14.08.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:12:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 3/3] mmc: sdhci-s3c: constify uses of driver/match data
Date:   Wed, 14 Apr 2021 17:12:42 +0200
Message-Id: <20210414151242.102313-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver data (struct sdhci_s3c_drv_data) stored in of_device_id
table is allocated as const and used only in const-way.  Skip
unnecessary const-away casts and convert all users to work with pointer
to const.  This is both more logical and safer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/sdhci-s3c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a07a8f011741..862f033d235d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -462,21 +462,21 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 }
 #endif
 
-static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
+static inline const struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
 	if (pdev->dev.of_node)
-		return (struct sdhci_s3c_drv_data *)of_device_get_match_data(&pdev->dev);
+		return of_device_get_match_data(&pdev->dev);
 #endif
-	return (struct sdhci_s3c_drv_data *)
+	return (const struct sdhci_s3c_drv_data *)
 			platform_get_device_id(pdev)->driver_data;
 }
 
 static int sdhci_s3c_probe(struct platform_device *pdev)
 {
 	struct s3c_sdhci_platdata *pdata;
-	struct sdhci_s3c_drv_data *drv_data;
+	const struct sdhci_s3c_drv_data *drv_data;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host;
 	struct sdhci_s3c *sc;
@@ -761,7 +761,7 @@ static const struct platform_device_id sdhci_s3c_driver_ids[] = {
 MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
 
 #ifdef CONFIG_OF
-static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
+static const struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
 	.no_divider = true,
 };
 
-- 
2.25.1

