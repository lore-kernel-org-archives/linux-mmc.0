From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 15:47:54 +0100
Message-ID: <201401171547.55384.arnd@arndb.de>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk> <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com> <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54987 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaAQOs0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 09:48:26 -0500
In-Reply-To: <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Friday 17 January 2014, Nicolas Pitre wrote:
> On Thu, 16 Jan 2014, Olof Johansson wrote:
> 
> > "for SDIO slots" is somewhat misleading; nearly all controllers only
> > do one slot/device per controller. The designware controller can do
> > multiple slots, and that adds a bit of driver and binding complexity
> > for something that seemingly not a single vendor has actually
> > implemented.
> 
> The Marvell 8688, just to name one, does both WIFI and BlueTooth over 
> the same SDIO controller using separate functions/slots.
> 
> Or maybe I'm misunderstanding you?
> 

I wasn't aware of this but I just checked (in mmc_attach_sdio) that
there can be multiple functions on a slot. I assume the sd8688 has
a single slot with two functions, so that potentially extends the
problem space if we need to supply clocks and regulators per
function rather than just per slot.

	Arnd
