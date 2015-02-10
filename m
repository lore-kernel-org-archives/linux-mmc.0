From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.3.20
Date: Tue, 10 Feb 2015 09:40:18 +0100
Message-ID: <CAPDyKFr5QzkgUVZAWwY6EqfEF76902Yra6VHu2P__PdYMxTQdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:46653 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbbBJIkT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 03:40:19 -0500
Received: by mail-qg0-f54.google.com with SMTP id z60so25096908qgd.13
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2015 00:40:18 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>

Hi Linus,

Here are the PR for MMC for v3.20.

Stephen Rothwell has reported about a conflict in
drivers/mmc/host/sunxi-mmc.c between commit "mmc: sunxi:
Convert MMC driver to the standard clock phase API" from the sunxi
tree and commit "mmc: sunxi: Removing unused code" from my mmc tree.

The conflict should be rather trivial to resolve, but I am happy to
help if needed.

Details about the MMC highlights are found in the signed tag. Please
pull this in!

Kind regards
Ulf Hansson


The following changes since commit ec6f34e5b552fb0a52e6aae1a5afbbb1605c=
c6cc:

  Linux 3.19-rc5 (2015-01-18 18:02:20 +1200)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v3.20-1

for you to fetch changes up to 017210d1c0dc2e2d3b142985cb31d90b98dc0f0f=
:

  mmc: sdhci-s3c: solve problem with sleeping in atomic context
(2015-02-04 13:39:14 +0100)

----------------------------------------------------------------
MMC core:
- Support for MMC power sequences.
- SDIO function devicetree subnode parsing.
- Refactor the hardware reset routines and enable it for SD cards.
- Various code quality improvements, especially for slot-gpio.

MMC host:
- dw_mmc: Various fixes and cleanups.
- dw_mmc: Convert to mmc_send_tuning().
- moxart: Fix probe logic.
- sdhci: Various fixes and cleanups
- sdhci: Asynchronous request handling support.
- sdhci-pxav3: Various fixes and cleanups.
- sdhci-tegra: Fixes for T114, T124 and T132.
- rtsx: Various fixes and cleanups.
- rtsx: Support for SDIO.
- sdhi/tmio: Refactor and cleanup of header files.
- omap_hsmmc: Use slot-gpio and common MMC DT parser.
- Make all hosts to deal with errors from mmc_of_parse().
- sunxi: Various fixes and cleanups.
- sdhci: Support for Fujitsu SDHCI controller f_sdh30.

----------------------------------------------------------------
Adrian Hunter (3):
      mmc: core: Simplify by adding mmc_execute_tuning()
      mmc: core: Move mmc_card_removed() into mmc_start_request()
      mmc: sdhci: Always init buf_ready_int

Alessio Igor Bogani (1):
      mmc: sdhci: Fix FSL ESDHC reset handling quirk

Alexey Skidanov (1):
      mmc: Resolve BKOPS compatability issue

Andrew Gabbasov (1):
      mmc: sdhci: Remove redundant ADMA page boundary warnings

Andy Shevchenko (1):
      mmc: sdhci-acpi: fix copy'n'paste typos in the comments

Arnd Bergmann (1):
      mmc: moxart: fix probe logic

Asaf Vertz (1):
      mmc: block: fix format string warning

Axel Lin (1):
      mmc: toshsd: Fix unbalanced locking

Beomho Seo (1):
      mmc: dw_mmc: remove unnecessary debug message

Dan Carpenter (1):
      mmc: mxs-mmc: remove unneeded NULL check

David Lanzend=C3=B6rfer (3):
      mmc: sunxi: Lock fix
      mmc: sunxi: Correcting SDXC_HARDWARE_RESET bit
      mmc: sunxi: Removing unused code

Dmitry Torokhov (2):
      mmc: dw_mmc: exynos: remove incorrect __exit_p()
      mmc: dw_mmc: rockchip: remove incorrect __exit_p()

Doug Anderson (5):
      ARM: OMAP2+: Make sure pandora_wl1251_init_card() applies to SDIO=
 only
      mmc: core: Support the optional init_card() callback for MMC and =
