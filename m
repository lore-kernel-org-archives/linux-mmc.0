Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7DC433C1
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Mar 2021 05:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8E461997
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Mar 2021 05:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCTE57 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Mar 2021 00:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTE5k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Mar 2021 00:57:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD51C061761;
        Fri, 19 Mar 2021 21:57:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h3so7277289pfr.12;
        Fri, 19 Mar 2021 21:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKaorJcxqHmWLsdkc7AjkYdzrCa5R9G29rvcEX/TjMY=;
        b=eG0CbR4t8qEXoLgI3sqKQcYJOPFabLrwpHioqOGoYpUOwdRR2LPyRi/+YUTtqywDbF
         6Bi/8RMKQydNG4M7lTmyfayAKkSHYdZe5WiI4nVBxKMgX6V/bbSJVFoZhL1dfz7wAtEq
         /lFsYm6ShUGU5IwXDuzUQDGBxnK+TJe7OrVcCXWgjbvGdy1p4nSNrEDCv5UbtpWbVzN/
         l3tLGqg4+6DFSeECGD9V9kK/nw4PbwwsHcbWwSG9CW6yb/NNjGzsGhMgXAAfPNC9XMDY
         n783kkZDZQv+kd8ZA+/QZpPGuB735vsA+ncT92k9pRgPQwQ9ZIN89DG0p41GrsjuucUx
         jlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKaorJcxqHmWLsdkc7AjkYdzrCa5R9G29rvcEX/TjMY=;
        b=MR2Vxc/FKZy23dzMthpdugHA5/lNbLYpaZfcD3/PEkV/M7YM/9EqCjcV4yF9ZqvKCc
         IXd2Ug2xs6PdJ/g3+aXlw5OJst2XPxmzC1RaJU5QgOWXNkJuKLEM5pqXaqdlzi5n4Aag
         5wtxRmwNTZeYKemU/ItVqGkrUqGw9hfVzMuVv1n1dJAnALYgSs3vQpfUuVXbou3WP2EL
         mKhuhEd/gtUVcBTMRgUe2DTj4osqrUcUdXBDm2YePDx5bn3ruuoAKV5baPEPIkwfFuCU
         Kcp8pNuJs1pSWqQZ4ApW7qpDonfF45FN8c6ZhWNKDWTEzLO7xZFGBswMcgExcBh29rsu
         djwg==
X-Gm-Message-State: AOAM5314T5YwrB2nUaKq4YfKnoeHfkNytvWgXnu4oeT4OBDcg7jelpcs
        srUzgof3Hhm6iikeMN+d8sY=
X-Google-Smtp-Source: ABdhPJxYTjYyI/r0AvdJpfRjWq2J/veKJmRZrPdsAWlKAGKDg+ozYCqiUgzKh1VKtK8yPweGmD96nw==
X-Received: by 2002:a63:df09:: with SMTP id u9mr14350990pgg.64.1616216259743;
        Fri, 19 Mar 2021 21:57:39 -0700 (PDT)
Received: from localhost.localdomain ([223.71.18.62])
        by smtp.googlemail.com with ESMTPSA id t10sm6789176pjf.30.2021.03.19.21.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 21:57:39 -0700 (PDT)
From:   kehuanlin <chgokhl@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kehuanlin@fishsemi.com, kehuanlin <chgokhl@gmail.com>
Subject: [PATCH] mmc: core: Mark mmc_host device with pm_runtime_no_callbacks
Date:   Sat, 20 Mar 2021 12:57:20 +0800
Message-Id: <20210320045720.11872-1-chgokhl@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The rpm_resume() will call parent's resume callback recursively.
Since mmc_host has no its own pm_runtime callbacks, the mmc devices
may fail to resume (-ENOSYS in rpm_callback) sometimes. Mark mmc_host
device with pm_runtime_no_callbacks can fix the issue.

Signed-off-by: kehuanlin <chgokhl@gmail.com>
---
 drivers/mmc/core/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 9b89a91b6b47..177bebd9a6c4 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pagemap.h>
+#include <linux/pm_runtime.h>
 #include <linux/pm_wakeup.h>
 #include <linux/export.h>
 #include <linux/leds.h>
@@ -480,6 +481,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
 	device_enable_async_suspend(&host->class_dev);
+	pm_runtime_no_callbacks(&host->class_dev);
 
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
-- 
2.30.0

