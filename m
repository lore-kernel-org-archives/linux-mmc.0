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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FABC433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 11:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB8764DD3
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 11:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhBYLOL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Feb 2021 06:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhBYLNw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Feb 2021 06:13:52 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C2FC061574;
        Thu, 25 Feb 2021 03:13:12 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id a4so3542557pgc.11;
        Thu, 25 Feb 2021 03:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p37Q2U2usAvIKlqmjz2805mUMvZ9x/KKmC2ght6nM2o=;
        b=cn/BiB9R7U+mSNvJQA91EF4vQHwJHjh/0XaSh1KQpZ/6SYVqwtkIIagsI/TWyOPPJd
         nQByfNlL3foOEZPp1pZlaXwqcawWfotjXLZw7oJW18LDJqKId/rDINZOv1IEMgYJAKmr
         kydSOrdarWcSzqywhADB1ISZ5VJo6MvFwC2TgSk/93tL1dEXeYHx2LWW1tZi7JxUtm8Q
         kdCEAWRKaPGqQnl8fTu1OKGMo/VrdfMAMzCxX8lk+idsOWG0doQ0IAUyHCR/xFnLwzfM
         nWHoL+nsnOjwlWYoPzZoLFrCPWvRQyF8HY2d8w8AptceDxRAfvjxfyMAtOK1XMfLnL2Q
         ippw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p37Q2U2usAvIKlqmjz2805mUMvZ9x/KKmC2ght6nM2o=;
        b=Lj0Wvvb1/IcnVS4Tl8T/r8FvE0RKXTSSIrfHOddllPhO9juYEI8jYrQHDRm4Ryg4Gw
         Xcwyc5+eNckpp+x7o3guXoKfCazQNBuhn2eQvU+fgX8yFTc3E+eyuqvufVYmfAiUUnaI
         tn86jY12D2j+kPMQrBoF0E1G4/XYdzSmL5pirUnz+tlDz2t8DzmRWI/W5PbfAS1cWbbe
         26t3q5uWG5lcNSIxixeZDvEEfkG2aSmpzd2PqxYppT0Y6o1InYwGGejvrs9dd5CJ+cP0
         taJSHvGHH7jPBI4qBYYaH80WG6jkd7WyDzgqd2jLrFVr/i9hWoVzVpZASi+Bdwu5bOhH
         eBZQ==
X-Gm-Message-State: AOAM530d4v1vbA6uMOelohA+VyWnuGnCGiLQURRE615FmuWlgj8KokAr
        g4PTH+4pHRnqmcoHf10RESw=
X-Google-Smtp-Source: ABdhPJxwqsie0rFEvCl2hjsVFCgqtHFonqebIfRNoTUdgQo13W6KVwA+QNipwzXcf/g71ulmFQ0fdA==
X-Received: by 2002:a05:6a00:1681:b029:1ec:c756:7ec3 with SMTP id k1-20020a056a001681b02901ecc7567ec3mr2784510pfc.13.1614251592111;
        Thu, 25 Feb 2021 03:13:12 -0800 (PST)
Received: from gli-System-Product-Name.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id g3sm6800959pfo.90.2021.02.25.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 03:13:11 -0800 (PST)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Enable short circuit protection mechanism of GL9755
Date:   Thu, 25 Feb 2021 19:13:07 +0800
Message-Id: <20210225111307.62975-1-reniuschengl@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Short circuit protection mechanism of GL9755 is disabled by HW default
setting. Enable short circuit protection to prevent GL9755 from being
damaged by short circuit or over current.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 5606bdc08a96..7ba0fd601696 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -123,6 +123,9 @@
 #define PCI_GLI_9755_PLLSSC        0x68
 #define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
 
+#define PCI_GLI_9755_SerDes  0x70
+#define PCI_GLI_9755_SCP_DIS   BIT(19)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -547,6 +550,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	value &= ~PCI_GLI_9755_DMACLK;
 	pci_write_config_dword(pdev, PCI_GLI_9755_PECONF, value);
 
+	/* enable short circuit protection */
+	pci_read_config_dword(pdev, PCI_GLI_9755_SerDes, &value);
+	value &= ~PCI_GLI_9755_SCP_DIS;
+	pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, value);
+
 	gl9755_wt_off(pdev);
 }
 
-- 
2.27.0

