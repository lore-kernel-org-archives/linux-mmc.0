Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549E8C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C72764E57
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhBLNRF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhBLNRB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2021 08:17:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6370C061786
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 05:16:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m22so13070440lfg.5
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 05:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTDYqyjjzX5B3Ni0UXMher++mMIetga5ni7QQVe5LLQ=;
        b=CxT2M/AKPqAnl6tNXWKDY2gTbCh+bJPOmwa8X8SKUvIT/zp5cH5dDK3H4VHT5e5LCn
         /lc9k1evmF0fL8Jcpj1Qp/Ux72GNdfMTvgxT4+hEyOzfnCBjyayiZXpO6IE/csdLclWE
         RTmm9vBTEUeGcqQhmTIvPaSY9DQMtWUXGohYQfQfzze9UYxxS1i9EHg0V0MMcwriIfxB
         7YiCgOjeTaUBUKtvowua1PPsX4QH2utYJc158zSIsxErpmoaMR/r7zFZJsmb+xyIRgJU
         0eX9T05rzz6q9AauSsascFK7vZkx7+eYP7S38QcLG/Q3LoZPs8Qy7zAYTyeg/B4GcgVM
         Imtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTDYqyjjzX5B3Ni0UXMher++mMIetga5ni7QQVe5LLQ=;
        b=VEhF3eheo2hL6Fjg57ztsvMHbBiQEyr1vBEgJ1QZ48rcoj3G6get9x1sND2oi4RMjG
         qb/0KXLhlXrLUl/cIYl/tIakTX+4r9UggJS/j6vQkT8sUKWHleO7/SkB8aJyReCmjLv+
         Gj4jKaCWz9M+6VV78Ffcy0ABgq+hk+oiPHg0t2oeA4Oc+HF14iccaSa2xB1/MJWpnDwV
         uO/Bt7nvINYUjG9Lw65HxEBCYLBud5ttDfVQ6DQbqWZ6OsFhl9u/eoUGYG6vAiIN89el
         tpew8MUnIMpT8joRkAChzh4zdDBgCfbBSNoo63gTggqOgVXhtEs6FILZcglqX5Mg8rnv
         +iZQ==
X-Gm-Message-State: AOAM5323dCqZ7yvovM2n2p49syazBeTKn+fvrOHr9hpTprDtsoMTNJCj
        CZwcN3McBRBtoIeoPFBRrNdmy53P154hgzDh
X-Google-Smtp-Source: ABdhPJzU5T31V+T4DlryUo3Y3NHW1UjZTtDXaf6onT/F3qTvmZQ7ZUHxdWdPrG6VzWVbLUhYWzhetg==
X-Received: by 2002:ac2:58fb:: with SMTP id v27mr1523937lfo.371.1613135777664;
        Fri, 12 Feb 2021 05:16:17 -0800 (PST)
Received: from localhost.localdomain (h-98-128-181-28.NA.cust.bahnhof.se. [98.128.181.28])
        by smtp.gmail.com with ESMTPSA id a25sm1314400ljk.35.2021.02.12.05.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:16:16 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: core: Drop reference counting of the bus_ops
Date:   Fri, 12 Feb 2021 14:16:10 +0100
Message-Id: <20210212131610.236843-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When the mmc_rescan work is enabled for execution (host->rescan_disable),
it's the only instance per mmc host that is allowed to set/clear the
host->bus_ops pointer.

Besides the mmc_rescan work, there are a couple of scenarios when the
host->bus_ops pointer may be accessed. Typically, those can be described as
as below:

*)
Upper mmc driver layers (like the mmc block device driver or an SDIO
functional driver) needs to execute a host->bus_ops callback. This can be
considered as safe without having to use some special locking mechanism,
because they operate on top of the struct mmc_card. As long as there is a
card to operate upon, the mmc core guarantees that there is a host->bus_ops
assigned as well. Note that, upper layer mmc drivers are of course
responsible to clean up from themselves from their ->remove() callbacks,
otherwise things would fall apart anyways.

**)
Via the mmc host instance, we may need to force a removal of an inserted
mmc card. This happens when a mmc host driver gets unbind, for example. In
this case, we protect the host->bus_ops pointer from concurrent accesses,
by disabling the mmc_rescan work upfront (host->rescan_disable). See
mmc_stop_host() for example.

