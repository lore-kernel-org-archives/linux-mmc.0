From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq handler
Date: Wed, 19 Feb 2014 16:25:12 +0530
Message-ID: <CAKohpokBf_fJhiUJ53c+=6v+GMcjaDKd7+fwib99=sLMdkjQQQ@mail.gmail.com>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
	<E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
	<20140218175703.GJ21483@n2100.arm.linux.org.uk>
	<CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
	<20140219094322.GR21483@n2100.arm.linux.org.uk>
	<CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
	<20140219095212.GT21483@n2100.arm.linux.org.uk>
	<CAKohpo=ZrLRsTyCH86x7TbGE2XJnpXNb1ZDvYyzDUupAwTtS9Q@mail.gmail.com>
	<20140219105011.GU21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:42975 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbaBSKzN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2014 05:55:13 -0500
Received: by mail-ob0-f169.google.com with SMTP id wo20so208742obc.28
        for <linux-mmc@vger.kernel.org>; Wed, 19 Feb 2014 02:55:12 -0800 (PST)
In-Reply-To: <20140219105011.GU21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pratyush Anand <pratyush.anand@st.com>, spear-devel <spear-devel@list.st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

Thanks for removing my ST email id from this mail, I was about to do that
this time :)

On 19 February 2014 16:20, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 19, 2014 at 03:39:35PM +0530, Viresh Kumar wrote:

>> I didn't get that completely here.. sorry completely out of touch on
>> this driver.
>> The power GPIO here is controlling the power to card socket. Once the card
>> is inserted, we need to enable power to the socket so that controller can
>> read back information from card.
>
> Yes, and how is this different from any other implementation where power
> to the socket is controlled?
>
> This is what happens:
> - You detect a card insertion/removal event
> - You tell the mmc core about it via mmc_detect_change()
> - The mmc core looks at the current state, and if the socket is powered down,
>   it first goes through the power up sequence:
>   - Apply power to the socket
>     (a call to set_ios with MMC_POWER_UP and zero clock)
>   - Apply clock to the socket
>     (a call to set_ios with MMC_POWER_ON and non-zero clock)
>   - Wait 74 clock cycles (as required by the spec)
> - Start the detection by sending commands to the cards
> - If no cards are detected, power down the socket

Okay, that's all we need then..

>> And this set_ios callback is not available to drivers above sdhci.c, i.e.
>> glues like sdhci-pltfm or spear.. so, how we can we get that back in
>> sdhci-spear.c?
>
> This is the crux of the issue which this patch set tries to address.  sdhci
> has become - as I've now described it several times - "a patchwork quilt of
> hacks all cooperating to give the impression of a working driver".

Being honest, I haven't had a in depth look of your patchset. Was really busy
with some other stuff..

> This is just another such hack, because rather than fixing sdhci.c properly,
> you've hacked around it, thereby making sdhci.c worse.
>
> What you could have done is turned the power control code in sdhci.c into
> a library function, and sdhci_do_set_ios() calls a method in the sdhci_ops
> to control the power.  What this means is that:
>
> - if you use the standard sdhci power control support, then you can just
>   hook the standard function in there.
> - if you need to do something extra, you can place your function there
>   to do your own stuff, and call the standard function to do the standard
>   bits.
> - if you don't need the standard functionality, then you can handle the
>   power control entirely within your driver.
>
> Not only does this result in a much cleaner implementation, it means that
> going forward, any other such quirky stuff can be handled in the same way
> by the "glues" rather than having to augment the horrid quirk/quirk2 stuff,
> or coming up with hacks like sdhci-spear.c
>
> If you have a look through this patch set, I've already done that with a
> number of these methods - set_clock, set_uhs_signaling and reset.
>
> Moreover, you don't end up fiddling with sdhci internals (such as the
> card_tasklet) which then impact on attempts to clean that code up, which
> is exactly why we're discussing this. :)

I agree to all above stuff..

>> Again, I can't test any modifications to this code and we need help from
>> Pratyush/Mohit on this..
>
> The important thing is we understand why the code is the way it is today,
> and work out some way of cleaning this up.  Do you think the above will
> work?

Absolutely, it will work.

Thanks for your efforts in cleaning up this stuff..
