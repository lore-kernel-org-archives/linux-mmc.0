From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for mmc-next for 3.16, take 3
Date: Thu, 22 May 2014 12:49:11 +0200
Message-ID: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:45939 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaEVKtM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 06:49:12 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so5239173qge.26
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2014 03:49:11 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Markus Pargmann <mpa@pengutronix.de>

Hi Chris,

Here are a third and final collection of patches for 3.16.

I have as you and I discussed (off list), collected the patches from
Russell's sdhci patchset. I needed to resolve some conflicts while
applying them, but it was manageable. I also omitted the patch which
was reported to caused problem with eMMC, (mmc: sdhci: hack up driver
to make it more compliant with UHS-1).

Unless you have some additional review comments, please pull them into
your mmc-next branch to get some more testing in linux-next.

Kind regards
Uffe


The following changes since commit 197160d52e859575ff0ad1afd674ab2a825b=
9f83:

  mmc: sdhci: remove mdelay in eMMC tuning (2014-05-13 21:21:10 -0400)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git mmc-next_for_chris_3.=
16_take3

for you to fetch changes up to c47a823d0ee8097c08047bbc13728c9429a99e91=
:

  MAINTAINERS: mmc: Add path to git tree (2014-05-22 12:41:16 +0200)

----------------------------------------------------------------
Aisheng Dong (1):
      mmc: sdhci-esdhc-imx: fix mmc ddr mode regression issue

Al Cooper (1):
      mmc: sdhci: SD tuning is broken for some controllers

Andreas Fenkart (6):
      mmc: omap_hsmmc: Enable SDIO interrupt
      mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
      mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime sta=
te
      mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detect=
ed
      mmc: omap_hsmmc: switch default/idle pinctrl states in runtime ho=
oks
      mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt o=
n AM335x

Axel Lin (2):
      mmc: omap: Use DIV_ROUND_UP instead of open coded
      mmc: wmt-sdmmc: Use GFP_KERNEL instead of hard-coded value

Balaji T K (7):
      mmc: omap_hsmmc: use devm_clk_get
      mmc: omap_hsmmc: use devm_request_irq
      mmc: omap_hsmmc: use devm_request_threaded_irq
      mmc: omap_hsmmc: use devm_ioremap_resource
      mmc: omap_hsmmc: fix cmd23 multiblock read/write
      mmc: omap_hsmmc: split omap-dma header file
      mmc: omap_hsmmc: use IS_ERR macro for error checking

David Lanzend=C3=B6rfer (1):
      ARM: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi =
SoCs

Doug Anderson (1):
      mmc: dw_mmc: Don't print data errors

Peter Guo (1):
      mmc: sdhci-pci-o2micro: Add SeaBird SeaEagle SD3 support

Russell King (31):
      mmc: sdio_irq: rework sdio irq handling
      mmc: sdhci: clean up interrupt handling
      mmc: sdhci: clean up sdio interrupt enable handling
      mmc: sdhci: convert to new SDIO IRQ handling
      mmc: sdhci: push card_tasklet into threaded irq handler
      mmc: sdhci: allow sdio interrupts while sdhci runtime suspended
      mmc: sdhci: more efficient interrupt enable register handling
      mmc: sdhci: plug hole in disabling card detection interrupts
      mmc: sdhci: convert generic bus width setup to library function
      mmc: sdhci: convert reset into a library function
      mmc: sdhci: move FSL ESDHC reset handling quirk into esdhc code
      mmc: sdhci: avoid sync'ing the SG if there's no misalignment
      mmc: sdhci: convert ADMA descriptors to a coherent allocation
      mmc: sdhci: clean up sdhci_update_clock()/sdhci_set_clock()
      mmc: sdhci: move setting host->clock into sdhci_do_set_ios()
      mmc: sdhci: move setting mmc->actual_clock into set_clock handler=
