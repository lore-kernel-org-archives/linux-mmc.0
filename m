From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for mmc-next for 3.14, take 1
Date: Fri, 20 Dec 2013 09:39:08 +0100
Message-ID: <CAPDyKFpNgZ1ExXMbz7q4QqMNnCrFFPxrVtzB3cX1D3C96e0HLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60457 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab3LTIjJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Dec 2013 03:39:09 -0500
Received: by mail-qc0-f174.google.com with SMTP id n7so1916351qcx.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Dec 2013 00:39:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Chris,

Here is a collection of patches you might want to pull in for your
mmc-next branch for 3.14.

Kind regards
Ulf Hansson


The following changes since commit 82793a517714c53e874dd54c94c3965cc118f689:

  mmc: sh_mmcif: Fix compilation warning on 64-bit platforms
(2013-12-11 21:20:59 -0500)

are available in the git repository at:

  git://git.linaro.org/people/ulfh/mmc.git mmc-next_for_chris

for you to fetch changes up to 435c4fe59617b7439fa4a59f656b8499771002da:

  mmc: core: Enable MMC_CAP2_CACHE_CTRL as default (2013-12-20 09:14:13 +0100)

----------------------------------------------------------------
Ulf Hansson (10):
      mmc: sh_mobile_sdhi: Use modern PM macros to define pm callbacks
      mmc: tmio_mmc: Convert from legacy to modern PM ops
      mmc: tmio: Adapt to proper PM configs for exported functions
      mmc: core: Use MMC_UNSAFE_RESUME as default behavior
      mmc: core: Remove unnecessary validations for bus_ops callbacks
      mmc: card: Remove host cap MMC_CAP2_SANITIZE
      mmc: core: Remove unused host cap MMC_CAP2_BROKEN_VOLTAGE
      mmc: core: Remove support for MMC_CAP2_NO_SLEEP_CMD
      mmc: core: Use mmc_flush_cache() during mmc suspend
      mmc: core: Enable MMC_CAP2_CACHE_CTRL as default

 drivers/mmc/card/block.c          |    3 +-
 drivers/mmc/core/Kconfig          |   15 --------
 drivers/mmc/core/bus.c            |   12 ++-----
 drivers/mmc/core/core.c           |   72 +++----------------------------------
 drivers/mmc/core/mmc.c            |   31 ++--------------
 drivers/mmc/core/sd.c             |   23 +-----------
 drivers/mmc/host/sh_mobile_sdhi.c |    8 ++---
 drivers/mmc/host/tmio_mmc.c       |   30 ++++++++--------
 drivers/mmc/host/tmio_mmc.h       |    7 ++--
 drivers/mmc/host/tmio_mmc_pio.c   |    7 ++--
 include/linux/mmc/host.h          |   11 +-----
 11 files changed, 40 insertions(+), 179 deletions(-)
