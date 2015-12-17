From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: SDHCI long sleep with interrupts off
Date: Thu, 17 Dec 2015 15:54:54 +0100
Message-ID: <CAPDyKFpxx5oXM=MAYcdg1fBiodOo2HjoEvHmZk9nHBCW=qqBQQ@mail.gmail.com>
References: <20151217112814.6250a3b9@archvile>
	<1450350190.3163.93.camel@pengutronix.de>
	<20151217122053.036daf37@archvile>
	<1450351655.3163.97.camel@pengutronix.de>
	<CAPDyKFosBeyP3YYXz-1uyiqoaLuMQj3+ojzpt1-QY7JU9epggw@mail.gmail.com>
	<20151217132229.1c699f69@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34698 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbbLQOyy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 09:54:54 -0500
Received: by mail-yk0-f180.google.com with SMTP id p130so21132751yka.1
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2015 06:54:54 -0800 (PST)
In-Reply-To: <20151217132229.1c699f69@archvile>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

>> If/when you decide to fix this issue. Please keep in mind the following
>> things.
>>
>> - Try to convert the SDHCI into a pure library. No more quirks or callbacks.
>> - I assume we can simplify lots of code if we convert SDHCI into using
>> a threaded IRQ in favour of the tasklet.
>>
>> Any patches that moves SDHCI into this direction will be greatly appreciated!
>
> Ok, this sounds like a good way to go. Unfortunately it also sounds like a
> major endeavor, for which good knowledge of the SDHCI standard is necessary.
> This knowledge is based on documentation that is not openly available without
> cost AFAIK. This probably also explains why there hasn't been a real fix ever.
> On top of that, the whole sdhci code is unmaintained currently as it seems.
> I was studying the code a bit more, and I now understand that I am not even
> close to having the experience and standards-knowledge it takes to pull this
> off reliably. I guess the one who takes on this task may as well become
> official maintainer afterwards...

You are right, a maintainer is needed for sdhci.

Also, I am a bit surprised that none have stepped up, especially since
it's indeed being *very* widely used.

> OTOH, we pretty much depend on this driver now, since all of our new i.MX6/7
> boards have eMMC flash. We also use the flexcan peripheral on all designs,
> which is specially sensible to these latency spikes, so we will have to do
> something on the long run.... we cannot live forever with disabled PM ;-)
>

Unfortunate, PM is only one of the problems.

The code is in general fragile. We have have kind of reached the
point, when I apply changes that fixes one issue it may cause another.

Kind regards
Uffe
