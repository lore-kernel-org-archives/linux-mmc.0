From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: mmc_test: Ensure command queue is disabled for testing
Date: Fri,  1 Dec 2017 14:55:29 +0200
Message-ID: <1512132931-12380-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:2863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbdLAMzw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 1 Dec 2017 07:55:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are a couple of fixes related to mmc_test.


Adrian Hunter (2):
      mmc: core: Ensure cmd_completion is initialized
      mmc: mmc_test: Ensure command queue is disabled for testing

 drivers/mmc/core/core.c     |  6 ++----
 drivers/mmc/core/mmc_test.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)


Regards
Adrian
