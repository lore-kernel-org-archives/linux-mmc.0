From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 0/3] mmc: sdhci: Set DMA mask properly
Date: Fri, 4 Mar 2016 19:38:42 +0900
Message-ID: <1457087925-992-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4232 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbcCDKjp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 05:39:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

Well that's far from the two-liner I had in mind to fix our bounce-buffers
problem with Tegra, but it feels correct. Testing for ACPI and PCI would be
appreciated (I am rather confident that ACPI will be ok, but the PCI part
should be reviewed by someone who knows better).

64-bit capable devices are supposed to set their own DMA mask. Currently
this does not happen for sdhci devices excepted for the two (sdhci-acpi
and sdhci-pci) that define a enable_dma() hook and do it there. However
this hook is called from several places while DMA mask is supposed to
be set only once ; for instance the sdhci-acpi driver maintains a flag
just to make sure the DMA mask is set only upon the first call of this
hook.

For the vast majority of drivers that do not define a enable_dma() hook, the
default 32-bit DMA mask is used and there is a risk of using unneeded bounce
buffers on hosts capable of 64-bit addressing.

The first patch adds a default DMA mask setting function that is called when
a DMA-capable host is added. It tries to set sane DMA masks according to the
device's reported capabilities.

The addition of this function seems to make the same code in sdhci-acpi and
sdhci-pci redundant, so it is removed from these drivers. On top of making
this series a negative line count, it also removes one usage of the obsolete
pci_set_dma_mask() function.

Thanks to Arnd for the insightful discussion that led to this.

Changes since v2:
- Generalize the solution to all sdhci drivers instead of just Tegra
- Remove supposedly-redundant code from the sdhci-acpi and sdhci-pci drivers

Alexandre Courbot (3):
  mmc: sdhci: Set DMA mask when adding host
  mmc: sdhci-acpi: Remove enable_dma() hook
  mmc: sdhci-pci: Do not set DMA mask in enable_dma()

 drivers/mmc/host/sdhci-acpi.c     | 30 -------------------------
 drivers/mmc/host/sdhci-pci-core.c | 15 -------------
 drivers/mmc/host/sdhci.c          | 46 +++++++++++++++++++++++++++++++++------
 3 files changed, 39 insertions(+), 52 deletions(-)

-- 
2.7.2

