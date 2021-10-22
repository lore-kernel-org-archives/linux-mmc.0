Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E0C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 05:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B257610EA
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 05:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhJVFuG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 01:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJVFuF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 01:50:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD75C061764;
        Thu, 21 Oct 2021 22:47:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w19so2479183edd.2;
        Thu, 21 Oct 2021 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uL0ei4DZotMP7IZG62lSdzllNRPM+WuMifRGvsCm5Y0=;
        b=Gfo9/kSPS1mzEOqZndYFxgaL2Ieez1n51Vy4Rx0ZZUUlvybJSnOM+kpdvNZxhDTTgN
         Ue9Lui+YbqfcTD6emTIyvDUXaSRdsgACHP+ZmDuJxZcrKsLBAoaNg5S3ju19wD7V/AlZ
         85gEIIAsQH5I4RGklmybbVlPf3BdtUfTywil/P33yrXGeCcLvA2XD2eaYyYzoRF89zIK
         t68q2oyfKLrb4kwV1Y2y3gcF4NnLo2BQtH8iwuEeotOCnElFee8SN/3pchfXDWxEM4YQ
         i2aaZLFf8wUp8i0MKN63XG8ljnUumxz5mFg98EwIq2NZDvMNPwv1o7RaAkJOhIN31lur
         CJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uL0ei4DZotMP7IZG62lSdzllNRPM+WuMifRGvsCm5Y0=;
        b=ATwnhndP/N+mMqGOY1Nq3qm7npgIZFk5RjRcWo3GHSo6Flw6dJNdoTKN14mUmi63MG
         4QwkHkI0CZExXMG1D4JYrpcU4MnNfBi31WwZdtjm9VV6C9EdxyTVZZJAMrm8bLQlESOe
         D5sRTjgB8nCWX92arDVzgfaD+vu7gCVMQp5ALtJzHKCJxUllhgUtSP/ts/tCDhruKZbx
         4CEXadvuF8n7AhrlDieqUHRyHZDLYs29jIvdemOpqAeMuO8URpqwvR+f+gZL05bZbKah
         16hrBVg0hcd2b/CdpnbynrK0njAFUYYmmAqOIHOBWf+R/MJFX6lRzJE62nGeeP5+HYys
         q8Bw==
X-Gm-Message-State: AOAM532s5y6HZ6cj8GBD9c89rtxd85idlJiDL0FPc5Y3RVRRBDad55sx
        Og8mjUGd9qMGEg0VNb6QgiI=
X-Google-Smtp-Source: ABdhPJzdceQ4NX1eDxFYKHsQYasBmMZPHKS/tsxiUuUz0DkE9FBiGatQD5jVnLTrsq2cLKXhrjXNyg==
X-Received: by 2002:a17:907:d8c:: with SMTP id go12mr13241072ejc.472.1634881666757;
        Thu, 21 Oct 2021 22:47:46 -0700 (PDT)
Received: from localhost.localdomain (i5C74E2CB.versanet.de. [92.116.226.203])
        by smtp.gmail.com with ESMTPSA id q21sm3703271edi.58.2021.10.21.22.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 22:47:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: drop obsolete file pattern in SDHCI DRIVER section
Date:   Fri, 22 Oct 2021 07:47:40 +0200
Message-Id: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit 5c67aa59bd8f ("mmc: sdhci-pci: Remove dead code (struct
sdhci_pci_data et al)") removes ./include/linux/mmc/sdhci-pci-data.h;
so, there is no further file that matches 'include/linux/mmc/sdhci*'.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    include/linux/mmc/sdhci*

Drop this obsolete file pattern in SECURE DIGITAL HOST CONTROLLER
INTERFACE (SDHCI) DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20211021

Ulf, please pick this minor non-urgent cleanup patch on top of the
commit above.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44c590b762d1..c47ac3e938b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17024,7 +17024,6 @@ M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci*
-F:	include/linux/mmc/sdhci*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
-- 
2.26.2

