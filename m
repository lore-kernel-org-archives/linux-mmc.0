From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 09/10] ARM: dts: omap3: add pbias and mmc_init
 pinctrl states
Date: Wed, 12 Jun 2013 10:50:05 -0700
Message-ID: <20130612175005.GR8164@atomide.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-10-git-send-email-balajitk@ti.com>
 <20130612143548.GZ8164@atomide.com>
 <51B8B35E.20307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24841 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755788Ab3FLRuH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 13:50:07 -0400
Content-Disposition: inline
In-Reply-To: <51B8B35E.20307@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org

* Balaji T K <balajitk@ti.com> [130612 10:50]:
> On Wednesday 12 June 2013 08:05 PM, Tony Lindgren wrote:
> >* Balaji T K <balajitk@ti.com> [130606 12:20]:
> >>add pbias states for pbias 0, 1.8V, 3V
> >>add omap3 sd/mmc2 loop back clock config for devconf1 in mmc2_init pinctrl state
> >>add OMAP3430 sd/mmc1 loop back clock config for devconf0 in mmc1_init pinctrl state
> >>add OMAP3630 sd/mmc1 speed mode config for prog_io1 in mmc1_init pinctrl state
> >
> >Looks OK to me, except these should be under mmc1 for omap[345].dtsi files.
> >
> 
> I think I can move &omap3_pmx_general to omap3.dtsi and override
> &pbias_1v8, &pbias_3v in omap36xx.dtsi, but I doubt pinctrl-[0,1,2,3,4]
> since pull up setting can vary between boards.

OK makes sense to me if it's board specific.

Regards,

Tony
