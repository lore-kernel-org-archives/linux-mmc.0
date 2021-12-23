Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84175C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Dec 2021 13:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348593AbhLWNRa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Dec 2021 08:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhLWNRa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2021 08:17:30 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05526C061756
        for <linux-mmc@vger.kernel.org>; Thu, 23 Dec 2021 05:17:30 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u22so9030504lju.7
        for <linux-mmc@vger.kernel.org>; Thu, 23 Dec 2021 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1vdIWuNNE8OnHa60L7/WMRUeBtjD7twHKWeQD7MBsw=;
        b=DJ5/MLtjnLGIXlUDwTkWr1KMw/+Cyo3QPBIeYqs5PjfB1pvPlwCQ6ixh281aVLn3yk
         pePSX24DhsTVqx/hc+v1kV4pQXaa+KdEZUjZ/PCGqFvMC+inILUin77mfCmWPZMw7hX2
         4Sne3rwgKfw+KXTGfS4KtXF1OhHQ9253wynGjuUCFCpMTM1rvDCs9SMWXGvR1DeRGPUM
         TZxgBqQA9cVKHCQ3bORqiJDh+RAMV3XNLdDDUdmfaVza/zjN0zOlTYQ4ptMLeR04ftCG
         aU/95Woyi5zHzyRFwiRVhDLfsMxabcRcbyff1pOQSD0P5qjz3f/Gz66/crcsDcBf02PS
         3CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1vdIWuNNE8OnHa60L7/WMRUeBtjD7twHKWeQD7MBsw=;
        b=E8HA4IyYvmlqRoPPL76jOLM+wWkCuT0foh+wc32qzFAW+7bGYOeJB08tWY7njcfcka
         /9vpfqfn8K0u9Fa3WCS4zCkrFVRSmn3WiIuDJ2wFTi9avdGPylk1B80x7Wo07fH3CEyZ
         ywdMf3+gklNJZdhTzPWYXxcTZJTp/VMsIjfpmtAzrj4ArqUylXkwt3Cd+hCa/zMP240k
         TW3n01n/pTj21YW/mHL/iz2/pW/XHYftJG491ZwtaOw8/pekTEzQjHH0njc8pwWMbQJD
         1lzb8QDHLwW9P2v3WTGpHnBG6a8CinBb9fZ+TORkLXWbEjfz/XbZ5nNk3ETzyw9WUStd
         /nkw==
X-Gm-Message-State: AOAM532Ph64fGoB8a6PtgkaxgNgLif+4vKH1GfEHoJiO7HNnK+/w/UPq
        gR8Gazesu/yDb41Z0wxw09xDHg==
X-Google-Smtp-Source: ABdhPJyJN5DZyWS7pU+4iPcAevDPJh6n4d5DwIh7cLH/9B7CUCXvGxrk2tm2ntIGEQy+upp7Ektr/w==
X-Received: by 2002:a05:651c:88e:: with SMTP id d14mr1727969ljq.42.1640265448249;
        Thu, 23 Dec 2021 05:17:28 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id bu36sm498755lfb.259.2021.12.23.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 05:17:27 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.16-rc7
Date:   Thu, 23 Dec 2021 14:17:26 +0100
Message-Id: <20211223131726.10956-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.16-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc5

for you to fetch changes up to ff31ee0a0f471776f67be5e5275c18d17736fc6b:

  mmc: mmci: stm32: clear DLYB_CR after sending tuning command (2021-12-21 13:03:51 +0100)

----------------------------------------------------------------
MMC core:
 - Disable card detect during shutdown

MMC host:
 - mmci: Fixup tuning support for stm32_sdmmc
 - meson-mx-sdhc: Fix support for multi-block SDIO commands
 - sdhci-tegra: Fix support for eMMC HS400ES mode

----------------------------------------------------------------
Martin Blumenstingl (1):
      mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands

Prathamesh Shete (1):
      mmc: sdhci-tegra: Fix switch to HS400ES mode

Ulf Hansson (1):
      mmc: core: Disable card detect during shutdown

Yann Gautier (1):
      mmc: mmci: stm32: clear DLYB_CR after sending tuning command

 drivers/mmc/core/core.c              |  7 +++++-
 drivers/mmc/core/core.h              |  1 +
 drivers/mmc/core/host.c              |  9 ++++++++
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 16 ++++++++++++++
 drivers/mmc/host/mmci_stm32_sdmmc.c  |  2 ++
 drivers/mmc/host/sdhci-tegra.c       | 43 ++++++++++++++++++++++--------------
 6 files changed, 60 insertions(+), 18 deletions(-)
