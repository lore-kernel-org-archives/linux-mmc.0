Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE25C43461
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC980611F1
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhDOIom (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:44:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38425 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbhDOIol (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 04:44:41 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWxbl-0000Jo-LI
        for linux-mmc@vger.kernel.org; Thu, 15 Apr 2021 08:44:17 +0000
Received: by mail-ed1-f69.google.com with SMTP id m2-20020aa7c4820000b0290382b0bad9e7so4790574edq.9
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 01:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3RZMclgxc1FxJU/OrPHbJLizxo8O9HUjZmngSIwkM0=;
        b=MjOer3vpkEjegZAH4EqwDl7vB5GH0NlDEIU0dvVBXmoi9iHRqzx1F36ZALoWlE5+Eo
         3C7F4HKw7TyUc1R8DFlm+ptiTyFDvQ9wvdZIkz10qjUyTvxswZ+mxLaPwpKxVqoNxZOU
         SDtY0a1SqniHKV75BliQ3krW7ZvPZzOIlUUxlE5FBIX0PgJ+8uPNOQISxP0Mrd930Sq9
         ZyfLeXuNZKFk4+43891K1hieNoSnYZ6IpVDgXTnK/EZ92RK9NCe5R3OA4gdJmYa9v6AX
         5AKV+xbJ1Xn95pGycBGWIoS5poBRc00Ee7gFgHsBY0Zw3ijUrmT+LO6iNsd63c9+FAsA
         +5RQ==
X-Gm-Message-State: AOAM531l+SwT6qP60Gc7Upq1vHp/M1ptVkyoq4mf75N4NfWiBlAIrFZH
        FcNS5gMaoDYkb0+mCviREmKNY0mxRPTax2eP5dP/XiF/wyAIx2zLCZMD9XBY1aC9unVo0AzcYFD
        RHgwyHPIuQ45oa3cnMwprommqb76Tn87AZtB9vA==
X-Received: by 2002:a17:906:d04d:: with SMTP id bo13mr2252569ejb.157.1618476257343;
        Thu, 15 Apr 2021 01:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL1iqD0K8UraIVtQPabESHzQRRgghEweHqa35iG9WZz8DZdnZL+3UB1rriHafe5y+OdtromA==
X-Received: by 2002:a17:906:d04d:: with SMTP id bo13mr2252555ejb.157.1618476257184;
        Thu, 15 Apr 2021 01:44:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id k26sm1419360ejk.29.2021.04.15.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:44:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 3/3] mmc: sdhci-s3c: constify uses of driver/match data
Date:   Thu, 15 Apr 2021 10:44:12 +0200
Message-Id: <20210415084412.51125-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
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

Changes since v1:
1. None
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

