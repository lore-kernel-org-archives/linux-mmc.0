From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/4] mmc: meson-gx: smaller functional extensions
Date: Fri, 24 Mar 2017 23:01:48 +0100
Message-ID: <f6960395-370e-16b0-1a2a-2a1fce720d45@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37821 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbdCXWDH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 18:03:07 -0400
Received: by mail-wm0-f51.google.com with SMTP id n11so2092597wma.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 15:02:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

This series includes the switch to bitfield macros and a few smaller
functional extensions.

Heiner Kallweit (4):
  mmc: meson-gx: use bitfield macros
  mmc: meson-gx: use per port interrupt names
  mmc: meson-gx: switch to dynamic timeout values
  mmc: meson-gx: add CMD23 mode

 drivers/mmc/host/meson-gx-mmc.c | 119 +++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 51 deletions(-)

-- 
2.12.0

