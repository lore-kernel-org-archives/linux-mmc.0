From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/8] mmc: tmio: Convert to use runtime PM at request idle
Date: Fri,  8 Nov 2013 07:06:08 +0100
Message-ID: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:47975 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3KHGG0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 01:06:26 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so1122279lbj.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 22:06:22 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

In a step in removing CONFIG_MMC_CLKGATE, host drivers can implement same
functionality through runtime PM. This patchset is converting the tmio
accordingly.

On the way, it was reasonable to include some minor cleanups to simplify code.
The first three patch has beend sent through an another patchset recently, and
acked but since it touches related code to this patchset, I decided to fold it
in here as well.

An important note, this patchset has only been compile tested. I would
appreciate if any that has a hw can help out in testing.

Ulf Hansson (8):
  mmc: sh_mobile_sdhi: Use modern PM macros to define pm callbacks
  mmc: tmio_mmc: Convert from legacy to modern PM ops
  mmc: tmio: Adapt to proper PM configs for exported functions
  mmc: tmio: Keep host active while SDIO irq is enabled
  mmc: tmio: Keep host active while serving requests
  mmc: tmio: Extract bus_width modifications to a function
  mmc: tmio: Restructure .set_ios and adapt probe sequence to it
  mmc: tmio: Handle clock gating from runtime PM functions

 drivers/mmc/host/sh_mobile_sdhi.c |    8 +-
 drivers/mmc/host/tmio_mmc.c       |   30 +++---
 drivers/mmc/host/tmio_mmc.h       |   31 ++-----
 drivers/mmc/host/tmio_mmc_pio.c   |  185 ++++++++++++++++++++-----------------
 4 files changed, 125 insertions(+), 129 deletions(-)

-- 
1.7.9.5

