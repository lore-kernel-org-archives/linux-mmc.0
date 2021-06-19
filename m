Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9813C2B9F4
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Jun 2021 22:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C65161183
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Jun 2021 22:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFSW4X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 19 Jun 2021 18:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFSW4U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Jun 2021 18:56:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925FBC061574
        for <linux-mmc@vger.kernel.org>; Sat, 19 Jun 2021 15:54:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u13so3921620lfk.2
        for <linux-mmc@vger.kernel.org>; Sat, 19 Jun 2021 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSV/mBbqmIvRpaPtX9Y4vVykJHKsnTG2qhsD896N4Qc=;
        b=j881TjQ1hJ1/WDFdJDzEykNhyEERfWapEGoMbqBnaGFjSypPB3XEZK+CSOdTG8kPRj
         ApmA3BlujhkYrhBOPOOC7luaBqVf3a1JQ3/FwaIBdzyXP1gj1tWbPw+4FSh7p8QzeQeF
         60CkM5y4ov/nNuq5if43cAlK1oWotF7iTyNG7aPp6JGj7Nj0KjpDDjzAeemiofQQDxUj
         uKxxVzpR4jqadqU3hdRKYlzUXx/vDvG2Fdj5BwUpzUH9lFHrTKSUw3s3KII0+5W+5chF
         9Vm28MV/rPlX4HtTajfpLfpXQsbRumdU47D3k82Cv8Ihnwmvbg+6PLEcjzVJZLV352+F
         SDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSV/mBbqmIvRpaPtX9Y4vVykJHKsnTG2qhsD896N4Qc=;
        b=hDw83t4jmmHVa4vpt687b5Ch1rGp2LG1sQBRo1LSxGwjsReQgiCtlvkMxfI5mK8l8S
         M/5/BE1fsOudWZ93acePqSL4GQn+E08XBs1D3ZE2agNIk9cMCCA0zTvZVX0nYwuCi4Ln
         2TzDKPt9Ebgy6BW8t8qRK7e9L8jJknGbw7jJLcwFio5Xm2PlPboeHdk37AqKIlZD+2PN
         6K440gMg9Ue5o341NyjEO3ptukIzDPpj9cUKCUSJZMniYQfaWN9C21/mZkeHm/woOOx5
         pS3jgthSUrLELKOdrVT/1t+3JD1mpNUPWIXdT6ck2o63sKqxGOsnNXV+18gZqBUZrPbM
         Sldw==
X-Gm-Message-State: AOAM530HhjaZOHtvIE68rotUvOzGHkdo8GXFjppyMoz9w/RoH0ZD45q1
        TkqqLx92Cf8lQRETItxUtxjmzu/M4CeFkQ==
X-Google-Smtp-Source: ABdhPJw/xa73/4a/nhGqj/1sku26qmY/Q2RSrfn0HKp2aDr/sZAZNV3vsR8theUgnQdJrida3oOjgg==
X-Received: by 2002:ac2:54a9:: with SMTP id w9mr8476711lfk.11.1624143245831;
        Sat, 19 Jun 2021 15:54:05 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y5sm1345349lfa.148.2021.06.19.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 15:54:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 2/3] mmc: mmci: Implement .hw_reset() callback
Date:   Sun, 20 Jun 2021 00:51:17 +0200
Message-Id: <20210619225118.1862634-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210619225118.1862634-1-linus.walleij@linaro.org>
References: <20210619225118.1862634-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The .hw_reset() callback is optionally called when attaching
a host if and only if MMC_CAP_HW_RESET is set on the host,
which can be done from the device tree by putting the flag
cap-mmc-hw-reset in the DT node. This is sometimes helpful
for eMMC.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Yann Gautier <yann.gautier@foss.st.com>
Cc: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index af2ed6013ef9..97fa5e67ca0c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1883,6 +1883,15 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
+static void mmci_hw_reset(struct mmc_host *mmc)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+
+	reset_control_assert(host->rst);
+	udelay(2);
+	reset_control_deassert(host->rst);
+}
+
 static struct mmc_host_ops mmci_ops = {
 	.request	= mmci_request,
 	.pre_req	= mmci_pre_request,
@@ -1891,6 +1900,7 @@ static struct mmc_host_ops mmci_ops = {
 	.get_ro		= mmc_gpio_get_ro,
 	.get_cd		= mmci_get_cd,
 	.start_signal_voltage_switch = mmci_sig_volt_switch,
+	.hw_reset	= mmci_hw_reset,
 };
 
 static void mmci_probe_level_translator(struct mmc_host *mmc)
-- 
2.31.1

