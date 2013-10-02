From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/7] mmc: sh_mmcif: Convert to use runtime PM at request idle
Date: Wed,  2 Oct 2013 10:30:44 +0200
Message-ID: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:35541 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab3JBIa6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 04:30:58 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so345061lab.31
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 01:30:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

In a step in removing CONFIG_MMC_CLKGATE, host drivers can implement same
functionality through runtime PM. This patchset is converting the sh_mmcif
accordingly.

On the way, it was reasonable to include some minor cleanups to simplify code.
The first patch has beend sent through an another patchset recently, but since
it touches related code to this patchset, I decided to fold it in here as well.

An important note, this patchset has only been compile tested. I hope someone
can help out with proper testing.

Ulf Hansson (7):
  mmc: sh_mmcif: Move away from using deprecated APIs
  mmc: sh_mmcif: Convert to PM macros when defining dev_pm_ops
  mmc: sh_mmcif: Convert to clk_prepare|unprepare
  mmc: sh_mmcif: Use runtime PM to keep resourses active during I/O
  mmc: sd_mmcif: Move clock handling into runtime PM callbacks
  mmc: sh_mmcif: Simplify clock and power setup in set_ios
  mmc: sh_mmcif: Extend clock gating routine for runtime suspend

 drivers/mmc/host/sh_mmcif.c |  157 +++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 74 deletions(-)

-- 
1.7.9.5

