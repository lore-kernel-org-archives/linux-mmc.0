Return-Path: <SRS0=9sJp=55=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5386EC2BBC7
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:37 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234A620708
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKC4RlA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234A620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgDMCqf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgDMCqf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Apr 2020 22:46:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C99C0086D3;
        Sun, 12 Apr 2020 19:46:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so3882803pgi.5;
        Sun, 12 Apr 2020 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tnqE8PEqqE1BRJn6nGWZTUwVBt6LXnaUqshkgnwb5Ss=;
        b=JKC4RlA0I5ioGbFK2YWXszKo1eYASbnBVQaV0jyDXUyKbuaX1QfL9EgmlJk0b9/Z74
         +5hPsr9+mtRim7QXQlNmdKajwcVYjLEvdwEi8dGzmE7pUe18VgJpih9NbPus1zBg2b+O
         Of9mo/jzuH7mtMyyVLNnX7EgFaixx2gfuPDB6TA+7l++1Y6G3D3fo029tmx/3JR3zWmD
         SEbI1S9YNmZbeWTmm0XaG/bFCovQN/yACoW2Z3Lzx4a0jQS73flM+PPfKa+2hFVX7Q7T
         xz6q9tjbe+5+/598101LBuHj/e4g0CegOkONy+qqYJJsACRkSiA09wlxCd7vdQFwpr6s
         sBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tnqE8PEqqE1BRJn6nGWZTUwVBt6LXnaUqshkgnwb5Ss=;
        b=mZLQiYkWensLWzFWhr+dyfxlJV+V+7mxrT7n2uPTxyOA5HZGlyuTpJZOGxbA2a4L9p
         iYAGZeFKwqssG5xc+PohbEFYzAj19+aShccsU7Rl1d5+Q/8iPyCOAtpm6XEc5ibhFhOF
         u3n1bvs9Nt1/YPEUF3+kzBoxtPujUJRWrvd9P/3msuA/GSmOAOdXfHBQ2Wxh/lrBw9lg
         8CbsPYRYIr7gUQPCJnQ7G66LdJiJMpBYKi7pXcbE88b3Fh0VzQaFvJaF2LnAAfjxpR/u
         3gGzo0TTv3KpRnLxKjsFxFalnbKiRxPdMw3Z96YzYmHp0c4QP7il5v2BzeJmQ64TFIJ4
         WLdA==
X-Gm-Message-State: AGi0PuY8pobK+4DA7RCgWDG9JNl+yLGZgG5KpUr2eivuNQ36q1xtAbYW
        3wdA0zFAaTP3ZiJrfcBc/zU=
X-Google-Smtp-Source: APiQypJH5BgTFOWeJiaGKc45nm2kik87Ll6tco0vNzX1CBGvtUntoOdUHyWd/s+SmvtpDhdOFiO3Wg==
X-Received: by 2002:a63:fa0b:: with SMTP id y11mr5060865pgh.334.1586745995228;
        Sun, 12 Apr 2020 19:46:35 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id i15sm2327882pfe.197.2020.04.12.19.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 19:46:34 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, baolin.wang7@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] mmc: host: sdhci-sprd: Implement the request_atomic() API
Date:   Mon, 13 Apr 2020 10:46:05 +0800
Message-Id: <60142fe6c6c1dbba2696e775564ae2166786f0bc.1586744073.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586744073.git.baolin.wang7@gmail.com>
References: <cover.1586744073.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586744073.git.baolin.wang7@gmail.com>
References: <cover.1586744073.git.baolin.wang7@gmail.com>
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
index 2ab42c59e4f8..bc7a8cb84862 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -406,7 +406,8 @@ static struct sdhci_ops sdhci_sprd_ops = {
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
2.17.1

