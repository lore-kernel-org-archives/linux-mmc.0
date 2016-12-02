From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/1] mmc: mmc: Relax checking for switch errors after HS200 switch
Date: Fri,  2 Dec 2016 13:16:34 +0200
Message-ID: <1480677395-14169-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7518 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758734AbcLBLVi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Dec 2016 06:21:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

Hi

Here is V2 of a patch for an issue we discussed briefly here:

	https://marc.info/?l=linux-mmc&m=147937852408104
	
and here:

	https://marc.info/?l=linux-mmc&m=148060118031658

Changes in V2:
	Add __mmc_switch_status() to use a parameter bool crc_err_fatal


Adrian Hunter (1):
      mmc: mmc: Relax checking for switch errors after HS200 switch

 drivers/mmc/core/mmc.c     | 15 +++++++++++++--
 drivers/mmc/core/mmc_ops.c |  9 ++++++++-
 drivers/mmc/core/mmc_ops.h |  1 +
 3 files changed, 22 insertions(+), 3 deletions(-)


Regards
Adrian