s
      mmc: sdhci: convert sdhci_set_clock() into a library function
      mmc: sdhci-esdhc-imx: avoid DMA to kernel stack
      mmc: sdhci-esdhc-imx: comment runtime_pm_get_sync() in
esdhc_prepare_tuning()
      mmc: sdhci-esdhc-imx: fix lockdep splat upon tuning
      mmc: sdhci: set_uhs_signaling() need not return a value
      mmc: sdhci: convert sdhci_set_uhs_signaling() into a library func=
tion
      mmc: sdhci: cache timing information locally
      mmc: sdhci: clean up sdhci_execute_tuning() decision
      mmc: sdhci-esdhc-imx: remove emulation of uhs_mode
      mmc: sdhci-of-esdhc: remove platform_suspend/platform_resume call=
backs
      mmc: sdhci: remove platform_suspend/platform_resume callbacks
      mmc: sdhci-tegra: get rid of special PRESENT_STATE register handl=
ing
      mmc: sdhci: move regulator handling into sdhci_set_power()
      mmc: sdhci: move remaining power handling into sdhci_set_power()
      mmc: sdhci: track whether preset mode is currently enabled in har=
dware

Sebastian Hesselbarth (1):
      mmc: dove: fix missing MACH_DOVE dependency

Ulf Hansson (1):
      MAINTAINERS: mmc: Add path to git tree

=2E../devicetree/bindings/mmc/sunxi-mmc.txt          |   43 +
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   54 +
 MAINTAINERS                                        |    1 +
 drivers/mmc/core/sdio_irq.c                        |   41 +-
 drivers/mmc/host/Kconfig                           |    9 +-
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc.c                          |    2 +-
 drivers/mmc/host/omap.c                            |   10 +-
 drivers/mmc/host/omap_hsmmc.c                      |  351 +++++--
 drivers/mmc/host/sdhci-acpi.c                      |    8 +
 drivers/mmc/host/sdhci-bcm-kona.c                  |    4 +
 drivers/mmc/host/sdhci-bcm2835.c                   |    4 +
 drivers/mmc/host/sdhci-cns3xxx.c                   |   13 +-
 drivers/mmc/host/sdhci-dove.c                      |    4 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   83 +-
 drivers/mmc/host/sdhci-esdhc.h                     |    4 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |    4 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |   70 +-
 drivers/mmc/host/sdhci-of-hlwd.c                   |    4 +
 drivers/mmc/host/sdhci-pci-o2micro.c               |   78 +-
 drivers/mmc/host/sdhci-pci-o2micro.h               |    3 +
 drivers/mmc/host/sdhci-pci.c                       |    9 +-
 drivers/mmc/host/sdhci-pltfm.c                     |    4 +
 drivers/mmc/host/sdhci-pxav2.c                     |   14 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   13 +-
 drivers/mmc/host/sdhci-s3c.c                       |   36 +-
 drivers/mmc/host/sdhci-sirf.c                      |    4 +
 drivers/mmc/host/sdhci-spear.c                     |    5 +-
 drivers/mmc/host/sdhci-tegra.c                     |   27 +-
 drivers/mmc/host/sdhci.c                           |  744 +++++++-----=
--
 drivers/mmc/host/sdhci.h                           |   20 +-
 drivers/mmc/host/sunxi-mmc.c                       | 1049 ++++++++++++=
++++++++
 drivers/mmc/host/wmt-sdmmc.c                       |    2 +-
 include/linux/mmc/host.h                           |    3 +
 include/linux/mmc/sdhci.h                          |   15 +-
 include/linux/omap-dma.h                           |   19 +-
 include/linux/omap-dmaengine.h                     |   21 +
 include/linux/platform_data/mmc-omap.h             |    1 +
 38 files changed, 2154 insertions(+), 623 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
 create mode 100644 drivers/mmc/host/sunxi-mmc.c
 create mode 100644 include/linux/omap-dmaengine.h
