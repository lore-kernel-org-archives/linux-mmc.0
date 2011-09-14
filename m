From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V1] Power Class Selection Feature
Date: Wed, 14 Sep 2011 16:16:14 +0530
Message-ID: <1315997175-5540-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch version modifies the power_class_select function prototype.

During device enumeration, when the host tries to read the extended
csd register after switching to higher bus width, the read fails at
higher bus width. So the power_class_select function is modified to
reuse the extended csd register values read with 1 bit bus width. 

Girish K S (1):
  mmc: core: eMMC 4.5 Power Class Selection Feature

 drivers/mmc/core/mmc.c  |   90 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/mmc.h |   13 +++++++
 2 files changed, 103 insertions(+), 0 deletions(-)
