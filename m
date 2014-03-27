From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH] mmc: dw_mmc: Make sure we don't get stuck when we get an error
Date: Thu, 27 Mar 2014 11:48:46 +0530
Message-ID: <1395901126-6141-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:38889 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaC0GTB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Mar 2014 02:19:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: grundler@chromium.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, sonnyrao@chromium.org, kgene.kim@samsung.com, joshi@samsung.com
Cc: t.figa@samsung.com, Doug Anderson <dianders@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>

From: Doug Anderson <dianders@chromium.org>

If we happened to get a data error at just the wrong time the dw_mmc
driver could get into a state where it would never complete its
request.  That would leave the caller just hanging there.

We fix this two ways and both of the two fixes on their own appear to
fix the problems we've seen:

1. Fix a race in the tasklet where the interrupt setting the data
   error happens _just after_ we check for it, then we get a
   EVENT_XFER_COMPLETE.  We fix this by repeating a bit of code.
2. Fix it so that if we detect that we've got an error in the "data
   busy" state and we're not going to do anything else we end the
   request and unblock anyone waiting.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
---
 drivers/mmc/host/dw_mmc.c |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1d77431..4c589f1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1300,6 +1300,14 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			/* fall through */
 
 		case STATE_SENDING_DATA:
+			/*
+			 * We could get a data error and never a transfer
+			 * complete so we'd better check for it here.
+			 *
+			 * Note that we don't really care if we also got a
+			 * transfer complete; stopping the DMA and sending an
+			 * abort won't hurt.
+			 */
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
 				dw_mci_stop_dma(host);
@@ -1313,7 +1321,29 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				break;
 
 			set_bit(EVENT_XFER_COMPLETE, &host->completed_events);
+
+			/*
+			 * Handle an EVENT_DATA_ERROR that might have shown up
+			 * before the transfer completed.  This might not have
+			 * been caught by the check above because the interrupt
+			 * could have gone off between the previous check and
+			 * the check for transfer complete.
+			 *
+			 * Technically this ought not be needed assuming we
+			 * get a DATA_COMPLETE eventually (we'll notice the
+			 * error and end the request), but it shouldn't hurt.
+			 *
+			 * This has the advantage of sending the stop command.
+			 */
+			if (test_and_clear_bit(EVENT_DATA_ERROR,
+					       &host->pending_events)) {
+				dw_mci_stop_dma(host);
+				send_stop_abort(host, data);
+				state = STATE_DATA_ERROR;
+				break;
+			}
 			prev_state = state = STATE_DATA_BUSY;
+
 			/* fall through */
 
 		case STATE_DATA_BUSY:
@@ -1336,6 +1366,23 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				/* stop command for open-ended transfer*/
 				if (data->stop)
 					send_stop_abort(host, data);
+			} else {
+				/*
+				 * If we don't have a command complete now we'll
+				 * never get one since we just reset everything;
+				 * better end the request.
+				 *
+				 * If we do have a command complete we'll fall
+				 * through to the SENDING_STOP command and
+				 * everything will be peachy keen.
+				 *
+				 * TODO: I guess we shouldn't send a stop?
+				 */
+				if (!test_bit(EVENT_CMD_COMPLETE,
+					      &host->pending_events)) {
+					dw_mci_request_end(host, mrq);
+					goto unlock;
+				}
 			}
 
 			/*
-- 
1.7.10.4

