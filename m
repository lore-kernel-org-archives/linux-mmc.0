From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V7 0/2] HS200 Mode support for device and host
Date: Wed, 21 Dec 2011 09:42:57 +0530
Message-ID: <1324440779-27843-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

changes in v7:
	Updated with review comments for minor changes in host conditional
	handling. added the handling for 4 bit bus width. 
Changes in v6:
       split the patch into 2 and classified them as a patch for device
       and host. Modified to include the review comments.
Changes in v5:
       Reduced the case statements for better code readability. Removed
       unused macro definitions. Modified the tuning function prototype
       and definition to support tuning for both SD and eMMC cards.
Changes in v4:
       Rebased onto chris-mmc/mmc-next branch. This patch is successfully
       applied on commit with id de022ed3fdc14808299b2fa66dbb1ed5ab921912.
Changes in v3:
       In the previous commits of chris-mmc/mmc-next branch, the patch with
       commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) defines caps2 for
       more capabilities. This patch version deletes the member ext_caps(created
       in my earlier patch) from struct mmc_host and reuses already accepted
       caps2 member.
Changes in v2:
       Rebased to latest chris-mmc/mmc-next branch. Resolved indentation
       problems identified in review. This patch has to be applied before
       the patch released for modifying the printk messages.
Changes in v1:
       Case statements in switch that produce same result have
       been combined to reduce repeated assignments.
       patch recreated after rebase to chris balls mmc-next branch.

Girish K S (2):
  mmc: core: HS200 mode support for eMMC 4.5
  mmc: host: Adds support for eMMC 4.5 HS200 mode

 drivers/mmc/core/bus.c     |    3 +-
 drivers/mmc/core/debugfs.c |    3 +
 drivers/mmc/core/mmc.c     |  142 +++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/sd.c      |    3 +-
 drivers/mmc/core/sdio.c    |    4 +-
 drivers/mmc/host/sdhci.c   |   45 +++++++++++----
 drivers/mmc/host/sdhci.h   |    1 +
 include/linux/mmc/card.h   |    3 +
 include/linux/mmc/host.h   |   11 +++-
 include/linux/mmc/mmc.h    |   66 ++++++++++++++++++++-
 include/linux/mmc/sdhci.h  |    1 +
 11 files changed, 257 insertions(+), 25 deletions(-)
