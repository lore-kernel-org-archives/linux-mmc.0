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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3C7C4332B
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B501F20753
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brNWfESJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCSKz0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:55:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35154 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgCSKzZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2020 06:55:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so1241841pfb.2;
        Thu, 19 Mar 2020 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=X5441Jy2VbGV6dbzgZxForefu3q50NuP2ovt+obRsE4=;
        b=brNWfESJSuqO+4+09IIvPRsaedOM8E/pS6J73eUynhP08GAvpMo/aK/w8QFA2Qg4bE
         roRO7HwQklcJpIqr8DjAl101c1rL3bCjonnjy21/3z0aZVIEGqxms6VjEBh9/zeNBgDX
         0/i9r9yIF5mn5kA2/nudMZkZ9I5SBLDzJrCIwrUpjNS6d1lbaQHkpDEsevmhXW9xPSvd
         L4K7qOZ3LX5XksSK7+b0jsbddBkE1gCFTegQVUeAci6TtPWImJCeChHjWECuPSrK2wBl
         1lmbyImG54W9cU36DqP+5dkLYxTNLBPHidlVPVz4E/Ponii9ozXALQnCvcfZZwo4qIuM
         ntVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=X5441Jy2VbGV6dbzgZxForefu3q50NuP2ovt+obRsE4=;
        b=VIRpZzMVZ7/H6Kvfoi/rwlpzZ53RsCY65LE7lFsEXNPpRjUkjW5ZJcKN67G0P2/MQ0
         WEEDiztk7ODan6Sv+BIscHccDk734chB3ZxAypKnBXONg1/a70D7OGTSNXYsmI+a0eVg
         v9lfvdvht3wWq8+kx/pGLvrgj1qLq1yVBiqSbjwTcZzeFuWiXuWr2YYheYnSkTIx1Fzh
         oMd9Cz84bu5DB10pxibysBhxDt+0SRw+Ht7KCiTDpddVsFGrUG5V1vGLIc810N7EbPcJ
         HrU1MxF6Evk96EOvsQV4bmlO6Q7SDDc80RvnQpUtszEJBP/fJZCRWGNG5pFhIfpyr2oX
         UWHQ==
X-Gm-Message-State: ANhLgQ0GgNGdIISeZp1YY1bQmO/n5Jpdow9fVJIszp050rrWPXrPLsI8
        v804HU/4Qk1aEHpgiaxfSkM=
X-Google-Smtp-Source: ADFU+vvwr8HV9kNS8ey2y7NUz400nhpNIeCWQcMYfi1GWHsCIpQjBM3WTOp+//wfnfqtqKg2GfParg==
X-Received: by 2002:a63:7c5b:: with SMTP id l27mr573245pgn.414.1584615324647;
        Thu, 19 Mar 2020 03:55:24 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f6sm2209949pfk.99.2020.03.19.03.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Mar 2020 03:55:24 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] mmc: host: sdhci-sprd: Implement the request_atomic() API
Date:   Thu, 19 Mar 2020 18:54:22 +0800
Message-Id: <2a7469f93323b6fc80176affa92f9396942a56e3.1584615043.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584615043.git.baolin.wang7@gmail.com>
References: <cover.1584615043.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584615043.git.baolin.wang7@gmail.com>
References: <cover.1584615043.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Implement the request_atomic() API for nonremovable cards, that means
we can submit next request in the irq hard handler context to reduce
latency.

Moreover factor out the AUTO CMD23 checking into a separate function
to reduce duplicate code.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 2ab42c5..bc7a8cb 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -406,7 +406,8 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	.request_done = sdhci_sprd_request_done,
 };
 
-static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
+static void sdhci_sprd_check_auto_cmd23(struct mmc_host *mmc,
+					struct mmc_request *mrq)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
@@ -422,10 +423,23 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	    mrq->sbc && (mrq->sbc->arg & SDHCI_SPRD_ARG2_STUFF) &&
 	    (host->flags & SDHCI_AUTO_CMD23))
 		host->flags &= ~SDHCI_AUTO_CMD23;
+}
+
+static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	sdhci_sprd_check_auto_cmd23(mmc, mrq);
 
 	sdhci_request(mmc, mrq);
 }
 
+static int sdhci_sprd_request_atomic(struct mmc_host *mmc,
+				      struct mmc_request *mrq)
+{
+	sdhci_sprd_check_auto_cmd23(mmc, mrq);
+
+	return sdhci_request_atomic(mmc, mrq);
+}
+
 static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -561,6 +575,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto pltfm_free;
 
+	if (!mmc_card_is_removable(host->mmc))
+		host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
+	else
+		host->always_defer_done = true;
+
 	sprd_host = TO_SPRD_HOST(host);
 	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
 
@@ -654,8 +673,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_host;
 
-	host->always_defer_done = true;
-
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
-- 
1.9.1

