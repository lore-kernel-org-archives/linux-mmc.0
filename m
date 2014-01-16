From: Olof Johansson <olof@lixom.net>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Thu, 16 Jan 2014 13:52:17 -0800
Message-ID: <CAOesGMg1mkb=Jw0fbeJo5oRGoTnW2XJ2=xZrJeJY66=7sxb5LA@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
	<3215037.8HVCjAeS8g@wuerfel>
	<CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
	<74872027.r5ouCtzAgs@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:37264 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaAPVwU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 16:52:20 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so2644562qap.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 13:52:17 -0800 (PST)
In-Reply-To: <74872027.r5ouCtzAgs@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Thu, Jan 16, 2014 at 1:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 16 January 2014 09:15:17 Olof Johansson wrote:
>>
>> > b) We need to add a way to attach a device_node to an sdio_func,
>> > so that a function driver can find additional DT properties.
>> > This part should be relatively simple once (a) is done and
>> > should only need a little code but no new binding. The code
>> > would be similar to what we do for amba, i2c or spi devices.
>>
>> This isn't actually needed for this functionality, but might be needed
>> for other things...
>>
>
> There is at least one sdio driver (cw1200) that needs to get
> a MAC address from DT and has the same kind of hack that
> you mention to work around it at the moment (actually worse,
> it's not even using auxdata). The MAC address is certainly
> a property of the device, not the host. This is of course
> the same problem that we have on various development boards
> with USB ethernet controllers lacking an EEPROM.

Yeah, definitely overlap with the on-board usb ethernet adapters where
the vendor hasn't bothered with an eeprom.

> Getting the device to probe in the first place is more important,
> and this is a much simpler problem though.

Yes, agreed -- both needs solving but they're separate issues.


-Olof
