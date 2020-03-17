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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E553EC18E5B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFE62071C
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW6deAEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCQKOb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:14:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43674 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgCQKOb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 06:14:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so11459164pgb.10;
        Tue, 17 Mar 2020 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=unr3k2tfwI2GqRohsFvvT8LxV6+FWELnFqCEg/uISRU=;
        b=VW6deAEGfLYbY7pS6MtMsUncuzhTbxcO4qKni6upZKof/ofZXI+1u0W3aK9al4MPug
         F5E05y6PMNqPlPk3l2Dw7Qy9mPI4eGPghQ7eBfaqmH7o7EXTY944XoipebnA9jSgLdtr
         jRRC1vsQS3lwxbV98io69ZRCUTk8bxOV+gJH3HInXmMLk9x5Wpy4s2/QTY4mzdub/f/O
         KEqTo0MOHyDMU8s4TOh3Ikr7+02Y8YtGQ2+nJ4QL5wWsTH6G3F+vKrB79pJgI4pTu4Nq
         WSrY107HREU7h2nWywPMPo8hUddKJ5ylEQfh06CcmAJwUFLW1NM1+W5QoGkKNcX3X+8T
         Uvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=unr3k2tfwI2GqRohsFvvT8LxV6+FWELnFqCEg/uISRU=;
        b=FMyO8Mj4VF0CDDJBulZrRS8GScbfc2H9pmTdAs0MkS+4y6mBkKhL/bqbv2QPW6xqHh
         ZNafCRBM2yrk1eVQz4NWDUwUG58+JopTNZ4QwyBT9bzbbqDst34jSWDzSWxDOT9o3AQ0
         Fdo9r0SKcgl6LUoGTOT8scPmMNgngJkE/7KJrvA09Qlp3rWmwCFM2MdFfaH4L6vXkJuc
         /61ktgvcEjwPMQspzLWiZsQfzBSV77s1els/qaM1AMPUfu9JtWgMlf0sAaQL+bFs54Xx
         BVAY+5dmeZoeoGaeLYJS/Ni79oTRlM4ijmVIu7S8oBDlj/bQzOEKHyu5o9YIauQxLiyy
         58OQ==
X-Gm-Message-State: ANhLgQ3XRbAYTPsERzdxErDH6yMfLbWpg4W1NNUgsICJFas5fICe18lZ
        EjKo/XBOkbzhrnXF6eEB87Bx3IWNLvo=
X-Google-Smtp-Source: ADFU+vuVmuOuaOQmHeXtRiW9FzeySr1ANKAzEBgX0qkeji0WpiinCnOTkUqYSe6sDFp7M5g2mIWb0Q==
X-Received: by 2002:aa7:87c1:: with SMTP id i1mr4521301pfo.297.1584440069616;
        Tue, 17 Mar 2020 03:14:29 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s25sm2195487pgv.70.2020.03.17.03.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 03:14:29 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mmc: host: sdhci-sprd: Implement the request_atomic() API
Date:   Tue, 17 Mar 2020 18:14:11 +0800
Message-Id: <8cc959db07c9f9dbcad5dfdbffd78760c06f1c7b.1584428736.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584428736.git.baolin.wang7@gmail.com>
References: <cover.1584428736.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584428736.git.baolin.wang7@gmail.com>
References: <cover.1584428736.git.baolin.wang7@gmail.com>
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
index 2ab42c5..9a08f70 100644
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
 
+static void sdhci_sprd_request_atomic(struct mmc_host *mmc,
+				      struct mmc_request *mrq)
+{
+	sdhci_sprd_check_auto_cmd23(mmc, mrq);
+
+	sdhci_request_atomic(mmc, mrq);
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