This said, it seems like the reference counting of the host->bus_ops
pointer at some point have become superfluous. As this is an old mechanism
of the mmc core, it a bit difficult to digest the history of when that
could have happened. However, let's drop the reference counting to avoid
unnecessary code-paths and lockings.

Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  | 89 ++--------------------------------------
 include/linux/mmc/host.h |  2 -
 2 files changed, 4 insertions(+), 87 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2e41fa598bd6..860995eb548b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1377,63 +1377,13 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
 	mmc_power_up(host, ocr);
 }
 
-/*
- * Cleanup when the last reference to the bus operator is dropped.
- */
-static void __mmc_release_bus(struct mmc_host *host)
-{
-	WARN_ON(!host->bus_dead);
-
-	host->bus_ops = NULL;
-}
-
-/*
- * Increase reference count of bus operator
- */
-static inline void mmc_bus_get(struct mmc_host *host)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
-	host->bus_refs++;
-	spin_unlock_irqrestore(&host->lock, flags);
-}
-
-/*
- * Decrease reference count of bus operator and free it if
- * it is the last reference.
- */
-static inline void mmc_bus_put(struct mmc_host *host)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
-	host->bus_refs--;
-	if ((host->bus_refs == 0) && host->bus_ops)
-		__mmc_release_bus(host);
-	spin_unlock_irqrestore(&host->lock, flags);
-}
-
 /*
  * Assign a mmc bus handler to a host. Only one bus handler may control a
  * host at any given time.
  */
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
 {
-	unsigned long flags;
-
-	WARN_ON(!host->claimed);
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	WARN_ON(host->bus_ops);
-	WARN_ON(host->bus_refs);
-
 	host->bus_ops = ops;
-	host->bus_refs = 1;
-	host->bus_dead = 0;
-
-	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 /*
@@ -1441,18 +1391,7 @@ void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
  */
 void mmc_detach_bus(struct mmc_host *host)
 {
-	unsigned long flags;
-
-	WARN_ON(!host->claimed);
-	WARN_ON(!host->bus_ops);
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	host->bus_dead = 1;
-
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	mmc_bus_put(host);
+	host->bus_ops = NULL;
 }
 
 void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
@@ -2244,32 +2183,15 @@ void mmc_rescan(struct work_struct *work)
 		host->trigger_card_event = false;
 	}
 
-	mmc_bus_get(host);
-
 	/* Verify a registered card to be functional, else remove it. */
-	if (host->bus_ops && !host->bus_dead)
+	if (host->bus_ops)
 		host->bus_ops->detect(host);
 
 	host->detect_change = 0;
 
-	/*
-	 * Let mmc_bus_put() free the bus/bus_ops if we've found that
-	 * the card is no longer present.
-	 */
-	mmc_bus_put(host);
-	mmc_bus_get(host);
-
 	/* if there still is a card present, stop here */
-	if (host->bus_ops != NULL) {
-		mmc_bus_put(host);
+	if (host->bus_ops != NULL)
 		goto out;
-	}
-
-	/*
-	 * Only we can add a new handler, so it's safe to
-	 * release the lock here.
-	 */
-	mmc_bus_put(host);
 
 	mmc_claim_host(host);
 	if (mmc_card_is_removable(host) && host->ops->get_cd &&
@@ -2332,18 +2254,15 @@ void mmc_stop_host(struct mmc_host *host)
 	/* clear pm flags now and let card drivers set them as needed */
 	host->pm_flags = 0;
 
-	mmc_bus_get(host);
-	if (host->bus_ops && !host->bus_dead) {
+	if (host->bus_ops) {
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		host->bus_ops->remove(host);
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
 		mmc_power_off(host);
 		mmc_release_host(host);
-		mmc_bus_put(host);
 		return;
 	}
-	mmc_bus_put(host);
 
 	mmc_claim_host(host);
 	mmc_power_off(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 927ba7566617..7b5555c705fd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -423,7 +423,6 @@ struct mmc_host {
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
 	unsigned int		claimed:1;	/* host exclusively claimed */
-	unsigned int		bus_dead:1;	/* bus has been released */
 	unsigned int		doing_init_tune:1; /* initial tuning in progress */
 	unsigned int		can_retune:1;	/* re-tuning can be used */
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
@@ -455,7 +454,6 @@ struct mmc_host {
 	struct mmc_slot		slot;
 
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
-	unsigned int		bus_refs;	/* reference counter */
 
 	unsigned int		sdio_irqs;
 	struct task_struct	*sdio_irq_thread;
-- 
2.25.1

