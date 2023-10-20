Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F8CDB474
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Oct 2023 11:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377236AbjJTL5D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Oct 2023 07:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377175AbjJTL5D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2023 07:57:03 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143B1D4C
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2023 04:57:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c3e23a818bso9022411fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2023 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697803019; x=1698407819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh++GJc3kGJM2bQdA5aanDk5yqbDgE0CFVbC9pD/A04=;
        b=iWXmXRELkqs/d1JgDtz9Ikp9vkBWXVyVOvDjqEdrsFq/6DYS5Vbm9SjzpzeJIg6f/+
         IAcfV0e8/lT9O4E8L8ItqpjyfiDSMLd0YB3xg0q+9KXzKOlDadBuOy0ckP0nu2IpIH+c
         EFBh7vexBgBMpcH3QIzC/IapACYj2fkNRR7qDsdQ5VQ8TQy2304jo4B2Avhj/PX6i9uF
         Gq7B8Re5AipntdQFZ36kCryQV18l+oZ4OxClOdwWpzWWJQLJ/QNduNCVAnYUhZeFjasi
         f6RCJ/oyjTQlB4nnS4nAdkdo+4jybA70ee+ndVnRlkKvx4QqStov/n1hL590PPzYwsLu
         FxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697803019; x=1698407819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hh++GJc3kGJM2bQdA5aanDk5yqbDgE0CFVbC9pD/A04=;
        b=lFVIVUJHiVHrGF2fb/smgPRqHy1D2z++o0+3NVe8Ak0WxDG4hPWw/L6w3sffHHWbE2
         CycWoFGLQU6w/qTCh6Iv+U3vKiY6mEblNGGi6kQYJU/awwlWxhV8pQpki/Pjocw4qygj
         XAhmgn4YrLlwSSZhPnPSAtNTucfaFzhN4AeSXXmJ7hiWJQk/RHX6lvBztIox1NfWH30k
         3vUDnyQpX7IBFVb8SUqarz/skf/ijw5w0uzgAq9Ds7zsbZEGme5opNCUBYpXlhoRys6a
         Iu+OpXaAsI4CuCAj3OcpA+y90E805Xx+w5BWGQ0zUpklOM+knYUiX6cbVBrJ5+mcbDTT
         i5bg==
X-Gm-Message-State: AOJu0Yw3gyIEZz30WEZqaZVogEsQgaU9XFzarWhLmsp4Z1cU3kXvhBDK
        waKfqqNwuBskCGkzE70Cvsa40w==
X-Google-Smtp-Source: AGHT+IHnGfzeX3kx7GOLdN3ynQSE3OBRsSmF/GQF3URlL9EC4qOVUrtvUe1p9Xhb+apubjZEC+Ky4A==
X-Received: by 2002:a05:651c:1308:b0:2c4:fdaf:1d62 with SMTP id u8-20020a05651c130800b002c4fdaf1d62mr1674662lja.11.1697803019267;
        Fri, 20 Oct 2023 04:56:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id b41-20020a05651c0b2900b002c02b36d381sm337496ljr.88.2023.10.20.04.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:56:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.6-rc7
Date:   Fri, 20 Oct 2023 13:56:57 +0200
Message-Id: <20231020115657.153077-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.6-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6-rc3

for you to fetch changes up to 84ee19bffc9306128cd0f1c650e89767079efeff:

  mmc: core: Capture correct oemid-bits for eMMC cards (2023-09-27 12:17:04 +0200)

----------------------------------------------------------------
MMC core:
 - Capture correct oemid-bits for eMMC cards
 - Fix error propagation for some ioctl commands
 - Hold retuning if SDIO is in 1-bit mode

MMC host:
 - mtk-sd: Use readl_poll_timeout_atomic to not "schedule while atomic"
 - sdhci-msm: Correct minimum number of clocks
 - sdhci-pci-gli: Fix LPM negotiation so x86/S0ix SoCs can suspend
 - sdhci-sprd: Fix error code in sdhci_sprd_tuning()

----------------------------------------------------------------
Avri Altman (1):
      mmc: core: Capture correct oemid-bits for eMMC cards

Dan Carpenter (1):
      mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()

Haibo Chen (1):
      mmc: core: sdio: hold retuning if sdio in 1-bit mode

Krzysztof Kozlowski (1):
      dt-bindings: mmc: sdhci-msm: correct minimum number of clocks

Pablo Sun (1):
      mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw

Sven van Ashbrook (1):
      mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend

Ulf Hansson (1):
      mmc: core: Fix error propagation for some ioctl commands

 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   2 +-
 drivers/mmc/core/block.c                           |  31 +++---
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/mmc/core/sdio.c                            |   8 +-
 drivers/mmc/host/mtk-sd.c                          |   6 +-
 drivers/mmc/host/sdhci-pci-gli.c                   | 104 +++++++++++++--------
 drivers/mmc/host/sdhci-sprd.c                      |   1 +
 7 files changed, 99 insertions(+), 55 deletions(-)
