Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA57C433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 15:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC8B20809
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 15:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anuFNeTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgESPYy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgESPYy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 11:24:54 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC3C08C5C0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 08:24:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x27so11462708lfg.9
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qf2J9d+pE8ux/Cchs98T6eJsiSqSCnHXewGGw1uY44=;
        b=anuFNeTMyDzavdWjY1GTSFbMlaC70QKkcyw+KE8hdosYo4TzXSd/qDzaxalIZs34ko
         gF5Z5+Y6FJoKFo4ZIO6ShLyLRSL4vxB8DXxx0zfXpNsWusgeOJtzqhVtt3wBbMx8nvYk
         bxkndfYu5+niXSmiIcGbJfBjoLkK6uWQ0LDMv/y19Rwd6GPBfEqtxEU6/GLhHfJhUYk+
         +aYp3NjAW0NC7GPqd1P30rtCDnd3eE2VXJ+pqhqobgzOckFC9nnz8JYmFH+6HV2R3y7h
         2OaBonCJeyDr6Rf5MXtgmT2PT5HB3lc44F/suOIQpgAkj05na+lUDXyiQ7wT0N6rSwmx
         mYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qf2J9d+pE8ux/Cchs98T6eJsiSqSCnHXewGGw1uY44=;
        b=DZjYNSTQf8GZQ+m5YFf0jITKm6QqFKGHK8v19ODG9I8W3z0jYL8vfgAda9VX54/2tQ
         XbJq6YwsfCyVmgo/IurItWim/kJPuuFYU7pEr3fskTsbwrCyWODSt5THVPzyqkP+1Ps1
         Lk29uEkFazVXU4/3qwXWnhhbNBU/wkeuL2Gh/pDGIUqc1pOz17N5JkDIgx/dTer6gNRS
         7Vl/1Fi+Al5rj0EyoN1jPWxhc/Cgsly0Kh6YMNp0MspmwQ/fpiFQy/pVr2avDvn3RdDV
         qPwOVii89nkLP6R4duKQtgbMebmDVI7nSXwSbwBfiIwYOKbmobZGreYkf52xexo/fqBM
         D89g==
X-Gm-Message-State: AOAM533G/RTiNTFXlfAWxLiGXv2vQzRDrNae0SxgBdiCVhdqshN3ss9l
        SFA0ai+LE4r1SIqLyIHJMk3d7sqcgCrcRw==
X-Google-Smtp-Source: ABdhPJyQHZ9eIWlRwy8ZDnTFWK0XQ5gVbcM8LmjoSBxo7r9UZLxgiEJ1+RUdvk6EqoIpKxg+sVkcdQ==
X-Received: by 2002:ac2:5473:: with SMTP id e19mr11269026lfn.21.1589901891160;
        Tue, 19 May 2020 08:24:51 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id i8sm6234395lfl.72.2020.05.19.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 08:24:48 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
Date:   Tue, 19 May 2020 17:24:45 +0200
Message-Id: <20200519152445.6922-1-ulf.hansson@linaro.org>
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
which is currently managed by tmio_mmc_host_probe(). However, it's likely
that may be too late for some cases, as registers may be read and written
way before that point.

To fix the behaviour, let's move the call to dev_pm_domain_start() from
tmio_mmc_host_probe() into those clients that needs it. From discussions at
linux-mmc mailing list, it turned out that it should be sufficient to do
this for the SDHI renesas variants, hence the call is move to
renesas_sdhi_probe().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/renesas_sdhi_core.c | 3 +++
 drivers/mmc/host/tmio_mmc_core.c     | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ff72b381a6b3..dcba9ad35dd1 100644
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
@@ -905,6 +906,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
+	dev_pm_domain_start(&pdev->dev);
+
 	ret = renesas_sdhi_clk_enable(host);
 	if (ret)
 		goto efree;
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
-- 
2.20.1

