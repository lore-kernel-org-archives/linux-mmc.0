Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED11C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC6212076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndy1tJ6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGJLJ2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJLJ1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:09:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B33C08C5CE;
        Fri, 10 Jul 2020 04:09:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so2374060pge.12;
        Fri, 10 Jul 2020 04:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ge6tP7aJVA2/arYXridWtv60L0GDRBud+3BiIv4iGwU=;
        b=ndy1tJ6FUeK9nFenN0cCeY/pzoN2bM+a5uOvvfZkluarKIZJG3/oGA5L0cfIPvpEeA
         8r0CQvAXwFoZu3qtfitdpGhilU2/uSFamt9n+8IYg4wIrIUuY8iKeODTpG2O9jC0BKdF
         SMDEdNzXc7QaOlIz+1CImLRK8PmLURkQfxuGjQb4htN7/4o1BrA+0rA2cCuSI6014DAo
         AJa6nU7TIN6tocfIOzGYbM4scQVfUVVjT+BVCWSdwJ9IzJySvAfjk93zhrz6lLGycwSB
         juNIXBoNql4x9kkRUz8MTVpaaLQSYnjar7ffF7eALDVnoMINkArMCTSDULNLv1eRqgfH
         r1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ge6tP7aJVA2/arYXridWtv60L0GDRBud+3BiIv4iGwU=;
        b=B/wGM8z82haGLI/kD0zAxTHo/LxI+3j0IUsE2U8y0eTg+Ib/FPO7ZyIUZy0gC9J9jX
         BZ9bt6hQqtQl7aTVwaeEgqHrq4fLz0iL0hQJ31r6TGIFOv8NxFqilEUqFrlbQZtc+Xzg
         5ijwsEdz4vBmptrLurPrPoPjQE8+nzlfeubtO+7tGe4CNjkWOKenZYTgpQ2syTXNYu2Z
         AjriYvFDSCoLSSKNF4okmeqt9rDxI1f0of0tW/wOZxwn0EDIIWAte9hwtiG+oulbtG5o
         qilxz/BB5A4TVCBTYAxAtISH5jBrPezMRDIdPga3N3MKsBVRArYAAX7RHkB89qnpFARp
         nPLA==
X-Gm-Message-State: AOAM532fbeyUH59fz+EK7NWsz8cBNM7hSUDzkePzaujicNitNrmZ/Pos
        QceAHkZKP2YhKFI5zZoP1jo=
X-Google-Smtp-Source: ABdhPJzSpMVwQrKH6DooHAi6R2iQnhUlH8zT3quDLCPYiMmXpHoaYLoepA6KUHMqrdV4ZULbKsQMnA==
X-Received: by 2002:a62:4e44:: with SMTP id c65mr26530826pfb.283.1594379367138;
        Fri, 10 Jul 2020 04:09:27 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id m1sm5211496pjy.0.2020.07.10.04.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:09:26 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 08/21] mmc: sdhci: add a kernel configuration for enabling UHS-II support
Date:   Fri, 10 Jul 2020 19:10:10 +0800
Message-Id: <20200710111010.29345-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 3b706af35ec3..ffeef38264c0 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
-- 
2.27.0

