Return-Path: <SRS0=pUbW=2Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2450DC2D0DA
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Dec 2019 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE91C20828
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Dec 2019 11:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoM3w92B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLZLan (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Dec 2019 06:30:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46274 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZLan (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Dec 2019 06:30:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so12724294pgb.13;
        Thu, 26 Dec 2019 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mm2k7kp3HTdwOQhCh2pHkzi/+UVQ/gaC7L55Fq1FQNY=;
        b=MoM3w92BO547oVBPnswuh+PTu1hn4nzc8zzpd9beE/RYduyjptQhruEp5ndmYATr+T
         9qRvLwVKYMCthogUgFsgVJHhxGP3rdOZvWusxsgIK2BjTH7otWAHeYUKAQpK7zowj4gH
         sMUDLsl56y3kzPtRWX6wfMSrP1Jea52YzDD+CHnySzm6Rza8kjTKCB9XTwmMx2Bw8iPC
         V1uYNqitItW18OkapeTh/z5KHwSIO9BQ7NYEIkZW996c3EE84x6zi1/PnoONZzp8aTTD
         eRizdyCjIRVYJynuaDiNgqxudGeWDx3WKMpB30Nl4s3oBgK42r7cWFR5KMGqa8hepas2
         oGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mm2k7kp3HTdwOQhCh2pHkzi/+UVQ/gaC7L55Fq1FQNY=;
        b=lypu1UiVqERkU4m0BM7rnclTWjepGKVM5ROYK16LTUSwnB/Fojo6MsfJI1wW0IsQBA
         mDQLNdBL7A0bUunkBfcZ9dj/FyfLZUN7GAuzIERWvWdLRYyLgXm8wEzB/bUofabGA/lo
         N6A5QWAPOmJiAjXTIfOacHg3ks3V8kGSRz5Ny5FHW3FzCgy4IYpscWnUEw/4xw2RF5Qw
         irbuQg9ushwBcUOkwC1suEsHWMxy8FXaURAVYAGoH54pbH+qV9kAqxJfhJdV5lEYwXV8
         ZpIaJqsz0d5sgagW2FOykD5nlwHa8kQc7Mlnf0hg3OF6BLESTbMwSpWRgvkDLg0pVriA
         QcZA==
X-Gm-Message-State: APjAAAUh6QBJezzSRck/sYcyDLcffs1RL7i0yn6+4RBJg6n0OfUrSbky
        mizcB/jLRt+GtR6GxCv3DbQ=
X-Google-Smtp-Source: APXvYqwPD7c6kqCmEJeleqH3lpxPMRjj0Wg3xVLJFSqOh4Hy14u50VVImzApe6+etmKbOHrYywwJFw==
X-Received: by 2002:a63:1418:: with SMTP id u24mr46242664pgl.279.1577359842447;
        Thu, 26 Dec 2019 03:30:42 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y6sm33743287pgc.10.2019.12.26.03.30.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Dec 2019 03:30:41 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mmc: host: Introduce the request_atomic() for the host
Date:   Thu, 26 Dec 2019 19:29:19 +0800
Message-Id: <cb52e4e6c15e02f1fb233bd1488ce82741a38c05.1577358666.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1577358666.git.baolin.wang7@gmail.com>
References: <cover.1577358666.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1577358666.git.baolin.wang7@gmail.com>
References: <cover.1577358666.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SD host controller can process one request in the atomic context if
the card is nonremovable, which means we can submit next request in the
irq hard handler when using the MMC software queue to reduce the latency.
Thus this patch adds a new API request_atomic() for the host controller
and implement it for the SD host controller.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c |   27 +++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |    1 +
 include/linux/mmc/host.h |    3 +++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 64bef96..004f789 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1810,17 +1810,12 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
  *                                                                           *
 \*****************************************************************************/
 
-void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+static void sdhci_start_request(struct mmc_host *mmc, struct mmc_request *mrq,
+				int present)
 {
-	struct sdhci_host *host;
-	int present;
+	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
-	host = mmc_priv(mmc);
-
-	/* Firstly check card presence */
-	present = mmc->ops->get_cd(mmc);
-
 	spin_lock_irqsave(&host->lock, flags);
 
 	sdhci_led_activate(host);
@@ -1848,6 +1843,22 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+
+void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	sdhci_start_request(mmc, mrq, 1);
+}
+EXPORT_SYMBOL_GPL(sdhci_request_atomic);
+
+void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	int present;
+
+	/* Firstly check card presence */
+	present = mmc->ops->get_cd(mmc);
+
+	sdhci_start_request(mmc, mrq, present);
+}
 EXPORT_SYMBOL_GPL(sdhci_request);
 
 void sdhci_set_bus_width(struct sdhci_host *host, int width)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a73ce89..cecc64b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -765,6 +765,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
+void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3931aa3..cc1a79b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -92,6 +92,9 @@ struct mmc_host_ops {
 			    int err);
 	void	(*pre_req)(struct mmc_host *host, struct mmc_request *req);
 	void	(*request)(struct mmc_host *host, struct mmc_request *req);
+	/* Submit one request to host in atomic context. */
+	void	(*request_atomic)(struct mmc_host *host,
+				  struct mmc_request *req);
 
 	/*
 	 * Avoid calling the next three functions too often or in a "fast
-- 
1.7.9.5

