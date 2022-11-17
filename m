Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C402CC43219
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiKQS1f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiKQS1b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 13:27:31 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26778515B;
        Thu, 17 Nov 2022 10:27:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id f18so7239172ejz.5;
        Thu, 17 Nov 2022 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+rSTxy95i5fB+h/5j4BybighhCVy5Cpr+8wxCuIfS8=;
        b=Rd2e9hZZ8eSFHv28+CbR29FviKgUzwBJW5uK56F6HMfv3BN7XA072eLK9qfcjOfYhW
         O4yJ8Sdo/JyJuOQG5q32mM8rfcybytHvqY3mGOwDE7hQeNQjGJvgDOgGmbzeqInYIaG7
         mkNLnF/HylmvUR8qPla5M9EzsskJIcqt8kPtAJdCK8iWItk51at3EM0cLtheC8OdWzC3
         aClvK1pAE9Ex/3bgYVWwV5SGdBfd6E1EgJ9Z4Bxhue7D0y3mRi0R33I9TnycOUFX0Aju
         NiJf7b1I7yfytarNclDMZp4rDmgkfjZKzBUmtUtx6tfkON+DndxoZuFFAe5Z4ssw3QS6
         PVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+rSTxy95i5fB+h/5j4BybighhCVy5Cpr+8wxCuIfS8=;
        b=59fefnHDvYyS8pbG1O1tknQhgaeJo1qY192qshXcIRtU0/Db81bbQaeuFSW6GVSKdV
         0zxASQctbbVQP2Tj+O/dKVk5k2VKs9JAlz6kw7JEKsMpp/PtKgi/sJlswlnjYDRSeuMo
         OH8GFHgP1ZyfCB2YSyVwtKu1gSNqg+VOe8lnxKzcsOcUoEiH1TMZnQ0YOeRsIHcZ/zbe
         RsEd1p1UI3WVHA+qw21s6H/CTpAx/cjSO9DazTdfZve1GPsqm7ezgxphys9RnezN2s0p
         Ty4ZttkAIYCZcP2G7b2hJvU+fOBNdv7QTbeZxPdmA8MDe+9qj820U14ekuqvkbhSI/tM
         VimA==
X-Gm-Message-State: ANoB5pkQWK3KUEVIgLoGIPnsfAsU4SHBwAbkpLzTf7sq/65maMmxOLta
        w2UyGlPrPip1taSrr/8/2wg=
X-Google-Smtp-Source: AA0mqf6Fe/ayrdsGJkjFUrQyiSGXzBegvQwqUA8lN02/4/ld05iVODo6XHssr2OYDJS1qk2JiYT/1Q==
X-Received: by 2002:a17:906:3155:b0:7ad:90db:c241 with SMTP id e21-20020a170906315500b007ad90dbc241mr3176853eje.284.1668709647195;
        Thu, 17 Nov 2022 10:27:27 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e25-20020a056402105900b004610899742asm847347edu.13.2022.11.17.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:27:26 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v11 3/6] mmc: sdhci-tegra: Sort includes alphabetically
Date:   Thu, 17 Nov 2022 19:27:17 +0100
Message-Id: <20221117182720.2290761-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117182720.2290761-1-thierry.reding@gmail.com>
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Sort includes alphabetically to make it easier to add new ones
subsequently.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index c71000a07656..e2a8488d4fa9 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -3,28 +3,29 @@
  * Copyright (C) 2010 Google, Inc.
  */
 
+#include <linux/bitfield.h>
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

