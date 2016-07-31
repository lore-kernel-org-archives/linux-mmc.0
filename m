From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.8
Date: Sun, 31 Jul 2016 18:35:50 +0200
Message-ID: <CAPDyKFp8RB=Fs_DBLS7PY4_Gz+g7e-9m1=0A=d5cboGUj58Qqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR for MMC v4.8 - sorry for being late!
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit 523d939ef98fd712632d93a5a2b588e477a7565e:

  Linux 4.7 (2016-07-24 12:23:50 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.8

for you to fetch changes up to 6ea6257945188ff7f5d1670d5adc964ac78c590c:

  mmc: rtsx_pci: Remove deprecated create_singlethread_workqueue
(2016-07-29 11:29:05 +0200)

----------------------------------------------------------------
MMC core:
 - A couple of changes to improve the support for erase/discard/trim cmds
 - Add eMMC HS400 enhanced strobe support
 - Show OCR and DSR registers in SYSFS for MMC/SD cards
 - Correct and improve busy detection logic for MMC switch (CMD6) cmds
 - Disable HPI cmds for certain broken Hynix eMMC cards
 - Allow MMC hosts to specify non-support for SD and MMC cmds
 - Some minor additional fixes

MMC host:
 - sdhci: Re-works, fixes and clean-ups
 - sdhci: Add HW auto re-tuning support
 - sdhci: Re-factor code to prepare for adding support for eMMC CMDQ
 - sdhci-esdhc-imx: Fixes and clean-ups
 - sdhci-esdhc-imx: Update system PM support
 - sdhci-esdhc-imx: Enable HW auto re-tuning
 - sdhci-bcm2835: Remove driver as sdhci-iproc is used instead
 - sdhci-brcmstb: Add new driver for Broadcom BRCMSTB SoCs
 - sdhci-msm: Add support for UHS cards
 - sdhci-tegra: Improve support for UHS cards
 - sdhci-of-arasan: Update phy support for Rockchip SoCs
 - sdhci-of-arasan: Deploy enhanced strobe support
 - dw_mmc: Some fixes and clean-ups
 - dw_mmc: Enable support for erase/discard/trim cmds
 - dw_mmc: Enable CMD23 support
 - mediatek: Some fixes related to the eMMC HS400 support
 - sh_mmcif: Improve support for HW busy detection
 - rtsx_pci: Enable support for erase/discard/trim cmds

----------------------------------------------------------------
Adrian Hunter (27):
      mmc: sdhci: Fix sdhci_card_busy()
      mmc: block: Fix tag condition with packed writes
      mmc: sdhci: Do not call implementations of mmc host ops directly
      mmc: sdhci: Split sdhci_add_host()
      mmc: sdhci: Make signal voltage support explicit
      mmc: sdhci: Tidy caps variables in sdhci_setup_host()
      mmc: sdhci: Add sdhci_read_caps()
      mmc: sdhci-pci: Do not runtime suspend at the end of sdhci_pci_probe()
      mmc: sdhci: Move busy signal handling into sdhci_finish_cmd()
      mmc: sdhci: Get rid of redundant BUG_ONs
      mmc: sdhci: Simplify sdhci_finish_command() by clearing
host->cmd at the start
      mmc: sdhci: Record what command is using the data lines
      mmc: sdhci: Get rid of host->busy_handle
      mmc: sdhci: Reduce the use of host->mrq
      mmc: sdhci: Move host->data warning
      mmc: sdhci: Factor out sdhci_finish_mrq()
      mmc: sdhci: Factor out sdhci_needs_reset()
      mmc: sdhci: Track whether a reset is pending
      mmc: sdhci: Clear pointers when a request finishes
      mmc: sdhci: Ensure all requests get errored out
      mmc: sdhci: Factor out sdhci_data_line_cmd()
      mmc: sdhci: Separate timer timeout for command and data requests
      mmc: sdhci: Allow for finishing multiple requests
      mmc: sdhci: Factor out sdhci_auto_cmd12()
      mmc: sdhci: Do not reset cmd or data circuits that are in use
      mmc: sdhci: Avoid STOP cmd triggering warning in sdhci_send_command()
      mmc: sdhci: sdhci_execute_tuning() must delete timer

Al Cooper (2):
      mmc: DT: sdhci-brcmstb: Add device tree bindings
      mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs

Andy Shevchenko (2):
      mmc: sdhci-pci: Convert to use managed functions pcim_* and devm_*
      sdhci-pci: Use MRFLD as abbreviation of Merrifield

Baolin Wang (1):
      mmc: Change the max discard sectors and erase response when HW busy detect

Ben Dooks (1):
      mmc: dw_mmc: fix 32bit little-endian access of des1 field

Bhaktipriya Shridhar (1):
      mmc: rtsx_pci: Remove deprecated create_singlethread_workqueue

Bojan Prtvar (2):
      mmc: core: Extend sysfs with OCR register
      mmc: core: Extend sysfs with DSR register

Brian Norris (2):
      phy: rockchip-emmc: configure default output tap delay
      phy: rockchip-emmc: reindent the register definitions

Chaotian Jing (7):
      mmc: mmc: Use ->card_busy() to detect busy cards in __mmc_switch()
      mmc: mmc: do not use CMD13 to get status after speed mode switch
      mmc: mmc: fix switch timeout issue caused by jiffies precision
      mmc: mediatek: do not tune data for HS400 mode
      mmc: mediatek: fix CRC error when calling mmc_select_hs400()
      mmc: mediatek: fix CMD21/CMD19 timeout issue
      mmc: mediatek: perfer to use rise edge latching

Chuanxiao Dong (1):
      mmc: sdhci: use pr_err for sdhci_dumpregs

Colin Ian King (1):
      mmc: sdhci-msm: fix spelling mistake: "Perpheral" -> "Peripheral"

Dong Aisheng (15):
      mmc: sdhci: using common mmc_regulator_set_vqmmc()
      mmc: sdhci-esdhc-imx: remove SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
      mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback
      mmc: sdhci-esdhc-imx: restore watermark level setting after resume
      mmc: sdhci-esdhci-imx: disable DLL delay line settings explicitly
      mmc: sdhci-esdhc-imx: support setting tuning start point
      doc: dt: fsl-imx-esdhc: add set tuning start point binding
      mmc: sdhci: add standard hw auto retuning support
      mmc: sdhci-esdhc-imx: enable hw auto retuning for STD_TUNING
      mmc: sdhci-esdhc-imx: enable hw auto retuning for MAN_TUNING
      mmc: sdhci-esdhc-imx: fix strobe DLL lock wrong clock issue
      mmc: sdhci-esdhc-imx: factor out hw related initialization into function
      mmc: sdhci-esdhc-imx: move tuning static configuration into
hwinit function
      mmc: sdhci-esdhci-imx: re-initialize hw state after resume
      mmc: sdhci-esdhc-imx: clear tuning bits during driver probe

Doug Anderson (2):
      mmc: dw_mmc: Consider HLE errors to be data and command errors
      mmc: dw_mmc: Wait for data transfer after response errors.

Douglas Anderson (12):
      phy: rockchip-emmc: Increase lock time allowance
      mmc: sdhci-of-arasan: Always power the PHY off/on when clock changes
      Documentation: mmc: sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs
      mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399
      Documentation: mmc: sdhci-of-arasan: Add ability to export card clock
      mmc: sdhci-of-arasan: Add ability to export card clock
      Documentation: phy: Let the rockchip eMMC PHY get an exported card clock
      phy: rockchip-emmc: Minor code cleanup in rockchip_emmc_phy_power_on/off()
      phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
      mmc: sdhci-of-arasan: Revert: Always power the PHY off/on when
clock changes
      phy: rockchip-emmc: Be tolerant to card clock of 0 in power on
      phy: rockchip-emmc: Wait even longer for the DLL to lock

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for mmc device tree bindings

Georgi Djakov (2):
      mmc: sdhci-msm: Do not reset the controller if no card in the slot
      mmc: sdhci-msm: Add support for UHS cards

Gwendal Grignou (1):
      mmc: Set pref erase size based on size

Jaehoon Chung (6):
      mmc: host: use the defined function to check whether card is removable
      mmc: dw_mmc: exynos: fix the NULL pointer dereference error
      mmc: dw_mmc: remove the quirks flags
      mmc: dw_mmc: add the card write threshold for HS400 mode
      mmc: dw_mmc: set to MMC_CAP_ERASE by default
      mmc: dw_mmc: rockchip: unset the MMC_CAP_ERASE flag

Jon Hunter (2):
      mmc: sdhci: Request regulators before reading capabilities
      mmc: tegra: Only advertise UHS modes if IO regulator is present

Jérôme Forissier (1):
      mmc: dw_mmc: k3: add MMC_CAP_CMD23

Krzysztof Kozlowski (1):
      mmc: s3cmci: Register cpufreq notifier only on S3C24xx

Ludovic Desroches (1):
      mmc: sdhci: fix wakeup configuration

Peter Griffin (1):
      mmc: core: Only change mode if mmc_select_bus_width() is successful

Pratibhasagar V (1):
      mmc: core: Disable HPI for certain Hynix eMMC cards

Ritesh Harjani (1):
      mmc: sdhci-msm: Add set_uhs_signaling() implementation

Seung-Woo Kim (1):
      mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()

Shawn Lin (13):
      Documentation: mmc: add mmc-hs400-enhanced-strobe
      mmc: core: add mmc-hs400-enhanced-strobe support
      mmc: core: implement enhanced strobe support
      mmc: debugfs: add HS400 enhanced strobe description
      mmc: sdhci-of-arasan: implement enhanced strobe callback
      phy: rockchip-emmc: give DLL some extra time to be ready
      phy: rockchip-emmc: configure frequency range and drive impedance
      mmc: dw_mmc: remove redundant of set_bit and clear_bit
      mmc: dw_mmc: check card present before starting request
      mmc: dw_mmc: fix unmap sg twice when finding data err
      mmc: core: Allow hosts to specify non-support for MMC commands
      Documentation: mmc: add description for new no-sd* and no-mmc
      mmc: core: expose MMC_CAP2_NO_* to dt

Simon Horman (1):
      mmc: sdhci: remove comment regarding timeout during tuning

Stefan Wahren (4):
      DT: bindings: remove bcm2835-sdhci
      mmc: sdhci-bcm2835: remove driver
      mmc: sdhci: add define for suspend/resume capability
      mmc: sdhci-iproc: Use defines instead of magic numbers

Ulf Hansson (18):
      mmc: core: Allow hosts to specify non-support for SD commands
      mmc: sh_mmcif: Enable MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO
      mmc: sh_mmcif: Use response type to know when to enable busy detection
      mmc: sh_mmcif: Inform the mmc core about the max busy timeout
      mmc: sh_mmcif: Use a 10s timeout in the error recovery path
      mmc: sdhci-pci-core: Simplify code by using SET_SYSTEM_SLEEP_PM_OPS
      mmc: sdhci-acpi: Simplify code by using SET_SYSTEM_SLEEP_PM_OPS
      mmc: sdhci-of-esdhc: Simplify code by using SIMPLE_DEV_PM_OPS
      mmc: sdhci-pxav3: Remove non needed #ifdef CONFIG_PM for dev_pm_ops
      mmc: sdhci-s3c: Remove non needed #ifdef CONFIG_PM for dev_pm_ops
      mmc: sdhci-sirf: Remove non needed #ifdef CONFIG_PM* for dev_pm_ops
      mmc: sdhci-esdhc-imx: Assign system PM ops within #ifdef CONFIG_PM_SLEEP
      mmc: sdhci-esdhc-imx: Use common sdhci_suspend|resume_host()
      mmc: sdhci-pltfm: Make sdhci_pltfm_suspend|resume() static
      mmc: sdhci-pltfm: Convert to use the SET_SYSTEM_SLEEP_PM_OPS
      mmc: sdhci-pltfm: Drop define for SDHCI_PLTFM_PMOPS
      mmc: rtsx_pci: Use the provided busy timeout from the mmc core
      mmc: rtsx_pci: Enable MMC_CAP_ERASE to allow erase/discard/trim requests

Wolfram Sang (2):
      mmc: sh_mobile_sdhi: properly document R-Car versions
      mmc: tmio: make a cast explicit

Yuan, Juntao (1):
      mmc: block: correct 4KB alignment check

Ziyuan Xu (1):
      mmc: mmc: Fix HS switch failure in mmc_select_hs400()

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  35 +-
 .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |  18 -
 .../devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt |  36 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   2 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |   4 +
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   9 +
 Documentation/mmc/mmc-dev-attrs.txt                |   2 +
 MAINTAINERS                                        |   8 +
 drivers/mmc/card/block.c                           |  13 +-
 drivers/mmc/core/bus.c                             |   3 +-
 drivers/mmc/core/core.c                            |  95 ++-
 drivers/mmc/core/debugfs.c                         |   3 +-
 drivers/mmc/core/host.c                            |   8 +
 drivers/mmc/core/mmc.c                             | 253 ++++---
 drivers/mmc/core/mmc_ops.c                         |  27 +-
 drivers/mmc/core/quirks.c                          |   2 +
 drivers/mmc/core/sd.c                              |  19 +
 drivers/mmc/host/Kconfig                           |  22 +-
 drivers/mmc/host/Makefile                          |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   2 +-
 drivers/mmc/host/dw_mmc-k3.c                       |   7 +
 drivers/mmc/host/dw_mmc-rockchip.c                 |  11 +-
 drivers/mmc/host/dw_mmc.c                          | 126 ++--
 drivers/mmc/host/dw_mmc.h                          |  10 +-
 drivers/mmc/host/mtk-sd.c                          |  70 +-
 drivers/mmc/host/mxcmmc.c                          |   2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  16 +-
 drivers/mmc/host/s3cmci.c                          |   2 +-
 drivers/mmc/host/s3cmci.h                          |   2 +-
 drivers/mmc/host/sdhci-acpi.c                      |   8 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |   8 +-
 drivers/mmc/host/sdhci-bcm2835.c                   | 204 ------
 drivers/mmc/host/sdhci-brcmstb.c                   | 143 ++++
 drivers/mmc/host/sdhci-cns3xxx.c                   |   2 +-
 drivers/mmc/host/sdhci-dove.c                      |   2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 153 +++--
 drivers/mmc/host/sdhci-iproc.c                     |  15 +-
 drivers/mmc/host/sdhci-msm.c                       | 117 +++-
 drivers/mmc/host/sdhci-of-arasan.c                 | 332 ++++++++-
 drivers/mmc/host/sdhci-of-at91.c                   |   2 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  16 +-
 drivers/mmc/host/sdhci-of-hlwd.c                   |   2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  83 +--
 drivers/mmc/host/sdhci-pci.h                       |   2 +-
 drivers/mmc/host/sdhci-pltfm.c                     |  13 +-
 drivers/mmc/host/sdhci-pltfm.h                     |   7 -
 drivers/mmc/host/sdhci-pxav2.c                     |   2 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   9 +-
 drivers/mmc/host/sdhci-s3c.c                       |   9 +-
 drivers/mmc/host/sdhci-sirf.c                      |   4 +-
 drivers/mmc/host/sdhci-st.c                        |   2 +-
 drivers/mmc/host/sdhci-tegra.c                     |  51 +-
 drivers/mmc/host/sdhci.c                           | 745 ++++++++++++++-------
 drivers/mmc/host/sdhci.h                           |  30 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |   2 +-
 drivers/mmc/host/sh_mmcif.c                        |  53 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  |  14 +-
 drivers/mmc/host/tmio_mmc.h                        |   2 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |   2 +-
 drivers/phy/phy-rockchip-emmc.c                    | 241 +++++--
 include/linux/mmc/card.h                           |  36 +-
 include/linux/mmc/dw_mmc.h                         |   9 -
 include/linux/mmc/host.h                           |  14 +
 include/linux/mmc/mmc.h                            |   3 +
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 65 files changed, 2127 insertions(+), 1020 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
 delete mode 100644 drivers/mmc/host/sdhci-bcm2835.c
 create mode 100644 drivers/mmc/host/sdhci-brcmstb.c
