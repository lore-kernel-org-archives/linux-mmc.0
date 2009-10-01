From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: TMIO MMC: full patchset.
Date: Thu, 1 Oct 2009 10:30:42 +0900
Message-ID: <aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	 <aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	 <c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:48496 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbZJABaj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2009 21:30:39 -0400
Received: by yxe37 with SMTP id 37so7397131yxe.33
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2009 18:30:43 -0700 (PDT)
In-Reply-To: <c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org

On Thu, Oct 1, 2009 at 5:15 AM, Ian Molton <ian@mnementh.co.uk> wrote:
> No, sorry, this is not the way to do it. Please actually use the
> platform hooks I provided, thats *why* I spent all this time rewriting
> the driver for you. All you've done is add the same hook I added but
> in a broken way.
>
> Passing struct clk pointers about is _not the right way_ its not the
> way the clk api was designed to be used. clocks are _got and _put by
> name and device references, and the pointers should not be getting
> passed from platform code to modular drivers.

Right, I agree that passing a struct clk pointer is far from perfect.

> Doing it from the platform code via the hooks I provided is not a
> workaround - its the proper way to do it until such time as the clk
> API is merged into the core kernel and divorced from its CPU
> dependency (so that MFD drivers can use it to provide clocks and the
> tmio_mmc driver can lose the platform hooks for clocking).

So you mean that the platform code should do clk_enable() and
clk_get_rate(), then feed the rate to the driver using hclk? That is
doable, but..

The downside of this is that the clock will be enabled regardless if
the tmio-mmc driver is enabled or not. From that perspective I would
prefer that the clock would be enabled in the actual tmio-mmc driver
itself.

Or I could add some ugly #ifdefs around the platform device code.
Maybe the best option is to hack up a mfd driver for just the
superh-mobile specific sdhi part.

> Some constructive advice follows:
>
> Does your clock rate vary dynamically, or is it on a per platform
> basis? If the latter then thats fine. If the former, you will need to
> do a lot more work as tmio-mmc was not written to support the clock
> rate getting changed under its feet, and you could fry peoples
> hardware.

Well, the goal is dynamic clocks, but at this point it's dynamic until
the clock is enabled. So i'd like to only enable the clock when
absolutely needed. I do however understand that neither tmio-mmc nor
the mmc subsystem was written with dynamically changing clocks in
mind.

Using clk_get_rate() after clk_enable() should be fine, see the
comment in linux/clk.h:

---
/**
 * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
 *		  This is only valid once the clock source has been enabled.
 * @clk: clock source
 */
unsigned long clk_get_rate(struct clk *clk);
---

At some point I'd like to add runtime pm support to the tmio-mmc
driver as well. With such a change it should be possible to power down
the hardware block while the system is idle and re-setup everything
when next access happens.

I hacked up a prototype for just that a few months ago, but it needs
more work. For now it's probably best just to focus on getting
_something_ supported to begin with.

> Also I would recommend that you merge all the platform data patches
> along with the kconfig patch as a single changeset in git or a single
> patch if you arent using git (you should use git). There is no reason
> to seperate them, and the platform data patches are useless without
> the kconfig patch (and vice-versa).

Thanks for your recommendation, but I'd like to keep the patches as is.

This because:
a) they are independent changes
b) they are potentially destined for more than one tree
c) they are for individual cpus/boards, a combined patch makes back
porting painful
d) having them separate minimizes amount of potential collision

> Since you will be then submitting the platform patches all at once,
> then I suggest you factor out all the identical MMC related structs
> into a seperate file (pxa has devices.c - superh may have something
> similar?) and then you can simply add the devices to a list of devices
> or have a single function call in each of the platform files, rather
> than duplicating the code all over the place. My guess is these wont
> be the only superH boards to use this driver. If the name of the MMC
> clock differs on each board, you can solve this by using a clock alias
> on each board (you may need to copy the clock alias support I wrote
> for SA1100/PXA - not sure if it went in to the generic code or just
> ARM stuff)

You are right that other boards and processor will want to use this.

Regarding duplicated code, please have a second look. The platform
data is similar but not identical. The hwblk_id part of the platform
device varies with processor model. With the platform data we also
need pinmux configuration, and that varies with board type so we end
up with board specific code regardless.

> Also you should consider adding updated defconfigs for each of the
> affected platforms to that patchset when you submit it - if you dont
> you will break them because they will lose their spi MMC access. That
> might be a bit serious if thats where their root fs is...

Right, but updating the defconfig usually happens later in the cycle.
Updating the defconfig for each little change will just force a
certain merge order, and this may make the entire tree stall if one
little patch gets delayed. So to maximize patch throughput I prefer to
minimize the amount of dependencies thank you.

As for the mmc over spi access, the platform data should be merged
after your patches and the kconfig bits so that will not generate any
breakage. We do of course control these things through the superh tree
already.

> As a bonus of using the tmio-mmc platform hooks properly, you also get
> to submit everything via the superH tree. You may consider the Kconfig
> patch acked-by me but I think it should be merged as part of a
> patchset containing all the platform patches too.

The kconfig bit can be merged at any point. If someone enables the
driver in the kconfig but lacks platform data then nothing happens.
But yes, I prefer to take things through the superh tree.

> I'd like to see the updated version when you're done.

I'll do my best to keep you CC:ed.

Any chance we can get at least the ian-0001 patch and the kconfig bit
merged in 2.6.32-rc? I realize it's a bit late in the merge cycle
though. If we stick to 2.6.33 then this little change took more than
one year from initial patches to inclusion in a stable kernel....

Thanks,

/ magnus