SD
      mmc: dw_mmc: Cleanup disable of low power mode w/ SDIO interrupts
      mmc: dw_mmc: Protect read-modify-write of INTMASK with a lock
      mmc: dw_mmc: Power on vqmmc in MMC_POWER_ON, not MMC_POWER_UP

Gregory CLEMENT (2):
      mmc: sdhci-pxav3: Fix SDR50 and DDR50 capabilities for the
Armada 38x flavor
      mmc: sdhci-pxav3: Extend binding with SDIO3 conf reg for the Arma=
da 38x

Haibo Chen (1):
      mmc: sdhci: use pipeline mmc requests to improve performance

Hans de Goede (1):
      mmc: sunxi: Fix setup of last descriptor of dma transfer

Javier Martinez Canillas (4):
      mmc: pwrseq: Document that simple sequence support more than one =
GPIO
      mmc: pwrseq_simple: Extend to support more pins
      mmc: pwrseq: Document optional clock for the simple power sequenc=
e
      mmc: pwrseq_simple: Add optional reference clock support

Jean Delvare (3):
      mmc: Enable Ricoh MMC quirk by default
      mmc: Fix menuconfig alignment of MMC_SDHCI_* options
      mmc: Add hardware dependencies for sdhci-pxav3 and sdhci-pxav2

Jisheng Zhang (6):
      mmc: sdhci-pxav3: fix unbalanced clock issues during probe
      mmc: sdhci-pxav3: fix pm unbalanced issue in -> remove()
      mmc: sdhci-pxav3: Remove checks for optional core clock in
error/remove path
      mmc: sdhci-pxav3: fix race between runtime pm and irq
      mmc: sdhci-pxav3: fix setting of pdata->clk_delay_cycles
      mmc: sdhci: switch voltage before sdhci_set_ios in runtime resume

Johan Rudholm (3):
      mmc: core: always check status after reset
      mmc: core: refactor the hw_reset routines
      mmc: sd: add reset bus_ops callback

Kuninori Morimoto (17):
      mmc: tmio: add tmio_mmc_host_alloc/free()
      mmc: tmio: tmio_mmc_host has .dma
      mmc: tmio: tmio_mmc_host has .write16_hook
      mmc: tmio: tmio_mmc_host has .clk_enable
      mmc: tmio: tmio_mmc_host has .clk_disable
      mmc: tmio: tmio_mmc_host has .multi_io_quirk
      mmc: tmio: tmio_mmc_host has .bus_shift
      mmc: tmio: tmio_mmc_data has .alignment_shift
      mmc: tmio: tmio_mmc_data has .dma_rx_offset
      mmc: tmio: add .enable_dma on tmio_mmc_dma
      mmc: tmio: enable SoC specific DMA buswidth settings
      mmc: sh_mobile_sdhi: remove .init/.cleanup
      mmc: sh_mobile_sdhi: tidyup mmc_data->bus_shift for latest SoC
      mmc: sh_mobile_sdhi: add new macro for mmc_host to sh_mobile_sdhi
      mmc: sh_mobile_sdhi: use .enable_dma
      mmc: sh_mobile_sdhi: enable 32bit DMA access
      mmc: tmio: remove TMIO_MMC_HAVE_CTL_DMA_REG flag

Marcin Wojtas (2):
      mmc: sdhci-pxav3: Fix Armada 38x controller's caps according to
erratum ERR-7878951
      mmc: sdhci-pxav3: Modify clock settings for the SDR50 and DDR50 m=
odes

Marek Szyprowski (1):
      mmc: pwrseq: add driver for emmc hardware reset

Micky Ching (7):
      mmc: rtsx: add dump_reg_range to simplify dump register
      mmc: rtsx: init cookie at probe/card_event
      mmc: rtsx: add helper function to simplify code
      mmc: rtsx: add support for sdio card
      mmc: rtsx: swap function position to avoid pre declaration
      mmc: rtsx: finish request if no card exist
      mmc: rtsx: check sg_count before long data xfer

Minda Chen (1):
      mmc: sdhci-sirf: add sirf tuning function (cmd 19)

