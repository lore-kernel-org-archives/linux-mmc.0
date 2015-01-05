From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: Add support for Intel SPT
Date: Mon,  5 Jan 2015 14:47:56 +0200
Message-ID: <1420462078-28868-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11016 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbbAEMto (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Jan 2015 07:49:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are a couple of patches to add some IDs.

Please queue them as fixes.


Adrian Hunter (2):
      mmc: sdhci-acpi: Add ACPI HID INT344D
      mmc: sdhci-pci: Add support for Intel SPT

 drivers/mmc/host/sdhci-acpi.c |  2 ++
 drivers/mmc/host/sdhci-pci.c  | 25 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h  |  3 +++
 3 files changed, 30 insertions(+)


Regards
Adrian
