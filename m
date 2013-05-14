From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V2 00/10] mmc_of_parse() adaptations, DT support for
 Sheevaplugs
Date: Tue, 14 May 2013 08:37:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305140819520.32151@axis700.grange>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54469 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab3ENGjH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 02:39:07 -0400
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Simon

On Mon, 13 May 2013, Simon Baatz wrote:

> While adding DT support for the Sheevaplugs by Globalscale Technologies
> (Kirkwood), it turned out that the DT binding of mvsdio lacked features to
> properly support the hardware (active high/low of CD and WP pins could not
> be described in DT).
> 
> This is standard functionality provided by the mmc_of_parse() helper
> function.  However, mmc_of_parse() may allocate GPIO lines.  If the
> allocation fails, it outputs an error, but does not return an error to its
> caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.

Thanks for the patches. In principle I'm fine either way. It is a policy 
decision IMHO. E.g. consider a situation. You have a DT with an SD-card 
slot, where card-detection is performed by a GPIO. OTOH the same pin is 
used on some other (optional) interface on the same board. If that other 
competing interface is unused, the driver isn't loaded, you can use the 
GPIO for card-detection. However, if that other interface is used, your 
attempt to get the card-detect pin will fail, but you still can use the 
interface in polling mode. No, I don't think this is a good example of 
hardware design :) User experience would depend on driver probing order, 
but in principle it is imaginable. So, with the current mmc_of_parse() 
you're more tolerant. You get a warning in the log, but the interface 
might still be usable. And if you're surprised why your write protection 
status hasn't been properly detected - just look in the log.

You're proposing a change in behaviour. After your change any failure to 
obtain a resource in mmc_of_parse() will fail interface probing. 
Personally I don't think there are any users around, who would notice this 
change, still, we have to be aware of it. And I don't know whether we 
should do that. You know, we don't break user-space ;-)

So, technically I'm ok with the changes, but policy-wise I'm not sure how 
severe this change would be. We could go a bit slower and first add a 
return code as in your patch #1, but not fail drivers, like in your 
patches #2, 3,... but WARN_ON(mmc_of_parse() < 0); and continue for now. 
In 3.12 we could then replace those warnings with real failures. But maybe 
I'm just overcautious and we can just go ahead with your patches. You can 
add my

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

for patches 1-3, and let's see what Chris thinks about this change.

Thanks
Guennadi

> The patch set is structured as follows:
> 
> 1   Adapt mmc_of_parse() to return errors
> 2-6 Handle errors in current drivers using mmc_of_parse() (compile tested
>     only)
> 7-8 Convert mvsdio and respective dts files to mmc_of_parse() (tested on
>     kirkwood)
> 9   Add dts files for (eSATA) Sheevaplug
> 10  Add DT support for (eSATA) Sheevaplug
> 
> 
> I could only test on an eSATA Sheevaplug. I found patches with
> different LEDs for the Sheevaplug.  Thus, I would highly appreciate if
> someone with the hardware could give this a spin on a non-eSATA
> version.  Some additional testing of the change detect and write
> protect behaviour for mvsdio can't hurt either.  I hope that there aren't
> board revisions with different CD/WP pins out there.
> 
> Simon Baatz (10):
>   mmc: return mmc_of_parse() errors to caller
>   mmc: sh_mmcif: handle mmc_of_parse() errors during probe
>   mmc: tmio-mmc: handle mmc_of_parse() errors during probe
>   mmc: mxcmmc: handle mmc_of_parse() errors during probe
>   mmc: sdhi-pxav3: handle mmc_of_parse() errors during probe
>   mmc: tegra: handle mmc_of_parse() errors during probe
>   ARM: mvebu: Use standard MMC binding for all users of mvsdio
>   mmc: mvsdio: use standard MMC device-tree binding parser
>     mmc_of_parse()
>   ARM: Kirkwood: Add dts files for Sheevaplug and eSATA Sheevaplug
>   ARM: Kirkwood: add DT support for Sheevaplug and Sheevaplug eSATA

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
