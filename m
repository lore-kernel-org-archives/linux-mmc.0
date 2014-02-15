From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Sat, 15 Feb 2014 22:03:19 +0000
Message-ID: <20140215220319.GM30257@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <1580658.FIe4en5bEU@wuerfel> <52FF6A16.5080201@gmail.com> <1528854.BAQRr94nzx@wuerfel> <20140215205159.GL30257@n2100.arm.linux.org.uk> <52FFDDA6.6020607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37561 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753138AbaBOWDb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 17:03:31 -0500
Content-Disposition: inline
In-Reply-To: <52FFDDA6.6020607@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Sat, Feb 15, 2014 at 10:35:34PM +0100, Tomasz Figa wrote:
> If you change your hardware in an incompatible way and such change can't  
> be detected automatically (i.e. the chip is non-discoverable) then I  
> don't know how you could let the OS know about this change in any other  
> way than providing it with the information it needs.

I'm not talking about such major changes.  I'm talking about minor
changes where the SDIO device may change, but everything else stays
compatible.

Why should such a situation be forced down the path of having a different
DT file to specify the different SDIO device, when the SDIO device itself
is discoverable?  For example, BRCM4329 to a BRCM4330.

Look, let's think seriously about this.  Let's say we have a platform
where there's already two different DT files - one for models with a
single CPU, and a different DT file for a quad CPU.  This is fine,
users generally know which model they have, and can choose between
the two without much difficulty - because this information is part of
their decision making process when buying the product.

How, let's say that the SDIO chip becomes obsolete, and has to be
replaced later in the production run.  The external form, fit and
function remain the same, it's just the internals have now changed.

Now, if we go down Arnd's route, then we need to have not two DT files,
but now four.  One for single CPU with BRCM4329, quad CPU with the
same, and then those two with a BRCM4330.

Now, how does the user choose which DT file is right for their device?
Do they:

(a) ask the manufacturer, leading to hundreds of support requests.
(b) open the device up, invalidating the warranty to find out what chips
    are inside.
(c) something else (please specify)

What I'm trying to get here is the perspective from the other side - the
/user/ perspective, and the problems that making the wrong decision here
brings.  It has huge implications, and can make the difference between
"shall we use a mainline kernel, or shall we keep our own kernel/use an
ancient vendor's kernel with our own private hacks so we can reduce our
support costs".

I'm already seeing exactly this kind of problem on the horizon, because
I know of a platform where there was a bug in part of the hardware -
and enabling support for some interface features screws up on those
with the hardware bug.  So, there's already _four_ DT files to think
about for this hardware platform.  If Arnd's suggestion goes forward,
then we end up with _six_.  It doesn't take much to see where this
leads.

Meanwhile, these kinds of differences could be dealt with using
/board specific code/ in the old days to read on-SoC configuration and
adjust things appropriately - and transparently to the user.

DT is _our_ convenience as kernel hackers.  It is a big _inconvenience_
to the user when a particular product goes through a revision.

So, never ever forget that "oh, we can just deal with it with a different
DT file" makes our lives easier at the expense of our users, and without
users, we've lost.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
