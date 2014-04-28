From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
	compliant with UHS-1
Date: Mon, 28 Apr 2014 12:51:07 +0100
Message-ID: <20140428115107.GJ26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk> <20140425123820.GA15179@pengutronix.de> <CAPDyKFpja-dGwsEL6YP=Nn=YSRRgMzTTz6WVQ8DiUOMrkLJpBQ@mail.gmail.com> <20140428110259.GI26756@n2100.arm.linux.org.uk> <CAPDyKFpHoLbY4Li45UfPweJ0xKpa5E5d=YX+Sgz9pvRG4W2xiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54444 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751767AbaD1LwC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 07:52:02 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpHoLbY4Li45UfPweJ0xKpa5E5d=YX+Sgz9pvRG4W2xiQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 28, 2014 at 01:11:20PM +0200, Ulf Hansson wrote:
> On 28 April 2014 13:02, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Mon, Apr 28, 2014 at 12:50:54PM +0200, Ulf Hansson wrote:
> >> On 25 April 2014 14:38, Markus Pargmann <mpa@pengutronix.de> wrote:
> >> > Hi,
> >> >
> >> > On Wed, Apr 23, 2014 at 08:07:57PM +0100, Russell King wrote:
> >> >> Patch suggested by Dong Aisheng <dongas86@gmail.com>, this avoids
> >> >> additional clock start/stop cycles during the transition to 1.8V
> >> >> signalling mode.
> >> >>
> >> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >> >
> >> > I tested the series on imx6s with a RIoT board. With this patch applied
> >> > the RIoT board emmc does not work. Here is the output of the board:
> >>
> >> Hi Markus,
> >>
> >> Thanks for helping out testing!
> >>
> >> Does that mean patch 1->20 works fine for you? May I add your tested-by tag?
> >
> > Why should _you_ add someone elses tested-by tag to _my_ patches?
> >
> > I still wonder whether you understood anything that I've already said to
> > you about the handling of this patch set.
> 
> That was based upon that _I_ would help out in creating the pull
> request to Chris, to minimize his effort in resolving conflicts.
> 
> All-right, I back off - I was just trying to help here. Please send
> the pull request to Chris directly instead.

I thought I clearly explained the logistics in a previous mail:

| I /could/ rebase it but then I wouldn't be able to produce the patch
| sets/patches for others [*] (such as the Novena project) to derive
| their kernel tree from my iMX6 patch set.
| 
| What I'd prefer is to keep the patch set intact, and provide Chris
| with a pull request for it up to patch 33, which would need a
| conflict fixed - and this would mean that I can be sure that what
| I'm testing, and what I'm distributing is what Chris will also be
| submitting.

One of the problems with your approaches is that the commit IDs for
the patches I'm carrying become different from the commit IDs which
will end up being merged, which then means I have to either silently
drop _my_ commits and hope that they've been merged intact, or I have
to manually diff each patch and compare it with what's merged, or
I have to rebase my patch set on top of what's merged and hope that
git spots that the patches are already applied (which it won't do if
there's other changes on top of them which make it non-obvious to git
that they're applied.)

To put it another way, recommitting these changes makes /more/ work
for me in the long run because of how git works.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
