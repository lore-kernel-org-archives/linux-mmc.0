From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Mon, 18 May 2015 08:53:22 -0700
Message-ID: <1431964402-27457-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

According to the DesignWare state machine description, after we get a
"response error" or "response CRC error" we move into data transfer
mode.  That means that we don't necessarily need to special case
trying to deal with the failure right away.  We can wait until we are
notified that the data transfer is complete (with or without errors)
and then we can deal with the failure.

It may sound strange to defer dealing with a command that we know will
fail anyway, but this appears to fix a bug.  During tuning (CMD19) on
a specific card on an rk3288-based system, we found that we could get
a "response CRC error".  Sending the stop command after the "response
CRC error" would then throw the system into a confused state causing
all future tuning phases to report failure.

When in the confused state, the controller would show these (hex codes
are interrupt status register):
 CMD ERR: 0x00000046 (cmd=19)
 CMD ERR: 0x0000004e (cmd=12)
 DATA ERR: 0x00000208
 DATA ERR: 0x0000020c
 CMD ERR: 0x00000104 (cmd=19)
 CMD ERR: 0x00000104 (cmd=12)
 DATA ERR: 0x00000208
 DATA ERR: 0x0000020c
 ...
 ...

It is inherently difficult to deal with the complexity of trying to
correctly send a stop command while a data transfer is taking place
since you need to deal with different corner cases caused by the fact
that the data transfer could complete (with errors or without errors)
during various places in sending the stop command (dw_mci_stop_dma,
send_stop_abort, etc)

Instead of adding a bunch of extra complexity to deal with this, it
seems much simpler to just use the more straightforward (and less
error-prone) path of letting the data transfer finish.  There
shouldn't be any huge benefit to sending the stop command slightly
earlier, anyway.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5f5adaf..c081ce2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1574,6 +1574,26 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			}
 
 			if (cmd->data && err) {
+				/*
+				 * Controller will move into a data transfer
+				 * state after a response error or response CRC
+				 * error.  Let's let that finish before trying
+				 * to send a stop, so we'll go to
+				 * STATE_SENDING_DATA.
+				 *
+				 * Although letting the data transfer take place
+				 * will waste a bit of time (we already know
+				 * the command was bad), it can't cause any
+				 * errors since it's possible it would have
+				 * taken place anyway if this tasklet got
+				 * delayed.  Allowing the transfer to take place
+				 * avoids races and keeps things simple.
+				 */
+				if (err != -ETIMEDOUT) {
+					state = STATE_SENDING_DATA;
+					continue;
+				}
+
 				dw_mci_stop_dma(host);
 				send_stop_abort(host, data);
 				state = STATE_SENDING_STOP;
-- 
2.2.0.rc0.207.ga3a616c
