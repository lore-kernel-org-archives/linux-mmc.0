From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 0/2] Add phy support for arasan,sdhci-5.1
Date: Mon, 15 Feb 2016 17:41:28 +0800
Message-ID: <1455529288-7454-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:34718 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcBOJqA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2016 04:46:00 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


Hello Ulf and Adrian,

Sorry for delay the new version for this topic. Actually I have no
platform available to test phy stuff since v4. Now, I can rework it.:)
I remove rpm support from v5 because this patchset just need to focus
on phy stuff, which will make the changes more precise. Another reason
is that phy_power_on take too much time from rpm, however the power profit
gained from phy_power_off is little due to the low power mechanism with the
phy itself observed from experiments.

v4 can be found here:
https://patchwork.kernel.org/patch/7463251/

Note:
Phy is mandatory requirement for arasan,sdhci-5.1, so we introduce
generic phy support for sdhci-of-arasan.


Shawn Lin (2):
  Documentation: bindings: add description of phy for sdhci-of-arasan
  mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan

 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 20 ++++++-
 drivers/mmc/host/sdhci-of-arasan.c                 | 66 ++++++++++++++++++++--
 2 files changed, 80 insertions(+), 6 deletions(-)

-- 
2.3.7


