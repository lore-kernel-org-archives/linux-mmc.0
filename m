From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Thu, 21 May 2015 11:45:49 +0000
Message-ID: <1432208749.6782.118.camel@transmode.se>
References: <1431673364.13197.10.camel@transmode.se>
	 <1431674695.13197.14.camel@transmode.se>
	 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
	 <1431693634.13197.29.camel@transmode.se>
	 <20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
	 <1431851766.6782.7.camel@transmode.se>
	 <20150519092014.GR26848@pek-khao-d1.corp.ad.wrs.com>
	 <1432133667.6782.81.camel@transmode.se>
	 <20150521010750.GU26848@pek-khao-d1.corp.ad.wrs.com>
	 <1432200282.6782.104.camel@transmode.se>
	 <20150521105613.GB26848@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:59362 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbbEULpw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2015 07:45:52 -0400
In-Reply-To: <20150521105613.GB26848@pek-khao-d1.corp.ad.wrs.com>
Content-Language: en-US
Content-ID: <218DA27E14F17B4B92B8DDEE3D271F77@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "haokexin@gmail.com" <haokexin@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, 2015-05-21 at 18:56 +0800, Kevin Hao wrote:
> On Thu, May 21, 2015 at 09:24:43AM +0000, Joakim Tjernlund wrote:
> > The HW 8BIT can be confused with SDHCI_CTRL_HISPD(0x04) as it is the same bit.
> > 
> > However, now I see that  esdhc_writeb() has
> >   /* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
> >         if (reg == SDHCI_HOST_CONTROL)
> >                 val &= ~ESDHC_HOST_CONTROL_RES;
> > and
> >    #define ESDHC_HOST_CONTROL_RES       0x05
> > 
> > so any esdhc_writeb() to SDHCI_HOST_CONTROL will clear the HW 8BIT.
> > What a mess.
> 
> Aha, I see. Thanks for the explanation.

There is also the common patten of
 val = esdhc_readb(..)
 val |= some bit
 esdhc_writeb(val)
This will also stomp on 8BIT

I cannot find a Maintainer, is there one?
This driver really needs a Freescale maintainer who can navigate
the subtile differences between Freescale SOCs

 Jocke
