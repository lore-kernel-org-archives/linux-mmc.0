From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Mon, 24 Jan 2011 16:43:17 +0000
Message-ID: <1295887397.1677.40.camel@apple-mac>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
	 <20101116150022.GA27726@void.printf.net>
	 <27884BED0E3C489C8849EE12A803F536@AN00536>
	 <m3oc9pnt6g.fsf@pullcord.laptop.org>
	 <4CE41BE3.1060806@elandigitalsystems.com>
	 <m3oc9n241c.fsf@pullcord.laptop.org>
	 <4CEA86D4.9050109@elandigitalsystems.com>
	 <1295607004.1816.6.camel@apple-mac>
	 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
	 <1295858946.1677.3.camel@apple-mac>
	 <alpine.LFD.2.00.1101240936260.8580@xanadu.home>
	 <1295881846.1677.9.camel@apple-mac>
	 <alpine.LFD.2.00.1101241051460.8580@xanadu.home>
	 <1295885309.1677.21.camel@apple-mac>
	 <alpine.LFD.2.00.1101241121520.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55603 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1AXQnb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 11:43:31 -0500
In-Reply-To: <alpine.LFD.2.00.1101241121520.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>

On Mon, 2011-01-24 at 11:28 -0500, Nicolas Pitre wrote:
> > I had assumed that for a module the global initialized variables were
> > loaded at module load. That then is a problem given that new devices
> > (and drivers) are appearing quite rapidly. I therefore do not understand
> > how the global initialized variables from an externally compiled kernel
> > module get added into the kernel image - does "depmod" do that?
> 
> Sorry... I don't follow you here.
> Nicolas

I obviously do not understand how the kernel build tools deal
with the global initialized variables, and at the present time
I have too many other priorities. But thanks for your explanation
which I partially understood (I think)

Tony Olech

