From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH v4 0/2] mmc: core: Add Poweroff Notify handling eMMC 4.5
Date: Fri,  9 Sep 2011 10:04:12 +0530
Message-ID: <1315542854-3752-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51301 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab1IIEek (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2011 00:34:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

This version adds the changes suggested by Jeon 

Girish K S (2):
  mmc: core: Add power off notify feature(eMMC 4.5)
  mmc: core: Add Poweroff Notify handling eMMC 4.5

 drivers/mmc/core/core.c  |   33 +++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |   22 ++++++++++++++++++++--
 drivers/mmc/host/sdhci.c |   10 ++++++++++
 include/linux/mmc/card.h |   20 ++++++++++++++++++++
 include/linux/mmc/host.h |    5 +++++
 include/linux/mmc/mmc.h  |    7 +++++++
 6 files changed, 95 insertions(+), 2 deletions(-)

