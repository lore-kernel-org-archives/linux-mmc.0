From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver Re-Resubmission
Date: Tue, 15 Mar 2011 17:23:32 +0100
Message-ID: <201103151723.32942.arnd@arndb.de>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536> <1295607004.1816.6.camel@apple-mac> <1299773604.1682.21.camel@apple-mac>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61667 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab1COQXj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 12:23:39 -0400
In-Reply-To: <1299773604.1682.21.camel@apple-mac>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thursday 10 March 2011, Tony Olech wrote:
>   Add a driver for Elan Digital System's VUB300 chip
> which is a USB connected SDIO/SDmem/MMC host controller.
> A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> computer to use SDIO/SD/MMC cards without the need for
> a directly connected, for example via PCI, SDIO host
> controller.

First a small question: I've read that USB mmc controllers
only work for SDIO but not for storage cards. Is that true
for this driver?

If not, I'd probably get one for card testing, since the
spring loading mechanism in my laptop is starting to wear
out.

What are typical products using this?

My comments are mostly for coding style, I didn't see any
major problems with the operation of the driver.

> +#include <linux/workqueue.h>
> +#include <linux/ctype.h>
> +#include <linux/firmware.h>
> +#include <linux/scatterlist.h>
> +struct HostController_Info {
> +       u8 Size;
> +       u16 FirmwareVer;
> +       u8 NumberOfPorts;
> +} __packed;
> +struct SD_Command_Header {
> +       u8 HeaderSize;
> +       u8 HeaderType;

Please insert empty lines between the definitions,
and use proper identifiers. In particular, don't
use CamelCase but lowercase with underscores like

struct host_controller_info;

> +       u8 PortNumber;
> +       u8 Command_Type; /* Bit7 - Rd/Wr */
> +       u8 CommandIndex;
> +       u8 TransferSize[4]; /* ReadSize + ReadSize */
> +       u8 ResponseType;
> +       u8 Arguments[4];
> +       u8 BlockCount[2];
> +       u8 BlockSize[2];
> +       u8 BlockBoundary[2];
> +       u8 Reserved[44]; /* to pad out to 64 bytes */
> +} __packed;

Don't use __packed for structures that are implicitly packed
already, or for structures that are not defined in hardware.
In this case, all members are u8, so __packed has no significance.

In other cases, it's better to mark only those members as packed
that are unaligned in hardware, instead of marking all of them.

Access to structures marked as __packed can be signficantly
slower on some architectures because gcc has to replace
them with bytewise access, even when they are in fact
aligned.

> +#define RESPONSE_INTERRUPT 0x01
> +#define RESPONSE_ERROR 0x02
> +#define RESPONSE_STATUS 0x03
> +#define RESPONSE_IRQ_DISABLED 0x05
> +#define RESPONSE_IRQ_ENABLED 0x06
> +#define RESPONSE_PIGGYBACKED 0x07

It would be more readable if you insert some tabs to
align the values, like

#define RESPONSE_INTERRUPT	0x01
#define RESPONSE_ERROR		0x02
#define RESPONSE_STATUS		0x03

> +static int limit_speed_to_24_MHz = INITIALIZE_VALUE_TO_ZERO;
> +module_param(limit_speed_to_24_MHz, bool, 0644);
> +MODULE_PARM_DESC(limit_speed_to_24_MHz, "Limit Max SDIO Clock Speed to 24 MHz");
> +static int pad_input_to_usb_pkt = INITIALIZE_VALUE_TO_ZERO;
> +module_param(pad_input_to_usb_pkt, bool, 0644);
> +MODULE_PARM_DESC(pad_input_to_usb_pkt,
> +                "Pad USB data input transfers to whole USB Packet");
> +static int disable_offload_processing = INITIALIZE_VALUE_TO_ZERO;
> +module_param(disable_offload_processing, bool, 0644);
> +MODULE_PARM_DESC(disable_offload_processing, "Disable Offload Processing");
> +static int force_1_bit_data_xfers = INITIALIZE_VALUE_TO_ZERO;
> +module_param(force_1_bit_data_xfers, bool, 0644);
> +MODULE_PARM_DESC(force_1_bit_data_xfers,
> +                "Force SDIO Data Transfers to 1-bit Mode");
> +static int force_polling_for_irqs = INITIALIZE_VALUE_TO_ZERO;
> +module_param(force_polling_for_irqs, bool, 0644);
> +MODULE_PARM_DESC(force_polling_for_irqs, "Force Polling for SDIO interrupts");
> +static int firmware_irqpoll_timeout = 1024;
> +module_param(firmware_irqpoll_timeout, int, 0644);
> +MODULE_PARM_DESC(firmware_irqpoll_timeout, "VUB300 firmware irqpoll timeout");
> +static int force_max_req_size = 128;
> +module_param(force_max_req_size, int, 0644);
> +MODULE_PARM_DESC(force_max_req_size, "set max request size in kBytes");
> +#ifdef SMSC_DEVELOPMENT_BOARD
> +static int firmware_rom_wait_states = 0x04;
> +#else
> +static int firmware_rom_wait_states = 0x1C;
> +#endif
> +module_param(firmware_rom_wait_states, bool, 0644);
> +MODULE_PARM_DESC(firmware_rom_wait_states,
> +                "ROM wait states byte=RRRIIEEE (Reserved Internal External)");

