Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFD5C55179
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A872075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4mOZOo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKFC2f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgKFC2e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:34 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5B6C0613D3
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:34 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e21so2760889pgr.11
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuB4tj6YcDY9jEmweGp+8BpnRDVzUuLPeDdIKG/BTQk=;
        b=i4mOZOo8wwAaOXT1SCNtxjLC04KiRx/Vh6I3a3QcmdZaU/4hqnXCzWSdJFrYAnpR+A
         NXOR+3+9cimiGzvPrS2Cm0jgDd9llZBxVYEy40VUinPbGEO7OZbwUDgj6lHO9vrTOfe9
         Z+os9yIerR6Y25p1Phiyr1kqCbsspCpm0+ymXoYZIth1mrY+hk49bCAC3JqXvWmmlO7H
         Me4Lji9r/hbEZGuhDDVkO+4TEi6LzDvXi+3yBhioRcNSVGeN0kmuESZTAcT4hz7AszXQ
         UzhZnrd/2Ib+hZ7DiWj4r+9QdVREpYWvKUysk8d4DnoTwKI34kNs6CHwOw9BhUITL0nB
         nyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuB4tj6YcDY9jEmweGp+8BpnRDVzUuLPeDdIKG/BTQk=;
        b=i0Fp8d5PXLpfuo3FN+R0krnZNQhoN+3Y38d/RMtLtHW7fvJ+66KoCdn2reVrxnvvqs
         t8O6fwBNaABnHb2p6mXX+eJbyyj4QVuXF/2kmS1X6VR2TRmJ5gJFJK9TJj/dHhsmGwE8
         x5OHVzXF0eyqyPN6VxTpGt5bdFFEN0dAX+o7JOW3X+oLZlQ4TcA/9dxBHQyWTfHAyGVB
         r2yRP41yf2iZJ5PW4SJOw4OhZp5nm9C1otkvDA2oZGn/XlNxF2uTqUXIKZzF43MPNuJh
         nOdJ+k/iUMFcpfumxvQngIStBP2igiEwJfQrgJx2M2Afg7PHr2To3AJhhhqNXCdXBUNb
         c7QA==
X-Gm-Message-State: AOAM530N64luSuFmBqSBYCUrgnPG3BaGp3BuZNB/XhOf5G16rX4mS0rq
        iTgzAT2TtZewjsciKS8I68H+ig==
X-Google-Smtp-Source: ABdhPJwrkKfQsS0OhKYmNvh7CIPXKG2jF71fugruavalLmJFLUeW8Ec9/yAQtCxCrQHvcW3dCeFpiA==
X-Received: by 2002:a17:90a:c7c4:: with SMTP id gf4mr26662pjb.18.1604629713965;
        Thu, 05 Nov 2020 18:28:33 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:33 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 12/27] mmc: sdhci-uhs2: add reset function
Date:   Fri,  6 Nov 2020 11:27:11 +0900
Message-Id: <20201106022726.19831-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
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
index d4a57e8c9bb8..af336bdb4305 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -195,13 +195,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 	pm_runtime_get_noresume(host->mmc->parent);
 }
 
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
 	if (!host->bus_on)
 		return;
 	host->bus_on = false;
 	pm_runtime_put_noidle(host->mmc->parent);
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
2.28.0

