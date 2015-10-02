From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.3 rc4
Date: Fri, 2 Oct 2015 11:24:03 +0200
Message-ID: <CAPDyKFp6mOkmeMNFoveqTvj4i2ojOwjh=+ruFsxhLVQT5Ubr_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35170 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbJBJYF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2015 05:24:05 -0400
Received: by wicge5 with SMTP id ge5so24464426wic.0
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2015 02:24:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

Here are some mmc fixes intended for v4.3 rc4 and it's based on v4.3-rc3.
Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.3-rc3

for you to fetch changes up to 031277d4d33d33f0174fbb569ca8f68238175617:

  mmc: core: fix dead loop of mmc_retune (2015-09-30 14:54:22 +0200)

----------------------------------------------------------------
MMC core:
 - Allow users of mmc_of_parse() to succeed when CONFIG_GPIOLIB is unset
 - Prevent infinite loop of re-tuning for CRC-errors for CMD19 and CMD21

MMC host:
 - pxamci: Fix issues with card detect
 - sunxi: Fix clk-delay settings

----------------------------------------------------------------
Chaotian Jing (1):
      mmc: core: fix dead loop of mmc_retune

Hans de Goede (1):
      mmc: sunxi: Fix clk-delay settings

Robert Jarzmik (1):
      mmc: pxamci: fix card detect with slot-gpio API

Ulf Hansson (1):
      mmc: core: Don't return an error for CD/WP GPIOs when GPIOLIB is unset

 drivers/mmc/core/core.c      |  6 ++--
 drivers/mmc/core/host.c      |  4 +--
 drivers/mmc/host/pxamci.c    | 66 +++++++++++++++-----------------------------
 drivers/mmc/host/sunxi-mmc.c | 53 +++++++++++++++++++++++++----------
 4 files changed, 67 insertions(+), 62 deletions(-)
