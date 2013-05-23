From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/13] mmc: omap_hsmmc: add dt pbias and control mmc
 support
Date: Thu, 23 May 2013 11:40:45 -0700
Message-ID: <20130523184045.GD13507@atomide.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
 <1367330633-5941-7-git-send-email-balajitk@ti.com>
 <20130516161650.GW5600@atomide.com>
 <519E3EC3.1040309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20482 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248Ab3EWSks (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2013 14:40:48 -0400
Content-Disposition: inline
In-Reply-To: <519E3EC3.1040309@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com

* Balaji T K <balajitk@ti.com> [130523 09:13]:
> On Thursday 16 May 2013 09:46 PM, Tony Lindgren wrote:
> >
> >These before and after functions should be first converted to just usual
> >regulator_set_voltage() eventually. In the PBIAS case it's really a mux
> >plus a comparator, but we can set it up as a regulator. And on some boards
> >it can be an external regulator like we have the legacy callbacks for in
> >mach-omap2/hsmmc.c.
> 
> Agree these .before, .after functions are for dual volt pbias i/o cell programming
> based on regulator voltage, but modeling pbias register programming via
> regulator might be overdo

Probably not as then you don't need to export any custom functions
from the pbias code. 

> >This all we can simplify quite a bit by defining the PBIAS register
> >as pinctrl-single,bits with two different named modes. One for
> >1.8V and for 3.3V. This way the PBIAS register is abstracted for
> >various omaps in the .dts file as the register is different.
> >
> 
> Sometimes pbias register (like in omap3) has bits fields other than mmc1 pbias bits,
> in which case it will be difficult to abstract via pinctrl-single
> with mask bits for non-mmc1 pbias bits.

Yes exactly, that's what you can totally define with pinconf-single,bits
in omap3.dtsi and omap4.dtsi files. Then from the pbias handling regulator
code you just request named pinctrl states which are now the same
from pbias driver point of view.

Regards,

Tony
