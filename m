Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319D1C433E9
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 14:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFFD22EBF
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 14:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbhAZOhN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391557AbhAZJxS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2021 04:53:18 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C6C06174A
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:52:37 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id i17so18799981ljn.1
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xl+szrNKltw4M9EkOt6Ku8phtfpsNC6B9vqlONxx0g4=;
        b=ETXxVM2bLAeaCcj1UVibB+xzYWVDbEQPAGexw9B8RYRZue9PL7GzvgHmtFb1o0R7oT
         mtB24aVlehH1AnDLZ0B/etqmD5yLUoEPaK18N3RlZhzBOOhPcEtq1BNGhUvCiUigkyT0
         AWLbVzTPiW2ztrNE1OBGr3Zne1+sdlNWslLg5Pqxar6+9Cm5i4KqulWIwkRZRbKHHjKs
         0x2GoyFNCwbphjOh0pcyzy1GSqn3Q18kYPBzvvq4RJ/p2qIn/3x8DdbDsRod07Kh5kPQ
         +jHrsl4/rIh483QgCKofWC7ei83w4/JhFrmUbnl5RKwPFXF0oGeQvBdFBHpyLVt/zfe4
         wUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xl+szrNKltw4M9EkOt6Ku8phtfpsNC6B9vqlONxx0g4=;
        b=b5svXtamACdwwtI0lRNFITa5sSuEzu2e63u71j3A9sg0JP+Zk+j5J9nGiPDEFdxINF
         kczDtxTzGuV5f7O+YlqtwVR/jDImNpYlPZDjlmFU1CmAjePySYEbpE6zI0LgsuBuSh8e
         ehzPEzCocVPaww13C4e8CjLMi5GKSWjUKH4K3uq/N8o/pU+flRaBURwHkztHwQTD9S0b
         eTkAMGttiDUvirv1a4//ADvMZEowuSr6GnccQ5tZAWf0vl1idcGDvugzI5WFMQjTQZ+N
         YpdRE8fcAzZbYknfcYnm/9QjZ6oTEuMVXTApxfWfX5AVUbf2saRoGwT9lUSs9HxyhFBU
         X0yA==
X-Gm-Message-State: AOAM533hjcjBIKuDwgukRCXlIp6Zu8+1AyZFijB73T/ZpOjubYXjhH5v
        S4QAcPSUKj69siS7ItTv5CK6CBQxvfNtfY+1
X-Google-Smtp-Source: ABdhPJwe2hBaInwMyQJ6bm/S6REpkGRtWsL6YNFzyylZ3R0mgoyfmjcIrsAuAKVG67ByJ+1FBIUMlw==
X-Received: by 2002:a2e:81d1:: with SMTP id s17mr2447074ljg.49.1611654755466;
        Tue, 26 Jan 2021 01:52:35 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-179.NA.cust.bahnhof.se. [98.128.180.179])
        by smtp.gmail.com with ESMTPSA id x28sm2031841lfn.98.2021.01.26.01.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 01:52:34 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>, stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pltfm: Fix linking err for sdhci-brcmstb
Date:   Tue, 26 Jan 2021 10:52:30 +0100
Message-Id: <20210126095230.26580-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The implementation of sdhci_pltfm_suspend() is only available when
CONFIG_PM_SLEEP is set, which triggers a linking error:

"undefined symbol: sdhci_pltfm_suspend" when building sdhci-brcmstb.c.

Fix this by implementing the missing stubs when CONFIG_PM_SLEEP is unset.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 6301b81cf573..9bd717ff784b 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -111,8 +111,13 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 	return host->private;
 }
 
+extern const struct dev_pm_ops sdhci_pltfm_pmops;
+#ifdef CONFIG_PM_SLEEP
 int sdhci_pltfm_suspend(struct device *dev);
 int sdhci_pltfm_resume(struct device *dev);
-extern const struct dev_pm_ops sdhci_pltfm_pmops;
+#else
+static inline int sdhci_pltfm_suspend(struct device *dev) { return 0; }
+static inline int sdhci_pltfm_resume(struct device *dev) { return 0; }
+#endif
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
-- 
2.25.1

