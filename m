From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] sh-mobile: enable both edges GPIO interrupts on sh7372
Date: Thu, 21 Jul 2011 16:54:32 +0900
Message-ID: <20110721075432.GE27831@linux-sh.org>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange> <Pine.LNX.4.64.1107151254300.22613@axis700.grange> <Pine.LNX.4.64.1107151256380.22613@axis700.grange> <CANqRtoRin_mSERnYn8Q-dYJHc0O-kwa3YtmjCRDsUU=yEfDMEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:44686 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235Ab1GUHyo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jul 2011 03:54:44 -0400
Content-Disposition: inline
In-Reply-To: <CANqRtoRin_mSERnYn8Q-dYJHc0O-kwa3YtmjCRDsUU=yEfDMEw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

On Fri, Jul 15, 2011 at 08:14:23PM +0900, Magnus Damm wrote:
> On Fri, Jul 15, 2011 at 7:58 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > From: Magnus Damm <damm@opensource.se>
> >
> > IRQ-capable GPIOs on sh7372 can be configured to produce interrupts on
> > both edges.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <damm@opensource.se>
> > ---
> > ?drivers/sh/intc/chip.c | ? ?3 +++
> > ?1 files changed, 3 insertions(+), 0 deletions(-)
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
