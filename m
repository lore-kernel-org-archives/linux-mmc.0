Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5536C433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Mar 2022 16:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiCCQwh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiCCQwg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2022 11:52:36 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114119DE8F
        for <linux-mmc@vger.kernel.org>; Thu,  3 Mar 2022 08:51:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u20so9592249lff.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2022 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0hlDMq4glELTxqqeCYQhCGVz6ASynOhyADKIGNkHxI=;
        b=lM+FtnlKckXCQpElr2JR138CKdeX+U2eun4ELTIZ4sBj13l1AyGsYj/7EbHk76vCy3
         9uZ3XCUX/iKFykOm6EMZNk3bW6ElUA0DOK3o/9ae8J7YDlZv94eOunX4aC1a65y/dMHX
         Jv9rjacTnnoq0vF/+I+UVl281Fmbve3tsoMWsnftCNg3k5Wa+6vWwvQSgx/X3P0MZHsM
         OGW3BGtkPwrceeR/E1z//0w8RGdkjhN6JHG7dQyuFYJNmtfXT1pWbM0vkXqiLwwfZFSc
         V1gr0L20OnEyZQBD/TyZjt51y8g+EWlP5Y3tXHnXxoQLqUfVn8IU9KTRejwkulSLiGVI
         TqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0hlDMq4glELTxqqeCYQhCGVz6ASynOhyADKIGNkHxI=;
        b=d8rajtyqttyK8Bb41Mx+0GNts7I+OeG6O3iQMiCwsCG6iu98ll1AM6xcC+BW35UwGZ
         3+VLoelk7NBfAByWwiN826XW6SjGcakCim5Y6zaMMXYy0c0P1COz+tCE3rN2P/XPNm1o
         7sNes7ZxJvHgD4GnC6YfDTjiv9WmEke5TGlhKNyhAcWRl2vKTwk0DzQjUBuMY/wYMnku
         yI+HVn1qCGgLojKzxmctjYziCyj1YQeL/vOdAT2HpxRxmcFuXazo7AlG8eJzxbeV04B/
         hb2c9c9MhcNbQkDvsT5w9nn7qsDBCxD7rS6FsE17cMMTmGbUgF1qimyQQTkIoEMS8hTH
         k5ww==
X-Gm-Message-State: AOAM530CSJINwuRiqgYXGByd4eNP0prSpnzBMzKHV6PaUM8/sVDbmSsw
        T/DViM/Lgsz3JHoNVzgoXjMduKy1yI2DVg==
X-Google-Smtp-Source: ABdhPJz9ZBx87iKT0e1+HeehvcT+hS0gckoWv62UmqP+hGy6tSdepldUbJCmRSoXrlZbeJ6croDQmg==
X-Received: by 2002:a05:6512:33c6:b0:446:e0ce:5c3c with SMTP id d6-20020a05651233c600b00446e0ce5c3cmr1163571lfg.26.1646326306369;
        Thu, 03 Mar 2022 08:51:46 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id g27-20020ac2539b000000b0044392f8d4c6sm521749lfh.1.2022.03.03.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:51:45 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: host: Return an error when ->enable_sdio_irq() ops is missing
Date:   Thu,  3 Mar 2022 17:51:42 +0100
Message-Id: <20220303165142.129745-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Even if the current WARN() notifies the user that something is severely
wrong, we can still end up in a PANIC() when trying to invoke the missing
->enable_sdio_irq() ops. Therefore, let's also return an error code and
prevent the host from being added.

While at it, move the code into a separate function to prepare for
subsequent changes and for further host caps validations.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index cf140f4ec864..d739e2b631fe 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -588,6 +588,16 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static int mmc_validate_host_caps(struct mmc_host *host)
+{
+	if (host->caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
+		dev_warn(host->parent, "missing ->enable_sdio_irq() ops\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  *	mmc_add_host - initialise host hardware
  *	@host: mmc host
@@ -600,8 +610,9 @@ int mmc_add_host(struct mmc_host *host)
 {
 	int err;
 
-	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
-		!host->ops->enable_sdio_irq);
+	err = mmc_validate_host_caps(host);
+	if (err)
+		return err;
 
 	err = device_add(&host->class_dev);
 	if (err)
-- 
2.25.1

