Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE555C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 06:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EF020715
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 06:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="s3WBzOtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgERGIp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 02:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERGIo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 02:08:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91124C061A0C;
        Sun, 17 May 2020 23:08:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f13so7951211wmc.5;
        Sun, 17 May 2020 23:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzDmmSRgID/AAT9U9NADJh+Q7oTNQ3LSGXH6EEbMns0=;
        b=s3WBzOtQG0ZljGSteUJ2eRPFU1efr1bExm1oTwdqFkxMXumhLyZ2lZVMFcsVD0Ogw4
         6oGpVTwLaDHkoO6WCqexPfswEoaAK8HpgI+TJI5uj7WIXHCAf9lE017pHW3WE4l4IcBZ
         Apbb1thutl/X57y+xux0VVIHQ4N+eglWBDjSeKzFoD0XlWBcZ5lCj6OULveC0hfKSgBi
         aEaWNYQfScsjCUzYeAlCR+Qu70cDDpOV7oNE9hECvpH1t2fzMslk0c03S3QaCWy+FNro
         Mgm2YA1uKMteGjkXRqX6xdAiIMDRKGDVbfnh8QkNXbMO8D9vxPPi+IzyvhkAoJo3AKRe
         Bh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzDmmSRgID/AAT9U9NADJh+Q7oTNQ3LSGXH6EEbMns0=;
        b=dnx3M//6a6NljzPrzdbEA8auMBbeEK3WIRYWifdCP2li0YQr7qW8TGotSbPQrSXqXI
         KJ29mHFMoimBntCidvZymaZuSb82AKSE86748tMOPwQyy9NDGiljDERAlvsVoRw3UGDh
         Il8m+JoK71bWrJOSh8+3etOZKL/lYaN4Q1Jmepicu1PNlC/uvnrxQcpo/aauzXowi/Ac
         GGYoKsTHJvnEdW/dncgTTOr5xr4/iB4kT01CEXzDFA5e2YO6Ij5r+BWIegyGdnmFnG2t
         CN6mTh/Q2+vdee+oYo84GLwzuGcV6T/pRjb2msoHrPKOwaASaaj9fFWakRlwxe4KsrGB
         xq9g==
X-Gm-Message-State: AOAM5329szlbOOqViKmcxPdOqqdFM/Zy5fzXBPp7b7OlJc36/9LaWQpn
        C+r4EctdkGQ3GpHQpdtppGM=
X-Google-Smtp-Source: ABdhPJxHHbeWWsbf/7SLYQQSyy4HAmj400J9BP8xOtLUkcaJuTQaA8l4sft05aKFWuA6QJi4ZtJBCg==
X-Received: by 2002:a05:600c:2dd0:: with SMTP id e16mr18593643wmh.121.1589782123183;
        Sun, 17 May 2020 23:08:43 -0700 (PDT)
Received: from localhost.localdomain (p200300f137132e00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b19sm16120469wmd.26.2020.05.17.23.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 23:08:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] mmc: host: meson-mx-sdhc: fix building with CONFIG_MMC_MESON_MX_SDHC=m
Date:   Mon, 18 May 2020 08:08:11 +0200
Message-Id: <20200518060811.1499962-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For an x86_64 allmodconfig build Stephen reports that building
meson-mx-sdhc-clkc.o warns that MODULE_LICENSE is missing and when
linking meson_mx_sdhc_register_clkc cannot be found.

Compile the MMC controller driver together with the build-in clock
controller driver into one module rather than using two separate
modules to fix these issues.

Fixes: 53ded1b676d199 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/Makefile                                 | 3 ++-
 drivers/mmc/host/{meson-mx-sdhc.c => meson-mx-sdhc-mmc.c} | 0
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename drivers/mmc/host/{meson-mx-sdhc.c => meson-mx-sdhc-mmc.c} (100%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 8bcb420e071c..8f459259181e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -68,7 +68,8 @@ obj-$(CONFIG_MMC_VUB300)	+= vub300.o
 obj-$(CONFIG_MMC_USHC)		+= ushc.o
 obj-$(CONFIG_MMC_WMT)		+= wmt-sdmmc.o
 obj-$(CONFIG_MMC_MESON_GX)	+= meson-gx-mmc.o
-obj-$(CONFIG_MMC_MESON_MX_SDHC)	+= meson-mx-sdhc-clkc.o meson-mx-sdhc.o
+meson-mx-sdhc-objs 		:= meson-mx-sdhc-clkc.o meson-mx-sdhc-mmc.o
+obj-$(CONFIG_MMC_MESON_MX_SDHC)	+= meson-mx-sdhc.o
 obj-$(CONFIG_MMC_MESON_MX_SDIO)	+= meson-mx-sdio.o
 obj-$(CONFIG_MMC_MOXART)	+= moxart-mmc.o
 obj-$(CONFIG_MMC_SUNXI)		+= sunxi-mmc.o
diff --git a/drivers/mmc/host/meson-mx-sdhc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
similarity index 100%
rename from drivers/mmc/host/meson-mx-sdhc.c
rename to drivers/mmc/host/meson-mx-sdhc-mmc.c
-- 
2.26.2

