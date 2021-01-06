Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEB2C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Jan 2021 09:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87C52310B
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Jan 2021 09:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbhAFJ23 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbhAFJ22 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jan 2021 04:28:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4DBC06134D;
        Wed,  6 Jan 2021 01:27:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hk16so1287094pjb.4;
        Wed, 06 Jan 2021 01:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30gO3S3DeQMcowqhl/FY8ymKxzURmO5FSvF9UTh/G6I=;
        b=XAvivFEsmcwooJEGtCwulU6ckLwIJsgitf/Aim164ibCQT1dM6AE2vrit5OE2M4huq
         TGJif+ABZAyXZRJ+kO0ktjJ0S93c0qojRzE0GV77VBZ9myv4YPvHRa8x9w/Fr2oHi4vl
         bq2zVbzyVY0vKNkeFQjZVpgaDZZVU+/hFwKbD+nFOlniCVaNXjNJQ+g6uUrh2RYuo5D+
         Rtw4mfWg8UcJlwuWYfRNti5QWQhUxnFv8n7+syNYyuuqd1C15U9ny7D5oEKWrNv/QLzO
         9YFLJGmphB9LbUV5LFcekEol7DhumMYUgWn+AUrrlgkBNd+yO9KP23Qvyau/O8GGvNgf
         cDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30gO3S3DeQMcowqhl/FY8ymKxzURmO5FSvF9UTh/G6I=;
        b=WStaDBRiGn58eG7nxKFk0aiCj+eAchgZjPAGfm7W7rU8vWC8mR27017TKDHNUzE30w
         uzsJKT/TW3VVcI2pwq+rapIzw04AMGU4ZxbaJd8bGJobDH56H7Qz6gyZc8ZOFKpCMNYY
         FaSKGKGpU9RHbdWX0s6FkU7aHWM3Y+u2bYwIujDsH9+5wSnRu4II8hlnlGXLcAbXnfh1
         mTogmFYJI8oNKFp8CUz7GgkSb7GhEK88jPJ1cxfYetvHAsVDbc4DSoKkOR6l+prHCJo2
         MH538a2NlULf28ABAaHFhTueefgsEewkFJZFhAwlk5YdiAFy7xtfrjLzZVJ38DFa5/KN
         T7zA==
X-Gm-Message-State: AOAM531AvaU7qHlSXtEKKvPqnp7DxWJKxpJb1ZJdfjMpvFTM7SnPjgFQ
        YOfBCEKMA0IJvagKPfhvEyTCj4Ro3ngT6g==
X-Google-Smtp-Source: ABdhPJwKH/EvrWP4Woi7DHxc+HRX512yiLzpLak7v+uHhk6xgrhack5WA51z5EVTZa7Ds/Fe+jARvg==
X-Received: by 2002:a17:902:e9c5:b029:db:d1ae:46ba with SMTP id 5-20020a170902e9c5b02900dbd1ae46bamr3416884plk.38.1609925267338;
        Wed, 06 Jan 2021 01:27:47 -0800 (PST)
Received: from gli-System-Product-Name.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id 129sm1856207pfw.86.2021.01.06.01.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 01:27:46 -0800 (PST)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL9763E
Date:   Wed,  6 Jan 2021 17:27:40 +0800
Message-Id: <20210106092740.5808-1-reniuschengl@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The R/W performance of GL9763E is low with some platforms, which
support ASPM mechanism, due to entering L1 state very frequently
in R/W process. Enlarge its ASPM L1 entry delay to improve the
R/W performance of GL9763E.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index c6a107d7c742..2d13bfcbcacf 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -88,6 +88,10 @@
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define PCIE_GLI_9763E_CFG2      0x8A4
+#define   GLI_9763E_CFG2_L1DLY	   GENMASK(28, 19)
+#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
+
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
 
@@ -792,6 +796,11 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value &= ~GLI_9763E_HS400_SLOW;
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
 
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
+	value &= ~GLI_9763E_CFG2_L1DLY;
+	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.27.0

