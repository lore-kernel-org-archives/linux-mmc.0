From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Attach PM domain prior probing of SDIO func driver
Date: Wed, 3 Jun 2015 10:45:10 +0200
Message-ID: <CAPDyKFqxd1Uu93d2j-9m9zCBqEE+eGRRhYYCiasA_AZKCdtT3g@mail.gmail.com>
References: <1433153905-25204-1-git-send-email-ulf.hansson@linaro.org>
	<20150601194209.GB30024@dtor-ws>
	<CAPDyKFr+SucSGZRigc4a6zei9TR4f5TuNHXTqWDDj2YQK1yn5A@mail.gmail.com>
	<20150602085101.GY2067@n2100.arm.linux.org.uk>
	<20150602110715.GA20704@n2100.arm.linux.org.uk>
	<CAPDyKFrxjnTUE2W9PGS4=TJeW9ODiL7=UnBtMLALpbLfXotcxw@mail.gmail.com>
	<20150602150617.GF2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35229 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbbFCIpL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jun 2015 04:45:11 -0400
Received: by qkhq76 with SMTP id q76so1366242qkh.2
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2015 01:45:11 -0700 (PDT)
In-Reply-To: <20150602150617.GF2067@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Aaron Lu <aaron.lu@intel.com>

[...]

>> > * When we create a device which we know has a PM domain which should be
>> >   attached, try to look up that PM domain.
>> > * If we find the PM domain, attach the domain, otherwise create the
>> >   domain but mark it "incomplete".
>> > * When the device is attempted to be probed, force the probe to defer if
>> >   the PM domain is inccomplete.
>> > * When a PM domain is initialised, search for any incomplete PM domain,
>> >   and if found, connect with the domain and arrange to handle it.
>>
>> This is a good description from what I had in mind and for what I have
>> started working on. :-)
>
> It would help if you explained things better, since your original
> comment made it sound like you were intending to _only_ attach PM
> domains at device probe time.

I was expecting people to recall from earlier discussions on linux-pm,
sorry. Of course it's impossible to keep up with all things that goes
on.

Anyway, commit e90d5532773e2bcccc538dd346b9fc3482cd700c ("driver core
/ PM: Add PM domain callbacks for device setup/cleanup"), indicates
the direction of change for how we wants to deal with assigning PM
domain pointers.

[...]

>>
>> 1. In the case where the PM domain driver hasn't yet been probed and
>> thus not called pm_genpd_init() + of_genpd_add_provider_*(), we can't
>> support probe deferral of a device which needs its PM domain powered.
>> Simply because dev_pm_domain_attach() has no knowledge about the (not
>> yet registered) PM domain.
>
> Why can't we do something like the clk API, regulator API, or of the
> many other resource providing subsystems, and detect when there's an
> firmware node saying that a resource should be provided to a device,
> but the resource is not yet available?
>
> For example, if you call clk_get() for a device and clock consumer name
> and firmware says that the clock should exist, but it can't be found,
> clk_get() returns an EPROBE_DEFER error-pointer.  Same for the regulator
> subsystem.  IRQ domains behave very similarly, but earlier on before the
> device driver's probe function is called.
>
> Why can't PM domains also follow this model?

That seems like separate and much wider discussion.

I haven't suggested to re-write the entire PM domain/genpd, just the
way how PM domain pointers gets assigned. I don't think it will be
that of a big deal, but let's see.

>
>> 2. We can't attach a devices to its PM domain via DT, unless it has a
>> matching bus/driver which can be probed.
>>
>> 3. Dealing with device enumeration from HW is fragile, since there are
>> no way to keep the PM domain powered during that sequence. That's
>> because the PM domain hasn't yet been attached. For example
>> amba_device_add() has this limitation.
>
> Stop right there.  Device enumeration from hardware is _not_ fragile,
> it's what is used on virtually all PCI-using platforms out there.  If
> you invent something that takes the kernel away from being able to do
> hardware enumeration, you will be breaking lots of stuff outside the
> ARM architecture and you will _not_ be popular.
>
> You're working on a core subsystem, and you _have_ to realise that the
> world is not made up of DT - you have to cater for other probing styles
> besides DT, which includes hardware based enumeration.   You can't say
> "we're not going to support that anymore" - that's not your decision to
> make.

I was too vague in 3). Obviously enumeration from HW isn't fragile in
most cases.

>
> Yes, amba_device_add() has the limitation that the ID must be readable
> when the device is declared, and we can't do much about that because
> the ID is exported to userspace - hence it's part of the kernel's
> userspace API.  Changing it is going to risk breaking userspace, so
> we need to be careful about what we do there - but that's my problem,
> not yours.  I know Linaro likes to take chunks of the kernel away from
> me without talking to me first, but I do wish they wouldn't.
>

Let's discuss the amba_device_add() case in more detail.

When the amba device resides in a PM domain, it's likely (I know for
sure that's case for ux500) that the PM domain must be powered while
amba_device_add() tries to read the ID from the HW.

In the current solution the PM domain pointer is assigned at
->probe(), which makes it impossible for amba_device_add() to control
the power to the PM domain.

If we instead had that PM domain pointer assigned during
amba_device_add(), we can use runtime PM to control the power to the
PM domain. That's the simple idea, I will try to make it work in
practice.

Anyway, I don't have any patches available for posting/sharing yet. I
will keep you on cc while posting them.

Kind regards
Uffe
