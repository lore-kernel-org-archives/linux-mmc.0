From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c
Date: Wed, 29 Apr 2015 11:15:27 +0200
Message-ID: <17258495.kJWOqBBcrn@wuerfel>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com> <6927395.c8hJ4o34f5@wuerfel> <CAOHikRAYtPt67-ZOFz890v46v28gtvQDPhgH1qA8d4xoSaQ7+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54152 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031678AbbD2JPi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Apr 2015 05:15:38 -0400
In-Reply-To: <CAOHikRAYtPt67-ZOFz890v46v28gtvQDPhgH1qA8d4xoSaQ7+Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

On Wednesday 29 April 2015 12:34:41 Suman Tripathi wrote:
> On Tue, Apr 28, 2015 at 1:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 27 April 2015 21:25:20 Suman Tripathi wrote:
> >> > On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
> >> > > > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> >> > > > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> >> > > > > +
> >> > > > > +               if (of_get_property(np, "no-cmd23", NULL))
> >> > > > > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> >> > > > >
> >> > > > >                 if (of_get_property(np, "no-1-8-v", NULL))
> >> > > > >
> >> > > > >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> >> > > >
> >> > > > Any property you add needs to be documented in the DT binding.
> >> > > > If possible, add generic properties for each bug you have mmc.txt
> >> > > > rather than the driver specific sdhci.txt, and implement the
> >> > >
> >> > > I will add the binding in mmc.txt. I thought this was present but not.
> >> > >
> >> > > > parsing in a common function that is used for all mmc hosts.
> >> > >
> >> > > As per mine understanding the sdhci_get_of_porperty is a common
> >> > > parsing function  . Am I wrong ??
> >>
> >
> > A small side note: please fix your email client to use proper attribution
> > of the citations. The way you reply, nobody knows what you are saying
> > compare to what you quote. Also, reduce the quotation to the parts you
> > are replying to.
> >
> 
> Okay. Sorry for that. I fixed it.

Ok, much better.

> >> > No, this is only used for sdhci, not for the other controllers.
> >>
> >> But our's is a SHCI variant so I added it in this file.
> >
> > That's my point: a lot of the bugs are independent of the specific
> > host controller and could happen with any one of them. We want to
> > ensure that nobody tries to add another property with similar
> > semantics and a different name just because they are using a
> > different driver.
> 
> Then I am not finding a reason why we have sdhci_get_of_property function ?? .
>  I added a generic names like broken-adma that everyone can reuse it.
> I made mistake of not adding it in the binding.
> 
> For eg : broken-cd is not added by me but I can use it. So I added
> something like broken-adma as it was not present.

The common mmc_of_parse() handles "broken-cd", and the sdhci_get_of_property()
does so too. This is really a mistake we made earlier when it was added
to sdhi instead of the common code. We should remove the parsing for
that property from the sdhci driver and have the core handle it always,
but that require someone to do it and ensure that no subtle ABI changes
are introduced on the way.

For new properties, the right way is to add it to the common function only.

> >> 2. We need to support PIO mode as of now because DMA or ADMA requires
> >> some kind of translation driver that I am working on.
> >
> > But this does not describe the hardware properties. Don't add properties
> > that describe the lack of a kernel driver. If you can't do DMA yet,
> > use a dma-ranges property that lists one empty range to prevent
> > dma_set_mask() from working, so it will fall back to PIO mode. You
> > may have to fix the driver if that doesn't already work.
> >
> 
> The generic sdhc framework doesn't have this capabiltiy. It uses the
> quirks to identify the broken DMA and ADMA modes even
> if the controller is capable of.
> 
> > What kind of driver do you need here?
> 
> For DMA and adma we need some 32 bit to 64 bit translation driver.
> The existing arasan driver only support 32 bit.

Ok, that sounds like a very simple case: The width of the DMA is determined
from DT by looking at the dma-ranges properties. If it doesn't work, one
of these steps that are supposed to happen are broken and you should
try to find out which one that is and fix it:

- The parent node of the sdhci device in DT must not claim to support
  64 bit if the bus is only 32-bit wide. A dma-ranges property containing
  "<0 0 1 0>" would describe a bus that has a 32-bit DMA address range that
  is 1:1 mapped to the root bus, which is the default.

- The ARM64 code must check that property in a call to dma_set_mask()
  or dma_set_mask_and_coherent(), and not allow a mask to be set that
  exceeds the size of the dma-ranges property.

- The sdhci driver must call dma_set_mask() or dma_set_mask_and_coherent()
  with the mask that is claimed by the device (usually 32 bit or 64 bit)
  and check the result.

- If the call to dma_set_mask() for the 64-bit mask fails, the driver must
  fall back to using the 32-bit mask and not attempt to use the 64-bit
  DMA registers.

This is the behavior we require anyway, and if this all works, you don't
need the extra quirks.

The above assumes that the limitation is enforced by the bus (e.g. an
AHB bus can only do 32-bit DMA). It would be a little different if you
have a 64-bit AXI bus and the Arasan device itself is limited to 32-bit
independent of the width of the bus it is connected to. Can you find out
which of these two cases you have?

> >> 3. The version of arasan variant we have in our SoC doesn't have the
> >> HISPD  bit field in HI-SPEED SD card. So this makes HI-SPEED sdcard
> >> work.
> >>
> >> 4. NO_CMD23 is required for eMMC cards.
> >>
> >> These are not new properties.  Only the fact is I am using it for our
> >> SoC from dtb. These quirks are already there in mmc common framework.
> >> Nothing is new.
> >
> > Are you sure that you have version 8.9a of the Arasan SDHCI? This sounds
> 
> No We are using 4.9a ARASAN SDHCI

Ok, then add a compatible string for this version to the arasan binding,
and set the quirks flags only for the 4.9a version and not for the 8.9a
version.

	Arnd
