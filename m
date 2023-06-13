Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C420EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjFMUec (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjFMUea (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF2892
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f762b3227dso447748e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688465; x=1689280465;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kcednvuw8fADgko4gaPCVbyMHgDDWwuaOkWQxVwp51M=;
        b=pnMxNNJfdw1IBpNxhkCM6K0PzTpizLvKArBACiw75rZaJlDHN7J0xh4QeXnjC90UAh
         I8Ffae/S2VH5HPur6P4n5c6NyuTDP33KUor/dpWFdO/z6yj3ayMNcXAta6SeuyhP5mOx
         +QVuAHDFGsOTaLd0KHw/c8IGFkHnfCI9QaxJcYpKgrt/bKTE7Xd5gCYFFcfJIZK2U24p
         TbdLWW7OqS8vEPS+DGuPFCi+/YXZi5aZrtkYvTWf/V51+pw4+xwA9QKXUP1+BdSzTs9G
         0WBQdr64bDqmNcQWxINUTE8rfXVM3llbx8jtwi4OcuVyZpg0PijmAgfPwQg1sJii2cPY
         +7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688465; x=1689280465;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kcednvuw8fADgko4gaPCVbyMHgDDWwuaOkWQxVwp51M=;
        b=GEp2kblez9VI6daF34TAjMywTKZuYRLPWx77S93h/Y+UFcN3E8AAG1QAKmj+BUPiVp
         cIhftO4qRajZBLrMMLva7R6ZnHThfmXr0IokvCDeqmVgZxaxKIIZldBNUCQSTtS/qGTQ
         U0JFgPN0jjd4bCc16YphTrQOZ3NXDyU51U/Ak20FszyWHjyEqn1quKzzSju/PdiwjRS2
         mZu3/IAC1uB+g6b2ASwmAIUNi/2jmp4mWiYeCXwUdlse7wEXWE41nOv/+pcJx8VWD18D
         FVV0lvSs+vMOjHgu3i1bOBm9JT0iYIcpR0XQMTF8xFxujZLGShuMZFBlHZnp79c/MMBm
         YFVQ==
X-Gm-Message-State: AC+VfDym1VxUGj2MsVqEVMGPqrk3HqCHsPFmH21CPF8HxmhZFNg0nnV9
        4COnLjZtJTqA+r5uJw04lkjeqg==
X-Google-Smtp-Source: ACHHUZ48mfM5/P9A9Y94JYt91moM59ya3XvByPtbOhrQ1lXNFI4yAnplunN5bnR6u5YtNucWiQzkUw==
X-Received: by 2002:a05:6512:32a9:b0:4f7:6404:4638 with SMTP id q9-20020a05651232a900b004f764044638mr221697lfe.17.1686688465473;
        Tue, 13 Jun 2023 13:34:25 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:25 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 00/10] Fix busydetect on Ux500 PL180/MMCI
Date:   Tue, 13 Jun 2023 22:34:16 +0200
Message-Id: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMnSiGQC/43Nyw6CMBAF0F8xXVvTt+DK/zAupu0ITRBIi0RC+
 HcLO+NClnce584kYQyYyOUwk4hjSKFrc1DHA3E1tBXS4HMmggnJFNO0b3jBqH2lyeOAbqCP8Kb
 GAJOGeVkWQPKrhYTURmhdvT4/IQ0Y10UfMd9vfbd7znVIQxenrX7k6/RP08gpo6IAx0s4K9R4b
 UILsTt1sSKrOIo9isgKouVMCmm1Mj+K3KPIrDgvvS6FBjTqS1mW5QOn6WraXgEAAA==
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
a delayed work that fire after a timeout if the busy detect
has not stopped. This is the last patch in the series.

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
Changes in v4:
- Fix an unrelated change in patch 1
- Move MMCI_BUSY_DONE initialization outside the if()-clause
  for busy detection.
- Use the per-command ->busy_timeout as calculated by the
  core.
- Link to v3: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org

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

 drivers/mmc/host/mmci.c             | 143 ++++++++++++++++++++++++++++--------
 drivers/mmc/host/mmci.h             |  15 ++++
 drivers/mmc/host/mmci_stm32_sdmmc.c |   6 +-
 3 files changed, 132 insertions(+), 32 deletions(-)
---
base-commit: 3dff3b32d4752f4a0655fad3c8669978c291ae59
change-id: 20230405-pl180-busydetect-fix-66a0360d398a

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

