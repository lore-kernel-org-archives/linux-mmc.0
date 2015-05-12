From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND v6 1/2] arm64: dts: Add the arasan sdhci nodes in apm-storm.dtsi
Date: Tue, 12 May 2015 14:30:29 +0200
Message-ID: <CAPDyKFrY+UQETZy3cgtrS5UTGYLq6JyFsGXaNsAfg=9Eat6ooA@mail.gmail.com>
References: <1431333531-30491-1-git-send-email-stripathi@apm.com>
	<1431333531-30491-2-git-send-email-stripathi@apm.com>
	<CAOHikRAeOH5Pt4WZFk1C29dUytO7H0ox_dgq578oW19ue8Eb8Q@mail.gmail.com>
	<5446694.nHWK6QO1on@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5446694.nHWK6QO1on@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>, Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12 May 2015 at 09:28, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tuesday 12 May 2015 11:03:46 Suman Tripathi wrote:
>> > @@ -533,6 +567,15 @@
>> >                         interrupts = <0x0 0x4f 0x4>;
>> >                 };
>> >
>> > +               sdhci0: sdhci@1c000000 {
>> > +                       compatible = "arasan,sdhci-4.9a";
>> > +                       reg = <0x0 0x1c000000 0x0 0x100>;
>> > +                       interrupts = <0x0 0x49 0x4>;
>> > +                       dma-coherent;
>> > +                       clock-names = "clk_xin", "clk_ahb";
>> > +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
>> > +               };
>> > +
>> >                 phy1: phy@1f21a000 {
>> >                         compatible = "apm,xgene-phy";
>> >                         reg = <0x0 0x1f21a000 0x0 0x100>;
>> > --
>> > 1.8.2.1
>> >
>>
>> Can anyone from dt community review this patch ? I have changed the dts node
>> names from sdhc to sdhci as per Arnd, Michael comments .
>
> I was actually asking for it to be named 'mmc', not 'sdhci', because the
> name is supposed to indicate the purpose of the device, not the
> implementation. I realize that we are inconsistent here, just as with
> 'uart' vs 'serial', and that ePAPR does not define what to do.

Then we need a common name to address the following purposes: SD, MMC,
eMMC, SDIO.

>
> We should probably add something to Documentation/devicetree/bindings/mmc/mmc.txt
> about this topic and change all the dts files accordingly (unless there
> is a risk for regressions). At the moment, the mmc.txt file also includes
> an example with 'sdhci', not 'mmc'.
>

I am happy to change, as long as we can come up with something better.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
