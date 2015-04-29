From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from
 fdt in sdhci-pltm.c
Date: Wed, 29 Apr 2015 12:34:41 +0530
Message-ID: <CAOHikRAYtPt67-ZOFz890v46v28gtvQDPhgH1qA8d4xoSaQ7+Q@mail.gmail.com>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
	<5771531.b7UhrXUGmv@wuerfel>
	<CAOHikRDX7RZUkHFUmNs0kY+aYqXra5i=3cukpjz5yOECkcffbQ@mail.gmail.com>
	<6927395.c8hJ4o34f5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og122.obsmtp.com ([64.18.0.192]:60221 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753511AbbD2HEn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Apr 2015 03:04:43 -0400
Received: by wgso17 with SMTP id o17so17767922wgs.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2015 00:04:41 -0700 (PDT)
In-Reply-To: <6927395.c8hJ4o34f5@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

Hi Arnd,

Please ignore the previous reply.

On Tue, Apr 28, 2015 at 1:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 27 April 2015 21:25:20 Suman Tripathi wrote:
>> > On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
>> > > > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
>> > > > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>> > > > > +
>> > > > > +               if (of_get_property(np, "no-cmd23", NULL))
>> > > > > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>> > > > >
>> > > > >                 if (of_get_property(np, "no-1-8-v", NULL))
>> > > > >
>> > > > >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>> > > >
>> > > > Any property you add needs to be documented in the DT binding.
>> > > > If possible, add generic properties for each bug you have mmc.txt
>> > > > rather than the driver specific sdhci.txt, and implement the
>> > >
>> > > I will add the binding in mmc.txt. I thought this was present but not.
>> > >
>> > > > parsing in a common function that is used for all mmc hosts.
>> > >
>> > > As per mine understanding the sdhci_get_of_porperty is a common
>> > > parsing function  . Am I wrong ??
>>
>
> A small side note: please fix your email client to use proper attribution
> of the citations. The way you reply, nobody knows what you are saying
> compare to what you quote. Also, reduce the quotation to the parts you
> are replying to.
>

Okay. Sorry for that. I fixed it.

>> > No, this is only used for sdhci, not for the other controllers.
>>
>> But our's is a SHCI variant so I added it in this file.
>
> That's my point: a lot of the bugs are independent of the specific
> host controller and could happen with any one of them. We want to
> ensure that nobody tries to add another property with similar
> semantics and a different name just because they are using a
> different driver.

Then I am not finding a reason why we have sdhci_get_of_property function ?? .
 I added a generic names like broken-adma that everyone can reuse it.
I made mistake of not adding it in the binding.

For eg : broken-cd is not added by me but I can use it. So I added
something like broken-adma as it was not present.

>
>> > > An alternative would be to set all these bits based on the compatible
>> > > string of your host, if that is the only one that has all these bugs.
>> >
>> > The host driver  (arasan) is reused but this quirks are needed due to
>> > board issues. so I have a control over dtb only to fix this.
>>
>> What is the nature of the bug on that board? Is there a different
>> way to describe that without introducing six new properties?
>>
>> Sorry it is board and IP as well SoC errata's,
>>
>> 1. Delay after power is required due to some voltage issues that will
>> be fixed in next board revision
>
> This is clearly not sdhci-specific, so make that a generic property
> for all mmc.
>

Okay

>> 2. We need to support PIO mode as of now because DMA or ADMA requires
>> some kind of translation driver that I am working on.
>
> But this does not describe the hardware properties. Don't add properties
> that describe the lack of a kernel driver. If you can't do DMA yet,
> use a dma-ranges property that lists one empty range to prevent
> dma_set_mask() from working, so it will fall back to PIO mode. You
> may have to fix the driver if that doesn't already work.
>

The generic sdhc framework doesn't have this capabiltiy. It uses the
quirks to identify the broken DMA and ADMA modes even
if the controller is capable of.

> What kind of driver do you need here?

For DMA and adma we need some 32 bit to 64 bit translation driver.
The existing arasan driver only support 32 bit.

>
>> 3. The version of arasan variant we have in our SoC doesn't have the
>> HISPD  bit field in HI-SPEED SD card. So this makes HI-SPEED sdcard
>> work.
>>
>> 4. NO_CMD23 is required for eMMC cards.
>>
>> These are not new properties.  Only the fact is I am using it for our
>> SoC from dtb. These quirks are already there in mmc common framework.
>> Nothing is new.
>
> Are you sure that you have version 8.9a of the Arasan SDHCI? This sounds

No We are using 4.9a ARASAN SDHCI

> like version specific quirks, so they are probably present in each
> SoC that uses the same version.

Not sure

>
>         Arnd



-- 
Thanks,
with regards,
Suman Tripathi
