From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
Date: Tue, 31 May 2016 08:58:08 +0800
Message-ID: <20160531005808.GA7913@shlinux2>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <20160505224240.GA31429@rob-hp-laptop>
 <CAPDyKFqpoi03Egfuvd8qJXnn_+FBgPXAb7S4UvkxVs8BA+zwnA@mail.gmail.com>
 <20160509181829.GA19687@rob-hp-laptop>
 <CAPDyKFq2=mqujFjvJSYxg2nVmK=OrBKLtFfb-ErNJO3Zr_LMVw@mail.gmail.com>
 <20160528033613.GA3291@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34654 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161729AbcEaBDe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2016 21:03:34 -0400
Content-Disposition: inline
In-Reply-To: <20160528033613.GA3291@shlinux2>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-usb@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, hverkuil@xs4all.nl, tjakobi@math.uni-bielefeld.de, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>

On Sat, May 28, 2016 at 11:36:13AM +0800, Peter Chen wrote:
> On Tue, May 10, 2016 at 01:02:08PM +0200, Ulf Hansson wrote:
> > + Arnd
> > 
> > [...]
> > 
> > >> >> Solution
> > >> >> ========
> > >> >> This is very similar to the MMC pwrseq behavior so the idea is to:
> > >> >> 1. Move MMC pwrseq drivers to generic place,
> > >> >
> > >> > You can do that, but I'm going to NAK any use of pwrseq bindings outside
> > >> > of MMC. I think it is the wrong way to do things. The DT should describe
> > >>
> > >> Huh, I didn't know that was your view of the mmc pwrseq bindings. Why
> > >> didn't you NAK them before?
> > >
> > > Unfortunately, either I missed it or it was a time I couldn't spend much
> > > time on reviews.
> > 
> > Okay, I guess it's common issue among maintainers. The problem with DT
> > is that it gets really hard to be fixed up later. :-)
> > 
> > >
> > >> > the devices. If they happen to be "simple" then the core can walk the
> > >> > tree and do any setup. For example, look for "reset-gpios" and toggle
> > >> > that GPIO. There is no need for a special node.
> > >> >
> > >> >> 2. Extend the pwrseq-simple with regulator toggling,
> > >> >> 3. Add support to USB hub and port core for pwrseq,
> > >> >
> > >> > We discussed this for USB already[1] and is why we defined how to add
> > >> > USB child devices. The idea is not to add pwrseq to that.
> > >>
> > >> I am not familiar with the USB discussion.
> > >>
> > >> Still, let me give you some more background to the mmc pwrseq. The
> > >> idea from the mmc pwrseq bindings comes from the power-domain DT
> > >> bindings, as I thought these things were a bit related.
> > >> In both cases they are not directly a property of the device, but more
> > >> describing a HW dependency to allow the device to work.
> > >
> > > I could see this as a board level power domain. However the difference
> > > is we are not generally exposing internal SOC details the same way as
> > > board level components. Perhaps we could extend power domains to board
> > > level, but that is not what was done here.
> > >
> > >> One could probably use a child node instead of a phandle, but that
> > >> wasn't chosen back then. Of course you are the DT expert, but could
> > >> you perhaps tell me why a child node is better for cases like this?
> > >
> > > If there is a control path hierarchy, then we try to model that in DT
> > > with child nodes. In cases of SDIO and USB, there is a clear hierarchy.
> > > Ignoring the discovery ordering problem, we already have defined ways to
> > > describe GPIO connections, regulators, etc. to devices. Describing those
> > > things separately from the device to solve a particular issue that is
> > > really a kernel limitation is what I don't like.
> > 
> > Okay, I see.
> > 
> > To move forward in trying to make mmc pwrseq a generic pwrseq, could
> > we perhaps allow both cases?
> > 
> > In the mmc case, there are already deployed bindings so we need to
> > cope with these by using the phandle option, but for USB etc we could
> > force the child node option.
> > As long as we agree that we keep using a compatible string for the
> > child node as well, both options should be able to co-exist and we
> > should probably be able to managed them both from a common pwrseq
> > driver framework.
> > 
> > Although, I do remember from an older conversations around some of
> > mine submission for the mmc pwrseq code, that some people (maybe
> > Arnd?) wasn't keen on adding a new framework for this. Perhaps that
> > has changed?
> > 
> 
> All, how we move on for this?
> 
> 1. Using a generic driver to manage both mmc and USB (and further
> subsystem), USB and further subsystem do not use pwrseq node in dts.
> 2. USB creates the similar driver under drivers/usb for its own use. 
> 
> Which one do you prefer, thanks.
> 

Hi Krzysztof Kozlowski,

I think option 1 may be better according to Rob and Ulf's comment.
Would you like going on your patch set? You can work on generic pwrseq
driver, I will do USB stuffs based on generic pwrseq driver?

-- 

Best Regards,
Peter Chen
