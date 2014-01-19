From: Olof Johansson <olof@lixom.net>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Sun, 19 Jan 2014 11:29:55 -0800
Message-ID: <CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
	<3215037.8HVCjAeS8g@wuerfel>
	<CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
	<alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
	<CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
	<alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34111 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaAST34 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2014 14:29:56 -0500
Received: by mail-wg0-f53.google.com with SMTP id y10so6340774wgg.32
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jan 2014 11:29:55 -0800 (PST)
In-Reply-To: <alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Rob Herring <robherring2@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Fri, Jan 17, 2014 at 8:58 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 17 Jan 2014, Rob Herring wrote:
>
>> On Thu, Jan 16, 2014 at 9:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Thu, 16 Jan 2014, Olof Johansson wrote:
>> >
>> >> "for SDIO slots" is somewhat misleading; nearly all controllers only
>> >> do one slot/device per controller. The designware controller can do
>> >> multiple slots, and that adds a bit of driver and binding complexity
>> >> for something that seemingly not a single vendor has actually
>> >> implemented.
>> >
>> > The Marvell 8688, just to name one, does both WIFI and BlueTooth over
>> > the same SDIO controller using separate functions/slots.
>>
>> But that is logical functions within a chip, not multiple discrete
>> chips (i.e. slots) with their own reset, regulators, etc.
>
> OK.  If that's the definition of a slot in this context then I agree.

Correct -- the device that I've been doing the work in is actually the
combined wifi/bluetooth module on the Samsung Chromebook, which is a
Marvell 8797. It has multiple functions which still work well.

The "multi-slot" concept I was talking about was one host controller
for several physical slots. Seems like at91 implements _and_ uses this
but nobody else. However, it seems that they allocate one mmc host per
slot, so the same model still works.


-Olof
