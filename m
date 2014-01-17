From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 11:44:23 +0100
Message-ID: <20140117104423.GR17530@lunn.ch>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140116195819.GY15937@n2100.arm.linux.org.uk>
 <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
 <20140117093909.GB2348@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:53502 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbaAQKp7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Jan 2014 05:45:59 -0500
Content-Disposition: inline
In-Reply-To: <20140117093909.GB2348@piout.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olof Johansson <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> The TI wilink chips (TiWi, wl12xx, wl18xx) have wifi on SDIO and BT on
> UART but they share the same clock. So, the next question would be what
> if I just want to enable one or the other (and take that decision at
> runtime) ?

At least for the clock is it not an issue. The generic clock framework
does "reference" counting. It will only turn the clock off when all
users have said to turn it off. So put a phandle to the clock in all
nodes which use it.

I've not looked at regulators, but i would hope it also does reference
counting of a regulators users.

	 Andrew
