From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 4/6] mmc: vub300: loop cleanup
Date: Sun, 15 May 2011 20:21:46 -0400
Message-ID: <1305505308-8767-4-git-send-email-cjb@laptop.org>
References: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:37134 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1EPAT4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 May 2011 20:19:56 -0400
In-Reply-To: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>

For loops that start with i=0, re-use a single counter int.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/vub300.c |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index ac2fa06..0463921 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -905,6 +905,7 @@ static void send_command(struct vub300_mmc_host *vub300)
 	struct mmc_command *cmd = vub300->cmd;
 	struct mmc_data *data = vub300->data;
 	int retval;
+	int i;
 	u8 response_type;
 	if (vub300->app_spec) {
 		switch (cmd->opcode) {
@@ -1014,14 +1015,11 @@ static void send_command(struct vub300_mmc_host *vub300)
 			vub300->resp_len = 0;
 			break;
 		case 16:
-		{
-			int i;
 			for (i = 0; i < ARRAY_SIZE(vub300->fbs); i++)
 				vub300->fbs[i] = 0xFFFF & cmd->arg;
 			response_type = SDRT_1;
 			vub300->resp_len = 6;
 			break;
-		}
 		case 17:
 		case 18:
 		case 24:
@@ -2215,33 +2213,30 @@ static int vub300_probe(struct usb_interface *interface,
 	vub300->command_res_urb = command_res_urb;
 	vub300->usb_timed_out = 0;
 	vub300->dynamic_register_count = 0;
-	{
-		int i;
-		for (i = 0; i < ARRAY_SIZE(vub300->fn); i++) {
-			vub300->fn[i].offload_point = 0;
-			vub300->fn[i].offload_count = 0;
-		}
+
+	for (i = 0; i < ARRAY_SIZE(vub300->fn); i++) {
+		vub300->fn[i].offload_point = 0;
+		vub300->fn[i].offload_count = 0;
 	}
+
 	vub300->total_offload_count = 0;
 	vub300->irq_enabled = 0;
 	vub300->irq_disabled = 0;
 	vub300->irqs_queued = 0;
-	{
-		int i;
-		for (i = 0; i < ARRAY_SIZE(vub300->sdio_register); i++)
-			vub300->sdio_register[i++].activate = 0;
-	}
+
+	for (i = 0; i < ARRAY_SIZE(vub300->sdio_register); i++)
+		vub300->sdio_register[i++].activate = 0;
+
 	vub300->udev = udev;
 	vub300->interface = interface;
 	vub300->cmnd_res_ep = 0;
 	vub300->cmnd_out_ep = 0;
 	vub300->data_inp_ep = 0;
 	vub300->data_out_ep = 0;
-	{
-		int i;
-		for (i = 0; i < ARRAY_SIZE(vub300->fbs); i++)
-			vub300->fbs[i] = 512;
-	}
+
+	for (i = 0; i < ARRAY_SIZE(vub300->fbs); i++)
+		vub300->fbs[i] = 512;
+
 	/*
 	 *      set up the endpoint information
 	 *
-- 
1.7.0.1

