From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/4] mmc: core: Add support for MMC power sequences
Date: Sun, 04 Jan 2015 20:20:15 +0100
Message-ID: <54A9926F.9090607@redhat.com>
References: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org> <20150102181423.GS11285@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbbADTVQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 4 Jan 2015 14:21:16 -0500
In-Reply-To: <20150102181423.GS11285@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>

Hi Russell,

On 02-01-15 19:14, Russell King - ARM Linux wrote:
> On Fri, Jan 02, 2015 at 05:14:04PM +0100, Ulf Hansson wrote:
>> To be able to handle these SOC specific power sequences, we add a MMC power
>> sequence interface, which helps the mmc core to deal with such.
>
> I think this should be done differently - part of that is with hind sight
> given that we now have a range of interface types.
>
> One of my early design mistakes with MMC was to incorporate the power up
> and initialisation protocol (the 74 clocks business) into the core code.
> This was wrong, because it is a detail which only applies to dumb host
> interfaces.  More inteligent interfaces do not need that complexity as
> they handle that in hardware.
>
> Rather than MMC ending up with more layers and more infrastructure like
> this - turning it more into the turd which is sdhci - I would like to see
> some proper thought put into design, specifically addressing the above
> design issue.
>
> What should be done is to move away from the opaque "set_ios" method into
> something more appropriate - a set of callbacks which describe what we
> want to achieve.

I think you misunderstand what this patch-set tries to do, this patch-set
is intended for use with on board sdio devices, which typically may need
a number of resources initialized before the can be probed over the sd
bus at all. E.g. a regulator enabled, a reset de-asserted, a clk configured
and provided, etc. So this is about sequencing of events before even
trying to talk to the device at the basic spi compatible layer.

Your ideas seem like a good idea to improve the mmc subsys, but this
is somewhat unrelated, in a way this could apply equally to say an usb
attached device, or basically any discoverable bus, where some onboard
devices may need some form of enabling (or power up) before they can be
discovered.

Which is why the original patchset Ulf references in the cover letter was
trying to be more generic, since the got nowhere Ulf now is trying with
something mmc specific, since the direct need for this functionality is
with sdio devices.

Note that this is a real world problem which has been hacked around a lot
in vendor kernels, so although getting the design right as always is
important, it is also important to at some point come up with something
workable, and if you look at previous threads on this topic, you will see
that has already been discussed a lot, and always seems to get stuck on
people trying to find the "perfect. 100% generic" solution, a typical
example of perfect being the enemy of good.

Regards,

Hans
