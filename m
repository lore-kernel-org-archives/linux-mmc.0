From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 17:34:53 +0530
Message-ID: <CAJuYYwQLUs5qb8NqtPf3=ytNHJ_VdnN8Z4yWwyk2+OTftdWFXw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <87y5l7421h.fsf@octavius.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 22 August 2012 16:38, Chris Ball <cjb@laptop.org> wrote:
> Hi Thomas,
>
> On Wed, Aug 22 2012, Thomas Abraham wrote:
>>> This matches Mitch's last suggestion exactly -- I think we're all agreed
>>> on these properties now.  The only remaining question is how to handle
>>> the pinctrl for CD in Thomas's case.
>>
>> Hi Chris,
>>
>> For sdhci-s3c driver, the 'broken-cd' and 'cd-gpios' bindings are
>> sufficient. But, are drivers free to use implementation specific
>> behavior when using these bindings. Or do we strictly adhere to the
>> table which Shawn has listed. For sdhci-s3c driver, I would like to
>> deviate from the "implication" column listed above.
>
> I'd rather you use the implications described above for the names
> described above; there's not much point in defining named behaviors
> across the subsystem if they're actually different in each driver.

Ok.

>
> But I think you can still use driver-internal properties that change the
> interpretation of those names in a documented way.  If the meaning of
> cd-gpios is modified when coupled with your "samsung,sdhci-cd-external",
> that's okay with me.  That should cover all the cases you need until you
> migrate to using pinctrl, right?  So, you could immediately support:
>
> none          -> currently "samsung,sdhci-cd-internal"
> broken-cd     -> currently "samsung,sdhci-cd-none"
> cd-gpios      -> currently "samsung,sdhci-cd-gpios"
> non-removable -> currently "samsung,sdhci-cd-permanent"
> cd-gpios + samsung,sdhci-cd-external -> currently "samsung,sdhci-cd-external"
>
> How does that sound?

Not quite there yet. It is not possible to leave out cd-gpios for
"samsung,sdhci-cd-internal" since the current Samsung pinmux
configuration piggybacks on gpio dt binding. Can we use the following
instead.

none               -> currently "samsung,sdhci-cd-none"
broken-cd        -> currently "samsung,sdhci-cd-none"
cd-gpios          -> currently "samsung,sdhci-cd-gpios"
non-removable -> currently "samsung,sdhci-cd-permanent"
cd-gpios + samsung,sdhci-cd-internal -> currently "samsung,sdhci-cd-internal"

Thanks Chris.

Regards,
Thomas.
