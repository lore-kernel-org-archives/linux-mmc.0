From: "Maya Erez" <merez@codeaurora.org>
Subject: RE: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Sat, 2 Mar 2013 22:00:56 +0200
Message-ID: <003101ce1780$a928d000$fb7a7000$@codeaurora.org>
References: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:28189 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab3CBUBB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Mar 2013 15:01:01 -0500
In-Reply-To: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>
Cc: 'Johan Rudholm' <johan.rudholm@stericsson.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>

Thanks Ulf.
I will go over the new patch and will develop the periodic BKOPS on top of
it.

Thanks,
Maya

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org
[mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Ulf Hansson
Sent: Friday, March 01, 2013 2:47 PM
To: linux-mmc@vger.kernel.org; Chris Ball
Cc: Johan Rudholm; Ulf Hansson
Subject: [PATCH 0/3] mmc: Use runtime pm for blkdevice

From: Ulf Hansson <ulf.hansson@linaro.org>

SDIO has been using runtime pm for a while to handle runtime power save
operations. This patchset is enabling the option to make the sd/mmc
blockdevices to use runtime pm as well.

The runtime pm implementation for the block device will make use of
autosuspend to defer power save operation to after request inactivty for a
certain time.

To actually perform some power save operations the corresponding bus ops for
mmc and sd shall be implemented. Typically it could make sense to do BKOPS
for eMMC in here.

Ulf Hansson (3):
  mmc: core: Remove power_restore bus_ops for mmc and sd
  mmc: core: Add bus_ops for runtime pm callbacks
  mmc: block: Enable runtime pm for mmc blkdevice

 drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
 drivers/mmc/core/bus.c   |   14 ++++++++++++--
 drivers/mmc/core/core.h  |    2 ++
 drivers/mmc/core/mmc.c   |   14 --------------
 drivers/mmc/core/sd.c    |   14 --------------
 drivers/mmc/core/sdio.c  |   20 ++++++++++++++++++++
 6 files changed, 60 insertions(+), 32 deletions(-)

--
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html

Maya Erez
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

