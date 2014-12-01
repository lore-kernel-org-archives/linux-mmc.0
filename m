From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/3] mmc: sdhci: Disable re-tuning for HS400
Date: Mon,  1 Dec 2014 15:16:03 +0200
Message-ID: <1417439766-5063-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61477 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbaLANTt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Dec 2014 08:19:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

As described in patch 3, re-tuning for HS400 has to be done
in HS200 mode, but there is no support for that, so re-tuning
needs to be disabled until support is added. I have some patches
for that which I will send in the next day or two.


Adrian Hunter (3):
      mmc: sdhci: Tuning should not change max_blk_count
      mmc: sdhci: Add out_unlock to sdhci_execute_tuning
      mmc: sdhci: Disable re-tuning for HS400


Regards
Adrian
