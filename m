From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] mmc: dw_mmc: Fix the CTO timeout calculation
Date: Wed, 27 Sep 2017 13:56:30 -0700
Message-ID: <20170927205631.31559-3-dianders@chromium.org>
References: <20170927205631.31559-1-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170927205631.31559-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com
Cc: briannorris@chromium.org, amstan@chromium.org, xzy.xu@rock-chips.com, Douglas Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In the commit 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken
command transfer over scheme") we tried to calculate the expected
hardware command timeout value.  Unfortunately that calculation isn't
quite correct in all cases.  It used "bus_hz" but, as far as I can
tell, it's supposed to use the card clock.  Let's account for the div
value, which is documented as 2x the value stored in the register, or
1 if the register is 0.

NOTE: It's not expected that this will actually fix anything important
since the 10 ms margin added by the function will pretty much dwarf
any calculations.  The card clock should be 100 kHz at minimum and:
  1000 ms/s * (255 * 2) / 100000 Hz.
Gives us 5.1 ms.

...so really the point of this patch is just to make the code more
"correct" in case anyone ever tries to remove the 10 ms buffer.

Fixes: 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken command transfer over scheme")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/dw_mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f5b2bb4b4d98..16516c528a88 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -401,10 +401,14 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 static inline void dw_mci_set_cto(struct dw_mci *host)
 {
 	unsigned int cto_clks;
+	unsigned int cto_div;
 	unsigned int cto_ms;
 
 	cto_clks = mci_readl(host, TMOUT) & 0xff;
-	cto_ms = DIV_ROUND_UP(cto_clks, host->bus_hz / 1000);
+	cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
+	if (cto_div == 0)
+		cto_div = 1;
+	cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
 
 	/* add a bit spare time */
 	cto_ms += 10;
-- 
2.14.2.822.g60be5d43e6-goog
