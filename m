From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Wed, 18 May 2011 07:29:53 +0200
Message-ID: <BANLkTi=M+8nBZGzUOvEa67nb2LuTbQwx=Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40701 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1ERF3y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 01:29:54 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so1017278iyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2011 22:29:53 -0700 (PDT)
In-Reply-To: <5D8008F58939784290FAB48F54975198419F754247@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, David Strobach <lalochcz@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Greg KH <greg@kroah.com>, "horms@verge.net.au" <horms@verge.net.au>, "damm@opensource.se" <damm@opensource.se>, Andrei Warkentin <andreiw@motorola.com>

2011/5/17 Dong, Chuanxiao <chuanxiao.dong@intel.com>:

> mmc clock gating thread may be delayed for a long time in some scenarios.
> Since mmc_claim_host will be also used by other thread. I think this will
> possibly happen.

That shouldn't matter? host->lock will make sure the requests are
serialized will it not?

Linus Walleij
