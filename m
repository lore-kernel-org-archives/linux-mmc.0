From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Tue, 25 Jan 2011 09:35:51 +0000
Message-ID: <1295948151.1898.2.camel@apple-mac>
References: <m3oc9pnt6g.fsf@pullcord.laptop.org>
	 <4CE41BE3.1060806@elandigitalsystems.com>
	 <m3oc9n241c.fsf@pullcord.laptop.org>
	 <4CEA86D4.9050109@elandigitalsystems.com>
	 <1295607004.1816.6.camel@apple-mac>
	 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
	 <20110122142112.GC15620@pengutronix.de>
	 <alpine.LFD.2.00.1101221405110.8580@xanadu.home>
	 <20110123100917.GB32578@pengutronix.de>
	 <1295886085.1677.32.camel@apple-mac> <20110125091317.GB2703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57201 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab1AYJgc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2011 04:36:32 -0500
In-Reply-To: <20110125091317.GB2703@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>

On Tue, 2011-01-25 at 10:13 +0100, Wolfram Sang wrote:
> > The intended use of the read-only sysfs file is to enable first-line
> > support staff to determine quickly what actual firmware file is being
> > used.
> You have that in the driver (and similar ones):
> +	dev_info(&vub300->udev->dev, "requesting offload firmware %s\n",
> +		 vub300->vub_name);
> Won't checking the logs do?
>    Wolfram

Nearly, but there is one crucial difference, the logs
are historic and the sysfs is current.

Tony Olech


