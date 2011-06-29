From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: sdhci-pci: add 8-bit bus width support for Medfield eMMCs
Date: Wed, 29 Jun 2011 14:23:45 +0300
Message-ID: <1309346627-32630-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64578 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab1F2LX6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2011 07:23:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Just setting some MMC_CAP_8_BIT_DATA bits.


Adrian Hunter (1):
      mmc: sdhci-pci: allow 8-bit bus width for Intel Medfield eMMCs

Major Lee (1):
      mmc: sdhci-pci: add 8-bit bus width support for mrst hc0

 drivers/mmc/host/sdhci-pci.c |   54 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 49 insertions(+), 5 deletions(-)

Regards
Adrian Hunter