Mohammad Jamal (1):
      mmc: host: sdhci: Added a space before (

NeilBrown (4):
      mmc: omap_hsmmc: remove prepare/complete system suspend support.
      mmc: slot-gpio: Allow host driver to provide isr for card-detect
interrupts
      mmc: omap_hsmmc: use slot-gpio library for gpio support.
      mmc: omap_hsmmc: use mmc_of_parse to parse common mmc configurati=
on.

Nicholas Mc Guire (1):
      mmc: vub300: remove unreachable return value handling

Paul Osmialowski (1):
      mmc: sdhci-s3c: solve problem with sleeping in atomic context

Pavan Kunapuli (1):
      mmc: tegra: Write xfer_mode, CMD regs in together

Pramod Gurav (1):
      mmc: mmci: Get rid of dead code in mmci_dma_setup

Sascha Hauer (2):
      mmc: Add SDIO function subnode DT documentation
      mmc: Add SDIO function devicetree subnode parsing

Seungwon Jeon (3):
      mmc: dw_mmc: fix the max_blk_count in IDMAC
      mmc: dw_mmc: exynos: don't use if clock isn't available
      mmc: dw_mmc: exynos: move definitions to header file

Tobias Klauser (1):
      mmc: block: Remove unnecessary temporary variable

Ulf Hansson (26):
      mmc: moxart: Handle error from mmc_of_parse()
      mmc: sdhci-bcm-kona: Handle error from mmc_of_parse()
      mmc: sdhci-of-esdhc: Handle error from mmc_of_parse()
      mmc: sdhci-s3c: Handle error from mmc_of_parse()
      mmc: sdhci-st: Do cleanup while mmc_of_parse() return an error
      mmc: core: Return error at failure of request CD/WP in mmc_of_par=
se()
      mmc: mvsdio: Remove redundant use of mmc_gpio_free_cd|ro()
      mmc: sdhci-sirf: Remove redundant use of mmc_gpio_free_cd()
      mmc: slot-gpio: Remove option to explicitly free requested CD/WP =
GPIOs
      mmc: slot-gpio: Use the parent device while allocating data
      mmc: slot-gpio: Make mmc_gpio_alloc() available for MMC core
      mmc: core: Free all resources for the class device at ->dev_relea=
se()
      mmc: slot-gpio: Rework how to handle allocation of slot-gpio data
      mmc: sdhci-esdhc-imx: Fixup ->remove()
      mmc: sdhci-esdhc-imx: Fixup runtime PM conditions during ->probe(=
)
      mmc: sdhci-pci: Remove redundant runtime PM idle callback
      mmc: mmci: Do pm_runtime_put() after the host has been added
      mmc: dw_mmc: Convert to mmc_send_tuning()
      mmc: core: Make tuning block patterns static
      mmc: sdhci-acpi: Remove redundant runtime PM idle callback
      Merge branch 'tmio' into next
      mmc: core: Initial support for MMC power sequences
      mmc: pwrseq: Document DT bindings for the simple MMC power sequen=
ce
      mmc: pwrseq: Initial support for the simple MMC power sequence pr=
ovider
      mmc: pwrseq_simple: Add support for a reset GPIO pin
      mmc: core: Invoke mmc_pwrseq_post_power_on() prior MMC_POWER_ON s=
tate

Vincent Yang (4):
      mmc: sdhci: add a voltage switch callback function
      mmc: sdhci: add a quirk for tuning work around
      mmc: sdhci: add a quirk for single block transactions
      mmc: sdhci: host: add new f_sdh30

Wei Yongjun (1):
      mmc: toshsd: use module_pci_driver to simplify the code

Wolfram Sang (1):
      mmc: mvsdio: don't use devm_pinctrl_get_select_default() in probe

Wu Fengguang (1):
      mmc: sdhci: host: fix odd_ptr_err.cocci warnings

 .../devicetree/bindings/mmc/mmc-pwrseq-emmc.txt    |  25 +
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  25 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |  62 ++-
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  30 ++
 .../devicetree/bindings/mmc/sdhci-pxa.txt          |  15 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |  14 +-
 drivers/mmc/card/block.c                           |   6 +-
 drivers/mmc/card/mmc_test.c                        |  18 +-
 drivers/mmc/core/Makefile                          |   2 +-
 drivers/mmc/core/bus.c                             |   4 +
 drivers/mmc/core/core.c                            | 152 +++---
 drivers/mmc/core/core.h                            |   7 +
 drivers/mmc/core/host.c                            |  65 +--
 drivers/mmc/core/mmc.c                             | 101 ++--
 drivers/mmc/core/mmc_ops.c                         |  30 ++
 drivers/mmc/core/pwrseq.c                          | 112 +++++
 drivers/mmc/core/pwrseq.h                          |  43 ++
 drivers/mmc/core/pwrseq_emmc.c                     | 101 ++++
 drivers/mmc/core/pwrseq_simple.c                   | 145 ++++++
 drivers/mmc/core/sd.c                              |  27 +-
 drivers/mmc/core/sdio.c                            |  14 +-
 drivers/mmc/core/sdio_bus.c                        |  11 +
 drivers/mmc/core/slot-gpio.c                       | 182 ++-----
 drivers/mmc/core/slot-gpio.h                       |  13 +
 drivers/mmc/host/Kconfig                           |  15 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 113 +----
 drivers/mmc/host/dw_mmc-exynos.h                   |  56 +++
 drivers/mmc/host/dw_mmc-rockchip.c                 |   2 +-
 drivers/mmc/host/dw_mmc.c                          | 124 +++--
 drivers/mmc/host/dw_mmc.h                          |   9 +-
 drivers/mmc/host/mmci.c                            |   7 +-
 drivers/mmc/host/moxart-mmc.c                      |  24 +-
 drivers/mmc/host/mvsdio.c                          |  10 -
 drivers/mmc/host/mxs-mmc.c                         |   3 +-
 drivers/mmc/host/omap_hsmmc.c                      | 150 +-----
 drivers/mmc/host/rtsx_pci_sdmmc.c                  | 542 ++++++++++++-=
--------
 drivers/mmc/host/sdhci-acpi.c                      |  13 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |   4 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  17 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  20 +-
 drivers/mmc/host/sdhci-pci.c                       |   7 +-
 drivers/mmc/host/sdhci-pxav3.c                     | 119 ++++-
 drivers/mmc/host/sdhci-s3c.c                       |  12 +-
 drivers/mmc/host/sdhci-sirf.c                      |  74 ++-
 drivers/mmc/host/sdhci-st.c                        |   4 +-
 drivers/mmc/host/sdhci-tegra.c                     |  30 +-
 drivers/mmc/host/sdhci.c                           | 125 ++++-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 237 +++++++++
 drivers/mmc/host/sh_mobile_sdhi.c                  | 117 +++--
 drivers/mmc/host/sunxi-mmc.c                       |  29 +-
 drivers/mmc/host/tmio_mmc.c                        |  15 +-
 drivers/mmc/host/tmio_mmc.h                        |  43 +-
 drivers/mmc/host/tmio_mmc_dma.c                    |  38 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |  61 ++-
 drivers/mmc/host/toshsd.c                          |  17 +-
 drivers/mmc/host/vub300.c                          |   4 +-
 include/linux/mfd/tmio.h                           |  28 +-
 include/linux/mmc/card.h                           |   2 +-
 include/linux/mmc/core.h                           |   1 -
 include/linux/mmc/dw_mmc.h                         |   6 +
 include/linux/mmc/host.h                           |   4 +-
 include/linux/mmc/mmc.h                            |  10 +-
 include/linux/mmc/sdhci.h                          |  10 +
 include/linux/mmc/sh_mobile_sdhi.h                 |  15 -
 include/linux/mmc/slot-gpio.h                      |   5 +-
 include/linux/platform_data/mmc-omap.h             |   4 -
 68 files changed, 2152 insertions(+), 1180 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-em=
mc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-si=
mple.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu=
=2Etxt
 create mode 100644 drivers/mmc/core/pwrseq.c
 create mode 100644 drivers/mmc/core/pwrseq.h
 create mode 100644 drivers/mmc/core/pwrseq_emmc.c
 create mode 100644 drivers/mmc/core/pwrseq_simple.c
 create mode 100644 drivers/mmc/core/slot-gpio.h
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.h
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
