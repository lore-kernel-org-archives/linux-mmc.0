From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Thu, 13 Feb 2014 09:56:56 +0100
Message-ID: <CAPDyKFo9Xpxe0XzevPEeaofLeCNivnf3R_RttToP2h3aFyB4Yw@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
	<52E700F0.7040708@gmail.com>
	<CAPDyKFpOhQtiyCmzie3=sfg42Vv5_rReRNgUf8kALoE6TBe2cw@mail.gmail.com>
	<201401281148.10670.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:34976 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbaBMI45 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2014 03:56:57 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so15773257qab.12
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2014 00:56:57 -0800 (PST)
In-Reply-To: <201401281148.10670.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Olof Johansson <olof@lixom.net>, linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, mark.rutland@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chris Ball <chris@printf.net>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>

On 28 January 2014 11:48, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 28 January 2014, Ulf Hansson wrote:
>> On 28 January 2014 01:59, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> > On 27.01.2014 11:19, Ulf Hansson wrote:
>> >> There is already a host capability that I think we could use to handle
>> >> this. MMC_CAP_NONREMOVABLE, the corresponding DT binding string is
>> >> "non-removable", and it may be set per host device.
>> >>
>> >> Using this cap means the mmc_rescan process that runs to detect new
>> >> cards, will only be executed once and during boot. So, we need to make
>> >> sure all resources and powers are provided to the card at this point.
>> >> Otherwise the card will not be detected.
>> >
>> > I don't quite like this requirement, especially if you consider
>> > multi-platform kernels where a lot of drivers is going to be provided as
>> > modules. WLAN drivers are especially good candidates. This means that even
>> > if the card is powered off at boot-up, if user (or init system) loads
>> > appropriate module, which powers the chip on, MMC core must be able to
>> > notice this.
>>
>> To be able to detect the card, the WLAN driver doesn't have to be
>> probed, only the "power controller" driver. I suppose this is were it
>> becomes a bit tricky.
>>
>> Somehow the mmc core needs to be involved in the probe process of the
>> power controller driver. Could perhaps the power controller bus be
>> located in the mmc core and thus the power controller driver needs to
>> register itself by using a new API from the mmc core? Similar how SDIO
>> func driver's register themselves.
>
> I think there is another option, which does have its own pros and cons:
> We could move all the power handling back into the sdio function driver
> if we allow a secondary detection path using DT rather than the probing
> of the SDIO bus. Essentially you'd have to list the class/vendor/device
> ID for each function that cannot be autodetected in DT, and have the
> SDIO core pretend that it found the device just by looking at the
> device nodes, and register the struct sdio_func so it can be bound to
> the driver. The driver then does all the power handling in a device
> specific way. At some point the hardware gets registered at the
> mmc host, and the sdio core connects the bus state to the already present
> sdio_func, possibly notifying the function driver that it has become
> usable.

It seems like an option we could try.

There are some tricky parts that needs to be taken care of by the
mmc/sdio core, regarding the probe/removal and the suspend/resume
sequence, but I suppose it should be possible.

A minor concern is how do we handle devices that are fully powered at
boot? Unless the sdio func driver will be loaded we can't power off
them, right? Do we need to cover this case, do you think?

>
> Obviously, this can only work for CAP_NONREMOVABLE devices, but those
> are exactly the ones we are worried about here. The advantage is that
> the power sequencing for a particular device can then be in device
> specific code and can have an arbitrarily complex in the driver without
> needing the mmc code to handle all possible corner cases.

Agree!

I think a removable SDIO card won't l need this additional power
controller mechanism.

Kind regards
Uffe

>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
