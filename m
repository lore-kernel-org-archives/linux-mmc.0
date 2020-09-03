Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F19C2D0A7
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 23:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC122078E
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 23:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gDDpJ+qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgICXZh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgICXZI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 19:25:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48FC06124F
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 16:25:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so3324088pgm.11
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAUtvcHaucBqw/xKruQ8sUGNoGTZknTunbUiV4pTWE4=;
        b=gDDpJ+qosozaMJj1Btae6p2MZQMhhZnGxFLO3kw8aeDYZAhuNuDrZAt6QpEJdyl1Bh
         e9bDDjK9n9qUsEaDggXkEziJ4G6PWex0Z1sTvchqG+Ks8r9MQq8uaYR6wipPM7daCa0x
         yOqVA8gm9K1D/hzBdyWum0YnxXlUF0vcVdxhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAUtvcHaucBqw/xKruQ8sUGNoGTZknTunbUiV4pTWE4=;
        b=TyM9BO2aeqEStuAoxX85ab6fk178yzHA/ingL2tM4vbuwU1sYiiC4JulpNmtF2hnJw
         M7XYgfbbouUhpHfyMTx93i/ZvBtXblF7riSW7HwU1VTQ5PE1yBDmlvfUMHxQBu0tNQvy
         4dziOcSUXH3LatKeVEWwzg7B09t68sD6Rx7HiY1TrFB6VtrOrBeJhWRCMM/61frC/3Iy
         XC7t38uP7c30iw4IqUH4IjRIezPVt/7ezKT/Jjst93TZ5ccDvKmM+yA+vQdOUbRWhwak
         rQiIxpPsddwkbzVXH5IwLiWBZUhBN8IjgZ6AylP1xi5i3TfrQaudy6E7Sf6MekSvySBo
         WqLA==
X-Gm-Message-State: AOAM533q1ewbm0UzQ43Dt9VT6JRiWG4L1AzvyThquldomZt5Zla2Wdqw
        UZYIyuMzK1oD2XXN2+H8Id1+VQ==
X-Google-Smtp-Source: ABdhPJzn/88aILgq2HYbhieGtLauiT7tbZJ6vkVgfNIx/4y3oZ7eUz4kgYyWk0ioH1XoMhXU/q43PA==
X-Received: by 2002:a62:52d6:: with SMTP id g205mr6104288pfb.144.1599175508292;
        Thu, 03 Sep 2020 16:25:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q7sm3614459pgg.10.2020.09.03.16.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:25:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 4/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.19
Date:   Thu,  3 Sep 2020 16:24:39 -0700
Message-Id: <20200903162412.4.I84eb3e0a738635d524c90d1a688087bc295f7c32@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200903232441.2694866-1-dianders@chromium.org>
References: <20200903232441.2694866-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
probe") but applied to a whole pile of drivers.  This batch converts
the drivers that appeared to be around in the v4.19 timeframe.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/dw_mmc-bluefield.c   | 1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 1 +
 drivers/mmc/host/meson-mx-sdio.c      | 1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c   | 1 +
 drivers/mmc/host/sdhci-omap.c         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index aa38b1a8017e..10baf122bc15 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -55,6 +55,7 @@ static struct platform_driver dw_mci_bluefield_pltfm_driver = {
 	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_bluefield",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_bluefield_match,
 		.pm		= &dw_mci_pltfm_pmops,
 	},
diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 83e1bad0a008..39794f93826f 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -200,6 +200,7 @@ static struct platform_driver dw_mci_hi3798cv200_driver = {
 	.remove = dw_mci_hi3798cv200_remove,
 	.driver = {
 		.name = "dwmmc_hi3798cv200",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = dw_mci_hi3798cv200_match,
 	},
 };
diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 9b2cf7afc246..a6ff8b4ad1a5 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -755,6 +755,7 @@ static struct platform_driver meson_mx_mmc_driver = {
 	.remove  = meson_mx_mmc_remove,
 	.driver  = {
 		.name = "meson-mx-sdio",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(meson_mx_mmc_of_match),
 	},
 };
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 64ac0dbee95c..4b673792b5a4 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -214,6 +214,7 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
 static struct platform_driver sdhci_dwcmshc_driver = {
 	.driver	= {
 		.name	= "sdhci-dwcmshc",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_dwcmshc_dt_ids,
 		.pm = &dwcmshc_pmops,
 	},
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 1ec74c2d5c17..7893fd3599b6 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1297,6 +1297,7 @@ static struct platform_driver sdhci_omap_driver = {
 	.remove = sdhci_omap_remove,
 	.driver = {
 		   .name = "sdhci-omap",
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		   .pm = &sdhci_omap_dev_pm_ops,
 		   .of_match_table = omap_sdhci_match,
 		  },
-- 
2.28.0.526.ge36021eeef-goog

