From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 0/4] Tegra SD/MMC fixes
Date: Mon, 14 Apr 2014 18:42:39 -0700
Message-ID: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f73.google.com ([209.85.216.73]:38928 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbaDOBms (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Apr 2014 21:42:48 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so1317053qab.0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Apr 2014 18:42:47 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>

The following patches fix a couple of issues which prevented Venice2
boards from booting via eMMC and SD card reliably.  Note that this
includes disabling UHS support since SDR50 and above require a
Tegra-specific tuning procedure which is not supported yet (and still
seems to have issues even in downstream kernels).

Tested on Tegra124-based Venice2 and Norrin boards.

Andrew Bresticker (4):
  mmc: tegra: disable UHS modes
  mmc: tegra: fix reporting of base clock frequency
  mmc: sdhci: defer probing on regulator_get_optional() failures
  ARM: tegra: fix Venice2 VQMMC regulators

 arch/arm/boot/dts/tegra124-venice2.dts |  3 ++-
 drivers/mmc/host/sdhci-tegra.c         | 40 +++++++++++++++++++++++++---------
 drivers/mmc/host/sdhci.c               | 19 +++++++++++++---
 3 files changed, 48 insertions(+), 14 deletions(-)

-- 
1.9.1.423.g4596e3a

