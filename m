From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/1] mmc: start removing enable / disable API
Date: Wed, 29 Feb 2012 09:17:20 +0200
Message-ID: <1330499841-6879-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51768 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030774Ab2B2HRU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Feb 2012 02:17:20 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Hi

Most parts of the enable / disable API are no longer used and
can be removed.

V2: fix missing enable in mmc_try_claim_host as per Sujit Reddy Thumma


Adrian Hunter (1):
      mmc: start removing enable / disable API

 arch/arm/mach-exynos/mach-nuri.c           |    5 +-
 arch/arm/mach-exynos/mach-universal_c210.c |    9 +-
 drivers/mmc/core/core.c                    |  187 +++-------------------------
 drivers/mmc/core/host.c                    |    1 -
 drivers/mmc/core/host.h                    |    1 -
 drivers/mmc/host/davinci_mmc.c             |    4 -
 drivers/mmc/host/omap_hsmmc.c              |   15 +--
 include/linux/mmc/core.h                   |    1 -
 include/linux/mmc/host.h                   |   46 +------
 9 files changed, 27 insertions(+), 242 deletions(-)


Regards
Adrian
