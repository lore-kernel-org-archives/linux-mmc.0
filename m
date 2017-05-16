From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 0/5] mmc: cavium: bug fixes for 4.12
Date: Tue, 16 May 2017 11:36:50 +0200
Message-ID: <20170516093655.17746-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34049 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdEPJhV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 05:37:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Hi Ulf,

here are some bug fixes for the new mmc driver. The only
non-trivial fix should be the platform thing in patch #4 and #5.

Tested on OcteonTx and on various MIPS boxes.

thanks,
Jan

David Daney (2):
  mmc: cavium-octeon: Fix interrupt enable code
  mmc: cavium-octeon: Use proper GPIO name for power control

Jan Glauber (3):
  mmc: cavium: Prevent crash with incomplete DT
  of/platform: Make of_platform_device_destroy globally visible
  mmc: cavium: Fix probing race with regulator

 drivers/mmc/host/cavium-octeon.c   | 4 ++--
 drivers/mmc/host/cavium-thunderx.c | 4 +++-
 drivers/mmc/host/cavium.c          | 8 ++++++--
 drivers/of/platform.c              | 3 ++-
 include/linux/of_platform.h        | 1 +
 5 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.9.0.rc0.21.g7777322

