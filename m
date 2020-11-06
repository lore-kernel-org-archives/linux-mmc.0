Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB47C4742C
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DDF2075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3FxgVa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKFC2n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKFC2k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:40 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6CC0613CF
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:40 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so2753901pgg.12
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyEqMGIHRnKPe3xHe7UousaiWzXJGRfcAUx/vMsQuIw=;
        b=W3FxgVa1m5WnbyCCyqmcTeUkhbF+QyNq5HZj8oSSBG51RGuK+z94BVDoH1loLaMRRl
         emr2UkfgxEO3RcNiLB5dB9uOZyXirNPYVQd6ph42FpVVC8gdsT5NUweyJo3b5D1FyF/G
         +xF10KL7tO8PQN9qDc+iKGBN/FSzht6gcEiG8Z6r6dI70bx0/PqIJvgG4J+KtPvYIcpE
         P1gb84HiYq7uxxf1v2rYicDNub4oKpHfZskY6jvRe9HmGWinLaVZVBxuygvG0M558oje
         EJ26GNLzzAbHm6MzCymWeVQxVsb69i5q/yIlgL1Ueegb9byDe8yzqoVAb6lboGyI2RYA
         n1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyEqMGIHRnKPe3xHe7UousaiWzXJGRfcAUx/vMsQuIw=;
        b=Pm4qTy5jW/VamkdTVvGdyK2C/WaWgsPZdPQXYD6q4937Jv5C0uqJXo6n1Vtb+jiU5i
         X2JlF2ZEbH6JdXePxT/4V4K281sUzfhh5NpgM87n1uF+1czvqiyui6rnI9xb6fTvSCBS
         rM9nZyVxK/30xWUSsD1zkQIBN/ui2AKaoZvxokA6STBzAwZKUAyB2cfgAykwjxsyBd0x
         9uThwbgA1uMsnfig+UG2KAARbANhuVV5RlxKPy2I1gcKE0pAiqL6RMRQDFLM+5pZtZuJ
         ibbkPzI3FzsTYv5qmsQxKe2kVkyrNsCsIfQ30SlH4U4jmLCXjHnIOJ8y5kfkxeirf3iE
         n9Ng==
X-Gm-Message-State: AOAM532KzXLC7uqs2yHDYDfh9ISuTz34r+9SAHxJF1LPOsBYJqXaZ/u9
        yQ5O4r3kkOoaQACC0RUJMZM7Fg==
X-Google-Smtp-Source: ABdhPJxI2+dKRxtHxmHOTSrUzZMu1zXt13l3GwZK4faUutL0L8VBwahJNyBePABLt1MktehexZqhuw==
X-Received: by 2002:a17:90a:43c6:: with SMTP id r64mr11402pjg.128.1604629719929;
        Thu, 05 Nov 2020 18:28:39 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:39 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 14/27] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Fri,  6 Nov 2020 11:27:13 +0900
Message-Id: <20201106022726.19831-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 2bf78cc4e9ed..1eca89359351 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -178,6 +178,29 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/*
+	 * For UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage switch required.
+	 */
+        if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+             host->version >= SDHCI_SPEC_400 &&
+             host->mmc->flags & MMC_UHS2_SUPPORT)
+                return 0;
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -186,6 +209,9 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }
 
-- 
2.28.0

