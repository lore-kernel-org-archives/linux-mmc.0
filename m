Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137A1C54FD0
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 10:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4435206D4
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 10:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqAgyWF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgD0Kar (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgD0Kar (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 06:30:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EE8C0610D5;
        Mon, 27 Apr 2020 03:30:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so5103022pfx.7;
        Mon, 27 Apr 2020 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+MBCNDaLw3uQE6AgVXdsrI4+m1caWL4Ufysj/pafog=;
        b=qqAgyWF/2DUdL2/CJEqRS+BbSa4hMbmdEt/4d762uqgEWxO95ANdX62WbFLqETkM+X
         kpART+tYOYWahFR+HiWtkeIOBirkpF95mgczf0nsw3BywtSk70q18FfgV/XIflprJ4m4
         sMuJh0p74w/uno3rz/uMy5ETltHy/1P4Llkl9pFGwL1x2Ljoy+Vh6mIsjZMTscIPb0eO
         nCt5Halq9amuWpOAqBoVH2jKIxIJt4sLm5h/uSnFukWGQnu/7vWtjCuXXjtwEYU75qdx
         F/y3gOeRgnAhId4RLNvGACHEK/SJxIuFQTshJfKmaQjF1On/huwYYvVTvMv2rreN73A0
         OcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+MBCNDaLw3uQE6AgVXdsrI4+m1caWL4Ufysj/pafog=;
        b=OOfoJO2lGV8DPOYvAni+EeIMnQxOstfvtOY/Sqz18WSZQ5aS+QJHD+IhkDAd0mti6y
         7QiKKXr0GNcRwklc5MrKREcyukVvsESuOxUBl1wnVbZXHrG4+8w8n4DyanOEx6bBahxZ
         rD2Ajzr8tn86A7iyb9XoKtt1S9MMYbIbw00vZY6gKkDYVzM/JntkPBPdIxLfBtar7jVG
         zzpYFc8FNw6Ez7hCKJlL21z8thhiGTKK90ABuVqIvPjcDFamPwI4xytRgwyV511t4gab
         VJdhsUhL3SGi0jh4lfC8dM3PnC7GbqX2rxJEkG5O8Ez3JbVfxq0VEOM4nCK98CKHOlEi
         SYdw==
X-Gm-Message-State: AGi0PubU1IyMeRG8s1a+nKW1/h0QGzYD+SzBZ4bYS/2kZzI2xFhpj35i
        sowWolp9hMwMpB6xx1sUVtwTNd82
X-Google-Smtp-Source: APiQypJCwFXeuNCVc8cCXhqFJneZXNnH0wpU89wvK1KdOiPMhS5qG94Fl7kFk0wqde+yngVJAvavGA==
X-Received: by 2002:a63:ce17:: with SMTP id y23mr21384308pgf.194.1587983446412;
        Mon, 27 Apr 2020 03:30:46 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id i25sm11867975pfo.196.2020.04.27.03.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 03:30:46 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw,
        vineethrp@gmail.com, dflogeras2@gmail.com,
        Ben Chuang <benchuanggli@gmail.com>,
        Renius Chen <renius.chen@genesyslogic.com.tw>
Subject: [PATCH] mmc: sdhci-pci-gli: Fix no irq handler from suspend
Date:   Mon, 27 Apr 2020 18:30:48 +0800
Message-Id: <20200427103048.20785-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The kernel prints a message similar to
"[   28.881959] do_IRQ: 5.36 No irq handler for vector"
when GL975x resumes from suspend. Implement a resume callback to fix this.

Fixes: 31e43f31890c ("mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x")
Co-developed-by: Renius Chen <renius.chen@genesyslogic.com.tw>
Signed-off-by: Renius Chen <renius.chen@genesyslogic.com.tw>
Tested-by: Dave Flogeras <dflogeras2@gmail.com>
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

