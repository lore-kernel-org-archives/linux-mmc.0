Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F05EC4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 03:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiLBDNw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiLBDNv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 22:13:51 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE85A9CCE
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 19:13:50 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id h193so3318840pgc.10
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 19:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/KCyW/nZsCSOBqrMJLS3BfqoCX4HTe2xd1fQxSnYf4c=;
        b=Mgl3zQz64SSTsWS5jS3ZAVpbPf4ufwqiaqntCB5pAiMQXUrS9nQWsnbIEndDrjN5Ic
         Ue7BehdwCUNS02VQpUbrYG5E2zKMgVddhWykQtijzZ6RfV/T9SioCLPes/q0Kk4Eg6xy
         L/TWFrycIj/XCYHmlKkGS4BACNlygdvmCSBSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KCyW/nZsCSOBqrMJLS3BfqoCX4HTe2xd1fQxSnYf4c=;
        b=V8kQJ8KgL1y2TuKTxn1zjpiQMjAjtKiGthZB5GOltIew8Ynl/stOfMkbo6WEs4q16D
         lzaPlx8Y1gRlbMATrgvKFIOdhaw6qAorcQ7opQWleN9CBoCecb94xYwA6IY81cat/Szb
         GRPJs++2pm97XhP4Ds56uqLkcHpupckwjlH1+jVZJfIYPBXUu6nsV1x2PbJNjGmjZ++o
         xMKdait+Lk/kMuIVtNHez2P3SDKlhSl03cXpf6JaJFg1SnR4iUQ7jn+SFPY+LAv4836q
         Q2pFMdlNm/LbhhMHe0E6i9XSUpBj/0kch54/9V1v4dDiPYzskBP8Bv0MBw9YFKr7cuw6
         U/Kw==
X-Gm-Message-State: ANoB5pkn2XSrGdyPBN6HpwrupcR9AMwU5UYU5cnAebcrCpZ9KoXorusX
        ZjH2XbA8duOKOmaJD7kqroVepA==
X-Google-Smtp-Source: AA0mqf4bsC0ceRf9eG10Yhj6Qr71xtd1D/giJttzYDpCc1/ktkNuFv9ydePp+pSyzGPXrnj7W5/EyA==
X-Received: by 2002:a63:db0a:0:b0:459:35b1:1396 with SMTP id e10-20020a63db0a000000b0045935b11396mr46503851pgg.593.1669950830237;
        Thu, 01 Dec 2022 19:13:50 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id jx24-20020a17090b46d800b00213202d77d9sm3708410pjb.43.2022.12.01.19.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:13:49 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 0/8] mmc: sdhci-pxav2: Add support for PXA168
Date:   Thu,  1 Dec 2022 19:13:22 -0800
Message-Id: <20221202031330.94130-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a revival of an earlier patch series from 2013 to add support
for the PXA168 SDHC controller, with an additional SDIO IRQ errata fix.
It also cleans up the clock naming to be consistent with the existing DT
schema shared with the pxav3 driver (in a backwards-compatible way).

Here is the original patch series this is based on:
https://lore.kernel.org/linux-mmc/1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com/

Note that I left out the platform_specific_completion and clock gating
changes from the original patches. They both seemed controversial, and
don't seem necessary based on my testing. I've been running this code on
a PXA168 for months without any issues.

Changes in v2:
- Fix mistakes in devicetree binding
- Use cleaner code for pxav1_readw suggested by Adrian
- Switch to request_done() and irq() for SDIO workaround CMD0 handling

Doug Brown (8):
  mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
  mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
  mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
  mmc: sdhci-pxav2: change clock name to match DT bindings
  mmc: sdhci-pxav2: add optional core clock
  mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1
    controller
  mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
  dt-bindings: mmc: sdhci-pxa: add pxav1

 .../devicetree/bindings/mmc/sdhci-pxa.yaml    |  19 ++-
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-pxav2.c                | 150 +++++++++++++++++-
 3 files changed, 163 insertions(+), 7 deletions(-)

-- 
2.34.1

