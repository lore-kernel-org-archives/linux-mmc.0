From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/4] mmc: sdhci: Disable re-tuning for HS400
Date: Fri,  5 Dec 2014 19:25:27 +0200
Message-ID: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49598 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbaLER1K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:27:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hi

Here is V2 of patches to disable re-tuning for HS400.

As described in patch 4, re-tuning for HS400 has to be done
in HS200 mode, but there is no support for that, so re-tuning
needs to be disabled until support is added.

Changes in V2:

	Added "mmc: sdhci: Simplify use of tuning timer"
	patch.

	Changed "mmc: sdhci: Disable re-tuning for HS400"
	so that the tuning timer is not started instead
	of stopping it when HS400 mode is selected.


Adrian Hunter (4):
      mmc: sdhci: Tuning should not change max_blk_count
      mmc: sdhci: Add out_unlock to sdhci_execute_tuning
      mmc: sdhci: Simplify use of tuning timer
      mmc: sdhci: Disable re-tuning for HS400

 drivers/mmc/host/sdhci.c  | 66 ++++++++++++++++++++++++++++++-----------------
 include/linux/mmc/sdhci.h |  1 +
 2 files changed, 43 insertions(+), 24 deletions(-)


Regards
Adrian
