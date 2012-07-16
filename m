From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
Date: Tue, 17 Jul 2012 00:16:48 +0200
Message-ID: <CACRpkdb0k4fNigA6FGyEobxUt-JnmUy-ni7XzH-gup-ic_j+VQ@mail.gmail.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
	<CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
	<20120715211120.GH4041@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44850 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab2GPWQt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jul 2012 18:16:49 -0400
Received: by qadb17 with SMTP id b17so1899855qad.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jul 2012 15:16:49 -0700 (PDT)
In-Reply-To: <20120715211120.GH4041@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Roland Stigge <stigge@antcom.de>, Grant Likely <grant.likely@secretlab.ca>, cjb@laptop.org, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org

On Sun, Jul 15, 2012 at 11:11 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 14, 2012 at 09:57:08PM +0200, Linus Walleij wrote:
>
>> If I understand correctly this relates closely to another patch from Mark Brown
>> we discussed the other day (sorry for missing this patch, which arrived
>> earlier, for a while).
>
>> Mark/Grant can you look at this patch?
>
> Not unless I have a copy of it, no...

Sorry, forwarded a copy to you.

> I had thought a version of this
> had been submitted already and was in a similar place to the one for
> gpio_request().

Me to...

Linus Walleij
