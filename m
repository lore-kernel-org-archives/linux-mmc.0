From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/5] mmc: meson-gx: add cmd23 and descriptor chain mode
Date: Wed, 15 Mar 2017 20:16:16 +0100
Message-ID: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33649 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdCOTQf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 15:16:35 -0400
Received: by mail-wr0-f169.google.com with SMTP id u48so17654607wrc.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2017 12:16:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Apart from three minor improvements this patch series adds support
for CMD23 mode and switches the driver to descriptor chain mode.

On my system with a 128GB eMMC card this increased the read
performance from 10 - 15 MB/s to 140 MB/s.

Successfully tested on a Odroid C2 with custom uboot based on recent
mainline uboot. Behavior might be different with vendor uboot.

Heiner Kallweit (5):
  mmc: meson-gx: switch irq name to DT node name
  mmc: meson-gx: improve response reading
  mmc: meson-gx: use block mode also for just one block
  mmc: meson-gx: add support for CMD23 mode
  mmc: meson-gx: switch to descriptor chain mode

 drivers/mmc/host/meson-gx-mmc.c | 258 ++++++++++++++++++++++------------------
 1 file changed, 142 insertions(+), 116 deletions(-)

-- 
2.12.0

