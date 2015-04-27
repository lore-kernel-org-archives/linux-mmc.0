From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c
Date: Mon, 27 Apr 2015 21:49:14 +0200
Message-ID: <6927395.c8hJ4o34f5@wuerfel>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com> <5771531.b7UhrXUGmv@wuerfel> <CAOHikRDX7RZUkHFUmNs0kY+aYqXra5i=3cukpjz5yOECkcffbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60167 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbbD0Tt0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2015 15:49:26 -0400
In-Reply-To: <CAOHikRDX7RZUkHFUmNs0kY+aYqXra5i=3cukpjz5yOECkcffbQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

On Monday 27 April 2015 21:25:20 Suman Tripathi wrote:
> > On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
> > > > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> > > > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > > > > +
> > > > > +               if (of_get_property(np, "no-cmd23", NULL))
> > > > > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> > > > > 
> > > > >                 if (of_get_property(np, "no-1-8-v", NULL))
> > > > >                 
> > > > >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> > > > 
> > > > Any property you add needs to be documented in the DT binding.
> > > > If possible, add generic properties for each bug you have mmc.txt
> > > > rather than the driver specific sdhci.txt, and implement the
> > > 
> > > I will add the binding in mmc.txt. I thought this was present but not.
> > > 
> > > > parsing in a common function that is used for all mmc hosts.
> > > 
> > > As per mine understanding the sdhci_get_of_porperty is a common
> > > parsing function  . Am I wrong ??
> 

A small side note: please fix your email client to use proper attribution
of the citations. The way you reply, nobody knows what you are saying
compare to what you quote. Also, reduce the quotation to the parts you
are replying to.

> > No, this is only used for sdhci, not for the other controllers.
> 
> But our's is a SHCI variant so I added it in this file.

That's my point: a lot of the bugs are independent of the specific
host controller and could happen with any one of them. We want to
ensure that nobody tries to add another property with similar
semantics and a different name just because they are using a
different driver.
 
> > > An alternative would be to set all these bits based on the compatible
> > > string of your host, if that is the only one that has all these bugs.
> >
> > The host driver  (arasan) is reused but this quirks are needed due to
> > board issues. so I have a control over dtb only to fix this.
> 
> What is the nature of the bug on that board? Is there a different
> way to describe that without introducing six new properties?
> 
> Sorry it is board and IP as well SoC errata's,
> 
> 1. Delay after power is required due to some voltage issues that will
> be fixed in next board revision

This is clearly not sdhci-specific, so make that a generic property
for all mmc.

> 2. We need to support PIO mode as of now because DMA or ADMA requires
> some kind of translation driver that I am working on.

But this does not describe the hardware properties. Don't add properties
that describe the lack of a kernel driver. If you can't do DMA yet,
use a dma-ranges property that lists one empty range to prevent
dma_set_mask() from working, so it will fall back to PIO mode. You
may have to fix the driver if that doesn't already work.

What kind of driver do you need here?

> 3. The version of arasan variant we have in our SoC doesn't have the
> HISPD  bit field in HI-SPEED SD card. So this makes HI-SPEED sdcard
> work.
> 
> 4. NO_CMD23 is required for eMMC cards.
> 
> These are not new properties.  Only the fact is I am using it for our
> SoC from dtb. These quirks are already there in mmc common framework.
> Nothing is new.

Are you sure that you have version 8.9a of the Arasan SDHCI? This sounds
like version specific quirks, so they are probably present in each
SoC that uses the same version.

	Arnd
