From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.16
Date: Mon, 29 Jan 2018 11:14:48 +0100
Message-ID: <1517220888-4431-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34008 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeA2KOy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jan 2018 05:14:54 -0500
Received: by mail-wm0-f51.google.com with SMTP id j21so35669571wmh.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jan 2018 02:14:53 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

Hi Linus,

Here's the PR for MMC for v4.16. Details about the highlights are as usual found
in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.16

for you to fetch changes up to 310eb252a78307fc2ac4c4c755290a578c0304d0:

  mmc: mmci: fix error return code in mmci_probe() (2018-01-24 13:51:07 +0100)

----------------------------------------------------------------
There are two major achievements for MMC in this release, which deserves to be
specially highlighted.

First, we have converted the MMC block device from using the legacy blk
interface into using the modern blkmq interface. Not only do we get all the
nice effects from using blkmq, but it also means that new fresh nice code
replaces old rusty code. Great news to everybody that cares about MMC/SD!

It should also be noted that converting to blkmq has not been trivial, mostly
because of that we have been carrying too much of MMC specific optimizations
for the I/O request path, rather than striving to move these to the generic blk
layer. Hopefully we won't be doing that mistake, ever again.

Special thanks to Adrian Hunter (Intel) and to Linus Walleij (Linaro), who both
have been working on this for quite some time!

Second, on top of the blkmq deployment, we have enabled full support the eMMC
command queuing feature, introduced in the eMMC v.5.1 spec. This also includes
an implementation of a host driver library, supporting the corresponding CQHCI
HW. Ideally, those controllers that supports CQHCI should only need some minor
adaptations to make this play.

So far the sdhci-pci driver for the Intel GLKs and the sdhci-of-arasan driver
used on Rockchip RK3399, have enabled support for eMMC command queueing.

Worth to highlight is also that, implementing the eMMC command queuing support
has been a collaborative effort, as several people from Codeaurora, Rockchip,
Intel and Linaro have been involved. However, the work has been driven by
Adrian Hunter (Intel).

In some shadow of the above, here are the rest of the highlights:

MMC core:
 - Don't remove non-removable cards during system suspend
 - Add a slot-gpio helper to check capability of GPIO WP detection

MMC host:
 - sdhci: Cleanups and improvements of some wakeup related code
 - sdhci-pci-arasan: New variant to support Arasan PCI HW with integrated phy
 - sdhci-acpi: Avoid broken UHS transfer modes on Intel CHT
 - sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400
 - sdhci_f_sdh30: Add ACPI support
 - sdhci-esdhc-imx: Enable/disable clock at runtime suspend/resume
 - sdhci-of-esdhc: A few minor fixes
 - mmci: Add support for new STM32 variant
 - renesas_sdhi: enable R-Car D3 (r8a77995) support
 - tmio/renesas_sdhi: Re-structuring, cleanups and modernizations

----------------------------------------------------------------
Adam Borowski (1):
      mmc: sunxi: fix mojibake in module metadata

Adrian Hunter (31):
      mmc: block: No need to export mmc_cleanup_queue()
      mmc: block: Simplify cleaning up the queue
      mmc: core: Make mmc_pre_req() and mmc_post_req() available
      mmc: block: Add error-handling comments
      mmc: core: Add parameter use_blk_mq
      mmc: block: Add blk-mq support
      mmc: block: Add CQE support
      mmc: sdhci-pci: Add CQHCI support for Intel GLK
      mmc: block: blk-mq: Add support for direct completion
      mmc: block: blk-mq: Separate card polling from recovery
      mmc: block: Make card_busy_detect() accumulate all response error bits
      mmc: block: blk-mq: Check error bits and save the exception bit when polling card busy
      mmc: block: Check the timeout correctly in card_busy_detect()
      mmc: block: Check for transfer state in card_busy_detect()
      mmc: block: Add timeout_clks when calculating timeout
      mmc: block: Reduce polling timeout from 10 minutes to 10 seconds
      mmc: block: blk-mq: Stop using legacy recovery
      mmc: mmc_test: Do not use mmc_start_areq() anymore
      mmc: core: Ensure cmd_completion is initialized
      mmc: mmc_test: Ensure command queue is disabled for testing
      mmc: core: Remove option not to use blk-mq
      mmc: block: Remove code no longer needed after the switch to blk-mq
      mmc: core: Remove code no longer needed after the switch to blk-mq
      mmc: cqhci: Ensure macro parameters are wrapped in parentheses
      mmc: sdhci-acpi: Add setup_host() callback
      mmc: sdhci-acpi: Avoid broken UHS transfer modes on Intel CHT
      mmc: sdhci-pci: Stop calling sdhci_enable_irq_wakeups()
      mmc: sdhci-pci: Use device wakeup capability to determine MMC_PM_WAKE_SDIO_IRQ capability
      mmc: sdhci: Stop exporting sdhci_enable_irq_wakeups()
      mmc: sdhci: Handle failure of enable_irq_wake()
      mmc: sdhci: Rework sdhci_enable_irq_wakeups()

