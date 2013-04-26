From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/3] mmc: add more device ids
Date: Fri, 26 Apr 2013 11:27:20 +0300
Message-ID: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23525 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758891Ab3DZIXF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Apr 2013 04:23:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here is a minor fix and some more device ids for sdhci-acpi and sdhci-pci.

Please queue for 3.10 if possible.

Adrian Hunter (3):
      mmc: sdhci-acpi: fix initial runtime pm status
      mmc: sdhci-acpi: add more device ids
      mmc: sdhci-pci: add more device ids

 drivers/mmc/host/sdhci-acpi.c | 69 +++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci-pci.c  | 54 +++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 9 deletions(-)

Regards
Adrian

