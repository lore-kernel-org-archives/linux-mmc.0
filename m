From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for mmc-next
Date: Fri, 1 Nov 2013 01:15:06 +0100
Message-ID: <CAPDyKFruCr6mGCYQzWSxuWGCuyOFfPqGYCxH+EKV0f88DDThoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:33884 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab3KAAPH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Oct 2013 20:15:07 -0400
Received: by mail-qc0-f181.google.com with SMTP id w4so2105702qcr.26
        for <linux-mmc@vger.kernel.org>; Thu, 31 Oct 2013 17:15:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi Chris,

I have collected a few additional patches that you might want to pull
into your mmc-next branch when you find it convenient.

Kind regards
Ulf Hansson


The following changes since commit 4d22378221bd0ed69c2e99408d31c108d72aeb80:

  mmc: core: Add MMC_CAP_RUNTIME_RESUME to resume at runtime_resume
(2013-10-30 20:28:43 -0400)

are available in the git repository at:

  git://git.linaro.org/people/ulfh/mmc.git mmc-next_for_chris

for you to fetch changes up to 3157fb3c092ef008fac3e8657926e00145799c5f:

  mmc: wbsd: Silence compiler warning (2013-11-01 00:44:59 +0100)

----------------------------------------------------------------
Ulf Hansson (4):
      mmc: sh_mmcif: Convert to PM macros when defining dev_pm_ops
      mmc: sh_mmcif: Convert to clk_prepare|unprepare
      mmc: core: Silence compiler warning in __mmc_switch
      mmc: wbsd: Silence compiler warning

 drivers/mmc/core/mmc_ops.c  |    2 +-
 drivers/mmc/host/sh_mmcif.c |   22 +++++++++-------------
 drivers/mmc/host/wbsd.c     |    1 -
 3 files changed, 10 insertions(+), 15 deletions(-)