A lot of module parameters for a simple driver. I assume that some
of these were useful in debugging but could be removed now.

> +static struct workqueue_struct *cmndworkqueue;
> +static struct workqueue_struct *pollworkqueue;
> +static struct workqueue_struct *deadworkqueue;

Do you really need three separate workqueues? Note that you can
have different work_struct in the same queue.

> +       unsigned card_powered:1;
> +       unsigned card_present:1;
> +       unsigned read_only:1;
> +       unsigned large_usb_packets:1;
> +       unsigned app_spec:1; /* ApplicationSpecific */
> +       unsigned irq_enabled:1; /* by the MMC CORE */
> +       unsigned irq_disabled:1; /* in the firmware */
> +       unsigned bus_width:4;

Bit fields are normally discouraged, just use bool values
for flags, or a u8 for the bus_width.

> +static ssize_t __show_operating_mode(struct vub300_mmc_host *vub300,
> +                                   struct mmc_host *mmc, char *buf)
> +{
> +       int usb_packet_size = vub300->large_usb_packets ? 512 : 64;
> +       if (vub300->vub_name[0])
> +               return sprintf(buf, "VUB %s %s %d MHz %s %d byte USB packets"
> +                               " using %s\n",
> +                      (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
> +                      (mmc->caps & MMC_CAP_4_BIT_DATA) ? "4-bit" : "1-bit",
> +                      mmc->f_max / 1000000,
> +                      pad_input_to_usb_pkt ? "padding input data to" : "with",
> +                      usb_packet_size, vub300->vub_name);
> +       else
> +               return sprintf(buf, "VUB %s %s %d MHz %s %d byte USB packets"
> +                               " and no offload processing\n",
> +                      (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
> +                      (mmc->caps & MMC_CAP_4_BIT_DATA) ? "4-bit" : "1-bit",
> +                      mmc->f_max / 1000000,
> +                      pad_input_to_usb_pkt ? "padding input data to" : "with",
> +                      usb_packet_size);
> +}
> +
> +static ssize_t show_operating_mode(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
> +       if (mmc) {
> +               struct vub300_mmc_host *vub300 = mmc_priv(mmc);
> +               return __show_operating_mode(vub300, mmc, buf);
> +       } else {
> +               return sprintf(buf, "VUB driver has no attached device");
> +       }
> +}

This sysfs attribute is rather hard to parse from user space, it looks
like it's designed only to be read by humans. I think it would be better
to use multiple attributes, each of which has only a single piece
of information in it.

Some of these attributes however don't really belong into this driver
but into the core, like the 1-bit / 4-bit mode. Please leave this out
of your driver, and submit a separate patch to the mmc core if you
think it's reasonable.

> +static void vub300_queue_cmnd_work(struct vub300_mmc_host *vub300)
> +{
> +       kref_get(&vub300->kref);
> +       if (queue_work(cmndworkqueue, &vub300->cmndwork)) {
> +               /*
> +                * then the cmndworkqueue was not previously
> +                * running and the above get ref is obvious
> +                * required and will be put when the thread
> +                * terminates by a specific call
> +                */
> +       } else {
> +               /*
> +                * the cmndworkqueue was already running from
> +                * a previous invocation and thus to keep the
> +                * kref counts correct we must undo the get
> +                */
> +               kref_put(&vub300->kref, vub300_delete);
> +       }
> +}

You use the same kref_get/kref_put statement in a lot of
places, better encapsulate it in an inline function and make the
callers do

	vub300_get(vub300);
	...
	vub300_put(vub300);


> +       } else if (!new_card_present && old_card_present) {
> +               dev_info(&vub300->udev->dev, "card just ejected\n");
> +               vub300->card_present = 0;
> +               mmc_detect_change(vub300->mmc, 0);
> +               return;
> +       } else {
> +               return;
> +       }
> +}

The last else branch is redundant here.

> +static void __add_offloaded_reg_to_fifo(struct vub300_mmc_host *vub300,
> +                                       struct Offload_Registers_Access
> +                                       *register_access, u8 Function)
> +{
> +       u8 r =
> +           vub300->fn[Function].offload_point +
> +           vub300->fn[Function].offload_count;
> +       memcpy(&vub300->fn[Function].reg[MAXREGMASK & r]
> +              , register_access, sizeof(struct Offload_Registers_Access));
> +       vub300->fn[Function].offload_count += 1;
> +       vub300->total_offload_count += 1;
> +}

