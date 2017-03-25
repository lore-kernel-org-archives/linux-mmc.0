From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/4] mmc: meson-gx: smaller functional extensions
Date: Sat, 25 Mar 2017 11:20:40 +0100
Message-ID: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35647 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdCYKVC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Mar 2017 06:21:02 -0400
Received: by mail-wm0-f49.google.com with SMTP id u132so29103136wmg.0
        for <linux-mmc@vger.kernel.org>; Sat, 25 Mar 2017 03:21:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

This series includes the switch to bitfield macros and a few smaller
functional extensions.

Successfully tested on a Odroid C2 (S905GXBB) with a 128GB eMMC.

Measured with a simple
dd if=/dev/mmcblk0 of=/dev/null iflag=direct bs=100M count=1
read performance increases from 13.5 MB/s to 16.8 MB/s by
switching to CMD23 mode.

v2:
- removed few unused defines
- improved name of function to get timeout value

Heiner Kallweit (4):
  mmc: meson-gx: use bitfield macros
  mmc: meson-gx: use per port interrupt names
  mmc: meson-gx: switch to dynamic timeout values
  mmc: meson-gx: add CMD23 mode

 drivers/mmc/host/meson-gx-mmc.c | 129 ++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 59 deletions(-)

-- 
2.12.0

