From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: rockchip: Set the drive phase to 180 degrees
Date: Tue, 10 May 2016 11:16:35 -0700
Message-ID: <1462904195-18229-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33595 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbcEJSRJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 14:17:09 -0400
Received: by mail-pf0-f175.google.com with SMTP id 206so8566173pfu.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 11:17:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, shawn.lin@rock-chips.com
Cc: linux-rockchip@lists.infradead.org, briannorris@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Historically for Rockchip devices we've relied on the power-on
default (or perhaps the firmware setting) to get the correct drive
phase for dw_mmc devices.  This worked OK for the most part, but:

* Relying on the setting just "being right" is a bit fragile.

* As soon as there is an instance where the power on default is wrong or
  where the firmware didn't configure this properly then we'll get a
  mysterious failure.

Let's explicitly set this phase in the kernel.

You might notice that this patch is currently very dumb and just always
sets this phase to 180 degrees.  As far as I can tell this is actually a
sane thing to do.  From reading through the Designware Databook it
appears that there are instances where you could still meet hold time
requirements and set this phase to 90 degrees, but nothing I've read
indicates that 180 degrees is not OK also.

As indicated above, adding a delay to the drive is used to achieve
proper hold times.  For a given speed mode hold times are listed in the
spec in terms of nanoseconds.  The hold times are different for
different speed modes.  The actual hold time achieved is actually a
function of Delay_O (an internal delay in dw_mmc, which could vary from
SoC model to SoC model), pad delays, and the drive delay (which we're
setting here).  Note also that by setting the drive delay as a phase we
will get a different number of nanoseconds of delay depending on the
input clock.

Note that, as far as I can tell, this _does_ change the behavior of
rk3288 devices.  On devices I tested, which use coreboot/depthcharge as
BIOS, the SDMMC/SDIO0/SDIO1 drive phase used to be 90 degrees.  Now it
will be 180 degrees.  With my understanding from the Designware Databook
the 180 degrees ought to be more correct and should increase
compatibility.

I have tested this by inserting my collection of uSD cards (mostly UHS,
though a few not) into a veyron_minnie and confirmed that they still
seem to enumerate properly.  For a subset of them I tried putting a
filesystem on them and also tried running mmc_test.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 8c20b81cafd8..62cbd33a07cd 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -66,6 +66,27 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	/* Make sure we use phases which we can enumerate with */
 	if (!IS_ERR(priv->sample_clk))
 		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
+
+	/*
+	 * Set the drive phase to 180 degrees.  This helps us achieve proper
+	 * hold times.
+	 *
+	 * Note that this is _not_ a value that is tuned and is also _not_ a
+	 * value that will vary from board to board.  It is a value that
+	 * _could_ vary between different SoC models (could be different on
+	 * rk3066 vs. rk3288 for instance).  It is also a value that _could_
+	 * need to be adjusted based on our clock frequency and speed mode
+	 * since different speed modes have different hold time requirements
+	 * and hold time requirements are in "ns" (a phase offset adds a
+	 * different "ns" delay for different input clocks).
+	 *
+	 * Despite these theoretical needs, it has been observed that 180
+	 * degrees gives us good signaling across all tested SoCs and all
+	 * tested speed modes.  If when we find someone that needs 90 degrees
+	 * here we can add a table based on speed mode / SoC compatible ID.
+	 */
+	if (!IS_ERR(priv->drv_clk))
+		clk_set_phase(priv->drv_clk, 180);
 }
 
 #define NUM_PHASES			360
-- 
2.8.0.rc3.226.g39d4020

