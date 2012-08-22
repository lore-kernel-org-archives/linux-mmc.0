From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 14:00:32 +0800
Message-ID: <20120822060030.GU24242@S2101-09.ap.freescale.net>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
 <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
 <87k3ws5uhs.fsf@octavius.laptop.org>
 <201208211208.49987.arnd@arndb.de>
 <87393g5mic.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59573 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007Ab2HVGAJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 02:00:09 -0400
Received: by pbbrr13 with SMTP id rr13so991699pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Aug 2012 23:00:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87393g5mic.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>

On Tue, Aug 21, 2012 at 10:48:43AM -0400, Chris Ball wrote:
> Aside: the bindings do not match the code.  The bindings document says
> to use "fsl,cd-internal", and imx51-babbage.dts does so -- but the code
> doesn't check for "fsl,cd-internal", it checks for "fsl,cd-controller":
> 
>         if (of_get_property(np, "fsl,cd-controller", NULL))
>                 boarddata->cd_type = ESDHC_CD_CONTROLLER;
> 
> The same confusion is present for fsl,wp-{controller,internal}.
> 
Thanks for spotting it.  I will submit a patch to fix binding doc and
dts.

> Ignoring that, these bindings are similar, but not the same -- imx-esdhc
> only allows one of the cd_type cases to be true, so you either have
> cd-internal or you have cd-gpios:
> 
>         if (of_get_property(np, "fsl,cd-controller", NULL))
>                 boarddata->cd_type = ESDHC_CD_CONTROLLER;
> 
>         boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
>         if (gpio_is_valid(boarddata->cd_gpio))
>                 boarddata->cd_type = ESDHC_CD_GPIO;
> 
> This differs from Thomas's binding -- he wants a way to say "the cd-gpio
> mentioned in cd-gpios is [internal/external] to the card's CD pin".
> 
> Rob Herring said:
> > This makes the most sense to me. However, I prefer broken-cd over
> > cd-internal. The binding should add properties for exceptions, not SDHCI
> > spec compliant implementations.
> 
> Agreed, I was going to say the same thing.  Putting it all together, it
> sounds like we want:
> 
> no extra properties:  the CD pin on the host just works.
> broken-cd:            the CD pin on the host is broken; use polling.
> cd-gpios:             the GPIO listed is the CD pin on the host being
>                       brought out directly to a GPIO.
> cd-external:          when used with cd-gpios, specifies that the GPIO
>                       in cd-gpios is external to the CD pin on the host.
> 
> cd-gpios and cd-external can be present on the same node.  if broken-cd
> is present, it must be the only one of these nodes used.
> 
> Shawn, I guess I'll leave it up to you on whether/when you'd like to
> move away from the "fsl," properties to the new common ones?
> 
Ok, I will move to the common one once it appears on your tree.

-- 
Regards,
Shawn
