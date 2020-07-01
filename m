Return-Path: <SRS0=joLi=AM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E3C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 10:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E5520747
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 10:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQ7dkkUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgGAKX3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbgGAKX0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2020 06:23:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0976DC061755
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2020 03:23:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so23196387wrs.11
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2020 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+0L7y/Q5A/sbDA9AxIYlmTu4gtBQkLRySgsaJ7BoAY=;
        b=kQ7dkkURh4AtE4qt3ISqlQdkih3RMk1qYxt16jBrQnP+M4yANrT9fjqxEUUvPKBZCU
         +ibk0nVgsTJCv4KKuqtFXLS8ZZtsA/C8msTHGAFRRTlzdhnMWf9JNjyvkaDSSsfvjqHZ
         rS/oIaEhI6i26kgyrdznxuGzcahq74INsEQy0Ym87n7DF1mrbXcKTeUdBwDN0tjsM1jY
         i9LOzkwVt4ut2AxZkywFAPtfZ7WpDqZd89Kq81kqnQErx087oc0kNMyRM2CA8ZtKAO+U
         2U+nlItyqhrv6GNd6bzObPsvbtxMF6HRjaJowz3v6BcX7pfLCHcxvOFceHEtpydsTSsV
         XXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+0L7y/Q5A/sbDA9AxIYlmTu4gtBQkLRySgsaJ7BoAY=;
        b=HH/KBvcn0ycS/0nOnH76nydmsn1tTs+DrBeqgeulD0TmCSepoNnP0Ufi/Vl+4HJlqZ
         +d7DlvGocWELkppRrUZm7enwSNQc2njNQy8rbT+b+4PDdubhmit+mCXxg5cScsNTGmZr
         kJQ+eV/Aa4mTM0XVDhEdZkQyEQj4Mfg1jVmhAkTIfTrCVxsTNlpbhI6OBNYvsILncNMp
         Si0q06jt4MzwSR0qrSbd5FwCTUbRcXJX6D6fL8+iqI9tawJsVPpOWM5968CQnZ8ntJ7t
         BHcBlGI1PSbJ0EXdSWbTDb+tUowVHLe+Pdkh8Kzqn0F2uPchagQhT4n3W5AHTb1P+h5j
         NXIA==
X-Gm-Message-State: AOAM532HcxAqNvuMZ+logIMbpf/X+OLSmbJu/LcOfCdNhx60HnL3pFFz
        L+lGXyUiFLYQ1/TpGDJrxOB/fw==
X-Google-Smtp-Source: ABdhPJw1kO9gxa4UxTNtADJOroEmaJriqXOuZTCWjSGpmV8hPEVE/6FojS/GyzGme4iBa4RNP8DHqQ==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr25362925wrr.240.1593599004674;
        Wed, 01 Jul 2020 03:23:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id d10sm6994341wrx.66.2020.07.01.03.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:23:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 1/1] arch: arm: mach-omap2: mmc: Move omap_mmc_notify_cover_event() prototype
Date:   Wed,  1 Jul 2020 11:23:17 +0100
Message-Id: <20200701102317.235032-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When building the kernel with W=1 the build system complains of:

 drivers/mmc/host/omap.c:854:6: warning: no previous prototype for ‘omap_mmc_notify_cover_event’ [-Wmissing-prototypes]
 854 | void omap_mmc_notify_cover_event(struct device *dev, int num, int is_closed)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

If we move the prototype into a shared headerfile the build system
will be satisfied.  Rather than create a whole new headerfile just
for this purpose, it makes sense to use the already existing
mmc-omap.h.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-omap2/mmc.h              | 4 ----
 include/linux/platform_data/mmc-omap.h | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
index 7f4e053c34344..b5533e93cb632 100644
--- a/arch/arm/mach-omap2/mmc.h
+++ b/arch/arm/mach-omap2/mmc.h
@@ -16,7 +16,3 @@ static inline int omap_msdi_reset(struct omap_hwmod *oh)
 	return 0;
 }
 #endif
-
-/* called from board-specific card detection service routine */
-extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
-					int is_closed);
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 9acf0e87aa9be..f0b8947e6b07d 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -116,3 +116,6 @@ struct omap_mmc_platform_data {
 
 	} slots[OMAP_MMC_MAX_SLOTS];
 };
+
+extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
+					int is_closed);
-- 
2.25.1

