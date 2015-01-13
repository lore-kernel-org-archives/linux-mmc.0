From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: core: Add support for MMC power sequences
Date: Tue, 13 Jan 2015 15:34:27 +0100
Message-ID: <CAPDyKFr3bLxH5cUx_GF0VonmiM_Qy_xuaOc43=TMmZUnaoxE5A@mail.gmail.com>
References: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
	<20150102181423.GS11285@n2100.arm.linux.org.uk>
	<CAPDyKFpo=WpE3hDxqETVXOYX6pFsSmO7YybLJF=kJFyYFVcaoA@mail.gmail.com>
	<20150112161820.GJ12302@n2100.arm.linux.org.uk>
	<CAPDyKFrXEBxVRY+MVu1HnxeojmWENwTmX3vf8r5uSx0tdNLsvw@mail.gmail.com>
	<20150113142322.GQ12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:38613 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbAMOe2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 09:34:28 -0500
Received: by mail-qa0-f42.google.com with SMTP id dc16so2284441qab.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 06:34:27 -0800 (PST)
In-Reply-To: <20150113142322.GQ12302@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>

[...]

>>
>> Thanks a lot for elaborating! I understand your concern now.
>>
>> In this context, I believe it's important to state that I think these
>> host driver behaves badly! _All_ host drivers shall handle their
>> "power_up" things while they get MMC_POWER_UP through the ->set_ios()
>> callback. They shouldn't be taking short-cuts and ignore the
>> MMC_POWER_UP state, that also includes those host drivers which are
>> able to handle the power sequence by help from it's controller
>> hardware.
>
> You can't solve this in this way.  Let's say that you decide to force
> the inteligent controllers to power up and enable clocks in the
> POWER_UP stage:
>
> pwrseq          power sequence  host action
>
> power_up                        no power applied
>                 POWER_UP        host applies power to the card, waits,
>                                 and applies the clock
>
> power_on                        power and clock is applied
>                 POWER_ON        host does nothing
>
> So now, you have a variability for the power_on() callback, where with
> dumb hosts, the clock is not enabled, but for more inteligent hosts,
> the clock has already enabled, and likely we have already waited the
> 74 clocks necessary in the MMC protocol.

I understand, so I was not thinking of fixing the actual problem but
more to make the behaviour consistent.

>
>> I did quick research and found that the following host's ->set_ios()
>> callbacks need to be fixed in this regards.
>> au1xmmc_set_ios()
>> cb710_mmc_set_ios()
>> omap_hsmmc_set_ios()
>> sdricoh_set_ios()
>> __toshsd_set_ios()
>
> Rather than fixing them, how about introducing a new method for host
> controllers:
>
>         power_up()
>
> which can be pointed to a library function which makes the ->set_ios
> calls as the current mmc_power_up() function does for those dumb
> controllers, but for the more inteligent controllers, just invokes
> their power up sequence and returns when that is complete.

Seems like a good idea!

>
>> > An alternative way to get consistency is to eliminate the pwrseq
>> > "power_on" callback altogether; the "power_up" callback will always
>> > be made before the host interface power sequence is started - and
>> > that is about the only thing we can guarantee given the variability
>> > in host interface designs.
>>
>> Eliminating is likely not an option, since it would mean we will have
>> a hard time to cope with requirements for the pwrseq sequences.
>>
>> An option would be to move the call to the pwrseq ->power_on()
>> callback to the end of mmc_power_up(). That would make it as
>> consistent as we can from mmc core point of view. Right?
>
> Yes, and you might as well call the pwrseq callbacks "->pre_power_on()"
> and "->post_power_on()" - maybe even "->post_pwrclk_on()" to make it
> clear that it happens after the power and clocks have been applied
> according to the MMC/SD protocol.
>
> What I'm envisioning mmc_power_up() becoming is something like this:
>
> void mmc_power_up(struct mmc_host *host, u32 ocr)
> {
>         if (host->ios.power_mode == MMC_POWER_ON)
>                 return;
>
>         mmc_host_clk_hold(host);
>
>         if (pwrseq)
>                 pwrseq->pre_power_on(host);
>
>         host->ios.vdd = fls(ocr) - 1;
>         host->ios.clock = host->f_init;
>         host->ios.power_mode = MMC_POWER_ON;
>         /* and set remainder of initial state of host->ios */
>
>         host->ops->power_up(host, &host->ios);
>
>         if (pwrseq)
>                 pwrseq->post_power_on(host);
>
>         mmc_host_clk_release(host);
> }
>
> The legacy power_up host method can save a copy host->ios, and manipulate
> the saved copy to call mmc_set_ios() as we currently do, with all the
> delays we have there.
>

Looks good!

I will rename the pwrseq callbacks to your proposal and send a v2.

Kind regards
Uffe
