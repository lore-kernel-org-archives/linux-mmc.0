From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.6 rc6
Date: Fri, 29 Apr 2016 09:07:28 +0200
Message-ID: <CAPDyKFo0Y0+ka8zYu-JceEa3ijXopNU=bR8OH4u0bNLctxAgeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37851 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcD2HH3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2016 03:07:29 -0400
Received: by mail-wm0-f54.google.com with SMTP id a17so20541565wme.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2016 00:07:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here are a two mmc fixes intended for v4.6 rc6. It's based on v4.6 rc4.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.6-rc4

for you to fetch changes up to 2963070a0f8184fe40be11927344e3fcc7e18e7c:

  mmc: sunxi: Disable eMMC HS-DDR (MMC_CAP_1_8V_DDR) for Allwinner A80
(2016-04-28 11:43:54 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO hangs
 - sunxi: Disable eMMC HS-DDR for Allwinner A80

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO hangs

Chen-Yu Tsai (1):
      mmc: sunxi: Disable eMMC HS-DDR (MMC_CAP_1_8V_DDR) for Allwinner A80

 drivers/mmc/host/Kconfig      |  1 +
 drivers/mmc/host/sdhci-acpi.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sunxi-mmc.c  |  5 +++
 3 files changed, 87 insertions(+)
