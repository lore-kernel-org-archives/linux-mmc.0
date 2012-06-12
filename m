From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Tue, 12 Jun 2012 23:28:22 +0200
Message-ID: <3019432.q0GM0tRQD3@avalon>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com> <Pine.LNX.4.64.1206121517590.6800@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33850 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab2FLV2R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 17:28:17 -0400
In-Reply-To: <Pine.LNX.4.64.1206121517590.6800@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Guennadi,

On Tuesday 12 June 2012 15:31:49 Guennadi Liakhovetski wrote:
> On Tue, 12 Jun 2012, Laurent Pinchart wrote:
> > The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> > width. When the MMC controller gets powered off, runtime PM switches the
> > MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT register afterwards
> > fails and prints an error message to the kernel log.
> > 
> > As configuring the bus width is pointless when the interface gets
> > powered down, skip the operation when power is off.
> 
> The patch looks good - thanks! But maybe we can make the commit message a
> bit more precise. I think, ios->power_mode refers to powering the card
> down and up, not the controller. We use this information to also try to
> put the controller in a power-saving mode. Depending on the kernel and
> board configuration this can be a NOP, it can switch the MSTP clock off,
> as you correctly notice, or it can power the whole PM domain, to which the
> controller belongs, down. So, maybe something like this would be better:
> 
> The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> width. When the mmc core requests the driver to power off the card, we
> inform runtime PM, that the controller can be suspended. This can lead to
> the MSTP clock being turned off. Writing to to CTL_SD_MEM_CARD_OPT
> register afterwards fails and prints an error message to the kernel log.
> 
> As conf... (continue as above)
> 
> Feel free to further improve the above :)

Thank you for the feedback. I'll send a v2 that incorporates a second related 
fix.

-- 
Regards,

Laurent Pinchart

