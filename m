From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] mmc: core: Fix the behaviour of pwrseq_emmc
Date: Tue,  9 May 2017 00:09:01 +0200
Message-ID: <1494281343-18963-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37912 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdEHWJI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2017 18:09:08 -0400
Received: by mail-wm0-f49.google.com with SMTP id 142so80635963wma.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 May 2017 15:09:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Douglas Anderson <dianders@chromium.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>

In case if a pwrseq-emmc has been bound to the host, a call to mmc_power_up()
triggers an eMMC HW reset via the pwrseq_emmc's ->post_power_on() callback.
This isn't really what we want, as mmc_power_up() is called each time when
resuming the card.

Let's fix this behaviour and avoid doing the emmc HW reset unless really needed.

Ulf Hansson (2):
  mmc: pwrseq: Add reset callback to the struct mmc_pwrseq_ops
  mmc: core: Don't do eMMC HW reset when resuming the eMMC card

 drivers/mmc/core/core.c        | 2 ++
 drivers/mmc/core/mmc.c         | 2 ++
 drivers/mmc/core/pwrseq.c      | 8 ++++++++
 drivers/mmc/core/pwrseq.h      | 3 +++
 drivers/mmc/core/pwrseq_emmc.c | 2 +-
 5 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.7.4

