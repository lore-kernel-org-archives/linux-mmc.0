Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9124C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 23:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiDFXi5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiDFXi4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 19:38:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7B61FCD38
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 16:36:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso4436980pjh.3
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=21ZJRRzPBF6FcLzLA+5OerzfnCr3C60pEPJqVVBmqTY=;
        b=fKwn0tUMW047EyEj2Owp8YI5iW6CAw7fzm93kE70JaSkisqGFGRYw0WSQ995y/Ahdq
         b5/KCNurRH6P5x7lXbwcqz0zzAE+yKIziwzwdqasM8LjpbSn+FORgzLng6ddJwykKYrm
         Cd/1iatq5/fR7IkJzWYaoNcwzcgT3D5fxa1Aykz9Z4tVz0Cio1oD0tzlY1vOeULqgofo
         AwyAlp0RPJIhg+tw0v7IFvDyp/1GnWipihXFIoDrCISvL+bWWPs3XPdoOvOfNHJYmf6S
         dOw4iFaedBTqWWlN2+STe3zBU8+pRxzgGbeC5VsbDjmU7417KuUWs/Q71WxPyhQ3XfGp
         7FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=21ZJRRzPBF6FcLzLA+5OerzfnCr3C60pEPJqVVBmqTY=;
        b=vJkWAvulAGwKoYPK8QKaxA/3iQQDBMVb8VuKjG99hMaI85tEixXA/7RTKD9arku+uM
         mw3UUda/awnIrinSraz5TM1QEiSfWy7csvIDPEyLvH9c9Yv1mricyH6Hkcj9ZwuIuh9j
         GEIUiv6LFFAj1R5VBdmlMEv7QrraKTucmtq11afLmR7ei8HSVL9En1xKCQ0wMLQCL2Fb
         nd53t69JSr2UXkGC7IZMfrMl3vHLSf5xajQnIPGsjB5r19+ORyyERWqQ9j5xq+SC1FJo
         s7wLjdHL9eBs7Ikh8bbJOmiYszl3rTeW6iWfOFQt/fy41j9yXcekQyTPHP9rZs1q9Ajn
         WH6g==
X-Gm-Message-State: AOAM532Vjeq8v9rScCeAvul7a0UcbtH6bye5LiYaa7Qdq3mPWYP/k4q3
        uOi3gnWEuyRlWDAhClB9pharQw==
X-Google-Smtp-Source: ABdhPJw6de6LxMX24kxKqOkwU7ahEUMqpmaXcVTLkvOJdN5e2XGTxzipHvLO3QMVfxr0Ma+CwQjFTQ==
X-Received: by 2002:a17:90a:b115:b0:1ca:9d56:24f9 with SMTP id z21-20020a17090ab11500b001ca9d5624f9mr12636918pjq.130.1649288217192;
        Wed, 06 Apr 2022 16:36:57 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:36:56 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Support Pensando Elba SoC
Date:   Wed,  6 Apr 2022 16:36:37 -0700
Message-Id: <20220406233648.21644-1-brad@pensando.io>
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

This is a respin based on review inputs.  The version of 
dtschema used is 2022.3.2.  Changes from V3:

0001-dt-bindings-arm-add-Pensando-boards.patch
- Add description and board compatible

0003-dt-bindings-mmc-Add-Pensando-Elba-SoC-binding.patch
- Change from elba-emmc to elba-sd4hc to match file convention
- Use minItems: 1 and maxItems: 2 to pass schema check

0005-dt-bindings-spi-dw-Add-Pensando-Elba-SoC-SPI-Control.patch
- Add required property pensando,syscon-spics to go with
  pensando,elba-spi

0006-MAINTAINERS-Add-entry-for-PENSANDO.patch
- Change Maintained to Supported

0007-arm64-Add-config-for-Pensando-SoC-platforms.patch
- Fix a typo on interface max speed

0008-spi-cadence-quadspi-Add-compatible-for-Pensando-Elba.patch
- Update due to spi-cadence-quadspi.c changes

0009-mmc-sdhci-cadence-Add-Pensando-Elba-SoC-support.patch
- Change from elba-emmc to elba-sd4hc to match file convention

0010-spi-dw-Add-support-for-Pensando-Elba-SoC.patch
- Use more descriptive dt property pensando,syscon-spics
- Minor changes from review input

0011-arm64-dts-Add-Pensando-Elba-SoC-support.patch
- Changed to dual copyright (GPL-2.0+ OR MIT)
- Minor changes from review input

Brad Larson (11):
  dt-bindings: arm: add Pensando boards
  dt-bindings: Add vendor prefix for Pensando Systems
  dt-bindings: mmc: Add Pensando Elba SoC binding
  dt-bindings: spi: Add compatible for Pensando Elba SoC
  dt-bindings: spi: dw: Add Pensando Elba SoC SPI Controller bindings
  MAINTAINERS: Add entry for PENSANDO
  arm64: Add config for Pensando SoC platforms
  spi: cadence-quadspi: Add compatible for Pensando Elba SoC
  mmc: sdhci-cadence: Add Pensando Elba SoC support
  spi: dw: Add support for Pensando Elba SoC
  arm64: dts: Add Pensando Elba SoC support

 .../bindings/arm/pensando,elba.yaml           |  26 +++
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   4 +-
 .../bindings/spi/cdns,qspi-nor.yaml           |   3 +-
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  17 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 arch/arm64/Kconfig.platforms                  |  12 ++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/pensando/Makefile         |   3 +
 arch/arm64/boot/dts/pensando/elba-16core.dtsi | 189 ++++++++++++++++++
 .../boot/dts/pensando/elba-asic-common.dtsi   |  98 +++++++++
 arch/arm64/boot/dts/pensando/elba-asic.dts    |  28 +++
 .../boot/dts/pensando/elba-flash-parts.dtsi   | 106 ++++++++++
 arch/arm64/boot/dts/pensando/elba.dtsi        | 189 ++++++++++++++++++
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-cadence.c              | 148 ++++++++++++--
 drivers/spi/spi-cadence-quadspi.c             |  19 ++
 drivers/spi/spi-dw-mmio.c                     |  85 ++++++++
 18 files changed, 922 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml
 create mode 100644 arch/arm64/boot/dts/pensando/Makefile
 create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi

-- 
2.17.1

