From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: mmc: Improve reliability of HS200/HS400 selection
Date: Wed, 28 Oct 2015 14:25:39 +0200
Message-ID: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57266 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178AbbJ1M3L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Oct 2015 08:29:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

Hi

Here are some patches that improve the reliability of selecting
eMMC HS200 or HS400 mode.

Generally the improvement is to match the host controller timing
setting with the card mode before sending commands.


Adrian Hunter (4):
      mmc: mmc: Improve reliability of mmc_select_hs200()
      mmc: mmc: Fix HS setting in mmc_select_hs400()
      mmc: mmc: Move mmc_switch_status()
      mmc: mmc: Improve reliability of mmc_select_hs400()

 drivers/mmc/core/mmc.c | 93 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 24 deletions(-)


Regards
Adrian
