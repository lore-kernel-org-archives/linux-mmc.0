From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from
 fdt in sdhci-pltm.c
Date: Mon, 27 Apr 2015 21:25:20 +0530
Message-ID: <CAOHikRDX7RZUkHFUmNs0kY+aYqXra5i=3cukpjz5yOECkcffbQ@mail.gmail.com>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
	<8525627.D1S9aInyMV@wuerfel>
	<CAOHikRDkQwG+7EUddXmx427ZpEOjqTt22H_zzozABOE3a963tQ@mail.gmail.com>
	<5771531.b7UhrXUGmv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:56385 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932069AbbD0PzW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2015 11:55:22 -0400
Received: by widdi4 with SMTP id di4so105097707wid.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Apr 2015 08:55:20 -0700 (PDT)
In-Reply-To: <5771531.b7UhrXUGmv@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
> > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> > > index bef250e..9f6a4b9 100644
> > > --- a/drivers/mmc/host/sdhci-pltfm.c
> > > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > > @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
> > > *pdev)
> > >
> > >                 if (of_get_property(np, "broken-cd", NULL))
> > >                         host->quirks |=
> > >SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > >
> > > +
> > > +               if (of_get_property(np, "delay-after-power", NULL))
> > > +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> > > +
> > > +               if (of_get_property(np, "no-hispd", NULL))
> > > +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> > > +
> > > +               if (of_get_property(np, "broken-adma", NULL))
> > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > > +
> > > +               if (of_get_property(np, "broken-dma", NULL))
> > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > > +
> > > +               if (of_get_property(np, "no-cmd23", NULL))
> > > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> > >
> > >                 if (of_get_property(np, "no-1-8-v", NULL))
> > >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> >
> > Any property you add needs to be documented in the DT binding.
> > If possible, add generic properties for each bug you have mmc.txt
> > rather than the driver specific sdhci.txt, and implement the
> I will add the binding in mmc.txt. I thought this was present but not.
>
> > parsing in a common function that is used for all mmc hosts.
> As per mine understanding the sdhci_get_of_porperty is a common
> parsing function  . Am I wrong ??

No, this is only used for sdhci, not for the other controllers.

But our's is a SHCI variant so I added it in this file.

> > An alternative would be to set all these bits based on the compatible
> > string of your host, if that is the only one that has all these bugs.
>
> The host driver  (arasan) is reused but this quirks are needed due to
> board issues. so I have a control over dtb only to fix this.

What is the nature of the bug on that board? Is there a different
way to describe that without introducing six new properties?

Sorry it is board and IP as well SoC errata's,

1. Delay after power is required due to some voltage issues that will
be fixed in next board revision

2. We need to support PIO mode as of now because DMA or ADMA requires
some kind of translation driver that I am working on.

3. The version of arasan variant we have in our SoC doesn't have the
HISPD  bit field in HI-SPEED SD card. So this makes HI-SPEED sdcard
work.

4. NO_CMD23 is required for eMMC cards.

These are not new properties.  Only the fact is I am using it for our
SoC from dtb. These quirks are already there in mmc common framework.
Nothing is new.





On Mon, Apr 27, 2015 at 8:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
>> > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
>> > > index bef250e..9f6a4b9 100644
>> > > --- a/drivers/mmc/host/sdhci-pltfm.c
>> > > +++ b/drivers/mmc/host/sdhci-pltfm.c
>> > > @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
>> > > *pdev)
>> > >
>> > >                 if (of_get_property(np, "broken-cd", NULL))
>> > >                         host->quirks |=
>> > >SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> > >
>> > > +
>> > > +               if (of_get_property(np, "delay-after-power", NULL))
>> > > +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>> > > +
>> > > +               if (of_get_property(np, "no-hispd", NULL))
>> > > +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> > > +
>> > > +               if (of_get_property(np, "broken-adma", NULL))
>> > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>> > > +
>> > > +               if (of_get_property(np, "broken-dma", NULL))
>> > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>> > > +
>> > > +               if (of_get_property(np, "no-cmd23", NULL))
>> > > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>> > >
>> > >                 if (of_get_property(np, "no-1-8-v", NULL))
>> > >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>> >
>> > Any property you add needs to be documented in the DT binding.
>> > If possible, add generic properties for each bug you have mmc.txt
>> > rather than the driver specific sdhci.txt, and implement the
>> I will add the binding in mmc.txt. I thought this was present but not.
>>
>> > parsing in a common function that is used for all mmc hosts.
>> As per mine understanding the sdhci_get_of_porperty is a common
>> parsing function  . Am I wrong ??
>
> No, this is only used for sdhci, not for the other controllers.
>
>> > An alternative would be to set all these bits based on the compatible
>> > string of your host, if that is the only one that has all these bugs.
>>
>> The host driver  (arasan) is reused but this quirks are needed due to
>> board issues. so I have a control over dtb only to fix this.
>
> What is the nature of the bug on that board? Is there a different
> way to describe that without introducing six new properties?
>
>         Arnd



-- 
Thanks,
with regards,
Suman Tripathi
