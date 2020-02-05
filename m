Return-Path: <SRS0=4knG=3Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D566BC35254
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBCF21927
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 12:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqK8prlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBEMvb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:51:31 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55723 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgBEMvb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Feb 2020 07:51:31 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so941423pjz.5;
        Wed, 05 Feb 2020 04:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qXFSOdJFY54Rwc/1S4vXiFbbifW3bH93ZRFzyBvbEM0=;
        b=PqK8prljZrh8Nl09N/AoAVTK4xaSUk222FtX0iOIv5d7HaHwIloY88/YO3i1r7jFcQ
         IRsyA1hnh8T364CkFBfs8D95p2pgdi/QjgzUepSOWpc/C1NqmzRcpsYGbyuRRYKzrpN2
         F4hNclJnsWtTYSesPMcbOAPWdHGHIWBiMTdHWaxVlDsUsLSt8SDKbGkNyhSvvvcPwdh8
         99gDupRFG7Tgnd6olFlUrnRQXKaCXT2UMS8S0mTG6UFHahmeQpIbj7s3dS9V30BE3gpO
         /nBwM0msmy3ceE6XEDvmzdLEHPUgbj0HLjD9s8I8zqyiwxiTN1JOD375+dJxtPJ1KbUn
         oppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qXFSOdJFY54Rwc/1S4vXiFbbifW3bH93ZRFzyBvbEM0=;
        b=QAElIwRXnJGytcVpZygqYXuAR2I6FnRxT70W/neuoizY+MRnfp0+n+MSGkj+z2+AjN
         5wBZKPcEnAP1oNc1RUTeCOvYhuhUSrLeZaUttrn70ya9DGsIqAiWF2vPMT7Pd+qSeKaJ
         37h2kPQRqZUhB6qUxFRaD2JN/xWtWb9ykbD9IZSWZWpTzSgubXz7MiMRyBOQfy3KEPo3
         HOzuUMOoGq5Lr/txW8pArIuRM9Ex1RWnlX+Ffvw79db11yoHMfPhRXIYWip63Etl5rsb
         Qzh1bTk68YJBW0UMeGAHnrseGb/3Qt7aXIPHjzEymSGs7vjoLEge5X378i5Q9XaMRF2H
         BczQ==
X-Gm-Message-State: APjAAAUnQYh19zTYowHl48Ywoq4eMYghChUaeZMsxCD4kmQyVMauLGbl
        ZTZtqPFB9OPpMLWOALmbWl4=
X-Google-Smtp-Source: APXvYqzsQZpSNdGN//eoRR8y6Oymb4LbqAIXFeFJVpYMTWuLiWFf/HhP918199kPK7K0s8Xxr49Wtw==
X-Received: by 2002:a17:902:463:: with SMTP id 90mr36624355ple.213.1580907090390;
        Wed, 05 Feb 2020 04:51:30 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y127sm22864784pfg.22.2020.02.05.04.51.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Feb 2020 04:51:30 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/5] mmc: host: sdhci: Add a variable to defer to complete requests if needed
Date:   Wed,  5 Feb 2020 20:50:31 +0800
Message-Id: <99f715b4b442d196bd7127cb6264b804219036ad.1580894083.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1580894083.git.baolin.wang7@gmail.com>
References: <cover.1580894083.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1580894083.git.baolin.wang7@gmail.com>
References: <cover.1580894083.git.baolin.wang7@gmail.com>
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

