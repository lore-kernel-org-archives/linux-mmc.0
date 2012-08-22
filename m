From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 10:54:36 -0400
Message-ID: <87393f3rkj.fsf@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com>
	<87pq6k46jg.fsf@octavius.laptop.org> <5033B0F0.7050506@gmail.com>
	<CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
	<20120822055151.GT24242@S2101-09.ap.freescale.net>
	<877gsr5iz1.fsf@octavius.laptop.org>
	<CAJuYYwQz00ZzB5MxRG66XEPZApAtS6bwJAafmw3b=7DD7u+Crg@mail.gmail.com>
	<87y5l7421h.fsf@octavius.laptop.org>
	<CAJuYYwQLUs5qb8NqtPf3=ytNHJ_VdnN8Z4yWwyk2+OTftdWFXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuYYwQLUs5qb8NqtPf3=ytNHJ_VdnN8Z4yWwyk2+OTftdWFXw@mail.gmail.com>
	(Thomas Abraham's message of "Wed, 22 Aug 2012 17:34:53 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,

On Wed, Aug 22 2012, Thomas Abraham wrote:
>> none          -> currently "samsung,sdhci-cd-internal"
>> broken-cd     -> currently "samsung,sdhci-cd-none"
>> cd-gpios      -> currently "samsung,sdhci-cd-gpios"
>> non-removable -> currently "samsung,sdhci-cd-permanent"
>> cd-gpios + samsung,sdhci-cd-external -> currently "samsung,sdhci-cd-external"
>>
>> How does that sound?
>
> Not quite there yet. It is not possible to leave out cd-gpios for
> "samsung,sdhci-cd-internal" since the current Samsung pinmux
> configuration piggybacks on gpio dt binding. Can we use the following
> instead.
>
> none               -> currently "samsung,sdhci-cd-none"
> broken-cd        -> currently "samsung,sdhci-cd-none"
> cd-gpios          -> currently "samsung,sdhci-cd-gpios"
> non-removable -> currently "samsung,sdhci-cd-permanent"
> cd-gpios + samsung,sdhci-cd-internal -> currently "samsung,sdhci-cd-internal"

I see.  Okay; unless anyone has better ideas, it sounds like you should
go ahead and do that -- with something like this in your binding docs:

"This binding differs from the core MMC binding by requiring a cd-gpios
property to be present to use internal card-detection.  If no cd-gpios
are present (and "non-removable" is missing) the driver will poll for
card-detection as if a "broken-cd" property was provided."

I'll send out the new core bindings doc shortly.  Finishing off another
thread -- the "samsung-sdhci.txt" name is okay.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
