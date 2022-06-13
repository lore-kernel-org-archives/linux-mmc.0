Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C666DC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jun 2022 20:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiFMUqx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349775AbiFMUp6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2022 16:45:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A13525D
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f9so6013268plg.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6Q84YOUaUYvCziNbod1CpGn7SNbOLOf4WmTjcjyAvNg=;
        b=BLXtU6MAFJq5ssm4lI4sJ0/r9iEVIqEhjHPbmHzRyPqsCvEC2CZbeLRYCtHSHM6aAh
         L13Puo2cZHHMlpKPRhpKuAzxSXRDHjZUFOCNzttCWSFhYtqPiAG9Q0foMXLWER9oMzzD
         RHpMpZhvacF7FHq6jVX1T+5E0AnnCNmLJ8MaFCUkpneMVQX6QzXzN4TKl3ry5lsugEUf
         9b3/hfnFj0kN+5W1g+boYR9kfgl4aYq8Np1JVODyFoJlRtdW4NhQUk/6yCYe+XP2Gf6D
         ZC1bb1tNWfwoGZb+PKiReA42F87Ge7uLgRpS+ty1F+kIuPrdkUKqEKj7NJ849umOos+z
         QpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Q84YOUaUYvCziNbod1CpGn7SNbOLOf4WmTjcjyAvNg=;
        b=wzCvIOxiN4QcMepO9FwhE16OWSzpj4bwLgX0uq4mqG2hjPq6RwVRI4L8oCX3sQX33r
         GSBafICXemsyDd7aEuXvL7fH+TMvLBUtFZ0nje49w9GfypRlF/SZ3xgcw/UOx8aYMNnv
         Wf+kvuOYhIiKjLBZuTQa4Ul0VtSvLnVQjT5siEJ9QiVaN8ljxMhXMO8ZM3BwNHnaCQ2e
         dpMkYM+Rzr3bQHmFMYva52BCq9MwDIx/zWYEv8A2eSkh71x2iIqi6f4/p1JODuVwcCbz
         YjxPRuQ/GQ/WIIDY+AdUq/KLNB8j2d5uFP/uBzsYKm3O9Ls9qw+zSWMXax/YdPp7zZS6
         +W+Q==
X-Gm-Message-State: AOAM531Rdt/QzVJuheriu/kxhyrNA5fzhkkacIoLNGw/FqPdk6XpLRoz
        qQdDZMD6FCXIFuq/7i3O+yz0XA==
X-Google-Smtp-Source: AGRyM1tHDOCjTnfHqTX8BF/l+bjxaQLXumsogekN2cwVv4Qa8s2rjq7p0HuTq502cayORc1+gR3kLQ==
X-Received: by 2002:a17:902:c244:b0:168:c4c3:e80e with SMTP id 4-20020a170902c24400b00168c4c3e80emr967363plg.18.1655150233307;
        Mon, 13 Jun 2022 12:57:13 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:12 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 00/15] Support AMD Pensando Elba SoC
Date:   Mon, 13 Jun 2022 12:56:43 -0700
Message-Id: <20220613195658.5607-1-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

This series enables support for AMD Pensando Elba SoC based platforms.

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

This is a respin based on review inputs

1. Change to AMD Pensando instead of Pensando.

2. No reference to spidev in the device tree.  Add multi-function driver
   pensando-elbasr and sub-device reset-elbasr.

3. Rebase to linux-next tag next-20220609 5.19.0-rc1

4. Redo the email list after rebase and using scripts/get_maintainer.pl

Brad Larson (15):
  dt-bindings: arm: add AMD Pensando boards
  dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC binding
  dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
  dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
    bindings
  dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
  dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System
    Resource chip
  dt-bindings: reset: amd,pensando-elbasr-reset: Add AMD Pensando SR
    Reset Controller bindings
  MAINTAINERS: Add entry for AMD PENSANDO
  arm64: Add config for AMD Pensando SoC platforms
  arm64: dts: Add AMD Pensando Elba SoC support
  spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
  spi: dw: Add support for AMD Pensando Elba SoC
  mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
  mfd: pensando-elbasr: Add AMD Pensando Elba System Resource chip
  reset: elbasr: Add AMD Pensando Elba SR Reset Controller

 .../devicetree/bindings/arm/amd,pensando.yaml |  26 +
 .../bindings/mfd/amd,pensando-elbasr.yaml     |  93 ++
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |  14 +
 .../reset/amd,pensando-elbasr-reset.yaml      |  62 ++
 .../bindings/spi/cdns,qspi-nor.yaml           |  12 +
 .../bindings/spi/snps,dw-apb-ssi.yaml         |   2 +
 MAINTAINERS                                   |  10 +
 arch/arm64/Kconfig.platforms                  |  12 +
 arch/arm64/boot/dts/amd/Makefile              |   1 +
 arch/arm64/boot/dts/amd/elba-16core.dtsi      | 189 ++++
 arch/arm64/boot/dts/amd/elba-asic-common.dtsi | 103 +++
 arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +
 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 +++
 arch/arm64/boot/dts/amd/elba.dtsi             | 191 ++++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/pensando-elbasr.c                 | 862 ++++++++++++++++++
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-cadence.c              | 179 +++-
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-elbasr.c                  |  94 ++
 drivers/spi/spi-cadence-quadspi.c             |  19 +
 drivers/spi/spi-dw-mmio.c                     |  66 ++
 .../reset/amd,pensando-elba-reset.h           |  11 +
 include/linux/mfd/pensando-elbasr.h           |  78 ++
 27 files changed, 2171 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
 create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
 create mode 100644 drivers/mfd/pensando-elbasr.c
 create mode 100644 drivers/reset/reset-elbasr.c
 create mode 100644 include/dt-bindings/reset/amd,pensando-elba-reset.h
 create mode 100644 include/linux/mfd/pensando-elbasr.h

-- 
2.17.1

