From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Fri, 15 May 2015 07:49:29 +0000
Message-ID: <1431676168.13197.18.camel@transmode.se>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
	 <1431673364.13197.10.camel@transmode.se>
	 <20150515073617.GO8870@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:53622 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080AbbEOHtd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 03:49:33 -0400
In-Reply-To: <20150515073617.GO8870@pek-khao-d1.corp.ad.wrs.com>
Content-Language: en-US
Content-ID: <61E189342CAA5E409DA7CAD8E9E5E843@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "haokexin@gmail.com" <haokexin@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, 2015-05-15 at 15:36 +0800, Kevin Hao wrote:
> On Fri, May 15, 2015 at 07:02:44AM +0000, Joakim Tjernlund wrote:
> > Reverting this seem a bit to much. Looking in the log it seems commit
> >  2317f56c055fcad524bf6a873df48a754e7ebc4d 
> > introduced the error by not checking for host->ops->set_bus_width before
> > calling it.
> > 
> > How does this work for you?
> 
> No. My sd card still don't work with this change.
> 
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c80287a..23603b2 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1528,7 +1528,10 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
> >         if (host->ops->platform_send_init_74_clocks)
> >                 host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> >  
> > -       host->ops->set_bus_width(host, ios->bus_width);
> > +       if (host->ops->set_bus_width)
> > +               host->ops->set_bus_width(host, ios->bus_width);
> > +       else
> > +               sdhci_set_bus_width(host, ios->bus_width);
> 
> The default sdhci_set_bus_width() doesn't apply to the esdhc controller on my
> board (p2020rdb). This controller is compatible with the sd host specification
> 2.0 and the implementation of sdhci_set_bus_width() can't set the bus width
> correctly for it.

But the controller is the same as for T1042 I presume? The bus width is in SDHCI_HOST_CONTROL
and the 8BIT is bit 29 in the register?

What bus width do you use and what is the failure?

 Jocke
 

