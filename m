From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 0/2] MMC: add driver for Amlogic GXBB SoCs
Date: Tue, 13 Sep 2016 17:43:12 -0700
Message-ID: <20160914004314.682-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36455 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932782AbcINAnR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Sep 2016 20:43:17 -0400
Received: by mail-it0-f41.google.com with SMTP id o3so21922930ita.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Sep 2016 17:43:16 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Victor Wan <victor.wan@amlogic.com>, Jerry Cao <jerry.cao@amlogic.com>, Xing Wu <xing.xu@amlogic.com>, yonghui.yu@amlogic.com

Here's an updated series for the Amlogic MMC driver.

Changes since v2:
- rework voltage regulator support
- drop read/write accessor macros
- drop descriptor struct (had endian issues)
- fix big-endian support, and tested big-endian build

This version is included in the v4.8/integ branch of my git tree
https://git.kernel.org/cgit/linux/kernel/git/khilman/linux-amlogic.git/

Also some RFC quetsions:

I think this is the exact same IP on the GXL family of SoC, so I'm
thinking about renaming all occurances of GXBB to just GX.  We can
have compatibles to match meson-gxbb and meson-gxl etc. though.

Thoughts?

Kevin Hilman (2):
  MMC: meson: initial support for GXBB platforms
  ARM64: dts: meson-gxbb: add MMC support

 .../devicetree/bindings/mmc/amlogic,meson-gxbb.txt |  29 +
 MAINTAINERS                                        |   1 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  87 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  78 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  37 +-
 drivers/mmc/host/Kconfig                           |  10 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/meson-gxbb.c                      | 838 +++++++++++++++++++++
 8 files changed, 1080 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
 create mode 100644 drivers/mmc/host/meson-gxbb.c

-- 
2.9.3

