From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/4] mmc: add pwrseq-based hw_reset
Date: Wed, 8 Feb 2017 22:45:52 +0100
Message-ID: <db739bb8-2ad1-75bb-0b65-8246f84da7e8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34736 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbdBHV4B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 16:56:01 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so271022wmi.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 13:56:00 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

For implementing ops hw_reset in struct meson_host_ops often we can
use what is available in pwrseq already, just with a small extension.
For example all existing pwrseq drivers parse DT for a reset GPIO.

Meson GX is the first user of this extension.

Heiner Kallweit (4):
  mmc: pwrseq: add op reset to struct mmc_pwrseq_ops
  mmc: pwrseq: implement reset operation in pwrseq_emmc
  mmc: meson-gx: add pwrseq-based hw_reset
  ARM64: dts: meson-gxbb-odroidc2: add hw-reset capability flag for emmc port

 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 +
 drivers/mmc/core/core.c                             | 6 ++++++
 drivers/mmc/core/pwrseq.c                           | 8 ++++++++
 drivers/mmc/core/pwrseq.h                           | 3 +++
 drivers/mmc/core/pwrseq_emmc.c                      | 1 +
 drivers/mmc/host/meson-gx-mmc.c                     | 1 +
 include/linux/mmc/core.h                            | 1 +
 7 files changed, 21 insertions(+)

-- 
2.11.0

