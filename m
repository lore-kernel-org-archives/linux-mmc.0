From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/1] mmc: mmc: Relax checking for switch errors after HS200 switch
Date: Thu, 24 Nov 2016 14:02:48 +0200
Message-ID: <1479988969-1747-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:53950 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933453AbcKXMLA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 24 Nov 2016 07:11:00 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

Hi

Here is a patch for an issue we discussed briefly here:

	https://marc.info/?l=linux-mmc&m=147937852408104


Adrian Hunter (1):
  mmc: mmc: Relax checking for switch errors after HS200 switch

 drivers/mmc/core/mmc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


Regards
Adrian
