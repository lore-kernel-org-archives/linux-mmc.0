Return-Path: <SRS0=LShN=7L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7956C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 29 May 2020 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EE8207BC
	for <linux-mmc@archiver.kernel.org>; Fri, 29 May 2020 10:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poIRSp28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE2KXy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 May 2020 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgE2KXv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 May 2020 06:23:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5657BC08C5C6
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2020 03:23:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z6so1894908ljm.13
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2020 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtiHAujl9lf2oMvwRBMnVGbOD90IBdFARsRXPPpNsWY=;
        b=poIRSp28YZwRA/l7u/DkP2Hcl603SWYzvPDSwddXAqTudJYmQuYGH2QobiSOQjiMWD
         tYlGXNTFFdq9mJS01vTirdtF8gpUxBdiBnNnRO0nOOMmuar7cHod5Xuno9HPM/9VKrZR
         N1Iya4RgYNf18bhwdD8BiKNnjzMN1CsW6RSQUNRGjiMgl8vfxuY0UUVKQMnSx3RRKjSZ
         U3bWKwWDKABc7hix4vDyqhOHlbmkdALRq7pOVAqByi286lDEW71KixibqBWdPe4KSKz+
         rd9NYrNSKFlyqgY0cHaYdN4c4+ypEuFLGI/9BYKhne0AjaWYRiujURjfTJUkjOI3Pb4x
         UwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtiHAujl9lf2oMvwRBMnVGbOD90IBdFARsRXPPpNsWY=;
        b=rmmhMIxxOK8gGvJxQkplA6r/QANHcrUaLX8FbUHlS8c/3kRJua/mJgn7ClD7w9hT/O
         dAIzEPy4omrB98JtXifGYJBW3dkIeHcaSsarpmgkv9dro5zI0Isman37T4z36Ly8nacN
         4PJ8NynRhLU7LeXewTxawz7pu9y/oC4nm2WgeESQjfPFv+hTUKzXWmy3Bmvym8btCc3d
         4gNFST88jfXU1SPsunYgFV94fx0aMZOUml+IJszadjWBHZ0+8CtoZImnTLArZWuAs6aK
         1nI4UWQsbykmWZFCFGyL/xgxyFFD0pLHhpl/nPLYrMO7wcsQmIF4ra6IgHPrHCeEFWj+
         s0fg==
X-Gm-Message-State: AOAM532Lcl2gIAqEtMPMOycRLfr8YpUL15Ldy4g0E8/ZRIz4dtChP5/e
        lIanpxgk1ZDS1UCo7n5PdMtNh6OWu2x6fA==
X-Google-Smtp-Source: ABdhPJycAtZPotAPlmj89l9sOK9ZfCEE9Y2BHD3lMtTp3cDn3DaGEz7sVaVlq2KCtV8mrq07crqmxQ==
X-Received: by 2002:a2e:980d:: with SMTP id a13mr4017188ljj.277.1590747829267;
        Fri, 29 May 2020 03:23:49 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id g142sm2175067lfd.59.2020.05.29.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:23:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH] mmc: core: Always allow the card detect uevent to be consumed
Date:   Fri, 29 May 2020 12:23:41 +0200
Message-Id: <20200529102341.12529-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The approach to allow userspace ~5s to consume the uevent, which is
triggered when a new card is inserted/initialized, currently requires the
mmc host to support system wakeup.

This is unnecessary limiting, especially for an mmc host that relies on a
GPIO IRQ for card detect. More precisely, the mmc host may not support
system wakeup for its corresponding struct device, while the GPIO IRQ still
could be configured as a wakeup IRQ via enable_irq_wake().

To support all various cases, let's simply drop the need for the wakeup
support. Instead let's always register a wakeup source and activate it for
all card detect IRQs by calling __pm_wakeup_event().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  | 10 +++++-----
 drivers/mmc/core/host.c  |  3 +++
 include/linux/mmc/host.h |  1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8d2b808e9b58..aff3fa937674 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1455,12 +1455,12 @@ void mmc_detach_bus(struct mmc_host *host)
 void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
 {
 	/*
-	 * If the device is configured as wakeup, we prevent a new sleep for
-	 * 5 s to give provision for user space to consume the event.
+	 * Prevent system sleep for 5s to allow user space to consume the
+	 * corresponding uevent. This is especially useful, when CD irq is used
+	 * as a system wakeup, but doesn't hurt in other cases.
 	 */
-	if (cd_irq && !(host->caps & MMC_CAP_NEEDS_POLL) &&
-		device_can_wakeup(mmc_dev(host)))
-		pm_wakeup_event(mmc_dev(host), 5000);
+	if (cd_irq && !(host->caps & MMC_CAP_NEEDS_POLL))
+		__pm_wakeup_event(host->ws, 5000);
 
 	host->detect_change = 1;
 	mmc_schedule_delayed_work(&host->detect, delay);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index c8768726d925..6141a85749ca 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pagemap.h>
+#include <linux/pm_wakeup.h>
 #include <linux/export.h>
 #include <linux/leds.h>
 #include <linux/slab.h>
@@ -36,6 +37,7 @@ static DEFINE_IDA(mmc_host_ida);
 static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	wakeup_source_unregister(host->ws);
 	ida_simple_remove(&mmc_host_ida, host->index);
 	kfree(host);
 }
@@ -400,6 +402,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->index = err;
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
+	host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
 
 	host->parent = dev;
 	host->class_dev.parent = dev;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7149bab555d7..1fa4fa1caef5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -287,6 +287,7 @@ struct mmc_host {
 #ifdef CONFIG_PM_SLEEP
 	struct notifier_block	pm_notify;
 #endif
+	struct wakeup_source	*ws;		/* Enable consume of uevents */
 	u32			max_current_330;
 	u32			max_current_300;
 	u32			max_current_180;
-- 
2.20.1

