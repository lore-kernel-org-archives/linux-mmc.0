Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DEDC07E9D
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 23:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E541860FE9
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 23:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbhGSWfp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355759AbhGSSyO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jul 2021 14:54:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021EFC061574
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jul 2021 12:26:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu14so12134581pjb.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jul 2021 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Col+Hohsx7xGEFrf+jrfKCvFuSmzDZVn/MQc+BnuW18=;
        b=ZT8nCCynJcgM/7BgjAfxesuFgGNL50LCMscTSf6fn8k1AwHZfgUQ3wWLPLAWJMwjum
         2LsJVROIPrnKzh59b2h4ZtRoip+/2nrcCaZhfFIuLqB5pe/p0kw58koBZbw8pdF5r4kg
         Eh7IA2ZPNE5/rUi5IsV15of5/ViqpNcK53WbshmuTBZF84K39ZwzRxPTbFSwsqIkXf0J
         +ujfaUthW26apXh7cQXrCuS1X2xZxKHjpzcNT1GFouVt8F/gw2usOrgeE0DhhulrS+nK
         G9l5bzboo3o/slYTBvRhfZKPUZBNaHFoOJtSdCdiWaUJqIkcyUJxzVmKwLtzUkKWb7Os
         OhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Col+Hohsx7xGEFrf+jrfKCvFuSmzDZVn/MQc+BnuW18=;
        b=idkZf9WBunUFVSlh6JCwgPKf2yo76plqmCEiUh0vR6jxb9Fh1C9mHIMKOGV67wiI6X
         X//cC/rM1p+2gmCDX/HgqrtrA2lDATW0TAE3qtBUR7CmD3mxhqXLcHXuEQ7mRaSa1vUP
         Inqz7Xqrkx84clFsApn5mR87o/ijk9FpSinuWu34DCN+ulbbXme2nSwUtKWrPNgGGt40
         S4vWmYxT+Vj1/j4WAGrZ1hCsW/kwbRQMUggliJ9cLnUnN5p5G9yQ6d/FYsYWuDJp3wzy
         trKS6s43XYBJX/CXgXQMRB4mnLVeVxCyQNp2h+f3quLhDO1IUEGTpl5p1AYXPPOSbuLj
         kpWg==
X-Gm-Message-State: AOAM533tufIT9suL604hMhr8mARlpaGO7sbXXMNx5Z9o8V80j/wjnyMt
        e9VBVM/iABImVDD5wQFMuf8=
X-Google-Smtp-Source: ABdhPJwTXDrMxPjGHTUp5k1aFDZCklfmLjP3huiqCPmK7iC29tErG3i0xIncxJFBOLXOhP/xugPPJA==
X-Received: by 2002:a17:90a:a117:: with SMTP id s23mr3532133pjp.229.1626723288741;
        Mon, 19 Jul 2021 12:34:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:504a:4236:c95f:1569:e13d])
        by smtp.gmail.com with ESMTPSA id f17sm268204pjj.21.2021.07.19.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:34:48 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Remove unneeded mmc-esdhc-imx.h header
Date:   Mon, 19 Jul 2021 16:34:13 -0300
Message-Id: <20210719193413.3792615-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

After the i.MX conversion to a DT-only platform, the mmc-esdhc-imx.h
header file is no longer used outside the driver, so move its content
to the sdhci-esdhc-imx driver and remove the header.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 33 +++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h | 42 ---------------------
 2 files changed, 32 insertions(+), 43 deletions(-)
 delete mode 100644 include/linux/platform_data/mmc-esdhc-imx.h

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 72c0bf0c1887..57b19ca1ad6d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/platform_data/mmc-esdhc-imx.h>
 #include <linux/pm_runtime.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -191,6 +190,38 @@
  */
 #define ESDHC_FLAG_BROKEN_AUTO_CMD23	BIT(16)
 
+enum wp_types {
+	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
+	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
+	ESDHC_WP_GPIO,		/* external gpio pin for WP */
+};
+
+enum cd_types {
+	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
+	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
+	ESDHC_CD_GPIO,		/* external gpio pin for CD */
+	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
+};
+
+/*
+ * struct esdhc_platform_data - platform data for esdhc on i.MX
+ *
+ * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
+ *
+ * @wp_type:	type of write_protect method (see wp_types enum above)
+ * @cd_type:	type of card_detect method (see cd_types enum above)
+ */
+
+struct esdhc_platform_data {
+	enum wp_types wp_type;
+	enum cd_types cd_type;
+	int max_bus_width;
+	unsigned int delay_line;
+	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
+	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
+	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
+};
+
 struct esdhc_soc_data {
 	u32 flags;
 };
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
deleted file mode 100644
index cba1184b364c..000000000000
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2010 Wolfram Sang <kernel@pengutronix.de>
- */
-
-#ifndef __ASM_ARCH_IMX_ESDHC_H
-#define __ASM_ARCH_IMX_ESDHC_H
-
-#include <linux/types.h>
-
-enum wp_types {
-	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
-	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
-	ESDHC_WP_GPIO,		/* external gpio pin for WP */
-};
-
-enum cd_types {
-	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
-	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
-	ESDHC_CD_GPIO,		/* external gpio pin for CD */
-	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
-};
-
-/**
- * struct esdhc_platform_data - platform data for esdhc on i.MX
- *
- * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
- *
- * @wp_type:	type of write_protect method (see wp_types enum above)
- * @cd_type:	type of card_detect method (see cd_types enum above)
- */
-
-struct esdhc_platform_data {
-	enum wp_types wp_type;
-	enum cd_types cd_type;
-	int max_bus_width;
-	unsigned int delay_line;
-	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
-	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
-	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
-};
-#endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
2.25.1

