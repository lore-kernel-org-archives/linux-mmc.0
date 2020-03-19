Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C53DC4332E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022DB20753
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uju42OeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCSKzS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:55:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33627 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSKzR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2020 06:55:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id g18so920516plq.0;
        Thu, 19 Mar 2020 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RnuPX1r2mFAI/A72C+v2CFVMojx/n50SdvshtlGYixw=;
        b=uju42OeHSKtnyKRnPW1/YiV8qcIg56COqPIBfv6T0yM96+14MRNYNXhO15JGSNMSJQ
         DAXxYbt/6N1eJA1CGoaTGvUvlTfWDeH52NsRlvwn7pfVdCTHbYyAPQs3YLA0ceVHJjgD
         y+RUtHvZvHbCpm6wtolwaRdlQr4WdvO/CaGVZmdNzAKFsYeWikHi3OnB9xZuuzqa6ZK/
         zUrYwPK9HcWfNbeEhKGn+trtatj3cjrD5lHmPGj7rVkMQ/PpcccYIq1fDgOPmC6vfY5q
         MglNkGGihIVKEdvJZJ9oNU8ttpsCOqv9+Aiw5uaxHJe5w2TrHJXA2hvAkGL3exWRKv3F
         +5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RnuPX1r2mFAI/A72C+v2CFVMojx/n50SdvshtlGYixw=;
        b=W5KeSwyi8pwjCKgp1UO0tjlJRpY3cBolLKDuaKmEqSAl3lsS3xsyaB4LnqThMF9ISr
         Hk+q08NKz5cMTUpxxFjUQUyCCuZ18H9z0Xs65iJtWE7BuuAOE+JUWueMhtdodqK+WfQZ
         5fJmv1huaRC0eBWXfy/+nRiUhzWrMqwbBjsOlV47ZagFyXyj0SATHpWMSFZO+OjYzwc6
         KebfTPSDjTblbAOeFF0zEtUkN7wi99qJorY6PhrLJUmBSb4yRg6njB8/1UMpA8RFZGQQ
         gkBl2BKOQDWsdREg+LHW+1GsYb3CefYbWDi0eBwOBIKYH+ceLDsxmRhuxR79rB1ScI0C
         VJbg==
X-Gm-Message-State: ANhLgQ1bYmTxrMf3/vKEbt/qLg7HHb9dV6ND+snGmld7sNlI2eKgGFFP
        Fhynk9vhYpEi9cO4Qc/+r+rGRV14
X-Google-Smtp-Source: ADFU+vuvIE63is1kB36eE0cb1LIYFHHZbai9871V3uGGAcY1un7kWo3JvaH9wsIRNYjOxXUS1C8C6w==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr3072020plc.216.1584615316285;
        Thu, 19 Mar 2020 03:55:16 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f6sm2209949pfk.99.2020.03.19.03.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Mar 2020 03:55:15 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] mmc: host: Introduce the request_atomic() for the host
Date:   Thu, 19 Mar 2020 18:54:19 +0800
Message-Id: <cfab9b3d78487ff02e1df087457a7716f337af67.1584615043.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584615043.git.baolin.wang7@gmail.com>
References: <cover.1584615043.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584615043.git.baolin.wang7@gmail.com>
References: <cover.1584615043.git.baolin.wang7@gmail.com>
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
index 562ed06..787a7b5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -92,6 +92,9 @@ struct mmc_host_ops {
 			    int err);
 	void	(*pre_req)(struct mmc_host *host, struct mmc_request *req);
 	void	(*request)(struct mmc_host *host, struct mmc_request *req);
+	/* Submit one request to host in atomic context. */
+	int	(*request_atomic)(struct mmc_host *host,
+				  struct mmc_request *req);
 
 	/*
 	 * Avoid calling the next three functions too often or in a "fast
-- 
1.9.1

