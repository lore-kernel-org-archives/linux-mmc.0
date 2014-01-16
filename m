From: Olof Johansson <olof@lixom.net>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Thu, 16 Jan 2014 09:15:17 -0800
Message-ID: <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
	<3215037.8HVCjAeS8g@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:59738 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbaAPRPS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 12:15:18 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so2557525qcx.16
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 09:15:17 -0800 (PST)
In-Reply-To: <3215037.8HVCjAeS8g@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

[adding devicetree and mmc lists]

On Thu, Jan 16, 2014 at 6:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 16 January 2014 13:36:49 Russell King - ARM Linux wrote:
>
>>
>> The Wifi/BT chip can only be detected via probing the SDIO connection, and
>> only when the device has been powered up and released from reset - so we
>> have to power up and reset the bcrm device before we probe via the SDIO
>> bus.
>
> This is indeed a common problem, and while we've talked about solving
> it in the past, nothing has happened code-wise. It indeed needs an
> implementation in the sdio framework.

Yeah, this is what's keeping wifi from working on the ARM Chromebook
upstream as well, and it's been on my list to deal with for a long
time. So now is as good a time as any.

Generic SDIO framework solution/binding would be great, since these
constructs are quite common on systems these days (even x86 is
starting to get peripherals on SDIO).

>> While it's possible to attach the power supply for the Wifi/BT chip to the
>> vmmc-supply property of the host, it's not possible to do that with the
>> oscillator supply.  Neither is there any provision for manipulating the
>> GPIOs to deal with the resets.
>>
>> I can't find any examples of anything similar in our existing set of DT
>> files, so I suspect either this is a device which no one supports on any
>> DT platform, or there's some clever way to handle this.
>
> The former.

We've dealt with it with local code in our tree for Chrome OS, and I
suspect everyone else has too. It's definitely time to solve
generically.

>> How do other people support this in DT?  Do they hack up some platform
>> specific code (which isn't nice)?  What other solutions are there to get
>> around this problem?  How does this kind of thing get represented in DT?
>>
>> (Don't suggest adding DT support to the bcrmfmac driver - this is a
>> chicken-and-egg problem.  The driver isn't being probed at the moment
>> because the device is powered down and/or held in reset, so is
>> undetectable.  The kernel needs to power it up and release the reset
>> so it becomes detectable.)
>
> The problem is two-fold:
>
> a) we need to add a generic mechanism to the SDIO probe code to
> allow specifying clocks, regulators and resets (possibly more)
> for an SDIO endpoint that get enabled before the probe starts.
> This parts needs a DT binding for SDIO slots as well as code.

"for SDIO slots" is somewhat misleading; nearly all controllers only
do one slot/device per controller. The designware controller can do
multiple slots, and that adds a bit of driver and binding complexity
for something that seemingly not a single vendor has actually
implemented.

So we can likely assume to keep these reset/power/clock lines per host
controller, no need to add a slot construct.

> b) We need to add a way to attach a device_node to an sdio_func,
> so that a function driver can find additional DT properties.
> This part should be relatively simple once (a) is done and
> should only need a little code but no new binding. The code
> would be similar to what we do for amba, i2c or spi devices.

This isn't actually needed for this functionality, but might be needed
for other things...

> Note that the same problem exists for a number of other discoverable
> buses that get used in nondiscoverable ways, e.g. USB, PCI,
> or even SCSI. It's normally a spec violation if those devices
> are wired up like this, but of course we still want to support
> the hardware.

... such as these. :)

-Olof
