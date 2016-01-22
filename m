From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/3] mmc: sdhci: Fix card detect race for Intel BXT/APL
Date: Fri, 22 Jan 2016 11:44:59 +0200
Message-ID: <1453455902-3987-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60849 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbcAVJsq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jan 2016 04:48:46 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Lakshmi Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Russell King <linux@arm.linux.org.uk>

Hi

Here are 3 little patches to fix a problem on Intel BXT/APL.
The PCI and ACPI Ids for BXT/APL were added in v4.4 so the
patches are cc stable v4.4+.

AFAICT the patches do not conflict with other SDHCI patches
on the mailing list at the moment.


Adrian Hunter (3):
      mmc: sdhci: Add get_cd sdhci host operation
      mmc: sdhci-pci: Fix card detect race for Intel BXT/APL
      mmc: sdhci-acpi: Fix card detect race for Intel BXT/APL

 drivers/mmc/host/sdhci-acpi.c     | 35 ++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci-core.c | 27 +++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |  6 +++++-
 drivers/mmc/host/sdhci.h          |  1 +
 4 files changed, 67 insertions(+), 2 deletions(-)


Regards
Adrian
