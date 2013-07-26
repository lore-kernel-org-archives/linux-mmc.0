From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 26 Jul 2013 10:27:25 -0500
Message-ID: <1374852445.20685.18.camel@linux-builds1>
References: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
	 <1374846562.3213.56.camel@hornet> <1374850185.20685.12.camel@linux-builds1>
	 <1374850802.3213.87.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:5425 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759075Ab3GZP1W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 11:27:22 -0400
In-Reply-To: <1374850802.3213.87.camel@hornet>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: "dinh.linux@gmail.com" <dinh.linux@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Mark Rutland <Mark.Rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 2013-07-26 at 16:00 +0100, Pawel Moll wrote:
> On Fri, 2013-07-26 at 15:49 +0100, Dinh Nguyen wrote:
> > Dinh please...
> 
> Uh, accept my apologies. I know exactly how it feels ;-)
> 
> > > I've also noticed that Exynos defines almost identical bindings:
> > > 
> > > > samsung,dw-mshc-ciu-div
> > > > samsung,dw-mshc-sdr-timing
> > > > samsung,dw-mshc-ddr-timing
> > 
> > Yes, I agree.
> > > 
> > > Aren't you both using the same "Synopsis Designware Mobile Storage Host
> > > Controller" by any chance? Are you sharing a driver? And if not,
> > > why? ;-) If the timings really must be parametrised, would it be
> > > possible to come up with a common set of "synopsis" properties, instead
> > > of "samsung" and "altr" ones? 
> > 
> > We are using the same driver. This is just a platform specifc entries
> > for how the IP can be implemented. I also agree that we can come up with
> > a shared set of properties for these.
> > 
> > But since the platform-driver part has already been picked into the
> > master tree, can I work on a common set after this patch? That way it
> > enables SD/MMC to work on SocFPGA for the time being.
> 
> Ah, I see. You should have included the binding documentation in the
> driver using the bindings, not in the patch adding the required nodes to
> DTS files... Than no one would have any comments on this patch ;-)
> 
> So yes, if the driver part got merged I will shut up now, providing you
> promise to work on "consolidating" the bindings for the next cycle. The
> sooner, the better. Does it sound like a deal?

Yes, you have my promise on the consolidating work! I was also thinking
the same thing when I enabled this for SOCFPGA, but since I don't have
any Exynos HW, I didn't have a way to test. But I will work on a patch
soon and send to the Exynos people to test.

Thanks,
Dinh
> 
> Pawel
> 
> 
> 



