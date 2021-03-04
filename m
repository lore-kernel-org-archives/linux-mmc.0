Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED774C433E6
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 03:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B089964EE3
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 03:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhCDDne (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhCDDnD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 22:43:03 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22CCC061761
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 19:42:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o38so17975307pgm.9
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 19:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tffW+x0Z9bWuAJnHiB6v6+v5SpYm7jDmBmoT2CaZJw8=;
        b=qDtH6oDuTzlpqxjbf8twdPlTY00ztG6wCgoGm0W6AAv2U45owzkShTCQd9BoPnW+fH
         GbpWmVHLCuWHyEVRhCMM68qAqannSmnJJm4US789d5g70iG17K/9N97zKdPp7lDCP1bM
         olfXkdeZL/1CzCaFkG1Rweyi/jiXqRwl1ucz7/48ovi69WNck9U+DJbU8RMOhljnty9V
         iGVyIXggwuX1T5QqYcFiPsLmzGKK9n4SrVj3ey7L4tKzdAuLIaASTPADaKEsJeAH+Fe0
         Zx/9u0CtwlL+kHHG/FiPYv+1tCrkardPK8A5fhtVMl5jXztMYN3lly/EtNQZfl+yHGm8
         UnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tffW+x0Z9bWuAJnHiB6v6+v5SpYm7jDmBmoT2CaZJw8=;
        b=uTaAwFCCBTVXI3BEekSYu7HurAl/3kHZxzF1mKeIzZqeitSkUhdWNI3YQQY9XIEt6V
         idl+UODq7x/LxOEEvxV155bX7Pb4MsWJBtiY9Irjmhc2VdR1LRgVANpCUU+jPO8W+Vvf
         mLYBMa3QCVS2MWaFbFqxD5zgzf5o0QZR+2koB/Wajn/VXUXPzE/xrDFugNIS3r+aIljZ
         mlzapfw/8GVAKFvY8SizTQgaLBZvqduO/piMNonMWGIbDjBFAqT8ZoV++mUJ4BKlGEmB
         aORiLyPkowHIQUX/J2Guimx4lKnAsgWt+DX3U9CLd7tMX5HZBrVHwiTa5AeUPloHnIPg
         y/1w==
X-Gm-Message-State: AOAM531NL8TDGSrp60cpU2hjDg8S1RTMXoTg/0ANgEM/kO0jBKYS3JxS
        tKvjHY4d76An6PmtYX35MfksqWtGWFdvWtjD
X-Google-Smtp-Source: ABdhPJwabYrzrkPq11VEa1zJd9zZb5yOqiXy+o2pXK7oTU9bAkSOGXpV+0Zt1s0aOxLeYaagJZCB1g==
X-Received: by 2002:a62:7c95:0:b029:1ed:ae61:5379 with SMTP id x143-20020a627c950000b02901edae615379mr2003953pfc.63.1614829343029;
        Wed, 03 Mar 2021 19:42:23 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:22 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Support Pensando Elba SoC
Date:   Wed,  3 Mar 2021 19:41:33 -0800
Message-Id: <20210304034141.7062-1-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series enables support for Pensando Elba SoC based platforms.
The Elba SoC has the following features:

- Sixteen ARM64 A72 cores
- Dual DDR 4/5 memory controllers
- 32 lanes of PCIe Gen3/4 to the Host
- Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
  also a single 1GE management port.
- Storage/crypto offloads and 144 programmable P4 cores.
- QSPI and EMMC for SoC storage
- Two SPI interfaces for peripheral management
- I2C bus for platform management

Brad Larson (8):
  gpio: Add Elba SoC gpio driver for spi cs control
  spi: cadence-quadspi: Add QSPI support for Pensando Elba SoC
  spi: dw: Add support for Pensando Elba SoC SPI
  spidev: Add Pensando CPLD compatible
  mmc: sdhci-cadence: Add Pensando Elba SoC support
  arm64: Add config for Pensando SoC platforms
  arm64: dts: Add Pensando Elba SoC support
  MAINTAINERS: Add entry for PENSANDO

 .../bindings/gpio/pensando,elba-spics.txt     |  24 ++
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   2 +-
 .../bindings/spi/cadence-quadspi.txt          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/pensando/Makefile         |   6 +
 arch/arm64/boot/dts/pensando/elba-16core.dtsi | 171 ++++++++++
 .../boot/dts/pensando/elba-asic-common.dtsi   | 113 +++++++
 arch/arm64/boot/dts/pensando/elba-asic.dts    |   8 +
 .../boot/dts/pensando/elba-flash-parts.dtsi   |  80 +++++
 arch/arm64/boot/dts/pensando/elba.dtsi        | 310 ++++++++++++++++++
 drivers/gpio/Kconfig                          |   6 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-elba-spics.c                | 120 +++++++
 drivers/mmc/host/Kconfig                      |  15 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-cadence-elba.c         | 137 ++++++++
 drivers/mmc/host/sdhci-cadence.c              |  78 ++---
 drivers/mmc/host/sdhci-cadence.h              |  68 ++++
 drivers/spi/spi-cadence-quadspi.c             |   9 +
 drivers/spi/spi-dw-mmio.c                     |  35 +-
 drivers/spi/spidev.c                          |   1 +
 24 files changed, 1159 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt
 create mode 100644 arch/arm64/boot/dts/pensando/Makefile
 create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi
 create mode 100644 drivers/gpio/gpio-elba-spics.c
 create mode 100644 drivers/mmc/host/sdhci-cadence-elba.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

-- 
2.17.1

