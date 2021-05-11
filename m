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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801FCC433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 06:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F09B6192C
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 06:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhEKGQ3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 02:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhEKGQ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 02:16:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE18AC061574;
        Mon, 10 May 2021 23:15:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b21so10350745plz.0;
        Mon, 10 May 2021 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6A6E9MTW1MHNUC2nN6QJOAjOuzbJNdMNuOZ2OzhYPWA=;
        b=QMu3bVdiofnGIcrTUh0VWhIiuTEXXro/9HwKc3kFM0rELSAIAwygfORFTZCXud0Li2
         2J24bhSxcqeZ+YpPzVlRaZPB/V3fUICc+Ie0lumMcNXOkiu3pay1peeKK6HJ3ZfbGYRQ
         QBAavlfOh8HrgDMTwhc92sLzudl2uSvRWXo3whVzyf7a1Ma7VHpCdB4b7fbw6r5R7/3G
         ViUpwbgtQSBYY+jdfC5SJoSugEVaVk5tF8i7CjQKPKmFLvQ4cV4Kh9Kd5sdLyp7lQCni
         WMUvLoAPcKYalE/SyaARazRc9f9WlWWRGh9k4ccPnW/0w8ecYqdy3O2p+/jJcwKiXKNU
         x+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6A6E9MTW1MHNUC2nN6QJOAjOuzbJNdMNuOZ2OzhYPWA=;
        b=V4QNW9PePRlvVc410PEQRo1OYpxvBVRWxKtYF/PVUyGr+KHdjgs5YtnQVq0dPkFoUG
         DiSB28H25hYPR86CQEXbUjvXa4pTSphS+MYzz96wnyEQGFJqoseRDjeVpjE0aOKPVKBi
         SRtK5qLeOEO9zx8zdGWhw3nzFiuFyHB5CxbI0y5OOabocxAh50MYFV+lAlumIg2eWuVN
         7BoNkBmiIrx963205tWkwfoevwVyFeVlzDVEsstgjmAWIbvKqyXI04roS+ld6xu6CbUZ
         78k3gaCTpM3DyqazOJhs9ltLl76kNyn8djMHlck+PrZ4gxhBjtyRR3qqwhGYXW0XYRci
         tAWA==
X-Gm-Message-State: AOAM531KSzPNT1fWEzpzT9Wpu+JFUEF+Aq4uUOURP8mWuFwnRyL4IU9k
        hlv53oFVCyAs/OoA6rwWcj8=
X-Google-Smtp-Source: ABdhPJzGW+N/VJcxl1EDqEBKM5imkz4+bs46geaqKQO5odkYN3jPyvW5zM2Oqp60eBuD+Nyjy/yzKQ==
X-Received: by 2002:a17:902:dccc:b029:ed:32ed:e7d0 with SMTP id t12-20020a170902dcccb02900ed32ede7d0mr28204569pll.79.1620713721798;
        Mon, 10 May 2021 23:15:21 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id j2sm1140795pji.34.2021.05.10.23.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 23:15:21 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        renius.chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        seanhy.chen@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        totti.yan@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Fine tune GL9763E L1 entry delay
Date:   Tue, 11 May 2021 14:18:35 +0800
Message-Id: <20210511061835.5559-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fine tune the value to 21us in order to improve read/write performance.

Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 592d79082f58..73e01c3480a3 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -94,7 +94,7 @@
 
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
-#define   GLI_9763E_CFG2_L1DLY_MID 0x50
+#define   GLI_9763E_CFG2_L1DLY_MID 0x54
 
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
@@ -842,7 +842,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
 	value &= ~GLI_9763E_CFG2_L1DLY;
-	/* set ASPM L1 entry delay to 20us */
+	/* set ASPM L1 entry delay to 21us */
 	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
 
-- 
2.31.1

