From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Thu, 23 Aug 2012 12:29:52 +0530
Message-ID: <CAJuYYwRDPU=m=XkYx8FPts=ar0pWyN7iTH5+6Kmb5KWMdT8pPg@mail.gmail.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org>
	<5033A34E.7040201@gmail.com>
	<87pq6k46jg.fsf@octavius.laptop.org>
	<5033B0F0.7050506@gmail.com>
	<CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
	<20120822055151.GT24242@S2101-09.ap.freescale.net>
	<877gsr5iz1.fsf@octavius.laptop.org>
	<CAJuYYwQz00ZzB5MxRG66XEPZApAtS6bwJAafmw3b=7DD7u+Crg@mail.gmail.com>
	<87y5l7421h.fsf@octavius.laptop.org>
	<CAJuYYwQLUs5qb8NqtPf3=ytNHJ_VdnN8Z4yWwyk2+OTftdWFXw@mail.gmail.com>
	<50351256.60507@firmworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56018 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261Ab2HWG7y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 02:59:54 -0400
Received: by lagy9 with SMTP id y9so248572lag.19
        for <linux-mmc@vger.kernel.org>; Wed, 22 Aug 2012 23:59:53 -0700 (PDT)
In-Reply-To: <50351256.60507@firmworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mitch Bradley <wmb@firmworks.com>
Cc: Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>

On 22 August 2012 22:39, Mitch Bradley <wmb@firmworks.com> wrote:
> Sorry to interject on a topic that seems to have already been decided,
> but I'm confused by one thing and would like clarification.  I
> understand that you need to use a GPIO-style specifier as a surrogate
> for a pinmux specification - that much is clear.  What is not clear is
> why it's necessary to (ab)use the name "cd-gpios" for it.
>
> Why not use a different property name, e.g. "samsung,cd-pinmux-gpio =
> <gpio-specifier>" for the "cd-gpios + samsung,sdhci-cd-internal" case?
> Then both "samsung,sdhci-cdi-internal" and "samsung,sdhci-cd-external"
> could go away.  There would only be one system-dependent property
> "samsung,cd-pinmux-gpio" whose name would make it clear that it's
> conflating pinmuxing and gpios.

Right, I agree. I will prepare the sdhci-s3c based on Chris's new
generic binding patch and your suggestion.

>
> I think the scheme I propose would be clearer, less likely to confuse
> other people who try to use the driver as a model, require less
> hand-waving in the documentation, and easier to change to a proper
> pinmuxing scheme should that become available later.

Thanks for your time.

Regards,
Thomas.
