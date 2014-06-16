From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] mmc: mmci: Restore irq handling behavior for arm_variant
Date: Mon, 16 Jun 2014 09:58:00 +0200
Message-ID: <1402905483-22567-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:40825 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbaFPH6K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 03:58:10 -0400
Received: by mail-la0-f54.google.com with SMTP id mc6so2167563lab.41
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 00:58:09 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

Commit "mmc: mmci: Handle CMD irq before DATA irq" introduced a bug, reported
by John Stultz while using the arm_variant in QEMU envrionment.

More information can be found here:
https://lkml.org/lkml/2014/6/12/19

In this patchset we restores the old behavior for handling irqs, but only for
the arm_variant.

Ulf Hansson (3):
  mmc: mmci: Remove redundant check of status for DATA irq
  mmc: mmci: Move all CMD irq handling to mmci_cmd_irq()
  mmc: mmci: Reverse IRQ handling for the arm_variant

 drivers/mmc/host/mmci.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
1.7.9.5