Just use a temporary variable:

	struct offload_interrupt_function_register *fn = &vub300->fn[Function];
	u8 r = fn->offload_point + fn.offload_count;
	...

> +static void __vub300_irqpoll_response(struct vub300_mmc_host *vub300)
> +{
> +       /*
> +        * cmd_mutex is held by vub300_pollwork_thread
> +        */
> +       if (0 == vub300->command_res_urb->actual_length) {

The common coding style is to write the variable name first and then
the value you are comparing with:

	if (vub300->command_res_urb->actual_length == 0)


> +       } else if (RESPONSE_INTERRUPT == vub300->resp.common.HeaderType) {
> +               mutex_lock(&vub300->irq_mutex);
> +               if (vub300->irq_enabled)
> +                       mmc_signal_sdio_irq(vub300->mmc);
> +               else
> +                       vub300->irqs_queued += 1;
> +               vub300->irq_disabled = 1;
> +               mutex_unlock(&vub300->irq_mutex);
> +               mutex_unlock(&vub300->cmd_mutex);
> +               kref_put(&vub300->kref, vub300_delete);
> +               return;
> +       } else if (RESPONSE_ERROR == vub300->resp.common.HeaderType) {
> +               if (SD_ERROR_NO_DEVICE == vub300->resp.error.ErrorCode)
> +                       check_vub300_port_status(vub300);
> +               mutex_unlock(&vub300->cmd_mutex);
> +               vub300_queue_poll_work(vub300, HZ);
> +               kref_put(&vub300->kref, vub300_delete);
> +               return;
> +       } else if (RESPONSE_STATUS == vub300->resp.common.HeaderType) {
> +               vub300->system_port_status = vub300->resp.status;
> +               new_system_port_status(vub300);
> +               mutex_unlock(&vub300->cmd_mutex);
> +               if (!vub300->card_present)
> +                       vub300_queue_poll_work(vub300, HZ / 5);
> +               kref_put(&vub300->kref, vub300_delete);
> +               return;

Better use a switch/case statement instead of lots of if/else. Also, don't
duplicate the cleanup path, instead do:

	switch (vub300->resp.common.HeaderType) {
	case RESPONSE_INTERRUPT:
		...
		break;
	case RESPONSE_ERROR:
		...
		break;
	case ...
		break;
	}
	mutex_unlock(&vub300->cmd_mutex);
	kref_put(&vub300->kref, vub300_delete);
	return;

Also, make sure that all functions have a matching number of
mutex_lock/mutex_unlock etc calls, to avoid confusing the readers.

> +/*
> + * the STUFF bits are masked out for the comparisons
> + */
> +static void snoop_block_size_and_bus_width(struct vub300_mmc_host *vub300,
> +                                          u32 cmd_arg)
> +{
> +       if (0x80022200 == (0xFBFFFE00 & cmd_arg))
> +               vub300->fbs[1] = (cmd_arg << 8) | (0x00FF & vub300->fbs[1]);
> +       else if (0x80022000 == (0xFBFFFE00 & cmd_arg))
> +               vub300->fbs[1] = (0xFF & cmd_arg) | (0xFF00 & vub300->fbs[1]);
> +       else if (0x80042200 == (0xFBFFFE00 & cmd_arg))
> +               vub300->fbs[2] = (cmd_arg << 8) | (0x00FF & vub300->fbs[2]);

switch/case again.

> +static void send_command(struct vub300_mmc_host *vub300)
> +{
> +       /*
> +        * cmd_mutex is held by vub300_cmndwork_thread
> +        */
> +       struct mmc_command *cmd = vub300->cmd;
> +       struct mmc_data *data = vub300->data;
> +       int retval;
> +       u8 ResponseType;
> +       if (vub300->app_spec) {
> +               if (6 == cmd->opcode) {
> +                       ResponseType = SDRT_1;
> +                       vub300->resp_len = 6;
> +                       if (0x00000000 == (0x00000003 & cmd->arg))
> +                               vub300->bus_width = 1;
> +                       else if (0x00000002 == (0x00000003 & cmd->arg))
> +                               vub300->bus_width = 4;
> +                       else
> +                               dev_err(&vub300->udev->dev,
> +                                       "unexpected ACMD6 bus_width=%d\n",
> +                                       0x00000003 & cmd->arg);
> +               } else if (13 == cmd->opcode) {
> +                       ResponseType = SDRT_1;
> +                       vub300->resp_len = 6;
> +               } else if (22 == cmd->opcode) {
> +                       ResponseType = SDRT_1;
> +                       vub300->resp_len = 6;
> +               } else if (23 == cmd->opcode) {
> +                       ResponseType = SDRT_1;
> +                       vub300->resp_len = 6;

and here. Also, this function is too long to be readable.

	Arnd
