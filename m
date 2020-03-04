Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E14DC3F2D7
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761D92166E
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5+LEcMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgCDHm0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:42:26 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35977 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgCDHmZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 02:42:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id d7so570885pjw.1;
        Tue, 03 Mar 2020 23:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UuO82t2CTJ8u+mIQWhpCsbN6XGcm5YIydRt9WbDocTg=;
        b=q5+LEcMcECo3hiwQqVqhgnOiB10Cx8lLXJrUNQts+N1ziH7dAOmF8WZ0jlhgSq+5sx
         3LuhT4Fk/awSwYJH4qaa0Z/frz47C4b+WNVch7n+OGd9hqQzEk+6oFsZXw9/mYQQZAIj
         3hTnIBKNbVnEcxsJ3IT1eA7cWAjxOT0N2dPoqDPlP+uQvz3K9TqWWG2HtXz9rAac3KtH
         7ZFmXUYjkr/BZVYHO+j0BJhuwRQvtUWXAyPtB2ZF1fRSow7JIAgA6MMGFx38tdCb9LdW
         qDicAAF/f+QxVmufCgAKJbNdr1Mmkisbh+ZrCGQh6J9XS7i6jjnM3OUkSwC3ngEjOd1y
         oybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UuO82t2CTJ8u+mIQWhpCsbN6XGcm5YIydRt9WbDocTg=;
        b=Y2doG22wUls5ZQc5ZtrN7XWcJGCc689qubHAwpIO8QGpr54M6vJ1btKdIXJGqA4WAW
         yEsp9mvA84q5UHhGSPuocmAyvlVJ3mqKenpSkfkW0J9XNEU3vMk/Snbjif4Cx4pOiE0U
         OSY2Ech/n+jXENKA+X72pBkjDCDe4KpNjjE8PE32TRtv1coum3YLf6owE6lnJROwV04Y
         2uYLxpepJW/B+A4sFhTrpctBKnywhMJa9eSYThsSuwNtWI0v8am6AOdl0/4miAOj+0Fd
         p4MFU2k3IQ8MdsIiLiNBSCibjOjMmbZPX15F26ewotTqroVxbblD35CivxJHWnTtSiXm
         lRWA==
X-Gm-Message-State: ANhLgQ0J02utmySafO+37QX9aXIEYKecX4d3CTtEz5IW31WlMtn117xB
        kwqWq463DhHxJVV0g0NNSTY=
X-Google-Smtp-Source: ADFU+vs9X6W6h0IGUCku1qUo5EOB0CszfGCYTvy6MNEhj/XIB69giEOjuJvxdqx0WP7MQje4NgPZkQ==
X-Received: by 2002:a17:90a:3324:: with SMTP id m33mr1774085pjb.167.1583307743416;
        Tue, 03 Mar 2020 23:42:23 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k24sm24097374pgm.61.2020.03.03.23.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2020 23:42:23 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/3] mmc: host: Introduce the request_atomic() for the host
Date:   Wed,  4 Mar 2020 15:42:00 +0800
Message-Id: <ace53bca354e2846f19684bd33a9c0f3c2ee2c44.1583307441.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583307441.git.baolin.wang7@gmail.com>
References: <cover.1583307441.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1583307441.git.baolin.wang7@gmail.com>
References: <cover.1583307441.git.baolin.wang7@gmail.com>
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
 drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  1 +
 include/linux/mmc/host.h |  3 +++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9c37451..4febbcb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2016,17 +2016,12 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
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
@@ -2043,6 +2038,22 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
index cac2d97..5507a73 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -775,6 +775,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
+void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 562ed06..db5e59c 100644
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
1.9.1

