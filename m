From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 0/7] mmc: sdhci: set .remove to sdhci_pltfm_unregister()
Date: Fri, 27 Feb 2015 15:47:24 +0800
Message-ID: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:45700 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbB0Hrx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 02:47:53 -0500
Received: by yhai57 with SMTP id i57so7212757yha.12
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 23:47:52 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

v2:
  - Update the sdhci-bcm-kona as suggested by Ray Jui.
  - Also kill the private get_max_clock function in sdhci-sirf.

v1:
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

 drivers/mmc/host/sdhci-bcm-kona.c  | 61 ++++++++------------------------------
 drivers/mmc/host/sdhci-bcm2835.c   |  7 +----
 drivers/mmc/host/sdhci-cns3xxx.c   |  7 +----
 drivers/mmc/host/sdhci-dove.c      | 39 ++++--------------------
 drivers/mmc/host/sdhci-of-arasan.c |  1 -
 drivers/mmc/host/sdhci-of-esdhc.c  |  7 +----
 drivers/mmc/host/sdhci-of-hlwd.c   |  7 +----
 drivers/mmc/host/sdhci-pltfm.c     |  2 ++
 drivers/mmc/host/sdhci-sirf.c      | 36 +++++-----------------
 drivers/mmc/host/sdhci-st.c        | 12 +-------
 drivers/mmc/host/sdhci-tegra.c     | 30 +++----------------
 11 files changed, 36 insertions(+), 173 deletions(-)

-- 
1.9.3

