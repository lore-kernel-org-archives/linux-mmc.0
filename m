Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042A6C64980
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57EF61289
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhGVDWR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhGVDWK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8BDC061757;
        Wed, 21 Jul 2021 21:02:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p9so4337119pjl.3;
        Wed, 21 Jul 2021 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jz33oZyW6qGbCKVeZCfohr4PS24TVJXz4sDYeaRdSgU=;
        b=U9LZQIzUA+Gzl8DyOxl62WTY1OxfSPlVv3a1kssZGocCX55cYGQISq46mGDo+OinOy
         Z443xMFrZYbAow0zdWiht6FKLLBh1gSgrARCqgxVLtmWuZNcTlxHHDAW5TUfDtrGVr/2
         oLHpD1fptykbfBgF2Z3y44vVVofsK94TaS8N46wCKXrG1c+HD4a0FMfJbcFSXFKrdojw
         ktRb9qv4mMF2i2ti2goqZHbBL2QeWrWqir0TCyMXV6LEeDCM6APeM0co76ES+shiIvJ9
         NwElvMzxSJ+ffGSQWMJ5xlIBgA81SiSh7NX8B1ZGXLktZYKyxG429Ed+EGssHQvP1Jr2
         082A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jz33oZyW6qGbCKVeZCfohr4PS24TVJXz4sDYeaRdSgU=;
        b=UH5u3djp/yMNzloPbwy/mLWMvRmoVuwNj/EDZGpsauMt5HesbjXchQ6DyesXJNeHsz
         XqsSdFzN9VkbMg0rrV4WRuibyeDN4/TSSfUQdzvMrStwJCQmLK+0WUKBqkCdqGX7qJhE
         uK+FKg82Q654tsz14Pf1sMiSfclGAQPA0G/KRJTkcK4I6DY6vhMtlOX4ut1VkBoIrAfi
         e86IiP7E1pMLe5FBWr7NaUo7EHwA6LogdlpCgLvYjDZkA0pB2AIRPAnbkd4u3TN65NhA
         MJwrb9v9nMEQRS/U02yIiBAAds7nLW24McbGXSqrUm+I4De0AI0pr3VdtSEAN2Zwdqyg
         cWKA==
X-Gm-Message-State: AOAM530u/7piMCQZCCjPOF2XebGvPqEJHwjVVLRQYs7FQj0zLbxQnGPd
        OHwsH9oMwGKj454FE872O98=
X-Google-Smtp-Source: ABdhPJxQJJQ/ghZdsks/I9RZdGFBg7/B62oV9nxVDYxkM95fLPwn7pCFDuGOFTEVTjXt5dp2m8uetQ==
X-Received: by 2002:a17:90a:f18f:: with SMTP id bv15mr6880591pjb.63.1626926565079;
        Wed, 21 Jul 2021 21:02:45 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:44 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
Subject: [RFC PATCH v3.2 28/29] mmc: Remove duplicate code.
Date:   Thu, 22 Jul 2021 12:01:23 +0800
Message-Id: <20210722040124.7573-28-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

1. core.c : Use tab to replace space.
2. sdhci.c: Remove code which had been moved into sdhci_request_done_dma()

Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/core/core.c  |  2 +-
 drivers/mmc/host/sdhci.c | 74 ----------------------------------------
 2 files changed, 1 insertion(+), 75 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d53722c21f29..2624d7b30cd2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2248,7 +2248,7 @@ void mmc_rescan(struct work_struct *work)
 	if (mmc_card_sd_express(host)) {
 		mmc_release_host(host);
 		goto out;
-        }
+	}

 	if (host->caps & MMC_CAP_UHS2) {
 		/*
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5356cd5f4907..ae8e3b5a38bf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3155,83 +3155,9 @@ bool sdhci_request_done(struct sdhci_host *host)
 			sdhci_set_mrq_done(host, mrq);
 		}

-		if (data && data->host_cookie == COOKIE_MAPPED) {
-			if (host->bounce_buffer) {
-				/*
-				 * On reads, copy the bounced data into the
-				 * sglist
-				 */
-				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
-					unsigned int length = data->bytes_xfered;
-
-					if (length > host->bounce_buffer_size) {
-						pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
-						       mmc_hostname(host->mmc),
-						       host->bounce_buffer_size,
-						       data->bytes_xfered);
-						/* Cap it down and continue */
-						length = host->bounce_buffer_size;
-					}
-					dma_sync_single_for_cpu(
-						mmc_dev(host->mmc),
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						DMA_FROM_DEVICE);
-					sg_copy_from_buffer(data->sg,
-						data->sg_len,
-						host->bounce_buffer,
-						length);
-				} else {
-					/* No copying, just switch ownership */
-					dma_sync_single_for_cpu(
-						mmc_dev(host->mmc),
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						mmc_get_dma_dir(data));
-				}
-			} else {
-				/* Unmap the raw data */
-				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-					     data->sg_len,
-					     mmc_get_dma_dir(data));
-			}
-			data->host_cookie = COOKIE_UNMAPPED;
-		}
-
 		sdhci_request_done_dma(host, mrq);
 	}

-	/*
-	 * The controller needs a reset of internal state machines
-	 * upon error conditions.
-	 */
-	if (sdhci_needs_reset(host, mrq)) {
-		/*
-		 * Do not finish until command and data lines are available for
-		 * reset. Note there can only be one other mrq, so it cannot
-		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
-		 * would both be null.
-		 */
-		if (host->cmd || host->data_cmd) {
-			spin_unlock_irqrestore(&host->lock, flags);
-			return true;
-		}
-
-		/* Some controllers need this kick or reset won't work here */
-		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
-			/* This is to force an update */
-			host->ops->set_clock(host, host->clock);
-
-		/*
-		 * Spec says we should do both at the same time, but
-		 * Ricoh controllers do not like that.
-		 */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
-
-		host->pending_reset = false;
-	}
-
 	host->mrqs_done[i] = NULL;

 	spin_unlock_irqrestore(&host->lock, flags);
--
2.32.0

