Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B3C41535
	for <linux-mmc@archiver.kernel.org>; Tue, 17 May 2022 18:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352049AbiEQSV3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 May 2022 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352160AbiEQSV0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2022 14:21:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD0118382;
        Tue, 17 May 2022 11:21:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so344054plh.2;
        Tue, 17 May 2022 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=qbw25+h7kWDog71rHZzhe0jgB5ZXhGJ80dI1qj26a2E=;
        b=jns8GOvBKf2iy29Y4pWAi0edGa/n1B8RKqdCa3GF4kjyDobrPXxmV4CR31LVxILl5U
         qGwsSa/+iuf34FPzDUKsnOu/zykXusFDYpbHt+ntD4XaRYSqDKXapLh0aNO6t72Ht6uk
         Tvh4t4YNhxzXZ64nZ36L8uie2aJuxHp8Oe6cTYYlw2eau6PGgPX1eG0md8Ctxi0Oq+2s
         OXDVGmR2aXmBhi3yIlZPIxAOHclHsmWbAOz4dXlRPdQmlOrfzQp+5hieN7xP2S3wGMNw
         5QRXISjo23dbitsGD/lUkSCMwKgTfJK7yL0YBv8r8VMwnnI+t9L0tUc1TWWQ+/d2a1dM
         3EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qbw25+h7kWDog71rHZzhe0jgB5ZXhGJ80dI1qj26a2E=;
        b=M55/mwvZkjT6fnkxEE6pzkuMZZPtprSspd7WMDlQRgWMH4bBQ2jWY05h6duIFMMk6D
         /df/Zf/2Mg7T53wx/8Z56Abi83lXAKec1x1YeJEa/SQ8/pxF2MUlOfbvy208oNn2UbSF
         4rSP1xul9sIw+VQhWVvgXQxRx/X0w+f6ZXpA5KoYroJxOR3o5emZ3+bAw4v0UHeCkTEv
         PjDwmqe4FBIYWQPUWr1CnyHt0wfG/SWJOwlRPrp9kvC2G3/kS8q5fZ90GcbUzZsuxOWt
         W2dFQegfiMKaotYhUY4INJm2kL7Uof4Ss8y27obUNdta7zj+KauYik5WM8KNEMDqYNmE
         gB+Q==
X-Gm-Message-State: AOAM530urSzyOD/VrmksmoVCNUhMktrz77pOGaZwcJw3HrlmJjwzOCAz
        lJu9XDuIUzsS9S4vIwR7QyA=
X-Google-Smtp-Source: ABdhPJyzmanT7BNcKgKRPoWkD7vYl/HN30uKWadjeG4e6e4zXHZcl5D/+Bsv/x08Wc5ufcCJtfjvZA==
X-Received: by 2002:a17:90a:9505:b0:1df:2162:2bb5 with SMTP id t5-20020a17090a950500b001df21622bb5mr18019441pjo.73.1652811683409;
        Tue, 17 May 2022 11:21:23 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id 125-20020a630383000000b003f5e0c264bcsm837641pgd.66.2022.05.17.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:21:23 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 0/2]  mmc: sdhci-brcmstb: Add support for optional sdio_freq clock
Date:   Tue, 17 May 2022 14:04:33 -0400
Message-Id: <20220517180435.29940-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

v2 changes :
- Added Reviewed-by tag to PATCH v2 1/2
- In PATCH v2 2/2 Used host->mmc->f_max instead of parsing the device
  tree again, /s/clock-frequency/max-frequency in commit message 

v1 Changes :
Sending the remaining 2 patches separately after implementing review comments
for the patches 3/4 and 4/4 as part of the following:
"mmc: sdhci-brcmstb: host controller clock enhancements"
https://lore.kernel.org/linux-arm-kernel/96fd3054-17b1-db42-9a44-a60485243807@linaro.org/t/
changes are rebased over
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git refs/heads/next

tested brcm,sdhci-brcmstb.yaml and driver with and without sdio_freq clock.

Al Cooper (1):
  mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0

Kamal Dasu (1):
  dt-bindings: mmc: Add Broadcom optional sdio_freq clock

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 25 +++++++++++++----
 drivers/mmc/host/sdhci-brcmstb.c              | 28 +++++++++++++++++++
 2 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.17.1

