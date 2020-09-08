Return-Path: <SRS0=ACzm=CR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BA9C2D0A7
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Sep 2020 16:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501D32080C
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Sep 2020 16:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBZoXnPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgIHQmY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731789AbgIHQmU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2020 12:42:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD49DC061A02
        for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2020 07:02:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a15so20273112ljk.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2020 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOh67eUnshJy3tnL7gq7fmPkRMPH6zbcOThNQKvvLWQ=;
        b=gBZoXnPd96cStaqkCHql1SkOzPWMNOlAQa91Sn+3MG73vY0tMXvqkXhBbRGcEb9WY8
         5josx2kl3sfwgdzsg35+aNRgImdl/zDiOdw1OWTR980hpIu7+w0xq26D9RPehEAiswxf
         CCG9tLzR4WRJ89dtNOQYj8SRmAlZ1VeBrsohVHyj/EGbVSpwUiQQXFT1IXmghmQOqz0D
         eAzCPdxH813hGJHVbLkhAZ1IyR1LAabNDxrbVtS9TUmIMCh2kP3KT0aLt3uSFbWhYifz
         py3aNF98EKkEqioveqfUhQIxFdsxjuzOyfCyanU/9+wXwNOS/wSddySQLOMvyC0Poc5r
         USDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOh67eUnshJy3tnL7gq7fmPkRMPH6zbcOThNQKvvLWQ=;
        b=db6V1oKV40i3y5okZn1n4TZITAo4jLlJ4LTz6+LkyTDG9q0CXXIH8Xjn6To2o1UPV8
         GTcz3EQXrZRMvE4kOQbdOCZf0/xjEvVvpvtDOIVw8DEnEbWgIROOdTrL7HnGV6p600ua
         vZzADZdaAlxp5iAQk1pUP0WSRrGRmYkHMkUHWci/6c2XGM53run0IY5mQ4+7p0YcT6/B
         bAD/WL3Kwzhh8hinlSYWKWAAIdF6vp7Xt8WybwL1yvWuT2F7Ytx8F/GNrMWvz4VOn7DB
         VouOr/R8AU7YSe/OQhoTDv8MWaU0MFpEAEt15emEKYDq7nmYOGSwAuDjeOlSHZ+3aPd6
         7jUg==
X-Gm-Message-State: AOAM533kSa2AJVobl+kXhCxPfJ0b7ztxrT44uhK5VCEUIUlb1xr48tMX
        8G5Wa+mb+/86Re/0SNOmaU3hTwr9AqfPOMgj
X-Google-Smtp-Source: ABdhPJxuuZzL/HJSE7QOMI33QKv/gqfnVPPbD3oH0Zxp8QZfxhtJikyVS9slvskuvDp5B5YhQ3tdjg==
X-Received: by 2002:a2e:7e12:: with SMTP id z18mr11980711ljc.388.1599573767458;
        Tue, 08 Sep 2020 07:02:47 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-44.NA.cust.bahnhof.se. [98.128.180.44])
        by smtp.gmail.com with ESMTPSA id 189sm10233543ljj.54.2020.09.08.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 07:02:46 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mmc: Drop COMPILE_TEST Kconfig option for MMC_S3C
Date:   Tue,  8 Sep 2020 16:02:42 +0200
Message-Id: <20200908140242.743234-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

MMC_S3C isn't ready yet to be built with COMPILE_TEST, hence drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index dc646359b4ff..185a2564e623 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -630,7 +630,7 @@ config MMC_SPI
 
 config MMC_S3C
 	tristate "Samsung S3C SD/MMC Card Interface support"
-	depends on ARCH_S3C24XX || COMPILE_TEST
+	depends on ARCH_S3C24XX
 	depends on S3C24XX_DMAC
 	help
 	  This selects a driver for the MCI interface found in
-- 
2.25.1

