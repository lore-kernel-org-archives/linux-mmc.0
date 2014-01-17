From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 11:58:52 -0500 (EST)
Message-ID: <alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
 <CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:52756 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaAQQ6y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 11:58:54 -0500
In-reply-to: <CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Fri, 17 Jan 2014, Rob Herring wrote:

> On Thu, Jan 16, 2014 at 9:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Thu, 16 Jan 2014, Olof Johansson wrote:
> >
> >> "for SDIO slots" is somewhat misleading; nearly all controllers only
> >> do one slot/device per controller. The designware controller can do
> >> multiple slots, and that adds a bit of driver and binding complexity
> >> for something that seemingly not a single vendor has actually
> >> implemented.
> >
> > The Marvell 8688, just to name one, does both WIFI and BlueTooth over
> > the same SDIO controller using separate functions/slots.
> 
> But that is logical functions within a chip, not multiple discrete
> chips (i.e. slots) with their own reset, regulators, etc.

OK.  If that's the definition of a slot in this context then I agree.


Nicolas
