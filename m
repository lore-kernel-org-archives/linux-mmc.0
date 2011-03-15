From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver Re-Resubmission
Date: Tue, 15 Mar 2011 11:06:47 -0400
Message-ID: <m3y64gqv7c.fsf@pullcord.laptop.org>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
	<20101116150022.GA27726@void.printf.net>
	<27884BED0E3C489C8849EE12A803F536@AN00536>
	<m3oc9pnt6g.fsf@pullcord.laptop.org>
	<4CE41BE3.1060806@elandigitalsystems.com>
	<m3oc9n241c.fsf@pullcord.laptop.org>
	<4CEA86D4.9050109@elandigitalsystems.com>
	<1295607004.1816.6.camel@apple-mac>
	<1299773604.1682.21.camel@apple-mac>
	<m37hc1rsrp.fsf@pullcord.laptop.org>
	<20110315094041.GA32015@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59227 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab1COPJb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Mar 2011 11:09:31 -0400
In-Reply-To: <20110315094041.GA32015@pengutronix.de> (Wolfram Sang's message
	of "Tue, 15 Mar 2011 10:40:41 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, linux-mmc@vger.kernel.org

Hi Wolfram,

On Tue, Mar 15 2011, Wolfram Sang wrote:
>> I'm leaning towards merging it as-is and then
>> working on incremental fixes; please yell if that sounds like a bad idea.
>
> What about staging? From my all overall impression, the driver would fit there.
> Also, there are more people lurking around fixing coding-style than here.

I thought about it, but I think staging drivers generally have a much
larger TODO list than this one would.

Perhaps a good plan is:  I'll push it to mmc-next after the 2.6.39 merge,
then I'll try to work on style changes a bit (I'll send each patch to the
list and Tony can ACK/NACK them), and then we can include it in 2.6.40
either as a normal driver if we're comfortable with how it's ended up,
or as a staging driver if we'd still like to get some more eyes on it.

Does that sound okay to everyone?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
