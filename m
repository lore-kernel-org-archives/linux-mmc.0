Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F00C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15FD611CD
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhDOIoj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:44:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38405 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhDOIoj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 04:44:39 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWxbj-0000IF-ER
        for linux-mmc@vger.kernel.org; Thu, 15 Apr 2021 08:44:15 +0000
Received: by mail-ej1-f70.google.com with SMTP id p26-20020a170906a01ab0290373d37378f3so675256ejy.3
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 01:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afLlSFHqkyfNq8XB8hE8fEk1Bn9ss6leqQ5Uo7hmj+I=;
        b=THpqe6M/Di/wOJ15jXx+QKUq7Y3adBB/fWqYnhVExk2164UT+Gn52hXM7qAYIVw9Et
         UMeA8nkefSCQcjnJPQFmkwnAPj8mYYtD+DHU35khGdSxe0VqTug4KTWiJwjkPWzmgXRy
         X4eBwxZbGpkZv0AuUdyl6EAXN8GjWAarAgx9945Yl+kL+L2qMk2GfkK6a5pTZt1S7rfI
         b6z6jzZTJWFE9YM7xppEF09+5KqdBcJpy00QPaQUpyyifLqe8GlbDv1ZXNQ80/fSGGI/
         pITdCo6pU7+1m4vuS7Kd9Xru/1fnR9gahS+WOzNwUKZl4UBGQjs5KKywqgRbTNEtZpGC
         g/DQ==
X-Gm-Message-State: AOAM532pMWhLDG6Od60CwENfL1TtVnd4OJb2IRYcSGdD12Ho7CXAo8xS
        kHdWvZ+SQ2ubLZhRogvP/sybvR/BeIYx143L1/1Mb0itORTWGNUUlhXboVxzUZwWC3HT//L/NvS
        u0Dj+ofwZX4jyyLNrPzlqt4wp9V+aSpYaDYGEwg==
X-Received: by 2002:aa7:c3c3:: with SMTP id l3mr2804631edr.103.1618476255199;
        Thu, 15 Apr 2021 01:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGubMcxKW1PgZ0pez1xZE9dMYv7WAOyLtVFD1VPxJHQJ5kuB+Lmt0mE0mM3CucaQxZfp6qtw==
X-Received: by 2002:aa7:c3c3:: with SMTP id l3mr2804626edr.103.1618476255116;
        Thu, 15 Apr 2021 01:44:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id k26sm1419360ejk.29.2021.04.15.01.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:44:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 1/3] mmc: sdhci-s3c: simplify getting of_device_id match data
Date:   Thu, 15 Apr 2021 10:44:10 +0200
Message-Id: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller and to
remove the of_device_id table forward declaration.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Rewrite the commit msg as it is not a NULL pointer dereference.
---
 drivers/mmc/host/sdhci-s3c.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index f48a788a9d3d..8e1dca625620 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -20,6 +20,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -461,19 +462,12 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 }
 #endif
 
-#ifdef CONFIG_OF
-static const struct of_device_id sdhci_s3c_dt_match[];
-#endif
-
 static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
-		return (struct sdhci_s3c_drv_data *)match->data;
-	}
+	if (pdev->dev.of_node)
+		return (struct sdhci_s3c_drv_data *)of_device_get_match_data(&pdev->dev);
 #endif
 	return (struct sdhci_s3c_drv_data *)
 			platform_get_device_id(pdev)->driver_data;
-- 
2.25.1

