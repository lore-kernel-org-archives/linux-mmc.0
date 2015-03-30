From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 0/9] Add sd/emmc support for stih407 family silicon
Date: Mon, 30 Mar 2015 15:39:53 +0100
Message-ID: <1427726402-7513-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34907 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbbC3OkI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 10:40:08 -0400
Received: by wgdm6 with SMTP id m6so177610790wgd.2
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 07:40:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com

Hi,

This series adds sd/emmc support to the sdhci-st.c driver for stih407
family silicon. The changes mainly involve configuring some extra glue
registers in the flashSS which configure the Arasan controller.

This series also adds support for UHS modes for eMMC. To allow
UHS HS200/SD104 modes to function correctly, due to the
tight timing constriants, support for delay management is also added.
Two types of delay management are supported, static delay management and
dynamic delay management, this delay management is only available
on eMMC pads on stih410 and later silicon.

This series has been tested with stih410-b2120 revd on eMMC and sd, at
various clock speeds. As part of this testing a bug was also found in the
upstream flexgen clock set_rate implementation (now fixed upstream).

    max-frequency = 200Mhz
    /dev/mmcblk0p1:
     Timing buffered disk reads: 270 MB in  3.02 seconds =  89.54 MB/sec
    
    max-frequency = 100Mhz
    root@debian-armhf:~# hdparm -t /dev/mmcblk0p1
    /dev/mmcblk0p1:
     Timing buffered disk reads: 210 MB in  3.00 seconds =  70.00 MB/sec
    
    max-frequency = 50Mhz
    root@debian-armhf:~# hdparm -t /dev/mmcblk0p1
    /dev/mmcblk0p1:
     Timing buffered disk reads: 118 MB in  3.00 seconds =  39.28 MB/sec

It has also been tested on stih416-b2020 to ensure we have caused no
regressions. Finally the dt documentation has been updated to reflect
the changes in the driver code. Intrestingly it seems we are the first
upstream platform to be using some of the uhs bindings such as
sd-uhs-sdr104.

Changes since v2:
 - Some whitespace fixups (Max)
 - if (!ioaddr) suggestion (Max)
 - Add stih418-b2199 suport (Max)
 - Stih410 to STiH410 fixes (Max)
 - rebased on v4.0-rc6 (Pete)

Changes since v1:
 - Partition the changes into smaller patches to aid review process (Ulf)

regards,

Peter.

Peter Griffin (9):
  mmc: sdhci-st: Add macros for register offsets and bitfields for mmcss
    glue regs
  mmc: sdhci-st: Add support for de-asserting reset signal and top regs
    resource
  mmc: sdhci-st: Add delay management functions for top registers
    (eMMC).
  mmc: sdhci-st: Add st_mmcss_cconfig function to configure mmcss glue
    registers.
  mmc: sdhci-st: Add sdhci_st_set_uhs_signaling function.
  mmc: sdhci-st: Update the quirks for this controller.
  mmc: sdhci-st: Update ST SDHCI binding documentation.
  ARM: STi: DT: STiH407: Add dt nodes for sdhci and emmc.
  ARM: STi: DT: STiH418: Add dt nodes for sdhci and emmc.

 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 100 +++++-
 arch/arm/boot/dts/stih407-family.dtsi              |  30 ++
 arch/arm/boot/dts/stih410-b2120.dts                |  10 +
 arch/arm/boot/dts/stih418-b2199.dts                |  12 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |   8 +
 drivers/mmc/host/sdhci-st.c                        | 346 ++++++++++++++++++++-
 6 files changed, 492 insertions(+), 14 deletions(-)

-- 
1.9.1

