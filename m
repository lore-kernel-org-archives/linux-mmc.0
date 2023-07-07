Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A79EB64D9
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Jul 2023 15:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGGPJd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjGGPJY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jul 2023 11:09:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C3268C
        for <linux-mmc@vger.kernel.org>; Fri,  7 Jul 2023 08:09:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fba03becc6so4021376e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jul 2023 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688742561; x=1691334561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vrdg0BN8YeBPDc9Z9UP3CnoTFMFzGJE30KoHXN+rRA=;
        b=sFjOsKeMEC/86xCtbSTI4Tawd1k3QfcsXGfWApGBL1x19uMmxtfKUPkPuG8FFNDM2S
         OpZ0fLCttpFipoo5Ezw88q1vgRSIQDKvd96Ur4da02dF7cWUYX9ZyB2uOu/zQlmkprpD
         PpIZ3ecFS44Ww7k/DjogXpUrAg3q3L1HeGeAJ4O15de+T5rEdVOYADNPxEEDRl+QGAMH
         dtG8hloMLzjYezyL1eamIPX+3OKgGcy2m6wL01nD53203aJC6W3vtYxwqHdgmEwyoCvV
         mdy2wF4ECDye1arJb4I3o62REe66ZPU0j1r/ySNGNUP73hEMtql2OR/lt9FrmrNZLwWM
         XM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688742561; x=1691334561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Vrdg0BN8YeBPDc9Z9UP3CnoTFMFzGJE30KoHXN+rRA=;
        b=CBWrIkQZWJ6lWHs4e/Tu3nHEphOFiHWZ49tmAhlp1tiJd7iWFpPiFqxRM629peWA1w
         XJMrHb7KI137wE/RFZ4H4W0oObQ/UiJaLOhTI1TWVM5dMQO1ghjjntWoRnWzqjB1WphI
         g3lSrjFqGQhzJLGK5SYHC9EirM6MRjjgH3e/gmSwk+ppuH7LWpteMxocT+o/c9JFH0Kk
         kcbbyFDX53KO9MNykQLEIOtbpr+OCw6Xu3pXiOSYsu/4pwwxqO7195jO5PwcmMOzjlP8
         hFf9NHAW+SVRsktsZoXPoxmD85nIVJQTHpnoXoFiNS1ybBV0/GznJp/p4jGM99IRWDIo
         L/4w==
X-Gm-Message-State: ABy/qLbFZZW35CYtsCuZNUQ4tsvHZdL5iaVxhL4G4eh5KVpUbGdovOkZ
        G76zQ4EBauyYt8x65/Y+I1sNcA==
X-Google-Smtp-Source: APBJJlHUCfOsWmEr/nU2X4bUtXexNSuTsdr3Fo86I7TLAV/FuqEMGf0Lzv4Rf+oayoRyWWpP60NnuA==
X-Received: by 2002:a05:6512:2251:b0:4f9:5807:aba7 with SMTP id i17-20020a056512225100b004f95807aba7mr3390088lfu.27.1688742560970;
        Fri, 07 Jul 2023 08:09:20 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v25-20020ac25619000000b004fb745fd22fsm716004lfd.32.2023.07.07.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:09:20 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.5-rc1
Date:   Fri,  7 Jul 2023 17:09:19 +0200
Message-Id: <20230707150919.724185-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v6.5-rc1. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e55e5df193d247a38a5e1ac65a5316a0adcc22fa:

  csky: fix up lock_mm_and_find_vma() conversion (2023-06-29 23:34:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-2

for you to fetch changes up to fa700d73494abbd343c47c6f54837c9874c61bbe:

  mmc: Revert "mmc: core: Allow mmc_start_host() synchronously detect a card" (2023-06-30 14:06:51 +0200)

----------------------------------------------------------------
MMC core:
 - Fix regression of detection of eMMC/SD/SDIO cards

----------------------------------------------------------------
Ulf Hansson (1):
      mmc: Revert "mmc: core: Allow mmc_start_host() synchronously detect a card"

 drivers/mmc/core/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)
