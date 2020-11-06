Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38579C388F7
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D135C20782
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYEo3Q0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKFC23 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKFC22 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0DEC0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w65so2953878pfd.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSSavh8aYuAKIHXfk4k19j1F92a9eMW5CzDb9993MqU=;
        b=BYEo3Q0d7sowonRQAWHJQ0Me1yZyJMKZyhajU473DZ6B0j4VLTclPc57wc3qV0r7BN
         4wVU+Iuoj4j9IuhR999knyLoDMjx94Z/DRp4+bdQtmKIsRmttbs5gfZ4HmYHAdWu6qro
         uv1ulvPWaAYa2q+zihYt6yFP9UtB8kLIIX3dE4mtWyqE8Vl0H8CKRQ2f8Ko74rnmRetZ
         BmnTvjHr4DnOS+P2JcHVin3B0VeTgjuAniluISo0BBbMcadsFEqjHgQfoTKnjUQdGKvE
         fvHMfqHqMJYImxwzBjuJjkFphXdRE00WTehhKT1WrXBW5ltLKd5Z9CXmxPiR1RSPTgAp
         /Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSSavh8aYuAKIHXfk4k19j1F92a9eMW5CzDb9993MqU=;
        b=Kbf1QKyzh+pbOQNEjWrUHhUabnZENDc5IfywcpGhxP5gSd6QkPFEd7bIplDlZLCZ/s
         Nf6EHvXoP2XZL9HLcz97k8igTbA2ptCesLo/rZSQwL4iWj6KPJq3prbhn1fwzzrI+hgM
         xlCHpNWDNzJxwlitbHyeu0v13KZUO137dyyVBHYGQJviWbOVCYOJ5Bi9ztaqY4HW/o9p
         Hq/oYuE/m+sWnRNC9hOZ/vGigBb0smmdrdntiMnde5XUqPqyKDWPVzsF+pKN0wQOVxbV
         eSJ/QPU74br31YXlICwP2bFxRAastYEIiJ3jSy2qJjI0kNIRXv7R13FcBcNzBUNPOcFK
         lYbw==
X-Gm-Message-State: AOAM530Venh7MrOoSenURmF4pEQYAWMJPqQCV3HpzwZjyjrMpJ1JUTvV
        F+T6o38zPVmzCOTFX0E2F6fA3Bcuy5CENg==
X-Google-Smtp-Source: ABdhPJyC7aqLgd76lj5QmCOs7lCdy4oablIuNeLjwbHbR/B1L06vGJJDJ0rnPG1YsQcFxBEyw2FW0g==
X-Received: by 2002:a63:1512:: with SMTP id v18mr3213908pgl.450.1604629708080;
        Thu, 05 Nov 2020 18:28:28 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:27 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 10/27] mmc: sdhci: add UHS-II module
Date:   Fri,  6 Nov 2020 11:27:09 +0900
Message-Id: <20201106022726.19831-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds sdhci-uhs2.c as a module for UHS-II support.
This is a skelton for further development in this patch series.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Makefile     |  1 +
 drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 451c25fc2c69..f6e9b05c3b30 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
new file mode 100644
index 000000000000..f29d3a4ed43c
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
+ *  Interface driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *  Copyright (C) 2020 Genesys Logic, Inc.
+ *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
+ *  Copyright (C) 2020 Linaro Limited
+ *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <linux/module.h>
+
+#include "sdhci.h"
+#include "sdhci-uhs2.h"
+
+#define DRIVER_NAME "sdhci_uhs2"
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static int __init sdhci_uhs2_mod_init(void)
+{
+	return 0;
+}
+module_init(sdhci_uhs2_mod_init);
+
+static void __exit sdhci_uhs2_exit(void)
+{
+}
+module_exit(sdhci_uhs2_exit);
+
+MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
+MODULE_DESCRIPTION("MMC UHS-II Support");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

