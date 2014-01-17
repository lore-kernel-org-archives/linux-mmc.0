From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 18:06:41 +0800
Message-ID: <CAGb2v640Qeb60dMq2kH6M6NqkVbdUh1JcCus3a7D7icQeDdKNg@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel> <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140116195819.GY15937@n2100.arm.linux.org.uk> <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
 <20140117093909.GB2348@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:63074 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbaAQKHC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 05:07:02 -0500
In-Reply-To: <20140117093909.GB2348@piout.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olof Johansson <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 17, 2014 at 5:39 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On Thu, Jan 16, 2014 at 12:00:47PM -0800, Olof Johansson wrote :
>> On Thu, Jan 16, 2014 at 11:58 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote:
>> >> We've dealt with it with local code in our tree for Chrome OS, and I
>> >> suspect everyone else has too. It's definitely time to solve
>> >> generically.
>> >
>> > As there's no code for any Cubox-i or Hummingboard (they're both purely
>> > DT), what this means is that the answer to Wifi/BT support in mainline is
>> > that this is "impossible at the moment"...
>> >
>> > I guess this is becoming a higher priority issue which really needs to be
>> > solved somehow. :)
>>
>> I'm looking at it right now actually, might as well sort it out while
>> people are paying attention. Patches a little later today unless I get
>> distrac^Winterrupted. :)
>>
>
> Maybe it is not completely related but I think it needs to be thought
> about while you are it:
>
> The TI wilink chips (TiWi, wl12xx, wl18xx) have wifi on SDIO and BT on
> UART but they share the same clock. So, the next question would be what
> if I just want to enable one or the other (and take that decision at
> runtime) ?

Some Broadcom chips (BCM4329/4330) and the AP6210 found on CubieTruck
are like this as well. In our case, the SD/MMC host driver hasn't been
mainlined yet. But BT on UART is independent and usable.

> Where do I put the pinctrl/clocks/regulators in the DT ? I guess it can
> become an issue to enable both WiFi and BT at the same time if both SDIO
> and UART are trying to handle the same pinctrl and regulators.

Shouldn't the clocks and regulators be registered in the DT _AS_ clocks
and regulators? fixed-regulator already accepts GPIO lines. fixed-rate-clock
mentions GPIOs in DT bindings, but doesn't seem to use them in the code.
We'd still need a device to tie them to, especially in the UART use case.

Or we could try rfkill devices. Not saying it's the correct way, but it is
a solution.


Cheers,
ChenYu
