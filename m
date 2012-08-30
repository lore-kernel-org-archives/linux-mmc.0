From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Quieten "could not set regulator OCR" error.
Date: Thu, 30 Aug 2012 13:25:58 -0400
Message-ID: <873934qok9.fsf@octavius.laptop.org>
References: <87a9xfyko6.fsf@octavius.laptop.org>
	<CAPDyKFofwC-t-7vhxjF5PUZKTiqYxZh8Kh6J6cLCTFuDTw1-eQ@mail.gmail.com>
	<87mx1dvo9s.fsf@octavius.laptop.org>
	<20120830171214.GD4356@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54849 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab2H3R0F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Aug 2012 13:26:05 -0400
In-Reply-To: <20120830171214.GD4356@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Thu, 30 Aug 2012 10:12:14 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>

Hi,

On Thu, Aug 30 2012, Mark Brown wrote:
>> Looks like regulator_desc->name should be "dummy", but I think it would
>> be an API violation for us to start caring about that.  Mark, would you
>> be interested in offering an "regulator_is_dummy(supply)" function so
>> that we can limit our error messages to non-dummy supplies?
>
> No, that's a terrible idea as previously discussed.
>
> The *sole* purpose of the dummy regulator driver is to provide a crutch
> to keep systems with broken configuraitons running, it's not indended to
> be used on production systems and is there solely as an aid for
> development.  This is why it can only be enabled via Kconfig.  If there
> is no software controllable regulator there the board should be
> providing fixed regulator.

It's being used on production systems, else I wouldn't be responding
to bug reports from distro users of x86 laptops.  Turns out that distro
kernel maintainers often like to answer "y" to new Kconfig options
without reading/understanding them fully.

> Conversely there is nothing stopping other regulator drivers having
> similar properties to the dummy driver, or constraints stopping them
> implementing things.  If the MMC framework wants to silently accept
> regulators that don't allow the voltage to be set then the MMC framework
> should enumerate the range of voltages which can be set using the
> regulator it has and then take appropriate action.

I didn't do this because I don't want to silently accept real regulators
with insufficient voltage ranges, because that would make it harder to
debug real MMC failures.

Sounds like my response to the bug reports should be "persuade your
distro kernel maintainers to turn off CONFIG_REGULATOR" -- I'll try
doing that.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
