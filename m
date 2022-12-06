Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7689EC63707
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 16:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiLFQ7z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiLFQ7y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 11:59:54 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0835028E0F;
        Tue,  6 Dec 2022 08:59:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z92so21225370ede.1;
        Tue, 06 Dec 2022 08:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSPEHSYmi4vlcGVbczR4I6cGH/dyxfXxCF0BQRo95CI=;
        b=eD1P+puHbw7hKL5IQgc+mzYG6cSuxGIQS/AaGX56IX7gtQYrctEtR/GW66nlDYkxIn
         3O7JKdJpYC6Cww+cG5FXTyqPr4WsNMhOb92VA4mbgr3KwwodrphpKw6oLlpdHR4B5tHu
         R1yO7PR4DbYCrCl9MkDa7ZzpX2qkm5YELriDt1Tc8Nv3Blka90DuFLdRZtAns5tQuHT4
         uoPq7T+y6yrhLwybox2FbW92KSNBzBy8qLifDyK0e6YHk9iCPVZGNy9XQSfUWR93Inw4
         E/qY4fJROOr8A1d1BFNJOJ//7U8kxc7FzewFAMGwGpzOK8nEifPJ/snMtp/nNuqkErc+
         l57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSPEHSYmi4vlcGVbczR4I6cGH/dyxfXxCF0BQRo95CI=;
        b=xENjP6gEIxHUN2AUbDM+7/6123iKnhnMbcfEM27KfMJkx1GSy8EfiCiAubcBPerD8N
         s01mIEW57JRPNueU6tWxnibytE6I7vKC0anSReWw7Xy1fSGC/aiGe9VTnQ1ltgzcYjBp
         4bwXFdPLPFoxAEGQlVPypOHb0E6OtkxaViXNccWsHKzeRrcZfUwr6RI4zdY1br1dP2YB
         o1f1+Md9maWg/AnaHM7L4+X19M/2ffP8K80QFQLH4GbHawDiQufAbcaK8z09jSmW2UOY
         xMl2LiR30T8LcMFjG5qoF1OBRfne31VLbFZJCX55bLUK01ZatXKzZ8ygXIIYOLX55n89
         gk4g==
X-Gm-Message-State: ANoB5pmr+UdxTnOG+0Xqy3l1lRi2uOjWxbSU+j2jzV3IgyiM7gEdD643
        xuvcOWmCuODvaRAmxdqQm/c=
X-Google-Smtp-Source: AA0mqf6uvAmII/HzPxDOxEezJflXnVZyPaTXTzlFj/NQ1BAv82SWRi42QT4q+LHrfwih6OfFxAOZDQ==
X-Received: by 2002:aa7:d417:0:b0:46b:203:f389 with SMTP id z23-20020aa7d417000000b0046b0203f389mr39313635edq.303.1670345991603;
        Tue, 06 Dec 2022 08:59:51 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640210c400b0046c4553010fsm1205110edu.1.2022.12.06.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:59:51 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v13 3/6] mmc: sdhci-tegra: Sort includes alphabetically
Date:   Tue,  6 Dec 2022 17:59:42 +0100
Message-Id: <20221206165945.3551774-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206165945.3551774-1-thierry.reding@gmail.com>
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
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

