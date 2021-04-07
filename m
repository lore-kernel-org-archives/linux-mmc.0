Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B6C433ED
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 09:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247AC61363
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 09:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhDGJfc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhDGJfa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Apr 2021 05:35:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5AC061756;
        Wed,  7 Apr 2021 02:35:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f29so10144458pgm.8;
        Wed, 07 Apr 2021 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIooQe1cbZMs5k8eiR4v29BI/b/lezlax8wbPH1H5SQ=;
        b=TG3PeN3bbbhOlaS/fGewz9kZiVnq2EJUkxfeL2QWyXozsNqD1cjXmZQJB5UCuuvCqK
         J7KnscDpbC2cYyQgM/4X1/DfMYJ9N/KZMhCV351/SyFvGSRwmpzHRiLHeKdz5QwfA83v
         BzTnXB1oSSt0RCEN+rcrpxevK6UIymMsbb9qDDakODz8h8495aqaaF9DsIQzjjWIBjJG
         MyO4OY7+7LIzovfvlz6puppfGwsuhRyAbgfU220U3+Qz0+mppcMRy1njas99JqcIaxTj
         x1YjV6CXisuZ4fU8wRRjltqKQ4sLpZhEBfJhFE+99gijFWbvoEx0zC9uMVPZNBXL3/ew
         XuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIooQe1cbZMs5k8eiR4v29BI/b/lezlax8wbPH1H5SQ=;
        b=hXHkgGOOISi0GnLaV4RUdVpFkpwHo4uRSdLthDdb2F7Ic1bPacLVrYIuW5iaHjVIqy
         cFIFVt9xrE7gs88MNvmKqrsKAO9r95zegqNjmmhSxXWkuKTuc6D9gmVkjZeHynUdQlI3
         rxThw8C+8pwprAuypkB+/cfAfpV37UnJaXocyXdKjY3cPXA1BDGW3KSXbzowaKVtSJnY
         WN1xYW28D+npUl56Z/kVetjXHLAVPbz9I6IpfTtvw0Uex32d6NLNSS+AujYtQkwf9jms
         fNLVB8dzn+CwZPrwtl2I1YU+/SnzhDRagB/02cc4CRFY2TO6sqilu5NUIPGQon18xC7S
         6dTQ==
X-Gm-Message-State: AOAM532E+LAf7ULR84uAhkIcHu9VbzQ1uZr/JU7BEDPSeCqw0ljhJMz5
        CrUNjrhQOK2ULEisIxVbOaA=
X-Google-Smtp-Source: ABdhPJy07ALYrfjRKx22b51BS2YpKrkb0TCrDqKfuWda/8IxY1teZ40qkuDIjAdVMBC4GhJdF8YKKQ==
X-Received: by 2002:a63:2c8a:: with SMTP id s132mr2443705pgs.165.1617788120728;
        Wed, 07 Apr 2021 02:35:20 -0700 (PDT)
Received: from localhost.localdomain (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id gm10sm4749407pjb.4.2021.04.07.02.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 02:35:20 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Renius.Chen@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [RESEND, PATCH] mmc: sdhci-pci-gli: Improve GL9763E L1 entry delay to increase battery life
Date:   Wed,  7 Apr 2021 17:38:16 +0800
Message-Id: <20210407093816.8863-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

For GL9763E, although there is the best performance at the maximum delay.
Change the value to 20us in order to have better power consumption.
This change may reduce the maximum performance by 10%.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4a0f69b97a78..3b0a049d4124 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -90,7 +90,7 @@
 
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
-#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
+#define   GLI_9763E_CFG2_L1DLY_MID 0x50
 
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
@@ -802,8 +802,8 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
 	value &= ~GLI_9763E_CFG2_L1DLY;
-	/* set ASPM L1 entry delay to 260us */
-	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
+	/* set ASPM L1 entry delay to 20us */
+	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
-- 
2.30.0

