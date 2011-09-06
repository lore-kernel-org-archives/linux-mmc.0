From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH v2 0/2] PowerOff Notify/handle feature eMMC 4.5
Date: Tue,  6 Sep 2011 16:29:25 +0530
Message-ID: <1315306767-9549-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:59338 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab1IFK7l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2011 06:59:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

This set of patch implements the PowerOff notification feature
for eMMC 4.5 devices.

Girish K S (2):
  mmc: core: Add power off notify feature(eMMC 4.5)
  mmc: core: Add Poweroff Notify handling

 drivers/mmc/core/core.c  |   33 +++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |   21 +++++++++++++++++++--
 drivers/mmc/host/sdhci.c |   10 ++++++++++
 include/linux/mmc/card.h |   20 ++++++++++++++++++++
 include/linux/mmc/host.h |    5 +++++
 include/linux/mmc/mmc.h  |    7 +++++++
 6 files changed, 94 insertions(+), 2 deletions(-)

