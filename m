From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/7] mmc: slot-gpio: Cleanup API and simplifications
Date: Thu, 18 Dec 2014 15:44:29 +0100
Message-ID: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:43765 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaLROoq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 09:44:46 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so1820154wgg.11
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 06:44:45 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Note, this patchset is based upon the following patchset:
[PATCH 0/6] mmc: Fix error handling for mmc_of_parse()
http://marc.info/?l=linux-mmc&m=141889571821080&w=2

Patch 1 -> 2:
Remove redundant calls from host drivers to the slot-gpio API for freeing
requested CD/WP GPIOs.

Patch 3:
Remove redundant slot-gpio API for freeing requested CD/WP GPIOs. 

Patch 4 -> 7:
Rework how slot-gpio handles allocation of data.


Ulf Hansson (7):
  mmc: mvsdio: Remove redundant use of mmc_gpio_free_cd|ro()
  mmc: sdhci-sirf: Remove redundant use of mmc_gpio_free_cd()
  mmc: slot-gpio: Remove option to explicitly free requested CD/WP GPIOs
  mmc: slot-gpio: Use the parent device while allocating data
  mmc: slot-gpio: Make mmc_gpio_alloc() available for MMC core
  mmc: core: Free all resources for the class device at ->dev_release()
  mmc: slot-gpio: Rework how to handle allocation of slot-gpio data

 drivers/mmc/core/host.c       |  33 +++++----
 drivers/mmc/core/slot-gpio.c  | 164 ++++++------------------------------------
 drivers/mmc/core/slot-gpio.h  |  13 ++++
 drivers/mmc/host/mvsdio.c     |   4 --
 drivers/mmc/host/sdhci-sirf.c |   3 -
 include/linux/mmc/host.h      |   2 -
 include/linux/mmc/slot-gpio.h |   3 -
 7 files changed, 52 insertions(+), 170 deletions(-)
 create mode 100644 drivers/mmc/core/slot-gpio.h

-- 
1.9.1

