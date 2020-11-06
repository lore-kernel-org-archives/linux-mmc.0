Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6DEC388F7
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24112075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QloUebj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKFC3S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgKFC3R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:29:17 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E80C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:29:17 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id u4so2768368pgr.9
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b27GJGEmE1Mom6xyD9K+l/VA3DKeEcufnAZxDfWuSpA=;
        b=QloUebj4KbG5jJRv0H8hCra2triZfLbfW8YzbN7Y8qwMNY7nfk7UPDQCEEo7y0Dyoy
         M7RwEGOd+lbQdUe3ko8l1jzzg2egeZ/LCN3t6mNuoBaC9WbpNs7RiLPqcz/3wpRoqfx/
         dHOTXc6I6T7t7vMGDZ9iuu2Zull02bHOMMWq162+yW1i4hBq1gNZwy0mUiaYgmPSiCgj
         mKN0IVeOHmRoaEow/UPYyPm3BRfkGHtheIclmoo1rdIiJ3/EXbBdUJWjBmLYz4lhDpAV
         hYElcanv3jr12+UMMLPwTUaGF8WAigBqYsgQuYhUHNce7g6qLWsuHHu3ljNihLXyoU0I
         Uoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b27GJGEmE1Mom6xyD9K+l/VA3DKeEcufnAZxDfWuSpA=;
        b=nYMbZx5SiBDxCElWARlsyOXez0M8cU3C1XIVBnw8QXu05p/aHDEsRXHNlCV8Ba3LCq
         LXAFMsHdgyl3qJV0EgRaEsE7tvbd64xabYkBPfMb+yUYX1qmDtLkhxThX/gaQ2GBDKY2
         MSti7sUAu6YHcyvLoZnW5I8fzaocxVw6UWudZ5lwWZogRsAr6nuZ38Iwq3ijRQJhcMGL
         n8ZB+S3PDF6XvjwP3nt/JZw77Hmhi+YVGV66q/2tKbalBwaZCrHkaKs2LUw5OfRMKpFc
         PqRot1XEsWTq77ofCTVhx6sqGaGo3aPIy4Oe0xjpkqo9Q8kEck8l1+Fl9AO94f3VrsIf
         RVYQ==
X-Gm-Message-State: AOAM531nV9fwq8SFXsee+rdRsqvOtzbNoGl/yDoc85nzXf7C2Mub3L01
        pGVNohyTdbSS8es05gdRminc/w==
X-Google-Smtp-Source: ABdhPJxQw8fWMpTvx9u5nTg84ZaSUEZW34L5U3OWH0F3P/t0ZewQONa/xdteYMWibBFvGrrfbR2GUg==
X-Received: by 2002:a17:90a:1f0b:: with SMTP id u11mr5388492pja.105.1604629757052;
        Thu, 05 Nov 2020 18:29:17 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:16 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 26/27] mmc: sdhci-pci: add UHS-II support framework
Date:   Fri,  6 Nov 2020 11:27:25 +0900
Message-Id: <20201106022726.19831-27-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 23da7f7fe093..a896c7b325d0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -39,6 +39,7 @@
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2215,7 +2216,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2226,6 +2230,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
+{
+	return sdhci_uhs2_add_host(slot->host);
+}
+
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
+{
+	sdhci_uhs2_remove_host(slot->host, dead);
+}
+
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_suspend_ignore_children(dev, 1);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index d0ed232af0eb..c961ec3cec26 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -137,6 +137,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
 
 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -186,6 +187,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
-- 
2.28.0

