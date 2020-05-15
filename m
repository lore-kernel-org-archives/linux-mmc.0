Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC46C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85B220759
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 14:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUbSTSGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgEOOFG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEOOFF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 10:05:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92891C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 07:05:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id e125so1154871lfd.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GzyY6WF9cs2u61XpsJ0RBx3TP+MAWkbmz9R2Rpnmb4=;
        b=IUbSTSGbU5dgDcc68w5rzBkq2MbwX4kc+b4wKOLvVfOmlusCGZupExcjkmQjTs08VH
         sRAYify3Q1e1HPrYGgwTb+rhpwrOxNthoebR9id41DXMuOR6luKAeVeXTxzozlCtklJ2
         TFH1Mxt4Roe+x43VJ1NjeSfrFkd99A3KEG6RrhVRWSQ/OO+xavR8eos5c5B/uzsFc5nJ
         ZAvbEN0EMS/vFRC5U78OE7//vC13/aYQhluBl7dhmxTeoYR4FJoTmsPgaPQdkra/FK6p
         IR+VLGBOm87vBLzTbSBagYN2QxkU2Xay/oofi73dlX1BcOsm0KcU7S+W2zzEfyLOps90
         lg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GzyY6WF9cs2u61XpsJ0RBx3TP+MAWkbmz9R2Rpnmb4=;
        b=VoWLpcH2zcaMhQGc32rZvLErqiQJwjW4KMSdma2/USY9D8FHtzyGtpAwbeW8nxyRiF
         ZofjzPHbn/U8YOSOWPTPIeT76NVEnLp9BKjr41oC6SJ6QN0Msu7UnsRYPh6sfwP1MEWJ
         7TA7/Yaqa6EjenMa4Je6BofpG/6ZDLeUIcbWnQJLCAnKMrML/SX0SKb76je/uhNNKxkB
         HgB1xGWfZ1BVjD5UTc/1/AKRl1gPJU/Tvgswr+PMGeNiiz6i0G/je89UTx0oVSFjTDrp
         ffPGIOY7mSwwuxQ12LGEQ3pOEjyE/LFNlXd7WRugMwVGMrpZwSTXdv/ma/zP7i5M1WB4
         AkfA==
X-Gm-Message-State: AOAM532c+bfxE9qwUiW8FMME7/NXtvK07UOz+p4x08ExusQdXrEDN7/B
        A6K561EJbjYaY8PuAb3YM3K8MXDQ4to=
X-Google-Smtp-Source: ABdhPJxYajFmUZMHGZ0pkAdK7BrEi0qf+HcyWTIQjBXReYt07Yt9Nq0E0mP1Z1Rj+z0rel7UpT7u0g==
X-Received: by 2002:a19:b8d:: with SMTP id 135mr2517398lfl.145.1589551503534;
        Fri, 15 May 2020 07:05:03 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id s27sm1220215ljo.80.2020.05.15.07.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:05:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
Date:   Fri, 15 May 2020 16:04:59 +0200
Message-Id: <20200515140459.15273-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If the tmio device is attached to a genpd (PM domain), that genpd may have
->start|stop() callback assigned to it. To make sure the device is
accessible during ->probe(), genpd's ->start() callback must be invoked,
which is currently managed by tmio_mmc_host_probe(). This is very likely to
be too late for some cases, as registers may be read and written way before
that.

To fix this behaviour, let's drop the call to dev_pm_domain_start() from
tmio_mmc_host_probe() - and let the tmio clients manage this instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/renesas_sdhi_core.c | 3 +++
 drivers/mmc/host/tmio_mmc.c          | 3 +++
 drivers/mmc/host/tmio_mmc_core.c     | 2 --
 drivers/mmc/host/uniphier-sd.c       | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ff72b381a6b3..5d44240d57ec 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mfd/tmio.h>
@@ -909,6 +910,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (ret)
 		goto efree;
 
+	dev_pm_domain_start(&pdev->dev);
+
 	ver = sd_ctrl_read16(host, CTL_VERSION);
 	/* GEN2_SDR104 is first known SDHI to use 32bit block count */
 	if (ver < SDHI_VER_GEN2_SDR104 && mmc_data->max_blk_count > U16_MAX)
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 93e83ad25976..b8f5687e10be 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -17,6 +17,7 @@
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
+#include <linux/pm_domain.h>
 #include <linux/scatterlist.h>
 
 #include "tmio_mmc.h"
@@ -172,6 +173,8 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	host->mmc->f_max = pdata->hclk;
 	host->mmc->f_min = pdata->hclk / 512;
 
+	dev_pm_domain_start(&pdev->dev);
+
 	ret = tmio_mmc_host_probe(host);
 	if (ret)
 		goto host_free;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index ba301fb7656b..d7fde57c78c1 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -39,7 +39,6 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
-#include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -1192,7 +1191,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
-	dev_pm_domain_start(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index f82baf99fd69..0c41dc1cc96c 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/reset.h>
 
 #include "tmio_mmc.h"
@@ -624,6 +625,8 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
+	dev_pm_domain_start(dev);
+
 	uniphier_sd_host_init(host);
 
 	tmio_data->ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34;
-- 
2.20.1

