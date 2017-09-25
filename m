From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V1 0/2] mmc: sd: Fix signal voltage when there is no power cycle
Date: Mon, 25 Sep 2017 11:29:02 +0300
Message-ID: <1506328144-13666-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:29782 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932364AbdIYIfs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Sep 2017 04:35:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Zhoujie Wu <zjwu@marvell.com>

Hi

Here is V1 of "mmc: sd: Fix signal voltage when there is no power cycle"


Changes since RFC:
      mmc: core: Factor out mmc_host_set_uhs_voltage()
	New patch
      mmc: sd: Fix signal voltage when there is no power cycle
	Now based on "Factor out mmc_host_set_uhs_voltage()" patch
	Added explanation to commit message


Adrian Hunter (2):
      mmc: core: Factor out mmc_host_set_uhs_voltage()
      mmc: sd: Fix signal voltage when there is no power cycle

 drivers/mmc/core/core.c | 38 ++++++++++++++++++++++++--------------
 drivers/mmc/core/core.h |  1 +
 drivers/mmc/core/sd.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 16 deletions(-)


Regards
Adrian
