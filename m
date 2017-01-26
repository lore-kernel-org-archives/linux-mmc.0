From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 00/13] mmc: bcm2835: more cleanups
Date: Fri, 27 Jan 2017 00:37:13 +0100
Message-ID: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbdAZXhn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Jan 2017 18:37:43 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>

  Hi folks,

Continuing bcm283x mmc driver cleanup.  Changes:

 * switch to threaded irq handler.
 * handle timeouts using delayed work instead of timers.

With these changes most of the driver code runs in
thread context, which in turn allows to remove the
work queue and the tasklet.  Also some wait loops can
be simplified because almost all driver code is allowed
to sleep now.

Code is also available here:
  git://git.kraxel.org/linux bcm2837-sdhost-cleanup

Baseline for the patch series is this:
  git://git.kraxel.org/linux bcm2837-wifi

Tested on raspberry pi 2b only so far.
PIO mode only, didn't try to enable DMA.

Lots of baby patches for now, to make review
and (if needed) bisecting easier.  Will all be
squashed into the bcm283x mmc driver patch later.

cheers,
  Gerd

Gerd Hoffmann (13):
  mmc: bcm2835: add bcm2835_read_wait_sdcmd
  mmc: bcm2835: use bcm2835_read_wait_sdcmd in bcm2835_send_command
  mmc: bcm2835: add bcm2835_threaded_irq
  mmc: bcm2835: add bcm2835_check_data_error
  mmc: bcm2835: call bcm2835_block_irq from irqthread
  mmc: bcm2835: add bcm2835_check_cmd_error
  mmc: bcm2835: call bcm2835_busy_irq from irqthread
  mmc: bcm2835: split bcm2835_data_irq
  mmc: bcm2835: switch locking to mutex
  mmc: bcm2835: work queue is dead code now, zap
  mmc: bcm2835: kill tasklet
  mmc: bcm2835: move timeout to thread context
  mmc: bcm2835: use bcm2835_read_wait_sdcmd in bcm2835_finish_command

 drivers/mmc/host/bcm2835.c | 448 ++++++++++++++++++++-------------------------
 1 file changed, 197 insertions(+), 251 deletions(-)

-- 
1.8.3.1

