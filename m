From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V6 RESEND 0/2] Poweroff Notify eMMC 4.5
Date: Fri, 16 Sep 2011 19:09:35 +0530
Message-ID: <1316180377-30969-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch version removes some checkpatch error.
Earlier versions were checked with the older checkpatch.pl
which didnt give any checkpatch errors. This patch uses
the checkpatch.pl in the latest script folder.

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
