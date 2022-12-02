Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49511C47088
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 15:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiLBP1E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiLBP0z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 10:26:55 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662EBCFE67;
        Fri,  2 Dec 2022 07:26:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b2so12327317eja.7;
        Fri, 02 Dec 2022 07:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSPEHSYmi4vlcGVbczR4I6cGH/dyxfXxCF0BQRo95CI=;
        b=EkqSCjXLPAcY5hECGJeH97TDy4+9gHKZQdYLOUPDw792oRA2oUe8skoF1OoVvwTqvk
         Jc4doB9qCP+hOtw3qp3c+2DdNsrWUO/TZGcRI90WeCPvevH4f4nkPXIP124S5Ph3N/Xv
         eOxOI1V4i4Ep3XlZS856CYligI6aIdhnKQjqhB0qozS5hfQW9Y24/vqcik7W4d0LX4pw
         5mRuHPN2T6ohkHaUBNyEC3kPmRXXQu+mRESzPTAGdDQfgjc2SJRs1VrwJAH4PkXQgp78
         UAgHjPE0aSLW47AN9m2eivkcHvzYWPxkuctEiEuMj6qN44bGUNEb1L6PZ7G/lVtlFNIH
         sV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSPEHSYmi4vlcGVbczR4I6cGH/dyxfXxCF0BQRo95CI=;
        b=dGqDCLoumGRZL5B+uQyL2zlTperdkvPjAskZIMhKCW6NJtYwRogg5P+93aj5LeHuYL
         SlMVn0GlfLCN5buD8rAqi5hfjJ7mZPwV4DcWkU0OKMb8dWeKdg94174JLh0ESufVLSTP
         MMb38hHPq2xLhpEoQFcv9TmWIxVWtvQKLrgpGSSf3ru66Cg6uLo0AnrXlnqyRE6bwqC9
         anI+ySHz5Z5N6v8U4Yowjc43Ix16z0oD43wVuJ7nq+7SYFbV4LFQqhfZFczDDly72zWQ
         EysTWt9q3FV73hh9fDEGb51sti18NHDyyTKGQF7rA3zhePQHhQR4ughDsobjFOra9xW0
         gwGQ==
X-Gm-Message-State: ANoB5pmKbaAChJGo5u5isacC01m2M+eiTan1Wzuop5CKX2k1Pt7VJMIm
        0MOLygEcwizlEn/ftdE7gq4=
X-Google-Smtp-Source: AA0mqf4YzA6rYqJ9/n2IsfEwxQK762QnL559L95HzIwJrjNNnR9Ygm8zuD1MyIeKgDXovGdzFzvCww==
X-Received: by 2002:a17:906:39c8:b0:7ad:79c0:5482 with SMTP id i8-20020a17090639c800b007ad79c05482mr50981225eje.730.1669994812806;
        Fri, 02 Dec 2022 07:26:52 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ky1-20020a170907778100b0072a881b21d8sm3103086ejc.119.2022.12.02.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:26:52 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v12 3/6] mmc: sdhci-tegra: Sort includes alphabetically
Date:   Fri,  2 Dec 2022 16:26:41 +0100
Message-Id: <20221202152644.29450-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202152644.29450-1-thierry.reding@gmail.com>
References: <20221202152644.29450-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Sort includes alphabetically to make it easier to add new ones
subsequently.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 9fc8a61eca54..afa9cbf9cb6f 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -3,28 +3,28 @@
  * Copyright (C) 2010 Google, Inc.
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
-#include <linux/iopoll.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/of.h>
+#include <linux/iopoll.h>
+#include <linux/ktime.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
-#include <linux/mmc/card.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/mmc.h>
-#include <linux/mmc/slot-gpio.h>
-#include <linux/gpio/consumer.h>
-#include <linux/ktime.h>
 
 #include <soc/tegra/common.h>
 
-- 
2.38.1

