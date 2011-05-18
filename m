From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Wed, 18 May 2011 14:01:47 +0800
Message-ID: <5D8008F58939784290FAB48F54975198419F75461E@shsmsx502.ccr.corp.intel.com>
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
	<5D8008F58939784290FAB48F54975198419F754247@shsmsx502.ccr.corp.intel.com>
 <BANLkTi=M+8nBZGzUOvEa67nb2LuTbQwx=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58630 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab1ERGBy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 02:01:54 -0400
In-Reply-To: <BANLkTi=M+8nBZGzUOvEa67nb2LuTbQwx=Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, David Strobach <lalochcz@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Greg KH <greg@kroah.com>, "horms@verge.net.au" <horms@verge.net.au>, "damm@opensource.se" <damm@opensource.se>, Andrei Warkentin <andreiw@motorola.com>



> -----Original Message-----
> From: linus.ml.walleij@gmail.com [mailto:linus.ml.walleij@gmail.com] On Behalf Of
> Linus Walleij
> Sent: Wednesday, May 18, 2011 1:30 PM
> To: Dong, Chuanxiao
> Cc: Guennadi Liakhovetski; Chris Ball; David Strobach; linux-mmc@vger.kernel.org;
> Greg KH; horms@verge.net.au; damm@opensource.se; Andrei Warkentin
> Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
> 
> 2011/5/17 Dong, Chuanxiao <chuanxiao.dong@intel.com>:
> 
> > mmc clock gating thread may be delayed for a long time in some scenarios.
> > Since mmc_claim_host will be also used by other thread. I think this will
> > possibly happen.
> 
> That shouldn't matter? host->lock will make sure the requests are
> serialized will it not?
If mmc clock gating thread is scheduled when calling mmc_claim_host, host->clock is unlocked. And maybe when it is scheduled back, host was already claimed by other thread. If it is possible happened, then host->clock cannot make this serialized.


> 
> Linus Walleij
