Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01378C48BE5
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Jun 2021 22:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65E7611CE
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Jun 2021 22:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhFSW4X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 19 Jun 2021 18:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhFSW4U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Jun 2021 18:56:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A63C061756
        for <linux-mmc@vger.kernel.org>; Sat, 19 Jun 2021 15:54:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m21so23206445lfg.13
        for <linux-mmc@vger.kernel.org>; Sat, 19 Jun 2021 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4O/PSg42XQGCFuaHFKksTpyRyVdPtGQ1Rdj/uH+UqA=;
        b=nnYlDJV7lF+OmF4cNajdGrn/NgWZCzgPHuiMJ6lnF9trRrHXMMVKH3Oz5wxIAQ4wtL
         yWDMKhycSDwRyaXkkqMbWfBNO8gx2Xb10I3oJj2DXSEfc4Savwni3KUB7Canea7IIxyV
         GHzv/DnGmUTzfnEQQ+mktoaFSHMlikRuhnTYXhRAwFoQ+Fkjfuk/WIK6LQ263lLa9gB4
         9IRJgsWJEh7YDr5C0W1QAXr9m/vcKluRI+zDHzXpo+lF+q+6abBuygU88yFGxUcbcmM+
         qqxzA5BGaNVXOOhyVd+xQvd3JB6oIDmlxOcbtdJDczSa4Qhq9DKBGO2zYWBqTred8cdO
         wxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4O/PSg42XQGCFuaHFKksTpyRyVdPtGQ1Rdj/uH+UqA=;
        b=CD7dSJ7kkCpohzv0grRzbAbCqmPqDsknu2hkR3RnWfQG+XKU1AnmRatuLMKXEbNF23
         Cwykw+s3xYv5QL1GWmE+Mwr+NnArZWwX9e/llHXNNrEh3CqKmxUWhPHMGJREE9Z4TtdY
         ZWJ1GYdIZiLlBvfDZ37hkHMFqnYGd8lQ8rpqOfqtls2l7Mzp05rOaUKsriksRMrn/RHq
         /jYDqS1hjaZmthe/4Egj/AvogmMdMKNWQ2bYHVO6Bir8lWJtT4AH4vTkSXOpiOn1XApE
         DiMFdWvYLztriZRDANlBdt6JEmV0PNuAoJ+Ilo+soX1R2vEQXVWUpDPRsrSuxB5mHbmw
         v/tg==
X-Gm-Message-State: AOAM531aOKUhkKXZ+OHUaB3TR++25tVpfi442GN71jeJDhv6yqxQrPqE
        IGjTWk9yEy2Ue80kaDWeBIqDwhvzcNN2Ug==
X-Google-Smtp-Source: ABdhPJx/8BYkA1itRd9EkHdffaoBBmdv1/7DP9nf3fN3rbiSuIN5DO6SRDSexBhDEhX5N68VZ7w6+g==
X-Received: by 2002:a19:c753:: with SMTP id x80mr6935805lff.200.1624143247150;
        Sat, 19 Jun 2021 15:54:07 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y5sm1345349lfa.148.2021.06.19.15.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 15:54:06 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 3/3] mmc: mmci: Add small comment about reset thread
Date:   Sun, 20 Jun 2021 00:51:18 +0200
Message-Id: <20210619225118.1862634-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210619225118.1862634-1-linus.walleij@linaro.org>
References: <20210619225118.1862634-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Put a small comment before assigning IRQ_WAKE_THREAD
telling us what is going on.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Yann Gautier <yann.gautier@foss.st.com>
Cc: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 97fa5e67ca0c..b646ba7f4e10 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1394,6 +1394,10 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	} else if (host->variant->busy_timeout && busy_resp &&
 		   status & MCI_DATATIMEOUT) {
 		cmd->error = -ETIMEDOUT;
+		/*
+		 * This will wake up mmci_irq_thread() which will issue
+		 * a hardware reset of the MMCI block.
+		 */
 		host->irq_action = IRQ_WAKE_THREAD;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
-- 
2.31.1

