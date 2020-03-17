Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E081C2BB1D
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5490C20735
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2a8uuHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgCQKO0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:14:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33688 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQKOZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 06:14:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id n7so11699012pfn.0;
        Tue, 17 Mar 2020 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CJ+wcXrk2AEgHUVo4xt56W56ueRIUgPFWZGnDDDncXc=;
        b=B2a8uuHAXzQ6/5JN+HOZJYJ/4vaiesxeohSbKzfzIaIiwYgIN3zNkNyvHLdRGTAPtG
         nhwaLNwx+iz4GGkvh00uI8tRnv8Mc4mvTUcbk+3xMUaJ6axlYtnODQH6lbz/aQV0bvy8
         EyIe1hx6BNEmANsOGmvXogbrEvv5PXkkimfXBBzi+cbVX4ssKMEIapTi4maDTWfe3+iy
         K5KeQcC5x0/o7QLP3ixpaG5t//MF1jOTd7Wg+d38W0TkOXAB4ZPHm6XgMNlI+aokmxvz
         acdiT55pjHNF6U0UZAuU0LLXCiUmQy9z5AjB0Z0vQipmIX5SKPu7oBo9Pd8t+5BObgdP
         4/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CJ+wcXrk2AEgHUVo4xt56W56ueRIUgPFWZGnDDDncXc=;
        b=NcGngEY18hLlN/817yPiYVDRfnj7bZVsDUaGa5SztOH3F9zqQIFVitVHVQU0C8Xrnv
         1nMBX4MJpoCJwc/wyMqVIb3Po+Y8sqay4XDZNo0BRGmDD2/YYD/UZ9FrDIvRC1x+MPdT
         RnZKwJ0+2hQ5u8qj9bOcy9zqc4A7XGwhwB6dy2a8Hq4tP6B8i8wsHecFvASRMXi6phDl
         GXpkVKq40fOisr14LJWFggSz4zIzAcOLSNmIweISdKp5cXFbHcmW4pGAfz/UJH/jfsjJ
         FYVgEG20dQprA30bGubLQK/rqtGgoKMKM7ehrkom6Shdwa9KTRJKm83KGzmy9cwYjOKg
         8Rhg==
X-Gm-Message-State: ANhLgQ3aBpGwhTa1Igs4X+8RRn6+YJjAPvLcYhDVHocGTECYg+/oDNQU
        CFpAPZN1a7OC3v0G+tZ54NYhO5YRwec=
X-Google-Smtp-Source: ADFU+vsk7ad1YGpnHh9fr67sum48t3QZAHGEe+H8j+CZNAo1fiKXToOmnyNKLR/yAx1nPaK43FvVVg==
X-Received: by 2002:a63:ed10:: with SMTP id d16mr4265924pgi.107.1584440063976;
        Tue, 17 Mar 2020 03:14:23 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s25sm2195487pgv.70.2020.03.17.03.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 03:14:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mmc: host: Introduce the request_atomic() for the host
Date:   Tue, 17 Mar 2020 18:14:09 +0800
Message-Id: <f4ffe80d664a970bb33ab94791bf67f9545e3e29.1584428736.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584428736.git.baolin.wang7@gmail.com>
References: <cover.1584428736.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584428736.git.baolin.wang7@gmail.com>
References: <cover.1584428736.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SD host controller can process one request in the atomic context if
the card is nonremovable, which means we can submit next request in the
irq hard handler when using the MMC host software queue to reduce the
latency. Thus this patch adds a new API request_atomic() for the host
controller, as well as adding support for host software queue to submit
a request by the new request_atomic() API.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/mmc_hsq.c | 5 ++++-
 include/linux/mmc/host.h   | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 59d2776..fdbaa98 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -41,7 +41,10 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 
 	spin_unlock_irqrestore(&hsq->lock, flags);
 
-	mmc->ops->request(mmc, hsq->mrq);
+	if (mmc->ops->request_atomic)
+		mmc->ops->request_atomic(mmc, hsq->mrq);
+	else
+		mmc->ops->request(mmc, hsq->mrq);
 }
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
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

