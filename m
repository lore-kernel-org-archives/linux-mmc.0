From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/12] mmci: allow the card detect status not to be
	inverted
Date: Mon, 9 Aug 2010 12:25:40 +0100
Message-ID: <20100809112540.GC10793@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com> <1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com> <20100729123443.GA18923@n2100.arm.linux.org.uk> <AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com> <20100729142011.GG18923@n2100.arm.linux.org.uk> <20100805061453.GA7524@bnru02.bnr.st.com> <20100805092531.GA23473@n2100.arm.linux.org.uk> <20100809103704.GB5826@bnru01.bnr.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46088 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101Ab0HIL0G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 07:26:06 -0400
Content-Disposition: inline
In-Reply-To: <20100809103704.GB5826@bnru01.bnr.st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Colin Tuckley <colin.tuckley@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Aug 09, 2010 at 04:07:05PM +0530, Rabin VINCENT wrote:
> On Thu, Aug 05, 2010 at 11:25:31 +0200, Russell King - ARM Linux wrote:
> > On Thu, Aug 05, 2010 at 11:44:54AM +0530, Rabin VINCENT wrote:
> > > so are you OK with the cd_noinvert addition (for the GPIO case)?
> > > Or a cd_invert and a patch to existing platforms?
> > 
> > I'd much prefer positive logic.  Double negatives (eg, not noinverted)
> > are always bad news.
> 
> Here's the new patch.  I'll rebase the rest of the unapplied patches in
> the series on top of this.

This looks much better, thanks.
