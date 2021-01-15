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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FAC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 05:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDC7239FC
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 05:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbhAOFsY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 00:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbhAOFsV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 00:48:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E72C061757;
        Thu, 14 Jan 2021 21:47:41 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 30so5326389pgr.6;
        Thu, 14 Jan 2021 21:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/rucpAwNr7H7Sq+3iwOrm/3FZrRl2K/TF/QHTKwAl4=;
        b=prBSjERD/4xhSmfN/LZoOMqYKPZB+MJkLRhzWQs5F0STCTA0EGz8La3vovPqyW09U+
         0V5UcopJa0JAQc4QlD/63Z7KyF+aIrZ1+ptx7Hyjs0AUioVAll703qW2I2WBkJjuDsIh
         GO3DNPR5sSYqxyfOkCF9i5dppF+1F5LRRA5D43PLGzS/MhExhVtV28gISLA8451qlTVn
         6g9+mmM3q/7Yp1XIw5ro+AphxFA6gWlUXCAka99WybAsj6MN3QUJWKrXK6aHu8noux/S
         i0binNhfywyIlez1DuUwWXPRY/1UFS3//J+CD6luClp1O70SUG1/Zi09uRk6mM9GqTRo
         7NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/rucpAwNr7H7Sq+3iwOrm/3FZrRl2K/TF/QHTKwAl4=;
        b=Ml2i03nsw7wIdlHEKykNyC8Yir5X8U62yEoNe/e8Ai/ldnF+z3/X/KDQjJYXumOq5c
         TGLpY4mXaJpTxyyn0XtMkFvLfS+FEJXBBYfRVYIiwhfclCYzgdmOYyEiPiKGfX6msi+K
         mZdAWbz0I47Wtjv4m/BBYCAeljp+ruLQXS1dOXLdC6WlkXTb/PSY8wFq4I97gNfxa5Az
         daLudXzbILzek6DjMYwcYWm3WUKW8kbuigzOy5tl5J0f0rlzcAa7oonrXeuyva+ihO2R
         +y87LrjIYsJLamB/HuTEohvqIM6ntF27tnIjtEDYca4OvM7qUiIh4/okq7IghZ1AnsEP
         /pkQ==
X-Gm-Message-State: AOAM531NBlZH9pHK9XvJOAF0B0FxXsUH630gfVPz5Hr/kVD6s5B2HNnp
        A2T+ypSj64rggv/oi567nngc9S0LGf0Vow==
X-Google-Smtp-Source: ABdhPJz3QaEPXYyvRtan7b9Ddu4rqqXDtp+0jZ0MB1Y1BA/TloVGN2WygeGPK0o7ogTp+Sp/OoHICg==
X-Received: by 2002:a62:1d43:0:b029:1ab:7f7a:4ab8 with SMTP id d64-20020a621d430000b02901ab7f7a4ab8mr10960117pfd.43.1610689661151;
        Thu, 14 Jan 2021 21:47:41 -0800 (PST)
Received: from gli-System-Product-Name.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id t206sm6815854pgb.84.2021.01.14.21.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 21:47:40 -0800 (PST)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL9763E (v2)
Date:   Fri, 15 Jan 2021 13:47:36 +0800
Message-Id: <20210115054736.27769-1-reniuschengl@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

GL9763E enters ASPM L1 state after a very short idle in default,
even during a burst of request. So the R/W performance of GL9763E
is low with some platforms, which support ASPM mechanism, due to
entering ASPM L1 state very frequently in R/W process. Set the L1
entry delay bits in vendor-specific register to 0x3FF to enlarge
the idle period to 260us for improving the R/W performance
of GL9763E.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index c6a107d7c742..fb14f70cb9a0 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -88,6 +88,10 @@
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define PCIE_GLI_9763E_CFG2      0x8A4
+#define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
+#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
+
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
 
@@ -792,6 +796,12 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value &= ~GLI_9763E_HS400_SLOW;
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
 
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
+	value &= ~GLI_9763E_CFG2_L1DLY;
+	/* set ASPM L1 entry delay to 260us */
+	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.27.0

