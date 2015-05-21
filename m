From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Thu, 21 May 2015 09:24:43 +0000
Message-ID: <1432200282.6782.104.camel@transmode.se>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
	 <1431673364.13197.10.camel@transmode.se>
	 <1431674695.13197.14.camel@transmode.se>
	 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
	 <1431693634.13197.29.camel@transmode.se>
	 <20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
	 <1431851766.6782.7.camel@transmode.se>
	 <20150519092014.GR26848@pek-khao-d1.corp.ad.wrs.com>
	 <1432133667.6782.81.camel@transmode.se>
	 <20150521010750.GU26848@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:60522 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbbEUJYr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2015 05:24:47 -0400
In-Reply-To: <20150521010750.GU26848@pek-khao-d1.corp.ad.wrs.com>
Content-Language: en-US
Content-ID: <B015C32658C4264BBF5E97B5D6C5CCD7@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "haokexin@gmail.com" <haokexin@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, 2015-05-21 at 09:07 +0800, Kevin Hao wrote:
> On Wed, May 20, 2015 at 02:54:27PM +0000, Joakim Tjernlund wrote:
> > On Tue, 2015-05-19 at 17:20 +0800, Kevin Hao wrote:
> > > On Sun, May 17, 2015 at 08:36:07AM +0000, Joakim Tjernlund wrote:
> > > > On Sun, 2015-05-17 at 13:06 +0800, Kevin Hao wrote:
> > > > > > 
> > > > > > How about this one:
> > > > > > 
> > > > > > From af6b18c056b6064424bd2ab1f9989bbadae5e701 Mon Sep 17 00:00:00 2001
> > > > > > From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> > > > > > Date: Mon, 20 Apr 2015 22:36:55 +0200
> > > > > > Subject: [PATCHv3] sdhci-of-esdhc: Support 8BIT bus width.
> > > > > > 
> > > > > > esdhc_readb()/esdhc_writeb() did not adjust for 8BIT.
> > > > > 
> > > > > Do we really need this for the 8bit bus support? There is already a specific
> > > > > API for setting the bus width, this change seems unnecessary to me. That is
> > > > > also why I choose to revert that patch. Did I miss something?
> > > > 
> > > > We do, the bus API really only works well when the bus bits are in another 
> > > > register but the HOST_CONTROL register.
> > > 
> > > Sorry, I didn't get what you mean. Could you elaborate a bit more?
> >   clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
> >                         ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
> > and 
> >   esdhc_writeb(struct sdhci_host *host, int reg) with reg ==  SDHCI_HOST_CONTROL
> > is the same register so esdhc_writeb() will stomp on the settings esdhc_pltfm_set_bus_width()
> > did earlier.
> 
> The .set_bus_width() is the only API we use to set the bus width. We never do
> something like this:
>       esdhc_writeb(host, SDHCI_CTRL_8BITBUS, SDHCI_HOST_CONTROL);

ATM, you might at some point.

> 
> So the scenario you mentioned above should not happen. That is also why I think
> your changes is not necessary.

The HW 8BIT can be confused with SDHCI_CTRL_HISPD(0x04) as it is the same bit.

However, now I see that  esdhc_writeb() has
  /* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
        if (reg == SDHCI_HOST_CONTROL)
                val &= ~ESDHC_HOST_CONTROL_RES;
and
   #define ESDHC_HOST_CONTROL_RES       0x05

so any esdhc_writeb() to SDHCI_HOST_CONTROL will clear the HW 8BIT.
What a mess.

> 
> > 
> > > 
> > > > The only reason 4BIT works is because its bit placement is where 
> > > > SDHCI expects it to be. 8BIT is not, so unless readb/writeb funktions compensate
> > > > for that they will overwrite what the bus API set earlier.
> > > 
> > > But the implementation of esdhc_pltfm_set_bus_width() already take care about
> > > this. And in the current kernel, we only set the bus width via this API. So why
> > > do you think that it can be overwrote?
> > > 
> > > static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
> > > {
> > >       u32 ctrl;
> > > 
> > >       switch (width) {
> > >       case MMC_BUS_WIDTH_8:
> > >               ctrl = ESDHC_CTRL_8BITBUS;
> > >               break;
> > > 
> > >       case MMC_BUS_WIDTH_4:
> > >               ctrl = ESDHC_CTRL_4BITBUS;
> > >               break;
> > > 
> > >       default:
> > >               ctrl = 0;
> > >               break;
> > >       }
> > > 
> > >       clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
> > >                       ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
> > > }
> > > 
> > > > 
> > > > Atleast this is my understanding, Ulf?
> > > > 
> > > > Didn't this patch work for you either?
> > > 
> > > I don't have a 8bit card at hand. For 4bit card, it works with or without this
> > > change.
> > 
> > Sure it does, that was not the question though:
> > Does it still work with this version of the patch?
> 
> I think I already answered your question. For 4bit card, it works with or
> without this version of patch.

Ahh, I misread. Sorry for the confusion.

 Jocke
