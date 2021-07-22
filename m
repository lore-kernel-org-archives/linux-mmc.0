Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E0C6377E
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993F161222
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGVDWG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhGVDVw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAEEC06179E;
        Wed, 21 Jul 2021 21:02:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2352733pja.5;
        Wed, 21 Jul 2021 21:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4E1R4sFAVMhjqGN0YC8B71uq5j/Oq2YJVzlAWihbNec=;
        b=Pq96KElRB891sL3oh229eket4TOuYtBX6m8VN9tj6wOsum4w1hFrJa4deMzoaShe2E
         le6J0np6YDc4pz71DW6ZA6ey8ngPgpNRxk2AvY6fUQRPW5X+BqwENeiQpoT4IzU3tkwe
         zOyayHd1zrlcTYExn4Eiy9XOD1838BdpWc2X05Zb+0RCkQcV8L6CHlbpVsdMcy7x3DfK
         J8ypiNOhAZAci6Yu3Z5REDo6D9KuTy9aLQYXEdU4xW/PSzo4/6d8+8qLuH19gnaBAAKa
         hr27YJxIDBYgxlzaMWH+BXN9XRzUscxgI3oYSCbiC2fy1VbrSB4NDjqM2WCU7NPQawaO
         PeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4E1R4sFAVMhjqGN0YC8B71uq5j/Oq2YJVzlAWihbNec=;
        b=LmeZU4fRXiRvwpAwOG/9YYZa/AXvEHl/d9N6u56sRFqO1o5xtW79HqA8Osz6W6lPPS
         r08Ii8AJIlK6EuXrwJDrQDcE7Y/dX9BlaLiRQGBjB/OZN6LmxIATuTE+wwzO7PwyataM
         dJ6YIxc268eZXsslttSlq2hC6wk8H7oNVBFOzXL+fPHDnOm3qg0n2QUDwBsMNJ4jfGL4
         ipQfHqMFNtuACRxzwHe1i9TOICcKpE28SFSRdNT5hLFHDWw11+SQo91RketPwRUcbRVI
         13nIDWDc0VYFlAjNZ3pOpTbaM6tWjfNm6MzbwLxtnI2dev+zhFjMVCAvbxgc/iCk3Wcw
         IQvA==
X-Gm-Message-State: AOAM530R8cnJqTiCbTEDxMdfK6pweOzgY47IcFpFyDflw9L5kSi9af2t
        gjst3SZERyAX/TuoNj/Oerw=
X-Google-Smtp-Source: ABdhPJwQP26yCo/7Sfuz+wcyp46/mt03qdV41wSR5PhVno2OrdQL2UQ0K54vH8mjw8tPNNPhs61Gaw==
X-Received: by 2002:a17:902:8648:b029:129:dda4:ddc2 with SMTP id y8-20020a1709028648b0290129dda4ddc2mr29974073plt.4.1626926546577;
        Wed, 21 Jul 2021 21:02:26 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:26 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 18/29] mmc: sdhci-uhs2: add clock operations
Date:   Thu, 22 Jul 2021 12:01:13 +0800
Message-Id: <20210722040124.7573-18-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
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
2.32.0

