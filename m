From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Thu, 16 Jan 2014 20:03:45 +0000
Message-ID: <20140116200345.GZ15937@n2100.arm.linux.org.uk>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk> <3215037.8HVCjAeS8g@wuerfel> <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com> <20140116195819.GY15937@n2100.arm.linux.org.uk> <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:39418 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750994AbaAPUDv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 15:03:51 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Jan 16, 2014 at 12:00:47PM -0800, Olof Johansson wrote:
> On Thu, Jan 16, 2014 at 11:58 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote:
> >> We've dealt with it with local code in our tree for Chrome OS, and I
> >> suspect everyone else has too. It's definitely time to solve
> >> generically.
> >
> > As there's no code for any Cubox-i or Hummingboard (they're both purely
> > DT), what this means is that the answer to Wifi/BT support in mainline is
> > that this is "impossible at the moment"...
> >
> > I guess this is becoming a higher priority issue which really needs to be
> > solved somehow. :)
> 
> I'm looking at it right now actually, might as well sort it out while
> people are paying attention. Patches a little later today unless I get
> distrac^Winterrupted. :)

I'll look forward to them, but I may not be able to do much more this
evening.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
