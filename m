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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56583C433E6
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 23:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAE664E68
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 23:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhCNXJB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Mar 2021 19:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCNXId (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Mar 2021 19:08:33 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E2C061574
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 16:08:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b130so30028984qkc.10
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3uS6eKQhnMVVFANhxkTCdz/iHAlCTQnyQNw8vfmtKsY=;
        b=Thr0BpyLtuKXrcNaFWIwAKIdFxnopFeYweHF54GXCalHzJWEz18uhQPVEMbLAlYOjN
         GGZjbqoJC70NUpEJyEGiPSBhcvsPzTUM1FXdJz7N+naE5wjzSVmntoFIMkri9XpkXyz4
         KjXE06mpOb7YGB3DUsftz3/sRmvuQaeSysWRJ1kD1kWwC5lI3YmBP0sSNgFGGMhpqhF9
         OtNDL0pvyT23hSNgKC5NxG7BaCmLQwrB9wcf9IsJJiN+F+9IR98y1XHOn6gigZqYh88t
         uxtB9CXHe/pb2hayCnsh4v8iKhjwKnChAK6SkgCRkbd8p4PHBeSOJKcADO4Pz6PwHWGN
         qmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3uS6eKQhnMVVFANhxkTCdz/iHAlCTQnyQNw8vfmtKsY=;
        b=WVGui65MSTxGJ3LF/cR6EvAYiT52DseWCV+CXhRBeB0UOTBoag7ARd/mjyYg2M/YtY
         i1aDlny+Ov4Sqcqis0uz1PflNVG4c0POzgdDWEztbDuhUSDrtSvQpzEz0Gbd5wJ6EIww
         B0pxeocjtVIyEzKlkKaXRQyuFu7UG61KwNGcduwDpC8KcLvECpr0T1XnsRTCFMw50g1c
         e/bY3uTz1jBH9uk1wfmZ65P3i1NfeNfa/35IWnL+9nipHRXiHjCCGB/13MImbHXbNmvJ
         DVH0JoYlQX5y33p6ZIVavMAZVcAHImpWIjm1VXYHNEC3Gr72gduulMHOn3KnQRMGNU5f
         KvTA==
X-Gm-Message-State: AOAM532l1XbfaTY+NdTVzigdTDlnmtRQy4UvCtjwGzoY/pdu753h2A5M
        Y6zCVajeoyFG6L0RUkFYUjs=
X-Google-Smtp-Source: ABdhPJya30z0N2tvIrtwhOUbuq6g1I1FNK8dxGk1NFWWSlxOMJlc4eKP4hkuAAqzXlwuHZx4RTSUDw==
X-Received: by 2002:a37:850:: with SMTP id 77mr461235qki.289.1615763312668;
        Sun, 14 Mar 2021 16:08:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919:d9cd:fba7:d537:4be3])
        by smtp.gmail.com with ESMTPSA id q187sm10980811qkb.36.2021.03.14.16.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 16:08:32 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: Remove non-DT stub
Date:   Sun, 14 Mar 2021 20:08:23 -0300
Message-Id: <20210314230824.148969-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

i.MX has been converted to a devicetree only platform, so remove
the non-DT stub for sdhci_esdhc_imx_probe_dt().

Also, make the driver depend on OF now. 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Fix typo in Subject: immc --> mmc

 drivers/mmc/host/Kconfig           |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b236dfe2e879..e911eb570fbc 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -278,6 +278,7 @@ config MMC_SDHCI_ESDHC_IMX
 	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
+	depends on OF
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
 	help
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 94327988da91..2a1fb1cd4433 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1453,7 +1453,6 @@ static const struct cqhci_host_ops esdhc_cqhci_ops = {
 	.dumpregs	= esdhc_sdhci_dumpregs,
 };
 
-#ifdef CONFIG_OF
 static int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 			 struct sdhci_host *host,
@@ -1505,15 +1504,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	return 0;
 }
-#else
-static inline int
-sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
-			 struct sdhci_host *host,
-			 struct pltfm_imx_data *imx_data)
-{
-	return -ENODEV;
-}
-#endif
 
 static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 {
-- 
2.25.1

