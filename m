Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D313C55179
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EED2075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1z2N16N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKFC2x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgKFC2w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:52 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC51C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:52 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z24so2784764pgk.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gw23cynGhAlflQDyTMofyXMllkXqVf/0B/dwjMVvO+w=;
        b=R1z2N16NQiGQlvVoAejbufG6UxgrvnB7iFdNqMyvnKqcNmjic7u7LCa9ae1KlHVA9n
         cddAI6mznGgYnBJiyOBXazMDOehhqYyZnw/73e2WIVWGLIIihVke9HgZKYLtlnSHVF45
         dgSjsxfe2qVf5b1+PK0qQ0OPAgpO5OnqISOB5bdhQANSN+uSvdFgji7RpZmQWuU/FZnb
         KdKSfUciYc6LqEkMkQi8GfUqX14z2Dniz3KPgKCVHlGo6ocqTDr0xZRjjzzjgLcfvzrD
         rPm0lVBcNZo1CNKNUhQjzYDiXrucHgM+B/SGoG92LclzT5t9HBMqH5CqYPogxMuFzraQ
         t0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gw23cynGhAlflQDyTMofyXMllkXqVf/0B/dwjMVvO+w=;
        b=k6gepy44EbxAb8hJ32fIBALs2NhHByvxGKn7sMMuNP90A6ilUSfX0mnKqJbWpaIsTk
         pu3ujDs36/1BIRga/znvCTNJMGHDlSQiJGNFXeAIWYlek857FlQzbmTIYqS6qAkWmQcA
         eQXIjkbY/c1QnBT4GNuM5ewFHMvBf9OpS3X0Vodqzz4W8AwpUNT2SseYjOo16NHWPqeo
         c32zH0KN4CT110E0g9vxxZBHH4R5FpzdvJVBFeUuJj7ZU/QcqYrRyB2itOnFJR5uLsXY
         3gOvh/WJElS0uPycGQ2x827w0c7f78837gQsMSk2XtfwhpCY6flZ8LPs41O7rDZluozz
         utyQ==
X-Gm-Message-State: AOAM533nFRiXTl88li6R5JOeW9jf3CVmi+IJzMd0MPQg7lrQJNsCIenk
        FM7BHbE5T8FLMz8i6PG/GdYKQw==
X-Google-Smtp-Source: ABdhPJwKNErgF0FucPzeH35Iw/uXFcx4Fd63+8tDJk8GQUwHXG7fSIBZdGZwkgAvczb8Gb5RHuIB6g==
X-Received: by 2002:a17:90a:7802:: with SMTP id w2mr6096pjk.160.1604629732419;
        Thu, 05 Nov 2020 18:28:52 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:51 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 18/27] mmc: sdhci-uhs2: add clock operations
Date:   Fri,  6 Nov 2020 11:27:17 +0900
Message-Id: <20201106022726.19831-19-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 994dff967e85..55362ace1857 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 
 #include "sdhci.h"
@@ -385,6 +386,42 @@ void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	__sdhci_uhs2_set_ios(mmc, ios);
 }
 
+static void sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+        struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
+static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+        struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	ktime_t timeout;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -556,6 +593,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 
 	if (!host->mmc_host_ops.uhs2_detect_init)
 		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
+	if (!host->mmc_host_ops.uhs2_disable_clk)
+		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
+	if (!host->mmc_host_ops.uhs2_enable_clk)
+		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
 
 	return 0;
 }
-- 
2.28.0

