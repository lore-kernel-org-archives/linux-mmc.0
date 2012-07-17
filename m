From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
Date: Tue, 17 Jul 2012 20:17:45 +0200
Message-ID: <CACRpkdaUfx6iiydHAwzZMG=a5y5kcoB+zeaVTvXjcPArGX8bMg@mail.gmail.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
	<CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
	<20120715211120.GH4041@opensource.wolfsonmicro.com>
	<CACRpkdb0k4fNigA6FGyEobxUt-JnmUy-ni7XzH-gup-ic_j+VQ@mail.gmail.com>
	<20120717074324.GA12047@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:54721 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091Ab2GQSRq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 14:17:46 -0400
Received: by qadb17 with SMTP id b17so2504708qad.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jul 2012 11:17:46 -0700 (PDT)
In-Reply-To: <20120717074324.GA12047@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Roland Stigge <stigge@antcom.de>, Grant Likely <grant.likely@secretlab.ca>, cjb@laptop.org, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org

On Tue, Jul 17, 2012 at 9:43 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 17, 2012 at 12:16:48AM +0200, Linus Walleij wrote:
>> On Sun, Jul 15, 2012 at 11:11 PM, Mark Brown
>
>> > I had thought a version of this
>> > had been submitted already and was in a similar place to the one for
>> > gpio_request().
>
>> Me to...
>
> Greg just merged the driver core patch for pushing the deferred devices
> to the end of the dpm list before reprobing them which should address
> Grant's concern about doing this in gpiolib.

OK sounds good, I'll look over your patch again.

Yours,
Linus Walleij
