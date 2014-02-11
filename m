From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: brcm 4329 problems
Date: Tue, 11 Feb 2014 10:27:33 +0000
Message-ID: <20140211102733.GG26684@n2100.arm.linux.org.uk>
References: <20140203210450.GN26684@n2100.arm.linux.org.uk> <52F14F7E.9040900@broadcom.com> <20140205153824.GS26684@n2100.arm.linux.org.uk> <20140208215927.GA5276@n2100.arm.linux.org.uk> <52F744C9.7040804@broadcom.com> <20140209205917.GO26684@n2100.arm.linux.org.uk> <20140209232708.GA25900@n2100.arm.linux.org.uk> <CAA+hA=SEoXfSN19z1vLpiLDh8Mo3Qty4cU2HOGJska70dT5Cew@mail.gmail.com> <20140210140346.GW26684@n2100.arm.linux.org.uk> <CAA+hA=Si4k0A5_-ve0oh8FKxCGDg5pD_M=Z4g2Ca7UWJaeq6Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60829 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750797AbaBKK1o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2014 05:27:44 -0500
Content-Disposition: inline
In-Reply-To: <CAA+hA=Si4k0A5_-ve0oh8FKxCGDg5pD_M=Z4g2Ca7UWJaeq6Rw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Arend van Spriel <arend@broadcom.com>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, brcm80211-dev-list@broadcom.com

On Tue, Feb 11, 2014 at 03:33:09PM +0800, Dong Aisheng wrote:
> It depends on both host and card that 1) if host is able to detect
> SDIO interrupts without clock
> and 2) if the card is able to send interrupt to host without clock.
> If any one of both can't do that, we may need to tell host to not
> do runtime suspend to prevent the clock from being disabled.
> Or the SDIO interrupt may not work.
> 
> The IMX esdhc/usdhc can not detect the SDIO interrupts sent from card
> if the clock is disabled.
> So we need such quirk to not allow runtime PM for SDIO cards.
> Doesn't it make sense?

That's strange.  I have it working as of last night.

Yes, I have to leave the AHB clock on so that the registers are readable,
in the interrupt handler, and that's something I only do if the SDIO
interrupt is enabled, but everything else gets disabled.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
