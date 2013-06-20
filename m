From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/1] mmc: sdhci-pci: add another device id
Date: Thu, 20 Jun 2013 12:57:58 +0300
Message-ID: <1371722279-16975-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48265 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab3FTJwS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Jun 2013 05:52:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here is a patch to add another PCI device id for
an eMMC host controller.  It is dependent on:

	mmc: sdhci-acpi: add support for eMMC hardware reset for HID 80860F14
	mmc: sdhci-pci: add support for eMMC hardware reset for BYT eMMC.

which were sent on 13 June.

Please queue all 3 for linux 3.11.


Adrian Hunter (1):
      mmc: sdhci-pci: add another device id

 drivers/mmc/host/sdhci-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)


Regards
Adrian
