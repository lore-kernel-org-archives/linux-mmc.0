Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37605C2BA83
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC8A20842
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGdyka6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgBLEOR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:14:17 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:32921 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLEOQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 23:14:16 -0500
Received: by mail-pj1-f68.google.com with SMTP id m7so1428314pjs.0;
        Tue, 11 Feb 2020 20:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qXFSOdJFY54Rwc/1S4vXiFbbifW3bH93ZRFzyBvbEM0=;
        b=hGdyka6/RmAXFjU841hEJJ21UrRKnW8Hoe1NIwqk5ipPXxuIf/fHKOJmpz7WjEuHeN
         KEd11+a0oVSA02bOfHJ6tSz27iF2eT0inqjKAIW5O4OiAWiK8yn3B2JM9dmXB4+I904o
         YEuCIL/co326mIIX0ijWC6UsSEcEULBNx/wX3LZz/HeLukOWWTJWX7CiR0SRlaBdkIBn
         tsR/Ht/7Oup0k6ERXyeliBVtG/1YnfxTFTL/cHSE+ugv8q5Iv/929nfCy1M2KhWSzu5L
         UoA/zzda6iE0ZyqyI9pMsvPcp8O8mh23l1LvourNMyMvIFuao+QFPWJCcJrl+MEcl9kl
         FILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qXFSOdJFY54Rwc/1S4vXiFbbifW3bH93ZRFzyBvbEM0=;
        b=XZfc22MlmEf9dalHvmyaDqQqguKHAvmNqdIsoxSz6jLgXvVl1hjgRydAF2IO91GxxB
         gNAZBoD8rVpQZB4K1PnaGWT3qK/EV4iyC5+LMG3eh/xvnAAoRoN+BzGv51zAfk6rBt4J
         LeE8GX/W5eLcFQGT93nMQCkTIX9s6uVp6+WU4r1QHX0dJ9q++Ll0zSpX43Zi4jFICmHb
         /xohhdYKEc9aXxIhxi9SJHEMeKvPVkQMIiyDm9IO27qWYnm5CdgyO87iVI5GU+WbypMB
         LJK43E320yJg4bkK1iB6zlnLevsucDbIHpWNFbE2t8MAqMrL4Ctypm3hvONpnCUHLTsF
         wlaw==
X-Gm-Message-State: APjAAAWmPhQC5ge3RffqlS8pw9cRKZZ0d5I0Gd9otzCFXhlhqImjHK5H
        UnBTAcRwY50IyCpzmtF5LYg=
X-Google-Smtp-Source: APXvYqxQVb2chEkGjnmYtilp53q3aLcRcGNzxL6C1uOMNe1G9W3h8QKkKvjRYhQy0HFmgd/lQZbfEQ==
X-Received: by 2002:a17:902:ba8b:: with SMTP id k11mr6337872pls.208.1581480855883;
        Tue, 11 Feb 2020 20:14:15 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm6424762pfq.27.2020.02.11.20.14.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Feb 2020 20:14:15 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/5] mmc: host: sdhci: Add a variable to defer to complete requests if needed
Date:   Wed, 12 Feb 2020 12:12:59 +0800
Message-Id: <e693e7a29beb3c1922b333f4603ea81f43d5c5b1.1581478568.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
References: <cover.1581478568.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
References: <cover.1581478568.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

When using the host software queue, it will trigger the next request in
irq handler without a context switch. But the sdhci_request() can not be
called in interrupt context when using host software queue for some host
drivers, due to the get_cd() ops can be sleepable.

But for some host drivers, such as Spreadtrum host driver, the card is
nonremovable, so the get_cd() ops is not sleepable, which means we can
complete the data request and trigger the next request in irq handler
to remove the context switch for the Spreadtrum host driver.

As suggested by Adrian, we should introduce a request_atomic() API to
indicate that a request can be called in interrupt context to remove
the context switch when using mmc host software queue. But this should
be done in another thread to convert the users of mmc host software queue.
Thus we can introduce a variable in struct sdhci_host to indicate that
we will always to defer to complete requests when using the host software
queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9761981..9c37451 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3250,7 +3250,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
 {
 	struct mmc_data *data = mrq->data;
 
-	return host->pending_reset ||
+	return host->pending_reset || host->always_defer_done ||
 	       ((host->flags & SDHCI_REQ_USE_DMA) && data &&
 		data->host_cookie == COOKIE_MAPPED);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 3e95f74..cac2d97 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -537,6 +537,7 @@ struct sdhci_host {
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
 	bool use_external_dma;	/* Host selects to use external DMA */
+	bool always_defer_done;	/* Always defer to complete requests */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.7.9.5

