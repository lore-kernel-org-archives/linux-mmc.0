From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC] mmc: add DT bindings for more MMC capability flags
Date: Thu, 07 Feb 2013 01:44:22 +0100
Message-ID: <1923973.xHEn0Jh3IU@wuerfel>
References: <Pine.LNX.4.64.1301231743190.26301@axis700.grange> <20130206151549.GA11609@e106331-lin.cambridge.arm.com> <Pine.LNX.4.64.1302061720390.13474@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49343 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab3BFQue (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 11:50:34 -0500
In-Reply-To: <Pine.LNX.4.64.1302061720390.13474@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Wednesday 06 February 2013 17:25:42 Guennadi Liakhovetski wrote:
> 
> Thank for pointing me out at that thread. However, I don't think 
> MMC_CAP_POWER_OFF_CARD has anything to do with compatibility or hardware 
> revisions. At least I haven't yet come across any sd/mmc hosts, that also 
> supply card power. You could "derive" this flag from the presence of a 
> regulator, capable of changing its status (switching on / off), but even 
> then you're not guaranteed, that you actually can (and want to) power the 
> card off at run-time - the regulator can be shared etc. So, an explicit 
> flag is needed.

It sounds like something that should be handled in a controller specific
way I think. E.g. on SDHCI, there seems to always be a method to power
down the card using the SDHCI_POWER_CONTROL register, even without
any external regulators.

	Arnd
