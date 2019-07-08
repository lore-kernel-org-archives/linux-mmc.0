From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 0/2] Amlogic 32-bit Meson SDHC MMC controller driver
Date: Mon,  8 Jul 2019 19:33:28 +0200
Message-ID: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, robh+dt@kernel.org, ulf.hansson@linaro.org, jianxin.pan@amlogic.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-mmc@vger.kernel.org

Hello,

this is RFC v1 of the attempt to upstream the driver for the "SDHC" MMC
controller found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

The public S805 (Meson8b) datasheet has some documentation starting on
page 74: [0]

The goal of this RFC v1 is to:
- find out how to set up the MMC clock correctly with Jianxin's help (see
  the description of patch #2 with questions)
- get feedback from the MMC maintainers to see which bits need changing


[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf


Martin Blumenstingl (2):
  dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
  mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host

 .../bindings/mmc/amlogic,meson-mx-sdhc.txt    |   34 +
 drivers/mmc/host/Kconfig                      |   14 +
 drivers/mmc/host/Makefile                     |    1 +
 drivers/mmc/host/meson-mx-sdhc.c              | 1161 +++++++++++++++++
 4 files changed, 1210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.c

-- 
2.22.0
