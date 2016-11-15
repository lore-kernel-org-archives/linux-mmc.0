From: Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH 0/2] MMC: davinci: fix card detect and write protect
Date: Tue, 15 Nov 2016 17:28:20 +0100
Message-ID: <20161115162822.25791-1-ahaslam@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38029 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbcKOQ20 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2016 11:28:26 -0500
Received: by mail-wm0-f49.google.com with SMTP id f82so9695906wmf.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2016 08:28:25 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, nsekhar@ti.com, khilman@baylibre.com, david@lechnology.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

This series fixes the card detect and write protect parsing for
the davinci_mmc driver, and takes care of a technical debt to 
remove card polling when a card detect gpio is available.

In the case of a platform based boot we register the gpios
using the APIs provided by slot-gpio.

In the case of a DT based boot we use the mmc_of_parse API to parse
all DT properties and register the gpios.

If this series is accepted, the next series will convert all users
to use gpio descriptors and we could then remove the platform
callbacks.

This was tested on the omap138-lcdk, and the da850-evm, with 
additional patches to platform data and dts files.

Axel Haslam (2):
  MMC: davinci: use mmc_of_parse to parse common mmc configuration
  MMC: davinci: request gpios using gpio descriptors

 drivers/mmc/host/davinci_mmc.c | 130 +++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 64 deletions(-)

-- 
2.10.1

