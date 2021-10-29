Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36576C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA016023F
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 12:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhJ2MJl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhJ2MJk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 08:09:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A3FC061714
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 05:07:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 205so16472826ljf.9
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eirQQDFGLnuOBylNysB2OPO3DM0CiT5s5esxUOxGBw=;
        b=lqTKm2lv4z205Qp89xJiLSTdgPD7+cbtM+/QE+QRN/gUlp1OmplLRredwuByu6Al/P
         Wo71Zho7LNfYeOnoSlPX4hcM+Jdyel5sH2cgJGFzOK5hYaNr2nVqMIlRwDS5sRKEtZDy
         xmwTJsedlGE/cJ36KHirqKd4wL6gw2f9OVCwev+yOE/G9PbN7tTn3HLFFn4gQuXPCtkl
         W6/Td2LmBPjYvT3DBBUixDzG75AyTHYhO5CWTObXim/QTV3EO213oaxYhzsV87B53aVA
         skdLHHpMsmstX9qKt4wIeZckp+rfRga7dYhR57l1DidaRpt9OmXSz0tyMhgWwcEW+x+g
         YliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eirQQDFGLnuOBylNysB2OPO3DM0CiT5s5esxUOxGBw=;
        b=ScKETzrn3J8NuDnyOXNGZIs48rUI3p6JuyxSGguxXFvHmecuJFYMZRCzJfy7Ipoa5Z
         ELaMivGQf8qs8yVZFm+BdlUXS1bsPVvP3nlHQlQ5vOJ1CHbmCI01q+I0G1qKc6K0yXzR
         dQ1wF43TbJg6dwn7Rut8/FKYtF6ZJZIOdi4fQfNOyqOpkZLkc+jjax/EO5HGTgKaVk8u
         kecNp9sCxPCxV32bZ3WSeSf5SV+TeZoakhfzJUKftkhavc1QpC0lnDprQsvbpoungmIr
         5YDdy57LeCAUwBG27AtVcF3lm3xyPrUwh/3rkEeP1P0YA9Hf3VjXUDDcGZmyA53+fOhS
         ImZw==
X-Gm-Message-State: AOAM532BqQKG7/Vo80EEpbxGmslOJzfrZw82vs1fmrhe9f+OpE1ptR0E
        KYPFJVfU6JK73KSPCINIWi4kKORTm67xdw==
X-Google-Smtp-Source: ABdhPJyzLo62tQdRTxyLQ9J4EAJXL52ZopoxaBT7MrOT9ts4P2uBgR1n0cJbehD4Tklkq/Bp6bPmgA==
X-Received: by 2002:a2e:5344:: with SMTP id t4mr11017960ljd.294.1635509230709;
        Fri, 29 Oct 2021 05:07:10 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id m3sm303935lfr.203.2021.10.29.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:07:09 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.15-rc8
Date:   Fri, 29 Oct 2021 14:07:09 +0200
Message-Id: <20211029120709.79366-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.15-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-rc5

for you to fetch changes up to 90935eb303e0d12f3d3d0383262e65290321f5f6:

  mmc: tmio: reenable card irqs after the reset callback (2021-10-28 23:19:32 +0200)

----------------------------------------------------------------
MMC host:
 - tmio: Re-enable card irqs after a reset
 - mtk-sd: Fixup probing of cqhci for crypto
 - cqhci: Fix support for suspend/resume
 - vub300: Fix control-message timeouts
 - dw_mmc-exynos: Fix support for tuning
 - winbond: Silences build errors on M68K
 - sdhci-esdhc-imx: Fix support for tuning
 - sdhci-pci: Read card detect from ACPI for Intel Merrifield
 - sdhci: Fix eMMC support for Thundercomm TurboX CM2290

----------------------------------------------------------------
Andy Shevchenko (1):
      mmc: sdhci-pci: Read card detect from ACPI for Intel Merrifield

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: clear the buffer_read_ready to reset standard tuning circuit

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the finding clock sample value

Johan Hovold (1):
      mmc: vub300: fix control-message timeouts

Randy Dunlap (1):
      mmc: winbond: don't build on M68K

Shawn Guo (1):
      mmc: sdhci: Map more voltage level to SDHCI_POWER_330

Wenbin Mei (2):
      mmc: cqhci: clear HALT state after CQE enable
      mmc: mediatek: Move cqhci init behind ungate clock

Wolfram Sang (1):
      mmc: tmio: reenable card irqs after the reset callback

 drivers/mmc/host/Kconfig           |  2 +-
 drivers/mmc/host/cqhci-core.c      |  3 +++
 drivers/mmc/host/dw_mmc-exynos.c   | 14 ++++++++++++++
 drivers/mmc/host/mtk-sd.c          | 38 +++++++++++++++++++-------------------
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
 drivers/mmc/host/sdhci-pci-core.c  | 29 ++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.c           |  6 ++++++
 drivers/mmc/host/tmio_mmc_core.c   | 17 ++++++++++++-----
 drivers/mmc/host/vub300.c          | 18 +++++++++---------
 9 files changed, 104 insertions(+), 39 deletions(-)
