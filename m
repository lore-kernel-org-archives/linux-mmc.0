From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get them self registered
Date: Thu,  5 May 2011 21:22:51 +0800
Message-ID: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:51742 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab1EENRL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 09:17:11 -0400
Received: by pxi16 with SMTP id 16so1606601pxi.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 May 2011 06:17:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

Here are what the patch set does.

* Remove .probe and .remove hooks from sdhci-pltfm.c and make it be
  a pure common helper function providers.
* Add .probe and .remove hooks for sdhci pltfm drivers sdhci-cns3xxx,
  sdhci-dove, sdhci-tegra, and sdhci-esdhc-imx to make them self
  registered with calling helper functions created above.
* Migrate the use of sdhci_of_host and sdhci_of_data to
  sdhci_pltfm_host and sdhci_pltfm_data, so that OF version host and
  data structure works can be saved, and pltfm version works for both
  cases.
* Add OF common helper stuff into sdhci-pltfm.c, and make OF version
  sdhci drivers sdhci-of-esdhc and sdhci-of-hlwd become self
  registered as well, so that sdhci-of-core.c and sdhci-of.h can be
  removed.
* Consolidate the OF and pltfm esdhc drivers into one with sharing
  the same pair of .probe and .remove hooks.
* Eliminate include/linux/mmc/sdhci-pltfm.h with moving stuff into
  drivers/mmc/host/sdhci-pltfm.h.

And the benefits we gain from the changes are:

* Get the sdhci device driver follow the Linux trend that driver
  makes the registration by its own.
* sdhci-pltfm.c becomes simple and clean as it only has common helper
  stuff there now.
* All sdhci device specific things are going back its own driver.
* The dt and non-dt drivers are consolidated to use the same pair of
  .probe and .remove hooks.
* SDHCI driver for Freescale eSDHC controller found on both MPCxxx
  and i.MX platforms is consolidated to use the same one .probe
  function.

It was only tested on i.mx51 babbage board, all other targets were
build tested.  Tested-by, Reviwed-by, and Acked-by are much
appreciated.

I attempt to get patch #1 ~ #6 go through Chris' tree, while the #7
through Sascha's tree.

Regards,
Shawn

Changes since v1:
 * Rebase on cjb's mmc-next tree
 * Introduce helper function pair sdhci_pltfm_register and
   sdhci_pltfm_unregister
 * Eliminate variable 'scratch' in .remove hook to make the code
   look simple
 * Return ERR_PTR in sdhci_pltfm_init and use IS_ERR/PTR_ERR to check
   return value in .probe hooks
 * Correct MODULE_AUTHOR statement
 * Split esdhc conlidation patch to ease reviewing

Shawn Guo (7):
      mmc: sdhci: make sdhci-pltfm device drivers self registered
      mmc: sdhci: eliminate sdhci_of_host and sdhci_of_data
      mmc: sdhci: make sdhci-of device drivers self registered
      sdhci: rename sdhci-esdhc-imx.c to sdhci-esdhc.c
      mmc: sdhci: consolidate sdhci-of-esdhc and sdhci-esdhc-imx
      mmc: sdhci: merge two sdhci-pltfm.h into one
      ARM: mxc: remove esdhc.h and use the public one

 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    1 -
 arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
 drivers/mmc/host/Kconfig                           |   77 ++--
 drivers/mmc/host/Makefile                          |   17 +-
 drivers/mmc/host/sdhci-cns3xxx.c                   |   43 ++-
 drivers/mmc/host/sdhci-dove.c                      |   42 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  331 -----------
 drivers/mmc/host/sdhci-esdhc.c                     |  580 ++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc.h                     |   81 ---
 drivers/mmc/host/sdhci-of-core.c                   |  250 ---------
 drivers/mmc/host/sdhci-of-esdhc.c                  |   91 ---
 drivers/mmc/host/sdhci-of-hlwd.c                   |   66 ++-
 drivers/mmc/host/sdhci-of.h                        |   42 --
 drivers/mmc/host/sdhci-pltfm.c                     |  259 +++++----
 drivers/mmc/host/sdhci-pltfm.h                     |   39 ++-
 drivers/mmc/host/sdhci-tegra.c                     |  118 +++--
 include/linux/mmc/esdhc.h                          |   27 +
 include/linux/mmc/sdhci-pltfm.h                    |   35 --
 18 files changed, 1048 insertions(+), 1053 deletions(-)
