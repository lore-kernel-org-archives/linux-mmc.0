From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/3] mmc: sdhci-acpi: Fix Braswell eMMC timeout clock frequency
Date: Mon,  6 Oct 2014 15:23:04 +0300
Message-ID: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60429 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbaJFMY4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Oct 2014 08:24:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are 3 patches that fix Fix Braswell eMMC timeout clock
frequency.  A fix has already been done for sdhci-pci, so
please consider these for 3.18 also.


Adrian Hunter (3):
      mmc: sdhci-acpi: Get UID directly from acpi_device
      mmc: sdhci-acpi: Pass HID and UID to probe_slot
      mmc: sdhci-acpi: Fix Braswell eMMC timeout clock frequency

 drivers/mmc/host/sdhci-acpi.c | 44 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)


Regards
Adrian
