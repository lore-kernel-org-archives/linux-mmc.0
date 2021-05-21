Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D382C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 21 May 2021 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29819613BD
	for <linux-mmc@archiver.kernel.org>; Fri, 21 May 2021 10:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhEUK1O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 May 2021 06:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhEUK1H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 May 2021 06:27:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA576C06138A
        for <linux-mmc@vger.kernel.org>; Fri, 21 May 2021 03:25:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j10so28897312lfb.12
        for <linux-mmc@vger.kernel.org>; Fri, 21 May 2021 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oog9kZJgpGJ5N8aQ8WVC8s7VGtvJFHDSbWmuwocv9KM=;
        b=ECjDFODKQMnIhmessO/4ZmF6bH9ia1QIPiL8Ylf1e3PyEqGL/bgsofLftVQG1KI3vp
         SfCD92bDE7cHsIBN4owKq+x94b/kjXJ5dj/+IKW+ynVJ1ZwHDbYnFePUeCLs5DWjGCHm
         4Z0hsyIflIR0Rj/jkLUV/Oir2aM8CJiEeFlamD0gR5LoRvFM32VrdIYwgaZlGO4p/WaN
         TaSfJpasa+trHyeAw8wVjeV/iSwy7Orq2vfHxVBJ6OGz7Mkqk1evEUaBd+W5KNyX7/Gv
         DisZ7GkV3ZsdHTj7yk0pvbYhehMUHpRp8H5rfikaauoC1UjPOlSSf0ZcPPrOYiP1ZAFb
         movw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oog9kZJgpGJ5N8aQ8WVC8s7VGtvJFHDSbWmuwocv9KM=;
        b=hfmlaKXv7BMvMq62LphTRz1P04UAp1TquwPdfIO/4lTU9e7rID5IXWXPtyUhxhomsv
         B4ASVBVii12N/Q6+/vXVUdu1jmlOCfbPNUrn/V89SgUjUH0SBykQdAI7Sms8eqh0v+nH
         EQDlVgP90Zo1pk1ZHSeoQhxKAGLTX4nV0l3iTD9W/S7oCd1GKJdoYLx/OqD/Fh4DXnXG
         CMMmlh+dypjhq2b0+Q9SRKhMoNCWygGXLSr5T6WWclBxB8UzWmT8y+Da+eT/DGIMhpKI
         +LMDjB73TTDK1iWOQvP8iDb10PaD6IrA8FoDuULLebxShAVWbLXzI9Z6Zkk2HKVag0MW
         lGpg==
X-Gm-Message-State: AOAM532j+/z3r8YbJeZwUAzT3WobogBbfRTRnnJsZyJ42BA/giqkTozm
        crNblAfJ+H9E7ZAfELe8hg19HA==
X-Google-Smtp-Source: ABdhPJz9vlPNLZDJ6Gq9B0lcepjOxTYQXTmhPmNPy4UHSpDvvz1Q1K//2IhDzhNe3WPwCNldrDLy7w==
X-Received: by 2002:a19:6b18:: with SMTP id d24mr1739072lfa.103.1621592743078;
        Fri, 21 May 2021 03:25:43 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id y8sm597214ljy.7.2021.05.21.03.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 03:25:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.13-rc3
Date:   Fri, 21 May 2021 12:25:40 +0200
Message-Id: <20210521102540.104166-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.13-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc1

for you to fetch changes up to a1149a6c06ee094a6e62886b0c0e8e66967a728a:

  mmc: sdhci-pci-gli: increase 1.8V regulator wait (2021-05-10 14:39:06 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-pci-gli: Fix SD-card detection on Intel NUC10i3FNK4 (GL9755)
 - meson-gx: Replace WARN_ONCE with dev_warn_once for scatterlist offsets
 - meson-gx: Extend check of scatterlist size alignment with SD_IO_RW_EXTENDED

----------------------------------------------------------------
Daniel Beer (1):
      mmc: sdhci-pci-gli: increase 1.8V regulator wait

Neil Armstrong (2):
      mmc: meson-gx: make replace WARN_ONCE with dev_warn_once about scatterlist offset alignment
      mmc: meson-gx: also check SD_IO_RW_EXTENDED for scatterlist size alignment

 drivers/mmc/host/meson-gx-mmc.c  | 7 +++++--
 drivers/mmc/host/sdhci-pci-gli.c | 7 ++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)
