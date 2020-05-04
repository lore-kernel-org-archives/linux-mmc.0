Return-Path: <SRS0=85Gt=6S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EF0C3A5A9
	for <linux-mmc@archiver.kernel.org>; Mon,  4 May 2020 06:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC0C20757
	for <linux-mmc@archiver.kernel.org>; Mon,  4 May 2020 06:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCfsD3Y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEDGlI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 May 2020 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgEDGlH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2020 02:41:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BCDC061A0E;
        Sun,  3 May 2020 23:41:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so6424516plr.0;
        Sun, 03 May 2020 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtZ+Wyc4E0007em3u6MhGxUECw6up8i8wUSsz6BGZx8=;
        b=bCfsD3Y1CE5TJs+fmds80V7zT1nRqvrRHTw3HVnR/agvIRfXobQT/Pxaw9FcVVHlol
         FHtfbef3WpHMTECo/HdutM8C0GzP6TlQCb4GdryN40GkI8UHspj+q47v9YtmC7zaKLjS
         +/28+faW1yThakqArJLNaKbfK9NBs8HNpi/9+c3kwqTj9pZzCJbWYMpDGzDiIzWKy+uV
         eX3FwzFtVbqlWaPNN628I5d7BeJHgesrHO4LMesOIeXgukfTlz5CzPhJRnosAKPZyuJP
         HkCyOlkMzNJJJIZekB8w7VSZ4GpMLh/Qx9g01zBCv8ShZpq4XyPp3XP6XD/XXiq2mZMC
         yIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtZ+Wyc4E0007em3u6MhGxUECw6up8i8wUSsz6BGZx8=;
        b=sNYvR+A6I/05hs922QtkymdqYdHKNsCK+O3pzp0XejUJOQHTtYU/wPAdfzRuB9Qn9P
         WDHf/psXUWvDXYqIjshS6nkTJ2ggmbQjF92kL1B6lSvo2GuDW93s2wafTyeIQjsrB5KU
         LlyqGw/uHWkKOx/qOq6DvjsLVw5mUrlEimJ4bl8vSfY6ou4FADQa305Qa47Y+g81R2dT
         Zvwa4Q+lD7pnDN6PzmDb/WE+lEwmQ/Nukz0J/JEvgAnGbBDHXQCXyu8b3Egu84bYsXLk
         fNteqkpaoNjcyl8ztsSwSYWR3vyvEyLRBlrarfarga4AF5kOpIc1AC60DK4NqyYhtn07
         G+gA==
X-Gm-Message-State: AGi0PuaMIeJ36PA4aOlGH3qT/d3ZEa5tz9kTa3dPYY1EZNCgmToDDDN7
        BXDm8gMy8pXSg+F1wHqXjP8=
X-Google-Smtp-Source: APiQypL3OPN+4PXziyzrf58VLnw7T8DYElpx6YY/SBMGbTM9dK5j9x8wucnJtB3SAVVyobqnnK6fBw==
X-Received: by 2002:a17:90a:d3ce:: with SMTP id d14mr15192121pjw.46.1588574467038;
        Sun, 03 May 2020 23:41:07 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id k4sm7002300pgg.88.2020.05.03.23.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 23:41:06 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, renius.chen@genesyslogic.com.tw,
        custos.mentis@gmail.com, Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Fix can not access GL9750 after reboot from Windows 10
Date:   Mon,  4 May 2020 14:39:57 +0800
Message-Id: <20200504063957.6638-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Need to clear some bits in a vendor-defined register after reboot from
Windows 10.

Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
Reported-by: Grzegorz Kowal <custos.mentis@gmail.com>
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index ce15a05f23d4..8170b659f2af 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -26,6 +26,9 @@
 #define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
 #define   GLI_9750_DRIVING_1_VALUE    0xFFF
 #define   GLI_9750_DRIVING_2_VALUE    0x3
+#define   SDHCI_GLI_9750_SEL_1        BIT(29)
+#define   SDHCI_GLI_9750_SEL_2        BIT(31)
+#define   SDHCI_GLI_9750_ALL_RST      (BIT(24)|BIT(25)|BIT(28)|BIT(30))
 
 #define SDHCI_GLI_9750_PLL	      0x864
 #define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
@@ -122,6 +125,8 @@ static void gli_set_9750(struct sdhci_host *host)
 				    GLI_9750_DRIVING_1_VALUE);
 	driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_2,
 				    GLI_9750_DRIVING_2_VALUE);
+	driving_value &= ~(SDHCI_GLI_9750_SEL_1|SDHCI_GLI_9750_SEL_2|SDHCI_GLI_9750_ALL_RST);
+	driving_value |= SDHCI_GLI_9750_SEL_2;
 	sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
 
 	sw_ctrl_value &= ~SDHCI_GLI_9750_SW_CTRL_4;
-- 
2.26.2

