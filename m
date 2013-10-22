From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/7] mmc: sh_mmcif: Convert to use runtime PM at request idle
Date: Tue, 22 Oct 2013 16:07:19 +0200
Message-ID: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:64642 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab3JVOHd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 10:07:33 -0400
Received: by mail-la0-f48.google.com with SMTP id ev20so1002280lab.21
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 07:07:32 -0700 (PDT)
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

Changes in v2:
	- Adapted "mmc: sh_mmcif: Move clock handling into runtime PM callbacks"
	patch to maintain behavior of handling clk_get_rate.
	- Rebased patches on top of the above change.

Ulf Hansson (7):
  mmc: sh_mmcif: Move away from using deprecated APIs
  mmc: sh_mmcif: Convert to PM macros when defining dev_pm_ops
  mmc: sh_mmcif: Convert to clk_prepare|unprepare
  mmc: sh_mmcif: Use runtime PM to keep resourses active during I/O
  mmc: sh_mmcif: Move clock handling into runtime PM callbacks
  mmc: sh_mmcif: Simplify clock and power setup in set_ios
  mmc: sh_mmcif: Extend clock gating routine for runtime suspend

 drivers/mmc/host/sh_mmcif.c |  138 ++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 62 deletions(-)

-- 
1.7.9.5

