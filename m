Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24E8C63793
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F41E61261
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhGVDVo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhGVDVl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A93C0613C1;
        Wed, 21 Jul 2021 21:02:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j8-20020a17090aeb08b0290173bac8b9c9so2373415pjz.3;
        Wed, 21 Jul 2021 21:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ejtiMK9VQCHj3pEZGWJNyT1NRRi8uOEqf+b459wT27E=;
        b=lzdFGf9tRsxC5x3Y01z7ioD454DrUWR6+9yNqGFqlCem94cI70zK/aQTOqUKJ96RBp
         N9Qbav1jwAYhYVsflz9+msxTl+09w08aEEKkZ8bEW+jMSEYOz3H/MhGhU5avCGcuKMHh
         E+oXPfpNJeJgYwlXetNjjgK8CrWLMVy2iiFvUwlxk8pBDWFVEeF4BHxopwAt7TncjjN5
         sJzN8XXPwHu6k//vucudBd2j85+YxcCfI4nQtdaWkj0/NiqzR0/iA4HdlcznyDoL5DQC
         jkLEBy2EL0HG7T8DQ5bw7nclIQQIOOILIA7/1Xqtb6vQbfMOFfhlxhLIiR5bzaFBkEWC
         rDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejtiMK9VQCHj3pEZGWJNyT1NRRi8uOEqf+b459wT27E=;
        b=RqYRzWSBWnHWg25a8oLVbH4XYK++PD4JA9aexTzZ/pgMlnpBBJo8M/6lUNMWXTJ5xi
         E0eQrVsFLd/d82EWfwMz2rgfi5ZtbrHDA92cXzSeq9/Ag3KZcU97pdOnGX7K4TlaxCDC
         nEuk31TUWv+w/BiEtFIn3JCpQAwNip/H1BLvoOL3nkxpRu/dUwwZgRyxRwCs5NkYnm0j
         uHmSi6DAJ04n2TLoyDbLoBGh9a1UnMzOirXCr4lCMixxX1ecVA5/BAsZZ+YHSZpCy4Fg
         D7dLW8A37C1E+AKYqsqmUyT1rOQ9O8rVQZ/j0J6A+WesGaIdx8O+fTZKXzlEbDxlqV+s
         qfSg==
X-Gm-Message-State: AOAM532X+vKFYe62JA9JnkYUpT8cf15v9kNcBdM22xK7BlOaaW8GSzME
        Iuc4OBTlpLyUNC7joxLenAY=
X-Google-Smtp-Source: ABdhPJxY+0tjP0htyvrV54Blv0ou7gs49wfJg3A9Pt8Ywoj/qan2+98oN42jaXRW+pCF60eI7tOzPw==
X-Received: by 2002:a17:902:744a:b029:12b:af44:5b28 with SMTP id e10-20020a170902744ab029012baf445b28mr384673plt.84.1626926535453;
        Wed, 21 Jul 2021 21:02:15 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:15 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 12/29] mmc: sdhci-uhs2: add reset function
Date:   Thu, 22 Jul 2021 12:01:07 +0800
Message-Id: <20210722040124.7573-12-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 49 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 drivers/mmc/host/sdhci.c      |  3 ++-
 drivers/mmc/host/sdhci.h      |  1 +
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 08905ed081fb..e2b9743fe17d 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -10,6 +10,7 @@
  *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */

+#include <linux/delay.h>
 #include <linux/module.h>

 #include "sdhci.h"
@@ -49,6 +50,54 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);

+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+/**
+ * sdhci_uhs2_reset - invoke SW reset
+ * @host: SDHCI host
+ * @mask: Control mask
+ *
+ * Invoke SW reset, depending on a bit in @mask and wait for completion.
+ */
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
+{
+	unsigned long timeout;
+
+	if (!(host->mmc->caps & MMC_CAP_UHS2))
+		return;
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL) {
+		host->clock = 0;
+		/* Reset-all turns off SD Bus Power */
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_off(host);
+	}
+
+	/* Wait max 100 ms */
+	timeout = 10000;
+
+	/* hw clears the bit when it's done */
+	while (sdhci_readw(host, SDHCI_UHS2_SW_RESET) & mask) {
+		if (timeout == 0) {
+			pr_err("%s: %s: Reset 0x%x never completed.\n",
+			       __func__, mmc_hostname(host->mmc), (int)mask);
+			pr_err("%s: clean reset bit\n",
+			       mmc_hostname(host->mmc));
+			sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
+			return;
+		}
+		timeout--;
+		udelay(10);
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index b9529d32b58d..7bb7a0d67109 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -210,5 +210,6 @@
 struct sdhci_host;

 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);

 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 97e7e04e4614..78db850dc1f3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -194,13 +194,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 	pm_runtime_get_noresume(mmc_dev(host->mmc));
 }

-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
 	if (!host->bus_on)
 		return;
 	host->bus_on = false;
 	pm_runtime_put_noidle(mmc_dev(host->mmc));
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);

 void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d9d7a76cedc1..b9932423db08 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -831,6 +831,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }

+void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
--
2.32.0

