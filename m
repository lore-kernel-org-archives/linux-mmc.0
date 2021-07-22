Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17025C6379B
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050FF61241
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhGVDWN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhGVDWB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B46C0613C1;
        Wed, 21 Jul 2021 21:02:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o8so2973500plg.11;
        Wed, 21 Jul 2021 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGhpNbXjKkULU4t1oSP9LihFc2uO9bsLN2xlTwKncGQ=;
        b=iNjg6RUphomtTC4PFaeGwZeYq19C02HLmnMgiVrvoa8C0aT9r5cwiGWa9ZQQsVGXZ4
         Zt7pPOMQa58xuYVhiRhbu3xtGYMvN6H70HfnQmNTANWzKbAcg4kQRA/XQb6DQ/xYoGUt
         otOHBf1Mct6bI12EDL3p05rrIEsDVzTMrwlNCC3786Dy+R64T69yNxzLMUu+mE9kocJT
         yKXKwdU0xqRFbz1AA8QqFFUyLBN5xu/GjnuIbpR0fC4V0DI6WDxNKeJFNvdOAJvenvO7
         XuuHJB6C5FkZjGDjKx5Y/snbYzK6MwxZ2Zx4T0xU0o5aYsCM8Y7uuBR0553pEbHl8geE
         hoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGhpNbXjKkULU4t1oSP9LihFc2uO9bsLN2xlTwKncGQ=;
        b=e2BxYXsBik+0Yg/elyfQQ0/L1cnqnUTP8QUklSM0Kn14xOtX9DNGxYSxQdNCuEwqO1
         GabDAGuCvNY+Xud6Emil/FZhUMjCz64XL96haEPjTFYVoxC+bBWx9G+uaXZdzXhjLDKi
         Q1RRR9skrWjdTVL39WGO3LWRTFodzAM9y3nl7qzZnaVC0RajDy43fktA/O+X4hVVx+El
         Git3i71bIa90YKTtgC/N0oqp24JUCu0heTA1f22BD2LKnBXvZglTbnOm/DMYhNGrMa95
         bpMnNoLIYU8K27URbgraHsvLVZhZ8Gmhqww02KLi55ucHcv9cpz3qbG/tZ7LV1KSdJ9X
         /Cwg==
X-Gm-Message-State: AOAM530lZCOKUvXPEdJIqmEpTmFYkM12FGPcwuCWKu33TVY5gb+0YFUj
        xMUq3gHV+KiCbfTrO0RsQCk=
X-Google-Smtp-Source: ABdhPJwu259mPUixEt5btD46qtAMquPui9vw1tjjwsW4nQwZmas6RBzHfqtXs5cJRH26oT7XXQr6Iw==
X-Received: by 2002:a63:f00d:: with SMTP id k13mr39695102pgh.260.1626926555791;
        Wed, 21 Jul 2021 21:02:35 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:35 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 23/29] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Thu, 22 Jul 2021 12:01:18 +0800
Message-Id: <20210722040124.7573-23-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 5d3362ea138f..3dd81c89d8f1 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1631,6 +1631,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 	DBG("%s: begin UHS2 init.\n", __func__);
 	spin_lock_irqsave(&host->lock, flags);

+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b1d856664b58..4e2cb73a63bd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -723,6 +723,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };

 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--
2.32.0

