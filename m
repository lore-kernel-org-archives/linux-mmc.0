From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/7] mmc: core: Fixup ocr mask setup to prevent spec violation
Date: Mon, 16 Sep 2013 16:17:23 +0200
Message-ID: <1379341043-27062-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:38277 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab3IPORa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2013 10:17:30 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so3117229lab.4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2013 07:17:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

According to the eMMC/SD/SDIO specs the VDD voltage level must not be changed
during the initialization, without a complete power cycle of the card.

Before this patchset, some host drivers were trying to change voltage level
at MMC_POWER_ON state, which is also what the protocol layer advised them to.
This was not correctly done and is the reason to why quite messy code in
the protocol layer has been needed, to handle a re-initialization sequence,
typically triggered from a power_restore or resume.

I have tried to make each patch in the patchset as small and separate as
possible, surely the is room for improvments. Any suggestions are appreciated.

An important note; MMC_CAP2_FULL_PWR_CYCLE, will need to be set by a host
to tell the protocol layer that the host is able to perform a complete power
cycle. Thus the protocol layer will try to negotiate the lowest possible VDD
voltage level between the card and host.


Ulf Hansson (7):
  mmc: core: Let mmc_power_up|cycle take ocr as parameter
  mmc: core: Let mmc_set_signal_voltage take ocr as parameter
  mmc: core: Remove unnecessary retry mechanism at SDIO attach
  mmc: core: Cleanup code for setting ocr mask for SDIO
  mmc: core: Move cached value of the negotiated ocr mask to card
    struct
  mmc: core: Prevent violation of specs while initializing cards
  mmc: core: Collect common code for card ocr validation

 drivers/mmc/core/core.c  |   66 +++++++++++++++++--------------------
 drivers/mmc/core/core.h  |    6 ++--
 drivers/mmc/core/mmc.c   |   29 +++++-----------
 drivers/mmc/core/sd.c    |   41 +++++++----------------
 drivers/mmc/core/sdio.c  |   82 ++++++++++++++--------------------------------
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/host.h |    1 -
 7 files changed, 79 insertions(+), 147 deletions(-)

-- 
1.7.9.5

