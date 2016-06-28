From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 0/5] mmc: sdhci: Make signal voltage support explicit
Date: Tue, 28 Jun 2016 16:23:07 +0300
Message-ID: <1467120192-6479-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52439 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbcF1Na1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2016 09:30:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Dong Aisheng <dongas86@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>

Hi

Here are some patches to make it easier for drivers to set capabilities
particularly with respect to signal voltage support.  Not tested thoroughly
yet so RFC for now.


Adrian Hunter (5):
      mmc: sdhci: Do not call implementations of mmc host ops directly
      mmc: sdhci: Split sdhci_add_host()
      mmc: sdhci: Make signal voltage support explicit
      mmc: sdhci: Tidy caps variables in sdhci_setup_host()
      mmc: sdhci: Add sdhci_read_caps()

 drivers/mmc/host/sdhci.c | 203 ++++++++++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h |  17 +++-
 2 files changed, 152 insertions(+), 68 deletions(-)


Regards
Adrian
