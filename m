From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
Date: Thu, 20 Jan 2011 16:11:25 +0000
Message-ID: <1295539885.9794.50.camel@apple-mac>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
	 <20101116150022.GA27726@void.printf.net>
	 <27884BED0E3C489C8849EE12A803F536@AN00536>
	 <m3oc9pnt6g.fsf@pullcord.laptop.org>
	 <4CE41BE3.1060806@elandigitalsystems.com>
	 <m3oc9n241c.fsf@pullcord.laptop.org>
	 <4CEA86D4.9050109@elandigitalsystems.com>  <4D25C0DA.4040204@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59155 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab1ATQLc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jan 2011 11:11:32 -0500
In-Reply-To: <4D25C0DA.4040204@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi,
the answers to your questions and comments are embedded below.
Because a few changes in the patch are required and also because
the current kernel version is now 2.6.27 I am re-doing the patch
and it will be included in a second e-mail by itself.

Tony Olech
Elan Digital Systems Limited

On Thu, 2011-01-06 at 13:17 +0000, David Vrabel wrote: 
> I've not given this driver a detailed review, just skimmed it and
> noticed a few things.
> Tony Olech wrote:
> > +	  Some SDIO cards will need a firmware file to be loaded and
> > +	  sent to VUB300 chip in order to achieve better data throughput.
> > +	  Download these "Offload Pseudocode" from Elan Digital Systems'
> > +	  web-site http://www.elandigitalsystems.com/support/downloads.php
> > +	  and put them in /lib/firmware. Note that without these additional
> > +	  firmware files the VUB300 chip will still function, but not at
> > +	  the best obtainable data rate.
> It would be useful to document (in the driver) what this "offload
> pseudocode" does.  Looking at the driver it looks like it's pre-fetching
> SDIO register values, yes?

Yes it does does pre-fetch and pre-set some register values.
At this point in time the only available documentation is
the interface document referred to in a previous e-mail which
can be downloaded from:
www.elandigitalsystems.com/eng/drivers/vub300/Linux-v2-10.zip

> > +#pragma pack(1)
> You probably want __attribute__((packed)) on each structure here.  (Not
> sure if GCC even supports this #pragma).

Thank you for this comment. I have changed the patch accordingly.

> > +static DEVICE_ATTR(OperatingMode, S_IRUGO, show_OperatingMode, NULL);
> > +static struct attribute *vub300_attrs[] = {
> > +	&dev_attr_OperatingMode.attr,
> > +	NULL,
> > +};
> Suggest removing this unless it's actually useful. If it is useful, it
> should use all lower case for the name and it should be documented in
> Documentation/ABI.

This sysfs interface is a very useful read-only diagnostic and
will enable us to support customers. In particular it identifies
the SDIO bus speed actually being used as well as the identity
of the offload pseudocode firmware file, if any, that has
been downloaded into the VUB300 adapter. I have modified the
patch to use lower case for the sysfs file name (even though
other sysfs users use camel case) and have added documentation
as requested.vub300->irqs_queued

> > +static void snoop_block_size_and_bus_width(struct vub300_mmc_host *vub300,
> > +					   u32 cmd_arg)
> This doesn't seem necessary.  The block size is available in the datavub300->irqs_queued
> request and the bus width is supplied to the set_ios() call.

Unfortunately you are incorrect in your assertion.
The "block size" given in the data request is NOT
ALWAYS equal to the function block size. Therefore
the snooping of the function block size must remain.

> > +		if (6 == cmd->opcode) {
> > +			ResponseType = SDRT_1;
> > +			vub300->resp_len = 6;
> You don't need to check the opcode to determine the response format. Seevub300->irqs_queued
> cmd->flags.

Unfortunately you are incorrect in your assertion.
It is impossible, for example, from a flag setting
of 0x15 to determine whether a response type of
R5, R6 or R7 is to be expected. Therefore the
snooping of the opcode must remain.

> > +static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
> > +{				/* NOT irq */
> > +	struct vub300_mmc_host *vub300 = mmc_priv(mmc);vub300->irqs_queued
> > +	if (!vub300->interface)
> > +		return;
> > +	kref_get(&vub300->kref);
> > +	if (enable) {vub300->irqs_queued
> > +		mutex_lock(&vub300->irq_mutex);
> > +		if (vub300->irqs_queued) {
> > +			vub300->irqs_queued -= 1;
> > +			mmc_signal_sdio_irq(vub300->mmc);
> This might signal a spurious interrupt as it's not checking if the
> interrupt is still asserted.  This should be avoided.

You are correct in your implied assertion that spurious
interrupts cause havoc and ultimately failure in the
operation of the device. However this code segment is
absolutely required for the correct operation of our
offload processing. The key thing to note is that the
variable vub300->irqs_queued prevents spurious interrupts.

> David



