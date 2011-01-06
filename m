From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
Date: Thu, 06 Jan 2011 13:17:14 +0000
Message-ID: <4D25C0DA.4040204@csr.com>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>	<20101116150022.GA27726@void.printf.net>	<27884BED0E3C489C8849EE12A803F536@AN00536>	<m3oc9pnt6g.fsf@pullcord.laptop.org>	<4CE41BE3.1060806@elandigitalsystems.com> <m3oc9n241c.fsf@pullcord.laptop.org> <4CEA86D4.9050109@elandigitalsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:60471 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1AFN5u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2011 08:57:50 -0500
Received: from rly12d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly12d.srv.mailcontrol.com (MailControl) with ESMTP id p06DHVfq018830
	for <linux-mmc@vger.kernel.org>; Thu, 6 Jan 2011 13:17:32 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly12d.srv.mailcontrol.com (MailControl) id p06DHHtG015613
	for <linux-mmc@vger.kernel.org>; Thu, 6 Jan 2011 13:17:17 GMT
In-Reply-To: <4CEA86D4.9050109@elandigitalsystems.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony.olech@elandigitalsystems.com
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

I've not given this driver a detailed review, just skimmed it and
noticed a few things.

Tony Olech wrote:
> 
> +
> +	  Some SDIO cards will need a firmware file to be loaded and
> +	  sent to VUB300 chip in order to achieve better data throughput.
> +	  Download these "Offload Pseudocode" from Elan Digital Systems'
> +	  web-site http://www.elandigitalsystems.com/support/downloads.php
> +	  and put them in /lib/firmware. Note that without these additional
> +	  firmware files the VUB300 chip will still function, but not at
> +	  the best obtainable data rate.

It would be useful to document (in the driver) what this "offload
pseudocode" does.  Looking at the driver it looks like it's pre-fetching
SDIO register values, yes?

> +#pragma pack(1)

You probably want __attribute__((packed)) on each structure here.  (Not
sure if GCC even supports this #pragma).

> +static DEVICE_ATTR(OperatingMode, S_IRUGO, show_OperatingMode, NULL);
> +static struct attribute *vub300_attrs[] = {
> +	&dev_attr_OperatingMode.attr,
> +	NULL,
> +};

Suggest removing this unless it's actually useful. If it is useful, it
should use all lower case for the name and it should be documented in
Documentation/ABI.

> +static void snoop_block_size_and_bus_width(struct vub300_mmc_host *vub300,
> +					   u32 cmd_arg)

This doesn't seem necessary.  The block size is available in the data
request and the bus width is supplied to the set_ios() call.

> +		if (6 == cmd->opcode) {
> +			ResponseType = SDRT_1;
> +			vub300->resp_len = 6;

You don't need to check the opcode to determine the response format. See
cmd->flags.

> +
> +static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{				/* NOT irq */
> +	struct vub300_mmc_host *vub300 = mmc_priv(mmc);
> +	if (!vub300->interface)
> +		return;
> +	kref_get(&vub300->kref);
> +	if (enable) {
> +		mutex_lock(&vub300->irq_mutex);
> +		if (vub300->irqs_queued) {
> +			vub300->irqs_queued -= 1;
> +			mmc_signal_sdio_irq(vub300->mmc);

This might signal a spurious interrupt as it's not checking if the
interrupt is still asserted.  This should be avoided.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
