Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD5CC3F2D8
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B320121739
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufYK1K9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgCDHma (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:42:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45368 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgCDHm2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 02:42:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so637262pls.12;
        Tue, 03 Mar 2020 23:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=it3guJ5dFp5vGJJ3WdR2QDpXIeH4iEb/WDqIOW8QOj0=;
        b=ufYK1K9oUVpy0N8n3AGnWbbBrGDrUFdeomjPqOQrBkg6aoyOStFwe6InacQZgqfiqh
         SHVji1MA71YoofKWTDY9aqI3wH62mQRozrA9NPbBF9Gu3oyN+j3uEmGgnLH5O24DXUf9
         Xt0/dj+VN6Qw7HbM7BCDZkb9g1cxgZ1ZJAbvUt3kTUPCr4/+OILKrg66zPcygV+yvYje
         u4tTbLOM3gs0g9nrvb6sJJ9zMj67e9ccqbr1Ut16JSgtTpVFW6HgAS0F1A1zpqyyBjMj
         9zfR/pb+Q1S6I9jTjdY9pjvrDvr7yFexH8gn5ZY4MzDaoQtfUoFHcMAu2FyQO9SJfRHT
         P1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=it3guJ5dFp5vGJJ3WdR2QDpXIeH4iEb/WDqIOW8QOj0=;
        b=rcnlzHcIx1U4glKYljOk1FWq/4FlKN4kH7Ej7Epnx3Jb1Hswfb3q0yqK2I7x9xhuDG
         in1nweiAwYV24uRNXI7gHtdQO0vAWHUmukF8Y7sn/GGi3ItrXIV1fbQ3cXj2zeJQ5L0l
         82ZZwHYJ27Onx6iolvob71iyi8DdMbZMObRo+l7dJlIpjA+tdydgOHtfZwBQJmYGuUxW
         54YOZVJ9MwNLiJn+JTuzMrS2/Kd5+y+bpQDzDxbMZ7Knyf3PdMM7n+9AQnLBCWbyvKr/
         B0jLpfz85drOjf7pQSiBsuBlxhs6tmRcDUi9Yb9hL0XEw/h0JA8AZ+BnKVa2nGN369JF
         qmIQ==
X-Gm-Message-State: ANhLgQ33QBuxCQXwP+PJ4cHIjy8Gwn080OpjdAywBgeG6g4yMu9rRAbo
        o2mihn+bf49RcmVgGCsLjuI=
X-Google-Smtp-Source: ADFU+vttazL7JlzKuoQKtfLElt+HJ4rCq3A25Yo78vexH8anuP8wJBQwwn3hJtEZuboUwjXUsn0Wjw==
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr1842230pjb.193.1583307747064;
        Tue, 03 Mar 2020 23:42:27 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k24sm24097374pgm.61.2020.03.03.23.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2020 23:42:26 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/3] mmc: host: sdhci-sprd: Implement the request_atomic() API
Date:   Wed,  4 Mar 2020 15:42:01 +0800
Message-Id: <b6c0c003d887bf7c272c493212f4f89d28097ad4.1583307441.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583307441.git.baolin.wang7@gmail.com>
References: <cover.1583307441.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1583307441.git.baolin.wang7@gmail.com>
References: <cover.1583307441.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Implement the request_atomic() API for nonremovable cards, that means
we can submit next request in the irq hard handler context to reduce
latency.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 2ab42c5..bddf0f3 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -426,6 +426,27 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
+static void sdhci_sprd_request_atomic(struct mmc_host *mmc,
+				      struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+
+	host->flags |= sprd_host->flags & SDHCI_AUTO_CMD23;
+
+	/*
+	 * From version 4.10 onward, ARGUMENT2 register is also as 32-bit
+	 * block count register which doesn't support stuff bits of
+	 * CMD23 argument on Spreadtrum's sd host controller.
+	 */
+	if (host->version >= SDHCI_SPEC_410 &&
+	    mrq->sbc && (mrq->sbc->arg & SDHCI_SPRD_ARG2_STUFF) &&
+	    (host->flags & SDHCI_AUTO_CMD23))
+		host->flags &= ~SDHCI_AUTO_CMD23;
+
+	sdhci_request_atomic(mmc, mrq);
+}
+
 static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -561,6 +582,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto pltfm_free;
 
+	if (!mmc_card_is_removable(host->mmc))
+		host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
+	else
+		host->always_defer_done = true;
+
 	sprd_host = TO_SPRD_HOST(host);
 	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
 
@@ -654,8 +680,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_host;
 
-	host->always_defer_done = true;
-
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
-- 
1.9.1

