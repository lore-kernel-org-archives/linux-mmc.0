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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A69C35254
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 12:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686E32082E
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 12:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJusQJKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBEMv2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:51:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33402 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBEMv2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Feb 2020 07:51:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so1188210pfn.0;
        Wed, 05 Feb 2020 04:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6hpkny8N/XZM7wZK5JpvEfe2AHXPpO8aqNteI1qybns=;
        b=hJusQJKJ3dMO68YWd/RkVmXquAcSQCouv+XJYUHwrjq+Ec5w/GLEVgFg/ymRr/W07j
         1dDKHA4QuTspdrU82bamvjc8HNp76lvEvEH4OuaxAurErXqtCxF4NqBu7fSTKsz2HzR8
         PnGbzgi+nw4onNaIVPb/H+RF9OHbaPihw6zMjrU8Umb1ujstnxbQsCxrnHWhG+XcG0mh
         SodEOQOxj+fAxFGA16q1NFzWrEBEmf2Ha61Q4vSMqLq12xJ9VG1y0nxUql0MmGbILeoI
         je0w7F8LWcO1Q0iOi8pC8zQgY8cdy/nWB9AeQywoQzCELmcIWFkyjHU+yeXYn3Zow+tc
         p/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6hpkny8N/XZM7wZK5JpvEfe2AHXPpO8aqNteI1qybns=;
        b=h/LYMNSUQM4rVpohzjdFTGpmg+xGjp6ceB1OLL34VMjNQnVO14PtpvYq7IugH8JOsN
         RgDldQSK0zOqb1CA+3Y6MmRI7hGWzyVkrkdr+dUep78D5dm2uXy7IENwhu/qlckFkMi7
         0Kd1OCPy5prIhwx2XoURSEaJPJX5xJT1kiZbdWdQCZwZwkCV79e/1aOlpDDtF4TSvgi6
         3uH2iacXKZ4p1tjg99MOupq7PUqQrc/fI1NcUX7zqUNfFehGII13yMRTM395Gw6sy+Vz
         mFAbQI9pL5yiQADgHmJj/tCr+KXrAqlsKfC8mklyHiHQAITZAX7GvXu/MObr3p3Q/ZTW
         ToGw==
X-Gm-Message-State: APjAAAX4xT/ugvaAvX4kuvj0bj1zzwJFG+aYvNA9cv8K3rMzivGlU0OV
        74Vogi+MDQRZx3BXWhdAUxw=
X-Google-Smtp-Source: APXvYqw9idXFBSsT2xdvOiIRwSJPnB/B0HjeQJuBKo2i8fBwcpNqyp3vAtg3WzJp921F+ZoJTl6mhQ==
X-Received: by 2002:a63:c14b:: with SMTP id p11mr13707443pgi.290.1580907087478;
        Wed, 05 Feb 2020 04:51:27 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y127sm22864784pfg.22.2020.02.05.04.51.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Feb 2020 04:51:27 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/5] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Wed,  5 Feb 2020 20:50:30 +0800
Message-Id: <825d6f7b69393b4bc11fc3175749d46a0a495496.1580894083.git.baolin.wang7@gmail.com>
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

