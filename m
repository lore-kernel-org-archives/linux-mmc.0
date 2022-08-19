Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0396CC32771
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Aug 2022 21:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352509AbiHSV01 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352508AbiHSV0Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 17:26:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC406106FAD
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 14:26:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tl27so11057355ejc.1
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=HfXaeSjI3zLq10mjQ0wA06F58EqL6YnMjgb7hus5k/s=;
        b=CFLosHWuGiAT0PjSlFsP6pdw5t3GUlVCrUfrzD8n3ZBix/WenAHQsDTUlDXrPL7S/Y
         29FU+vSajTM3J6Vo3yZbVyEDVkYPZnBY/EUVzhFoIKHHr68xCgPPqgJ5S19zfWWIks7D
         JWfw6BIjBJan5mbgk79j6XK8Nq0iGe2XVJy0UhZ95zfOX3F0ePAukWCr7pY3eZVz0QJu
         5Nu9jgdmcloDkBucn17KttqEJw0+80nxmvecgxN3yDKSyJQVQ6c/8kgIfUsNPqdP40AF
         hCKYXikBbpOqZHfLrwIKu8cbBWfyIIe6bFjNrlgXc6CCXONHqTbtpnu8TqUyN8lD+80P
         78WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=HfXaeSjI3zLq10mjQ0wA06F58EqL6YnMjgb7hus5k/s=;
        b=X0hD5mBy1YZvUx9oGTLcQTYfmD9lJkkLTuhRscQKMLpa+W/RgWD8EIC504XR5sabxD
         IGT5BBmy7aZXXbHu6IlbxEpqHIE1akL4IvKX+uCPgoiMLm2q4okHQwEED5OkcSJjU2fn
         Gu9uyxrb/omvXcZUt9wE6QWZ9fW7M5Rxm6UER9w+mEIq4S9MDe60l6GBp3+zmJBn4wpt
         5nZUOjspBZ3KHzcc+pELIrWFVqaJqhJ0jnuT76Wjk1A58CMnxju8t4+HFBV88KrHQGYH
         CVTLS7RwMuwm8qNhJ9MUaCxvL016R8WZyR3qX8DNrpI1xBfVpQDjhaK4oJG6EqxFAxTP
         OrZw==
X-Gm-Message-State: ACgBeo3VWozmAirpPwXOpxeJxLUXlQ/uRFzOLTo1CSG0lc35gaDim8VA
        PoSwtFdKwHPXVfyLmKGZf6chR+f5Ebg=
X-Google-Smtp-Source: AA6agR5Q1rFP/CPmoczxzCeB3ic29Xj1neyBZCUI2HjewVeGlBtlCzFIMsQO7I0+P7M22i2R7jZKww==
X-Received: by 2002:a17:907:3f88:b0:730:9d82:5114 with SMTP id hr8-20020a1709073f8800b007309d825114mr5938593ejc.333.1660944381910;
        Fri, 19 Aug 2022 14:26:21 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5ac:3600:6819:de7b:5db7:493? (dynamic-2a01-0c23-c5ac-3600-6819-de7b-5db7-0493.c23.pool.telefonica.de. [2a01:c23:c5ac:3600:6819:de7b:5db7:493])
        by smtp.googlemail.com with ESMTPSA id s22-20020a056402015600b00445f545e4besm3648693edu.59.2022.08.19.14.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 14:26:21 -0700 (PDT)
Message-ID: <13d8200a-e2a8-d907-38ce-a16fc5ce14aa@gmail.com>
Date:   Fri, 19 Aug 2022 23:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: core: Switch to basic workqueue API for sdio_irq_work
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The delay parameter isn't set by any user, therefore simplify the code
and switch to the basic workqueue API w/o delay support. This also
reduces the size of struct mmc_host.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/host.c     | 2 +-
 drivers/mmc/core/sdio.c     | 4 ++--
 drivers/mmc/core/sdio_irq.c | 4 ++--
 include/linux/mmc/host.h    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 0fd91f749..b89dca1f1 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -565,7 +565,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
-	INIT_DELAYED_WORK(&host->sdio_irq_work, sdio_irq_work);
+	INIT_WORK(&host->sdio_irq_work, sdio_irq_work);
 	timer_setup(&host->retune_timer, mmc_retune_timer, 0);
 
 	/*
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 0b682a31c..f64b9ac76 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1043,7 +1043,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 
 	/* Prevent processing of SDIO IRQs in suspended state. */
 	mmc_card_set_suspended(host->card);
-	cancel_delayed_work_sync(&host->sdio_irq_work);
+	cancel_work_sync(&host->sdio_irq_work);
 
 	mmc_claim_host(host);
 
@@ -1103,7 +1103,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
 		else if (host->caps & MMC_CAP_SDIO_IRQ)
-			queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
+			schedule_work(&host->sdio_irq_work);
 	}
 
 out:
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 4b1f7c966..2b24bdf38 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -124,7 +124,7 @@ static void sdio_run_irqs(struct mmc_host *host)
 void sdio_irq_work(struct work_struct *work)
 {
 	struct mmc_host *host =
-		container_of(work, struct mmc_host, sdio_irq_work.work);
+		container_of(work, struct mmc_host, sdio_irq_work);
 
 	sdio_run_irqs(host);
 }
@@ -132,7 +132,7 @@ void sdio_irq_work(struct work_struct *work)
 void sdio_signal_irq(struct mmc_host *host)
 {
 	host->sdio_irq_pending = true;
-	queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
+	schedule_work(&host->sdio_irq_work);
 }
 EXPORT_SYMBOL_GPL(sdio_signal_irq);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index eb8bc5b9b..8fdd3cf97 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -476,7 +476,7 @@ struct mmc_host {
 
 	unsigned int		sdio_irqs;
 	struct task_struct	*sdio_irq_thread;
-	struct delayed_work	sdio_irq_work;
+	struct work_struct	sdio_irq_work;
 	bool			sdio_irq_pending;
 	atomic_t		sdio_irq_thread_abort;
 
-- 
2.37.2

