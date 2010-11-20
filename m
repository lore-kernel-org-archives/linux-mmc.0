From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC]  sdhci: 8 bit bus width changes
Date: Sat, 20 Nov 2010 18:24:23 +0000
Message-ID: <20101120182423.GA31030@void.printf.net>
References: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com> <20101119214002.GA19272@void.printf.net> <20101119215333.GB19272@void.printf.net> <20101120123553.GA11936@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48579 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab0KTSY1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 20 Nov 2010 13:24:27 -0500
Content-Disposition: inline
In-Reply-To: <20101120123553.GA11936@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Sat, Nov 20, 2010 at 01:35:53PM +0100, Wolfram Sang wrote:
> I know it's too late, but...

It's late, but it's not too late.  I'd like to send a fix for MMC cards
to Linus within the next week.  If we decide to make some small changes
here and can do it quickly, that should be fine.

> What does the platform_-prefix of the callback indicate?

That it's a hook for code (whether that's a -pltfm driver or an SDHCI
driver) that knows more about the board-level setup to implement.

> >  * introduce a quirk to specify that the board designers have indeed
> >    brought out all the pins for 8-bit to the slot.
> 
> This is not a quirk, this is platform_data, no?

Yes, I agree that platform code would be more correct than the quirk.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
