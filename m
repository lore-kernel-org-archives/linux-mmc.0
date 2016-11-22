From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: sdhci-pci: Add GLK support and misc
Date: Tue, 22 Nov 2016 11:03:36 +0200
Message-ID: <1479805418-19603-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39949 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932305AbcKVJJD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Nov 2016 04:09:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>

Hi

Here are a couple of small patches.


Adrian Hunter (1):
  mmc: sdhci-pci: Add support for Intel GLK

David E. Box (1):
  mmc: sdhci-pci: Allow deferred probe for sd card detect gpio

 drivers/mmc/host/sdhci-pci-core.c | 42 +++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 2 files changed, 39 insertions(+), 6 deletions(-)


Regards
Adrian
