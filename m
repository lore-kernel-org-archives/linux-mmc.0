Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E3C7EE2E
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjFKTlq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFKTlp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D1D2
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso4160068e87.0
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512501; x=1689104501;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dCXyL73MENjnJLZrDVn/k8iJuoy5Z0Z1mdSZ8sB38w=;
        b=XK8sREUjk0GSyAhNQDJzl+5DxmiNPghVE+wm+pq45QHd9vbbPhYyj++UEZkAqUSr/N
         5DF3NS3l/6v/lgR0dFp41C5Hteew8/t89nhA8DXxBM4ZIYztriwQP0Zc6qu7MvHSUovM
         36VDk+RUA4HRYOYmt1IJcit+lCvWz+Mzk5vGfJ92dRzZYXZN96ieQtZSXpU7OGI/buOT
         meALOAlqSYQEq/jiGwDtoBxyS6GB6+F7oYAKaogR36mo9kvNDSnUcuLh0VOA4Y0R5ZUf
         uv7Y5RZlKAvkQRAvZE+GavJMw/mkqBol0o0d7QOYe/gTkRbYH6dp9CrS+VTaGd1hKpJk
         bixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512501; x=1689104501;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dCXyL73MENjnJLZrDVn/k8iJuoy5Z0Z1mdSZ8sB38w=;
        b=SdoaDAA+uUYYMSBBiGCbBYNX0Y8fajO7mKrqR9y9Ogtyy3jJzALpVXJk2wjgXvveA7
         g8WbxLXVxYKcxXKbS41Q9YtHi3H1uqFX8+J8Z9g+7c98jdgBIk2zIWEgW++oqis5tm3U
         RlM6Ylm3CrzJD8g8yRGOGR3bvAb5wdcT//JQ7V1bo2l8xzfOthZlqPI9ZfScRdw2eO+x
         +Nn1MRNtRq12xrMNh9OXORxJfTzonkvFXVwdH+UWX5jleMabwv5Dn3oYCwgFF/dkNPAe
         gWxgtNxWhzpyj8xOH/axBhjptA410HVTPPkmKUMH5vqACfmEXiLSek8CZh45qWAO6R0Z
         3mNQ==
X-Gm-Message-State: AC+VfDx6f9oItQuzZKMHB25ds0Oqq/hhW0e4xO5nrQDWc8jECu92FoDf
        oN3mTKUZCOFwoyxz3Q+yDnggCStWGKo2D0hihhA=
X-Google-Smtp-Source: ACHHUZ4dB6la9H99qaKDz3r4JiemAkTGYy9i0eOq6GbEuFY6SpCRtu6IimVSrhSiCXfIZ59y+lLbiQ==
X-Received: by 2002:a19:4359:0:b0:4f3:b4a9:a619 with SMTP id m25-20020a194359000000b004f3b4a9a619mr2622572lfj.40.1686512500535;
        Sun, 11 Jun 2023 12:41:40 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 00/10] Fix busydetect on Ux500 PL180/MMCI
Date:   Sun, 11 Jun 2023 21:41:26 +0200
Message-Id: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYjhmQC/42Nyw7CIBBFf8WwFsOjxdaV/2FcDHRsSWppAIlN0
 38XunOlyztz7zkrCegtBnI5rMRjssG6KQd5PBAzwNQjtV3ORDAhWcVqOo+8YVS/wtJhRBPpw76
 pUsCkYp1sGyB5qiEg1R4mM5TxE0JEXx6zx9zffbd7zoMN0fll1yderj9MiVNGRQOGt3CusMbra
 Cfw7uR8TwoxiX8oIlMQNWdSSF1X6ouybdsHVYBB6BgBAAA=
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series fixes a pretty serious problem in the MMCI
busy detect handling, discovered only after going up and
down a ladder of refactorings.

The code is written expecting the Ux500 busy detect
to fire two interrupts: one at the start of the busy
signalling and one at the end of the busy signalling.

The root cause of the problem seen on some devices
is that only the first IRQ arrives, and then the device
hangs, waiting perpetually for the next IRQ to arrive.

This is eventually solved by adding a timeout using
a delayed work that fire after 10 ms if the busy detect
has not stopped at this point. (Other delay spans can
be suggested.) This is the last patch in the series.

I included the rewrite of the entire busy detect logic
to use a state machine as this makes it way easier to
debug and will print messages about other error
conditions as well.

The problem affects especially the Skomer
(Samsung GT-I9070) and Kyle (Samsung SGH-I407).

It is fine to just apply this for the -next kernel,
despite it fixes the busy detect that has been broken
for these devices for a while, we can think about
backporting a simpler version of the timeout for
stable kernels if we want.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Unconditionally assign busy_status = 0
- Rewrite state machine states to just three
- Drop a patch that gets absorbed into another patch
- Drop patch to get busy state from the state machine, it was
  fishy, based on a misunderstanding and not needed
- Link to v2: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org

Changes in v2:
- Drop pointless patch nr 1
- Unconditionally intialize some state variables
- Use a less fragile method to look for busy status when
  using busy detect, should fix Yann's problem
- Link to v1: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org

---
Linus Walleij (10):
      mmc: mmci: Clear busy_status when starting command
      mmc: mmci: Unwind big if() clause
      mmc: mmci: Stash status while waiting for busy
      mmc: mmci: Break out error check in busy detect
      mmc: mmci: Make busy complete state machine explicit
      mmc: mmci: Retry the busy start condition
      mmc: mmci: Use state machine state as exit condition
      mmc: mmci: Use a switch statement machine
      mmc: mmci: Break out a helper function
      mmc: mmci: Add busydetect timeout

 drivers/mmc/host/mmci.c             | 139 ++++++++++++++++++++++++++++--------
 drivers/mmc/host/mmci.h             |  15 ++++
 drivers/mmc/host/mmci_stm32_sdmmc.c |   6 +-
 3 files changed, 130 insertions(+), 30 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230405-pl180-busydetect-fix-66a0360d398a

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

