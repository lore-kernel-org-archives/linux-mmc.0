From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 0/4] fix some incorrect timeout clock getting from sdhci variant drivers
Date: Fri, 17 Feb 2017 11:56:16 +0800
Message-ID: <1487303780-234812-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:53942 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754742AbdBQD7J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 22:59:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Shawn Lin <shawn.lin@rock-chips.com>


This was found by Anssi Hannula that the the timeout clock actually
should be in KHz from the .get_timeout_clock callback. So patch 4
is a slighlt improvement based on Anssi's patch[1]. More investigation
shows that sdhci-bcm-kona also did it in the wrong way. So I decide to
invent a new helper function, sdhci_pltfm_clk_get_timeout_clock,to be
better reused.

Please review and comment.

[1]: https://patchwork.kernel.org/patch/9569431/


Anssi Hannula (1):
  mmc: sdhci-of-arasan: fix incorrect timeout clock

Shawn Lin (3):
  mmc: sdhci: add comment for get_timeout_clock callback
  mmc: sdhci: add new helper to get timeout clock
  mmc: sdhci-bcm-kona: reuse sdhci_pltfm_clk_get_timeout_clock

 drivers/mmc/host/sdhci-bcm-kona.c  |  2 +-
 drivers/mmc/host/sdhci-of-arasan.c | 23 +----------------------
 drivers/mmc/host/sdhci-pltfm.c     | 14 ++++++++++++++
 drivers/mmc/host/sdhci-pltfm.h     |  1 +
 drivers/mmc/host/sdhci.h           |  1 +
 5 files changed, 18 insertions(+), 23 deletions(-)

-- 
1.9.1


