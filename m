From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] mmc: meson-gx: add basic tuning
Date: Tue, 4 Apr 2017 20:58:15 +0200
Message-ID: <1d60ec2c-54c9-6b1c-7eaa-40e96fcd5be5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38686 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755668AbdDDS6b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2017 14:58:31 -0400
Received: by mail-wm0-f43.google.com with SMTP id t189so36225139wmt.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2017 11:58:26 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

With a 128GB Hardkernel eMMC card my Odroid C2 boots up to 60MHz only
(tons of CRC errors otherwise). I made some tests and with changed
clock phase configuration it runs rock-solid with 200 MHz.
Changing the clock phase configuration in general most likely wouldn't
be a good idea as this might break other combinations of MMC device and
speed.
Therefore add basic tuning. So far it changes the rx clock phase only
as default core and tx clock phase work fine.

Heiner Kallweit (2):
  mmc: meson-gx: introduce struct meson_tuning_params
  mmc: meson-gx: add basic tuning for rx clock phase

 drivers/mmc/host/meson-gx-mmc.c | 66 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

-- 
2.12.1

