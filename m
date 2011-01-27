From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] MMCI: don't read command response when invalid
Date: Thu, 27 Jan 2011 21:40:22 +0000
Message-ID: <20110127214022.GE1597@n2100.arm.linux.org.uk>
References: <20110111163502.GJ11039@n2100.arm.linux.org.uk> <20110111163556.GA18746@n2100.arm.linux.org.uk> <20110111232025.GA25752@void.printf.net> <20110127121901.GB25968@n2100.arm.linux.org.uk> <20110127153332.GA14591@void.printf.net> <20110127212814.GA21801@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43263 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab1A0Vka (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jan 2011 16:40:30 -0500
Content-Disposition: inline
In-Reply-To: <20110127212814.GA21801@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 27, 2011 at 09:28:14PM +0000, Chris Ball wrote:
> On Thu, Jan 27, 2011 at 03:33:32PM +0000, Chris Ball wrote:
> > Hi Russell,
> > 
> > On Thu, Jan 27, 2011 at 12:19:01PM +0000, Russell King - ARM Linux wrote:
> > > FYI, I've now merged this into the ARM devel tree for the time being so
> > > it doesn't get forgotten - which means it'll appear in linux-next at some
> > > point if it isn't already there.  (Mainly so I don't have to keep on
> > > adding the patch.)
> > > 
> > > Once you push it into mainline, I'll drop my copy.
> > 
> > Okay.  Sent this to Linus yesterday, just waiting for him to pull.
> > (It's been in linux-next for the last two weeks.)
> 
> It's present in mainline now.

Thanks, dropped from my tree now.
