From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 6/6] mmc: vub300: clean up multiline conditionals
Date: Sun, 15 May 2011 20:21:48 -0400
Message-ID: <1305505308-8767-6-git-send-email-cjb@laptop.org>
References: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:37138 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1EPAT6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 May 2011 20:19:58 -0400
In-Reply-To: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>

Kernel coding style prefers the boolean operator to end the line.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/vub300.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 656d528..1b72329 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -730,8 +730,8 @@ static void vub300_deadwork_thread(struct work_struct *work)
 		 */
 	} else if (vub300->card_present) {
 		check_vub300_port_status(vub300);
-	} else if (vub300->mmc && vub300->mmc->card
-		   && mmc_card_present(vub300->mmc->card)) {
+	} else if (vub300->mmc && vub300->mmc->card &&
+		   mmc_card_present(vub300->mmc->card)) {
 		/*
 		 * the MMC core must not have responded
 		 * to the previous indication - lets
@@ -1542,8 +1542,8 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 		} else {
 			data->bytes_xfered = vub300->datasize;
 		}
-	} else if ((!vub300->large_usb_packets && (0 < modulo_64_length))
-		   || (vub300->large_usb_packets && (64 > modulo_512_length))
+	} else if ((!vub300->large_usb_packets && (0 < modulo_64_length)) ||
+		    (vub300->large_usb_packets && (64 > modulo_512_length))
 		) {		/* don't you just love these work-rounds */
 		int padded_length = ((63 + linear_length) >> 6) << 6;
 		u8 *buf = kmalloc(padded_length, GFP_KERNEL);
@@ -1766,9 +1766,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 		int data_length;
 		mutex_lock(&vub300->cmd_mutex);
 		init_completion(&vub300->command_complete);
-		if (likely(vub300->vub_name[0])
-		    || !vub300->mmc->card
-		    || !mmc_card_present(vub300->mmc->card)) {
+		if (likely(vub300->vub_name[0]) || !vub300->mmc->card ||
+		    !mmc_card_present(vub300->mmc->card)) {
 			/*
 			 * the name of the EMPTY Pseudo firmware file
 			 * is used as a flag to indicate that the file
@@ -1950,8 +1949,8 @@ static void vub300_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		 * for performance we have to return immediately
 		 * if the requested data has been offloaded
 		 */
-		if ((cmd->opcode == 52)
-		    && satisfy_request_from_offloaded_data(vub300, cmd)) {
+		if (cmd->opcode == 52 &&
+		    satisfy_request_from_offloaded_data(vub300, cmd)) {
 			cmd->error = 0;
 			mutex_unlock(&vub300->cmd_mutex);
 			kref_put(&vub300->kref, vub300_delete);
@@ -2284,9 +2283,8 @@ static int vub300_probe(struct usb_interface *interface,
 				 endpoint->bEndpointAddress);
 		}
 	}
-	if (vub300->cmnd_res_ep
-	    && vub300->cmnd_out_ep
-	    && vub300->data_inp_ep && vub300->data_out_ep) {
+	if (vub300->cmnd_res_ep && vub300->cmnd_out_ep &&
+	    vub300->data_inp_ep && vub300->data_out_ep) {
 		dev_info(&vub300->udev->dev,
 			 "vub300 %s packets"
 			 " using EndPoints %02X %02X %02X %02X\n",
-- 
1.7.0.1

