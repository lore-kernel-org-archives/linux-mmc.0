Return-Path: <SRS0=wlIT=6I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CA7C2BA1A
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 06:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80D120700
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 06:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoUe1c1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgDXGUb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgDXGUb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2020 02:20:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9493C09B045;
        Thu, 23 Apr 2020 23:20:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h12so2446406pjz.1;
        Thu, 23 Apr 2020 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F1VyN8gTh8qYHhiebbZzcfoaBxGNctjua1hP2wX4UKU=;
        b=UoUe1c1I9GY0zu5k2eoEc9v09ZNhIRf/uWXRdIMvXi4UIb9wlU0WdRrc5i396pcckW
         0LswgqLl65pigRteofvZrlUUEFfKClJXX7Mh7qP1w7u69fjxa5dTBHYW6XHwPuJoj1+E
         QciVP8zJS5tsDsa2vyxLj14EPKzX7aNEWK9FyrJatFEFa1nVQU1igJOZ5oEEFBT7bltD
         3yJ9mNj39qfexYMDfECAMaRwTn2Ep0THTdvNi4JxMg5VnBxpVbgLibaRqqYmk47ZgEkR
         bo6gB1PSRy67DLXHvRZ+BofgrJAwgXDqQy7f5Cj2L4afHorXWzA6ilh/vXC38OP+cKw5
         NAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F1VyN8gTh8qYHhiebbZzcfoaBxGNctjua1hP2wX4UKU=;
        b=Hz+flNea+GcZ+DzHBuw38A/OQoBKtuS8EB+4F3SL77U+kWI6NX9Kh764DqJAwFuIuC
         UKMTa7LmybZLWIRtAtG4r7684pybC3OcEjCHw8R8gbvnpdkZc8bvJdDF8JmPsfYqDDK3
         3aOLJy1vqedmeiuXPn34E23kf0AL2FtYQziv/3471UPxCTc1TrpQmVrTCOo4raVzs3K6
         Dc3ihNTajVhqT+MO4bu2Dr+3ROQOelFDYcZ4eXzzDa/trvRgeeJF03h6JquenqVxBJ6c
         aww9pj+2BT2Bt4welXK+X6M1BQ1mnx0W40d/RXXR3VOw3Kq18FHFHeGGSPWy26237EFf
         OjHw==
X-Gm-Message-State: AGi0PuaVodddv1I4aSZUxxffoybUoGCLLCAMI85y1lcWGwhPjft9xtLa
        JAFeB+6wLaFSrLsx35XQ0KY=
X-Google-Smtp-Source: APiQypLB1Ph90wwN2E3GmhBZBPOMPf/k9TT0D4KKYTKFjTGvqj/r7cKPzBDQO7IBsLChSe7KdohkOA==
X-Received: by 2002:a17:90a:eac5:: with SMTP id ev5mr4632377pjb.173.1587709228971;
        Thu, 23 Apr 2020 23:20:28 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d17sm3963245pgk.5.2020.04.23.23.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 23:20:28 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw,
        vineethrp@gmail.com, dflogeras2@gmail.com,
        Ben Chuang <benchuanggli@gmail.com>,
        Renius Chen <renius.chen@genesyslogic.com.tw>
Subject: [PATCH] mmc: sdhci-pci-gli: Fix no irq handler from suspend
Date:   Fri, 24 Apr 2020 14:20:22 +0800
Message-Id: <20200424062022.4659-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Kernel shows "[   28.881959] do_IRQ: 5.36 No irq handler for vector"
when GL975x resumes from suspend. Implement a resume callback to fix this.

Fixes: 31e43f31890c (dhci-pci-gli: Enable MSI interrupt for GL975x)
Co-developed-by: Renius Chen <renius.chen@genesyslogic.com.tw>
Signed-off-by: Renius Chen <renius.chen@genesyslogic.com.tw>
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index ce15a05f23d4..7195dd33ac3d 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -334,6 +334,18 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
 	return value;
 }
 
+#ifdef CONFIG_PM_SLEEP
+int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+
+	pci_free_irq_vectors(slot->chip->pdev);
+	gli_pcie_enable_msi(slot);
+
+	return sdhci_pci_resume_host(chip);
+}
+#endif
+
 static const struct sdhci_ops sdhci_gl9755_ops = {
 	.set_clock		= sdhci_set_clock,
 	.enable_dma		= sdhci_pci_enable_dma,
@@ -348,6 +360,9 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
 	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
 	.probe_slot	= gli_probe_slot_gl9755,
 	.ops            = &sdhci_gl9755_ops,
+#ifdef CONFIG_PM_SLEEP
+	.resume         = sdhci_pci_gli_resume,
+#endif
 };
 
 static const struct sdhci_ops sdhci_gl9750_ops = {
@@ -366,4 +381,7 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
 	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
 	.probe_slot	= gli_probe_slot_gl9750,
 	.ops            = &sdhci_gl9750_ops,
+#ifdef CONFIG_PM_SLEEP
+	.resume         = sdhci_pci_gli_resume,
+#endif
 };
-- 
2.26.2

