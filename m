From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Tue, 17 May 2011 17:20:58 +0800
Message-ID: <5D8008F58939784290FAB48F54975198419F754247@shsmsx502.ccr.corp.intel.com>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
	<Pine.LNX.4.64.1105161044260.4131@axis700.grange>
	<m3d3jik88n.fsf@pullcord.laptop.org>
	<BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com>
	<m38vu6k5b0.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1105161801100.28668@axis700.grange>
	<m34o4uk3f5.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1105161841420.28668@axis700.grange>
 <BANLkTiky5W=AW=TPe_rQ9QZw=6c5hjexag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56076 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab1EQJVE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2011 05:21:04 -0400
In-Reply-To: <BANLkTiky5W=AW=TPe_rQ9QZw=6c5hjexag@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Chris Ball <cjb@laptop.org>, David Strobach <lalochcz@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Greg KH <greg@kroah.com>, "horms@verge.net.au" <horms@verge.net.au>, "damm@opensource.se" <damm@opensource.se>, Andrei Warkentin <andreiw@motorola.com>

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Linus Walleij
> Sent: Tuesday, May 17, 2011 1:56 AM
> To: Guennadi Liakhovetski
> Cc: Chris Ball; David Strobach; linux-mmc@vger.kernel.org; Greg KH;
> horms@verge.net.au; damm@opensource.se; Andrei Warkentin
> Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
> 
> 2011/5/16 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> > On Mon, 16 May 2011, Chris Ball wrote:
> >> My intuition is that we should revert it now -- it's been a week since
> >> the final -rc, so you'd expect .39 to be released today, and we can
> >> always add your patch back into stable via .40-rc1 if it's not related
> >> to the crashes.
> >
> > Ok, let's revert it then. Just we have to not forget to work on this
> > problem and find a proper fix.
> 
> I'm still baffled by the whole thing, the solution seems so intuitively
> correct. :-(
> 
> Is there something strange in the semantics of mmc_claim_host()?
> 
mmc clock gating thread may be delayed for a long time in some scenarios. Since mmc_claim_host will be also used by other thread. I think this will possibly happen.
But not sure the system how to treat the long time delayed.
