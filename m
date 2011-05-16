From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 1/6] mmc: vub300: Formatting cleanup.
Date: Sun, 15 May 2011 20:21:43 -0400
Message-ID: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:37127 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1EPATz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 May 2011 20:19:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>

This patch makes whitespace-only changes to vub300 to bring it more in
line with MMC/kernel codingstyle.  No difference in generated code.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/vub300.c |  372 ++++++++++++++++++++-------------------------
 1 files changed, 163 insertions(+), 209 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 5762709..04d445b 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -460,7 +460,7 @@ static void irqpoll_out_completed(struct urb *urb)
 	} else {
 		int ret;
 		unsigned int pipe =
-		    usb_rcvbulkpipe(vub300->udev, vub300->cmnd_res_ep);
+			usb_rcvbulkpipe(vub300->udev, vub300->cmnd_res_ep);
 		usb_fill_bulk_urb(vub300->command_res_urb, vub300->udev, pipe,
 				  &vub300->resp, sizeof(vub300->resp),
 				  irqpoll_res_completed, vub300);
@@ -476,9 +476,7 @@ static void irqpoll_out_completed(struct urb *urb)
 
 static void send_irqpoll(struct vub300_mmc_host *vub300)
 {
-	/*
-	 * cmd_mutex is held by vub300_pollwork_thread
-	 */
+	/* cmd_mutex is held by vub300_pollwork_thread */
 	int retval;
 	int timeout = 0xFFFF & (0x0001FFFF - firmware_irqpoll_timeout);
 	vub300->cmnd.poll.header_size = 22;
@@ -506,9 +504,9 @@ static void new_system_port_status(struct vub300_mmc_host *vub300)
 {
 	int old_card_present = vub300->card_present;
 	int new_card_present =
-	    (0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
+		(0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
 	vub300->read_only =
-	    (0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
+		(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	if (new_card_present && !old_card_present) {
 		dev_info(&vub300->udev->dev, "card just inserted\n");
 		vub300->card_present = 1;
@@ -532,10 +530,9 @@ static void __add_offloaded_reg_to_fifo(struct vub300_mmc_host *vub300,
 					struct offload_registers_access
 					*register_access, u8 func)
 {
-	u8 r = vub300->fn[func].offload_point +
-			vub300->fn[func].offload_count;
-	memcpy(&vub300->fn[func].reg[MAXREGMASK & r]
-	       , register_access, sizeof(struct offload_registers_access));
+	u8 r = vub300->fn[func].offload_point + vub300->fn[func].offload_count;
+	memcpy(&vub300->fn[func].reg[MAXREGMASK & r], register_access,
+	       sizeof(struct offload_registers_access));
 	vub300->fn[func].offload_count += 1;
 	vub300->total_offload_count += 1;
 }
@@ -550,9 +547,8 @@ static void add_offloaded_reg(struct vub300_mmc_host *vub300,
 	u8 regs = vub300->dynamic_register_count;
 	u8 i = 0;
 	while (0 < regs-- && 1 == vub300->sdio_register[i].activate) {
-		if ((vub300->sdio_register[i].func_num == func)
-		    && (vub300->sdio_register[i].sdio_reg == Register)
-		    ) {
+		if (vub300->sdio_register[i].func_num == func &&
+		    vub300->sdio_register[i].sdio_reg == Register) {
 			if (vub300->sdio_register[i].prepared == 0)
 				vub300->sdio_register[i].prepared = 1;
 			vub300->sdio_register[i].response =
@@ -576,21 +572,18 @@ static void check_vub300_port_status(struct vub300_mmc_host *vub300)
 	 */
 	int retval;
 	retval =
-	    usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
-			    GET_SYSTEM_PORT_STATUS,
-			    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			    0x0000, 0x0000, &vub300->system_port_status,
-			    sizeof(vub300->system_port_status), HZ);
+		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
+				GET_SYSTEM_PORT_STATUS,
+				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0x0000, 0x0000, &vub300->system_port_status,
+				sizeof(vub300->system_port_status), HZ);
 	if (sizeof(vub300->system_port_status) == retval)
 		new_system_port_status(vub300);
 }
 
 static void __vub300_irqpoll_response(struct vub300_mmc_host *vub300)
 {
-	/*
-	 * cmd_mutex is held by vub300_pollwork_thread
-	 */
-
+	/* cmd_mutex is held by vub300_pollwork_thread */
 	if (vub300->command_res_urb->actual_length == 0)
 		return;
 
@@ -662,15 +655,13 @@ static void __vub300_irqpoll_response(struct vub300_mmc_host *vub300)
 
 static void __do_poll(struct vub300_mmc_host *vub300)
 {
-	/*
-	 * cmd_mutex is held by vub300_pollwork_thread
-	 */
+	/* cmd_mutex is held by vub300_pollwork_thread */
 	long commretval;
 	mod_timer(&vub300->inactivity_timer, jiffies + HZ);
 	init_completion(&vub300->irqpoll_complete);
 	send_irqpoll(vub300);
 	commretval = wait_for_completion_timeout(&vub300->irqpoll_complete,
-					msecs_to_jiffies(500));
+						 msecs_to_jiffies(500));
 	if (vub300->usb_transport_fail) {
 		/* no need to do anything */
 	} else if (commretval == 0) {
@@ -690,7 +681,7 @@ static void __do_poll(struct vub300_mmc_host *vub300)
 static void vub300_pollwork_thread(struct work_struct *work)
 {				/* NOT irq */
 	struct vub300_mmc_host *vub300 = container_of(work,
-			struct vub300_mmc_host, pollwork.work);
+			      struct vub300_mmc_host, pollwork.work);
 	if (!vub300->interface) {
 		kref_put(&vub300->kref, vub300_delete);
 		return;
@@ -721,7 +712,7 @@ static void vub300_pollwork_thread(struct work_struct *work)
 static void vub300_deadwork_thread(struct work_struct *work)
 {				/* NOT irq */
 	struct vub300_mmc_host *vub300 =
-	    container_of(work, struct vub300_mmc_host, deadwork);
+		container_of(work, struct vub300_mmc_host, deadwork);
 	if (!vub300->interface) {
 		kref_put(&vub300->kref, vub300_delete);
 		return;
@@ -805,18 +796,14 @@ static void command_res_completed(struct urb *urb)
 {				/* urb completion handler - hardirq */
 	struct vub300_mmc_host *vub300 = (struct vub300_mmc_host *)urb->context;
 	if (urb->status) {
-		/*
-		 * we have to let the initiator handle the error
-		 */
+		/* we have to let the initiator handle the error */
 	} else if (vub300->command_res_urb->actual_length == 0) {
 		/*
 		 * we have seen this happen once or twice and
 		 * we suspect a buggy USB host controller
 		 */
 	} else if (!vub300->data) {
-		/*
-		 * this means that the command (typically CMD52) suceeded
-		 */
+		/* this means that the command (typically CMD52) suceeded */
 	} else if (vub300->resp.common.header_type != 0x02) {
 		/*
 		 * this is an error response from the VUB300 chip
@@ -824,11 +811,11 @@ static void command_res_completed(struct urb *urb)
 		 */
 	} else if (vub300->urb) {
 		vub300->cmd->error =
-		    vub300_response_error(vub300->resp.error.error_code);
+			vub300_response_error(vub300->resp.error.error_code);
 		usb_unlink_urb(vub300->urb);
 	} else {
 		vub300->cmd->error =
-		    vub300_response_error(vub300->resp.error.error_code);
+			vub300_response_error(vub300->resp.error.error_code);
 		usb_sg_cancel(&vub300->sg_request);
 	}
 	complete(&vub300->command_complete);	/* got_response_in */
@@ -842,7 +829,7 @@ static void command_out_completed(struct urb *urb)
 	} else {
 		int ret;
 		unsigned int pipe =
-		    usb_rcvbulkpipe(vub300->udev, vub300->cmnd_res_ep);
+			usb_rcvbulkpipe(vub300->udev, vub300->cmnd_res_ep);
 		usb_fill_bulk_urb(vub300->command_res_urb, vub300->udev, pipe,
 				  &vub300->resp, sizeof(vub300->resp),
 				  command_res_completed, vub300);
@@ -1119,31 +1106,31 @@ static void send_command(struct vub300_mmc_host *vub300)
 		int fn = 0x7 & (cmd->arg >> 28);
 		if (0x08 & vub300->cmnd.head.arguments[0]) { /* BLOCK MODE */
 			vub300->cmnd.head.block_count[0] =
-			    (data->blocks >> 8) & 0xFF;
+				(data->blocks >> 8) & 0xFF;
 			vub300->cmnd.head.block_count[1] =
-			    (data->blocks >> 0) & 0xFF;
+				(data->blocks >> 0) & 0xFF;
 			vub300->cmnd.head.block_size[0] =
-			    (data->blksz >> 8) & 0xFF;
+				(data->blksz >> 8) & 0xFF;
 			vub300->cmnd.head.block_size[1] =
-			    (data->blksz >> 0) & 0xFF;
+				(data->blksz >> 0) & 0xFF;
 		} else {	/* BYTE MODE */
 			vub300->cmnd.head.block_count[0] = 0;
 			vub300->cmnd.head.block_count[1] = 0;
 			vub300->cmnd.head.block_size[0] =
-			    (vub300->datasize >> 8) & 0xFF;
+				(vub300->datasize >> 8) & 0xFF;
 			vub300->cmnd.head.block_size[1] =
-			    (vub300->datasize >> 0) & 0xFF;
+				(vub300->datasize >> 0) & 0xFF;
 		}
 		vub300->cmnd.head.command_type =
-		    (MMC_DATA_READ & data->flags) ? 0x00 : 0x80;
+			(MMC_DATA_READ & data->flags) ? 0x00 : 0x80;
 		vub300->cmnd.head.transfer_size[0] =
-		    (vub300->datasize >> 24) & 0xFF;
+			(vub300->datasize >> 24) & 0xFF;
 		vub300->cmnd.head.transfer_size[1] =
-		    (vub300->datasize >> 16) & 0xFF;
+			(vub300->datasize >> 16) & 0xFF;
 		vub300->cmnd.head.transfer_size[2] =
-		    (vub300->datasize >> 8) & 0xFF;
+			(vub300->datasize >> 8) & 0xFF;
 		vub300->cmnd.head.transfer_size[3] =
-		    (vub300->datasize >> 0) & 0xFF;
+			(vub300->datasize >> 0) & 0xFF;
 		if (vub300->datasize < vub300->fbs[fn]) {
 			vub300->cmnd.head.block_count[0] = 0;
 			vub300->cmnd.head.block_count[1] = 0;
@@ -1154,30 +1141,29 @@ static void send_command(struct vub300_mmc_host *vub300)
 		vub300->cmnd.head.block_size[0] = (data->blksz >> 8) & 0xFF;
 		vub300->cmnd.head.block_size[1] = (data->blksz >> 0) & 0xFF;
 		vub300->cmnd.head.command_type =
-				(MMC_DATA_READ & data->flags) ? 0x00 : 0x80;
+			(MMC_DATA_READ & data->flags) ? 0x00 : 0x80;
 		vub300->cmnd.head.transfer_size[0] =
-				(vub300->datasize >> 24) & 0xFF;
+			(vub300->datasize >> 24) & 0xFF;
 		vub300->cmnd.head.transfer_size[1] =
-				(vub300->datasize >> 16) & 0xFF;
+			(vub300->datasize >> 16) & 0xFF;
 		vub300->cmnd.head.transfer_size[2] =
-				(vub300->datasize >> 8) & 0xFF;
+			(vub300->datasize >> 8) & 0xFF;
 		vub300->cmnd.head.transfer_size[3] =
-				(vub300->datasize >> 0) & 0xFF;
+			(vub300->datasize >> 0) & 0xFF;
 		if (vub300->datasize < vub300->fbs[0]) {
 			vub300->cmnd.head.block_count[0] = 0;
 			vub300->cmnd.head.block_count[1] = 0;
 		}
 	}
-	if (vub300->cmnd.head.block_size[0]
-	|| vub300->cmnd.head.block_size[1]) {
-		u16 block_size = vub300->cmnd.head.block_size[1]
-				| (vub300->cmnd.head.block_size[0] << 8);
+	if (vub300->cmnd.head.block_size[0] || vub300->cmnd.head.block_size[1]) {
+		u16 block_size = vub300->cmnd.head.block_size[1] |
+			(vub300->cmnd.head.block_size[0] << 8);
 		u16 block_boundary = FIRMWARE_BLOCK_BOUNDARY -
-				(FIRMWARE_BLOCK_BOUNDARY % block_size);
+			(FIRMWARE_BLOCK_BOUNDARY % block_size);
 		vub300->cmnd.head.block_boundary[0] =
-				(block_boundary >> 8) & 0xFF;
+			(block_boundary >> 8) & 0xFF;
 		vub300->cmnd.head.block_boundary[1] =
-				(block_boundary >> 0) & 0xFF;
+			(block_boundary >> 0) & 0xFF;
 	} else {
 		vub300->cmnd.head.block_boundary[0] = 0;
 		vub300->cmnd.head.block_boundary[1] = 0;
@@ -1257,12 +1243,12 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 			size -= interrupt_size;
 			data += interrupt_size;
 			retval =
-			    usb_control_msg(vub300->udev,
-					    usb_sndctrlpipe(vub300->udev, 0),
-					    SET_INTERRUPT_PSEUDOCODE,
-					    USB_DIR_OUT | USB_TYPE_VENDOR |
-					    USB_RECIP_DEVICE, 0x0000, 0x0000,
-					    xfer_buffer, xfer_length, HZ);
+				usb_control_msg(vub300->udev,
+						usb_sndctrlpipe(vub300->udev, 0),
+						SET_INTERRUPT_PSEUDOCODE,
+						USB_DIR_OUT | USB_TYPE_VENDOR |
+						USB_RECIP_DEVICE, 0x0000, 0x0000,
+						xfer_buffer, xfer_length, HZ);
 			kfree(xfer_buffer);
 			if (retval < 0) {
 				strncpy(vub300->vub_name,
@@ -1304,12 +1290,12 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 			size -= ts;
 			data += ts;
 			retval =
-			    usb_control_msg(vub300->udev,
-					    usb_sndctrlpipe(vub300->udev, 0),
-					    SET_TRANSFER_PSEUDOCODE,
-					    USB_DIR_OUT | USB_TYPE_VENDOR |
-					    USB_RECIP_DEVICE, 0x0000, 0x0000,
-					    xfer_buffer, xfer_length, HZ);
+				usb_control_msg(vub300->udev,
+						usb_sndctrlpipe(vub300->udev, 0),
+						SET_TRANSFER_PSEUDOCODE,
+						USB_DIR_OUT | USB_TYPE_VENDOR |
+						USB_RECIP_DEVICE, 0x0000, 0x0000,
+						xfer_buffer, xfer_length, HZ);
 			kfree(xfer_buffer);
 			if (retval < 0) {
 				strncpy(vub300->vub_name,
@@ -1460,8 +1446,8 @@ static int __command_read_data(struct vub300_mmc_host *vub300,
 	 */
 	int linear_length = vub300->datasize;
 	int padded_length = vub300->large_usb_packets ?
-	    ((511 + linear_length) >> 9) << 9 :
-	    ((63 + linear_length) >> 6) << 6;
+		((511 + linear_length) >> 9) << 9 :
+		((63 + linear_length) >> 6) << 6;
 	if ((padded_length == linear_length) || !pad_input_to_usb_pkt) {
 		int result;
 		unsigned pipe;
@@ -1477,8 +1463,8 @@ static int __command_read_data(struct vub300_mmc_host *vub300,
 			return 0;
 		} else {
 			vub300->sg_transfer_timer.expires =
-			    jiffies + msecs_to_jiffies(2000 +
-						       (linear_length / 16384));
+				jiffies + msecs_to_jiffies(2000 +
+						  (linear_length / 16384));
 			add_timer(&vub300->sg_transfer_timer);
 			usb_sg_wait(&vub300->sg_request);
 			del_timer(&vub300->sg_transfer_timer);
@@ -1495,13 +1481,12 @@ static int __command_read_data(struct vub300_mmc_host *vub300,
 		u8 *buf = kmalloc(padded_length, GFP_KERNEL);
 		if (buf) {
 			int result;
-			unsigned pipe =
-			    usb_rcvbulkpipe(vub300->udev, vub300->data_inp_ep);
+			unsigned pipe = usb_rcvbulkpipe(vub300->udev,
+							vub300->data_inp_ep);
 			int actual_length = 0;
-			result =
-			    vub300_usb_bulk_msg(vub300, pipe, buf,
-						padded_length, &actual_length,
-						2000 + (padded_length / 16384));
+			result = vub300_usb_bulk_msg(vub300, pipe, buf,
+					     padded_length, &actual_length,
+					     2000 + (padded_length / 16384));
 			if (result < 0) {
 				cmd->error = result;
 				data->bytes_xfered = 0;
@@ -1545,13 +1530,11 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 				  sizeof(vub300->padded_buffer));
 		memset(vub300->padded_buffer + linear_length, 0,
 		       sizeof(vub300->padded_buffer) - linear_length);
-		result =
-		    vub300_usb_bulk_msg(vub300, pipe, vub300->padded_buffer,
-					sizeof(vub300->padded_buffer),
-					&actual_length,
-					2000 +
-					(sizeof(vub300->padded_buffer) /
-					 16384));
+		result = vub300_usb_bulk_msg(vub300, pipe, vub300->padded_buffer,
+					     sizeof(vub300->padded_buffer),
+					     &actual_length, 2000 +
+					     (sizeof(vub300->padded_buffer) /
+					      16384));
 		if (result < 0) {
 			cmd->error = result;
 			data->bytes_xfered = 0;
@@ -1560,7 +1543,7 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 		}
 	} else if ((!vub300->large_usb_packets && (0 < modulo_64_length))
 		   || (vub300->large_usb_packets && (64 > modulo_512_length))
-	    ) {			/* don't you just love these work-rounds */
+		) {		/* don't you just love these work-rounds */
 		int padded_length = ((63 + linear_length) >> 6) << 6;
 		u8 *buf = kmalloc(padded_length, GFP_KERNEL);
 		if (buf) {
@@ -1571,9 +1554,9 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 			memset(buf + linear_length, 0,
 			       padded_length - linear_length);
 			result =
-			    vub300_usb_bulk_msg(vub300, pipe, buf,
-						padded_length, &actual_length,
-						2000 + padded_length / 16384);
+				vub300_usb_bulk_msg(vub300, pipe, buf,
+						    padded_length, &actual_length,
+						    2000 + padded_length / 16384);
 			kfree(buf);
 			if (result < 0) {
 				cmd->error = result;
@@ -1599,8 +1582,8 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 			data->bytes_xfered = 0;
 		} else {
 			vub300->sg_transfer_timer.expires =
-			    jiffies + msecs_to_jiffies(2000 +
-						       linear_length / 16384);
+				jiffies + msecs_to_jiffies(2000 +
+							   linear_length / 16384);
 			add_timer(&vub300->sg_transfer_timer);
 			usb_sg_wait(&vub300->sg_request);
 			if (cmd->error) {
@@ -1623,33 +1606,27 @@ static void __vub300_command_response(struct vub300_mmc_host *vub300,
 				      struct mmc_command *cmd,
 				      struct mmc_data *data, int data_length)
 {
-	/*
-	 * cmd_mutex is held by vub300_cmndwork_thread
-	 */
+	/* cmd_mutex is held by vub300_cmndwork_thread */
 	long respretval;
 	int msec_timeout = 1000 + data_length / 4;
 	respretval =
-	    wait_for_completion_timeout(&vub300->command_complete,
-					msecs_to_jiffies(msec_timeout));
+		wait_for_completion_timeout(&vub300->command_complete,
+					    msecs_to_jiffies(msec_timeout));
 	if (respretval == 0) { /* TIMED OUT */
-		/*
-		 * we don't know which of "out" and "res" if any failed
-		 */
+		/* we don't know which of "out" and "res" if any failed */
 		int result;
 		vub300->usb_timed_out = 1;
 		usb_kill_urb(vub300->command_out_urb);
 		usb_kill_urb(vub300->command_res_urb);
 		cmd->error = -ETIMEDOUT;
-		result =
-		    usb_lock_device_for_reset(vub300->udev, vub300->interface);
+		result = usb_lock_device_for_reset(vub300->udev,
+						   vub300->interface);
 		if (result == 0) {
 			result = usb_reset_device(vub300->udev);
 			usb_unlock_device(vub300->udev);
 		}
 	} else if (respretval < 0) {
-		/*
-		 * we don't know which of "out" and "res" if any failed
-		 */
+		/* we don't know which of "out" and "res" if any failed */
 		usb_kill_urb(vub300->command_out_urb);
 		usb_kill_urb(vub300->command_res_urb);
 		cmd->error = respretval;
@@ -1661,11 +1638,11 @@ static void __vub300_command_response(struct vub300_mmc_host *vub300,
 	} else if (vub300->command_out_urb->status) {
 		vub300->usb_transport_fail = vub300->command_out_urb->status;
 		cmd->error = -EPROTO == vub300->command_out_urb->status ?
-		    -ESHUTDOWN : vub300->command_out_urb->status;
+			-ESHUTDOWN : vub300->command_out_urb->status;
 	} else if (vub300->command_res_urb->status) {
 		vub300->usb_transport_fail = vub300->command_res_urb->status;
 		cmd->error = -EPROTO == vub300->command_res_urb->status ?
-		    -ESHUTDOWN : vub300->command_res_urb->status;
+			-ESHUTDOWN : vub300->command_res_urb->status;
 	} else if (vub300->resp.common.header_type == 0x00) {
 		/*
 		 * the command completed successfully
@@ -1673,13 +1650,13 @@ static void __vub300_command_response(struct vub300_mmc_host *vub300,
 		 */
 	} else if (vub300->resp.common.header_type == RESPONSE_ERROR) {
 		cmd->error =
-		    vub300_response_error(vub300->resp.error.error_code);
+			vub300_response_error(vub300->resp.error.error_code);
 		if (vub300->data)
 			usb_sg_cancel(&vub300->sg_request);
 	} else if (vub300->resp.common.header_type == RESPONSE_PIGGYBACKED) {
 		int offloaded_data_length =
-		    vub300->resp.common.header_size -
-		    sizeof(struct sd_register_header);
+			vub300->resp.common.header_size -
+			sizeof(struct sd_register_header);
 		int register_count = offloaded_data_length >> 3;
 		int ri = 0;
 		while (register_count--) {
@@ -1687,13 +1664,13 @@ static void __vub300_command_response(struct vub300_mmc_host *vub300,
 			ri += 1;
 		}
 		vub300->resp.common.header_size =
-		    sizeof(struct sd_register_header);
+			sizeof(struct sd_register_header);
 		vub300->resp.common.header_type = 0x00;
 		cmd->error = 0;
 	} else if (vub300->resp.common.header_type == RESPONSE_PIG_DISABLED) {
 		int offloaded_data_length =
-		    vub300->resp.common.header_size -
-		    sizeof(struct sd_register_header);
+			vub300->resp.common.header_size -
+			sizeof(struct sd_register_header);
 		int register_count = offloaded_data_length >> 3;
 		int ri = 0;
 		while (register_count--) {
@@ -1712,13 +1689,13 @@ static void __vub300_command_response(struct vub300_mmc_host *vub300,
 		vub300->irq_disabled = 1;
 		mutex_unlock(&vub300->irq_mutex);
 		vub300->resp.common.header_size =
-		    sizeof(struct sd_register_header);
+			sizeof(struct sd_register_header);
 		vub300->resp.common.header_type = 0x00;
 		cmd->error = 0;
 	} else if (vub300->resp.common.header_type == RESPONSE_PIG_ENABLED) {
 		int offloaded_data_length =
-		    vub300->resp.common.header_size -
-		    sizeof(struct sd_register_header);
+			vub300->resp.common.header_size -
+			sizeof(struct sd_register_header);
 		int register_count = offloaded_data_length >> 3;
 		int ri = 0;
 		while (register_count--) {
@@ -1755,32 +1732,29 @@ static void construct_request_response(struct vub300_mmc_host *vub300,
 	u8 *r = vub300->resp.response.command_response;
 	if (bytes == 3) {
 		cmd->resp[words] = (r[1 + (words << 2)] << 24)
-		    | (r[2 + (words << 2)] << 16)
-		    | (r[3 + (words << 2)] << 8);
+			| (r[2 + (words << 2)] << 16)
+			| (r[3 + (words << 2)] << 8);
 	} else if (bytes == 2) {
 		cmd->resp[words] = (r[1 + (words << 2)] << 24)
-		    | (r[2 + (words << 2)] << 16);
+			| (r[2 + (words << 2)] << 16);
 	} else if (bytes == 1) {
 		cmd->resp[words] = (r[1 + (words << 2)] << 24);
 	}
 	while (words-- > 0) {
 		cmd->resp[words] = (r[1 + (words << 2)] << 24)
-		    | (r[2 + (words << 2)] << 16)
-		    | (r[3 + (words << 2)] << 8)
-		    | (r[4 + (words << 2)] << 0);
+			| (r[2 + (words << 2)] << 16)
+			| (r[3 + (words << 2)] << 8)
+			| (r[4 + (words << 2)] << 0);
 	}
 	if ((cmd->opcode == 53) && (0x000000FF & cmd->resp[0]))
 		cmd->resp[0] &= 0xFFFFFF00;
 }
 
-/*
- * this thread runs only when there
- * is an upper level command req outstanding
- */
+/* this thread runs only when there is an upper level command req outstanding */
 static void vub300_cmndwork_thread(struct work_struct *work)
 {
 	struct vub300_mmc_host *vub300 =
-	    container_of(work, struct vub300_mmc_host, cmndwork);
+		container_of(work, struct vub300_mmc_host, cmndwork);
 	if (!vub300->interface) {
 		kref_put(&vub300->kref, vub300_delete);
 		return;
@@ -1837,26 +1811,23 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 static int examine_cyclic_buffer(struct vub300_mmc_host *vub300,
 				 struct mmc_command *cmd, u8 Function)
 {
-	/*
-	 * cmd_mutex is held by vub300_mmc_request
-	 */
+	/* cmd_mutex is held by vub300_mmc_request */
 	u8 cmd0 = 0xFF & (cmd->arg >> 24);
 	u8 cmd1 = 0xFF & (cmd->arg >> 16);
 	u8 cmd2 = 0xFF & (cmd->arg >> 8);
 	u8 cmd3 = 0xFF & (cmd->arg >> 0);
 	int first = MAXREGMASK & vub300->fn[Function].offload_point;
 	struct offload_registers_access *rf = &vub300->fn[Function].reg[first];
-	if (cmd0 == rf->command_byte[0]
-	    && cmd1 == rf->command_byte[1]
-	    && cmd2 == rf->command_byte[2]
-	    && cmd3 == rf->command_byte[3]
-	    ) {
+	if (cmd0 == rf->command_byte[0] &&
+	    cmd1 == rf->command_byte[1] &&
+	    cmd2 == rf->command_byte[2] &&
+	    cmd3 == rf->command_byte[3]) {
 		u8 checksum = 0x00;
 		cmd->resp[1] = checksum << 24;
 		cmd->resp[0] = (rf->Respond_Byte[0] << 24)
-		    | (rf->Respond_Byte[1] << 16)
-		    | (rf->Respond_Byte[2] << 8)
-		    | (rf->Respond_Byte[3] << 0);
+			| (rf->Respond_Byte[1] << 16)
+			| (rf->Respond_Byte[2] << 8)
+			| (rf->Respond_Byte[3] << 0);
 		vub300->fn[Function].offload_point += 1;
 		vub300->fn[Function].offload_count -= 1;
 		vub300->total_offload_count -= 1;
@@ -1868,18 +1839,17 @@ static int examine_cyclic_buffer(struct vub300_mmc_host *vub300,
 		while (0 < register_count) {
 			int point = MAXREGMASK & register_point;
 			struct offload_registers_access *r =
-			    &vub300->fn[Function].reg[point];
-			if (cmd0 == r->command_byte[0]
-			    && cmd1 == r->command_byte[1]
-			    && cmd2 == r->command_byte[2]
-			    && cmd3 == r->command_byte[3]
-			    ) {
+				&vub300->fn[Function].reg[point];
+			if (cmd0 == r->command_byte[0] &&
+			    cmd1 == r->command_byte[1] &&
+			    cmd2 == r->command_byte[2] &&
+			    cmd3 == r->command_byte[3]) {
 				u8 checksum = 0x00;
 				cmd->resp[1] = checksum << 24;
 				cmd->resp[0] = (r->Respond_Byte[0] << 24)
-				    | (r->Respond_Byte[1] << 16)
-				    | (r->Respond_Byte[2] << 8)
-				    | (r->Respond_Byte[3] << 0);
+					| (r->Respond_Byte[1] << 16)
+					| (r->Respond_Byte[2] << 8)
+					| (r->Respond_Byte[3] << 0);
 				vub300->fn[Function].offload_point += delta;
 				vub300->fn[Function].offload_count -= delta;
 				vub300->total_offload_count -= delta;
@@ -1898,17 +1868,14 @@ static int examine_cyclic_buffer(struct vub300_mmc_host *vub300,
 static int satisfy_request_from_offloaded_data(struct vub300_mmc_host *vub300,
 					       struct mmc_command *cmd)
 {
-	/*
-	 * cmd_mutex is held by vub300_mmc_request
-	 */
+	/* cmd_mutex is held by vub300_mmc_request */
 	u8 regs = vub300->dynamic_register_count;
 	u8 i = 0;
 	u8 func = FUN(cmd);
 	u32 reg = REG(cmd);
 	while (0 < regs--) {
-		if ((vub300->sdio_register[i].func_num == func)
-		    && (vub300->sdio_register[i].sdio_reg == reg)
-		    ) {
+		if ((vub300->sdio_register[i].func_num == func) &&
+		    (vub300->sdio_register[i].sdio_reg == reg)) {
 			if (!vub300->sdio_register[i].prepared) {
 				return 0;
 			} else if ((0x80000000 & cmd->arg) == 0x80000000) {
@@ -1927,9 +1894,9 @@ static int satisfy_request_from_offloaded_data(struct vub300_mmc_host *vub300,
 				vub300->sdio_register[i].prepared = 0;
 				cmd->resp[1] = checksum << 24;
 				cmd->resp[0] = (rsp0 << 24)
-				    | (rsp1 << 16)
-				    | (rsp2 << 8)
-				    | (rsp3 << 0);
+					| (rsp1 << 16)
+					| (rsp2 << 8)
+					| (rsp3 << 0);
 				return 1;
 			}
 		} else {
@@ -2038,10 +2005,10 @@ static void __set_clock_speed(struct vub300_mmc_host *vub300, u8 buf[8],
 		}
 	}
 	retval =
-	    usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
-			    SET_CLOCK_SPEED,
-			    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			    0x00, 0x00, buf, buf_array_size, HZ);
+		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
+				SET_CLOCK_SPEED,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0x00, 0x00, buf, buf_array_size, HZ);
 	if (retval != 8) {
 		dev_err(&vub300->udev->dev, "SET_CLOCK_SPEED"
 			" %dkHz failed with retval=%d\n", kHzClock, retval);
@@ -2060,23 +2027,17 @@ static void vub300_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	mutex_lock(&vub300->cmd_mutex);
 	if ((ios->power_mode == MMC_POWER_OFF) && vub300->card_powered) {
 		vub300->card_powered = 0;
-		usb_control_msg(vub300->udev,
-				    usb_sndctrlpipe(vub300->udev, 0),
-				    SET_SD_POWER,
-				    USB_DIR_OUT | USB_TYPE_VENDOR |
-				    USB_RECIP_DEVICE, 0x0000, 0x0000, NULL, 0,
-				    HZ);
-		/*
-		 * must wait for the VUB300 u-proc to boot up
-		 */
+		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
+				SET_SD_POWER,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0x0000, 0x0000, NULL, 0, HZ);
+		/* must wait for the VUB300 u-proc to boot up */
 		msleep(600);
 	} else if ((ios->power_mode == MMC_POWER_UP) && !vub300->card_powered) {
-		usb_control_msg(vub300->udev,
-				    usb_sndctrlpipe(vub300->udev, 0),
-				    SET_SD_POWER,
-				    USB_DIR_OUT | USB_TYPE_VENDOR |
-				    USB_RECIP_DEVICE, 0x0001, 0x0000, NULL, 0,
-				    HZ);
+		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
+				SET_SD_POWER,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0x0001, 0x0000, NULL, 0, HZ);
 		msleep(600);
 		vub300->card_powered = 1;
 	} else if (ios->power_mode == MMC_POWER_ON) {
@@ -2086,9 +2047,7 @@ static void vub300_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			kfree(buf);
 		}
 	} else {
-		/*
-		 * this should mean no change of state
-		 */
+		/* this should mean no change of state */
 	}
 	mutex_unlock(&vub300->cmd_mutex);
 	kref_put(&vub300->kref, vub300_delete);
@@ -2116,10 +2075,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
 			vub300->irq_enabled = 1;
 			vub300_queue_poll_work(vub300, 0);
 		} else if (vub300->irq_enabled) {
-			/*
-			 * this should not happen
-			 * so we will just ignore it
-			 */
+			/* this should not happen, so we will just ignore it */
 		} else {
 			vub300->irq_enabled = 1;
 			vub300_queue_poll_work(vub300, 0);
@@ -2292,7 +2248,7 @@ static int vub300_probe(struct usb_interface *interface,
 	iface_desc = interface->cur_altsetting;
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		struct usb_endpoint_descriptor *endpoint =
-		    &iface_desc->endpoint[i].desc;
+			&iface_desc->endpoint[i].desc;
 		dev_info(&vub300->udev->dev,
 			 "vub300 testing %s EndPoint(%d) %02X\n",
 			 usb_endpoint_is_bulk_in(endpoint) ? "BULK IN" :
@@ -2303,10 +2259,10 @@ static int vub300_probe(struct usb_interface *interface,
 		if (usb_endpoint_is_bulk_in(endpoint)) {
 			if (!vub300->cmnd_res_ep) {
 				vub300->cmnd_res_ep =
-				    endpoint->bEndpointAddress;
+					endpoint->bEndpointAddress;
 			} else if (!vub300->data_inp_ep) {
 				vub300->data_inp_ep =
-				    endpoint->bEndpointAddress;
+					endpoint->bEndpointAddress;
 			} else {
 				dev_warn(&vub300->udev->dev,
 					 "ignoring"
@@ -2315,10 +2271,10 @@ static int vub300_probe(struct usb_interface *interface,
 		} else if (usb_endpoint_is_bulk_out(endpoint)) {
 			if (!vub300->cmnd_out_ep) {
 				vub300->cmnd_out_ep =
-				    endpoint->bEndpointAddress;
+					endpoint->bEndpointAddress;
 			} else if (!vub300->data_out_ep) {
 				vub300->data_out_ep =
-				    endpoint->bEndpointAddress;
+					endpoint->bEndpointAddress;
 			} else {
 				dev_warn(&vub300->udev->dev,
 					 "ignoring"
@@ -2339,9 +2295,7 @@ static int vub300_probe(struct usb_interface *interface,
 			 vub300->large_usb_packets ? "LARGE" : "SMALL",
 			 vub300->cmnd_out_ep, vub300->cmnd_res_ep,
 			 vub300->data_out_ep, vub300->data_inp_ep);
-		/*
-		 * we have the expected EndPoints
-		 */
+		/* we have the expected EndPoints */
 	} else {
 		dev_err(&vub300->udev->dev,
 		    "Could not find two sets of bulk-in/out endpoint pairs\n");
@@ -2349,18 +2303,18 @@ static int vub300_probe(struct usb_interface *interface,
 		goto error5;
 	}
 	retval =
-	    usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
-			    GET_HC_INF0,
-			    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			    0x0000, 0x0000, &vub300->hc_info,
-			    sizeof(vub300->hc_info), HZ);
+		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
+				GET_HC_INF0,
+				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0x0000, 0x0000, &vub300->hc_info,
+				sizeof(vub300->hc_info), HZ);
 	if (retval < 0)
 		goto error5;
 	retval =
-	    usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
-			    SET_ROM_WAIT_STATES,
-			    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			    firmware_rom_wait_states, 0x0000, NULL, 0, HZ);
+		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
+				SET_ROM_WAIT_STATES,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				firmware_rom_wait_states, 0x0000, NULL, 0, HZ);
 	if (retval < 0)
 		goto error5;
 	dev_info(&vub300->udev->dev,
@@ -2371,18 +2325,18 @@ static int vub300_probe(struct usb_interface *interface,
 		 pad_input_to_usb_pkt ? "padding input data to" : "with",
 		 vub300->large_usb_packets ? 512 : 64);
 	retval =
-	    usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
-			    GET_SYSTEM_PORT_STATUS,
-			    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			    0x0000, 0x0000, &vub300->system_port_status,
-			    sizeof(vub300->system_port_status), HZ);
+		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
+				GET_SYSTEM_PORT_STATUS,
+				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0x0000, 0x0000, &vub300->system_port_status,
+				sizeof(vub300->system_port_status), HZ);
 	if (retval < 0) {
 		goto error4;
 	} else if (sizeof(vub300->system_port_status) == retval) {
 		vub300->card_present =
-		    (0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
+			(0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
 		vub300->read_only =
-		    (0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
+			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
 		goto error4;
 	}
-- 
1.7.0.1

