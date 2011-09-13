From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V5 0/2] Poweroff Notify eMMC 4.5
Date: Tue, 13 Sep 2011 18:28:04 +0530
Message-ID: <1315918686-14375-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch version fixes the problem with power off
notify function, when called for the first time and
card is not yet initialised. 
Earlier version will generate a core dump, so a check 
for NULL is required in the power off function.

Girish K S (2):
  mmc: core: Add power off notify feature(eMMC 4.5)
  mmc: core: Add Poweroff Notify handling eMMC 4.5

 drivers/mmc/core/core.c  |   34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |   22 ++++++++++++++++++++--
 drivers/mmc/host/sdhci.c |   10 ++++++++++
 include/linux/mmc/card.h |   20 ++++++++++++++++++++
 include/linux/mmc/host.h |    5 +++++
 include/linux/mmc/mmc.h  |    7 +++++++
 6 files changed, 96 insertions(+), 2 deletions(-)
