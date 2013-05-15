From: Simon Baatz <gmbnomis@gmail.com>
Subject: Re: [PATCH V2 00/10] mmc_of_parse() adaptations, DT support for
 Sheevaplugs
Date: Wed, 15 May 2013 21:42:29 +0200
Message-ID: <20130515194229.GA27459@schnuecks.de>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <Pine.LNX.4.64.1305140819520.32151@axis700.grange>
 <20130514162652.GA13801@schnuecks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:61684 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486Ab3EOTmd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 15:42:33 -0400
Received: by mail-ea0-f181.google.com with SMTP id a11so1247729eae.26
        for <linux-mmc@vger.kernel.org>; Wed, 15 May 2013 12:42:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130514162652.GA13801@schnuecks.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, May 14, 2013 at 06:26:52PM +0200, Simon Baatz wrote:
> On Tue, May 14, 2013 at 08:37:47AM +0200, Guennadi Liakhovetski wrote:
> > On Mon, 13 May 2013, Simon Baatz wrote:
> > 
> > > While adding DT support for the Sheevaplugs by Globalscale Technologies
> > > (Kirkwood), it turned out that the DT binding of mvsdio lacked features to
> > > properly support the hardware (active high/low of CD and WP pins could not
> > > be described in DT).
> > > 
> > > This is standard functionality provided by the mmc_of_parse() helper
> > > function.  However, mmc_of_parse() may allocate GPIO lines.  If the
> > > allocation fails, it outputs an error, but does not return an error to its
> > > caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.
> > 
> > Thanks for the patches. In principle I'm fine either way. It is a policy 
> > decision IMHO. E.g. consider a situation. You have a DT with an SD-card 
> > slot, where card-detection is performed by a GPIO. OTOH the same pin is 
> > used on some other (optional) interface on the same board. If that other 
> > competing interface is unused, the driver isn't loaded, you can use the 
> > GPIO for card-detection. However, if that other interface is used, your 
> > attempt to get the card-detect pin will fail, but you still can use the 
> > interface in polling mode. No, I don't think this is a good example of 
> > hardware design :) User experience would depend on driver probing order, 
> > but in principle it is imaginable. So, with the current mmc_of_parse() 
> > you're more tolerant. You get a warning in the log, but the interface 
> > might still be usable. And if you're surprised why your write protection 
> > status hasn't been properly detected - just look in the log.
> 
> Yes, there is value in both ways. As should be clear by now, I prefer
> being more strict here :-).  But in the end, it is a policy decision
> as you say.

I realized that I missed one use case: There are platforms on which a
driver may load earlier than the GPIO driver.  In this case,
EPROBE_DEFER can be used to retry the probe later.  Actually, mmci.c
is an example of such a driver.

Thus, when calling of_get_named_gpio_flags() in mmc_of_parse(), we
need to check for EPROBE_DEFER and return that to the caller. I will
update the patch accordingly.

- Simon
