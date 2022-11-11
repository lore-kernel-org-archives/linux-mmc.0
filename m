Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FADC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Nov 2022 12:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiKKM0K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Nov 2022 07:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiKKM0J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2022 07:26:09 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8241654E4
        for <linux-mmc@vger.kernel.org>; Fri, 11 Nov 2022 04:25:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u11so4360717ljk.6
        for <linux-mmc@vger.kernel.org>; Fri, 11 Nov 2022 04:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cPVQZP3CJGISOBWbQDciZSTi0SHMrLWneRzV2KFYjE=;
        b=pHyFqDhc31s4yZZDCxs8Vq3ZeKBNLc0fRCACiqjqJzKBzlvW5RnyFSWM2G5f+RNbIR
         AGjEkkB4f6DMdpBgiBp2yNp3KKP/03kFMpFXzcC6aGgMBaKkkAf3VwRzrPyvx8prohgs
         zqKx5t6tBJQ+z2UxNnqrzhq4i1kEHK6mphpz3bTfKEpKAKkMp5zX0t4FIkgJJsZKQ7/R
         s2sbjRuFX450+H7NCnGAdgKnrJr4uQ0Fdqty53aOUQeTsT1cBckt2JSL3lDEaVfTY1/S
         GTYpSUqpz3w+WGmoZ3sXogxzKY5tCAXiLDOaTkY8rtx/OlYOvDfi7k3tWu+RjCAAdl9m
         7dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cPVQZP3CJGISOBWbQDciZSTi0SHMrLWneRzV2KFYjE=;
        b=v9B6eTDHwHMnkoHAaBoOGiqDXRbMKrgREZGqTyD7YKiM4q/bPAq191HLuirA5Qp77M
         997y6MDr8vmqVw39L82HEUeRtKdZUaSa592DThjSXJzqEN4tCqK9zcVkOCsKJVxAXu5L
         wdFo76idlQewoq3ruiz2I2H1sIyToG9MQta0iKQg/0pawbKYcxefEUI2NGsgU6180YDu
         wgLMJOIg/7o1Y720+ibuFUfwUJBkCwEU6iJpcGB7Ysk8NGyV3fOB5SxvPkOyCmaTQgJH
         wzScV5Dq4yPI1LviIxJ2k3qjhBPbEE+5FSJmJGr0ZXnhBHaXh5v1ISGMYUtBkuE99kLU
         TBuQ==
X-Gm-Message-State: ANoB5pmEXKSzvRWQPuJ3mmTmQKGGDIN9g4PqrHd3VDuG432WwAkXDTGe
        73Az7jyswCVnhCXxxaTep2APIw5ibyZpDg==
X-Google-Smtp-Source: AA0mqf4b8dhxFKi654kgglCu6s8zV8cG9HMZ8VgVKt4IMoJXJorkipUhvQF95RdZ7kC2ijMsn18ISw==
X-Received: by 2002:a05:651c:2005:b0:276:ffbf:2ee2 with SMTP id s5-20020a05651c200500b00276ffbf2ee2mr508193ljo.505.1668169557055;
        Fri, 11 Nov 2022 04:25:57 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g19-20020a2e3913000000b0026df5232c7fsm378101lja.42.2022.11.11.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 04:25:56 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.1-rc5
Date:   Fri, 11 Nov 2022 13:25:54 +0100
Message-Id: <20221111122554.112164-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.1-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc4

for you to fetch changes up to f002f45a00ee14214d96b18b9a555fe2c56afb20:

  mmc: sdhci-esdhc-imx: use the correct host caps for MMC_CAP_8_BIT_DATA (2022-11-09 13:01:33 +0100)

----------------------------------------------------------------
MMC host:
 - cqhci: Provide helper for resetting both SDHCI and CQHCI
 - sdhci_am654: Fix reset for CQHCI
 - sdhci-brcmstb: Fix reset for CQHCI
 - sdhci-esdhc-imx: Fix reset for CQHCI
 - sdhci-esdhc-imx: Fixup support for MMC_CAP_8_BIT_DATA
 - sdhci-of-arasan: Fix reset for CQHCI
 - sdhci-tegra: Fix reset for CQHCI

----------------------------------------------------------------
Brian Norris (6):
      mmc: cqhci: Provide helper for resetting both SDHCI and CQHCI
      mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
      mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: use the correct host caps for MMC_CAP_8_BIT_DATA

 drivers/mmc/host/sdhci-brcmstb.c   |  3 ++-
 drivers/mmc/host/sdhci-cqhci.h     | 24 ++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c |  7 ++++---
 drivers/mmc/host/sdhci-of-arasan.c |  3 ++-
 drivers/mmc/host/sdhci-tegra.c     |  3 ++-
 drivers/mmc/host/sdhci_am654.c     |  7 ++++---
 6 files changed, 38 insertions(+), 9 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-cqhci.h
