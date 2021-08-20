Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C252C4338F
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56115610E6
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 13:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbhHTNXP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Aug 2021 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhHTNXP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2021 09:23:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE4C061575
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2021 06:22:37 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l18so9763641lji.12
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2021 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9daWYLrvyCEPIRa2dVBzTdNpv/SvOVQvlNtTBsH9LDc=;
        b=EK3YmDgaFYDy+RtR0bv9/QfQeugAs0xb6gQE8YDwiD++YukMu81HQdCQmqv/H67BU4
         VSZveOXFEb2BppOPvmqVq8jSAvcloilP1UGQ1CZwaPS7hrjiBm3IL1P06Hr5IjnXvIIw
         saqvsGUA6A/cQ5N/HJQ+4UiZbKnpLlBulLPAGaRACAbxkoHXL6zZPCyELNpFFeF+oapF
         QdYdhNhQf6ithKWlSgnoSJL15JuT8I4ml2X0ztxHZhOKrnv1KtpMrv5fGQCj8aAL4JUy
         rwSbtZuJYR3BwqB6xzRWjPgR4zCzPikDMLjvfGtdvrqNH7YCGb0SmM64WrtwG7zDP0n0
         ZTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9daWYLrvyCEPIRa2dVBzTdNpv/SvOVQvlNtTBsH9LDc=;
        b=IUQhcWjgqTJG9vwjxYuytHXNbcR/gFBLzbbD3+Hf5jMj/GkDi6SFnauP0LEdi6az5r
         i3ndtN7kkmqfWsyseRFbT75HAREFGtb5j/9FJpNXAkk9wEfoqfHn6DXz6PgBbrsxdCkP
         yY4yZuyVOqfFqTTHhlYKzPpPqz0uZC5HP3UfDlQpgryb7pgJoWDpCJuHcDz1wyQJ1Nul
         lf0ZuMq5BI+NEZreiZHrJvkX2snhNNVCGjqir8rTCp2a50ESvQkGMDouK5bsSe5eXwWU
         ULAJkX+BJkeleK9C1T0J1YFN6cLm7v2qTm4r2FM8njIFyMECI/w9y9PzkLUlt3g5wXd8
         uu0Q==
X-Gm-Message-State: AOAM532SVq601qIwcdWi0EiRqbALwj0Idp/vVngZ5goOTr/fR9D5mqDz
        7Z9llP8758HiZcYQwqpe2Jc5Rg==
X-Google-Smtp-Source: ABdhPJxlGO9sBInp8sdwlVhPydINe4iAEeAaahADA5SwpJucjNr7C06No6wviogCq/HHzmvH/KvZVw==
X-Received: by 2002:a05:651c:54e:: with SMTP id q14mr16303607ljp.426.1629465755872;
        Fri, 20 Aug 2021 06:22:35 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id d5sm320753ljc.101.2021.08.20.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 06:22:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.14-rc7
Date:   Fri, 20 Aug 2021 15:22:34 +0200
Message-Id: <20210820132234.318026-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.14-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc4

for you to fetch changes up to 419dd626e357e89fc9c4e3863592c8b38cfe1571:

  mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711 (2021-08-16 12:12:05 +0200)

----------------------------------------------------------------
MMC host:
 - dw_mmc: Fix hang on data CRC error
 - mmci: Fix voltage switch procedure for the stm32 variant
 - sdhci-iproc: Fix some clock issues for BCM2711
 - sdhci-msm: Fixup software timeout value

----------------------------------------------------------------
Christophe Kerello (1):
      mmc: mmci: stm32: Check when the voltage switch procedure should be done

Nicolas Saenz Julienne (2):
      mmc: sdhci-iproc: Cap min clock frequency on BCM2711
      mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711

Shaik Sajida Bhanu (1):
      mmc: sdhci-msm: Update the software timeout value for sdhc

Vincent Whitchurch (1):
      mmc: dw_mmc: Fix hang on data CRC error

 drivers/mmc/host/dw_mmc.c           |  6 +++---
 drivers/mmc/host/mmci_stm32_sdmmc.c |  7 +++++--
 drivers/mmc/host/sdhci-iproc.c      | 21 ++++++++++++++++++++-
 drivers/mmc/host/sdhci-msm.c        | 18 ++++++++++++++++++
 4 files changed, 46 insertions(+), 6 deletions(-)
