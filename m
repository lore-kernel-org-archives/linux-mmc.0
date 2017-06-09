From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/2] mmc: sdio: Keep card runtime resumed while adding function devices
Date: Fri,  9 Jun 2017 15:27:16 +0300
Message-ID: <1497011238-9573-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18608 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbdFIMdR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Jun 2017 08:33:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here is V2 of the patch to keep an SDIO card runtime resumed while adding
function devices.


Changes in V2:

	mmc: sdio: Tidy error path in mmc_attach_sdio()
		New patch

	mmc: sdio: Keep card runtime resumed while adding function devices
		Move call to pm_runtime_get_noresume() before
		pm_runtime_set_active().
		Do not use pm_runtime_put() incorrectly (or at all) in the
		error path.


Adrian Hunter (2):
      mmc: sdio: Tidy error path in mmc_attach_sdio()
      mmc: sdio: Keep card runtime resumed while adding function devices

 drivers/mmc/core/sdio.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)


Regards
Adrian
