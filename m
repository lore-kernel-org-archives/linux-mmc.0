From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/1] mmc: core: Further fix thread wake-up
Date: Mon, 19 Dec 2016 15:57:33 +0200
Message-ID: <1482155854-24963-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30014 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754015AbcLSOCl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Dec 2016 09:02:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>

Hi

Here is the fix for the hang that Ritesh was seeing while testing
the Software Command Queue patches.


Adrian Hunter (1):
      mmc: core: Further fix thread wake-up

 drivers/mmc/core/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)


Regards
Adrian
