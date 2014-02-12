From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: brcm 4329 problems
Date: Wed, 12 Feb 2014 09:36:34 +0000
Message-ID: <20140212093634.GL26684@n2100.arm.linux.org.uk>
References: <20140205153824.GS26684@n2100.arm.linux.org.uk> <20140208215927.GA5276@n2100.arm.linux.org.uk> <52F744C9.7040804@broadcom.com> <20140209205917.GO26684@n2100.arm.linux.org.uk> <20140209232708.GA25900@n2100.arm.linux.org.uk> <CAA+hA=SEoXfSN19z1vLpiLDh8Mo3Qty4cU2HOGJska70dT5Cew@mail.gmail.com> <20140210140346.GW26684@n2100.arm.linux.org.uk> <CAA+hA=Si4k0A5_-ve0oh8FKxCGDg5pD_M=Z4g2Ca7UWJaeq6Rw@mail.gmail.com> <20140211102733.GG26684@n2100.arm.linux.org.uk> <CAA+hA=RSSahbHOy+=_7LuOnv2=u7BUi8hs=CJAovjGTuDJByjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:33634 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751776AbaBLJgo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2014 04:36:44 -0500
Content-Disposition: inline
In-Reply-To: <CAA+hA=RSSahbHOy+=_7LuOnv2=u7BUi8hs=CJAovjGTuDJByjg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Arend van Spriel <arend@broadcom.com>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, brcm80211-dev-list@broadcom.com

On Wed, Feb 12, 2014 at 11:17:09AM +0800, Dong Aisheng wrote:
> That means enabling of ahb clock actually will make ipg and per also open.
> Then card interrupts can be detected well.
> You can measure the card clock(pin5) with a scope to double check it.

I can't - the brcm is a chip not a SD card, and the signals are all
embedded on internal layers in the PCB.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
