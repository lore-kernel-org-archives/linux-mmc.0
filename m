From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/2] Add support for Meson MX "SDIO" MMC controller
Date: Tue,  3 Oct 2017 13:24:15 +0200
Message-ID: <20171003112417.31860-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36324 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdJCLY0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2017 07:24:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This is the successor to Carlo Caione's "Add support for Amlogic Meson
MMC driver" series (v5) from [0].
This new driver is for the "SDIO" controller found in Amlogic Meson6,
Meson8 and Meson8b SoCs and supports an internal mux to allow connecting
three cards to it.

There are devices out there which actually need the mux feature of this
HW, one example is the Endless Mini (EC-100):
(the Meson8b SoC itself has only two MMC controllers)
- an eMMC module (connected to a yet unsupported MMC controller)
- an internal SD card (connected to the SDIO controller from this
  series)
- a RTL8723BS wifi SDIO card (also connected to the SDIO controller
  from this series)


changes since RFC v2 at [2]:
- removed struct meson_mx_mmc_slot and merged it's members into
  meson_mx_mmc_host. I could *not* remove the platform_device_create()
  (which registers a sub-device for the slot) because without that
  we cannot get mmc_of_parse() to parse the slot's node instead of the
  parent (= controller's) node.
  This also required some small restructuring of the probe related code
  by using the "mmc-slot" node detection and mmc_alloc_host() earlier
  in .probe()
- added Rob's ACK to the dt-binding patch
- added a note to the dt-binding doc that there is currently a driver
  limitation and only one slot is supported
- added reference to a board which actually needs the MMC mux support
  (information only, just in case someone wants to know why it's
  needed at all)
- dropped RFC status of the patches

changes since RFC v1 at [1]:
- added COMMON_CLK dependency as reported by the kbuild test robot
- use of_platform_device_{create,destroy} instead of open-coding it's
  logic
- moved struct device (which was an array) from meson_mx_mmc_host to
  the corresponding meson_mx_mmc_slot
- use struct mmc_command's busy_timeout instead of hard-coding the
  timeout values in meson_mx_mmc_start_cmd()
- don't use arrays with only one element for the clock parents in
  meson_mx_mmc_register_clks()
- removed the wrapper functions meson_mx_mmc_readl() meson_mx_mmc_writel()
- allow setting the MMC clock to 0 for UHS speed mode (the actual
  hardware clock cannot be gated as far as I know, so instead the
  lowest supported rate is chosen)
- remove unused #include <linux/init.h>
- add MMC_CAP_ERASE
- removed multiple slot support after discussing this with Ulf
  (this is a feature that needs to be part of the MMC core before drivers
  can use it)
- removed SDIO interrupt support (as I currently don't have a way to
  test it)
- merge meson_mx_mmc_apply_ios into meson_mx_mmc_set_ios (as that's
  the only place where it's needed after removing multiple slot support)
- updated the commit message of the driver patch to indicate the
  difference between the meson-mx-sdio.c and meson-gx.c (and the "still
  missing SDHC") driver
- NOTE: I did not add Rob's ACK on the dt-bindings patch because I
  introduced the "mmc-slot" compatible for the child nodes as suggested
  by Ulf (and I want confirmation from the DT maintainers that I did this
  correctly)


(notable) changes since Carlo's latest from [0] version are:
- renamed the driver to meson-mx-sdio (Amlogic's reference kernel calls
  the driver "aml_sdio" as there is a second MMC controller in these SoCs
  which they call the "SDHC controller"). do the same with our driver to
  avoid confusion once we add support for the second controller (which uses
  a completely different register layout)
- add support for the internal "mux" in this MMC controller (which allows
  connecting up to three devices to the the controller - at the cost of
  performance though since the controller can only process one request at
  a time). The driver registers a new device for each sub-node, which is
  then fed into the MMC framework to allow per-slot configuration using
  devicetree (see the example in the documentation)
- use the common clock framework internally for managing the MMC clock
  (there is a fixed-factor clock in the controller which takes clk81 as
   input and divides it's clock by two and a divider clock which takes
   the result from the fixed-factor clock as input)
- support the regulators provided by the MMC framework
- support for GPIO-based card-detection and read-only-detection through
  the MMC framework
- use of the <linux/bitfield.h> FIELD_PREP and FIELD_GET macros where it
  make sense (and thus the code easier to read)
- re-worked locking (based on the locking in dw_mmc as that also provides
  multiple "MMC slots")


tests done so far (use-cases which involve two cards were done only with
RFC v1):
- reading an OLD 256MiB SD card (which uses only a 1-bit bus) works fine
  (sha1sum of the whole device matches with what I get on my PC's
  card-reader)
- reading a somewhat more modern class 10 SD card and putting Arch Linux
  ARM on it (and using that as root file system)
- it successfully detects the RTL8723BS SDIO wifi chip in my device (even
  if the SD card is also enabled)
- reading a 128MiB file from the SD card while scanning wifi networks on
  the RTL8723BS card does not seem to result in any corruption (sha1sum
  of the read file seems to match)
- read speed of my class 10 SD card: ~15MiB/s
- (unfortunately I could NOT test downloading a file over wifi to the SD
  card because the RTL8723BS driver refuses to see any wifi networks, but
  that might be a problem on the RTL8723BS driver side since I don't get
  any error and the driver has just landed a few weeks ago in staging)


[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/412136.html
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-May/003466.html
[2] http://lists.infradead.org/pipermail/linux-amlogic/2017-September/004778.html

Carlo Caione (2):
  dt-bindings: mmc: Document the Amlogic Meson8 and Meson8b SDIO
    bindings
  mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b
    SoCs

 .../bindings/mmc/amlogic,meson-mx-sdio.txt         |  54 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/meson-mx-sdio.c                   | 769 +++++++++++++++++++++
 4 files changed, 837 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
 create mode 100644 drivers/mmc/host/meson-mx-sdio.c

-- 
2.14.2

