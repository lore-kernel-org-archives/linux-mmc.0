From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: mxs: fix card detection function for broken card
 detect
Date: Mon, 28 Apr 2014 11:36:19 +0200
Message-ID: <20140428093619.GP5858@pengutronix.de>
References: <dec3cef26b7470cabfc11a83750a88db5b545a41.1397944151.git.daniel@totalueberwachung.de>
 <20140428091341.GA5918@pengutronix.de>
 <CAPDyKFqP_cDTyC38+8XDPLWN0C6wWs9e6iZD06nkb_LqqLjjnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39144 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbaD1JgV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 05:36:21 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqP_cDTyC38+8XDPLWN0C6wWs9e6iZD06nkb_LqqLjjnw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Willmann <daniel@totalueberwachung.de>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>

On Mon, Apr 28, 2014 at 11:31:03AM +0200, Ulf Hansson wrote:
> On 28 April 2014 11:13, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Sat, Apr 19, 2014 at 11:59:18PM +0200, Daniel Willmann wrote:
> >> Return -ENOSYS in get_cd if broken-cd is specified in the device tree.
> >>
> >> Commit a91fe279ae75 (mmc: mxs: use standard flag for broken card
> >> detection) sets MMC_CAP_NEEDS_POLL when broken-cd is specified. This
> >> driver sets this flag unconditionally as it does not support a card
> >> detect interrupt. Instead, broken-cd means that there is no card detect
> >> signal connected.
> >>
> >> The mmc core checks the get_cd function return value to determine if a
> >> card is present. Only for a non-zero return value it will attempt to
> >> initialize the card. So retuning -ENOSYS will allow the card to be
> >> initialized.
> >> For comparison, mmc_gpio_get_cd in slot-gpio.c also returns -ENOSYS if
> >> the card detect GPIO is not valid.
> >
> > Short answer for fixing this regression:
> >
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > Long answer:
> >
> > This is broken in the MMC OF parser. When the parser finds the
> > 'broken-cd' property it just sets the MMC_CAP_NEEDS_POLL flag. This is
> > wrong.  broken-cd means that we cannot rely on any card detection, but
> > instead have to talk to the card to find out if it's available.
> > Currently there is no flag to signal this situation, so the host driver
> > has to handle this by returning true in the get_cd callback, just like
> > the patch below does.
> >
> > IMO the correct solution would be to add a MMC_CAP_CD_NEEDS_TALK_TO_CARD
> > flag to the core.
> >
> 
> So if I understand correct, you want the host-ops->get_cd function to
> be invoked from the mmc rescan - only when it actually can provide
> useful information?

Yes.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
