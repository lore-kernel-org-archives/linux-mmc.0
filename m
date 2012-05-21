From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Add wp-inverted property
Date: Mon, 21 May 2012 05:49:00 +0200
Message-ID: <201205210549.00300.marex@denx.de>
References: <1337571366-7779-1-git-send-email-marex@denx.de> <87396ukxiz.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:42183 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2EUDtI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 May 2012 23:49:08 -0400
In-Reply-To: <87396ukxiz.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-mmc@vger.kernel.org

Dear Chris Ball,

> Hi Marek,
> 
> On Sun, May 20 2012, Marek Vasut wrote:
> > The write-protect GPIO is inverted on some boards. Handle such case.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: Chris Ball <cjb@laptop.org>
> > ---
> > 
> >  Documentation/devicetree/bindings/mmc/mxs-mmc.txt |    1 +
> >  drivers/mmc/host/mxs-mmc.c                        |   11 ++++++++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > V2: Adjust the subject, Cc linux-mmc
> 
> Thanks, looks good.  Since this depends on patches that are going via
> arm-soc, I'm going to wait until that's in Linus master before merging.

Roger that, thanks!

> 
> - Chris.

Best regards,
Marek Vasut
