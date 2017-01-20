From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] dw-mmc controller fixes
Date: Fri, 20 Jan 2017 17:26:22 +0900
Message-ID: <4082c88e-de72-9e18-7b9a-c37551bda610@samsung.com>
References: <CGME20170120082622epcas5p2e3db3b067b3a1cce2e30f074175cb469@epcas5p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52646 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdATIh0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 03:37:26 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OK201NTFKRZGN80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 Jan 2017 17:26:23 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>

Dear Ulf,

Could you pull this patch on your fixes branch?

The following changes since commit ee6ff743e3a4b697e8286054667d7e4e1b56510d:

  mmc: core: Restore parts of the polling policy when switch to HS/HS DDR (2017-01-16 16:17:42 +0100)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git fixes

for you to fetch changes up to c9ea1acefff02aeb080b427d79cedeb446b28317:

  mmc: dw_mmc: force setup bus if active slots exist (2017-01-20 17:17:43 +0900)

----------------------------------------------------------------
Ziyuan Xu (1):
      mmc: dw_mmc: force setup bus if active slots exist

 drivers/mmc/host/dw_mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
