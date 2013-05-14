From: Simon Baatz <gmbnomis@gmail.com>
Subject: Re: [PATCH V2 00/10] mmc_of_parse() adaptations, DT support for
 Sheevaplugs
Date: Tue, 14 May 2013 18:26:52 +0200
Message-ID: <20130514162652.GA13801@schnuecks.de>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <Pine.LNX.4.64.1305140819520.32151@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:52421 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3ENQ0z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 12:26:55 -0400
Received: by mail-ee0-f48.google.com with SMTP id b47so467676eek.35
        for <linux-mmc@vger.kernel.org>; Tue, 14 May 2013 09:26:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1305140819520.32151@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Guennadi,

On Tue, May 14, 2013 at 08:37:47AM +0200, Guennadi Liakhovetski wrote:
> On Mon, 13 May 2013, Simon Baatz wrote:
> 
> > While adding DT support for the Sheevaplugs by Globalscale Technologies
> > (Kirkwood), it turned out that the DT binding of mvsdio lacked features to
> > properly support the hardware (active high/low of CD and WP pins could not
> > be described in DT).
> > 
> > This is standard functionality provided by the mmc_of_parse() helper
> > function.  However, mmc_of_parse() may allocate GPIO lines.  If the
> > allocation fails, it outputs an error, but does not return an error to its
> > caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.
> 
> Thanks for the patches. In principle I'm fine either way. It is a policy 
> decision IMHO. E.g. consider a situation. You have a DT with an SD-card 
> slot, where card-detection is performed by a GPIO. OTOH the same pin is 
> used on some other (optional) interface on the same board. If that other 
> competing interface is unused, the driver isn't loaded, you can use the 
> GPIO for card-detection. However, if that other interface is used, your 
> attempt to get the card-detect pin will fail, but you still can use the 
> interface in polling mode. No, I don't think this is a good example of 
> hardware design :) User experience would depend on driver probing order, 
> but in principle it is imaginable. So, with the current mmc_of_parse() 
> you're more tolerant. You get a warning in the log, but the interface 
> might still be usable. And if you're surprised why your write protection 
> status hasn't been properly detected - just look in the log.

Yes, there is value in both ways. As should be clear by now, I prefer
being more strict here :-).  But in the end, it is a policy decision
as you say.

There is also a "middle way" to split off the gpio allocation. This
has already been proposed in some other thread IIRC.

For example, split the current mmc_of_parse() into:

- mmc_of_parse(): Parses everything except the cd, wp gpios. It can't
  return an error and assumes sensible default values in case of a
  parse error (as it does today).

- mmc_of_gpio_cd(), mmc_of_gpio_wp(): Parses the cd/wp parts and
  requests the respective gpio (returning an error if that fails).

However, this means up to three calls instead of one in the
driver (and the respective error checking if needed).

On the other hand, it offers more flexibility: the driver can decide
whether to ignore the error, fall back to MMC_CAP_NEEDS_POLL or abort
the probe.

> You're proposing a change in behaviour. After your change any failure to 
> obtain a resource in mmc_of_parse() will fail interface probing. 
> Personally I don't think there are any users around, who would notice this 
> change, still, we have to be aware of it. And I don't know whether we 
> should do that. You know, we don't break user-space ;-)
> 
> So, technically I'm ok with the changes, but policy-wise I'm not sure how 
> severe this change would be. We could go a bit slower and first add a 
> return code as in your patch #1, but not fail drivers, like in your 
> patches #2, 3,... but WARN_ON(mmc_of_parse() < 0); and continue for now. 
> In 3.12 we could then replace those warnings with real failures. But maybe 
> I'm just overcautious and we can just go ahead with your patches. You can 
> add my
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> for patches 1-3, and let's see what Chris thinks about this change.

Thanks for the review and the ack! Of course, I am fine with a more
cautious way if that's required.

- Simon
