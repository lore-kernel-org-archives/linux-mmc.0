From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4] mmc: core: Add support for MMC power sequences
Date: Tue, 13 Jan 2015 14:23:22 +0000
Message-ID: <20150113142322.GQ12302@n2100.arm.linux.org.uk>
References: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
 <20150102181423.GS11285@n2100.arm.linux.org.uk>
 <CAPDyKFpo=WpE3hDxqETVXOYX6pFsSmO7YybLJF=kJFyYFVcaoA@mail.gmail.com>
 <20150112161820.GJ12302@n2100.arm.linux.org.uk>
 <CAPDyKFrXEBxVRY+MVu1HnxeojmWENwTmX3vf8r5uSx0tdNLsvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37054 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752220AbbAMOXj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 09:23:39 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFrXEBxVRY+MVu1HnxeojmWENwTmX3vf8r5uSx0tdNLsvw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>

On Tue, Jan 13, 2015 at 03:08:51PM +0100, Ulf Hansson wrote:
> On 12 January 2015 at 17:18, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jan 12, 2015 at 03:29:54PM +0100, Ulf Hansson wrote:
> >> Regarding you concern, about me propagating the same design mistake as
> >> for the ->set_ios() callback, I am not sure I fully understand why you
> >> think that's the case?
> >
> > Because of this:
> >
> > mmc_pwrseq_power_up()- Invoked from mmc_power_up(), to power up.
> > mmc_pwrseq_power_on()- Invoked from mmc_power_up(), to power on.
> >
> > This re-inforces the "power up, wait, power on" _power_ _sequence_
> > as part of the software design.
> >
> > We know that _today_ there is hardware which does not work like that.
> > We know that we have host adapters which ignore the "power up" part,
> > because they deal with all the sequencing in hardware.
> >
> > I'll refer to your new infrastructure as "pwrseq" and the existing
> > infrastructure as "power sequence".  (That alone shows what an
> > absurd situation this is - we have two things which have the same
> > name!)
> >
> > Let's say we have a pwrseq handler which implements the power_up()
> > and power_on() callbacks.  It's written for use with a controller
> > which implements appropriate actions on set_ios() with POWER_UP
> > and POWER_ON states implemented.
> >
> > So, what we have is:
> >
> > pwrseq          power sequence  host state/action
> >
> > power_up                        no power supplied
> >                 POWER_UP        host applies power to the card
> >
> > power_on                        host is supplying power to card
> >                 POWER_ON        host applies clocks to the card
> >
> > Now, for a more inteligent host, where the hardware takes care of
> > sequencing the application of power and clocks, we have this:
> >
> > pwrseq          power sequence  host action
> >
> > power_up                        no power applied
> >                 POWER_UP        host does nothing
> >
> > power_on                        no power applied
> >                 POWER_ON        host applies power to the card, waits,
> >                                 and applies the clock
> >
> > As we can see, the hardware state which the power_on() method of the
> > pwrseq is called is highly host dependent.  In the first case, power
> > has already been applied.  In the second case, power has not been
> > applied.
> >
> > To have consistency, you need to /first/ solve the problem which I've
> > been pointing out, otherwise we're going to have these new pwrseq
> > callbacks being called with inconsistent, host specific power states
> > being applied to the card.
> 
> Thanks a lot for elaborating! I understand your concern now.
> 
> In this context, I believe it's important to state that I think these
> host driver behaves badly! _All_ host drivers shall handle their
> "power_up" things while they get MMC_POWER_UP through the ->set_ios()
> callback. They shouldn't be taking short-cuts and ignore the
> MMC_POWER_UP state, that also includes those host drivers which are
> able to handle the power sequence by help from it's controller
> hardware.

You can't solve this in this way.  Let's say that you decide to force
the inteligent controllers to power up and enable clocks in the
POWER_UP stage:

pwrseq		power sequence	host action

power_up			no power applied
		POWER_UP	host applies power to the card, waits,
				and applies the clock

power_on			power and clock is applied
		POWER_ON	host does nothing

So now, you have a variability for the power_on() callback, where with
dumb hosts, the clock is not enabled, but for more inteligent hosts,
the clock has already enabled, and likely we have already waited the
74 clocks necessary in the MMC protocol.

> I did quick research and found that the following host's ->set_ios()
> callbacks need to be fixed in this regards.
> au1xmmc_set_ios()
> cb710_mmc_set_ios()
> omap_hsmmc_set_ios()
> sdricoh_set_ios()
> __toshsd_set_ios()

Rather than fixing them, how about introducing a new method for host
controllers:

	power_up()

which can be pointed to a library function which makes the ->set_ios
calls as the current mmc_power_up() function does for those dumb
controllers, but for the more inteligent controllers, just invokes
their power up sequence and returns when that is complete.

> > An alternative way to get consistency is to eliminate the pwrseq
> > "power_on" callback altogether; the "power_up" callback will always
> > be made before the host interface power sequence is started - and
> > that is about the only thing we can guarantee given the variability
> > in host interface designs.
> 
> Eliminating is likely not an option, since it would mean we will have
> a hard time to cope with requirements for the pwrseq sequences.
> 
> An option would be to move the call to the pwrseq ->power_on()
> callback to the end of mmc_power_up(). That would make it as
> consistent as we can from mmc core point of view. Right?

Yes, and you might as well call the pwrseq callbacks "->pre_power_on()"
and "->post_power_on()" - maybe even "->post_pwrclk_on()" to make it
clear that it happens after the power and clocks have been applied
according to the MMC/SD protocol.

What I'm envisioning mmc_power_up() becoming is something like this:

void mmc_power_up(struct mmc_host *host, u32 ocr)
{
        if (host->ios.power_mode == MMC_POWER_ON)
                return;

        mmc_host_clk_hold(host);

	if (pwrseq)
		pwrseq->pre_power_on(host);

        host->ios.vdd = fls(ocr) - 1;
	host->ios.clock = host->f_init;
	host->ios.power_mode = MMC_POWER_ON;
	/* and set remainder of initial state of host->ios */

	host->ops->power_up(host, &host->ios);

	if (pwrseq)
		pwrseq->post_power_on(host);

	mmc_host_clk_release(host);
}

The legacy power_up host method can save a copy host->ios, and manipulate
the saved copy to call mmc_set_ios() as we currently do, with all the
delays we have there.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
