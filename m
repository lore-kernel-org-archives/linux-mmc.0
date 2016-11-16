From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/9] mmc: core: Re-work CMD13 polling method for CMD6 for mmc
Date: Wed, 16 Nov 2016 11:51:12 +0100
Message-ID: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37711 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbcKPKve (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 05:51:34 -0500
Received: by mail-wm0-f47.google.com with SMTP id t79so63883579wmt.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2016 02:51:33 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

Several changes has been made for how and when to use CMD13 as a
polling-method, to find out when the mmc cards stops signaling busy after
sending a CMD6. This particularly concerns the cases when switching to new bus
speed modes, such as HS (high-speed), HS DDR, HS200, HS400 and HS400ES.

Currently CMD13 polling is *not* allowed for these cases, but this was recently
changed - and which did cause regressions for card detection for some
platforms.

A simple fix was made to solve these regressions, simply by using a default
CMD6 generic timeout of 500ms, as to avoid using the fall-back timeout in
__mmc_switch() of 10min. That greatly improve the situation and one could
consider the regressions as "solved".

However, this simple fix is still causing unnecessary long card initialization
times, especially for those mmc hosts that doesn't support HW busy detection
(using MMC_CAP_WAIT_WHILE_BUSY and/or implements the ->card_busy() host ops).

This because we wait a fixed amount of time (CMD6 generic timeout) to make sure
the card is done signaling busy, while in practice this happens a lot sooner.

A couple of tests for HS and HS DDR eMMC cards, shows the card only need a few
ms to complete the bus speed mode changes, thus it's far less than the CMD6
generic timeout.

To improve this behaviour and shorten the card initialization time, we need to
allow using CMD13 as polling method to find out when the card stops signaling
busy. Although, enabling CMD13 polling may also introduce other issues as
according to the JEDEC spec, it's not the recommended method. Especially it
mentions that CRC errors may be triggered when sending a CMD13 command during a
bus timing change.

To deal with these issues, we need to change from ignoring those CRC errors but
instead continue to treat the card as being busy and continue to poll with
CMD13. Perhaps this behaviour is one of reasons to why the earlier CMD13 polling
method didn't work out well.

This series requires extensive testing, please help with that!

I have currently tested it with HS and HS DDR eMMC cards, and for combinations
of an mmc hosts (mmci) supporting HW busy detection and not (local hacks in
mmci.c).


Ulf Hansson (9):
  mmc: core: Retry instead of ignore at CRC errors when polling for busy
  mmc: core: Remove redundant __mmc_send_status()
  mmc: core: Rename ignore_crc to retry_crc_err to reflect its purpose
  mmc: core: Enable __mmc_switch() to change bus speed timing for the
    host
  mmc: core: Allow CMD13 polling when switching to HS mode for mmc
  mmc: core: Update CMD13 polling policy when switch to HS DDR mode
  mmc: core: Allow CMD13 polling when switch to HS200 mode
  mmc: core: Allow CMD13 polling when switch to HS400 mode
  mmc: core: Allow CMD13 polling when switch to HS400ES mode

 drivers/mmc/core/core.c    |   2 +-
 drivers/mmc/core/mmc.c     | 156 ++++++++++++++-------------------------------
 drivers/mmc/core/mmc_ops.c |  45 +++++++------
 drivers/mmc/core/mmc_ops.h |   4 +-
 4 files changed, 77 insertions(+), 130 deletions(-)

-- 
1.9.1

