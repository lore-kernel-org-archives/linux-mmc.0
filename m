From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH 0/3] mmc: sh_mobile_sdhi: Add r7s72100 support
Date: Fri,  9 Sep 2016 11:52:35 -0400
Message-ID: <20160909155238.17852-1-chris.brandt@renesas.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:8407 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753226AbcIIPxv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2016 11:53:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>

For the most part, the SDHI controller in the RZ/A1 (r7s72100)
is the same as other Renesas SoC...except for the fact that the 
data port register was widened to 32-bits and the 16-bit accesses
in the current tmio driver aren't going to cut it.

Also, the tmio driver allows you to pass in what voltages you
support via the ocr_mask. For the RZ/A1, it's just simple 3.3v.
So, I added the ability to pass that when using DT.


Chris Brandt (3):
  mmc: sh_mobile_sdhi: add ocr_mask option
  mmc: tmio-mmc: add support for 32bit data port
  mmc: sh_mobile_sdhi: Add r7s72100 support

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  1 +
 drivers/mmc/host/sh_mobile_sdhi.c                  |  9 ++++++
 drivers/mmc/host/tmio_mmc.h                        | 12 ++++++++
 drivers/mmc/host/tmio_mmc_pio.c                    | 35 ++++++++++++++++++++++
 include/linux/mfd/tmio.h                           |  5 ++++
 5 files changed, 62 insertions(+)

-- 
2.9.2