Andy Shevchenko (1):
      sdhci: Advertise 2.0v supply on SDIO host controller

Ard Biesheuvel (1):
      mmc: sdhci_f_sdh30: add ACPI support

Arnd Bergmann (3):
      mmc_test: use ktime_get_ts64 for timestamps
      mmc: s3mci: mark debug_regs[] as static
      mmc: tmio: hide unused tmio_mmc_clk_disable/tmio_mmc_clk_enable functions

Arvind Yadav (5):
      mmc: meson-gx-mmc: Fix platform_get_irq's error checking
      mmc: s3cmci: Fix platform_get_irq's error checking
      mmc: sdhci-acpi: Handle return value of platform_get_irq
      mmc: sdhci-spear: Handle return value of platform_get_irq
      mmc: sunxi-mmc: Handle return value of platform_get_irq

Atul Garg (1):
      mmc:host:sdhci-pci:Addition of Arasan PCI Controller with integrated phy.

Benoît Thébaudeau (1):
      mmc: sdhci-esdhc-imx: Fix i.MX53 eSDHCv3 clock

Christoph Fritz (1):
      mmc: core: apply NO_CMD23 quirk to some specific cards

Colin Ian King (2):
      mmc: block: make function mmc_cqe_issue_type static
      mmc: sh_mmcif: remove redundant initialization of 'opc'

Dan Carpenter (2):
      mmc: block: blk-mq: Potential NULL deref on mmc_blk_alloc_req() failure
      mmc: tmio, renesas_sdhi: Remove unneeded NULL check

Daniel Drake (1):
      mmc: avoid removing non-removable hosts during suspend

David Lechner (2):
      mmc: davinci: dont' use module_platform_driver_probe()
      mmc: davinci: suppress error message on EPROBE_DEFER

Liu, Changcheng (1):
      mmc: block: fix logical error to avoid memory leak

Masaharu Hayakawa (1):
      mmc: renesas_sdhi: Add MODULE_LICENSE

Masahiro Yamada (21):
      mmc: slot-gpio: call gpiod_to_irq() only when MMC_CAP_NEEDS_POLL is unset
      mmc: renesas_sdhi: consolidate DMAC CONFIG options
      mmc: renesas_sdhi: remove wrong depends on to enable compile test
      mmc: renesas_sdhi: remove eprobe jump label
      mmc: tmio: set tmio_mmc_host to driver data
      mmc: tmio: use devm_ioremap_resource() instead of devm_ioremap()
      mmc: tmio: move mmc_host_ops to struct tmio_mmc_host from static data
      mmc: tmio, renesas_sdhi: set mmc_host_ops hooks directly
      mmc: tmio: move mmc_gpio_request_cd() before mmc_add_host()
      mmc: renesas_sdhi: remove always false condition
      mmc: tmio, renesas_sdhi: move struct tmio_mmc_dma to renesas_sdhi.h
      mmc: tmio, renesas_sdhi: move Renesas-specific DMA data to renesas_sdhi.h
      mmc: tmio,renesas_sdhi: move ssc_tappos to renesas_sdhi.h
      mmc: tmio: change bus_shift to unsigned int
      mmc: tmio: use mmc_can_gpio_cd() instead of checking TMIO_MMC_USE_GPIO_CD
      mmc: tmio: ioremap memory resource in tmio_mmc_host_alloc()
      mmc: tmio: move clk_enable/disable out of tmio_mmc_host_probe()
      mmc: tmio: move {tmio_}mmc_of_parse() to tmio_mmc_host_alloc()
      mmc: tmio: remove dma_ops from tmio_mmc_host_probe() argument
      mmc: slot-gpio: add a helper to check capability of GPIO WP detection
      mmc: tmio: refactor .get_ro hook

Michael Trimarchi (3):
      mmc: sdhci-esdhc-imx: Manage sdhci_runtime_suspend_host error code
      mmc: sdhci-esdhc-imx: Changes the order of how clocks are being re-enabled
      mmc: sdhci-esdhc-imx: Enable/Disable mmc clock during runtime suspend

Milan Stevanovic (1):
      mmc: sdhci-of-arasan: Add sdhci_arasan_set_power

