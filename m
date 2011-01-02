From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 2/2] sdhci: Support for SD/MMC Dual Data Rate
Date: Sun, 2 Jan 2011 19:32:29 +0000
Message-ID: <20110102193229.GC24820@void.printf.net>
References: <35CD48DB-A420-4319-968D-400D45EE9C0D@marvell.com> <20110102185557.GB24820@void.printf.net> <2D605427-1ED4-4599-9F4D-0ED8A4FB6D4E@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43918 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab1ABTcb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 2 Jan 2011 14:32:31 -0500
Content-Disposition: inline
In-Reply-To: <2D605427-1ED4-4599-9F4D-0ED8A4FB6D4E@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

On Sun, Jan 02, 2011 at 11:02:32AM -0800, Philip Rakity wrote:
> > What do you think about passing the ddr mode itself (MMC_1_8V_DDR_MODE)
> > and having set_signaling_voltage() work out what voltage it needs to use
> > to achieve that?  I don't like passing the raw number around so much.
> 
> hmmm
> 
> concur about numbers and can pass the mode in.  The concern I had was if this function
> ever needed to be more generic then wanted the voltage.  Thought about using the VDD
> voltage defines but they are a range of values and not appropriate.  Thoughts ?

Ah, okay, makes sense.

I don't know how likely it is that you'll need the SDHCI layer to tell
you which signaling voltage to use in future -- if it doesn't seem
likely now, I think passing the mode is probably sensible enough.

> >> --- a/drivers/mmc/host/sdhci.h
> >> +++ b/drivers/mmc/host/sdhci.h
> >> @@ -182,6 +182,9 @@
> >> #define  SDHCI_CAN_64BIT	0x10000000
> >> 
> >> #define SDHCI_CAPABILITIES_1	0x44
> >> +#define  SDHCI_CAN_SDR50	0x00000001
> >> +#define  SDHCI_CAN_SDR104	0x00000002
> >> +#define  SDHCI_CAN_DDR50	0x00000004
> >> 
> > 
> > You could use the BIT(0..2) macros here.
> 
> would prefer
> 1<<0
> 1<<1
> 1<<2
> 
> you okay with this ?

Yeah, that's also fine, either works.  The only reason to prefer BIT()
is that it saves you from writing the above without surrounding parens.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
