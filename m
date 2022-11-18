Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B8C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 09:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbiKRJiu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241983AbiKRJip (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 04:38:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB5749097
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:38:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j16so7292251lfe.12
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUs/U8UWXwIGlb1bQsandtxXOXMS30Tnukg59tTXU5Q=;
        b=ZdhOkn3L3kPE7CBaKjCupDBlfZMCp9a0Lvp4vsOZtcrklNAo1Md6k+iTqPlz0qDATS
         MbAp1PuUGUhmExf8y40RpSvPb1LFrP0ahEQWrXSR1xr2AFHhZj6XmD4n+l1aesVFhDFq
         tBwTUNnzTCAu5KDxsRHV9Y/mAbwizoBO3T5/zknHrdFlLGPjC8kJLFVhzd53EMVQeyUV
         ZEnBKASMDqG6iytbDYyHWj3K/Frk0GtaltIlWC9Mm1VM68O5fhe/XyGMXTieiU3Jh+lC
         nBQS8pGgY/oTaptTn8RVOjJVbN8ktSAGA6IQS1TqgKEKYMEG+6cIcdGH6Gu7BG7LB095
         icOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUs/U8UWXwIGlb1bQsandtxXOXMS30Tnukg59tTXU5Q=;
        b=LTci09eP7C+R+2WhpmS0lJppxamdecrERWLZazY3IrjrnU+i4RBRJ4GI2lx/JE5Mbf
         McMNYIno1+66w/WakVonc08bXo9Z0MeBHsw5kizUPUAhKvtA58Qycgp2I2EYjVHxTjo5
         Zu3HJ4b7Zwp9FMLSiDhkx/RI+smj/eMmTY8R1Y8/HBsejLy1ddq/lBdyS0CPMhMpNQ1n
         LELR/2zM1Cd9WqLBacI1ddIxQQjIkAyD/fhiKqkNb+zh0+PcESyQz94jZScvpag+wjMK
         SaFfYdDMAZUqYyDdWiJq/hkQG09H3Fus0BVlm1Gh9NzvwV7rTuoeaiNxzs4AMfTaf8M/
         wMqA==
X-Gm-Message-State: ANoB5plz06HXfO4iv9lVDTi5vjXzNbzmgyfR6gS3zW9VLl5BKPK4a821
        Qvs4F1HEGnIYoMwSss8fcLuP85vlACSskQ==
X-Google-Smtp-Source: AA0mqf6HjyGvjYUtFqHO189lE4mjHUGDPygUNLppsV/Hq5lAX2L4dUwtZscsa9UntInpsDWxmwVyaw==
X-Received: by 2002:a05:6512:1594:b0:4ac:a453:7cc with SMTP id bp20-20020a056512159400b004aca45307ccmr2102606lfb.226.1668764321661;
        Fri, 18 Nov 2022 01:38:41 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id bf8-20020a056512258800b00492b0d23d24sm591329lfb.247.2022.11.18.01.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:38:40 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.1-rc6
Date:   Fri, 18 Nov 2022 10:38:39 +0100
Message-Id: <20221118093839.6361-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.1-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc5

for you to fetch changes up to 222cfa0118aa68687ace74aab8fdf77ce8fbd7e6:

  mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_put() (2022-11-16 17:00:39 +0100)

----------------------------------------------------------------
MMC core:
 - Fixup VDD/VMMC voltage-range negotiation

MMC host:
 - sdhci-pci: Fix memory leak by adding a missing pci_dev_put()
 - sdhci-pci-o2micro: Fix card detect by tuning the debounce timeout

----------------------------------------------------------------
Chevron Li (1):
      mmc: sdhci-pci-o2micro: fix card detect fail issue caused by CD# debounce timeout

Xiongfeng Wang (1):
      mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_put()

Yann Gautier (1):
      mmc: core: properly select voltage range without power cycle

 drivers/mmc/core/core.c              | 8 +++++++-
 drivers/mmc/host/sdhci-pci-core.c    | 2 ++
 drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)
