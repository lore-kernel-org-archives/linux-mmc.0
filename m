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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9460C2BA83
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8342082F
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGje1dO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBLEOO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:14:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44943 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLEON (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 23:14:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id y5so536964pfb.11;
        Tue, 11 Feb 2020 20:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6hpkny8N/XZM7wZK5JpvEfe2AHXPpO8aqNteI1qybns=;
        b=fGje1dO07f1Gt0n6q7nS8B4mwwcgFuXTqw8LyAV5iardHQoQ5ZIWVotTNdrS2r2bfT
         kExfRqJ/nKgvbZDO2llJ5FPXLel9NzbVXk3mob1qc+j9z8vYbAlCQYY3T27JvnwtCssz
         fvhjNgkRFxtk0hh1RVc1Ek69KU6KnDdJi+U4+MNQHimldNUQ7ddVbl9B7AvEAB/3/1rk
         JGEfbGNj9yjA4f5NsUhkWX6RvCpnrKiNSEcdM8Me8YKXRyUYeAIa3ZoxqQEBh7ey47Gh
         miBwKZk2fjbDwAvDHg6A9F6lL+ihtA4JVY/NTT5x+uxu3N7h4Hctz8aLwG/6RwkHZlfr
         tKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6hpkny8N/XZM7wZK5JpvEfe2AHXPpO8aqNteI1qybns=;
        b=D9qgcWNNIUDlgEVaClu10Me3QKW17wrEkcvNjIbM0yxhd1EyOSuJnNnjlWrOXf/WRk
         iy8n45TUdlkh1U3ABzY6w5+dJdro4g3UheYW34KL42JlI0iMWz1g1xI3WkZGeIZh1v6U
         TWQxTZm+bxOmQOxlLxI1qdcUUYeNKvhgB/m2mb2rgPl9hA+lbnBwk2u65JLYhxoJKCFv
         VqGj9lAevfCSmCQFFc1p36NFwO/WyZVopEKTG1qiNDzdFrahOprWNaPsAMdjKyAvPH4H
         t31MLBHLw/t8xxy0pMyZvQ6EjLk/f8yKS0tvlP2oDoN1YCGe6LfP8qGbhZbUevQhncqW
         eZwg==
X-Gm-Message-State: APjAAAXQnQm05n9bUe7NJbJPc7yX9464m4GBJaGovGIOKmoPFBa4qwh+
        8Th1g7EqOtWa7BNyIgt+c8A=
X-Google-Smtp-Source: APXvYqw1a5Z7mtwVhQrcG83kOcIfUuR8b8C+xr9H7xG3ihh4PleHYv01FR1yxya8oUHQY1rMRSamYg==
X-Received: by 2002:aa7:9f90:: with SMTP id z16mr9989008pfr.161.1581480852743;
        Tue, 11 Feb 2020 20:14:12 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm6424762pfq.27.2020.02.11.20.14.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Feb 2020 20:14:12 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/5] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Wed, 12 Feb 2020 12:12:58 +0800
Message-Id: <1539c801c8bbdbcd1d86f8c2dab375f5803c765a.1581478568.git.baolin.wang7@gmail.com>
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

Add request_done ops for struct sdhci_ops as a preparation in case some
host controllers have different method to complete one request, such as
supporting request completion of MMC software queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c |   12 ++++++++++--
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 63db844..9761981 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2944,7 +2944,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3372,7 +3375,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	/* Process mrqs ready for immediate completion */
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
-		if (mrqs_done[i])
+		if (!mrqs_done[i])
+			continue;
+
+		if (host->ops->request_done)
+			host->ops->request_done(host, mrqs_done[i]);
+		else
 			mmc_request_done(host->mmc, mrqs_done[i]);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a6a3ddc..3e95f74 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -654,6 +654,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*request_done)(struct sdhci_host *host,
+				struct mmc_request *mrq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.9.5

