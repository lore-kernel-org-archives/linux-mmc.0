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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC168C433DB
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 22:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999AD64E86
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 22:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCNWiX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCNWiN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Mar 2021 18:38:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91464C061574
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 15:38:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z190so29989236qka.9
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxGnvkWtUq48jaj6yUVV9sEVRsCwCaQv7HXysEcSVbU=;
        b=NjVoCeV2TKKC0l8umc0orT+dcCWThBXpFgtUurhv0CCDJ6nL/yz0G+JnC1I8Z6NIYV
         LrmOuIw7/73Gt+CExH4OnD555T9aimoACSBVOX+nmhs1qFnUGbs0nmmER41/G8T5lyne
         Qxiu7SaWzuu955O0vnZTTnYnECYzatAPSluUNa4BkfiU7rLEGMASnBEInjlzv7vz8pm3
         ZLdJxPs7j+GZ8tVmINElaXB5iS+Jc7spBZoZ26Z+tZ48UPXhQeNQu/FygBuXuA7r7c0v
         hRvYt8FK+qoasDIdv+mJuusya/zJZiPszCMECWiCdv2D829xJfaYtuFsZr34XpxKa2ZT
         c80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxGnvkWtUq48jaj6yUVV9sEVRsCwCaQv7HXysEcSVbU=;
        b=bIHI9PKa42S7Erl2yuUH+4MkMqyIdYsrBIYgs9kqEf2/JY+KmztPIh3ru3DeSLvN/o
         ivfHGJEOaL9KTBhtONvuMMt01VV6c5kd1hIYS1lSzC0hCDA61jpG0zQpwRn3cIqHx/FP
         Dt0QNGtApfC2n9NxWDH7Xlz6hQAx6+u0M0CfczCvQFoOR2nkz4AbhNZSGNcj1m5EuuFd
         sSRb2mFvQyqp2Ln7oTNL0ooH60gDcMmkMGq+L7sGW1UnnzQjh/91JLryE7o07woEwGV9
         2RHlNk4eNMzgmldrhDeVW0TmQH8n1V0YTBLXIQ+3AWh9NVMCogtpRRCVD/l2Dc3r+Bve
         WZTg==
X-Gm-Message-State: AOAM532O6temdQYgef20aY4Lu5MFToDRk/9YB8fnqY5jm2lGlkQzu6AK
        /EMHcp5IW668mVJL+SHKi78=
X-Google-Smtp-Source: ABdhPJwdJq+pLwQtHc2YaLwJ23YJpEj9A7BkMNNDXAuES0fq79EptHQH4h4ofAjopYlYclXemnD5CQ==
X-Received: by 2002:a37:5b43:: with SMTP id p64mr22202577qkb.131.1615761492842;
        Sun, 14 Mar 2021 15:38:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919:d9cd:fba7:d537:4be3])
        by smtp.gmail.com with ESMTPSA id x17sm4210542qtw.91.2021.03.14.15.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:38:11 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] immc: sdhci-esdhc-imx: Remove non-DT stub
Date:   Sun, 14 Mar 2021 19:38:01 -0300
Message-Id: <20210314223802.148413-1-festevam@gmail.com>
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