Patrice Chotard (5):
      mmc: mmci: Don't pretend all variants to have MMCIMASK1 register
      mmc: mmci: Don't pretend all variants to have MCI_STARBITERR flag
      mmc: mmci: Don't pretend all variants to have OPENDRAIN bit
      mmc: mmci: Add support for setting pad type via pinctrl
      mmc: mmci: Add STM32 variant

Pravin Shedge (1):
      mmc: android-goldfish: remove duplicate includes

Sean Wang (1):
      mmc: dt-bindings: add mmc support to MT7623 SoC

Shah Nehal-Bakulchandra (1):
      mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400

Shawn Lin (1):
      mmc: sdhci-of-arasan: Add CQHCI support for arasan,sdhci-5.1

Ulf Hansson (5):
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Ulrich Hecht (2):
      dt-bindings: mmc: renesas_sdhi: Add r8a77995 support
      mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support

Venkat Gopalakrishnan (1):
      mmc: cqhci: support for command queue enabled host

Wei Yongjun (1):
      mmc: mmci: fix error return code in mmci_probe()

Wolfram Sang (5):
      mmc: core: properly init drv_type
      mmc: core: use usleep_range rather than HZ magic in mmc_delay()
      mmc: tmio: use usleep_range consistently
      mmc: tmio: use ioread* for repeated access to a register
      mmc: tmio: use io* accessors consistently

Wu Fengguang (1):
      mmc: block: blk-mq: fix boolreturn.cocci warnings

Zhoujie Wu (1):
      mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable

yinbo.zhu (2):
      mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec
      mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb

 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |    2 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |    1 +
 drivers/mmc/core/block.c                           | 1385 +++++++++++---------
 drivers/mmc/core/block.h                           |   12 +-
 drivers/mmc/core/bus.c                             |    2 -
 drivers/mmc/core/card.h                            |    2 +
 drivers/mmc/core/core.c                            |  228 +---
 drivers/mmc/core/core.h                            |   47 +-
 drivers/mmc/core/host.h                            |    6 +-
 drivers/mmc/core/mmc.c                             |    2 +-
 drivers/mmc/core/mmc_test.c                        |  221 ++--
 drivers/mmc/core/queue.c                           |  504 ++++---
 drivers/mmc/core/queue.h                           |   64 +-
 drivers/mmc/core/quirks.h                          |    8 +
 drivers/mmc/core/slot-gpio.c                       |   22 +-
 drivers/mmc/host/Kconfig                           |   22 +-
 drivers/mmc/host/Makefile                          |   11 +-
 drivers/mmc/host/android-goldfish.c                |    2 -
 drivers/mmc/host/cqhci.c                           | 1150 ++++++++++++++++
 drivers/mmc/host/cqhci.h                           |  240 ++++
 drivers/mmc/host/davinci_mmc.c                     |   17 +-
 drivers/mmc/host/meson-gx-mmc.c                    |    2 +-
 drivers/mmc/host/mmci.c                            |  127 +-
 drivers/mmc/host/mmci.h                            |    6 +
 drivers/mmc/host/renesas_sdhi.h                    |   22 +
 drivers/mmc/host/renesas_sdhi_core.c               |   52 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   15 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   37 +-
 drivers/mmc/host/s3cmci.c                          |    8 +-
 drivers/mmc/host/sdhci-acpi.c                      |  132 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   36 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  149 ++-
 drivers/mmc/host/sdhci-of-esdhc.c                  |    8 +
 drivers/mmc/host/sdhci-pci-arasan.c                |  331 +++++
 drivers/mmc/host/sdhci-pci-core.c                  |  218 ++-
 drivers/mmc/host/sdhci-pci.h                       |    7 +-
 drivers/mmc/host/sdhci-spear.c                     |    4 +
 drivers/mmc/host/sdhci-xenon.c                     |    7 +
 drivers/mmc/host/sdhci.c                           |   57 +-
 drivers/mmc/host/sdhci.h                           |    2 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |   52 +-
 drivers/mmc/host/sh_mmcif.c                        |    2 +-
 drivers/mmc/host/sunxi-mmc.c                       |    9 +-
 drivers/mmc/host/tmio_mmc.c                        |   23 +-
 drivers/mmc/host/tmio_mmc.h                        |   43 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  152 +--
 include/linux/mmc/host.h                           |    5 +-
 include/linux/mmc/slot-gpio.h                      |    1 +
 48 files changed, 4009 insertions(+), 1446 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci.c
 create mode 100644 drivers/mmc/host/cqhci.h
 create mode 100644 drivers/mmc/host/sdhci-pci-arasan.c
