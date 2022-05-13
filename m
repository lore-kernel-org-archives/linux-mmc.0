Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB316C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 13 May 2022 20:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383833AbiEMUTd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 May 2022 16:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377434AbiEMUTc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2022 16:19:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F703B2A2;
        Fri, 13 May 2022 13:19:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q4so8966173plr.11;
        Fri, 13 May 2022 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zu2lvxKQkZXRvBfdGyoDHis8Q6/nWoDKB0YB1wl3/Sc=;
        b=Dyh1VI5vx8CtUVshbJSgPUX9o1Pu98VyKKm7gm8duQVsyi6T6PltrgD6IRb6Mlyq5V
         0VJYrqt9tScbCBzGzJEglHrEIqsev7URLwkc8YUYY3b7tI5TdiD+DmATMqZqpBB+m+/J
         hQs18gYxWpI/15LqqgrwI6H0bHyRVC/mlVirfgoP41fJSMe/3zsifLsh1zAYYJW/bvmK
         AyfGUNYafJs8gUra6haA/la9MlushUDb1y3dDeQtagv0m7JwWsxf19rUWJ8YWkGFyFIP
         mKpJ9l1rmFPSBOs8IwQ8nMkmR2LEfG3D/DvmMeZvLIkHFNV/2WLPFj2oT+8qVmof+sh2
         87Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zu2lvxKQkZXRvBfdGyoDHis8Q6/nWoDKB0YB1wl3/Sc=;
        b=kRKY7ssPRsW/lc3YgOFFPhGplSTv4HNuTXOoioSs2F0hzCTvXEuUurfjSbPJA6OLyq
         UWy6PPGk7JxF1a1w1kgeMEFdbkIMAWGXKKi3bJMqtnEh25R0Rk/zCk24BfoY+dc/oGE1
         oQJDEQvIVlAyC8/WXNoQLNotCmxRZe5btlt0ESnAcWWNFdlPXvCqoDaBzz7EMHn02y2X
         RhXMdKpAxjf6Mr9T4x/qgQYbIGm7rz43au6qx51eVkEMghYJxAI0GKGe86tfRnvuqigE
         6LZTusIvNG9wN0M5a2u6RbqLeJqo6zKvTmmxMBq+XLvz0LbSeAEkFiUkD+8FwVDESAJR
         PgTg==
X-Gm-Message-State: AOAM5300o3Qo/64T+vIS4kE06Qp4nSePNiOYeqDu8tbcc09fhWgdR9FC
        2zPsEXab/BDoJwKCFLjhVAA=
X-Google-Smtp-Source: ABdhPJwov4uKfWaDtLMbwBxbngD0TVsII/RuyWYTSAMMPeALyHAXKYsyNRg77DM8+jI3kn/4rVI94w==
X-Received: by 2002:a17:90a:cf:b0:1d9:44ad:2607 with SMTP id v15-20020a17090a00cf00b001d944ad2607mr6513714pjd.25.1652473171499;
        Fri, 13 May 2022 13:19:31 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id b190-20020a621bc7000000b0050dc762819csm2182229pfb.118.2022.05.13.13.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:19:31 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 0/2] mmc: sdhci-brcmstb: Add support for optional sdio_freq clock
Date:   Fri, 13 May 2022 16:19:05 -0400
Message-Id: <20220513201907.36470-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 25 ++++++++++++----
 drivers/mmc/host/sdhci-brcmstb.c              | 30 +++++++++++++++++++
 2 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.17.1

