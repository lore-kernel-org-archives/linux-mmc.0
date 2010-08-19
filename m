From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] mmc: USB SD Host Controller (USHC) driver
Date: Thu, 19 Aug 2010 13:55:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008191338270.622@xanadu.home>
References: <1282226936-3159-1-git-send-email-david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:47646 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab0HSRz2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2010 13:55:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L7E001AIV4ESO40@VL-MO-MR005.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 19 Aug 2010 13:55:26 -0400 (EDT)
In-reply-to: <1282226936-3159-1-git-send-email-david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

On Thu, 19 Aug 2010, David Vrabel wrote:

> Add a driver for USB SD Host Controller devices.  These devices are
> Cypress Astoria chips with firmware compliant with issue 2 of CSR's USHC
> specification.
> 
> Signed-off-by: David Vrabel <david.vrabel@csr.com>

Looks good from a quick glance. Some nits below.

> +config MMC_USHC
> +	tristate "USB SD Host Controller (USHC) support"
> +	depends on USB
> +	help
> +	  This selects support for USB SD Host Controllers based on
> +	  the Cypress Astoria chip with firmware compliant with CSR's
> +	  USB SD Host Controller specification (CS-118793-SP).
> +
> +	  CSR boards with this device include: USB<>SDIO (M1985v2),
> +	  and Ultrasira.
> +
> +	  Note: Version 2 devices only support SDIO cards/devices.

Do you mean that only the devices with version 2 do support SDIO, or 
that devices with version 2 support SDIO only?

> +	/* The Astoria's data FIFOs don't work with clock speeds < 5MHz so
> +	   limit commands with data to 6MHz or more. */
> +	if (req->data && ushc->clock_freq < 6000000) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
[...]
> +	mmc->f_min = 0;
> +	mmc->f_max = 50000000;

Why are you setting mmc->f_min to zero?  I understand that the 6000000 
limit is only for commands with data, but a limit of 0 is rather ... 
unusual.


Nicolas
