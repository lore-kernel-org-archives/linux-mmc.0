From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 0/7] mmc: sdhci: set .remove to sdhci_pltfm_unregister()
Date: Fri,  6 Feb 2015 11:15:15 +0800
Message-ID: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:33506 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbBFDPf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Feb 2015 22:15:35 -0500
Received: by mail-yh0-f50.google.com with SMTP id a41so785924yho.9
        for <linux-mmc@vger.kernel.org>; Thu, 05 Feb 2015 19:15:35 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

In the current kernel, the specific .remove function in several sdhci platform
drivers seem pretty similar. Actually we can just set all of them to
sdhci_pltfm_unregister() with just a bit twist.

Only run test for sdhci-of-esdhc driver. All others just passed the build test.

Kevin Hao (7):
  mmc: sdhci-dove: remove the unneeded error check
  mmc: sdhci-dove: kill the driver specific private struct
  mmc: tegra: use devm help functions to get the clk and gpio
  mmc: sdhci-sirf: kill the "clk" member in driver private struct
  mmc: sdhci-bcm-kona: kill the "external_clk" member in driver private 
       struct
  mmc: sdhci: disable the clock in sdhci_pltfm_unregister()
  mmc: sdhci: set the .remove to sdhci_pltfm_unregister()

 drivers/mmc/host/sdhci-bcm-kona.c  | 31 +++++++-----------------------
 drivers/mmc/host/sdhci-bcm2835.c   |  7 +------
 drivers/mmc/host/sdhci-cns3xxx.c   |  7 +------
 drivers/mmc/host/sdhci-dove.c      | 39 +++++---------------------------------
 drivers/mmc/host/sdhci-of-arasan.c |  1 -
 drivers/mmc/host/sdhci-of-esdhc.c  |  7 +------
 drivers/mmc/host/sdhci-of-hlwd.c   |  7 +------
 drivers/mmc/host/sdhci-pltfm.c     |  2 ++
 drivers/mmc/host/sdhci-sirf.c      | 30 +++++++----------------------
 drivers/mmc/host/sdhci-st.c        | 12 +-----------
 drivers/mmc/host/sdhci-tegra.c     | 30 ++++-------------------------
 11 files changed, 30 insertions(+), 143 deletions(-)

-- 
1.9.3

