From: Olof Johansson <olof@lixom.net>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Sun, 19 Jan 2014 19:57:20 -0800
Message-ID: <CAOesGMjeb1syXwYHqsiJnMRu9wfC=zsm8WPoDqvQiZ8gcyHnrg@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
	<3215037.8HVCjAeS8g@wuerfel>
	<CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
	<alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
	<CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
	<alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr>
	<CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
	<20140119230924.GB8154@piout.net>
	<20140119233008.GA4867@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:41816 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbaATD5V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2014 22:57:21 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so5448196qcq.4
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jan 2014 19:57:20 -0800 (PST)
In-Reply-To: <20140119233008.GA4867@quad.lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Jan 19, 2014 at 3:30 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Jan 20, 2014 at 12:09:25AM +0100, Alexandre Belloni wrote:
>> On Sun, Jan 19, 2014 at 11:29:55AM -0800, Olof Johansson wrote :
>> > The "multi-slot" concept I was talking about was one host controller
>> > for several physical slots. Seems like at91 implements _and_ uses this
>> > but nobody else. However, it seems that they allocate one mmc host per
>> > slot, so the same model still works.
>> >
>>
>> I think we need to be extra careful about the DT bindings then because
>> adding a property in a slot is requiring handling that in the at91
>> driver whereas adding a common property for the various mmc hosts can be
>> done in the core code.
>>
>> From what I remember, it would be really good to put the DT parsing for
>> the slots in the core code but I only had a really quick look at that.
>
> The patches I have here do it all in the core per host with common
> bindings. I hope to post them tonight.

Done. See RFC series at:

http://marc.info/?l=linux-mmc&m=139019015915702&w=2


-Olof
